file = 'func.php';
$(document).ready(function () {
    $('.refresh-tb').click(function (e) {
        settb();
    });

    $('#search_docket_data, #search_case_data').click(function (e) {
        search_data($(this));
    });

    $('#copyids').click(function (e) {
        if ($('#maintb').text().includes('Search case number')) {
            twarning(`Please search data first`);
            return;
        }

        // Collect data from the 2nd column in tbody
        let dataToCopy = [];
        $('#maintb tbody tr').each(function () {
            let secondColumnData = $(this).find('td:eq(1)').text(); // 'td:eq(1)' selects the 2nd column (0-based index)
            dataToCopy.push(secondColumnData);
        });

        // Copy the data to the clipboard
        let textToCopy = dataToCopy.join('\n');
        navigator.clipboard.writeText(textToCopy).then(function () {
            console.log('Data copied to clipboard successfully!');
        }, function (err) {
            console.error('Could not copy text: ', err);
        });
    });


});

async function addcomma() {
    var input = $('#search_input').val();

    // Split the input by spaces or commas
    var parts = input.split(/[\s,]+/);

    // Trim each part and join with commas
    var trimmedParts = parts.map(function (part) {
        return $.trim(part);
    });

    // Filter out any empty strings that may result from the split
    trimmedParts = trimmedParts.filter(function (part) {
        return part.length > 0;
    });

    // Join the trimmed parts with commas
    var result = trimmedParts.join(', ');

    $('#search_input').val(result);

    console.log(result);
}









async function search_data(btn) {
    org = $(btn).html();
    t = $(btn).attr('t');
    // val = $(data).val();
    data = $('#search_input')
    var val = isElem(data) ? $(data).val() : data;

    if (val === "") {
        reqfunc(data);
        twarning("Please input case number");
        return;
    }

    $(btn).html(loadingsm("fetching...")).prop('disabled', true);
    var fd = new FormData();

    fd.append('val', val);
    fd.append('t', t);
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
