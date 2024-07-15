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
        <li class="breadcrumb-item">Search</a></li>
      </ol>
    </nav>
  </div>

  <section class="section">
    <div class="card">
      <div class="card-body">
        <form onsubmit="return false;" id="tb_form">
          <div class="row d-flex justify-content-center align-items-center">
            <div class="col-3">
              <input type="text" class="form-control form-control-sm" id="search_input" name="search_input" placeholder="Search case number">
            </div>
            <div class="col-3">
              <button class="btn btn-primary btn-sm w-100" id="search_docket_data" t="1">Search docket data</button>
            </div>
            <div class="col-3">
              <button class="btn btn-warning btn-sm w-100" id="search_case_data" t="2">Search case data</button>
            </div>
          </div>
          <div class="row">
            <div class="table-responsive mt-3">
              <table class="table table-bordered table-hover text-center" id="maintb">
                <thead>
                </thead>
                <tbody>
                  <tr>
                    <td colspan="2">Search case number</td>
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