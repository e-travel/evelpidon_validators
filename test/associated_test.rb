require 'test_helper'
require 'evelpidon_validators/associated'

# Tests inspired by:
# https://github.com/rails/rails/blob/v3.1.1/activerecord/test/cases/validations/association_validation_test.rb
class AssociatedValidatorTest < ActiveSupport::TestCase

  class Topic
    include ActiveModel::Validations
    attr_accessor :title, :content, :replies

    def initialize(params = {})
      self.title = params['title']
      self.content = params['content']
      self.replies = params['replies']
    end
  end

  class Reply
    include ActiveModel::Validations
    attr_accessor :title, :content, :topic

    def initialize(params = {})
      self.title = params['title']
      self.content = params['content']
      self.topic = params['topic']
    end
  end

  def test_validates_associated_many
    Topic.validates :replies, :associated => true
    Reply.validates :content, :presence => true
    t = Topic.new("title" => "uhohuhoh", "content" => "whatever")
    t.replies = [r = Reply.new("title" => "A reply"), r2 = Reply.new("title" => "Another reply", "content" => "non-empty"), r3 = Reply.new("title" => "Yet another reply"), r4 = Reply.new("title" => "The last reply", "content" => "non-empty")]
    assert !t.valid?
    assert t.errors[:replies].any?
    assert_equal 1, r.errors.count  # make sure all associated objects have been validated
    assert_equal 0, r2.errors.count
    assert_equal 1, r3.errors.count
    assert_equal 0, r4.errors.count
    r.content = r3.content = "non-empty"
    assert t.valid?
  end

  def test_validates_associated_one
    Reply.validates :topic, :associated => true
    Topic.validates :content, :presence => true
    r = Reply.new("title" => "A reply", "content" => "with content!")
    r.topic = Topic.new("title" => "uhohuhoh")
    assert !r.valid?
    assert r.errors[:topic].any?
    r.topic.content = "non-empty"
    assert r.valid?
  end
end
