$(document).ready(function() {
    // all custom jQuery to validate a single form specified goes here here
    /*
        all fields including name and address are required
        phone: use phoneUS in additional-methods to check this
        email: use email to check this
        credit card number: use creditcard to check this
        expiration date: do not check this on the client side
     */

    $("#checkoutForm").validate({
        rules: {
            name: {
                required: true,
                normalizer: function(value) {
                    //https://github.com/jquery-validation/jquery-validation/issues/1886
                    // Note: the value of `this` inside the `normalizer` is the corresponding
                    // DOMElement. In this example, `this` reference the `username` element.
                    // Trim the value of the input
                    return $.trim(value);
                },
                minlength: 2,
            },
            address: {
                required: true,
                normalizer: function(value) {
                    //https://github.com/jquery-validation/jquery-validation/issues/1886
                    // Note: the value of `this` inside the `normalizer` is the corresponding
                    // DOMElement. In this example, `this` reference the `username` element.
                    // Trim the value of the input
                    return $.trim(value);
                },
                minlength: 2
            },
            phone: {
                required: true,
                phoneUS: true
            },
            email: {
                required: true,
                email: true
            },
            ccNumber: {
                required: true,
                creditcard: true
            }
        },
        messages: {
            name: {
                required: "Name is required",
                minlength: "Minimum length is two characters"
            },
            address: {
                required: "Address is required",
                minlength: "Minimum length is two characters"
            },
            phone: {
                required: "Phone number is required",
                phoneUS: "A valid US phone number is required"
            },
            email: {
                required: "Email is required",
                email: "A valid email is required"
            },
            ccNumber: {
                required: "A credit card number is required",
                creditcard: "A valid credit card number is required"
            }
        }
    });
});