<?php
require_once '../dbcon.php';

$ckid = $_POST['ckid'] ?? '';
$officialsName = $_POST['officialsName'] ?? '';
$position = $_POST['position'] ?? '';
$division = $_POST['division'] ?? '';
$contactNo = $_POST['contactNo'] ?? '';


if (isset($_POST['savedetails'])) {
    $sql = "
    UPDATE nlrccms.contactkeyofficials
    SET
        name = '$officialsName',
        position = '$position',
        division = '$division',
        contactNo = '$contactNo'
    WHERE
        id = '$ckid';
";
    echo crud($sql);
}

if (isset($_POST['setdivision'])) {
    $sql = "SELECT * FROM nlrccms.divisions;";
    echo optiontags($sql);
}

if (isset($_POST['viewdata'])) {
    /*    echo '  
    <div class="container">
        <div class="form-group">
            <label for="officialNo">Official Name</label>
            <input type="text" class="form-control" id="officialNo" name="officialNo" >
        </div>
        <div class="form-group">
            <label for="officialsName">Officials Name</label>
            <input type="text" class="form-control" id="officialsName" name="officialsName" >
        </div>
        <div class="form-group">
            <label for="position">Position</label>
            <input type="text" class="form-control" id="position" name="position" >
        </div>
        <div class="form-group">
            <label for="division">Division</label>
            <input type="text" class="form-control" id="division" name="division" >
        </div>
        <div class="form-group">
            <label for="contactNo">Contact No.</label>
            <input type="text" class="form-control" id="contactNo" name="contactNo" >
        </div>
        <div class="form-group">
            <label for="status">Status</label>
            <input type="text" class="form-control" id="status" name="status" >
        </div>
    </div>'; */

    $sql = "select ck.id, ck.officialNo as `Official name`, ck.name as `Officials name`, ck.position as `Position`, d.name as `Division`, ck.contactNo as `Contact no.`, s.name as `Status`,
    d.id as divid
    from nlrccms.contactkeyofficials ck
    left join nlrccms.divisions d on d.id = ck.division
    left join nlrccms.status s on s.id = ck.status
    where ck.id = '$ckid'";
    $res = mysqli_fetch_array(execquery($sql));

    echo '
        <input type="hidden" name="ckid" id="ckid" value="' . $res[0] . '"> 
        <div class="container">
            <div class="form-group">
                <label for="officialNo"><strong>Official Name:</strong></label>
                <p id="officialNo">' . $res[1] . '</p>
            </div>
            <div class="form-group">
                <label for="officialsName"><strong>Officials Name:</strong></label>
                <p id="officialsName">' . $res[2] . '</p>
            </div>
            <div class="form-group">
                <label for="position"><strong>Position:</strong></label>
                <p id="position">' . $res[3] . '</p>
            </div>
            <div class="form-group">
                <label for="division"><strong>Division:</strong></label>
                <p id="division" divid="' . $res['divid'] . '">' . $res[4] . '</p>
            </div>
            <div class="form-group">
                <label for="contactNo"><strong>Contact No.:</strong></label>
                <p id="contactNo">' . $res[5] . '</p>
            </div>
            <div class="form-group">
                <label for="status"><strong>Status:</strong></label>
                <p id="status">' . $res[6] . '</p>
            </div>
        </div>
';
}

if (isset($_POST['settb'])) {
    $sql = "
    SELECT 
        ck.id, 
        ck.officialNo AS `Official_name`, 
        ck.name AS `Officials_name`, 
        ck.position AS `Position`, 
        d.name AS `Division`, 
        ck.contactNo AS `Contact_no`, 
        s.name AS `Status`,
        CONCAT('<button class=\"btn btn-primary btn-sm\" ckid=\"', ck.id, '\" onclick=\"viewdata(this)\">View details</button>') AS `Action`
    FROM 
        nlrccms.contactkeyofficials ck
    LEFT JOIN 
        nlrccms.divisions d ON d.id = ck.division
    LEFT JOIN 
        nlrccms.status s ON s.id = ck.status
    ";
    echo datatb($sql);
}

if (isset($_POST['setpages'])) {
    $sql = "SELECT count(*) FROM nlrccms.contactkeyofficials where concat(officialNo,name,position,division,contactNo,dateCreated,status,remarks) like '%$search%'";
    echo pages($sql, $entries);
}
