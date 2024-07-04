file = 'index-func.php';
$(document).ready(function () {
    setDocTitle("Login");
});

async function signin(btn) {
    bool = true;
    un = $('#username');
    pw = $('#password');
    let elem = $();
    if (un.val() === "") {
        bool = false;
        elem = elem.add(un);
    }
    if (pw.val() === "") {
        bool = false;
        elem = elem.add(pw);
    }
    if (bool) {
        var signin = new FormData();
        signin.append('username', un.val());
        signin.append('password', pw.val());
        signin.append('signin', '');
        var res = await myajax(file, signin);
        if (res === "success") {
            ttimer('Successfully login!<br>Redirecting to dashboard!', 2);
            setTimeout(() => {
                window.location = "dashboard/";
            }, 3000);
        } else {
            twarning('Username and password not found!', 3);
        }
    } else {
        reqfunctwtoast(elem, 'Please input username and password', 3);
    }
}