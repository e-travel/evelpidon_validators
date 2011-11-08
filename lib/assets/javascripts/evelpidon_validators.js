//= require_self
//= require_tree ./evelpidon_validators

clientSideValidations.helpers = clientSideValidations.helpers || {};

clientSideValidations.helpers.getSiblingField = function(field, siblingName) {
    var thanName = field.attr('name').replace(/\[[^\]]*\]/, '[' + siblingName + ']');
    return field.parents('form').find("[name='" + thanName + "']");
};
