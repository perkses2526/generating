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
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('settb', '');
    var res = await myajax(file, formdata); // Ensure 'file' is the correct endpoint

    var parsedRes = JSON.parse(res);

    setdatatb(parsedRes, tb);
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