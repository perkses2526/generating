<?php
session_start();
if (isset($_SESSION['active'])) {
  if ($_SESSION['usertype']  === "admin" || $_SESSION['usertype']  === "superadmin") {
    header("location: dashboard/");
  } else if ($_SESSION['usertype']  === "Coordinator") {
    header("location: dashboards/");
  }
}

echo header("location: reports/");
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="description">
  <meta content="" name="keywords">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

  <link href="assets/css/style.css" rel="stylesheet">

</head>

<body>
  <main>
    <div class="container-scroller">
      <div class="container-fluid page-body-wrapper full-page-wrapper">
        <div class="content-wrapper d-flex align-items-center auth px-0">
          <div class="row w-100 mx-0">
            <div class="col-lg-4 mx-auto">
              <div class="auth-form-light text-left py-5 px-4 px-sm-5">
                <div class="row">
                  <div class="card">
                    <div class="card-body">
                      <div class="brand-logo text-center">
                        <h1 class="mt-3">PAYROLL</h1>
                      </div>
                      <h6 class="font-weight-light">Sign in to continue.</h6>
                      <form class="pt-3">
                        <div class="mb-3">
                          <label for="username" class="form-label">Username or Email</label>
                          <input type="email" class="form-control form-control-lg" id="username" name="username" placeholder="Username or email">
                        </div>
                        <div class="mb-3">
                          <label for="password" class="form-label">Password</label>
                          <input type="password" class="form-control form-control-lg" id="password" name="password" placeholder="Password">
                        </div>
                        <div class="mb-3 text-center">
                          <button type="button" class="btn btn-success btn-lg btn-block font-weight-medium auth-form-btn" onclick="signin(this)">SIGN IN</button>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>
    </div>
    <div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 2000;">
    </div>
  </main>

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <script src="assets/js/main.js"></script>
  <script src="jq.js"></script>
  <script src="swal.js"></script>
  <script src="funcs.js"></script>
  <script src="index.js"></script>

</body>

</html>