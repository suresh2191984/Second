<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MultiAddControl.ascx.cs" Inherits="Investigation_MultiAddControl" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<script src="../Scripts/Common.js" type="text/javascript"></script>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">
        
    function GetInvMedicalRemarks(source, eventArgs) {

        RemarksDetails = eventArgs.get_value();
        if (document.getElementById('hdnAppRemarksID') != null) {
            var arrValue = RemarksDetails.split("~");
            document.getElementById('hdnAppRemarksID').value = arrValue[1];
            document.getElementById('hdnInvRemGrpIDList').value = document.getElementById('hdnInvRemGrpIDList').value + RemarksDetails + "^";
        }
    }
    function AddClinicalNotes(id) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vNotes = SListForAppMsg.Get('Investigation_MultiAddControl_ascx_01') == null ? "Please Select  Notes" : SListForAppMsg.Get('Investigation_MultiAddControl_ascx_01');
        
        var splitString = id.split('_');
        document.getElementById(splitString[0] + '_hdnControlID').value = splitString[0];
        var type;
        var ClinicalNotes;
        var AddStatus = 0;
        var rowNumber = 0;
        var HidValue = document.getElementById(splitString[0] + '_hdnClinicalNotes').value;
        if (document.getElementById(splitString[0] + '_txtDescription').value == "") {
            //alert('Please Select  Notes');
            ValidationWindow(vNotes, AlertType);
            document.getElementById(splitString[0] + '_txtDescription').focus();
            return false;
        }

        ClinicalNotes = document.getElementById(splitString[0] + '_txtDescription').value;
        var row = document.getElementById(splitString[0] + '_tdClinicalNotes').insertRow(1);
        if (HidValue == "") {
            rowNumber = 1;
        }
        else {
            rowNumber = HidValue.split(',').length + 1;
        }
        var rowID = splitString[0] + '_' + rowNumber;
        row.id = rowID;
        row.style.fontWeight = "normal";
        row.style.fontsize = "10px";
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        document.getElementById(splitString[0] + '_tdClinicalNotes').style.display = "block";
        //cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + rowID + ");' src='../Images/Delete.jpg' />";
        cell1.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclick1(\'" + ClinicalNotes + "," + rowID + "\');\" src=\"../Images/Delete.jpg\" />";
        cell1.width = "5%";
        cell2.innerHTML = ClinicalNotes;
        cell2.width = "20%";
        if (document.getElementById(splitString[0] + '_hdnClinicalNotes').value == '') {
            document.getElementById(splitString[0] + '_hdnClinicalNotes').value = ClinicalNotes;
        }
        else {
            document.getElementById(splitString[0] + '_hdnClinicalNotes').value = document.getElementById(splitString[0] + '_hdnClinicalNotes').value + ',' + ClinicalNotes;
        }
        document.getElementById(splitString[0] + '_txtDescription').value = '';
        return false;
    }

    function ImgOnclick1(ImgID) {
        var T = document.getElementById('<%=hdnClinicalNotes.ClientID%>').value;
        var Lists = ImgID.split(',');
        var DeletedValue = Lists[0];
        var hideval = Lists[1];
        document.getElementById(hideval).style.display = "none";
        var newInvList = '';
        if (document.getElementById('<%=hdnClinicalNotes.ClientID%>').value != "") {
            var InvesList1 = document.getElementById('<%=hdnClinicalNotes.ClientID%>').value;
            var InvesList2 = InvesList1.split(',');
            for (var count = 0; count < InvesList2.length; count++) {
                if (DeletedValue != '') {
                    if (DeletedValue != InvesList2[count]) {
                        newInvList += InvesList2[count] + ',';
                    }
                }
            }
            if (newInvList.indexOf(',') != -1) {
                var output = newInvList.split(',');
                var finalList = '';
                for (var count = 0; count < output.length - 1; count++) {
                    if (count == output.length - 2) {
                        finalList += output[count];
                    }
                    else {
                        finalList += output[count] + ',';
                    }
                }
                document.getElementById('<%=hdnClinicalNotes.ClientID%>').value = finalList;
            }
            else {
                document.getElementById('<%=hdnClinicalNotes.ClientID%>').value = newInvList;
            }
        }
        var val = document.getElementById('<%=hdnClinicalNotes.ClientID%>').value;
        if (val == "") {
            var id = '<%= hdnClinicalNotes.ClientID %>';
            var splitString = id.split('_');
            document.getElementById(splitString[0] + '_tdClinicalNotes').style.display = "none";
        }
    }

    function LoadExistingItems(idd, hdnClinicalNotes) {
        
        //        alert(hdnValue);
        //        alert(idd);        
        var ii, yy, zz, zz1, zz2;
        var xx = hdnClinicalNotes;
        var splitStr1 = xx.split(",");
        var len1 = splitStr1.length;
        for (i = 0; i < len1; i++) {
            if (splitStr1[i] != "") {
                yy = splitStr1[i];
                if (yy != "") {
                    var row = document.getElementById(idd + '_tdClinicalNotes').insertRow(1);
                    var rowID = idd + "_" + i;
                    row.id = rowID;
                    row.style.fontWeight = "normal";
                    row.style.fontsize = "10px";
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    document.getElementById(idd + '_tdClinicalNotes').style.display = "block";
                    cell1.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclick1(\'" + yy + "," + rowID + "\');\" src=\"../Images/Delete.jpg\" />";
                    cell1.width = "5%";
                    cell2.innerHTML = yy;
                    cell2.width = "20%"
                }
            }
        }
    }


    
</script>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="defaultfontcolor">
<table class="w-100p defaultfontcolor">
    <tr id="tdFish" runat="server">
        <td class="font10 h-20 w-10p" id="tdInvName" runat="server" style="font-weight: normal;
            color: #000; display: table-cell;">
            <asp:Label ID="lblName" runat="server" Text="Name" 
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
        </td>
        <td class="w-5p v-middle a-left">
            <asp:Label ID="lblPVisitID" runat="server" Style="display: none;" 
                meta:resourcekey="lblPVisitIDResource1"></asp:Label>
            <asp:Label ID="lblPatternID" runat="server" Style="display: none;" 
                meta:resourcekey="lblPatternIDResource1"></asp:Label>
            <asp:Label ID="lblInvID" runat="server" Style="display: none;" 
                meta:resourcekey="lblInvIDResource1"></asp:Label>
            <asp:Label ID="lblOrgID" runat="server" Style="display: none;" 
                meta:resourcekey="lblOrgIDResource1"></asp:Label>
        </td>
        <td class="w-12p v-middle">
            <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtDescription" TextMode="MultiLine"
                runat="server" CssClass="small" meta:resourcekey="txtDescriptionResource1"></asp:TextBox>
            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                TargetControlID="txtDescription" ServiceMethod="GetInvBulkDataAuto" ServicePath="~/WebService.asmx"
                EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                DelimiterCharacters=";,:" Enabled="True">
            </ajc:AutoCompleteExtender>
            <asp:HiddenField runat="server" ID="hidVal" />
            <table>
                <tr>
                    <td>
                        <table id="tdClinicalNotes" class="dataheaderInvCtrl w-50p" style="display: none;"
                            runat="server">
                            <tr id="Tr1" class="colorforcontent" runat="server">
                                <td class="bold font14 h-8p w-5p" id="Td1" style="color: White;" runat="server">
                                    <asp:Label ID="Label1" Text="Delete" runat="server" 
                                        meta:resourcekey="Label1Resource1"></asp:Label>
                                </td>
                                <td id="Td2" class="bold font14 h-8p w-20p" style="color: White;" runat="server">
                                    <asp:Label ID="Label2" Text="Notes" runat="server" 
                                        meta:resourcekey="Label2Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td class="w-2p v-middle">
            <asp:Button ID="btnCNAdd" runat="server" class="btn" OnClientClick="return AddClinicalNotes(this.id);"
                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Add" meta:resourcekey="btnCNAddResource1" />
        </td>
        <td class="v-top font14 h-20 w-4p" style="font-weight: normal; color: #000;">
        </td>
        <td id="tdRemarks" class="font10 h-20 w-10p v-top" runat="server" style="font-weight: normal;
            color: #000; display: table-cell;">
            <table>
                <tr>
                    <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                        Medical Remarks
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtMedRemarks"
                            TabIndex="1" TextMode="MultiLine" CssClass="small" 
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
            </table>
        </td>
        <td class="w-3p v-middle">
        </td>
        <td class="w-14p v-middle">
            <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" meta:resourcekey="ddlstatusResource1"
                CssClass="ddlsmall">
                <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
            </asp:DropDownList>
            <input type="hidden" id="hdnControlID" value="" class="w-50p" runat="server" />
            <input type="hidden" id="hdnClinicalNotes" value="" class="w-50p" runat="server" />
        </td>
        <td class="w-5p v-middle">
                        <table id="tdInvStatusReason2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                                        Width="100px" normalWidth="100px" onmousedown="expandDropDownList(this);" 
                                        onblur="collapseDropDownList(this);" 
                                        meta:resourcekey="ddlStatusReasonResource1" CssClass="ddl">
                                        <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <span class="richcombobox" style="width: 100px;">
                                        <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                            CssClass="ddl" Width="100px" 
                                        meta:resourcekey="ddlOpinionUserResource1">
                                            <asp:ListItem Text="--Select--" meta:resourcekey="OpinionUserListItemResource1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </td>
        <td style="width: 5%;vertical-align:middle;"></td>
       
</tr>
</table>