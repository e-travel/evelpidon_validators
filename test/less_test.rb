require 'test_helper'
require 'evelpidon_validators/less'

class LessValidatorTest < ActiveSupport::TestCase

  class ModelWithLessValidation
    include ActiveModel::Validations
    attr_accessor :attr1, :attr2
    validates :attr1, :less => { :than => :attr2 }
  end

  setup do
    @model = ModelWithLessValidation.new
  end

  test "less integer" do
    @model.attr2 = 2
    assert_valid_attr1 0
    assert_valid_attr1 1
    assert_invalid_attr1 2
    assert_invalid_attr1 3
  end

  test "less date" do
    today = Date.today
    @model.attr2 = today
    assert_valid_attr1 today - 2
    assert_valid_attr1 today - 1
    assert_invalid_attr1 today
    assert_invalid_attr1 today + 1
  end

  test "less string" do
    @model.attr2 = 'c'
    assert_valid_attr1 'a'
    assert_valid_attr1 'b'
    assert_invalid_attr1 'c'
    assert_invalid_attr1 'd'
  end

  #########
  protected
  #########

  def assert_valid_attr1(value)
    @model.attr1 = value
    assert_valid_attribute(@model, :attr1)
  end

  def assert_invalid_attr1(value)
    @model.attr1 = value
    assert_invalid_attribute @model, :attr1
  end
end
