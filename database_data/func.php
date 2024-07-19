<?php
require_once '../dbcon.php';

if (isset($_POST['viewdata'])) {
    echo "";
}

if (isset($_POST['settb'])) {
    $sql = "SELECT 
        TABLE_SCHEMA, 
        TABLE_NAME, 
        COLUMN_NAME, 
        DATA_TYPE, 
         CASE 
            WHEN IS_NULLABLE = 'YES' THEN 'YES'
            ELSE 'NO'
        END AS IS_NULLABLE,
        CHARACTER_MAXIMUM_LENGTH, 
        NUMERIC_PRECISION, 
        NUMERIC_SCALE 
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = 'ects' OR TABLE_SCHEMA = 'ects_core';
;";
    echo datatb($sql);
}

