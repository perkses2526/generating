file = 'func.php';
$(document).ready(function () {
    setTimeout(() => {
        settb();
    }, 500);

    $('.refresh-tb').click(function (e) {
        settb();
    });

    /*   $('#search').keyup(function (e) {
          clearTimeout(timeout);
          timeout = setTimeout(function () {
              setpages();
          }, 250);
      });
  
      $('#page').change(function (e) {
          settb();
      }); */

});

async function savedetails() {
    arbiter = $('#arbiter').val();
    RM = $('#RM').val();
    if (RM === "") {
        rqtoast($('#RM'));
        return;
    }
    if (arbiter === "") {
        rqtoast($('#arbiter'));
        return;
    }
    if (!confirm("Are you sure to update this data?")) {
        return;
    }
    var fd = new FormData();

    fd.append('did', $('#did').val());
    fd.append('RM', RM);
    fd.append('arbiter', $('#arbiter option:selected').text().trim().split('(')[0].trim());
    fd.append('aid', arbiter);
    fd.append('savedetails', '');
    var res = await myajax(file, fd);
    if (res === "success") {
        /*  settb(); */
        tsuccess(`EME data updated.`);
        closeModal();
    } else {
        $(btn).prop('disabled', false);
        terror();
    }
}

async function editdetails(btn) {
    aid = $('#aid').val();
    did = $('#did').val();
    const container = $(btn).closest('form').find('div.container');
    await $(container).html(`
    <input type="hidden" name="did" id="did" value="${did}"> 
    <input type="hidden" name="aid" id="aid" value="${aid}"> 
    <div class="container">
        <div class="form-group">
            <label for="ID"><strong>ID:</strong></label>
            <p id="did">${$('#ID').html().trim()}</p>
        </div>
        <div class="form-group">
            <label for="ARBITER"><strong>ARBITER Name:</strong></label>
            <select name="arbiter" id="arbiter"></select>
            <!--<textarea type="text" class="form-control form-control-sm" id="ARBITER">${$('#ARBITER').html().trim()}</textarea>-->
        </div>
        <div class="form-group">
            <label for="RM"><strong>RM:(FORMAT: <br>ADDRESS <br>CONTACT/+1 <br>EMAIL/+1)</strong></label>
            <textarea class="form-control form-control-sm" id="RM" rows="4">${$('#RM').html().trim().replace(/<br\s*\/?>/gi, '')}</textarea>
        </div>
    </div>`);

    await setfilter('arbiter', aid);

    $('#arbiter').selectize();
    var s = $('#arbiter')[0].selectize;
    if (s) {
        s.setValue(aid);
    } else {
        console.error("Selectize instance not found.");
    }


    $(btn).text('Save Details').removeClass('btn-warning').addClass('btn-success').attr('onclick', 'savedetails(this)');
}

async function saveeme(btn) {
    arbiter = $('#arbiter').val();
    RM = $('#RM').val();
    if (RM === "") {
        rqtoast($('#RM'));
        return;
    }
    if (arbiter === "") {
        rqtoast($('#arbiter'));
        return;
    }
    if (!confirm("Are you sure to add this eme data?")) {
        return;
    }
    var fd = new FormData();

    fd.append('RM', RM);
    fd.append('arbiter', $('#arbiter option:selected').text().trim().split('(')[0].trim());
    fd.append('aid', arbiter);
    fd.append('saveeme', '');
    var res = await myajax(file, fd);
    if (res === "success") {
        settb();
        tsuccess(`EME data added.`);
        closeModal();
    } else {
        $(btn).prop('disabled', false);
        terror();
    }
}

async function setneweme(btn) {
    var fd = new FormData();
    fd.append('setneweme', '');
    var res = await myajax(file, fd);
    modallg(`Add new EME`, res);
    await setfilter('arbiter');
    $('#arbiter').selectize();
    $('#btn_submit').html(`<button type="button" class="btn btn-success btn-sm" ckid="1" onclick="saveeme(this)">Save eme</button>`);
}

async function viewdata(btn) {
    hhtr(btn);
    ckid = $(btn).attr('did');
    var fd = new FormData();
    fd.append('viewdata', '');
    fd.append('did', ckid);
    var res = await myajax(file, fd);
    modallg(`${$(btn).closest('tr').find('td:eq(1)').text()} - EME Details`, res);
    $('#modaltb').DataTable();
    $('#btn_submit').html(`<button type="button" class="btn btn-warning btn-sm" ckid="1" onclick="editdetails(this)">Edit Details</button>`);
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



/* async function settb() {
    tb = $('#maintb');
    $(tb).html(loadingsm("Fetching data, please wait..."));
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('settb', '');
    var res = await myajax(file, formdata);
    $(tb).html(res);
}
 *//* 
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