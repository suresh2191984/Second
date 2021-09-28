function AddDHEB(ctlDesc, ctlComments, ctlDeleted, ctlTable, ctlValues, ctlExisitingValues, sDescription, sComment) {
    if (document.getElementById(ctlDesc) == null || document.getElementById(ctlDesc).value.trim() == "") {
        alert('Provide a value');
        return false;
    }
    var ctlDesc1 = document.getElementById(ctlDesc).value;
    var ctlComments1 = document.getElementById(ctlComments) == null ? "" : document.getElementById(ctlComments).value;
    var unfretval = ctlDesc1 + "~" + ctlComments1;
    var IsTrue = false;
    if (unfretval != false) {
        IsTrue = unfCmdAdd_onclick(unfretval, ctlDesc, ctlComments, ctlDeleted, ctlTable, ctlValues, ctlExisitingValues, sDescription, sComment);
        unfClearControl(ctlDesc, ctlComments);
    }

    return IsTrue;
}


function unfCmdAdd_onclick(unfgotValue, ctlDesc, ctlComments, ctlDeleted, ctlTable, ctlValues, ctlExisitingValues, sDescription, sComment) {
    var Col1 = sDescription;
    var unfViewStateValue = document.getElementById(ctlValues).value;
    var unfarrayGotValue = new Array();
    unfarrayGotValue = unfgotValue.split('~');
    var ValueName, Comments;

    if (unfarrayGotValue.length > 0) {
        ValueName = unfarrayGotValue[0];
        Comments = unfarrayGotValue[1];
    }

    var unfarrayAlreadyPresentDatas = new Array();
    var unfiAlreadyPresent = 0;
    var unfiCount = 0;
    var unftempDatas = document.getElementById(ctlExisitingValues).value;

    unfarrayAlreadyPresentDatas = unftempDatas.split('|');
    if (unfarrayAlreadyPresentDatas.length > 0) {
        for (unfiCount = 0; unfiCount < unfarrayAlreadyPresentDatas.length; unfiCount++) {
            if (unfarrayAlreadyPresentDatas[unfiCount].toLowerCase() == (ValueName.toLowerCase())) {
                unfiAlreadyPresent++;
            }
        }
    }

    if (unfiAlreadyPresent == 0) {
        unftempDatas += ValueName + "|";
        document.getElementById(ctlExisitingValues).value = unftempDatas;
        unfViewStateValue += "RID^" + 0 + "~VALUENAME^" + ValueName + "~COMMENTS^" + Comments + "|";
        document.getElementById(ctlValues).value = unfViewStateValue;
        unfCreateJavaScriptTables(ctlDesc, ctlComments, ctlDeleted, ctlTable, ctlValues, ctlExisitingValues, sDescription, sComment);

    }
    else {
        alert(' Already exist');
        return false;
    }
    return true;

}

function unfCreateJavaScriptTables(ctlDesc, ctlComments, ctlDeleted, ctlTable, ctlValues, ctlExisitingValues, sDescription, sComment) {
    var Col1 = sDescription;
    var Col2 = sComment;

    document.getElementById(ctlTable).innerHTML = "";
    var unfnewTable, unfstartTag, unfendTag;
    var unfViewStateValue = document.getElementById(ctlValues).value;

    unfstartTag = "<TABLE  ID='tabDrg1' class='gridView w-100p' ><TBODY><tr><td > Select </td><td >" + Col1 + "</td><td >" + Col2 + "</td><TD></TD></tr>";
    unfendTag = "</TBODY></TABLE>";
    unfnewTable = unfstartTag;

    var unfarrayMainData = new Array();
    var unfarraySubData = new Array();
    var unfarrayChildData = new Array();
    var unfiarrayMainDataCount = 0;
    var unfiarraySubDataCount = 0;

    unfarrayMainData = unfViewStateValue.split('|');
    if (unfarrayMainData.length > 0) {
        for (unfiarrayMainDataCount = 0; unfiarrayMainDataCount < unfarrayMainData.length - 1; unfiarrayMainDataCount++) {

            unfarraySubData = unfarrayMainData[unfiarrayMainDataCount].split('~');
            for (unfiarraySubDataCount = 0; unfiarraySubDataCount < unfarraySubData.length; unfiarraySubDataCount++) {
                unfarrayChildData = unfarraySubData[unfiarraySubDataCount].split('^');
                if (unfarrayChildData.length > 0) {
                    if (unfarrayChildData[0] == "VALUENAME") {
                        ValueName = unfarrayChildData[1];
                    }
                    if (unfarrayChildData[0] == "COMMENTS") {
                        Comments = unfarrayChildData[1];
                    }
                }
            }
            var unfchkBoxName = "RID^" + 0 + "~VALUENAME^" + ValueName + "~COMMENTS^" + Comments + "";
            var unfReturnYesOrNo = unfDeletedValueCheck(unfchkBoxName, ctlDeleted);

            //unfbtnEdit_OnClick(unfsEditedData, hdfValues, hdnValueExists, txtDescValue, txtComments, dvTable, hdnValuesDeleted, sDescription, sComment) {
            //                                   ctlValues,ctlExisitingValues,ctlDesc, ctlComments, ctlTable  , ctlDeleted , sDescription, sComment
            var sStr = "";
        
            sStr = "<TD><input name='RID^" + 0 + "~VALUENAME^" + ValueName + "~COMMENTS^" + Comments +
                   "' onclick=unfbtnEdit_OnClick(name,'" + ctlValues + "','" + ctlExisitingValues + "','" + ctlDesc + "','" + ctlComments + "','" + ctlTable + "','" + ctlDeleted + "','" + sDescription + "','" + sComment + "');" +
                   " class ='pointer ui-icon with-out-bkg ui-icon-pencil b-none' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />" +
                   "</TD>";

            //alert(sStr);

            if (unfReturnYesOrNo == "Yes") {
                unfnewTable += "<TR><TD nowrap='nowrap'><input name='RID^" + 0 + "~VALUENAME^" + ValueName + "~COMMENTS^" + Comments + "' onclick=unfchkUnCheck(name,'" + ctlDeleted + "');" + " type='checkbox' /> "
                //        + sStr;
            }
            else {
                unfnewTable += "<TR><TD nowrap='nowrap' ><input name='RID^" + 0 + "~VALUENAME^" + ValueName + "~COMMENTS^" + Comments + "' onclick=unfchkUnCheck(name,'" + ctlDeleted + "');" + " type='checkbox' checked='checked' /> "
                //      + sStr;
            }
            unfnewTable += "</TD><TD Width='50%'>" + ValueName + "</TD>";
            unfnewTable += "<TD >" + Comments + "</TD>";
            unfnewTable += sStr + "</TR>";


        }
    }

    unfnewTable += unfendTag;
    //Update the Previous Table With New Table.
    document.getElementById(ctlTable).innerHTML += unfnewTable;


}
function unfchkUnCheck(unfDataValue, ctlDeleted) {

    var unfarrayAlreadyPresentDatas = new Array();
    var unfiAlreadyPresent = 0;
    var unfiCount = 0;

    var unftempDatas = document.getElementById(ctlDeleted).value;
    var unfboolAlreadyPresent = false;
    unfarrayAlreadyPresentDatas = unftempDatas.split('|');

    if (unfarrayAlreadyPresentDatas.length > 0) {
        for (unfiCount = 0; unfiCount < unfarrayAlreadyPresentDatas.length; unfiCount++) {
            if (unfarrayAlreadyPresentDatas[unfiCount].toLowerCase() == unfDataValue.toLowerCase()) {
                unfarrayAlreadyPresentDatas[unfiCount] = "";
                unfboolAlreadyPresent = true;
            }
        }
    }

    unftempDatas = "";

    for (unfiCount = 0; unfiCount < unfarrayAlreadyPresentDatas.length; unfiCount++) {
        unftempDatas += unfarrayAlreadyPresentDatas[unfiCount] + "|";
    }
    if (unfboolAlreadyPresent == false) {
        unftempDatas += unfDataValue + "|";
    }
    document.getElementById(ctlDeleted).value = unftempDatas;
}

function unfClearControl(sctlDescription, sctlComments) {
    var ctlDesc = document.getElementById(sctlDescription);
    var ctlComments = document.getElementById(sctlComments);
    ctlDesc.value = '';
    ctlComments.value = '';
    ctlDesc.focus();
    return false;
}

function unfDeletedValueCheck(unfDataValue, ctlValues) {
    var unfarrayAlreadyPresentDatas = new Array();
    var unfiAlreadyPresent = 0;
    var unfiCount = 0;
    var unftempDatas = document.getElementById(ctlValues).value;
    var unfretValueAlreadyPresent = "No";

    unfarrayAlreadyPresentDatas = unftempDatas.split('|');
    if (unfarrayAlreadyPresentDatas.length > 0) {
        for (unfiCount = 0; unfiCount < unfarrayAlreadyPresentDatas.length; unfiCount++) {
            if (unfarrayAlreadyPresentDatas[unfiCount].toLowerCase() == unfDataValue.toLowerCase()) {
                unfretValueAlreadyPresent = "Yes";
            }
        }
    }
    return unfretValueAlreadyPresent;
}


function unfbtnEdit_OnClick(unfsEditedData, hdfValues, hdnValueExists, txtDescValue, txtComments, dvTable, hdnValuesDeleted, sDescription, sComment) {
    
    var unfarrayAlreadyPresentDatas = new Array();
    var unfiCount = 0;

    var unftempDatas = document.getElementById(hdfValues).value;
    unfarrayAlreadyPresentDatas = unftempDatas.split('|');
    if (unfarrayAlreadyPresentDatas.length > 0) {
        for (unfiCount = 0; unfiCount < unfarrayAlreadyPresentDatas.length; unfiCount++) {
            if (unfarrayAlreadyPresentDatas[unfiCount].toLowerCase() == unfsEditedData.toLowerCase()) {
                unfarrayAlreadyPresentDatas[unfiCount] = "";
            }
        }
    }

    unftempDatas = "";
    for (unfiCount = 0; unfiCount < unfarrayAlreadyPresentDatas.length; unfiCount++) {
        if (unfarrayAlreadyPresentDatas[unfiCount] != "") {
            unftempDatas += unfarrayAlreadyPresentDatas[unfiCount] + "|";
        }
    }

    var unfarrayGotValue = new Array();
    var unfarrayDesc = new Array();
    var unfComments = new Array();

    unfarrayGotValue = unfsEditedData.split('~');
    var Desc, Comments;

    if (unfarrayGotValue.length > 0) {
        Desc = unfarrayGotValue[1];
        Comments = unfarrayGotValue[2];

        unfarrayDesc = Desc.split('^');
        unfComments = Comments.split('^');
    }

    if (unfarrayDesc.length > 0) {
        document.getElementById(txtDescValue).value = unfarrayDesc[1];
    }
    if (unfComments.length > 0) {
        document.getElementById(txtComments).value = unfComments[1];
    }

    document.getElementById(hdfValues).value = unftempDatas;
    // Delete datas from Drugname Exists Field
    var unftempDatas = document.getElementById(hdnValueExists).value;
    unfarrayAlreadyPresentDatas = null;

    unfarrayAlreadyPresentDatas = unftempDatas.split('|');
    if (unfarrayAlreadyPresentDatas.length > 0) {
        for (unfiCount = 0; unfiCount < unfarrayAlreadyPresentDatas.length; unfiCount++) {
            if (unfarrayAlreadyPresentDatas[unfiCount].toLowerCase() == unfarrayDesc[1].toLowerCase()) {
                unfarrayAlreadyPresentDatas[unfiCount] = "";
            }
        }
    }
    unftempDatas = "";
    for (unfiCount = 0; unfiCount < unfarrayAlreadyPresentDatas.length; unfiCount++) {
        if (unfarrayAlreadyPresentDatas[unfiCount] != "") {
            unftempDatas += unfarrayAlreadyPresentDatas[unfiCount] + "|";
        }
    }
    document.getElementById(hdnValueExists).value = unftempDatas;
    unfCreateJavaScriptTables(txtDescValue, txtComments, hdnValuesDeleted, dvTable, hdfValues, hdnValueExists, sDescription, sComment);
}


