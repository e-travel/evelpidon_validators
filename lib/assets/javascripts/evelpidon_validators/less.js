clientSideValidations.validators.remote['less'] = function(element, options) {
    if ($.ajax({
        url: '/validators/less.json',
        data: { value: element.val(), than: clientSideValidations.helpers.getSiblingField(element, options.than).val() },
        async: false
    }).status == 404) { return options.message; }
};
