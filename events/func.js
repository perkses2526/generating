file = 'func.php';
$(document).ready(function () {
    settb();
    $('.refresh-tb').click(function (e) {
        // setpages();
        settb();
    });
});

async function savedetails(btn) {
    form = $(btn).closest('form')[0];
    var fd = new FormData(form);
    fd.append('savedetails', '');
    var res = await myajax(file, fd);
    if (res === "success") {
        settb();
        tsuccess(`News and events data updated.`);
        closeModal();
    } else {
        $(btn).prop('disabled', false);
        terror();
    }
}

async function editdetails(btn) {
    location_val = $('#location').html();
    $('#modalBody').html(`
        <input type="hidden" name="did" id="id" value="${$(btn).attr('did')}"> 
        <div class="container">
            <div class="form-group">
                <label for="ID"><strong>ID:</strong></label>
                <p id="ID">${$('#ID').html()}</p>
            </div>
            <div class="form-group">
                <label for="event_name"><strong>Event Name:</strong></label>
                <input type="text" class="form-control form-control-sm" id="event_name" name="event_name" value="${$('#event_name').html()}">
            </div>
            <div class="form-group">
                <label for="event_no"><strong>Event No:</strong></label>
                <input type="text" class="form-control form-control-sm" id="event_no" name="event_no" value="${$('#event_no').html()}">
            </div>
            <div class="form-group">
                <label for="file_name"><strong>File name:</strong></label>
                <input type="text" class="form-control form-control-sm" id="file_name" name="file_name" value="${$('#file_name').html()}">
            </div>
            <div class="form-group">
                <label for="location"><strong>Location:</strong></label>
                <select id="location" name="location">
                    <option value="">Select location</option>
                    <option value="/var/www/html/NLRCMS/uploads/events/tmp/">/var/www/html/NLRCMS/uploads/events/tmp/</option>
                    <option value="/var/www/html/NLRCP/uploads/events/">/var/www/html/NLRCP/uploads/events/</option>
                    <option value="/var/www/html/NLRCP/uploads/events/tmp/">/var/www/html/NLRCP/uploads/events/tmp/</option>
                    <option value="/var/www/html//uploads/events/">/var/www/html//uploads/events/</option>
                </select>
            </div>
        </div>`);

    $('#location').selectize();
    var s = $('#location')[0].selectize;
    if (s) {
        s.setValue(location_val);
    } else {
        console.error("Selectize instance not found.");
    }

    $(btn).text('Save Details').removeClass('btn-warning').addClass('btn-success').attr('onclick', 'savedetails(this)');
}

async function viewdata(btn) {
    did = $(btn).closest('tr').find('td:eq(0)').text();
    var fd = new FormData();
    fd.append('viewdata', '');
    fd.append('did', did);
    var res = await myajax(file, fd);
    modallg(`Title: ${$(btn).closest('tr').find('td:eq(2)').text()} - Event Details`, res);
    $('#modaltb').DataTable();
    $('#btn_submit').html(`<button type="button" class="btn btn-warning btn-sm" did="${did}" onclick="editdetails(this)">Edit Details</button>`);
}

async function settb() {
    var tb = $('#maintb');
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('settb', '');
    var res = await myajax(file, formdata); // Ensure 'file' is the correct endpoint
    var parsedRes = JSON.parse(res);
    setdatatb(parsedRes, tb);
}
