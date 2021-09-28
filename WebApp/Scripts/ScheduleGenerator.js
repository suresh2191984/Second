var ddlStat;
var gvscResult;
function GenerateTemplate(ddlID,gvResult, ResourceID, ReasourceType) {
    ddlStat = ddlID;
    gvscResult = gvResult;
    WebService.loadWebScheduleDetail(ResourceID, ReasourceType, GenerateSchedules);
}

function GenerateSchedules(tmpVal) {
    var sVal = '';
    var ddllength = tmpVal.length;
    if (tmpVal[ddllength - 1].Description == "RES") {
        BindDDlSchedules(tmpVal[ddllength - 1].SchedulableResource);
        BindGrid(tmpVal);
    }
}

function BindGrid(gvList) {

    while (count = document.getElementById(gvscResult).rows.length) {

        for (var j = 0; j < document.getElementById(gvscResult).rows.length; j++) {
            document.getElementById(gvscResult).deleteRow(j);
        }
    }

    var Headrow = document.getElementById(gvscResult).insertRow(0);
    Headrow.id = "HeadID";
    Headrow.style.backgroundColor = "#2c88b1";
    Headrow.style.fontWeight = "bold";
    Headrow.style.color = "#FFFFFF";
    var cell1 = Headrow.insertCell(0);
    var cell2 = Headrow.insertCell(1);
    var cell3 = Headrow.insertCell(2);
    var cell4 = Headrow.insertCell(3);
    var cell5 = Headrow.insertCell(4);
    var cell6 = Headrow.insertCell(5);
    cell1.innerHTML = "Select";
    cell2.innerHTML = "Tocken No";
    cell3.innerHTML = "Description";
    cell4.innerHTML = "Patient Name";
    cell5.innerHTML = "Patient No.";
    cell6.innerHTML = "Phone";

    for (i = 0; i < gvList.length; i++) {
        if (gvList[i].Description != "RES") {
            var row = document.getElementById(gvscResult).insertRow(1);
            row.style.height = "13px";
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            cell1.innerHTML = "<input type='radio' onclick='onSelectRow(this.id)' runat='server' id='Slot--" + gvList[i].TokenNumber + "' />";
            cell2.innerHTML = gvList[i].TokenNumber;
            cell3.innerHTML = gvList[i].Description;
            cell4.innerHTML = gvList[i].PatientName;
            cell5.innerHTML = gvList[i].PatientNumber;
            cell6.innerHTML = gvList[i].PhoneNumber;
        }
    }
}

function onSelectRow(rid) {
    chosen = "";

    var len = document.forms[0].elements.length;
    for (var i = 0; i < len; i++) {
        if (document.forms[0].elements[i].type == "radio") {
            if (document.forms[0].elements[i].id.split('--')[0] == "Slot") {
                document.forms[0].elements[i].checked = false;
            }
        }
    }
    document.getElementById(rid).checked = true;
}

function BindDDlSchedules(ddllist) {
        var flag = true;
        ddlStat.options.length = 0;
        var ddlid = ddlStat.id;
        for (var count = 0; count < ddllist.length; count++) {
            
            var opt = document.createElement("option");

            document.getElementById(ddlid).options.add(opt);
            opt.value = ddllist[count].ComplaintDesc;
            opt.text = ddllist[count].ComplaintName;
         }
  }

   