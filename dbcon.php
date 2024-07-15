<?php
session_start();
set_time_limit(10000); // 300 seconds or 5 minutes
ini_set('memory_limit', '10024M'); // Set memory limit to 1GB (adjust as needed)
/* date_default_timezone_set('Asia/Manila'); */
require_once '../vendor/autoload.php';
class DatabaseConnection
{

    /* private $server = '159.138.22.107';
    private $uname = 'nlrc';
    private $pass = '@NLRC2019';
    private $db = 'ects';
 */
    private $server = '139.162.36.162';
    private $uname = 'dbremoteuser';
    private $pass = '.U/CGEf}/cl290thfoCm';
    private $db = 'ects';

    private $con;

    public function __construct()
    {
        try {
            $this->con = @new mysqli($this->server, $this->uname, $this->pass, $this->db);
            mysqli_set_charset($this->con, "utf8mb4");
            if ($this->con->connect_error) {
                throw new Exception("Initial connection failed: " . $this->con->connect_error);
            }
        } catch (Exception $e) {
            /*   
            //online db
            $this->uname = '';
            $this->pass = '';
            $this->db = '';
            $this->con = new mysqli($this->server, $this->uname, $this->pass, $this->db);
 */
            if ($this->con->connect_error) {
                die("Reconnection failed: " . $this->con->connect_error);
            }
        }
    }

    public function getConnection()
    {
        return $this->con;
    }

    public function executeQuery($sql)
    {
        $con = $this->getConnection();

        $result = $con->query($sql);

        if (!$result) {
            die($con->error);
        }

        return $result;
    }

    public function getNewId($sql)
    {
        $con = $this->getConnection();
        $this->executeQuery($sql);
        return $con->insert_id;
    }

    public function getAffectedRows($sql)
    {
        $con = $this->getConnection();
        $this->executeQuery($sql);
        return $con->affected_rows;
    }

    public function executeMultiQuery($sql)
    {
        $con = $this->getConnection();
        $res = $con->multi_query($sql);

        if (!$res) {
            die("Error executing multi-query: " . $con->error);
        }

        return $res;
    }
}

global $db;
$db = new DatabaseConnection();

function execquery($sql)
{
    global $db;
    return $db->executeQuery($sql);
}

function affected($sql)
{
    global $db;
    return $db->getAffectedRows($sql);
}

function getnewid($sql)
{
    global $db;
    return $db->getNewId($sql);
}

function multiquery($sql)
{
    global $db;
    return $db->executeMultiQuery($sql);
}

global $db;
$conn = $db->getConnection();

foreach ($_POST as $key => $value) {
    $_POST[$key] = sanitizeInput($value, $conn);
}

function sanitizeInput($input, $conn)
{
    // If $input is an array, return it without modification
    if (is_array($input)) {
        return $input;
    } else {
        // Validate and sanitize the input
        $input = trim($input);
        // Basic email validation
        if ($input === filter_var($input, FILTER_SANITIZE_EMAIL)) {
            $input = filter_var($input, FILTER_SANITIZE_EMAIL);
        } else {
            $input = $input;
        }
        // Escape the input
        $input = mysqli_real_escape_string($conn, $input);
        return $input;
    }
}


function optiontags($sql, $id = "")
{
    $opt = '';
    $res = execquery($sql);
    if (mysqli_num_rows($res) > 0) {
        while ($row = mysqli_fetch_array($res)) {
            if (isset($row[1])) {
                $opt .= '<option value="' . $row[0] . '" ' . (($row[0] === $id) ? "selected" : "") . '>' . $row[1] . '</option>';
            } else {
                $opt .= '<option value="' . $row[0] . '" ' . (($row[0] === $id) ? "selected" : "") . '>' . $row[0] . '</option>';
            }
        }
    } else {
        $opt = '<option value="" disabled>No Data Found</option>';
    }
    echo $opt;
}

function pages($sql, $entries)
{
    $count = 0;

    if (is_string($sql)) {
        $res = execquery($sql);
        $count = mysqli_fetch_array($res)[0];
    } else {
        $count = $sql;
    }

    $pages = '';
    if ($count > 0) {
        $p = ceil($count / $entries);

        for ($i = 0; $i < $p; $i++) {
            $pages .= '<option value="' . $i . '">' . ($i + 1) . '</option>';
        }
    } else {
        $pages = '<option value="0">0</option>';
    }

    echo $pages;
}

function plarr($cl)
{
    $pls = $_POST;
    $arrk = array_keys($_POST);
    $arr = [];
    for ($i = 0; $i < $cl; $i++) {
        array_push($arr, $pls[$arrk[$i]]);
    }
    return $arr;
}

function createFile($originalFile, $destination)
{
    if (!copy($originalFile, $destination)) {
    } else {
    }
}

function createDirectory($path)
{
    if (!is_dir($path)) {
        if (mkdir($path, 0777, true)) {  // 0777 grants full permissions, but use a more restrictive value in production.
            return "Folder Created";
        } else {
            return "Failed to Create Folder";
        }
    } else {
        return "Folder Already Existing";
    }
}

function nores($colspan)
{
    $d = '
    <tbody>
    <tr>
        <td colspan="' . $colspan . '">No data found</td>
    </tr>
    </tbody>
    ';
    return $d;
}

function sadmin()
{
    if ($_SESSION['usertype'] === "superadmin") {
        return true;
    } else {
        return false;
    }
}

function crud($sql)
{
    $res = affected($sql);
    if ($res > 0) {
        return "success";
    } else {
        return "error";
    }
}




$did = $_POST['did'] ?? '';
$search = $_POST['search'] ?? '';
$entries = $_POST['entries'] ?? '50';
$page = $_POST['page'] ?? '0';
$start_date = $_POST['start_date'] ?? '';
$end_date = $_POST['end_date'] ?? '';
$case_type_code = $_POST['case_type_code'] ?? [];
$org_code = $_POST['org_code'] ?? [];


function autotb($sql, $autorow = 0)
{
    $tb = '';
    $res = execquery($sql);
    if ($res->num_rows > 0) {
        $data = $res->fetch_all(MYSQLI_ASSOC); // Fetch all results as an associative array

        // Initialize table variable
        if (!empty($data)) {
            $tb .= '<thead><tr>';
            if ($autorow == 1) {
                $tb .= '<th>No.</th>'; // Add the auto-increment column header
            }
            foreach (array_keys($data[0]) as $col) {
                // Convert column name to Sentence case and remove underscores
                $colFormatted = ucwords(str_replace('_', ' ', strtolower($col)));
                $tb .= "<th>{$colFormatted}</th>";
            }
            $tb .= '</tr></thead>';
        }

        $tb .= '<tbody>';
        $autoNum = 1; // Initialize auto-increment number
        foreach ($data as $row) {
            $tb .= '<tr>';
            if ($autorow == 1) {
                $tb .= "<td>{$autoNum}</td>"; // Add the auto-increment number
                $autoNum++; // Increment the auto-increment number
            }
            foreach ($row as $td) {
                $tb .= "<td>{$td}</td>";
            }
            $tb .= '</tr>';
        }
        $tb .= '</tbody>';
    } else {
        $tb .= nores(10);
    }
    return $tb;
}


function datatb($sql)
{
    $data = [];
    $res = execquery($sql);

    // Fetch column names
    $columns = [];
    $fields = $res->fetch_fields();
    foreach ($fields as $field) {
        $columns[] = $field->name;
        /* $colFormatted = ucwords(str_replace('_', ' ', strtolower($field->name)));
        $columns[] = $colFormatted; */
    }

    // Fetch data
    while ($row = $res->fetch_assoc()) {
        $data[] = $row;
    }

    // Return column names and data
    return json_encode(['columns' => $columns, 'data' => $data]);
}
