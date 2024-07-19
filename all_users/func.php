<?php
require_once '../dbcon.php';


if (isset($_POST['viewdata'])) {
    $sql = "SELECT u.user_id, username, org_code, fname, lname, mname, email, contact_no, mobile_no, status, group_concat(distinct ur.role_code) FROM `ects_core`.users u 
    join ects_core.user_roles ur on u.user_id = ur.user_id
    where u.user_id = '$did'
    group by u.user_id
    ;";
    $res = mysqli_fetch_array(execquery($sql));
    echo '
        <input type="hidden" name="did" id="id" value="' . $res[0] . '"> 
        <div class="container">
            <div class="form-group">
                <label for="user_id"><strong>User id:</strong></label>
                <p id="user_id">' . $res[0] . '</p>
            </div>
            <div class="form-group">
                <label for="username"><strong>Event Name:</strong></label>
                <p id="username">' . $res[1] . '</p>
            </div>
            <div class="form-group">
                <label for="org_code"><strong>Org code:</strong></label>
                <p id="org_code">' . $res[2] . '</p>
            </div>
            <div class="form-group">
                <label for="fname"><strong>First name:</strong></label>
                <p id="fname">' . $res[3] . '</p>
            </div>
           <div class="form-group">
                <label for="mname"><strong>Middle name:</strong></label>
                <p id="mname">' . $res[5] . '</p>
            </div>
            <div class="form-group">
                <label for="lname"><strong>Last name:</strong></label>
                <p id="lname">' . $res[4] . '</p>
            </div>
            <div class="form-group">
                <label for="email"><strong>Email:</strong></label>
                <p id="email">' . $res[6] . '</p>
            </div>
            <div class="form-group">
                <label for="contact"><strong>Contact no:</strong></label>
                <p id="contact">' . $res[7] . '</p>
            </div>
            <div class="form-group">
                <label for="mobile"><strong>Mobile no:</strong></label>
                <p id="mobile">' . $res[8] . '</p>
            </div>
            <div class="form-group">
                <label for="role_code"><strong>Role code:</strong></label>
                <p id="role_code">' . $res[10] . '</p>
            </div>
            <div class="form-group">
                <label for="status"><strong>Status:</strong></label>
                <p id="status">' . $res[9] . '</p>
            </div>
        </div>
    ';
}
// (SELECT count(*) FROM ects_core.user_roles where user_id = u.user_id)
if (isset($_POST['settb'])) {
    $sql = "SELECT user_id, username, group_concat(distinct ur.role_code) as `NoOfRoles`, org_code, fname, lname, mname, email, contact_no, mobile_no, status,
    concat('<button class=\"btn btn-primary btn-sm\" did=\"',user_id,'\" onclick=\"viewdata(this);\">View data</button>') as `Action`
    FROM ects_core.users u;";
    echo datatb($sql);
}
