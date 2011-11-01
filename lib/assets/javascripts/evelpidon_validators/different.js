clientSideValidations.validators.remote['different'] = function(element, options) {
    if ($.ajax({
        url: '/validators/different.json',
        data: { value: element.val(), than: clientSideValidations.helpers.getSiblingField(element, options.than).val() },
        async: false
    }).status == 404) { return options.message; }
};
