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
    $sql = "SELECT * FROM main_nlrc_db.M_Employees;";
    echo datatb($sql);
}
