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

async function dockettask(btn) {
    docket_id = $(btn).closest('tr').find('td:eq(0)').text();
    var fd = new FormData();
    fd.append('dockettask', '');
    fd.append('docket_number', $(btn).closest('tr').find('td:eq(1)').text());
    fd.append('did', docket_id);
    var res = await myajax(file, fd);
    modalxl(`Docket task details - ${$(btn).closest('tr').find('td:eq(1)').text()}`, res);
}

async function docketreassign(btn) {
    docket_id = $(btn).closest('tr').find('td:eq(0)').text();
    var fd = new FormData();
    fd.append('docketreassign', '');
    fd.append('docket_number', $(btn).closest('tr').find('td:eq(1)').text());
    fd.append('did', docket_id);
    var res = await myajax(file, fd);
    modallg(`Docket re-assignment details - ${$(btn).closest('tr').find('td:eq(1)').text()}`, res);
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
    settbsort();
} */

async function setpages() {
    var formdata = new FormData($('#tb_form')[0]);
    formdata.append('setpages', '');
    var res = await myajax(file, formdata);
    $('#page').html(res);
    settb();
}
