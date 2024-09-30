file = 'func.php';
$(document).ready(function () {
    settb();
    $('.refresh-tb').click(function (e) {
        settb();
    });
});



async function saveEmp(btn) {
    form = $('#modal').find('form')[0];
    elems = $(form).find('input:required');
    if (!validator(elems)) {
        return;
    }
    var fd = new FormData(form);
    fd.append('saveEmp', '');
    var res = await myajax(file, fd);
    if (res === "success") {
        settb();
        tsuccess(`EME data added.`);
        closeModal();
    } else {
        $(btn).prop('disabled', false);
        terror();
    }
}

async function setnewEmp(btn) {
    var fd = new FormData();
    fd.append('setnewEmp', '');
    var res = await myajax(file, fd);
    modallg(`Add new employee`, res);
    $('#btn_submit').html(`<button type="button" class="btn btn-success btn-sm" ckid="1" onclick="saveEmp(this)">Save employee</button>`);
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
