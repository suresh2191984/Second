<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FungalSmearPattern.ascx.cs"
    Inherits="Investigation_FungalSmearPattern" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    .style1
    {
        height: 21px;
    }
    .listMain
    {
        width: 350px !important;
    }
</style>

<script language="javascript" type="text/javascript">
    function ddlOnchange(obj) {

        var id = obj.split('_');
        if (document.getElementById(obj).value == 0) {
            document.getElementById('dVisible').style.display = "none";
        }
        else {
            document.getElementById('dVisible').style.display = "block";
        }
    }

    function AddItemsToTableFSP(id) {
        //alert(id);
        var splitID = id.split('_');
        var type;
        var iName;
        var iValue;
        //var iUOM;
        var AddStatus = 0;
        var rowNumber = 0;

        var HidValue = document.getElementById(splitID[0] + '_hResultvalues').value;
        iName = document.getElementById(splitID[0] + '_txtGlucose').value;
        iValue = document.getElementById(splitID[0] + '_txtLDH').value;

        if ((iName != "") || (iValue != "")) {
            //alert((splitID[0] + '_tblResult'));
            var row = document.getElementById(splitID[0] + '_tblResult').insertRow(1);
            rowNumber = HidValue.split('^').length;
            var temp;
            if (iValue == '') {
                temp = iValue + "~";
            }
            else {
                temp = "(" + iValue + ")~";
            }
            var rowID = splitID[0] + "_" + iName + temp + rowNumber;
            //alert(rowID);
            row.id = rowID;
            row.style.fontWeight = "normal";
            row.style.fontsize = "10px";
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            //var cell4 = row.insertCell(3);
            document.getElementById(splitID[0] + '_tblResult').style.display = "block";
            cell1.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclick(\'" + rowID + "\');\" src=\"../Images/Delete.jpg\" />";
            //alert("<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclick(\'" + splitID[0] +"_"+  rowNumber+"\');\" src=\"../Images/Delete.jpg\" />");
            cell1.width = "5%";
            cell2.innerHTML = iName;
            cell2.width = "20%"

            cell3.innerHTML = iValue;
            cell3.width = "20%"
            //cell4.innerHTML = iUOM;
            //cell4.width = "20%";
            //document.getElementById(splitID[0] + '_hResultvalues').value += "RID:" + rowNumber + "~FungalStructure:" + iName + "~Quantification:" + iValue + "^";
            if (iValue == '') {
                document.getElementById(splitID[0] + '_hResultvalues').value += iName + "~" + rowNumber + "^";
            }
            else {
                document.getElementById(splitID[0] + '_hResultvalues').value += iName + "(" + iValue + ")~" + rowNumber + "^";
            }

            document.getElementById(splitID[0] + '_txtGlucose').value = "";
            document.getElementById(splitID[0] + '_txtLDH').value = "";
        }
        return false;
    }

    //    function ImgOnclick(ImgID) {
    //        alert(ImgID);
    //        var ImgsplitID = ImgID.split('_');
    //        document.getElementById(ImgID).style.display = "none";
    //        var HidValue = document.getElementById(ImgsplitID[0] + '_hResultvalues').value;
    //        var list = HidValue.split('^');

    //        var newInvList = '';
    //        if (document.getElementById(ImgsplitID[0] + '_hResultvalues').value != "") {
    //            for (var count = 0; count < list.length; count++) {
    //                var InvesList = list[count].split('~');
    //                if (InvesList[0] != '') {
    //                    if (InvesList[0] != 'RID:' + ImgsplitID[1]) {
    //                        newInvList += list[count] + '^';
    //                    }
    //                }
    //            }
    //            document.getElementById(ImgsplitID[0] + '_hResultvalues').value = newInvList;
    //        }
    //    }


    function ImgOnclick(ImgID) {
        //alert(ImgID);

        var ImgsplitID = ImgID.split('_');

        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById(ImgsplitID[0] + '_hResultvalues').value;
        var list = HidValue.split('^');

        var newInvList = '';
        if (document.getElementById(ImgsplitID[0] + '_hResultvalues').value != "") {
            for (var count = 0; count < list.length; count++) {
                //var InvesList = list[count].split('~');
                if (list[count] != '') {
                    if (list[count] != ImgsplitID[1]) {
                        newInvList += list[count] + '^';
                    }
                }
            }
            document.getElementById(ImgsplitID[0] + '_hResultvalues').value = newInvList;
        }
    }

    function divCollapse() {
        //document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == "Weekly"
        if (document.getElementById('ddlSmearFindings').options[document.getElementById('ddlSmearFindings').selectedIndex].innerHTML == '1') {
            document.getElementById('divFungusPresent').style.display = 'block';
        }
        //alert(ddlsfValue);

    }
    
    
    
</script>

<table class="w-80p">
    <tr>
        <td class="font12 h-20" style="font-weight: normal; color: #000;" colspan="2">
            <asp:Label ID="lblName" runat="server" onclick="javascript:changeTestName(this.id);"
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReport_aspx_08 %></u></a>
        </td>
        <td>
            &nbsp;
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
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
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
            <asp:Panel ID="pnlEnabled" runat="server" meta:resourcekey="pnlEnabledResource1">
                <table>
                    <tr>
                        <td class="font12 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblReportingStatus" runat="server" Text="Reporting Status" meta:resourcekey="lblReportingStatusResource1"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:DropDownList ForeColor="Black" Font-Bold="true" ID="ddlReportingStatus" CssClass="ddlsmall"
                                runat="server" meta:resourcekey="ddlReportingStatusResource1">
                            </asp:DropDownList>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblSpecimen" runat="server" Text="Specimen" meta:resourcekey="lblSpecimenResource1"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtSpecimen" runat="server" MaxLength="200"
                                CssClass="small" meta:resourcekey="txtSpecimenResource1"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblSource" runat="server" Text="Source" meta:resourcekey="lblSourceResource1"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtSource" runat="server" MaxLength="200"
                                CssClass="small" meta:resourcekey="txtSourceResource1"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblSmearFindings" Visible="False" runat="server" Text="Smear Findings"
                                meta:resourcekey="lblSmearFindingsResource1"></asp:Label>
                            <asp:Label ID="lblKohMount" runat="server" Text="KOH Mount" meta:resourcekey="lblKohMountResource1"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:DropDownList ForeColor="Black" ID="ddlSmearFindings" runat="server" Visible="False"
                                CssClass="ddlsmall" meta:resourcekey="ddlSmearFindingsResource1">
                            </asp:DropDownList>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtKohMount" runat="server" MaxLength="200"
                                CssClass="small" meta:resourcekey="txtKohMountResource1"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lbl10KOH" runat="server" Text="10% KOH Mount" meta:resourcekey="lbl10KOHResource1"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txt10KohMount" runat="server"
                                CssClass="small" MaxLength="200" meta:resourcekey="txt10KohMountResource1"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 style1" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lbllpcb" runat="server" Text="LPCB" meta:resourcekey="lbllpcbResource1"></asp:Label>
                        </td>
                        <td colspan="3" class="style1">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtLPCB" runat="server" MaxLength="200"
                                CssClass="small" meta:resourcekey="txtLPCBResource1"></asp:TextBox>
                        </td>
                        <td class="style1">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblResult" runat="server" Text="Growth Status" meta:resourcekey="lblResultResource1"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtResult" runat="server" MaxLength="200"
                                CssClass="small" meta:resourcekey="txtResultResource1"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <div id="dVisible" style="display: none">
                                <table class="w-100p">
                                    <tr>
                                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                            <asp:Label ID="lblGlucose" runat="server" EnableTheming="True" Text="Fungal Structure"
                                                meta:resourcekey="lblGlucoseResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtGlucose" CssClass="small" runat="server" MaxLength="200" meta:resourcekey="txtGlucoseResource1"></asp:TextBox>
                                        </td>
                                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                            <asp:Label ID="lblLDH" runat="server" Text="Quantification" meta:resourcekey="lblLDHResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtLDH" runat="server" MaxLength="200" CssClass="small" meta:resourcekey="txtLDHResource1"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnAddProcess" runat="server" class="btn" OnClientClick="return AddItemsToTableFSP(this.id);"
                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Add"
                                                meta:resourcekey="btnAddProcessResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblClinicalDiagnosis" runat="server" Text="Clinical Diagnosis" meta:resourcekey="lblClinicalDiagnosisResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtClinicalDiagnosis" runat="server"
                                CssClass="small" MaxLength="200" meta:resourcekey="txtClinicalDiagnosisResource1"></asp:TextBox>
                        </td>
                        <td class="font11 style1" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblClinicalNotes" runat="server" Text="Clinical Notes" meta:resourcekey="lblClinicalNotesResource1"></asp:Label>
                        </td>
                        <td class="style3">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtClinicalNotes" runat="server"
                                CssClass="small" TextMode="MultiLine" meta:resourcekey="txtClinicalNotesResource1"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            &nbsp;
                        </td>
                        <td colspan="3">
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <table id="tblResult" runat="server" class="dataheaderInvCtrl w-100p" style="display: none;">
                                <tr class="colorforcontent" runat="server">
                                    <td class="font11 h-8 bold w-5p" style="color: White;" runat="server">
                                        <asp:Label ID="Rs_Delete" Text="Delete" runat="server"></asp:Label>
                                    </td>
                                    <td class="font11 h-8 bold w-5p" style="color: White;" runat="server">
                                        <asp:Label ID="Rs_FungalStructure" Text="Fungal Structure" runat="server"></asp:Label>
                                    </td>
                                    <td class="font11 h-8 bold w-5p" style="color: White;" runat="server">
                                        <asp:Label ID="Rs_Quantification" Text="Quantification" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server" 
                                meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                        </td>
                        <td colspan="2">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtReason" runat="server" CssClass="small"
                                TextMode="MultiLine" meta:resourcekey="txtReasonResource1"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                                EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                            </ajc:AutoCompleteExtender>
                            <asp:HiddenField ID="hdnRemarksID" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20 bold w-5p" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server" 
                                meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                        </td>
                        <td colspan="2">
                            <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtMedRemarks"
                                TabIndex="-1" TextMode="MultiLine" CssClass="small" 
                                meta:resourcekey="txtMedRemarksResource1"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                                TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                                EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
                            </ajc:AutoCompleteExtender>
                            <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="font11 h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="Rs_Status" Text="Status" runat="server" meta:resourcekey="Rs_StatusResource1"></asp:Label>
                        </td>
                        <td colspan="3">
                            <table>
                                <tr>
                                    <td>
                                        <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" CssClass="ddlsmall"
                                            meta:resourcekey="ddlstatusResource1">
                                            <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td class="font10 h-10" style="font-weight: normal; color: #000;">
                                        <table id="tdInvStatusReason1" runat="server" style="display: none;">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblReason" Text="Reason" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tdInvStatusOpinion1" runat="server" style="display: none;">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblOpinionUser" runat="server" Text="User" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <table id="tdInvStatusReason2" runat="server" style="display: none;">
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                                                        CssClass="ddlsmall" onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);">
                                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                                            <tr>
                                                <td>
                                                    <span class="richcombobox" class="w-100">
                                                        <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                                            CssClass="ddlsmall">
                                                            <asp:ListItem Text="--Select--" meta:resourcekey="OpinionUserListItemResource1"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
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
            <asp:HiddenField runat="server" ID="hidVal" />
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            <input type="hidden" id="hResultvalues" value="" style="width: 346%;" runat="server" />
        </td>
    </tr>
</table>
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
