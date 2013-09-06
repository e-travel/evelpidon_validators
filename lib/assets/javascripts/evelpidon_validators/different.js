ClientSideValidations.validators.remote['different'] = function(element, options) {
    if ($.ajax({
        url: '/validators/different',
        data: { value: element.val(), than: ClientSideValidations.helpers.getSiblingField(element, options.than).val() },
        async: false
    }).status == 404) { return options.message; }
};
