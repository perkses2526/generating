file = 'func.php';
$(document).ready(function () {
    $('.refresh-tb').click(function (e) {
        settb();
    });

    $('#search_docket_data, #search_case_data').click(function (e) {
        search_data($(this));
    });

});

async function search_data(btn) {
    // val = $(data).val();
    data = $('#search_input')
    var val = isElem(data) ? $(data).val() : data;

    if (val === "") {
        reqfunc(data);
        twarning("Please input case number");
        return;
    }

    var fd = new FormData();
    fd.append('val', val);
    fd.append('t', $(btn).attr('t'));
    fd.append('search_data', '');
    var res = await myajax(file, fd);
    var parsedRes = JSON.parse(res);

    setdatatb(parsedRes);
}

async function viewdata(btn) {
    number = ($(btn).attr('case_number') ? $(btn).attr('case_number') : $(btn).attr('docket_number'));
    ckid = $(btn).attr('did');
    var fd = new FormData();
    fd.append('viewdata', '');
    fd.append('number', number);
    console.log(number);
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
