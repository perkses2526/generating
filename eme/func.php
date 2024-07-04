<?php
require_once '../dbcon.php';

$RM = $_POST['RM'] ?? '';
$arbiter = $_POST['arbiter'] ?? '';
$aid = $_POST['aid'] ?? '';

if (isset($_POST['saveeme'])) {
    $sql = "INSERT INTO main_nlrc_db.eme (RM, ARBITER, AID)VALUES('$RM', '$arbiter', '$aid')";
    echo crud($sql);
}

if (isset($_POST['setneweme'])) {
    echo '
    <div class="container">
        <div class="form-group">
            <label for="ARBITER"><strong>SELECT ARBITER:</strong></label>
            <select name="arbiter" id="arbiter"></select>
        </div>
        <div class="form-group">
            <label for="RM"><strong>RM:(FORMAT: <br>ADDRESS <br>CONTACT/+1 <br>EMAIL/+1)</strong></label>
            <textarea class="form-control form-control-sm" id="RM" rows="4" placeholder="RM:
CONTACT:
EMAIL:">RM:
CONTACT:
EMAIL:</textarea>
        </div>
    </div>
';
}

if (isset($_POST['savedetails'])) {
    $sql = "
    UPDATE main_nlrc_db.eme
    SET
        RM = '$RM',
        ARBITER = '$arbiter',
        AID = '$aid'
    WHERE
        ID = '$did';
";
    echo crud($sql);
}

if (isset($_POST['setarbiter'])) {
    $sql = "SELECT user_id, UPPER(CONCAT(lname, ', ',fname, ' ', LEFT(mname, 1), '. (',org_code,')')) FROM ects_core.users;";
    echo optiontags($sql, $_POST['val']);
}

if (isset($_POST['viewdata'])) {
    $sql = "SELECT e.*, u.org_code FROM main_nlrc_db.eme e
    join ects_core.users u on u.user_id = e.AID WHERE ID = '$did'";
    $res = mysqli_fetch_array(execquery($sql));
    echo '
        <input type="hidden" name="did" id="did" value="' . $res[0] . '"> 
        <input type="hidden" name="aid" id="aid" value="' . $res['AID'] . '"> 
        <div class="container">
            <div class="form-group">
                <label for="ID"><strong>ID:</strong></label>
                <p id="ID">' . $res[0] . '</p>
            </div>
            <div class="form-group">
                <label for="ARBITER"><strong>ARBITER Name(ORG):</strong></label>
                <p id="ARBITER">' . $res[2] . ' (' . $res['org_code'] . ')</p>
            </div>
            <div class="form-group">
                <label for="RM"><strong>RM:</strong></label>
                <p id="RM">' . nl2br($res[1]) . '</p>
            </div>
        </div>
    ';
}

if (isset($_POST['settb'])) {

    $sql = "SELECT ID, ARBITER, RM, AID,
    CONCAT('<button class=\"btn btn-primary btn-sm\" did=\"', ID, '\" onclick=\"viewdata(this)\">View details</button>') AS `Action`
    FROM main_nlrc_db.eme
    order by ID desc
    ;";
    echo datatb($sql);
}
