//= require_self
//= require_tree ./evelpidon_validators

ClientSideValidations.helpers = ClientSideValidations.helpers || {};

ClientSideValidations.helpers.getSiblingField = function(field, siblingName) {
    var thanName = field.attr('name').replace(/\[[^\]]*\]$/, '[' + siblingName + ']');
    return field.parents('form').find("[name='" + thanName + "']");
};
