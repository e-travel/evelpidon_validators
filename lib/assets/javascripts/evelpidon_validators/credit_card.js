clientSideValidations.helpers = clientSideValidations.helpers || {};

/**
 * Variant of Avraham Plotnitzky's String.prototype method mixed with the "fast" version
 * see: https://sites.google.com/site/abapexamples/javascript/luhn-validation.
 *
 * Taken from https://gist.github.com/ShirtlessKirk/2134376
 *
 * @param luhn {Integer}
 * @returns {boolean}
 */
clientSideValidations.helpers.luhnChk = function(luhn) {
    var len = luhn.length,
        mul = 0,
        prodArr = [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9], [0, 2, 4, 6, 8, 1, 3, 5, 7, 9]],
        sum = 0;

    while (len--) {
        sum += prodArr[mul][parseInt(luhn.charAt(len), 10)];
        mul ^= 1;
    }

    return sum % 10 === 0 && sum > 0;
};

clientSideValidations.validators.remote['credit_card'] = function(element, options) {
    if (options.luhn_only) {
        if (clientSideValidations.helpers.luhnChk(element.val()) == false) {
            return options.message;
        }
    } else {
        if ($.ajax({
            url: '/validators/credit_card.json',
            data: { value: element.val(), type: clientSideValidations.helpers.getSiblingField(element, options.type_attribute).val()},
            async: false
        }).status == 404) { return options.message; }
    }
};
