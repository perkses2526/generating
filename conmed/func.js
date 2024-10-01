file = 'func.php';
$(document).ready(function () {
    settb();
    $('.refresh-tb').click(function (e) {
        // setpages();
        settb();
    });
});

async function viewpendings(btn) {
    uid = $(btn).closest('tr').find('td:eq(0)').text();
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('uid', uid);
    formdata.append('viewpendings', '');
    var res = await myajax(file, formdata);
    modalxl(`View pendings of ${$(btn).closest('tr').find('td:eq(2)').text()}`, res);
    $('#modaltb').DataTable();
}

async function viewdata(btn) {
    ckid = $(btn).attr('did');
    var fd = new FormData();
    fd.append('viewdata', '');
    fd.append('did', ckid);
    var res = await myajax(file, fd);
    modallg(`${$(btn).closest('tr').find('td:eq(1)').text()} - Division Details`, res);
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
