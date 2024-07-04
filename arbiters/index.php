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
        <li class="breadcrumb-item active">Arbiter</li>
      </ol>
    </nav>
  </div>

  <section class="section">
    <form onsubmit="return false;" id="tb_form">
      <div class="card">
        <div class="card-body p-3">
          <div class="row">
            <span>Filters:</span>
            <div class="col-3 text-end">
              <label for="org_code">Organization code</label>
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
            <div class="col-3 text-end">
              <label for="case_type_code">Case type code</label>
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
            <div class="col-auto">
              <label for="start_date"></label>
              <input type="date" class="form-control form-control-sm" name="start_date" id="start_date" value="2019-05-01">
            </div>
            <div class="col-auto">
              <label for="end_date">Filed date range</label>
              <input type="date" class="form-control form-control-sm" name="end_date" id="end_date" value="<?php echo date('Y-m-d'); ?>">
            </div>
            <div class="col-auto mt-auto">
              <button class="btn btn-success btn-sm"><i class="bi bi-file-spreadsheet-fill" onclick="htmltb_to_excel('maintb')"></i></button>
            </div>
            <div class="col-auto mt-auto">
              <button class="btn btn-success btn-sm refresh-tb" title="Refresh table"><i class="bi bi-arrow-clockwise"></i></button>
            </div>
          </div>
        </div>
      </div>

      <div class="card">
        <div class="card-body">
          <div class="row">
            <!-- <div class="row mb-2 mt-3">
              <div class="col">
                <select name="entries" id="entries" class="form-control form-control-sm w-auto">
                  <option value="50">50</option>
                  <option value="100">100</option>
                  <option value="200">200</option>
                  <option value="500">500</option>
                  <option value="1000">1000</option>
                </select>
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
              <div class="text-right col-auto">
                <button class="btn btn-success btn-sm refresh-tb" title="Refresh table"><i class="bi bi-arrow-clockwise"></i></button>
              </div>
            </div> -->
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
                    <td colspan="6"><span class=" fs-6">Fetching data...</span>
                      <div class="spinner-border spinner-border-sm text-success" id="l" role="status"></div>
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