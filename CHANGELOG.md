# Evelpidon Validators changelog

## 0.5.1 / 2013-08-29

* CreditCardValidator with `:luhn_only` true accepts nil values.

## 0.5.0 / 2013-08-29

* CreditCardValidator learned the option of `:luhn_only` bypassing the actual cc type check.
  Includes pure JS implementation.

## 0.4.4 / 2013-06-18

* Test numbers are considered valid in all Rails environments except production.
* Internal gem configuration changes.

## 0.4.3 / 2012-01-16

* Fixed bug with validation raising an error if number is nil.
* Fixed Credit Card Validator type_attribute option is optional.

## 0.4.2 / 2012-01-16

* Fixed type deprecation warning added in the wrong place

## 0.4.1 / 2012-01-16

* Renamed credit card validator type option to type_attribute (type is deprecated)
* Type is optional for a credit card validation

## 0.4.0 / 2012-01-13

* Fix for nested forms and sibling finding
* Added CreditCardValidator

## 0.3.0 / 2011-12-29

* Added AssociationValidator
* Fix for `than` validation options finding only input siblings
* README updates (+ StillMaintained and Travis-CI)

## 0.2.0 / 2011-11-07

* or_equal option to greater and less validators
* Missing rake development dependency

## 0.1.0 / 2011-11-01

* Birthday with support for the following validations :
  * Different (than)
  * Greater (than)
  * Less (than)
