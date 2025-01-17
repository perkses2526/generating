<?php
require_once '../header.php';
/* 
if (!($_SESSION['usertype'] === "superadmin")) {
  echo '<script>window.location="../404.php"</script>';
} */
?>


<main id="main" class="main">
  <div class="float-end col-auto">
    <div class="btn-group">
      <button class="btn btn-warning btn-sm" onclick="datatable_to_excel('maintb', 'Company data');" title="Export all data"><i class="bi bi-file-spreadsheet-fill"></i></button>
      <button class="btn btn-success btn-sm" onclick="htmltb_to_excel('maintb');" title="Export only the visible"><i class="bi bi-file-spreadsheet-fill"></i></button>
      <button class="btn btn-primary btn-sm refresh-tb" title="Refresh table"><i class="bi bi-arrow-clockwise"></i></button>
    </div>
  </div>
  <div class="pagetitle">
    <h1></h1>
    <nav>
      <ol class="breadcrumb">
        <li class="breadcrumb-item">Search</a></li>
      </ol>
    </nav>
  </div>
  <!-- add getting of dockets automatically -->
  <section class="section">
    <div class="card">
      <div class="card-body">
        <form onsubmit="return false;" id="tb_form">
          <div class="row d-flex justify-content-center align-items-center">
            <div class="col-3 d-flex">
              <textarea type="text" class="form-control form-control-sm" id="search_input" name="search_input" placeholder="Search company"></textarea>
              <!-- <div class="badge bg-info text-wrap m-auto" onclick="addcomma(this);" title="Adding separator(comma) per space in docket_number">Add comma</div> -->
            </div>
            <div class="col-auto">
              <button class="btn btn-outline-primary btn-sm w-100" id="search_company_data">Search company</button>
            </div>
          </div>
          <div class="row">
            <div class="table-responsive mt-3">
              <table class="table table-bordered table-hover text-center" id="maintb">
                <thead>
                </thead>
                <tbody>
                  <tr>
                    <td colspan="2">Search company</td>
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