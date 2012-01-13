require 'test_helper'
require 'evelpidon_validators/credit_card'

class CreditCardValidatorTest < ActiveSupport::TestCase

  class Payment
    include ActiveModel::Validations
    attr_accessor :card_type, :card_number
    validates :card_number, :credit_card => { :type => :card_type }
  end

  setup do
    CreditCardValidator::Validator.options[:test_numbers_are_valid] = true
    @payment = Payment.new
  end

  test "visa cards" do
    assert_valid_card_type_and_number 'Visa', '4111111111111111'
    assert_valid_card_type_and_number 'visa', '4111111111111111'

    assert_invalid_card_type_and_number 'MasterCard', '4111111111111111'
    assert_invalid_card_type_and_number 'DinersClub', '4111111111111111'
    assert_invalid_card_type_and_number 'Amex', '4111111111111111'
    assert_invalid_card_type_and_number 'Discover', '4111111111111111'
    assert_invalid_card_type_and_number 'Maestro', '4111111111111111'
  end

  test "master card cards" do
    assert_valid_card_type_and_number 'MasterCard', '5555555555554444'
    assert_valid_card_type_and_number 'master_card', '5555555555554444'

    assert_invalid_card_type_and_number 'Visa', '5555555555554444'
    assert_invalid_card_type_and_number 'DinersClub', '5555555555554444'
    assert_invalid_card_type_and_number 'Amex', '5555555555554444'
    assert_invalid_card_type_and_number 'Discover', '5555555555554444'
    assert_invalid_card_type_and_number 'Maestro', '5555555555554444'
  end

  test "diners club cards" do
    assert_valid_card_type_and_number 'DinersClub', '30569309025904'
    assert_valid_card_type_and_number 'diners_club', '30569309025904'

    assert_invalid_card_type_and_number 'Visa', '30569309025904'
    assert_invalid_card_type_and_number 'MasterCard', '30569309025904'
    assert_invalid_card_type_and_number 'Amex', '30569309025904'
    assert_invalid_card_type_and_number 'Discover', '30569309025904'
    assert_invalid_card_type_and_number 'Maestro', '30569309025904'
  end

  test "amex cards" do
    assert_valid_card_type_and_number 'Amex', '371449635398431'
    assert_valid_card_type_and_number 'amex', '371449635398431'

    assert_invalid_card_type_and_number 'Visa', '371449635398431'
    assert_invalid_card_type_and_number 'MasterCard', '371449635398431'
    assert_invalid_card_type_and_number 'DinersClub', '371449635398431'
    assert_invalid_card_type_and_number 'Discover', '371449635398431'
    assert_invalid_card_type_and_number 'Maestro', '371449635398431'
  end

  test "discover cards" do
    assert_valid_card_type_and_number 'Discover', '6011000990139424'
    assert_valid_card_type_and_number 'discover', '6011000990139424'

    assert_invalid_card_type_and_number 'Visa', '6011000990139424'
    assert_invalid_card_type_and_number 'MasterCard', '6011000990139424'
    assert_invalid_card_type_and_number 'DinersClub', '6011000990139424'
    assert_invalid_card_type_and_number 'Amex', '6011000990139424'
    assert_invalid_card_type_and_number 'Maestro', '6011000990139424'
  end

  test "maestro cards" do
    assert_valid_card_type_and_number 'Maestro', '6759671431256542'
    assert_valid_card_type_and_number 'maestro', '6759671431256542'

    assert_invalid_card_type_and_number 'Visa', '6759671431256542'
    assert_invalid_card_type_and_number 'MasterCard', '6759671431256542'
    assert_invalid_card_type_and_number 'DinersClub', '6759671431256542'
    assert_invalid_card_type_and_number 'Discover', '6759671431256542'
    assert_invalid_card_type_and_number 'Discover', '6759671431256542'
  end

  #########
  protected
  #########

  def assert_valid_card_type_and_number(type, number)
    @payment.card_type = type
    @payment.card_number = number
    assert_valid_attribute @payment, :card_number
  end

  def assert_invalid_card_type_and_number(type, number)
    @payment.card_type = type
    @payment.card_number = number
    assert_invalid_attribute @payment, :card_number
  end
end
