window.onload = function() {
    document.getElementById('feedback').onsubmit = function(event) {
        var phoneInput = document.getElementById('phone');
        var phoneRegex = /^\+\d\(\d{3}\)\d{3}-\d{2}-\d{2}$/;
        if (!phoneRegex.test(phoneInput.value)) {
            alert('Пожалуйста, введите корректный номер телефона: +X(XXX)XXX-XX-XX');
            event.preventDefault();
            return;
        }

        var emailInput = document.getElementById('email');
        if (emailInput.value.trim() !== '' && !isValidEmail(emailInput.value)) {
            alert('Введите корректный адрес электронной почты');
            event.preventDefault();
            return;
        }
    };

    function isValidPhoneNumber(phoneNumber) {
        return phoneNumber.length === 11;
    }

    function isValidEmail(email) {
        return email === '' || /\S+@\S+\.\S+/.test(email);
    }
};