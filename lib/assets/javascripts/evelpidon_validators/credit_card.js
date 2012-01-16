clientSideValidations.validators.remote['credit_card'] = function(element, options) {
    if ($.ajax({
        url: '/validators/credit_card.json',
        data: { value: element.val(), type: clientSideValidations.helpers.getSiblingField(element, options.type_attribute).val() },
        async: false
    }).status == 404) { return options.message; }
};
