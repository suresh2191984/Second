<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CommanPattern.ascx.cs"
    Inherits="Investigation_CommanPattern" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script language="javascript" type="text/javascript">
    function CommanPatternADD(id) {

        var splitID = id.split('_');
        var type;
        var iName;
        var iValue;
        var iUOM;
        var AddStatus = 0;
        var rowNumber = 0;

        var HidValue = document.getElementById(splitID[0] + '_hidCommanPattern').value;
        iName = document.getElementById(splitID[0] + '_txtName').value;
        iValue = document.getElementById(splitID[0] + '_txtValue').value;
        iUOM = document.getElementById(splitID[0] + '_txtUOM').value;
        //        alert('name' + iName);
        //        alert('Value' + iValue);
        //        alert('um'+iUOM);
        if ((iName != "") || (iValue != "") || (iUOM != "")) {
            var row = document.getElementById(splitID[0] + '_tblResult').insertRow(1);
            rowNumber = HidValue.split('^').length;
            var rowID = splitID[0] + "_" + rowNumber;
            row.id = rowID;

            row.style.fontWeight = "normal";
            row.style.fontsize = "10px";
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            document.getElementById(splitID[0] + '_tblResult').style.display = "block";
            cell1.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclick(\'" + splitID[0] + "_" + rowNumber + "\');\" src=\"../Images/Delete.jpg\" />";
            //alert("<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclick(\'" + splitID[0] +"_"+  rowNumber+"\');\" src=\"../Images/Delete.jpg\" />");
            cell1.width = "5%";
            cell2.innerHTML = iName;
            cell2.width = "20%"

            cell3.innerHTML = iValue;
            cell3.width = "20%"
            cell4.innerHTML = iUOM;
            cell4.width = "20%";
            document.getElementById(splitID[0] + '_hidCommanPattern').value += "RID:" + rowNumber + "~Name:" + iName + "~Value:" + iValue + "~UOM:" + iUOM + "^";

            document.getElementById(splitID[0] + '_txtName').value = "";
            document.getElementById(splitID[0] + '_txtValue').value = "";
            document.getElementById(splitID[0] + '_txtUOM').value = "";
        }
        return false;
    }

    function ImgOnclick(ImgID) {
        //alert(ImgID);
        var ImgsplitID = ImgID.split('_');
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById(ImgsplitID[0] + '_hidCommanPattern').value;
        var list = HidValue.split('^');

        var newInvList = '';
        if (document.getElementById(ImgsplitID[0] + '_hidCommanPattern').value != "") {
            for (var count = 0; count < list.length; count++) {
                var InvesList = list[count].split('~');
                if (InvesList[0] != '') {
                    if (InvesList[0] != 'RID:' + ImgsplitID[1]) {
                        newInvList += list[count] + '^';
                    }
                }
            }
            document.getElementById(ImgsplitID[0] + '_hidCommanPattern').value = newInvList;
        }
    }

    function LoadExistingCommanPattern(hdnValue, idd) {
        //RID:~Morphology:Morphology~Qualifcation:ification%^
        alert(hdnValue);
        alert(idd);
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
                    z3 = y[3].split(":");
                    alert(z[1]);
                    if (z[1] != "") {

                        var row = document.getElementById(idd + '_tblResult').insertRow(1);
                        var rowID = idd + "_" + z[1];
                        row.id = rowID;
                        row.style.fontWeight = "normal";
                        row.style.fontsize = "10px";
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(4);
                        alert('2');
                        document.getElementById(idd + '_tblResult').style.display = "block";
                        cell1.innerHTML = "<img id=\"imgbtn\" style=\"cursor:pointer;\" OnClick=\"ImgOnclick(\'" + rowID + "\');\" src=\"../Images/Delete.jpg\" />";
                        cell1.width = "5%";
                        cell2.innerHTML = z1[1];
                        cell2.width = "20%"
                        cell3.innerHTML = z2[1];
                        cell3.width = "20%"
                        cell4.innerHTML = z3[1];
                        cell4.width = "20%"
                        alert('3');
                    }
                }
            }
        }
    }
</script>

<table class="defaultfontcolor w-100p">
    <tr>
        <td class="font11 h-20 w-19p a-center" style="font-weight: normal; color: #000;">
            <asp:Label ID="lblName" runat="server" Text="Name" onclick="javascript:changeTestName(this.id);"
                meta:resourcekey="lblNameResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_BioPattern1_ascx_01 %></u></a>
        </td>
        <%--<td style="width: 13%">
            <asp:TextBox ID="txtResult" Height="20%" runat="server"></asp:TextBox>
        </td>
       
        <td style="width: 10%">
            <asp:Label runat="server" ID="lblUOM" CssClass="smalldefaultfontcolor">
            </asp:Label>
        </td>--%>
    </tr>
    <tr>
        <td>
            <table class="dataheaderInvCtrl w-100p">
                <tr class="colorforcontent a-center">
                    <td class="bold font12" style="color: #FFFFFF;">
                        <asp:Label ID="lbliName" runat="server" Text="Name" meta:resourcekey="lbliNameResource1"></asp:Label>
                    </td>
                    <td class="bold font12" style="color: #FFFFFF;">
                        <asp:Label ID="lblValue" runat="server" Text="Value" meta:resourcekey="lblValueResource1"></asp:Label>
                    </td>
                    <td class="bold font12" style="color: #FFFFFF;">
                        <asp:Label ID="lblUom" runat="server" Text="UOM" meta:resourcekey="lblUomResource1"></asp:Label>
                    </td>
                    <td class="w-10p">
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtName" onkeyup="javascript:return setCompletedStatus(this.id);"
                            runat="server" CssClass="small" meta:resourcekey="txtNameResource1"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtValue" CssClass="small" runat="server"
                            meta:resourcekey="txtValueResource1"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtUOM" onkeyup="javascript:return setCompletedStatus(this.id);"
                            runat="server" CssClass="small" meta:resourcekey="txtUOMResource1"></asp:TextBox>
                    </td>
                    <td class="a-left">
                        <asp:Button ID="aResistant" runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" OnClientClick="return CommanPatternADD(this.id);"
                            meta:resourcekey="aResistantResource1" />
                    </td>
                </tr>
            </table>
        </td>
        <td>
            <table>
                <tr>
                    <td class="font10 h-20 w-8p" style="font-weight: normal; color: #000;">
                        <table>
                            <tr>
                                <td class="font10 h-20 w-8p" style="font-weight: normal; color: #000;">
                                    <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                                </td>
                                <td class="font10 h-20 w-8p" style="font-weight: normal; color: #000;">
                                    <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server" 
                                        meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                                </td>
                                <td class="font10 h-20 w-8p" style="font-weight: normal; color: #000;">
                                    <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server" 
                                        meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtRefRange" onkeyup="javascript:return setCompletedStatus(this.id);"
                                        TabIndex="-1" TextMode="MultiLine" CssClass="small" meta:resourcekey="txtRefRangeResource1"></asp:TextBox>
                                    <asp:HiddenField ID="hdnXmlContent" runat="server" />
                                </td>
                                <td>
                                    <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtReason" onkeyup="javascript:return setCompletedStatus(this.id);"
                                        TabIndex="-1" TextMode="MultiLine" CssClass="small" meta:resourcekey="txtReasonResource1"></asp:TextBox>
                                    <asp:HiddenField ID="hidVal" runat="server" />
                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                        TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                                        EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                        DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                                    </ajc:AutoCompleteExtender>
                                    <asp:HiddenField ID="hdnRemarksID" runat="server" />
                                </td>
                                <td class="font10 h-50 w-8p" style="font-weight: normal; color: #000;">
                                    <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtMedRemarks"
                                        onkeyup="javascript:return setCompletedStatus(this.id);" TabIndex="-1" TextMode="MultiLine"
                                        CssClass="small" meta:resourcekey="txtReasonResource1"></asp:TextBox>
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
                    <td class="w-50p">
                        <table>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td class="font10 h-10" style="font-weight: normal; color: #000;">
                                    <table id="tdInvStatusReason1" runat="server" style="display: none;">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblReason" Text="Reason" runat="server" 
                                                    meta:resourcekey="lblReasonResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <table id="tdInvStatusOpinion1" runat="server" style="display: none;">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblOpinionUser" runat="server" Text="User" 
                                                    meta:resourcekey="lblOpinionUserResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" CssClass="ddlsmall"
                                        onChange="javascript:CheckIfEmpty(this.id,'txtValue');ShowStatusReason(this.id);"
                                        meta:resourcekey="ddlstatusResource1">
                                        <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <table id="tdInvStatusReason2" runat="server" style="display: none;">
                                        <tr>
                                            <td>
                                                <asp:DropDownList ForeColor="Black" CssClass="ddlsmall" ID="ddlStatusReason" runat="server"
                                                    TabIndex="-1" onmousedown="expandDropDownList(this);" 
                                                    onblur="collapseDropDownList(this);" 
                                                    meta:resourcekey="ddlStatusReasonResource1">
                                                    <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                    <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                                        <tr>
                                            <td>
                                                <span class="richcombobox w-100">
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
        </td>
    </tr>
    <tr>
        <td>
            <table id="tblResult" class="dataheaderInvCtrl w-100p" runat="server" cellpadding="4"
                style="display: none;">
                <tr class="colorforcontent">
                    <td class="font11 h-8 bold w-5p" style="color: White;">
                        <asp:Label ID="Rs_Delete" Text="Delete" runat="server" meta:resourcekey="Rs_DeleteResource1"></asp:Label>
                    </td>
                    <td class="font11 h-8 bold w-20p" style="color: White;">
                        <asp:Label ID="Rs_Name" Text="Name" runat="server" meta:resourcekey="Rs_NameResource1"></asp:Label>
                    </td>
                    <td class="font11 h-8 bold w-20p" style="color: White;">
                        <asp:Label ID="Rs_Value" Text="Value" runat="server" meta:resourcekey="Rs_ValueResource1"></asp:Label>
                    </td>
                    <td class="font11 h-8 bold w-20p" style="color: White;">
                        <asp:Label ID="Rs_UOM" Text="UOM" runat="server" meta:resourcekey="Rs_UOMResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <asp:HiddenField runat="server" ID="hidCommanPattern" />
            <%--<input type="text" id="hidCommanPattern" runat="server"/>--%>
        </td>
    </tr>
</table>
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnPrintableRange" runat="server" Value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
</style>
