ClientSideValidations.validators.remote['greater'] = function(element, options) {
    if ($.ajax({
        url: '/validators/greater',
        data: { value: element.val(), than: ClientSideValidations.helpers.getSiblingField(element, options.than).val() },
        async: false
    }).status == 404) { return options.message; }
};
