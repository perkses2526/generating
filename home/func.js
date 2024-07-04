file = 'func.php';
$(document).ready(function () {

    setfilter('case_type_code');
    setfilter('org_code');
    setTimeout(() => {
        $('#case_type_code').selectize();
        $('#org_code').selectize();
    }, 500);

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
    }, 500);

});

async function viewcase(btn) {
    casenumber = $(btn).closest('tr').find('td:eq(0)').text();
    docketnumber = $(btn).closest('tr').find('td:eq(1)').text();
    var fd = new FormData();
    fd.append('case_id', casenumber);
    fd.append('viewcase', '');
    var res = await myajax(file, fd);
    modallg(`Case number: ${casenumber} Docket number: ${docketnumber}`, res);
}


async function settb() {
    tb = $('#maintb');
    $(tb).html(loadingsm("Fetching data, please wait..."));
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('settb', '');
    var res = await myajax(file, formdata);
    $(tb).html(res);
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
