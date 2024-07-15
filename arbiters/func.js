file = 'func.php';
$(document).ready(function () {
    setfilter('case_type_code');
    setfilter('org_code');
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

    setTimeout(() => {
        $('#entries, #org_code, #case_type_code').change(function (e) {
            setpages();
        });
    }, 150);

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

async function settb() {
    var tb = $('#maintb');
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('settb', '');
    var res = await myajax(file, formdata); // Ensure 'file' is the correct endpoint

    var parsedRes = JSON.parse(res);

    setdatatb(parsedRes, tb);
}

/* 
async function settb() {
    tb = $('#maintb');
    $(tb).html(loadingsm("Fetching data, please wait..."));
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('settb', '');
    var res = await myajax(file, formdata);
    $(tb).html(res);
}
 */
async function setpages() {
    tb = $('#maintb');
    $(tb).html(loadingsm("Fetching data, please wait..."));
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('setpages', '');
    var res = await myajax(file, formdata);
    $('#page').html(res);
    settb();
}
