file = 'func.php';
$(document).ready(function () {
    settb();
    $('.refresh-tb').click(function (e) {
        // setpages();
        settb();
    });
});

async function setnewuser(btn) {
    var fd = new FormData();
    fd.append('setnewuser', '');
    var res = await myajax(file, fd);
    modallg(`Add new user`, res);
    $('#btn_submit').html(`<button type="button" class="btn btn-success btn-sm" ckid="1" onclick="saveuser(this)">Add user</button>`);
}

async function viewdata(btn) {
    ckid = $(btn).attr('did');
    var fd = new FormData();
    fd.append('viewdata', '');
    fd.append('did', ckid);
    var res = await myajax(file, fd);
    modallg(`Username: ${$(btn).closest('tr').find('td:eq(1)').text()} - Account Details`, res);
    $('#modaltb').DataTable();
    // $('#btn_submit').html(`<button type="button" class="btn btn-warning btn-sm" ckid="1" onclick="editdetails(this)">Edit Details</button>`);
}

async function settb() {
    var tb = $('#maintb');
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('settb', '');
    var res = await myajax(file, formdata); // Ensure 'file' is the correct endpoint

    var parsedRes = JSON.parse(res);

    setdatatb(parsedRes, tb);
}
