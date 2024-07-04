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
        <li class="breadcrumb-item active">Key Officials</li>
      </ol>
    </nav>
  </div>

  <section class="section">
    <div class="card">
      <div class="card-body">
        <form onsubmit="return false;" id="tb_form">

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
        </form>
      </div>
    </div>
  </section>

</main>
<script src="func.js"></script>

<?php require_once '../footer.php'; ?>