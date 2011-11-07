require 'test_helper'
require 'evelpidon_validators/greater'

class GreaterValidatorTest < ActiveSupport::TestCase

  class ModelWithGreaterValidation
    include ActiveModel::Validations
    attr_accessor :attr1, :attr2, :attr3
    validates :attr1, :greater => { :than => :attr2 }
    validates :attr3, :greater => { :than => :attr2, :or_equal => true }
  end

  setup do
    @model = ModelWithGreaterValidation.new
  end

  test "greater integer" do
    @model.attr2 = 2
    assert_valid_attr1 3
    assert_valid_attr1 4
    assert_invalid_attr1 1
  end

  test "greater date" do
    today = Date.today
    @model.attr2 = today
    assert_valid_attr1 today + 1
    assert_valid_attr1 today + 2
    assert_invalid_attr1 today - 1
  end

  test "greater string" do
    @model.attr2 = 'c'
    assert_valid_attr1 'd'
    assert_valid_attr1 'e'
    assert_invalid_attr1 'b'
  end

  test "equal integer is not valid" do
    @model.attr2 = 2
    assert_invalid_attr1 2
  end

  test "greater date is not valid" do
    today = Date.today
    @model.attr2 = today
    assert_invalid_attr1 today
  end

  test "greater string is not valid" do
    @model.attr2 = 'c'
    assert_invalid_attr1 'c'
  end

  test "equal integer is valid if is_equal is true" do
    @model.attr2 = 2
    assert_valid_attr3 2
  end

  test "greater date is valid if is_equal is true" do
    today = Date.today
    @model.attr2 = today
    assert_valid_attr3 today
  end

  test "greater string is valid if is_equal is true" do
    @model.attr2 = 'c'
    assert_valid_attr3 'c'
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

  def assert_valid_attr3(value)
    @model.attr3 = value
    assert_valid_attribute(@model, :attr3)
  end

  def assert_invalid_attr3(value)
    @model.attr3 = value
    assert_invalid_attribute @model, :attr3
  end
end
