<?php
require_once '../dbcon.php';

$t = $_POST['t'] ?? '';

if (isset($_POST['viewdata'])) {
    echo "";
}

if (isset($_POST['search_data'])) {
    $sql = "";
    if ($t === "1") {
        $sql = "SELECT
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" docket_number=\"', d.docket_id ,'\" attrs=\"docket_archives\">',(SELECT COUNT(*) FROM docket_archives WHERE docket_id = d.docket_id), '</button>') as docket_archives,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" docket_number=\"', d.docket_id ,'\" attrs=\"docket_comments\">',(SELECT COUNT(*) FROM docket_comments WHERE docket_id = d.docket_id), '</button>') as docket_comments,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" docket_number=\"', d.docket_id ,'\" attrs=\"docket_decision\">',(SELECT COUNT(*) FROM docket_decision WHERE docket_id = d.docket_id), '</button>') as docket_decision,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" docket_number=\"', d.docket_id ,'\" attrs=\"docket_disposition\">',(SELECT COUNT(*) FROM docket_disposition WHERE docket_id = d.docket_id), '</button>') as docket_disposition,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" docket_number=\"', d.docket_id ,'\" attrs=\"docket_entry_finality\">',(SELECT COUNT(*) FROM docket_entry_finality WHERE docket_id = d.docket_id), '</button>') as docket_entry_finality,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" docket_number=\"', d.docket_id ,'\" attrs=\"docket_orgs\">',(SELECT COUNT(*) FROM docket_orgs WHERE docket_id = d.docket_id), '</button>') as docket_orgs,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" docket_number=\"', d.docket_id ,'\" attrs=\"docket_reassignment\">',(SELECT COUNT(*) FROM docket_reassignment WHERE docket_id = d.docket_id), '</button>') as docket_reassignment,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" docket_number=\"', d.docket_id ,'\" attrs=\"docket_subledgers\">',(SELECT COUNT(*) FROM docket_subledgers WHERE docket_id = d.docket_id), '</button>') as docket_subledgers,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" docket_number=\"', d.docket_id ,'\" attrs=\"docket_tasks\">',(SELECT COUNT(*) FROM docket_tasks WHERE docket_id = d.docket_id), '</button>') as docket_tasks,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" docket_number=\"', d.docket_id ,'\" attrs=\"docket_transfer\">',(SELECT COUNT(*) FROM docket_transfer WHERE docket_id = d.docket_id), '</button>') as docket_transfer,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" docket_number=\"', d.docket_id ,'\" attrs=\"docket_tro_of_exec\">',(SELECT COUNT(*) FROM docket_tro_of_exec WHERE docket_id = d.docket_id), '</button>') as docket_tro_of_exec,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" docket_number=\"', d.docket_id ,'\" attrs=\"docket_writ_of_exec\">',(SELECT COUNT(*) FROM docket_writ_of_exec WHERE docket_id = d.docket_id), '</button>') as docket_writ_of_exec
        FROM dockets d where d.docket_number = '$val';";
    } else if ($t === "2") {
        $sql = "SELECT
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" case_id=\"', c.case_id ,'\" attrs=\"case_action_causes\">',(SELECT COUNT(*) FROM case_action_causes WHERE case_id = c.case_id), '</button>') as case_action_causes,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" case_id=\"', c.case_id ,'\" attrs=\"case_appeals\">',(SELECT COUNT(*) FROM case_appeals WHERE case_id = c.case_id), '</button>') as case_appeals,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" case_id=\"', c.case_id ,'\" attrs=\"case_counsels\">',(SELECT COUNT(*) FROM case_counsels WHERE case_id = c.case_id), '</button>') as case_counsels,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" case_id=\"', c.case_id ,'\" attrs=\"case_grievances\">',(SELECT COUNT(*) FROM case_grievances WHERE case_id = c.case_id), '</button>') as case_grievances,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" case_id=\"', c.case_id ,'\" attrs=\"case_legal\">',(SELECT COUNT(*) FROM case_legal WHERE case_id = c.case_id), '</button>') as case_legal,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" case_id=\"', c.case_id ,'\" attrs=\"case_legal_parties\">',(SELECT COUNT(*) FROM case_legal_parties WHERE case_id = c.case_id), '</button>') as case_legal_parties,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" case_id=\"', c.case_id ,'\" attrs=\"case_parties\">',(SELECT COUNT(*) FROM case_parties WHERE case_id = c.case_id), '</button>') as case_parties,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" case_id=\"', c.case_id ,'\" attrs=\"case_petitions\">',(SELECT COUNT(*) FROM case_petitions WHERE case_id = c.case_id), '</button>') as case_petitions,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" case_id=\"', c.case_id ,'\" attrs=\"case_referrals\">',(SELECT COUNT(*) FROM case_referrals WHERE case_id = c.case_id), '</button>') as case_referrals,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" case_id=\"', c.case_id ,'\" attrs=\"case_reliefs\">',(SELECT COUNT(*) FROM case_reliefs WHERE case_id = c.case_id), '</button>') as case_reliefs,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" case_id=\"', c.case_id ,'\" attrs=\"docket_decision\">',(SELECT COUNT(*) FROM docket_decision WHERE case_id = c.case_id), '</button>') as docket_decision,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" case_id=\"', c.case_id ,'\" attrs=\"docket_task_documents\">',(SELECT COUNT(*) FROM docket_task_documents WHERE case_id = c.case_id), '</button>') as docket_task_documents,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" case_id=\"', c.case_id ,'\" attrs=\"hist_case_parties\">',(SELECT COUNT(*) FROM hist_case_parties WHERE case_id = c.case_id), '</button>') as hist_case_parties,
        CONCAT('<button class=\"btn btn-primary btn-sm\" onclick=\"viewdata(this)\" case_id=\"', c.case_id ,'\" attrs=\"hist_cases\">',(SELECT COUNT(*) FROM hist_cases WHERE case_id = c.case_id), '</button>') as hist_cases
        from cases c where c.docket_number = '$val';";
    }

    echo datatb($sql);
}
