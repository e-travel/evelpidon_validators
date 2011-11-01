require 'test_helper'
require 'evelpidon_validators/different'

class DifferentValidatorTest < ActiveSupport::TestCase

  class ModelWithDifferentValidation
    include ActiveModel::Validations
    attr_accessor :attr1, :attr2
    validates :attr1, :different => { :than => :attr2 }
  end

  setup do
    @model = ModelWithDifferentValidation.new
  end

  test "different integers" do
    @model.attr2 = 2
    assert_valid_attr1 1
    assert_valid_attr1 3
    assert_invalid_attr1 2
  end

  test "different dates" do
    today = Date.today
    @model.attr2 = today
    assert_valid_attr1 today - 1
    assert_valid_attr1 today + 1
    assert_invalid_attr1 today
  end

  test "different strings" do
    @model.attr2 = 'a string'
    assert_valid_attr1 'another string'
    assert_valid_attr1 'a third string'
    assert_invalid_attr1 'a string'
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
