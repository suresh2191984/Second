<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HistoPathologyPattern.ascx.cs"
    Inherits="Investigation_HistoPathologyPattern" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="FCKeditorV2" %>
<%--<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>

<script language="javascript" type="text/javascript">
    //InvRemarks
    function SelectedRemarks(source, eventArgs) {
        RemarksDetails = eventArgs.get_value();
        if (document.getElementById('hdnRemarksID') != null) {
            document.getElementById('hdnRemarksID').value = RemarksDetails;
        }
    }
    function GetInvMedicalRemarks(source, eventArgs) {
        RemarksDetails = eventArgs.get_value();
        if (document.getElementById('hdnAppRemarksID') != null) {
            var arrValue = RemarksDetails.split("~");
            document.getElementById('hdnAppRemarksID').value = arrValue[1];
            document.getElementById('hdnInvRemGrpIDList').value = document.getElementById('hdnInvRemGrpIDList').value + RemarksDetails + "^";
        }
    }
    //InvRemarks
    function AddItemsToTableHPP(id) {
        /* Added By Venkatesh S */
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vProcessing = SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_01') == null ? "Please Select Processing Methods" : SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_01');
        var vStaining = SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_02') == null ? "Please Select Staining" : SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_02');
        var splitString = id.split('_');
        document.getElementById(splitString[0] + '_hdnControlID').value = splitString[0];
        var type;
        var ProcessMethods;
        var Staining;
        var AddStatus = 0;
        var rowNumber = 0;
        var HidValue = document.getElementById(splitString[0] + '_hResultvalues').value;
        if (document.getElementById(splitString[0] + '_ddlProcessingMethods').value == "0") {
            //alert('Please Select Processing Methods');
            ValidationWindow(vProcessing, AlertType);
            document.getElementById(splitString[0] + '_ddlProcessingMethods').focus();
            return false;
        }
        if (document.getElementById(splitString[0] + '_ddlStaining').value == "0") {
            //alert('Please Select Staining');
            ValidationWindow(vStaining, AlertType);
            document.getElementById(splitString[0] + '_ddlStaining').focus();
            return false;
        }
        ProcessMethods = document.getElementById(splitString[0] + '_ddlProcessingMethods').options[document.getElementById(splitString[0] + '_ddlProcessingMethods').selectedIndex].text;
        Staining = document.getElementById(splitString[0] + '_ddlStaining').options[document.getElementById(splitString[0] + '_ddlStaining').selectedIndex].text;
        var row = document.getElementById(splitString[0] + '_tblResult').insertRow(1);
        rowNumber = HidValue.split('^').length;
        var rowID = splitString[0] + '_tblResult' + rowNumber;
        row.id = rowID;
        row.style.fontWeight = "normal";
        row.style.fontsize = "10px";
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        document.getElementById(splitString[0] + '_tblResult').style.display = "block";
        //cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + rowID + ");' src='../Images/Delete.jpg' />";
        cell1.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclick(\'" + rowID + "\');\" src=\"../Images/Delete.jpg\" />";
        cell1.width = "5%";
        cell2.innerHTML = ProcessMethods;
        cell2.width = "20%"
        cell3.innerHTML = Staining;
        cell3.width = "20%"
        document.getElementById(splitString[0] + '_hResultvalues').value += "RID:" + rowNumber + "~ProcessMethods:" + ProcessMethods + "~Staining:" + Staining + "^";
        document.getElementById(splitString[0] + '_ddlProcessingMethods').value = "0";
        document.getElementById(splitString[0] + '_ddlStaining').value = "0";
        return false;
    }
    function AddClinicalNotes(id) {
//        debugger;
        var splitString = id.split('_');
        document.getElementById(splitString[0] + '_hdnControlID').value = splitString[0];
        var type;
        var ClinicalNotes;
        var AddStatus = 0;
        var rowNumber = 0;
        var HidValue = document.getElementById(splitString[0] + '_hdnClinicalNotes').value;
        if (document.getElementById(splitString[0] + '_txtClinicalNotes').value == "") {
            alert('Please Select Clinical Notes');
            document.getElementById(splitString[0] + '_txtClinicalNotes').focus();
            return false;
        }
        ClinicalNotes = document.getElementById(splitString[0] + '_txtClinicalNotes').value;
        if (HidValue != '') {
            rowNumber = HidValue.split(',').length;
        }
        document.getElementById(splitString[0] + '_tdClinicalNotes').style.display = "block";
        
        if (document.getElementById(splitString[0] + '_hdnClinicalNotes').value == '') {
            document.getElementById(splitString[0] + '_hdnClinicalNotes').value = ClinicalNotes;
        }
        else {
            document.getElementById(splitString[0] + '_hdnClinicalNotes').value = document.getElementById(splitString[0] + '_hdnClinicalNotes').value + ', ' + ClinicalNotes;
        }
        document.getElementById(splitString[0] + '_tdNoteCell').innerHTML = document.getElementById(splitString[0] + '_hdnClinicalNotes').value;
        return false;
    }

    function ImgOnclick(ImgID) {
        //alert(ImgID);
        var ImgsplitID = ImgID.split('_');
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById(ImgsplitID[0] + '_hResultvalues').value;
        var list = HidValue.split('^');
        // alert(ImgsplitID[0]);
        var newInvList = '';
        if (document.getElementById(ImgsplitID[0] + '_hResultvalues').value != "") {
            for (var count = 0; count < list.length; count++) {
                var InvesList = list[count].split('~');
                if (InvesList[0] != '') {
                    if (InvesList[0] != 'RID:' + ImgsplitID[1]) {
                        newInvList += list[count] + '^';
                    }
                }
            }
            document.getElementById(ImgsplitID[0] + '_hResultvalues').value = newInvList;
        }
    }
    function ImgClinicalNotesDelete(ImgID) {
        var splitString = ImgID.split('_');
        document.getElementById(splitString[0] + '_txtClinicalNotes').value = '';
        document.getElementById(splitString[0] + '_tdClinicalNotes').style.display = "none";
        document.getElementById(splitString[0] + '_hdnClinicalNotes').value = '';
    }
    function ImgClinicalNotesEdit(ImgID) {
        var splitString = ImgID.split('_');
        document.getElementById(splitString[0] + '_txtClinicalNotes').value = '';
        document.getElementById(splitString[0] + '_txtClinicalNotes').readOnly = false;
        document.getElementById(splitString[0] + '_txtClinicalNotes').value = document.getElementById(splitString[0] + '_hdnClinicalNotes').value;
        document.getElementById(splitString[0] + '_hdnClinicalNotes').value = '';        
        document.getElementById(splitString[0] + '_tdClinicalNotes').style.display = "none";
    }

    function LoadExistingItems(hdnValue, idd) {
        if (document.getElementById(idd + '_hdnClinicalNotes').value != '') {
            document.getElementById(idd + '_tdClinicalNotes').style.display = "block";
            document.getElementById(idd + '_tdNoteCell').innerHTML = document.getElementById(idd + '_hdnClinicalNotes').value;
        }
        else {
            document.getElementById(idd + '_tdClinicalNotes').style.display = "none";
        }
    }
        
    
    function ValidateUpload(id) {
        /* Added By Venkatesh S */
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vInvalid = SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_03') == null ? "Invalid File" : SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_03');
        // alert(id);
        var Upload_Image = document.getElementById(id);
        var myfile = Upload_Image.value;
        //alert(Upload_Image.value);
        if (myfile.indexOf("jpg") > 0 || myfile.indexOf("jpeg") > 0 || myfile.indexOf("JPG") > 0) {

        }
        else {
            // alert('Invalid File');
            ValidationWindow(vInvalid, AlertType);
        }
    }
    function SetBulkDataSearch_ClinicalNotes(KeyName, autoid) {
        autoClientid = autoid.split('_')[0] + '_' + 'AutoClinicalNotes';
        hdnContextClientid = autoid.split('_')[0] + '_' + 'hdnContext';
        searchvalue = $('[id$="'+hdnContextClientid+'"]').val() + "~" + KeyName;
        $find(autoClientid).set_contextKey(searchvalue);
    }
    function SetBulkDataSearch_GrossedBy(KeyName, autoid) {
        searchvalue = $('[id$="hdnContext"]').val() + "~" + KeyName;
        $find('<%=AutoGrossedBy.ClientID%>').set_contextKey(searchvalue);
    }
    function SetBulkDataSearch_AssistedBy(KeyName, autoid) {
        searchvalue = $('[id$="hdnContext"]').val() + "~" + KeyName;
        $find('<%=AutoAssistedBy.ClientID%>').set_contextKey(searchvalue);
    }
    function SetBulkDataSearch_timeoffixation(KeyName, autoid) {
        searchvalue = $('[id$="hdnContext"]').val() + "~" + KeyName;
        $find('<%=Autotimeoffixation.ClientID%>').set_contextKey(searchvalue);
    }
    function SetBulkDataSearch_TestperformedBy(KeyName, autoid) {
        searchvalue = $('[id$="hdnContext"]').val() + "~" + KeyName;
        $find('<%=AutoTestperformedBy.ClientID%>').set_contextKey(searchvalue);
    }
    function ClickAdd(id) {
//        debugger;
        var splitString = id.split('_');
        if (document.getElementById(splitString[0] + '_txtClinicalNotes').value != "") {
            document.getElementById(splitString[0] + '_btnCNAdd').click();
            document.getElementById(splitString[0] + '_txtClinicalNotes').value = "";
        }       
    }
    function BindImage(invid, orgid, visitid, ctrlID) {
        var ctrlVal = "";
        var bindCtrlVal = "";
        var row$ = "";
        var tbl = document.getElementById(ctrlID + "_tblHistro");
        var tbody = $('<tbody/>');
        var i = 0;
        var ImgSourceDetails = JSON.parse(document.getElementById(ctrlID + '_hdnImgSourceDetails').value);
        if (document.getElementById(ctrlID + '_hdnImgSourceDetails').value != "") {
            row$ = $('<tr/>');
            $.each(ImgSourceDetails, function(m, obj) {
                if (ImgSourceDetails[m].ImageID != "") {
                    var url = "ProbeImagehandler.ashx?InvID=" + invid + "&VisitId=" + visitid + "&POrgID=" + orgid + "&ImageID=" + ImgSourceDetails[m].ImageID;
                    ctrlVal = '<img src="' + url + '" alt="Image" id="ctlimg' + i + '" width="200" height="100">';
                    ctrlVal += '<br/><input id="hdnImg' + i + '" type="hidden" value="' + ImgSourceDetails[m].ImageID + '"/><input id="ctl' + i + '"  value="Delete" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="HistroOnRowDelete(this);" />';
                    ctrlVal += '<input id="hdnInvestigationId' + i + '" type="hidden" value="' + invid + '"/>';
                    ctrlVal += '<input id="hdnOrgID' + i + '" type="hidden" value="' + orgid + '"/>';
                    ctrlVal += '<input id="hdnPvisitid' + i + '" type="hidden" value="' + visitid + '"/>';
                    bindCtrlVal = $('<td/>').html(ctrlVal);
                    row$.append(bindCtrlVal);
                    ctrlVal = "";
                    bindCtrlVal = "";
                    i++;
                }
                $(tbody).append(row$);
            });
            $(tbl).append(tbody);
        }
    }
    function HistroOnRowDelete(obj) {
        /* Added By Venkatesh S */
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vDelete = SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_04') == null ? "Unable to delete" : SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_04');
        try {
            var $row = $(obj).closest('td');
            var invID = $row.find("input[id^='hdnInvestigationId']").val();
            var orgID = $row.find("input[id^='hdnOrgID']").val();
            var Patientvisitid = $row.find("input[id^='hdnPvisitid']").val();
            var imageID = $row.find("input[id^='hdnImg']").val();
            if (invID == '' || invID == undefined) {
                invID = '0';
            }
            if (orgID == '' || orgID == undefined) {
                orgID = '0';
            }
            if (Patientvisitid == '' || Patientvisitid == undefined) {
                Patientvisitid = '0';
            }
            if (imageID == '' || imageID == undefined) {
                imageID = '0';
            }
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/DeleteProbeImageDeatils",
                data: "{PVisitId: " + Patientvisitid + ",Pinvid: " + invID + ",OrgID: " + orgID + ",ImageId: " + imageID + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Success(data) {
                    $(obj).closest('td').remove();
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    //alert("Unable to delete");
                    ValidationWindow(vDelete, AlertType);
                }
            });
        }
        catch (e) {
            return false;
        }
        return false;
    } 
    function SetResultTemplate(objId, content) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vTemplate = SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_05') == null ? "Select Result Template" : SListForAppMsg.Get('Investigation_HistoPathologyPattern_ascx_05');
        try {
            var Orgid = $('input[id$=hdnOrgid]').val();
            var CtlID = $('input[id$=hidVal]').val();
            var userControlID = objId.split("_")
            var Result = $('select[id$="' + userControlID[0] + '_ddlInvResultTemplate"] option:selected').text();
            var Resultvalue = $('select[id$="' + userControlID[0] +'_ddlInvResultTemplate"] option:selected').val();
            if (Resultvalue == "0") {
                //alert('Select Result Template');
                ValidationWindow(vTemplate, AlertType);
            }
            else {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/SetResultTemplate",
                    data: "{POrgid: " + Orgid + ",ControlID: " + CtlID + ",ResultName: '" + Result + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function Success(data) {

                        var ResultXmlData = $.parseXML(data.d);
                        if (typeof FCKeditorAPI != 'undefined') {
                            var txtGross = FCKeditorAPI.GetInstance(userControlID[0] + '_txtGross');
                            var txtMicroscopy = FCKeditorAPI.GetInstance(userControlID[0] + '_txtMicroscopy');
                            var txtImpression = FCKeditorAPI.GetInstance(userControlID[0] + '_txtImpression');
                            var txtResult = FCKeditorAPI.GetInstance(userControlID[0] + '_txtResult');
                            var txtDiagnosis = FCKeditorAPI.GetInstance(userControlID[0] + '_txtDiagnosis');

                            if (content == "Add") {
                                
                                if (txtGross) {
                                    if (txtGross.GetHTML() == "") {
                                        txtGross.SetHTML($(ResultXmlData).find("Gross")[0].text);
                                    }
                                    else {
                                        txtGross.SetHTML(txtGross.GetHTML() + " " + $(ResultXmlData).find("Gross")[0].text);
                                    }
                                }
                                if (txtMicroscopy) {
                                    if (txtMicroscopy.GetHTML() == "") {
                                        txtMicroscopy.SetHTML($(ResultXmlData).find("Microscopy")[0].text);
                                    }
                                    else {
                                        txtMicroscopy.SetHTML(txtMicroscopy.GetHTML() + " " + $(ResultXmlData).find("Microscopy")[0].text);
                                    }
                                }
                                if (txtImpression) {
                                    if (txtImpression.GetHTML() == "") {
                                        txtImpression.SetHTML($(ResultXmlData).find("OriginalHEReport")[0].text);
                                    }
                                    else {
                                        txtImpression.SetHTML(txtImpression.GetHTML() + " " + $(ResultXmlData).find("OriginalHEReport")[0].text);
                                    }
                                }
                                if (txtResult) {
                                    if (txtResult.GetHTML() == "") {
                                        txtResult.SetHTML($(ResultXmlData).find("Result")[0].text);
                                    }
                                    else {
                                        txtResult.SetHTML(txtResult.GetHTML() + " " + $(ResultXmlData).find("Result")[0].text);
                                    }
                                }
                                if (txtDiagnosis) {
                                    if (txtDiagnosis.GetHTML() == "") {
                                        txtDiagnosis.SetHTML($(ResultXmlData).find("Diagnosis")[0].text);
                                    }
                                    else {
                                        txtDiagnosis.SetHTML(txtDiagnosis.GetHTML() + " " + $(ResultXmlData).find("Diagnosis")[0].text);
                                    }
                                }
                            }


                            else {
                              
                                if (txtGross) {

                                    txtGross.SetHTML($(ResultXmlData).find("Gross")[0].text);
                                }
                                if (txtMicroscopy) {

                                    txtMicroscopy.SetHTML($(ResultXmlData).find("Microscopy")[0].text);
                                }
                                if (txtImpression) {

                                    txtImpression.SetHTML($(ResultXmlData).find("OriginalHEReport")[0].text);
                                }
                                if (txtResult) {

                                    txtResult.SetHTML($(ResultXmlData).find("Result")[0].text);
                                }
                                if (txtDiagnosis) {

                                    txtDiagnosis.SetHTML($(ResultXmlData).find("Diagnosis")[0].text);
                                }

                            }
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {


                    }
                });
            }
        }

        catch (e) {
            return false;
        }

        return false;
    } 
</script>

<%--<asp:ScriptManager ID="sm" runat="server">
</asp:ScriptManager>--%>
<table>
    <tr>
        <td>
            <table class="w-80p">
                <tr>
                    <td class="bold font12 h-20" style="color: #000;" colspan="3">
                        <input type="hidden" id="hdnProcess" value="" runat="server" />
                        <input type="hidden" id="hdnStain" value="" runat="server" />
                        <asp:Label ID="lblName" runat="server" onclick="javascript:changeTestName(this.id);"
                            meta:resourcekey="lblNameResource1"></asp:Label>
                        &nbsp;
                        <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
                        <%--<asp:LinkButton id="lnkEdit" runat="server"  OnClientClick="lnkEdit_OnClientClick(this.id)" style="color: red; width:50px; font-size:larger"
                            visible="false"></asp:LinkButton>--%>
                        <a id="lnkEdit" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                            visible="false"><u>
                                <%=Resources.Investigation_ClientDisplay.Investigation_BioPattern1_ascx_01 %></u></a>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlEnableHis" runat="server" meta:resourcekey="pnlEnableHisResource1">
                            <table>
                                <tr>
                                    <td id="tdbarcodetxt" runat="server" class="font14 h-20" style="font-weight: normal;
                                        color: #000; display: none">
                                        <asp:Label ID="lblbarcode" Text="Slide No" runat="server" 
                                            meta:resourcekey="lblbarcodeResource1"></asp:Label>
                                    </td>
                                    <td style="display: none" id="tdbarcode" runat="server">
                                        <asp:DropDownList ForeColor="Black" CssClass="ddlsmall" ID="ddlBarcode" 
                                            runat="server" meta:resourcekey="ddlBarcodeResource1">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font14 h-20" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblSpecimenNo" runat="server" Text="Case No" 
                                            meta:resourcekey="lblSpecimenNoResource1"></asp:Label>
                                    </td>
                                    <td colspan="4">
                                        <asp:TextBox ForeColor="Black" Font-Bold="True" CssClass="small" ID="txtSpecimenNo"
                                            TextMode="MultiLine" runat="server" 
                                            meta:resourcekey="txtSpecimenNoResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font14 h-20" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblOrgan" runat="server" Text="Specimen" meta:resourcekey="lblOrganResource1"></asp:Label>
                                    </td>
                                    <td colspan="4">
                                        <asp:TextBox ForeColor="Black" CssClass="small" Font-Bold="true" ID="txtOrgan" TextMode="MultiLine"
                                            runat="server" meta:resourcekey="txtOrganResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font14 w-30p" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblClinicalNotes" runat="server" Text="Clinical Notes" 
                                            meta:resourcekey="lblClinicalNotesResource1"></asp:Label>
                                    </td>
                                    <td colspan="4" class="w-70p">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="a-left w-50p">
                                                    <asp:TextBox ForeColor="Black" Font-Bold="True" CssClass="small" ID="txtClinicalNotes"
                                                        onfocus="javascript:SetBulkDataSearch_ClinicalNotes('ClinicalNotes',this.id);"
                                                        runat="server" TextMode="MultiLine" onblur="javascript:ClickAdd(this.id);" 
                                                        meta:resourcekey="txtClinicalNotesResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoClinicalNotes" MinimumPrefixLength="2" runat="server"
                                                        TargetControlID="txtClinicalNotes" ServiceMethod="GetInvBulkDataAuto" ServicePath="~/WebService.asmx"
                                                        EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                                                    </ajc:AutoCompleteExtender>
                                                    <asp:HiddenField ID="hdnContext" runat="server" />
                                                </td>
                                                <td style="display: none">
                                                    <asp:Button ID="btnCNAdd" runat="server" class="btn" OnClientClick="return AddClinicalNotes(this.id);"
                                                        onmouseout="this.className='btn'" 
                                                        onmouseover="this.className='btn btnhov'" Text="Add" 
                                                        meta:resourcekey="btnCNAddResource1" />
														
                                                </td>
                                                <td class="v-top font14 h-20 w-50p" style="font-weight: normal; color: #000;">
                                                    <table id="tdClinicalNotes" class="dataheaderInvCtrl w-100p" style="display: none;"
                                                        runat="server">
                                                        <tr id="Tr2" class="colorforcontent" runat="server">
                                                            <td id="Td3" class="bold font14 h-8 w-5p" style="color: White;" runat="server">
                                                                <img id="imgDeletebtn" style="cursor: pointer;" src="../Images/DoustBin.png" runat="server"
                                                                    title="Delete ClinicalNotes" onclick="javascript:ImgClinicalNotesDelete(this.id);" />
                                                            </td>
                                                            <td id="Td1" class="bold font14 h-8 w-5p" style="color: White;" runat="server">
                                                                <img id="imgEditbtn" style="cursor: pointer;" src="~/Images/Edit.png" runat="server"
                                                                    title="Edit ClinicalNotes" onclick="javascript:ImgClinicalNotesEdit(this.id);" />
                                                            </td>
                                                            <td class="bold font14 h-8 w-90p" id="tdNoteCell" style="color: White;" runat="server">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="display: none">
                                    <td class="font14 h-20" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblProcessingMethods" runat="server" Text="Processing Methods" meta:resourcekey="lblProcessingMethodsResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ForeColor="Black" CssClass="ddlsmall" ID="ddlProcessingMethods"
                                            runat="server" meta:resourcekey="ddlProcessingMethodsResource1">
                                            <%--<asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                            <asp:ListItem Text="Routine" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                            <asp:ListItem Text="Frozen Section" Value="2" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                            <asp:ListItem Text="Microwave" Value="3" meta:resourcekey="ListItemResource4"></asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </td>
                                    <td class="font14 h-20" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblStaining" runat="server" Text="Staining" meta:resourcekey="lblStainingResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ForeColor="Black" ID="ddlStaining" CssClass="ddlsmall" runat="server"
                                            meta:resourcekey="ddlStainingResource1">
                                           <%-- <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                            <asp:ListItem Text="Hematoxylin and Eosin" Value="1" meta:resourcekey="ListItemResource6"></asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnAddProcess" runat="server" Text="Add" class="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClientClick="return AddItemsToTableHPP(this.id);"
                                            meta:resourcekey="btnAddProcessResource1" />
                                    </td>
                                </tr>
                                <tr style="display: none">
                                    <td colspan="4">
                                        <table id="tblResult" class="dataheaderInvCtrl w-100p" style="display: none;" runat="server">
                                            <tr class="colorforcontent" runat="server">
                                                <td class=" bold font14 h-8p w-5p" style="color: White;" runat="server">
                                                    <asp:Label ID="Rs_Delete" Text="Delete" runat="server"></asp:Label>
                                                </td>
                                                <td class="bold font14 h-8p w-20p" style="color: White;" runat="server">
                                                    <asp:Label ID="Rs_ProcessingMethods" Text="Processing Methods" runat="server"></asp:Label>
                                                </td>
                                                <td class="bold font14 h-8p w-20p" style="color: White;" runat="server">
                                                    <asp:Label ID="Rs_Staining" Text="Staining" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:Label ID="Rs_PleaseselectthebelowResultNamesonebyonetokeepaddingResultValues"
                                            Text="Please select the below Result Names one by one to keep adding Result Values:"
                                            runat="server" CssClass="font14" meta:resourcekey="Rs_PleaseselectthebelowResultNamesonebyonetokeepaddingResultValuesResource1"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font14 h-8p w-20p" runat="server">
                                        <asp:Label ID="Rs_SelectResult" Text="Select Result Template" runat="server" 
                                            meta:resourcekey="Rs_SelectResultResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ForeColor="Black" ID="ddlInvResultTemplate" runat="server" 
                                                        CssClass="ddlsmall" meta:resourcekey="ddlInvResultTemplateResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnLoadResultTemplate" runat="server" Text="Load" class="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClick="btnLoadResultTemplate_Click" meta:resourcekey="btnLoadResultTemplateResource1" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnAddResultTemplate" runat="server" Text="Add" class="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClick="btnAddResultTemplate_Click" meta:resourcekey="btnAddResultTemplateResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font14 h-15" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblGross" runat="server" Text="Gross" meta:resourcekey="lblGrossResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <%--<asp:TextBox ID="txtGross" MaxLength="50" TextMode="MultiLine" Rows="4" runat="server"
                                            Width="500px" meta:resourcekey="txtGrossResource1"></asp:TextBox>--%>
                                        <FCKeditorV2:CKEditorControl ID="txtGross" FontSizes="10px" FontNames="Arial" runat="server"
                                            Width="600px" ToolbarSet="Biospy" meta:resourcekey="txtGrossResource1" 
                                            TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5">
                                        <table class="dataheaderInvCtrl">
                                            <tr>
                                                <td class="colorforcontent bold font11" style="color: White;">
                                                    <asp:Label ID="lblGrossedby" CssClass="w-100" runat="server" Text="Grossed By" 
                                                        meta:resourcekey="lblGrossedbyResource1"></asp:Label>
                                                </td>
                                                <td class="w-20p">
                                                    <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtGrossedBy" CssClass="small"
                                                        onfocus="javascript:SetBulkDataSearch_GrossedBy('Grossed By','<%=AutoGrossedBy.ClientID%>');"
                                                        runat="server" meta:resourcekey="txtGrossedByResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoGrossedBy" MinimumPrefixLength="2" runat="server"
                                                        TargetControlID="txtGrossedBy" ServiceMethod="GetInvBulkDataAuto" ServicePath="~/WebService.asmx"
                                                        EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td class="colorforcontent bold font11 h-8" style="color: White;">
                                                    <asp:Label ID="lblAssistedby" runat="server" CssClass="w-100" 
                                                        Text="Assisted By" meta:resourcekey="lblAssistedbyResource1"></asp:Label>
                                                </td>
                                                <td class="w-20p">
                                                    <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtAssistedBy" onfocus="javascript:SetBulkDataSearch_AssistedBy('Assisted By','<%=AutoAssistedBy.ClientID%>');"
                                                        runat="server" CssClass="small" meta:resourcekey="txtAssistedByResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoAssistedBy" MinimumPrefixLength="2" runat="server"
                                                        TargetControlID="txtAssistedBy" ServiceMethod="GetInvBulkDataAuto" ServicePath="~/WebService.asmx"
                                                        EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td class="colorforcontent w-20p bold font11" style="color: White;">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="w-100p" nowrap="nowrap">
                                                                <asp:Label ID="lblTimeoffixation" runat="server" CssClass="w-100p" 
                                                                    Text="Time oF Fixation" meta:resourcekey="lblTimeoffixationResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="w-100p" nowrap="nowrap">
                                                                <asp:Label ID="lblTimeOffixToolTip" runat="server" CssClass="w-100p" Text="(for ER, PR, Cer B2)"
                                                                    ForeColor="DarkGreen" meta:resourcekey="lblTimeOffixToolTipResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="w-20p">
                                                    <asp:TextBox ForeColor="Black" Font-Bold="true" CssClass="small" ID="txttimeoffixation"
                                                        onfocus="javascript:SetBulkDataSearch_timeoffixation('Time Of Fixation','<%=Autotimeoffixation.ClientID%>');"
                                                        runat="server" meta:resourcekey="txttimeoffixationResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="Autotimeoffixation" MinimumPrefixLength="2" runat="server"
                                                        TargetControlID="txttimeoffixation" ServiceMethod="GetInvBulkDataAuto" ServicePath="~/WebService.asmx"
                                                        EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font14 h-15" style="font-weight: normal; color: #000;">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblImpression" runat="server" Text="Original H & E Report" 
                                                        ToolTip="Only for Second Opinion Histo, IHC, ER, PR Tests" 
                                                        meta:resourcekey="lblImpressionResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label3" runat="server" Text="(for Second Opinion Histo, IHC, ER, PR Tests)"
                                                        Font-Bold="True" ForeColor="DarkGreen" meta:resourcekey="Label3Resource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td colspan="3">
                                        <%--<asp:TextBox ID="txtImpression" MaxLength="50" TextMode="MultiLine" Rows="4" runat="server"
                                            Width="500px" meta:resourcekey="txtImpressionResource1"></asp:TextBox>--%>
                                        <FCKeditorV2:CKEditorControl ID="txtImpression" runat="server" FontSizes="10px" FontNames="Arial"
                                            Width="600px" ToolbarSet="Biospy" 
                                            meta:resourcekey="txtImpressionResource1" TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font14 h-15" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblMicroscopy" runat="server" Text="Microscopy" meta:resourcekey="lblMicroscopyResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <%--<asp:TextBox ID="txtMicroscopy" MaxLength="50" TextMode="MultiLine" Rows="4" runat="server"
                                            Width="500px" meta:resourcekey="txtMicroscopyResource1"></asp:TextBox>--%>
                                        <FCKeditorV2:CKEditorControl ID="txtMicroscopy" FontSizes="10px" FontNames="Arial"
                                            runat="server" Width="600px" ToolbarSet="Biospy" 
                                            meta:resourcekey="txtMicroscopyResource1" TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font14 h-15" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblResult" runat="server" Text="Result" 
                                            meta:resourcekey="lblResultResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <%--<asp:TextBox ID="txtImpression" MaxLength="50" TextMode="MultiLine" Rows="4" runat="server"
                                            Width="500px" meta:resourcekey="txtImpressionResource1"></asp:TextBox>--%>
                                        <FCKeditorV2:CKEditorControl ID="txtResult" runat="server" FontSizes="10px" FontNames="Arial"
                                            Width="600px" ToolbarSet="Biospy" meta:resourcekey="txtResultResource1" 
                                            TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font14 h-15" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="lblDiagnosis" runat="server" Text="Diagnosis" 
                                            meta:resourcekey="lblDiagnosisResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <%--<asp:TextBox ID="txtImpression" MaxLength="50" TextMode="MultiLine" Rows="4" runat="server"
                                    Width="500px" meta:resourcekey="txtImpressionResource1"></asp:TextBox>--%>
                                        <FCKeditorV2:CKEditorControl ID="txtDiagnosis" runat="server" Width="600px" FontSizes="10px"
                                            FontNames="Arial" ToolbarSet="Biospy" 
                                            meta:resourcekey="txtDiagnosisResource1" TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <table class="dataheaderInvCtrl w-80p">
                                            <tr>
                                                <td class="colorforcontent w-40p font11" style="color: White;">
                                                    <asp:Label ID="lblTestperformedby" runat="server" Text="Test Performed By" 
                                                        meta:resourcekey="lblTestperformedbyResource1"></asp:Label>
                                                    <asp:Label ID="lblToolTestper" runat="server" Text="(for IHC & Special Stains)" 
                                                        ForeColor="DarkGreen" meta:resourcekey="lblToolTestperResource1"></asp:Label>
                                                </td>
                                                <td class="w-60p">
                                                    <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtTestperformedBy" onfocus="javascript:SetBulkDataSearch_TestperformedBy('TestPerformedBy','<%=AutoTestperformedBy.ClientID%>');"
                                                        runat="server" CssClass="small" 
                                                        meta:resourcekey="txtTestperformedByResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoTestperformedBy" MinimumPrefixLength="2" runat="server"
                                                        TargetControlID="txtTestperformedBy" ServiceMethod="GetInvBulkDataAuto" ServicePath="~/WebService.asmx"
                                                        EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td class="font14 h-20" style="font-weight: normal; color: #000;">
                                    <asp:Label ID="Rs_Status" Text="Status" runat="server" meta:resourcekey="Rs_StatusResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ForeColor="Black" CssClass="ddlsmall" ID="ddlstatus" 
                                        runat="server" meta:resourcekey="ddlstatusResource1">
                                    </asp:DropDownList>
                                </td>
                                <td class="w-5p">
                                    <table id="tdInvStatusReason2" runat="server" style="display: none;">
                                        <tr>
                                            <td>
                                                <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                                                    onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);"
                                                    meta:resourcekey="ddlStatusReasonResource1" CssClass="ddlsmall">
                                                  <%--  <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource7"></asp:ListItem>--%>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                    <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                                        <tr>
                                            <td>
                                                <span class="richcombobox" class="w-100">
                                                    <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                                        CssClass="ddlsmall" meta:resourcekey="ddlOpinionUserResource1">
                                                      <%--  <asp:ListItem Text="--Select--" meta:resourcekey="OpinionUserListItemResource1"></asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </span>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="font14 h-20" style="font-weight: normal; color: #000;">
                                    <asp:Label ID="Rs_Comments" Text="Technical Remarks" CssClass="w-70" 
                                        runat="server" meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtReason" TextMode="MultiLine"
                                        CssClass="textbox_pattern small" meta:resourcekey="txtReasonResource1"></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                        TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                                        EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                        DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                                    </ajc:AutoCompleteExtender>
                                    <asp:HiddenField ID="hdnRemarksID" runat="server" />
                                </td>
                                <td class="font14 h-10 w-8p" style="font-weight: normal; color: #000;">
                                    <asp:Label ID="lblMedRemarks" Text="Medical Remarks" CssClass="w-70" 
                                        runat="server" meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                                </td>
                                <td class="font10 h-50 w-8p" style="font-weight: normal; color: #000;">
                                    <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtMedRemarks"
                                        TextMode="MultiLine" CssClass="textbox_pattern small" 
                                        meta:resourcekey="txtMedRemarksResource1"></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                                        TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                                        EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                        DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
                                    </ajc:AutoCompleteExtender>
                                    <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
                                </td>
                                <td>
                                    &nbsp;
                                    <asp:HiddenField runat="server" ID="hidVal" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <%--<asp:LinkButton ID="lnkBrowse" runat="server" Text="Browse">
        </asp:LinkButton>--%>
            <%--<ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modalBackground"
                DropShadow="true" PopupControlID="divPopUp" PopupDragHandleControlID="panelDragHandle"
                TargetControlID="lnkBrowse" />--%>
            <div id="divPopUp" class="modalPopup">
                <table>
                    <tr>
                        <td>
                            <asp:FileUpload ForeColor="Black" Font-Bold="true" ID="flUpload" onchange='javascript:ValidateUpload(this.id);'
                                runat="server" meta:resourcekey="flUploadResource1" />
                        </td>
                        <td>
                            <asp:FileUpload ForeColor="Black" Font-Bold="true" ID="flUpload2" onchange='javascript:ValidateUpload(this.id);'
                                runat="server" meta:resourcekey="flUpload2Resource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:FileUpload ForeColor="Black" Font-Bold="true" ID="flUpload3" onchange='javascript:ValidateUpload(this.id);'
                                runat="server" meta:resourcekey="flUpload3Resource1" />
                        </td>
                        <td>
                            <asp:FileUpload ForeColor="Black" Font-Bold="true" accept="jpg" ID="flUpload4" onchange='javascript:ValidateUpload(this.id);'
                                runat="server" meta:resourcekey="flUpload4Resource1" />
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<table id="tblHistro" cellpadding="3" cellspacing="0" width="98%" runat="server">
    <thead>
    </thead>
    <tbody>
    </tbody>
</table>
<input type="hidden" id="hResultvalues" value="" class="w-50p" runat="server" />
<input type="hidden" id="hdnClinicalNotes" value="" class="w-50p" runat="server" />
<input type="hidden" id="hdnAllClinicalNotes" value="" class="w-50p" runat="server" />
<input type="hidden" id="hdnControlID" value="" class="w-50p" runat="server" />
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<input id="hdninvid" runat="server" type="hidden" value="" />
<input id="hdnOrgid" runat="server" type="hidden" value="" />
<input id="hdnImgSourceDetails" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
    .style4
    {
        width: 50px;
    }
    .dataheaderInvCtrl
    {
        width: 98%;
    }
    </style>
