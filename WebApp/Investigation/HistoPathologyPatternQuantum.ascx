<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HistoPathologyPatternQuantum.ascx.cs"
    Inherits="Investigation_HistoPathologyPatternQuantum" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="FCKeditorV2" %>

<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

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
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vMethods = SListForAppMsg.Get('Investigation_HistoPathologyPatternQuantum_ascx_01') == null ? "Please Select Processing Methods" : SListForAppMsg.Get('Investigation_HistoPathologyPatternQuantum_ascx_01');
        var vStaining = SListForAppMsg.Get('Investigation_HistoPathologyPatternQuantum_ascx_02') == null ? "Please Select Staining" : SListForAppMsg.Get('Investigation_HistoPathologyPatternQuantum_ascx_02');
        var pMethods = SListForAppMsg.Get('Investigation_HistoPathologyPatternQuantum_ascx_11') == null ? "ProcessMethods" : SListForAppMsg.Get('Investigation_HistoPathologyPatternQuantum_ascx_11');
        var pStaining = SListForAppMsg.Get('Investigation_HistoPathologyPatternQuantum_ascx_26') == null ? "Staining" : SListForAppMsg.Get('Investigation_HistoPathologyPatternQuantum_ascx_26');
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
            ValidationWindow(vMethods, AlertType);
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
        var rowID = splitString[0] + '_' + rowNumber;
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
        document.getElementById(splitString[0] + '_hResultvalues').value += "RID:" + rowNumber + "~" + pMethods + ":" + ProcessMethods + "~" + pStaining + ":" + Staining + "^";
        document.getElementById(splitString[0] + '_ddlProcessingMethods').value = "0";
        document.getElementById(splitString[0] + '_ddlStaining').value = "0";
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
    function LoadExistingItems(hdnValue, idd) {
        //        alert(hdnValue);
        //        alert(idd);
        var i, y, z, z1, z2;
        var x = hdnValue;
        var splitStr = x.split("^");
        var len = splitStr.length;
        for (i = 0; i < len; i++) {
            if (splitStr[i] != "") {
                y = splitStr[i].split("~");
                if (y[0] != "") {
                    z = y[0].split(":");
                    z1 = y[1].split(":");
                    z2 = y[2].split(":");
                    if (z[1] != "") {
                        var row = document.getElementById(idd + '_tblResult').insertRow(1);
                        var rowID = idd + "_" + z[1];
                        row.id = rowID;
                        row.style.fontWeight = "normal";
                        row.style.fontsize = "10px";
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        document.getElementById(idd + '_tblResult').style.display = "block";
                        cell1.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclick(\'" + rowID + "\');\" src=\"../Images/Delete.jpg\" />";
                        cell1.width = "5%";
                        cell2.innerHTML = z1[1];
                        cell2.width = "20%"
                        cell3.innerHTML = z2[1];
                        cell3.width = "20%"
                    }
                }
            }
        }
    }


    function ValidateUpload(id) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vInvalid = SListForAppMsg.Get('Investigation_HistoPathologyPatternQuantum_ascx_03') == null ? "Invalid File" : SListForAppMsg.Get('Investigation_HistoPathologyPatternQuantum_ascx_03');
        var Upload_Image = document.getElementById(id);
        var myfile = Upload_Image.value;
        //alert(Upload_Image.value);
        if (myfile.indexOf("jpg") > 0 || myfile.indexOf("jpeg") > 0 || myfile.indexOf("JPG") > 0) {

        }
        else {
            //alert('Invalid File');
            ValidationWindow(vInvalid, AlertType);
        }
    }
    function onImageDelete(invID, Patientvisitid, orgID, HiddenProbeImageID, ID, ID1, ID2, ID3) {

        try {
            //debugger;
            // var $row = $(obj).closest('tr');
            //$row.
            //            var HiddenProbeImageID = $row.find("input[id$='HiddenProbeImageID']").val();
            //            var invID = $row.find("input[id$='hdnInvestigationId']").val();
            //            var orgID = $row.find("input[id$='hdnOrgID']").val();
            //            var Patientvisitid = $row.find("input[id$='hdnPvisitid']").val();
            //            if (HiddenProbeImageID == '' || HiddenProbeImageID == undefined) {
            //                HiddenProbeImageID = '0';
            //            }
            document.getElementById(ID).style.display = 'none';
            document.getElementById(ID1).style.display = 'none';
            document.getElementById(ID2).style.display = 'none';
            document.getElementById(ID3).style.display = 'none';
            if (invID == '' || invID == undefined) {
                invID = '0';
            }
            if (orgID == '' || orgID == undefined) {
                orgID = '0';
            }
            if (Patientvisitid == '' || Patientvisitid == undefined) {
                Patientvisitid = '0';
            }

            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vUnable = SListForAppMsg.Get('Investigation_HistoPathologyPatternQuantum_ascx_04') == null ? "Unable to delete" : SListForAppMsg.Get('Investigation_HistoPathologyPatternQuantum_ascx_04');
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/DeleteProbeImageDeatils",
                data: "{PVisitId: " + Patientvisitid + ",Pinvid: " + invID + ",OrgID: " + orgID + ",ImageId: " + HiddenProbeImageID + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Success(data) {
                    document.getElementById('trimg').style.display = 'none';
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    //alert("Unable to delete");
                    ValidationWindow(vUnable, AlertType);
                }
            });
        }
        catch (e) {
            return false;
        }
        return false;
    }
   
    function OnImageEnLarge(obj) {

        //        alert('1');
        //        var prtContent = document.getElementById('trimg');
        window.open(obj);
        //        var WinPrint = window.open('','','letf=0,top=0,width=900,height=900,toolbar=0,scrollbars=0,status=0,Addressbar=no');
        //        WinPrint.document.write(prtContent.innerHTML);
        //        WinPrint.print();
        return false;
    }
 
</script>

<%--<asp:ScriptManager ID="sm" runat="server">
</asp:ScriptManager>--%>
<table>
    <tr>
        <td>
            <table width="width: 80%;">
                <tr>
                    <td style="font-weight: bold; font-size: 12px; height: 20px; color: #000;" colspan="3">
                        <input type="hidden" id="hdnProcess" value="" runat="server" />
                        <input type="hidden" id="hdnStain" value="" runat="server" />
                        <asp:Label ID="lblName" runat="server" onclick="javascript:changeTestName(this.id);"
                            meta:resourcekey="lblNameResource1"></asp:Label>
                        &nbsp;
                        <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                            ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
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
                            <td id="tdbarcodetxt" runat="server" style="font-weight: normal; font-size: 11px; height: 20px; color: #000;display:none">
                              <asp:Label ID="lblbarcode" Text="Slide No" runat="server"></asp:Label>
                            </td>
                            <td style="display:none" id="tdbarcode" runat="server">
                                        <asp:DropDownList ForeColor="Black" ID="ddlBarcode" runat="server" 
                                            meta:resourceKey="ddlBarcodeResource1">
                                        </asp:DropDownList>
                            </td>
                            </tr>
                                <tr>
                                    <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;">
                                        <asp:Label ID="lblOrgan" runat="server" Text="Specimen" meta:resourcekey="lblOrganResource1"></asp:Label>
                                    </td>
                                    <td colspan="4">
                                      <%--  <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtOrgan" TextMode="MultiLine" runat="server" Width="600px" meta:resourcekey="txtOrganResource1"></asp:TextBox>--%>
                                        <FCKeditorV2:CKEditorControl ID="txtOrgan" runat="server" Width="600px" Height="100px"
                                            ToolbarSet="Biospy" meta:resourceKey="txtOrganResource1" 
                                            TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                     
                                </tr>
                                <tr>
                                    <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;">
                                        <asp:Label ID="lblSpecimenNo" runat="server" Text="Specimen No." meta:resourcekey="lblSpecimenNoResource1"></asp:Label>
                                    </td>
                                    <td colspan="4">
                                        <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtSpecimenNo" TextMode="MultiLine"
                                            runat="server" Width="600px" meta:resourcekey="txtSpecimenNoResource1"></asp:TextBox>
                                    </td>
                                     
                                </tr>
                                <tr>
                                    <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;">
                                        <asp:Label ID="lblSpecimen" runat="server" Text="Technique" meta:resourcekey="lblSpecimenResource1"></asp:Label>
                                    </td>
                                    <td colspan="4">
                                        <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtSpecimen" TextMode="MultiLine"
                                            runat="server" Width="600px" meta:resourcekey="txtSpecimenResource1"></asp:TextBox>
                                    </td>
                                     
                                </tr>
                                <tr>
                                    <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;">
                                        <asp:Label ID="lblClinicalDiagnosis" runat="server" Text="Site" meta:resourcekey="lblClinicalDiagnosisResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtClinicalDiagnosis"  runat="server"  TextMode="MultiLine" Width="200px"
                                            meta:resourcekey="txtClinicalDiagnosisResource1"></asp:TextBox>
                                    </td>
                                   <%-- <td style="font-weight: normal; font-size: 11px; color: #000;" class="style1">
                                        <asp:Label ID="lblClinicalNotes" runat="server" Text="Clinical History" meta:resourcekey="lblClinicalNotesResource1"></asp:Label>
                                    </td>
                                    <td class="style3">
                                        <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtClinicalNotes" runat="server" TextMode="MultiLine" Width="250px"
                                            meta:resourcekey="txtClinicalNotesResource1"></asp:TextBox>
                                    </td>--%>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;">
                                        <asp:Label ID="lblClinicalNotes" runat="server" Text="Clinical History" meta:resourcekey="lblClinicalNotesResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <%--<asp:TextBox ID="txtGross" MaxLength="50" TextMode="MultiLine" Rows="4" runat="server"
                                            Width="500px" meta:resourcekey="txtGrossResource1"></asp:TextBox>--%>
                                        <FCKeditorV2:CKEditorControl ID="txtClinicalNotes" runat="server" Width="600px" Height="100px"
                                            ToolbarSet="Biospy" meta:resourceKey="txtClinicalNotesResource1" 
                                            TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;">
                                        <asp:Label ID="lblProcessingMethods" runat="server" Text="Processing Methods" meta:resourcekey="lblProcessingMethodsResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ForeColor="Black" ID="ddlProcessingMethods" runat="server" meta:resourcekey="ddlProcessingMethodsResource1">
                                           <%-- <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                            <asp:ListItem Text="Routine" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                            <asp:ListItem Text="Frozen Section" Value="2" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                            <asp:ListItem Text="Microwave" Value="3" meta:resourcekey="ListItemResource4"></asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </td>
                                    <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;">
                                        <asp:Label ID="lblStaining" runat="server" Text="Staining" meta:resourcekey="lblStainingResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ForeColor="Black" ID="ddlStaining" runat="server" meta:resourcekey="ddlStainingResource1">
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
                                <tr>
                                    <td colspan="4">
                                        <table id="tblResult" class="dataheaderInvCtrl" cellpadding="4" cellspacing="0" width="100%"
                                            style="display: none;" runat="server">
                                            <tr class="colorforcontent" runat="server">
                                                <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;"
                                                    runat="server">
                                                    <asp:Label ID="Rs_Delete" Text="Delete" runat="server" meta:resourcekey="btnDeleteResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;"
                                                    runat="server">
                                                    <asp:Label ID="Rs_ProcessingMethods" Text="Processing Methods" runat="server" meta:resourcekey="lblProcessingMethodsResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;"
                                                    runat="server">
                                                    <asp:Label ID="Rs_Staining" Text="Staining" runat="server" meta:resourcekey="lblStainingResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:Label ID="Rs_PleaseselectthebelowResultNamesonebyonetokeepaddingResultValues"
                                            Text="Please select the below Result Names one by one to keep adding Result Values:"
                                            runat="server" meta:resourcekey="Rs_PleaseselectthebelowResultNamesonebyonetokeepaddingResultValuesResource1"></asp:Label>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Rs_SelectResult" Text="Select Result" runat="server" meta:resourcekey="Rs_SelectResultResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ForeColor="Black" ID="ddlInvResultTemplate" runat="server" meta:resourcekey="ddlInvResultTemplateResource1">
                                           <%-- <asp:ListItem Text="sample" Value="1" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                            <asp:ListItem Text="sample1" Value="2" meta:resourcekey="ListItemResource8"></asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="3">
                                        <asp:Button ID="btnLoadResultTemplate" runat="server" Text="Load" class="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClick="btnLoadResultTemplate_Click" OnClientClick="return AddItemsToTableHPP(this.id)"
                                            meta:resourcekey="btnLoadResultTemplateResource1" />&nbsp;&nbsp;
                                            <asp:Button ID="btnAddResultTemplate" runat="server" Text="Add" class="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClick="btnAddResultTemplate_Click"
                                            meta:resourcekey="btnAddResultTemplateResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;">
                                        <asp:Label ID="lblGross" runat="server" Text="Gross" meta:resourcekey="lblGrossResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <%--<asp:TextBox ID="txtGross" MaxLength="50" TextMode="MultiLine" Rows="4" runat="server"
                                            Width="500px" meta:resourcekey="txtGrossResource1"></asp:TextBox>--%>
                                            <FCKeditorV2:CKEditorControl ID="txtGross" runat="server" Width="600px" 
                                            Height="300px" ToolbarSet="Biospy">
            </FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;">
                                        <asp:Label ID="lblMicroscopy" runat="server" Text="Microscopy" meta:resourcekey="lblMicroscopyResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <%--<asp:TextBox ID="txtMicroscopy" MaxLength="50" TextMode="MultiLine" Rows="4" runat="server"
                                            Width="500px" meta:resourcekey="txtMicroscopyResource1"></asp:TextBox>--%>
                                            
          <FCKeditorV2:CKEditorControl ID="txtMicroscopy" runat="server" Width="600px" Height="300px"
                                            ToolbarSet="Biospy" meta:resourceKey="txtMicroscopyResource1" 
                                            TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;">
                                        <asp:Label ID="lblImpression" runat="server" Text="Interpretation" meta:resourcekey="lblImpressionResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <%--<asp:TextBox ID="txtImpression" MaxLength="50" TextMode="MultiLine" Rows="4" runat="server"
                                            Width="500px" meta:resourcekey="txtImpressionResource1"></asp:TextBox>--%>
                                            <FCKeditorV2:CKEditorControl ID="txtImpression" runat="server" Width="600px" Height="300px"
                                            ToolbarSet="Biospy" meta:resourceKey="txtImpressionResource1" 
                                            TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;">
                                        <asp:Label ID="lblMicroInterpretation" runat="server" 
                                            Text="Microscopy And Interpretation" 
                                            meta:resourceKey="lblMicroInterpretationResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                       
                                        <FCKeditorV2:CKEditorControl ID="txtMicroscopyandInterpretation" runat="server" Width="600px"
                                            Height="300px" ToolbarSet="Biospy" 
                                            meta:resourceKey="txtMicroscopyandInterpretationResource1" TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                 <tr>
                    
                                 <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;">
                                        <asp:Label ID="lblComm" runat="server" Text="Comment" 
                                            meta:resourceKey="lblCommResource1"></asp:Label>
                                </td>
                                <td>
                                    <%--<asp:TextBox ID="txtImpression" MaxLength="50" TextMode="MultiLine" Rows="4" runat="server"
                    Width="500px" meta:resourcekey="txtImpressionResource1"></asp:TextBox>--%>
                                        <FCKeditorV2:CKEditorControl ID="txtCommenttext" runat="server" Width="600px"
                                            ToolbarSet="Biospy" meta:resourceKey="txtCommenttextResource1" 
                                            TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
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

                                
                                <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;">
                                    <asp:Label ID="Rs_Comments" Text="Comments" Width="70px" Visible="False" 
                                        runat="server" meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtReason" Visible="False"
                                        TextMode="MultiLine" CssClass="textbox_pattern" Height="94%" Width="600px" 
                                        meta:resourcekey="txtReasonResource1"></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                                                                                    TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                                                                                                    EnableCaching="False" CompletionInterval="2"
                                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                                                                     Enabled="True" OnClientItemSelected="SelectedRemarks">
                                                                                                    </ajc:AutoCompleteExtender>
                                    <asp:HiddenField ID="hdnRemarksID" runat="server" />
                                </td>
                                 <tr>
                                     <td style="font-weight: normal; font-size: 10px; height: 10px; color: #000; width: 8%;">
                                        <asp:Label ID="lblMedRemarks" Text="Medical Remarks" Width="70px" runat="server"
                                            Visible="False" meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                                </td>
                                <td style="font-weight: normal; font-size: 10px; height: 50px; color: #000; width: 8%;">
                                        <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtMedRemarks"
                                            TabIndex="-1" TextMode="MultiLine" CssClass="textbox_pattern" Height="84%" Width="600px"
                                            Visible="False" meta:resourcekey="txtMedRemarksResource1"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                                                                                                        TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                                                                                                        EnableCaching="False"  CompletionInterval="2"
                                                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                                                                         Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
                                                                                                        </ajc:AutoCompleteExtender>
                                        <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
                                </td>
                                <td>
                                    &nbsp;
                                    <asp:HiddenField runat="server" ID="hidVal" />
                                </td></tr>
                                <tr>
                                    <td style="font-weight: normal; font-size: 11px; height: 20px; color: #000;">
                                    <asp:Label ID="Rs_Status" Text="Status" runat="server" meta:resourcekey="Rs_StatusResource1"></asp:Label>
                                </td>
                                <td>
                                        <asp:DropDownList ForeColor="Black" ID="ddlStatus" runat="server" 
                                            meta:resourcekey="ddlStatusResource1">
                                        </asp:DropDownList>
                                </td></tr>
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
                            <asp:FileUpload ForeColor="Black" Font-Bold="true" ID="flUpload" onchange='javascript:ValidateUpload(this.id);' runat="server"
                                meta:resourcekey="flUploadResource1" />
                        </td>
                        <td>
                            <asp:FileUpload ForeColor="Black" Font-Bold="true" ID="flUpload2" onchange='javascript:ValidateUpload(this.id);' runat="server"
                                meta:resourcekey="flUpload2Resource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:FileUpload ForeColor="Black" Font-Bold="true" ID="flUpload3" onchange='javascript:ValidateUpload(this.id);' runat="server"
                                meta:resourcekey="flUpload3Resource1" />
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
    <tr id ="trimg" >
                    <td style="font-weight: normal; font-size: 11px; height: 20px;  color: #000;" >
                   
                            <asp:Repeater ID="rptimages" runat="server" 
                            onitemdatabound="rptimages_ItemDataBound" >
                            <ItemTemplate>
                            <%--<tr style="height: 200px;">--%>
                            <tr>
                            <td align="left">
                            <asp:Label ID="imagpath" runat="server" Text='<%# Bind("FilePath") %>' 
                                meta:resourcekey="imagpathResource1"></asp:Label>
                            </td>
                            </tr>
                            <tr>
                            <td>
                            <asp:HiddenField ID="HiddenProbeImageID" runat="server" Value='<%# Eval("ImageID") %>' />
                            <asp:HiddenField ID="hdnInvestigationId" runat="server" Value='<%# Eval("InvestigationID") %>' />
                            <asp:HiddenField ID="hdnOrgID" runat="server" Value='<%# Eval("OrgID") %>' />
                            <asp:HiddenField runat="server" ID="hdnPvisitid" Value='<%# Eval("PatientVisitID") %>' /> 
                            <asp:Image  id="imgchrome"   runat="server"  width="100" height="100" 
                                meta:resourcekey="imgchromeResource1" />
                            <tr> <td>                   
                            <asp:Button id="btnLarge" runat="server" Text="Enlarge" style="background-color: Transparent;
                            color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                                        font-size: 11px;" meta:resourcekey="btnLargeResource1" />
                            <asp:Button ID="btnDelete" runat="server" Text="Delete"   style="background-color: Transparent;
                            color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                            font-size: 11px;"  />                                                                                 
                            <%--<input id="btnDelete" runat="server" value="Delete" type="button" style="background-color: Transparent;
                            color: Blue; border-style: none; text-decoration: underline; cursor: pointer;
                            font-size: 11px;" onclick="onImageDelete(this);" /> --%>
                            </td>   
                            </tr>                            
                            </td>
                            </tr>
                            </ItemTemplate>
                            </asp:Repeater>
                            
                            </td>
    </tr>
</table>
<input type="hidden" id="hResultvalues" value="" style="width: 50%;" runat="server" />
<input type="hidden" id="hdnControlID" value="" style="width: 50%;" runat="server" />
<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
</style>
