<?php
require_once '../dbcon.php';
/* 
if (isset($_POST['setnewuser'])) {
    echo '
    <div class="container">
        <div class="form-group">
            <label for="username"><strong>Username:</strong></label>
            <input type="text" class="form-control form-control-sm" id="username" name="username" placeholder="Username:">
        </div>
        <div class="form-group">
            <label for="org_code"><strong>Org code</strong></label>
            <select class="selectize" id="org_code" name="org_code">
                <option value="" selected>org code</option>
                <option value="CAR">CAR</option>
                <option value="FIRST">FIRST</option>
                <option value="FOURTH">FOURTH</option>
                <option value="NCR">NCR</option>
                <option value="RABI">RABI</option>
                <option value="RABII">RABII</option>
                <option value="RABIII">RABIII</option>
                <option value="RABIII-SO">RABIII-SO</option>
                <option value="RABIV">RABIV</option>
                <option value="RABIV-BA">RABIV-BA</option>
                <option value="RABIX">RABIX</option>
                <option value="RABV">RABV</option>
                <option value="RABVI">RABVI</option>
                <option value="RABVII">RABVII</option>
                <option value="RABVIII">RABVIII</option>
                <option value="RABX">RABX</option>
                <option value="RABX-BUK">RABX-BUK</option>
                <option value="RABXI">RABXI</option>
                <option value="RABXI-DC">RABXI-DC</option>
                <option value="RABXI-TC">RABXI-TC</option>
                <option value="RABXII">RABXII</option>
                <option value="RABXII-KD">RABXII-KD</option>
                <option value="RABXIII">RABXIII</option>
                <option value="SIXTH">SIXTH</option>
                <option value="SRABI">SRABI</option>
                <option value="SRABIV">SRABIV</option>
                <option value="SRABIX">SRABIX</option>
                <option value="SRABV">SRABV</option>
                <option value="SRABVI">SRABVI</option>
                <option value="SRABVIA">SRABVIA</option>
                <option value="SRABVII">SRABVII</option>
                <option value="SRABX">SRABX</option>
                <option value="SRABXII">SRABXII</option>
                <option value="SRABXIIC">SRABXIIC</option>            
            </select>
        </div>
        <div class="form-group">
            <label for="fname"><strong>First name:</strong></label>
            <input type="text" class="form-control form-control-sm" id="fname" name="fname" placeholder="First name:">
        </div>
        <div class="form-group">
            <label for="mname"><strong>Middle name:</strong></label>
            <input type="text" class="form-control form-control-sm" id="mname" name="mname" placeholder="Middle name:">
        </div>
        <div class="form-group">
            <label for="lname"><strong>Last name:</strong></label>
            <input type="text" class="form-control form-control-sm" id="lname" name="lname" placeholder="Last name:">
        </div>
        <div class="form-group">
            <label for="email"><strong>Email:</strong></label>
            <input type="text" class="form-control form-control-sm" id="email" name="email" placeholder="Email:">
        </div>
        <div class="form-group">
            <label for="contact_no"><strong>Contact No:</strong></label>
            <input type="text" class="form-control form-control-sm" id="contact_no" name="contact_no" placeholder="Contact No:">
        </div>
         <div class="form-group">
            <label for="mobile_no"><strong>Mobile no:</strong></label>
            <input type="text" class="form-control form-control-sm" id="mobile_no" name="mobile_no" placeholder="Mobile no:">
        </div>
    </div>
';
}

 */
/* 
if (isset($_POST['viewdata'])) {
    $sql = "SELECT 
    u.user_id, 
    u.username, 
    u.org_code, 
    u.fname, 
    u.lname, 
    u.mname, 
    u.email, 
    u.contact_no, 
    u.mobile_no, 
    u.status, 
    GROUP_CONCAT(DISTINCT ur.role_code) AS role_codes, 
    u.created_date,
    -- Aggregate counts directly within the main query
    COUNT(DISTINCT CASE WHEN c.case_type_code = 'RFA' AND dd.date_disposed IS NULL THEN c.docket_number END) AS pendingrfa,
    COUNT(DISTINCT CASE WHEN c.case_type_code = 'CASE' AND dd.date_disposed IS NULL THEN c.docket_number END) AS pendingcases,
    COUNT(DISTINCT CASE WHEN c.case_type_code = 'RFA' THEN c.docket_number END) AS totalrfa, 
    COUNT(DISTINCT CASE WHEN c.case_type_code = 'CASE' THEN c.docket_number END) AS totalcases
FROM 
    ects_core.users u 
    JOIN ects_core.user_roles ur ON u.user_id = ur.user_id
    LEFT JOIN cases c ON c.process_by = u.user_id
    left join (
        select bb.* 
        from docket_disposition as bb 
        inner join (
            select docket_id, min(disposition_id) as MaxDate 
            from docket_disposition 
            group by docket_id
        ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDate
    ) as dd on dd.docket_id = c.docket_id
WHERE 
    u.user_id = '$did'
GROUP BY 
    u.user_id, u.username, u.org_code, u.fname, u.lname, u.mname, u.email, u.contact_no, u.mobile_no, u.status, u.created_date;

    ;";
    $res = mysqli_fetch_array(execquery($sql));
    echo '
    <input type="hidden" name="did" id="id" value="' . $res[0] . '"> 
    <div class="container">
        <div class="row">
            <div class="col">
                <div class="form-group">
                    <label for="user_id"><strong>User id:</strong></label>
                    <p id="user_id">' . $res[0] . '</p>
                </div>
                <div class="form-group">
                    <label for="username"><strong>FULL Name:</strong></label>
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
                <div class="form-group">
                    <label for="created_date"><strong>Created date:</strong></label>
                    <p id="created_date">' . $res[11] . '</p>
                </div>
            </div>
            <div class="col">
                <div class="form-group">
                    <label for="pendingrfa"><strong>Pending RFA\'s:</strong></label>
                    <p id="pendingrfa">' . $res[12] . '</p>
                </div>
                <div class="form-group">
                    <label for="pendingcases"><strong>Pending Cases:</strong></label>
                    <p id="pendingcases">' . $res[13] . '</p>
                </div>
                <div class="form-group">
                    <label for="totalrfa"><strong>Total RFA\'s:</strong></label>
                    <p id="totalrfa">' . $res[14] . '</p>
                </div>
                <div class="form-group">
                    <label for="totalcases"><strong>Total Cases:</strong></label>
                    <p id="totalcases">' . $res[15] . '</p>
                </div>
            </div>
        </div>
    </div>

    ';
} */
// (SELECT count(*) FROM ects_core.user_roles where user_id = u.user_id)
if (isset($_POST['settb'])) {
    $sql = "SELECT pointer, UAUsername, EMID, UACreatedDate FROM main_nlrc_db.M_UserAccounts;";
  /*   $sql = "SELECT u.user_id, username,
    concat(u.fname, ' ', u.mname, ' ', u.lname) as `Full name`,
    count(distinct ur.role_code) as `NoOfRoles`, org_code, fname, lname, mname, email, contact_no, mobile_no, status, created_date,
    concat('<button class=\"btn btn-primary btn-sm\" did=\"',u.user_id,'\" onclick=\"viewdata(this);\">View data</button>') as `Action`
    FROM ects_core.users u
    join ects_core.user_roles ur on u.user_id = ur.user_id
    group by u.user_id
    ;"; */


    echo datatb($sql);
}
