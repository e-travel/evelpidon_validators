// Define the trim function if it's not already defined.
// See http://stackoverflow.com/a/1418059 for more info
if (typeof(String.prototype.trim) === "undefined") {
    String.prototype.trim = function () {
        return String(this).replace(/^\s+|\s+$/g, '');
    };
}

ClientSideValidations.validators.remote['different'] = function (element, options) {
    var value = element.val(),
        otherValue = ClientSideValidations.helpers.getSiblingField(element, options.than).val();
    if (value.trim() == otherValue.trim()) {
        return options.message;
    }
};
