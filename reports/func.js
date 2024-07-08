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
    tb.html(loadingsm("Fetching data, please wait..."));
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('settb', '');

    try {
        var res = await myajax(file, formdata); // Ensure 'file' is the correct endpoint

        tb.DataTable().clear().destroy();
        tb.html("");

        // Assuming res is in JSON format, parse it
        var parsedRes = JSON.parse(res);

        if (parsedRes.error) {
            reqfunc($('#report_list'));
            twarning(parsedRes.error);
            return; // Early return if no report is selected
        }

        var columns = parsedRes.columns.map(column => ({ title: column, data: column }));
        var data = parsedRes.data;

        // Calculate lengthMenu options based on the number of records
        var numRecords = data.length;
        var lengthMenu = [];
        var step = 10; // Starting step size for the menu
        for (var i = step; i < numRecords; i += step) {
            lengthMenu.push(i);
        }
        lengthMenu.push(numRecords, -1); // Add the total number of records and "All" option
        var lengthMenuLabels = lengthMenu.slice(0, -1).concat(["All"]);

        // Create a new header with search inputs
        var header = '<thead><tr>';
        columns.forEach(col => {
            header += `<th>${col.title}</th>`;
        });
        header += '</tr></thead>';

        tb.append(header);

        // Initialize DataTable with the received data and columns
        var dataTable = tb.DataTable({
            data: data,
            columns: columns,
            pageLength: 100, // Default number of rows to display
            lengthMenu: [lengthMenu, lengthMenuLabels], // Automated lengthMenu options
            orderCellsTop: true,
            fixedHeader: true,
            initComplete: function () {
                var api = this.api();

                // Setup the search inputs in the header
                api.columns().eq(0).each(function (colIdx) {
                    var cell = $('thead tr:eq(0) th').eq(colIdx);
                    var title = $(cell).text();
                    $(cell).html(title + '<br><input type="text" class="form-control form-control-sm column-search" placeholder="Search ' + title + '" />');

                    // On every keypress in this input
                    $('input', cell).off('keyup change').on('keyup change', function (e) {
                        e.stopPropagation();

                        // Get the search value
                        $(this).attr('title', $(this).val());
                        var regexr = '({search})'; // alternative: {search} OR {search}

                        var cursorPosition = this.selectionStart;
                        // Search the column for that value
                        api.column(colIdx).search(
                            this.value != ''
                                ? regexr.replace('{search}', '(((' + this.value + ')))')
                                : '',
                            this.value != '',
                            this.value == ''
                        ).draw();

                        $(this).focus()[0].setSelectionRange(cursorPosition, cursorPosition);
                    });
                });
            }
        });

    } catch (error) {
        console.error('Error fetching data:', error);
        twarning('An error occurred while fetching the data.');
    }
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

