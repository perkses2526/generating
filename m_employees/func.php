<?php
require_once '../dbcon.php';

$EMID = $_POST['EMID'] ?? '';
$EMLastName = $_POST['EMLastName'] ?? '';
$EMFirstName = $_POST['EMFirstName'] ?? '';
$EMMiddleName = $_POST['EMMiddleName'] ?? '';
$EMExtension = $_POST['EMExtension'] ?? '';
$EMServiceDate = !empty($_POST['EMServiceDate']) ? $_POST['EMServiceDate'] : '0000-00-00 00:00:00';
$EMPosition = $_POST['EMPosition'] ?? '';
$EMUnit = $_POST['EMUnit'] ?? '';

if (isset($_POST['saveEmp'])) {
    $sql = "INSERT INTO `main_nlrc_db`.`M_Employees` (`EMID`, `EMLastName`, `EMFirstName`, `EMMiddleName`, `UACreatedBy`, `UACreatedDate`, `EMActive`, `EMExtension`, `EMServiceDate`, `EMPosition`, `EMUnit`) 
    VALUES ('$EMID', '$EMLastName', '$EMFirstName', '$EMMiddleName', '1', '" . date('Y-m-d H:i:s') . "', '1', '$EMExtension', '$EMServiceDate', '$EMPosition', '$EMUnit');";
    echo crud($sql);
}

if (isset($_POST['setnewEmp'])) {
    echo '
    <div class="container">
        <div class="form-group">
            <label for="EMID"><strong>Employee ID:</strong><span class="text-danger">*</span></label>
            <input type="text" class="form-control form-control-sm" id="EMID" name="EMID" placeholder="Employee ID:" required>
        </div>
        <div class="form-group">
            <label for="EMLastName"><strong>Last name:</strong><span class="text-danger">*</span></label>
            <input type="text" class="form-control form-control-sm" id="EMLastName" name="EMLastName" placeholder="last_name:" required>
        </div>
        <div class="form-group">
            <label for="EMFirstName"><strong>First name:</strong><span class="text-danger">*</span></label>
            <input type="text" class="form-control form-control-sm" id="EMFirstName" name="EMFirstName" placeholder="first_name:" required>
        </div>
        <div class="form-group">
            <label for="EMMiddleName"><strong>Middle name:</strong></label>
            <input type="text" class="form-control form-control-sm" id="EMMiddleName" name="EMMiddleName" placeholder="middle_name:">
        </div>
        <div class="form-group">
            <label for="EMExtension"><strong>Extension name:</strong></label>
            <input type="text" class="form-control form-control-sm" id="EMExtension" name="EMExtension" placeholder="extension_name:">
        </div>
        <div class="form-group">
            <label for="EMServiceDate"><strong>Service:</strong></label>
            <input type="date" class="form-control form-control-sm" id="EMServiceDate" name="EMServiceDate" placeholder="service_date:">
        </div>
        <div class="form-group">
            <label for="EMPosition"><strong>Position:</strong><span class="text-danger">*</span></label>
            <input type="text" class="form-control form-control-sm" id="EMPosition" name="EMPosition" placeholder="Position:" required>
        </div>
        <div class="form-group">
            <label for="EMUnit"><strong>Designation:</strong><span class="text-danger">*</span></label>
            <input type="text" class="form-control form-control-sm" id="EMUnit" name="EMUnit" placeholder="Designation:" required>
        </div>
        
    </div>
';
}

if (isset($_POST['viewdata'])) {
    echo "";
}

if (isset($_POST['settb'])) {
    $sql = "SELECT *, concat(EMLastName, ' ', EMFirstName) as Full_name FROM main_nlrc_db.M_Employees;";
    echo datatb($sql);
}

    /* Case "552" 'NCR samar
        ELA = True
    Case "517" 'NCR dysangco
        ELA = True
    Case "509" 'CAR celino
        ELA = True
    Case "1181" 'RABI carasig
        ELA = True
    Case "9999" 'SRABI none
        ELA = True
    Case "1084" 'RABII lerios
        ELA = True
    Case "712" 'RABIII almeyda
        ELA = True
    Case "1170" 'RABIII-SO almeyda
        ELA = True
    Case "722" 'RABIV guan
        ELA = True
    Case "1304" 'SRABIV guan
        ELA = True
    Case "1397" 'RABV sarmiento
        ELA = True
    Case "1180" 'SRABV sarmiento
        ELA = True
    Case "1094" 'RABVI dadula
        ELA = True
    Case "1098" 'SRABVI nafarrete
        ELA = True
    Case "9999" 'SRABVIA none
        ELA = True
    Case "1114" 'RABVII cabatingan
        ELA = True
    Case "9999" 'SRABVII none
        ELA = True
    Case "9999" 'RABVIII none
        ELA = True
    Case "1292" 'RABIX amarga
        ELA = True
    Case "1295" 'SRABIX amarga
        ELA = True
    Case "1407" 'RABX SM.DATU10
        ELA = True
    Case "1411" 'RABX-BUK datu
        ELA = True
    Case "1126" 'SRABX datu
        ELA = True
    Case "1128" 'RABXI sedillo
        ELA = True
    Case "1184" 'RABXI-TC sedillo
        ELA = True
    Case "1258" 'RABXI-DC sedillo
        ELA = True
    Case "1235" 'RABXII vasallo
        ELA = True
    Case "1254" 'RABXII-KD vasallo
        ELA = True
    Case "1135" 'SRABXII vasallo
        ELA = True
    Case "9999" 'RABXIII
        ELA = True

 552
517
509
1181
9999
1084
712
1170
722
1304
1397
1180
1094
1098
9999
1114
9999
9999
1292
1295
1407
1411
1126
1128
1184
1258
1235
1254
1135
9999       
 */
