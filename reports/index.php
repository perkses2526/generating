<?php
require_once '../header.php';
/* 
if (!($_SESSION['usertype'] === "superadmin")) {
  echo '<script>window.location="../404.php"</script>';
} */
?>


<main id="main" class="main">

  <div class="pagetitle">
    <h1></h1>
    <nav>
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="../home/">Home</a></li>
        <li class="breadcrumb-item active">Reports</li>
      </ol>
    </nav>
  </div>

  <section class="section">
    <form onsubmit="return false;" id="tb_form">
      <div class="card col">
        <div class="card-body mt-3">
          <div class="row">
            <div class="col">
              <label for="report_list">Report list</label>
              <select name="report_list" id="report_list" class="selectize">
                <option value="">Select a report</option>
                <option value="1">MAAM LENY CONMED 1ST DAY OF THE MONTH</option>
                <option value="2">CONMED PERFORMANCE</option>
                <option value="3">ARBITER REPORTS ALL CASES</option>
                <option value="4">ARBITER PENDINGS COUNT ONLY</option>
                <option value="5">SEnA NCR RAFFLING MONITOR</option>
                <option value="6">MONTHLY CONMED REPORT WITH COMMENT</option>
                <option value="7">ECTS STATUS</option>
                <option value="8">ARBITER REPORTS ALL CASES COUNT ONLY</option>
                <option value="9">ARBITER ALL CASES COUNTS WITH PENDING</option>
                <option value="10">LIST OF CASES FROM 9 MONTHS TILL NOW, CONMED RATING</option>
                <option value="11">ECTS usage of RABS Monthly with disposed count</option>
                <option value="12">RFA Report that has pending</option>
                <option value="13">Multiple company cases created</option>
                <option value="14">Count of arbiters cases monthly</option>
                <option value="15">RAB'S LAST 10 PENDING CASES</option>
              </select>
            </div>
            <!-- <div class="col-auto">
              <div class="form-check mt-3">
                <input class="form-check-input" type="checkbox" value="1" name="counts" id="counts">
                <label class="form-check-label" for="flexCheckDefault">
                  Count onlys
                </label>
              </div>
            </div> -->
          </div>
        </div>
      </div>

      <div class="card col">
        <div class="card-body mt-3">
          <div class="row align-items-center mb-3">
            <span class="col-auto">Filters:</span>
            <div class="col-3">
              <div class="form-group">
                <label for="org_code" class="form-label">Organization code</label>
                <select name="org_code[]" id="org_code" class="selectize" multiple>
                  <option value="NCR">NCR</option>
                  <option value="SIXTH">SIXTH</option>
                  <option value="RABIII">RABIII</option>
                  <option value="RABIV">RABIV</option>
                  <option value="CAR">CAR</option>
                  <option value="RABX">RABX</option>
                  <option value="RABVII">RABVII</option>
                  <option value="RABII">RABII</option>
                  <option value="RABVI">RABVI</option>
                  <option value="SRABVI">SRABVI</option>
                  <option value="RABV">RABV</option>
                  <option value="SRABV">SRABV</option>
                  <option value="RABIX">RABIX</option>
                  <option value="RABXI">RABXI</option>
                  <option value="RABVIII">RABVIII</option>
                  <option value="RABXIII">RABXIII</option>
                  <option value="SRABVIA">SRABVIA</option>
                  <option value="RABXII">RABXII</option>
                  <option value="SRABVII">SRABVII</option>
                  <option value="SRABXII">SRABXII</option>
                  <option value="" selected></option>
                  <option value="RABI">RABI</option>
                  <option value="RABIII-SO">RABIII-SO</option>
                  <option value="SRABI">SRABI</option>
                  <option value="RABXI-TC">RABXI-TC</option>
                  <option value="RABXII-KD">RABXII-KD</option>
                  <option value="RABXI-DC">RABXI-DC</option>
                  <option value="RABX-BUK">RABX-BUK</option>
                  <option value="SRABX">SRABX</option>
                  <option value="SRABIX">SRABIX</option>
                  <option value="RABIV-BA">RABIV-BA</option>
                  <option value="SRABIV">SRABIV</option>
                </select>
              </div>
            </div>
            <div class="col-3">
              <div class="form-group">
                <label for="case_type_code" class="form-label">Case type code</label>
                <select name="case_type_code[]" id="case_type_code" class="selectize" multiple>
                  <option value="APPEAL">APPEAL</option>
                  <option value="CASE">CASE</option>
                  <option value="ER">ER</option>
                  <option value="MR">MR</option>
                  <option value="REFILE">REFILE</option>
                  <option value="REMAND">REMAND</option>
                  <option value="REOPEN">REOPEN</option>
                  <option value="REVIVE">REVIVE</option>
                  <option value="RFA">RFA</option>
                </select>
              </div>
            </div>
            <div class="col-2">
              <div class="form-group">
                <label for="start_date" class="form-label">Start Date</label>
                <input type="date" class="form-control form-control-sm" name="start_date" id="start_date" value="2019-05-01">
              </div>
            </div>
            <div class="col-2">
              <div class="form-group">
                <label for="end_date" class="form-label">End Date <div class="badge bg-info text-wrap" onclick="settodayed(this);">Set today</div></label>
                <input type="date" class="form-control form-control-sm" name="end_date" id="end_date" value="<?php echo date('Y-m-d'); ?>">
              </div>
            </div>
            <div class="col-auto text-end">
              <div class="btn-group mt-4">
                <button class="btn btn-warning btn-sm" onclick="datatable_to_excel('maintb', $('#org_code option:selected').text() + ' - ' + $('#case_type_code option:selected').text() + ' - ' +$('#report_list option:selected').text());" title="Export all data"><i class="bi bi-file-spreadsheet-fill"></i></button>
                <button class="btn btn-success btn-sm" onclick="htmltb_to_excel('maintb');" title="Export only the visible"><i class="bi bi-file-spreadsheet-fill"></i></button>
                <button class="btn btn-primary btn-sm refresh-tb" title="Refresh table"><i class="bi bi-arrow-clockwise"></i></button>
              </div>
            </div>
          </div>

        </div>
      </div>

      <div class="card">
        <div class="card-body">
          <div class="row">
            <div class="row mb-2 mt-3">
              <!-- <div class="col">
                <select name="entries" id="entries" class="form-control form-control-sm w-auto">
                  <option value="50">50</option>
                  <option value="100">100</option>
                  <option value="200">200</option>
                  <option value="500">500</option>
                </select>
              </div>
              <div class="col-auto text-end">
                <div class="row">
                  <div class="col-auto">
                    <label for="start_date"></label>
                    <input type="date" class="form-control form-control-sm" name="start_date" id="start_date" class="selectize">
                  </div>
                  <div class="col-auto">
                    <label for="end_date">Filed date range</label>
                    <input type="date" class="form-control form-control-sm" name="end_date" id="end_date" class="selectize">
                  </div>
                  <div class="col-auto mt-auto">
                    <button class="btn btn-success btn-sm" onclick="extractdata(this);"><i class="bi bi-file-spreadsheet-fill"></i></button>
                  </div>
                </div>
              </div>
              <div class="col-3 text-end">
                <input type="text" name="search" id="search" class="form-control form-control-sm" placeholder="Search...">
              </div>
              <div class="col-auto text-center">
                <div class="input-group btn-group-sm text-end">
                  <button name="nextbtn" class="btn btn-sm btn-secondary prev">
                    <i class="bi bi-arrow-left"></i></button>
                  <select name="page" id="page" class="form-control">
                    <option value="0"></option>
                  </select>
                  <button name="prevbtn" class="btn btn-sm btn-secondary next">
                    <i class="bi bi-arrow-right"></i></button>
                </div>
              </div> 
              <div class="col-auto mt-auto">
                <button class="btn btn-success btn-sm" onclick="datatable_to_excel('maintb');"><i class="bi bi-file-spreadsheet-fill"></i></button>
              </div>
              <div class="text-right col-auto">
                <button class="btn btn-success btn-sm refresh-tb" title="Refresh table"><i class="bi bi-arrow-clockwise"></i></button>
              </div>
            -->

            </div>
            <div class="table-responsive mt-3">
              <table class="table table-bordered table-hover text-center w-100" id="maintb">
                <thead>
                  <tr>
                    <th>#</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td colspan="6"><span class=" fs-6">Select a report</span>
                      <!-- <div class="spinner-border spinner-border-sm text-success" id="l" role="status"></div> -->
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </form>
  </section>

</main>
<script src="func.js"></script>

<?php require_once '../footer.php'; ?>