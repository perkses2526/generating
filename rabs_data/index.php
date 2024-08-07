<?php
require_once '../header.php';
?>


<main id="main" class="main">
  <div class="pagetitle">
    <h1></h1>
    <nav>
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="../home/">Home</a></li>
        <li class="breadcrumb-item active"></li>
      </ol>
    </nav>
  </div>

  <section class="section">
    <div class="card">
      <div class="card-body">
        <form onsubmit="return false;" id="tb_form">
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
            <div class="col-auto">
              <div class="form-group">
                <label for="end_date" class="form-label">Counts</label>
                <input type="checkbox" name="countsonly" id="countsonly" value="1" class="form-check" checked>
              </div>
            </div>
            <div class="col-auto text-end">
              <div class="btn-group mt-4">
                <button class="btn btn-warning btn-sm" onclick="datatable_to_excel('maintb', $('#report_list option:selected').text() + ' ' + $('#org_code option:selected').text());" title="Export all data"><i class="bi bi-file-spreadsheet-fill"></i></button>
                <button class="btn btn-success btn-sm" onclick="htmltb_to_excel('maintb');" title="Export only the visible"><i class="bi bi-file-spreadsheet-fill"></i></button>
                <button class="btn btn-primary btn-sm refresh-tb" title="Refresh table"><i class="bi bi-arrow-clockwise"></i></button>
              </div>
            </div>

          </div>
          <div class="row">
            <div class="table-responsive mt-3">
              <table class="table table-bordered table-hover text-center" id="maintb">
                <thead>
                  <tr>
                    <th>#</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td colspan="6"><span class=" fs-6">Click
                        <button class="btn btn-primary btn-sm refresh-tb" title="Refresh table"><i class="bi bi-arrow-clockwise"></i></button>
                        to generate data</span>
                      <!-- <div class="spinner-border spinner-border-sm text-success" id="l" role="status"></div> -->
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </form>
      </div>
    </div>
  </section>

</main>
<script src="func.js"></script>

<?php require_once '../footer.php'; ?>