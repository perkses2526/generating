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

async function viewdata(btn) {
    ckid = $(btn).attr('did');
    var fd = new FormData();
    fd.append('viewdata', '');
    fd.append('did', ckid);
    var res = await myajax(file, fd);
    modallg(`${$(btn).closest('tr').find('td:eq(1)').text()} - Division Details`, res);
    $('#modaltb').DataTable();
}

async function settb() {
    var tb = $('#maintb');
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('settb', '');
    var res = await myajax(file, formdata); 

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
