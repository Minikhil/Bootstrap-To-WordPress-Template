function formValidation() {

    var dname = document.inputForm.dname,
        name = document.inputForm.name,
        phone = document.inputForm.phone,
        email = document.inputForm.email;

    if (dname.value == "") {
        alert("Please Enter SBI Division Name");
        dname.focus();
        return false;
    } else {
        sbidivision.style.backgroundColor = "#FFFFFF";
    }

    if (name.value == "") {
        alert("Please enter your name");
        name.focus();
        return false;
    } else {
        name.style.backgroundColor = "#FFFFFF";
    }

    if (phone.value == "" || isNaN(phone.value) || phone.value.length != 10) {
        alert("Please provide a 10 digit number.");
        phone.focus();
        return false;
    } else {
        phone.style.backgroundColor = "#FFFFFF";
    }

    if (email.value == null || email.value == "") {
        alert("Not a valid e-mail address");
        email.focus();
        email.style.backgroundColor = "Red";
        return false;
    } else {
        var atpos = email.value.indexOf("@");
        var dotpos = email.value.lastIndexOf(".");
        if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {
            alert("Not a valid e-mail address");
            email.focus();
            email.style.backgroundColor = "Red";
            return false;
        }
    }
    return true;
}
