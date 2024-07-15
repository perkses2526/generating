file = 'func.php';
$(document).ready(function () {
    /*   setTimeout(() => {
          setpages();
      }, 500);
   */

    settb();
    $('.refresh-tb').click(function (e) {
        // setpages();
        settb();
    });

    /* $('#search').keyup(function (e) {
        clearTimeout(timeout);
        timeout = setTimeout(function () {
            setpages();
        }, 250);
    }); */

    /* $('#page').change(function (e) {
        settb();
    }); */

});

/* 
async function settb() {
    tb = $('#maintb');
    $(tb).html(loadingsm("Fetching data, please wait..."));
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('settb', '');
    var res = await myajax(file, formdata);
    $(tb).html(res);
} */

async function viewdata(btn) {
    ckid = $(btn).attr('did');
    var fd = new FormData();
    fd.append('viewdata', '');
    fd.append('did', ckid);
    var res = await myajax(file, fd);
    modallg(`${$(btn).closest('tr').find('td:eq(1)').text()} - Role code users`, res);
    $('#modaltb').DataTable();
    // $('#btn_submit').html(`<button type="button" class="btn btn-warning btn-sm" ckid="1" onclick="editdetails(this)">Edit Details</button>`);
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
            pageLength: 50, // Default number of rows to display
            lengthMenu: [lengthMenu, lengthMenuLabels], // Automated lengthMenu options
            orderCellsTop: true,
            fixedHeader: true,
            initComplete: function () {
                var api = this.api();

                // Setup the search inputs in the header
                api.columns().eq(0).each(function (colIdx) {
                    var cell = $('thead tr:eq(0) th').eq(colIdx);
                    var title = $(cell).text();
                    if (title !== 'Action') { // Exclude 'Action' column from adding search inputs
                        $(cell).html(title + '<br><input type="text" class="form-control form-control-sm column-search" placeholder="Search ' + title + '" />');

                        // On every keypress in this input
                        $('input', cell).off('keyup change').on('keyup change', function (e) {
                            e.stopPropagation();

                            // Get the search value
                            $(this).attr('title', $(this).val());
                            var regexr = '({search})'; // alternative: {search} OR {search}

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
                    } else {
                        $(cell).html(title); // Just display the title for 'Action' column
                    }
                });
            }
        });

    } catch (error) {
        console.error('Error fetching data:', error);
        twarning('An error occurred while fetching the data.');
    }
}

/* 
async function setpages() {
    tb = $('#maintb');
    $(tb).html(loadingsm("Fetching data, please wait..."));
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('setpages', '');
    var res = await myajax(file, formdata);
    $('#page').html(res);
    settb();
}
 */