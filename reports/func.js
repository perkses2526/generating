file = 'func.php';
$(document).ready(function () {
    setTimeout(() => {
        settb();
    }, 500);

    $('.refresh-tb').click(function (e) {
        settb();
    });

    /*  $('#search').keyup(function (e) {
         clearTimeout(timeout);
         timeout = setTimeout(function () {
             setpages();
         }, 250);
     });
 
     $('#page').change(function (e) {
         settb();
     });
 
     $('#entries, #report_list').change(function (e) {
         setpages();
     }); */

    setTimeout(() => {
        $('#report_list').change(function (e) {
            console.log("asd");
            if ($(this).val() === "10") {
                var today = new Date();
                today.setMonth(today.getMonth() - 9);
                var formattedDate = today.getFullYear() + '-' + String(today.getMonth() + 1).padStart(2, '0') + '-' + String(today.getDate()).padStart(2, '0');
                $('#start_date').val(formattedDate);
                console.log(formattedDate);
            }
            else if ($(this).val() === "7") {
                var today = new Date();
                today.setMonth(today.getMonth() - 9);
                var formattedDate = today.getFullYear() + '-' + String(today.getMonth() + 1).padStart(2, '0') + '-' + String(today.getDate()).padStart(2, '0');
                $('#end_date').val(formattedDate);
                console.log(formattedDate);
            }
            else {
                $('#start_date').val("2019-01-05");
            }
        });

    }, 500);


});

async function settodayed(div) {
    var today = new Date();
    var formattedDate = today.getFullYear() + '-' + String(today.getMonth() + 1).padStart(2, '0') + '-' + String(today.getDate()).padStart(2, '0');
    $('#end_date').val(formattedDate);
}



async function extractdata(btn) {
    $(btn).html(loadingsm());
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('report_name', $('#report_list option:selected').text());
    formdata.append('extractdata', '');

    var res = await myajax(file, formdata);
    tsuccess(res);
    $(btn).html(`<i class="bi bi-file-spreadsheet-fill"></i>`);
}

async function settb() {
    var tb = $('#maintb');
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('settb', '');
    var res = await myajax(file, formdata); // Ensure 'file' is the correct endpoint

    var parsedRes = JSON.parse(res);

    if (parsedRes.error) {
        reqfunc($('#report_list'));
        twarning(parsedRes.error);
        return; // Early return if no report is selected
    }

    setdatatb(parsedRes, tb);
}








/* async function settb() {
    tb = $('#maintb');
    $(tb).html(loadingsm("Fetching data, please wait..."));
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('settb', '');
    var res = await myajax(file, formdata);
    if (res.includes('Select a report to generate')) {
        reqfunc($('#report_list'));
        twarning(`Please select a report`);
    }
    await new DataTable(tb, {
        ajax: res
    });
    // await $(tb).html(res);
    // $(tb).DataTable();
} */

async function setpages() {
    tb = $('#maintb');
    $(tb).html(loadingsm("Fetching data, please wait..."));
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('setpages', '');
    var res = await myajax(file, formdata);
    $('#page').html(res);
    settb();
}

