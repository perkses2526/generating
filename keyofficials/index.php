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