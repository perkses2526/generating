let timeout;

$(document).ready(function () {
    setInterval(() => {
        $('select.selectize').each(function (i, v) {
            $(v).removeClass('selectize');
            $(v).selectize({
                /* create: true, */ // Allow creating new options
                sortField: 'text', // Sort options alphabetically
                placeholder: 'Select ' + $('label[for="' + $(v).attr('id') + '"]').text(),
                onType: function (str) {
                    // Convert the options to an array
                    var validOptionsArray = Object.values(this.options);
                    // Check if the entered text does not match any existing options
                    var isNoDataFound = !validOptionsArray.some(function (option) {
                        return option.text.toLowerCase().includes(str.toLowerCase());
                    });
                    // Get the dropdown content element
                    var dropdownContent = this.$dropdown_content[0];
                    drop = $(dropdownContent).closest('div.selectize-dropdown');
                    // Remove existing options from the dropdown content
                    if (isNoDataFound) {
                        var noDataOption = $('<div class="option" data-value="">No Data Found</div>');
                        $(dropdownContent).append(noDataOption);
                        $(drop).show();
                    }
                }
            });
            if ($(v).hasClass('sf')) {
                selectize = $(v)[0].selectize;
                var foption = Object.values(selectize.options)[0];
                selectize.setValue(foption.value);
            }
        });
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            $(tooltipTriggerEl).removeAttr('data-bs-toggle');
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    }, 500);

    $('.closemodal').click(function () {
        closeModal();
    });

    setTimeout(() => {
        var currentUrl = window.location.href;

        // Extract the last segment from the URL
        var segments = currentUrl.split('/').filter(Boolean);
        var folderName = segments[segments.length - 1];

        // Set the folder name as the page title
        if (folderName) {
            document.title = formatHeaderTitle(folderName);
        }
    }, 500);


});

async function setdatatb(parsedRes, tb = '#maintb') {
    $(tb).html(loadingsm("Fetching data, please wait..."));
    try {
        $(tb).DataTable().clear().destroy();
        $(tb).html("");

        var columns = parsedRes.columns.map(column => ({ title: formatHeaderTitle(column), data: column }));
        var data = parsedRes.data;

        // Calculate lengthMenu options based on the number of records
        var numRecords = data.length;
        var lengthMenu = [];
        var step = 10; // Starting step size for the menu
        for (var i = step; i < numRecords; i += step) {
            lengthMenu.push(i);
        }
        lengthMenu.push(numRecords, -1); // Add the total number of records and "All" option
        var lengthMenuLabels = lengthMenu.slice(0, -1).concat(["All"]);

        // Create a new header with search inputs
        var header = '<tr>';
        columns.forEach(col => {
            header += `<th></th>`;
        });
        header += '</tr>';

        // Initialize DataTable with the received data and columns
        var dataTable = $(tb).DataTable({
            data: data,
            columns: columns,
            pageLength: 100, // Default number of rows to display
            lengthMenu: [lengthMenu, lengthMenuLabels], // Automated lengthMenu options
            orderCellsTop: true,
            fixedHeader: true,
            initComplete: function () {
                $('thead').append(header);
                var api = this.api();
                api.columns().eq(0).each(function (colIdx) {
                    var cell = $('thead tr:eq(0) th').eq(colIdx);
                    var cell1 = $('thead tr:eq(1) th').eq(colIdx);
                    var title = $(cell).text();
                    if (title !== 'Action') { // Exclude 'Action' column from adding search inputs
                        var trnew = `<input type="text" class="form-control form-control-sm column-search" placeholder="Search ${formatHeaderTitle(title)}" />`;
                        $(cell1).html(`${trnew}`);

                        // On every keypress in this input
                        $('input', cell1).off('keyup change').on('keyup change', function (e) {
                            e.stopPropagation();

                            // Get the search value
                            $(this).attr('title', $(this).val());
                            var regexr = '({search})'; // alternative: {search} OR {search}

                            var cursorPosition = this.selectionStart;
                            // Search the column for that value
                            api.column(colIdx).search(
                                this.value != ''
                                    ? regexr.replace('{search}', '(((' + this.value + ')))')
                                    : '',
                                this.value != '',
                                this.value == ''
                            ).draw();

                            $(this).focus()[0].setSelectionRange(cursorPosition, cursorPosition);
                        });
                    }
                });
            }
        });
        hgfunc($(tb).find('tbody').find('tr').find('td'));
    } catch (error) {
        console.error('Error fetching data:', error);
        twarning('An error occurred while fetching the data.');
    }
}

// paul new funcs

$(document).ready(function () {
    var currentUrl = window.location.href;
    var navLinks = document.getElementsByClassName("nav-link");
    for (var i = 0; i < navLinks.length; i++) {
        var linkUrl = navLinks[i].getAttribute("href").replace('../', '');
        if (currentUrl.includes(linkUrl)) {
            navLinks[i].classList.add("active");
            navLinks[i].classList.remove("collapsed");
            var parentUl = navLinks[i].closest("ul");
            if (parentUl && parentUl.classList.contains("collapse")) {
                parentUl.classList.add("show");
                parentUl.previousElementSibling.classList.remove("collapsed");
            }
            break;
        }
    }
});

function show_progress() {
    $('#progressBar').css('width', '0%').attr('aria-valuenow', 0);
    $('#progressToast').show();
    $('#progressToast').find('span').html('0%');
}
function up_progress(percentage) {
    $('#progressBar').css('width', percentage + '%').attr('aria-valuenow', percentage);
    $('#progressToast').find('span').html(percentage + '%');
}

function hide_progress() {
    setTimeout(function () {
        $('#progressToast').hide();
    }, 3000);
}

function showpass(btn) {
    ipt = $(btn).parent().find('input')
    t = $(ipt).attr('type');
    if (t === 'password') {
        ipt.attr('type', 'text');
        $(btn).find('i').removeClass('bi-eye').addClass('bi-eye-slash');
    } else {
        ipt.attr('type', 'password');
        $(btn).find('i').removeClass('bi-eye-slash').addClass('bi-eye');
    }
}


// paul new funcs



function isElem(data) {
    return (data instanceof jQuery || data instanceof HTMLElement);
}

function formatHeaderTitle(str) {
    // Convert camelCase to space-separated words
    str = str.replace(/([a-z])([A-Z])/g, '$1 $2');
    // Convert snake_case to space-separated words
    str = str.replace(/_/g, ' ');
    // Capitalize the first letter of each word
    return str.replace(/\b\w/g, function (match) {
        return match.toUpperCase();
    });
}

$("button.next,button.prev,button.nextbtn, button.prevbtn").click(function (e) {
    e.preventDefault();
    p = $("#page");
    l = $(p).find('option').length;
    s = $(p).prop('selectedIndex');
    if ($(this).hasClass('next')) {
        if (s != (l - 1)) {
            s++;
            $(p).prop('selectedIndex', s);
            settb();
        } else {
            reqfunc(p);
        }
    }
    if ($(this).hasClass('prev')) {
        if (s != 0) {
            s--;
            $(p).prop('selectedIndex', s);
            settb();
        } else {
            reqfunc(p);
        }
    }
});


async function setfilter(elem, val = '') {
    var fd = new FormData();
    if (val !== "") {
        fd.append('val', val);
    }
    fd.append('set' + elem, '');
    var res = await myajax(file, fd);
    $("#" + elem).html(res);
}

function getValue(data, name) {
    const item = data.find(item => item.name === name);
    return item ? item.value : '';
}

function settbsort() {
    $('th').click(function () {
        sortTable($(this));
    });
}

function sortTable(th) {
    var columnIndex = th.index();
    var table = th.closest('table');
    var rows = table.find("tbody > tr").toArray(); // Convert to an array for faster sorting
    var isAscending = th.hasClass("asc");

    table.find("th").removeClass("asc desc");

    if (isAscending) {
        th.addClass("desc");
    } else {
        th.addClass("asc");
    }

    rows.sort(function (a, b) {
        var x = a.cells[columnIndex].textContent.toLowerCase();
        var y = b.cells[columnIndex].textContent.toLowerCase();
        return isAscending ? (x.localeCompare(y)) : (y.localeCompare(x));
    });

    // Append sorted rows back to the table
    $.each(rows, function (index, row) {
        table.children('tbody').append(row);
    });
}

function question(title, text) {
    return new Promise((resolve) => {
        Swal.fire({
            title: title,
            text: text,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes'
        }).then((result) => {
            if (result.isConfirmed) {
                resolve(true);
            } else {
                resolve(false);
            }
        });
    });
}

function setselect(sel, res) {
    setTimeout(() => {
        var optionobj = [];
        var val = '';
        $(res).each(function (i, v) {
            var isSelected = $(v).prop("selected");
            var isDisabled = $(v).prop("disabled");
            val = isSelected && !isDisabled ? $(v).val() : val;
            optionobj.push({
                value: $(v).val(),
                text: $(v).text(),
                disabled: isDisabled // Set the disabled property for the option
            });
        });
        $(sel)[0].selectize.clearOptions();
        $(sel)[0].selectize.addOption(optionobj);
        $(sel)[0].selectize.setValue(val);
    }, 500);
}

function setDocTitle(titles) {
    document.title = titles;
}

function tsuccess(texts, sec = 3) {
    toast('success', 'Successful', texts, sec);
}

function terror(texts = `There's something wrong, please try again.`, sec = 3) {
    toast('error', 'Error', texts, sec);
}

function twarning(texts, sec = 3) {
    toast('warning', 'Warning', texts, sec);
}

function ttimer(titles, sec = 3) {
    let timerInterval
    Swal.fire({
        title: titles,
        timer: (sec * 1000),
        timerProgressBar: true,
        didOpen: () => {
            Swal.showLoading()
            const b = Swal.getHtmlContainer().querySelector('b')
            timerInterval = setInterval(() => {
                b.textContent = Swal.getTimerLeft()
            }, 100)
        },
        willClose: () => {
            clearInterval(timerInterval)
        }
    });
}

function toast(icons, titles, texts, sec) {
    Swal.fire({
        icon: icons,
        title: titles,
        html: texts,
        timer: (sec * 1000),
        showConfirmButton: false,
        showClass: {
            popup: 'animate__animated animate__fadeInDown'
        },
        hideClass: {
            popup: 'animate__animated animate__fadeOutUp'
        }
    })
}

function hhtr(btn) {
    $('#maintb tr, #modaltb tr').find('td').removeClass('bg-warning').removeClass('opacity-50');
    $(btn).closest('tr').find('td').addClass('bg-warning opacity-50');
}


function getFileNameFromURL(url) {
    var segments = url.split('/');
    var filename = segments[segments.length - 1];
    return filename;
}

function rqtoast(elem, texts, sec = 3) {
    reqfunc(elem)
    twarning(texts, sec);
}

function reqfunctwtoast(elem, texts, sec = 3) {
    reqfunc(elem)
    twarning(texts, sec);
}

function datatable_to_excel(tableId, fileName = $('#' + tableId).attr('id')) {
    var table = $('#' + tableId).DataTable();
    var data = table.rows({ search: 'applied' }).data().toArray();

    var workbook = XLSX.utils.book_new();
    var sheetData = [];

    // Extract headers
    var headers = [];
    table.columns().header().each(function (header) {
        headers.push($(header).text().trim());
    });
    sheetData.push(headers); // Add headers to sheetData

    // Convert each row to an array and add to sheetData
    data.forEach(function (rowData) {
        var rowArray = [];
        Object.values(rowData).forEach(function (cellData) {
            rowArray.push(cellData);
        });
        sheetData.push(rowArray);
    });

    var sheet = XLSX.utils.aoa_to_sheet(sheetData);
    XLSX.utils.book_append_sheet(workbook, sheet, "Sheet1");
    XLSX.writeFile(workbook, fileName + '.xlsx');
}

function htmltb_to_excel(tbid, name = tbid) {
    var name = $("#tbtitle").html();
    name = ((name == "" || name == undefined) ? tbid : name);
    var data = document.getElementById(tbid).cloneNode(true);
    elems = $(data).find('.hideelem');
    links = $(data).find('a');
    var head = $(data).find('thead');
    $.each(links, function (i, v) {
        var l = $(v).attr('href');
        var p = $(v).parent();
        $(p).html(l);
    });
    $.each(head, function (i, v) {
        var thcnt = $(v).contents();
        $(v).replaceWith(thcnt);
    });
    var bdy = $(data).find('tbody');
    $.each(bdy, function (i, v) {
        var bdycnt = $(v).contents();
        $(v).replaceWith(bdycnt);
    });

    $(elems).remove();
    var file = XLSX.utils.table_to_book(data, {
        sheet: "Schedule",
        raw: false
    });

    XLSX.write(file, {
        bookType: 'xlsx',
        bookSST: true,
        type: 'base64'
    });

    XLSX.writeFile(file, name + '.xlsx');

}

function printDiv(id) {
    var divToPrint = document.getElementById(id).innerHTML;

    var newWin = window.open('', 'Print-Window');

    newWin.document.open();

    newWin.document.write(`<html>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
    @media print {
        .pagebreak { page-break-before: always; } /* page-break-after works, as well */
    }
    </style>

    <body onload="window.print();" class="bg-white m-3">` + divToPrint + `</body>
    <script src="../jq.js">
    </script>
    <script>
        $(".hideelem").each(function(i,v){
            $(v).hide();
        });
        setTimeout(() => {
            window.close();
        }, 500);
    </script>
    </html>`);

    newWin.document.close();

}

function checkall(elem) {
    var isChecked = $(elem).prop('checked');
    var tb = $(elem).closest('table');
    tb.find('tbody input[type="checkbox"]').prop('checked', isChecked);
}


function setCheckbox(element) {
    if ($(element).is(':checkbox')) {
        $(element).prop('checked', !$(element).prop('checked'));
    } else if ($(element).is('tr')) {
        var checkbox = $(element).find('input:checkbox');
        checkbox.prop('checked', !checkbox.prop('checked'));
    } else if ($(element).is('td')) {
        element = $(element).closest('tr');
        var checkbox = $(element).find('input:checkbox');
        checkbox.prop('checked', !checkbox.prop('checked'));
    }
}

function validator(elems) {
    var isValid = true;
    // Loop through all required inputs and selects
    $(elems).each(function () {
        // Check if the element is an input/select/textarea
        if ($(this).is('input, select, textarea')) {
            var inputValue = $(this).val();
            if (Array.isArray(inputValue)) {
                // If the value is an array, check its length
                if (inputValue.length === 0) {
                    elemid = $(this).attr('id');
                    txt = $('label[for="' + elemid + '"]').text();
                    //terror(txt + ' Is Required', 3);
                    reqfunc($(this));
                    isValid = false;
                    return false; // Break out of loop if any required input is empty
                }
            } else if (typeof inputValue === 'string' && inputValue.trim() === '') {
                // Check if input value is empty or whitespace
                elemid = $(this).attr('id');
                txt = $('label[for="' + elemid + '"]').text();
                //terror(txt + ' Is Required', 3);
                reqfunc($(this));
                isValid = false;
                return false; // Break out of loop if any required input is empty
            }
            // Check if input value length is within minimum and maximum length
            var minLength = $(this).attr("minlength");
            var maxLength = $(this).attr("maxlength");
            if (minLength && inputValue.length < minLength) {
                elemid = $(this).attr('id');
                txt = $('label[for="' + elemid + '"]').text();
                //terror(txt + " must be at least " + minLength + " characters long.", 3);
                reqfunc($(this));
                isValid = false;
                return false; // Break out of loop if any input length is less than minimum
            }
            if (maxLength && inputValue.length > maxLength) {
                elemid = $(this).attr('id');
                txt = $('label[for="' + elemid + '"]').text();
                //terror(txt + " must be more than " + maxLength + " characters long.", 3);
                reqfunc($(this));
                isValid = false;
                return false; // Break out of loop if any input length is more than maximum
            }

            // Check if input value is an email
            if ($(this).attr("type") === "email") {
                if (!validateEmail(inputValue)) {
                    elemid = $(this).attr('id');
                    txt = $('label[for="' + elemid + '"]').text();
                    //terror(txt + " must be a valid email address.", 3);
                    reqfunc($(this));
                    isValid = false;
                    return false; // Break out of loop if any input value is not a valid email
                }
            }

            // Check if input value is within the specified minimum and maximum values (for input type="number")
            if ($(this).attr("type") === "number") {
                var minValue = $(this).attr("min");
                var maxValue = $(this).attr("max");
                var value = parseFloat(inputValue);

                if (minValue && value < parseFloat(minValue)) {
                    elemid = $(this).attr('id');
                    txt = $('label[for="' + elemid + '"]').text();
                    // terror(txt + " must be at least " + minValue + ".", 3);
                    reqfunc($(this));
                    isValid = false;
                    return false; // Break out of loop if any input value is less than the minimum
                }

                if (maxValue && value > parseFloat(maxValue)) {
                    elemid = $(this).attr('id');
                    txt = $('label[for="' + elemid + '"]').text();
                    //terror(txt + " must be less than or equal to " + maxValue + ".", 3);
                    reqfunc($(this));
                    isValid = false;
                    return false; // Break out of loop if any input value is greater than the maximum
                }
            }
        }
    });
    return isValid;
}

// Function to validate email format
function validateEmail(email) {
    var re = /\S+@\S+\.\S+/;
    return re.test(email);
}

/* function reqfunc(elem) {
    dp = '';
    if (elem.hasClass("selectized")) {
        $(elem).closest('div').find('div.selectize-input').addClass('border border-danger');
        setTimeout(() => {
            $(elem).closest('div').find('div.selectize-input').removeClass('border border-danger');
        }, 3000);
    } else {
        $(elem).addClass('bg-danger bg-opacity-50');
        setTimeout(() => {
            $(elem).removeClass('bg-danger bg-opacity-50');
        }, 3000);
    }
} */

function hgfunc(elem) {
    let $input = $(elem).closest('div').find('div.selectize-input');
    if (elem.hasClass("selectized")) {
        $input.addClass('border border-success');
        setTimeout(() => {
            $input.removeClass('border border-success');
        }, 3000);
    } else {
        $(elem).addClass('bg-success bg-opacity-50');
        setTimeout(() => {
            $(elem).removeClass('bg-success bg-opacity-50');
        }, 3000);
    }
}


function reqfunc(elem) {
    let $input = $(elem).closest('div').find('div.selectize-input');
    if (elem.hasClass("selectized")) {
        $input.addClass('border border-danger');
        setTimeout(() => {
            $input.removeClass('border border-danger');
        }, 3000);
    } else {
        $(elem).addClass('bg-danger bg-opacity-50');
        setTimeout(() => {
            $(elem).removeClass('bg-danger bg-opacity-50');
        }, 3000);
    }
}


function loadingsm(msg = "") {
    return `<span class=" fs-6">` + msg + `</span><div class="spinner-border spinner-border-sm text-success" id="l" role="status"></div>`;
}

async function myajax(url, formData) {
    try {
        const response = await $.ajax({
            url: url,
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
        });
        return response.trim();
    } catch (error) {
        console.log('Error: ' + error.statusText);
        return "";
    }
}

function format12hr(timeStr) {
    const time = new Date("2000-01-01 " + timeStr);
    return time.toLocaleTimeString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true });
}

function addslashes(str) {
    return str.replace(/'/g, "\\'").replace(/"/g, '\\"');
}

function formatDateToYMD(date) {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0'); // Adding 1 to month because months are zero-based
    const day = String(date.getDate()).padStart(2, '0');

    return `${year}-${month}-${day}`;
}

function getDayNameFromDate(date) {
    const daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    return daysOfWeek[date.getDay()];
}

function modallg(title, body) {
    setViewModal(title, 'lg', body);
}

function modalxl(title, body) {
    setViewModal(title, 'xl', body);
}

function modalmd(title, body) {
    setViewModal(title, 'md', body);
}

function setViewModal(title, size, body) {
    $('#modalDialog').removeClass().addClass("modal-dialog modal-" + size);
    $('#modalTitle').html(title);
    $('#modalBody').html(body);
    $('#modal').modal('show');
}

function closeModal() {
    $('#modal').modal('hide');
    $('#btn_submit').html('');
    $('#maintb tr, #modaltb tr').find('td').removeClass('bg-warning').removeClass('opacity-50');
}