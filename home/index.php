<?php
require_once '../header.php';

echo '<script>window.location="../reports/"</script>';
exit;
// Flush the output buffer
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
        <li class="breadcrumb-item"><a href="../manage_company/">Home</a></li>
        <li class="breadcrumb-item active"></li>
      </ol>
    </nav>
  </div>

  <section class="section">
    <form onsubmit="return false;" id="tb_form">
      <div class="card">
        <div class="card-body p-3">
          <div class="row">
            <span>Filters:</span>
            <div class="col-6 text-end"><label for="org_code">Organization code</label>
              <select name="org_code[]" id="org_code" class="" multiple></select>
            </div>
            <div class="col-6 text-end"><label for="case_type_code">Case type code</label>
              <select name="case_type_code[]" id="case_type_code" class="" multiple></select>
            </div>
          </div>
        </div>
      </div>
      <div class="card">
        <div class="card-body">
          <div class="row">
            <div class="row mb-2 mt-3">
              <div class="col">
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
                    <button class="btn btn-success btn-sm"><i class="bi bi-file-spreadsheet-fill"></i></button>
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
              <div class="text-right col-auto">
                <button class="btn btn-success btn-sm refresh-tb" title="Refresh table"><i class="bi bi-arrow-clockwise"></i></button>
              </div>
            </div>
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