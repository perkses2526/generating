file = 'func.php';
$(document).ready(function () {
    $('.refresh-tb').click(function (e) {
        settb();
    });

    $('#search_company_data').click(function (e) {
        search_data($(this));
    });
});

async function addcomma() {
    var input = $('#search_input').val();

    // Split the input by new lines
    var lines = input.split('\n');

    // Process each line
    var processedLines = lines.map(function (line) {
        // Trim the line and wrap it in single quotes
        var trimmedLine = $.trim(line);
        return "'" + trimmedLine + "'";
    });

    // Join the processed lines with commas
    var result = processedLines.join(',\n');

    $('#search_input').val(result);

    console.log(result);
}









async function search_data(btn) {
    var org = $(btn).html();
    var data = $('#search_input');
    var val = isElem(data) ? $(data).val() : data;

    if (val === "") {
        reqfunc(data);
        twarning("Please input case number");
        return;
    }

    // Split the input value by new lines into an array
    var valuesArray = val.split(/[\r\n]+/).map(function (line) {
        return $.trim(line);
    }).filter(function (line) {
        return line.length > 0;
    });

    // Convert the array to a comma-separated string
    var formattedVal = valuesArray.map(function (line) {
        return line; // No need for single quotes here
    }).join(', ');

    $(btn).html(loadingsm("fetching...")).prop('disabled', true);
    var fd = new FormData();
    fd.append('val', formattedVal);
    fd.append('search_data', '');
    var res = await myajax(file, fd);
    var parsedRes = JSON.parse(res);

    setdatatb(parsedRes);

    $(btn).html(org).prop('disabled', false);
}



async function viewdata(btn) {
    if ($(btn).html() !== "0") {
        number = ($(btn).attr('case_id') ? $(btn).attr('case_id') : $(btn).attr('docket_number'));
        t = ($(btn).attr('case_id') ? "2" : "1");
        attrs = formatHeaderTitle($(btn).attr('attrs'));
        ckid = $(btn).attr('did');
        var fd = new FormData();
        fd.append('viewdata', '');
        fd.append('number', number);
        fd.append('t', t);
        fd.append('attrs', $(btn).attr('attrs'));
        var res = await myajax(file, fd);
        modalxl(`${$(btn).closest('tr').find('td:eq(0)').text()} - ${attrs} Details`, res);
        $('#modaltb').DataTable();
    }
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
