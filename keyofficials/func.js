file = 'func.php';
$(document).ready(function () {
    setTimeout(() => {
        setpages();
    }, 500);

    $('.refresh-tb').click(function (e) {
        setpages();
    });

    $('#search').keyup(function (e) {
        clearTimeout(timeout);
        timeout = setTimeout(function () {
            setpages();
        }, 250);
    });

    $('#page').change(function (e) {
        settb();
    });

});

async function savedetails(btn) {
    form = $(btn).closest('form')[0];

  /*   if ($(department).val() === "") {
        reqfunc($(department));
        twarning('Please enter department');
        return;
    } */

    var fd = new FormData(form);
    fd.append('savedetails', '');
    var res = await myajax(file, fd);
    if (res === "success") {
        setpages();
        tsuccess(`Key officials data updated.`);
        closeModal();
    } else {
        $(btn).prop('disabled', false);
        terror();
    }
}

async function editdetails(btn) {
    const ckid = $(btn).attr('ckid');
    const container = $(btn).closest('form').find('div.container');
    divval = $('#division').attr('divid');
    officialNo = $('#officialNo').html();
    await $(container).html(`
    <div class="container">
        <div class="form-group">
            <label for="officialNo"><strong>Official Name:</strong></label>
            <p id="officialNo">${officialNo}</p>
        </div>
        <div class="form-group">
            <label for="officialsName"><strong>Officials Name:</strong></label>
            <input type="text" class="form-control" id="officialsName" name="officialsName" value="${$('#officialsName').html().trim()}">
        </div>
        <div class="form-group">
            <label for="position"><strong>Position:</strong></label>
            <input type="text" class="form-control" id="position" name="position" value="${$('#position').html().trim()}">
        </div>
        <div class="form-group">
            <label for="division"><strong>Division:</strong></label>
            <select class="" id="division" name="division"></select>
        </div>
        <div class="form-group">
            <label for="contactNo"><strong>Contact No.:</strong></label>
            <input type="text" class="form-control" id="contactNo" name="contactNo" value="${$('#contactNo').html().trim()}">
        </div>
        <div class="form-group">
            <label for="status"><strong>Status:</strong></label>
            <p id="status">Posted</p>
        </div>
    </div>`);

    await setfilter('division');

    $('#division').selectize();
    var s = $('#division')[0].selectize;
    if (s) {
        s.setValue(divval);
    } else {
        console.error("Selectize instance not found.");
    }

    $(btn).text('Save Details').removeClass('btn-warning').addClass('btn-success').attr('onclick', 'savedetails(this)');
}

async function viewdata(btn) {
    ckid = $(btn).attr('ckid');
    var fd = new FormData();
    fd.append('viewdata', '');
    fd.append('ckid', ckid);
    var res = await myajax(file, fd);
    modallg(`Key official details`, res);
    $('#btn_submit').html(`<button type="button" class="btn btn-warning btn-sm" ckid="1" onclick="editdetails(this)">Edit Details</button>`);
}


async function settb() {
    var tb = $('#maintb');
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('settb', '');
    var res = await myajax(file, formdata); // Ensure 'file' is the correct endpoint

    var parsedRes = JSON.parse(res);

    setdatatb(parsedRes, tb);
}

async function setpages() {
    tb = $('#maintb');
    $(tb).html(loadingsm("Fetching data, please wait..."));
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('setpages', '');
    var res = await myajax(file, formdata);
    $('#page').html(res);
    settb();
}

