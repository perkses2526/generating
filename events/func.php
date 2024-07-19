<?php
require_once '../dbcon.php';

$event_name = $_POST['event_name'] ?? '';
$event_no = $_POST['event_no'] ?? '';
$file_name = $_POST['file_name'] ?? '';
$location = $_POST['location'] ?? '';

if (isset($_POST['savedetails'])) {
    $sql = "UPDATE nlrccms.events
    SET
        eventNo = '$event_no',
        title = '$event_name',
        file = '$file_name',
        location = '$location'
    WHERE
        id = '$did';
";
    echo crud($sql);
}


if (isset($_POST['viewdata'])) {
    $sql = "SELECT id, eventNo, title, file, location
     FROM nlrccms.events
     where id = $did
     ";
    $res = mysqli_fetch_array(execquery($sql));
    echo '
        <input type="hidden" name="did" id="id" value="' . $res[0] . '"> 
        <div class="container">
            <div class="form-group">
                <label for="ID"><strong>ID:</strong></label>
                <p id="ID">' . $res[0] . '</p>
            </div>
            <div class="form-group">
                <label for="event_name"><strong>Event Name:</strong></label>
                <p id="event_name">' . $res[2] . '</p>
            </div>
            <div class="form-group">
                <label for="event_no"><strong>Event No:</strong></label>
                <p id="event_no">' . $res[1] . '</p>
            </div>
            <div class="form-group">
                <label for="file_name"><strong>File name:</strong></label>
                <p id="file_name">' . ($res[3] === "" ? "No location found" : $res[3]) . '</p>
            </div>
            <div class="form-group">
                <label for="location"><strong>Location:</strong></label>
                <p id="location">' . ($res[4] === "" ? "No location found" : $res[4]) . '</p>
            </div>
        </div>
    ';
}

if (isset($_POST['settb'])) {
    $sql = "SELECT id, eventNo, title, file, location,
    concat('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" docket_number=\"', id ,'\">View details</button>') as Action
     FROM nlrccms.events;
    ";
    echo datatb($sql);
}
