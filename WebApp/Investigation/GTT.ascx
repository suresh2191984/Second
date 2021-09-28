<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GTT.ascx.cs" Inherits="Investigation_GTT" %>
<style type="text/css">
    .style1
    {
        width: 76px;
    }
    .style2
    {
        width: 124px;
    }
    .style3
    {
        width: 50px;
    }
    .style4
    {
        width: 78px;
    }
    .style5
    {
        width: 453px;
    }
</style>

<script language="javascript" type="text/javascript">
    function LoadOrdItems(ID) {
        // alert("LoadOrdItems :" + ID);
        var splitString = ID.split('_');
        // alert("LoadOrdItems[0] :" + splitString[0]);
        var HidValue = document.getElementById(splitString[0] + '_hdnGtt').value;
        var list = HidValue.split('^');

        //1~1:00 Am~~+^2~1:00 Am~fsfsd~+^3~1:00 Am~fsfsd~+^
        if (document.getElementById(splitString[0] + '_hdnGtt').value != "") {
            document.getElementById(ID).style.display = "block";
            for (var count = 0; count < list.length - 1; count++) {

                var InvesList = list[count].split('~');
                //total = document.getElementById('InvestigationControl1_lblTotal').innerHTML;
                var row = document.getElementById(ID).insertRow(1);
                row.id = InvesList[0];
                //alert(HidValue);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + InvesList[0] + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = InvesList[1];
                cell2.width = "35%";
                cell3.innerHTML = InvesList[2];
                cell3.width = "35%";
                cell4.innerHTML = InvesList[3];
                cell4.width = "30%";
            }
            //  alert('load');

        }
    }

    function GttADD(id) {

        var splitID = id.split('_');
        var type;
        var hh;
        var min;
        var iUOM;
        var Sess;
        var bldResult;
        var AddStatus = 0;
        var rowNumber = 0;

        var HidValue = document.getElementById(splitID[0] + '_hdnGtt').value;

        time = document.getElementById(splitID[0] + '_ddlTime7').options[document.getElementById(splitID[0] + '_ddlTime7').selectedIndex].text;

        min = document.getElementById(splitID[0] + '_ddlMin7').options[document.getElementById(splitID[0] + '_ddlMin7').selectedIndex].text;
        Sess = document.getElementById(splitID[0] + '_DropDownList7').options[document.getElementById(splitID[0] + '_DropDownList7').selectedIndex].text;
        bldResult = document.getElementById(splitID[0] + '_TextBox6').value;
        var UrnResult;

        if (document.getElementById(splitID[0] + '_ddldata7').options[document.getElementById(splitID[0] + '_ddldata7').selectedIndex].text != 'Select') {
            UrnResult = document.getElementById(splitID[0] + '_ddldata7').options[document.getElementById(splitID[0] + '_ddldata7').selectedIndex].text;
        }
        else {
            UrnResult = '';
        }

        //alert(splitID[0]);
        if ((time != "") || (min != "") || (Sess != "")) {
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
            cell2.innerHTML = time + ":" + min + " " + Sess;
            cell2.width = "20%"
            cell3.innerHTML = bldResult;
            cell3.width = "20%"
            cell4.innerHTML = UrnResult;
            cell4.width = "20%";
            //document.getElementById(splitID[0] + '_hdnGtt').value += "RID:" + rowNumber + "~Time:" + time + " " + min + " " + Sess + "~BRes:" + bldResult + "~Ures:" + UrnResult + "^";
            document.getElementById(splitID[0] + '_hdnGtt').value += rowNumber + "~" + time + ":" + min + " " + Sess + "~" + bldResult + "~" + UrnResult + "^";
            //            document.getElementById(splitID[0] + '_txtName').value = "";
            //            document.getElementById(splitID[0] + '_txtValue').value = "";
            //            document.getElementById(splitID[0] + '_txtUOM').value = "";
        }
        return false;
    }

    function ImgOnclick(ImgID) {
        //alert(ImgID);
        var ImgsplitID = ImgID.split('_');
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById(ImgsplitID[0] + '_hdnGtt').value;
        var list = HidValue.split('^');

        var newInvList = '';
        if (document.getElementById(ImgsplitID[0] + '_hdnGtt').value != "") {
            for (var count = 0; count < list.length; count++) {
                var InvesList = list[count].split('~');
                if (InvesList[0] != '') {
                    if (InvesList[0] != ImgsplitID[1]) {
                        newInvList += list[count] + '^';
                    }
                }
            }
            document.getElementById(ImgsplitID[0] + '_hdnGtt').value = newInvList;
        }
    }
</script>

<table class="w-100p">
    <tr>
        <td>
            <asp:Panel ID="pnlEnabled" runat="server" CssClass="w-100p" meta:resourcekey="pnlEnabledResource1">
                <table class="w-100p" style="border-collapse: collapse;">
                    <tr>
                        <td colspan="5">
                            <asp:Label ID="lblName" runat="server" onclick="javascript:changeTestName(this.id);"
                                meta:resourcekey="lblNameResource1"></asp:Label>
                            &nbsp;
                            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                                ForeColor="Red" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
                            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
                            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                                visible="False"><u><%=Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReport_aspx_08 %></u></a>
                        </td>
                        <td>
                            <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                        </td>
                        <td colspan="2">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" runat="server" ID="txtRefRange" TextMode="MultiLine"
                                CssClass="small" meta:resourcekey="txtRefRangeResource1"></asp:TextBox>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        &nbsp;
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
                                </tr>
                                <tr>
                                    <td>
                                        <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" meta:resourcekey="ddlstatusResource1"
                                            CssClass="ddlsmall">
                                            <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <table id="tdInvStatusReason2" runat="server" style="display: none;">
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                                                        CssClass="ddlsmall" onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);">
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
                    <tr>
                        <td class="a-center" colspan="4">
                            <asp:Label ID="Rs_Time" Text="Time" runat="server" meta:resourcekey="Rs_TimeResource1"></asp:Label>
                        </td>
                        <td class="style2">
                            <asp:Label ID="Rs_BloodGlucose" Text="Blood Glucose" runat="server" meta:resourcekey="Rs_BloodGlucoseResource1"></asp:Label>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="Rs_Units" Text="Units" runat="server" meta:resourcekey="Rs_UnitsResource1"></asp:Label>
                        </td>
                        <td class="style5" colspan="2">
                            <asp:Label ID="Rs_UrineGlucose" Text="Urine Glucose" runat="server" meta:resourcekey="Rs_UrineGlucoseResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            <asp:Label ID="lblFasting" runat="server" Text="Fasting" meta:resourcekey="lblFastingResource1"></asp:Label>
                        </td>
                        <td class="w-25">
                            <asp:DropDownList ForeColor="Black" ID="ddlTime1" runat="server" Visible="False"
                                CssClass="ddlsmall" meta:resourcekey="ddlTime1Resource1">
                            </asp:DropDownList>
                        </td>
                        <td class="style4">
                            <asp:DropDownList ForeColor="Black" ID="ddlMin1" runat="server" meta:resourcekey="ddlMin1Resource1"
                                CssClass="ddlsmall">
                            </asp:DropDownList>
                        </td>
                        <td class="style3">
                            <asp:DropDownList ForeColor="Black" ID="DropDownList1" runat="server" Visible="False"
                                CssClass="ddlsmall" meta:resourcekey="DropDownList1Resource1">
                               <%-- <asp:ListItem Text="am" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                <asp:ListItem Text="pm" meta:resourcekey="ListItemResource3"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </td>
                        <td class="style2 a-center">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtBox" runat="server" CssClass="small"
                                meta:resourcekey="txtBoxResource1"></asp:TextBox>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="lblUom1" runat="server" Text="mg/dl" meta:resourcekey="lblUom1Resource1"></asp:Label>
                        </td>
                        <td class="style5" colspan="2">
                            <asp:DropDownList ForeColor="Black" ID="ddlData1" runat="server" meta:resourcekey="ddlData1Resource1"
                                CssClass="ddlsmall">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            <asp:Label runat="server" ID="lblGlucose" Text="Glucose" meta:resourcekey="lblGlucoseResource1"></asp:Label>
                        </td>
                        <td colspan="8">
                            &nbsp;
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="txtGlucose" runat="server" CssClass="small"
                                meta:resourcekey="txtGlucoseResource1"></asp:TextBox>
                            &nbsp;
                            <asp:Label ID="lblGlucoseUOM" runat="server" Text="gm" meta:resourcekey="lblGlucoseUOMResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ForeColor="Black" ID="ddlTime0" runat="server" Visible="False"
                                CssClass="ddlsmall" meta:resourcekey="ddlTime0Resource1">
                            </asp:DropDownList>
                        </td>
                        <td class="style4">
                            <asp:DropDownList ForeColor="Black" ID="ddlMin0" runat="server" meta:resourcekey="ddlMin0Resource1"
                                CssClass="ddlsmall">
                            </asp:DropDownList>
                        </td>
                        <td class="style3">
                            <asp:DropDownList ForeColor="Black" ID="DropDownList0" runat="server" Visible="False"
                                CssClass="ddlsmall" meta:resourcekey="DropDownList0Resource1">
                               <%-- <asp:ListItem Text="am" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                <asp:ListItem Text="pm" meta:resourcekey="ListItemResource5"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </td>
                        <td class="style2" class="a-center">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="TextBox0" runat="server" CssClass="small"
                                meta:resourcekey="TextBox0Resource1"></asp:TextBox>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="lblUOM0" runat="server" Text="mg/dl" meta:resourcekey="lblUOM0Resource1"></asp:Label>
                        </td>
                        <td class="style5" colspan="2">
                            <asp:DropDownList ForeColor="Black" ID="ddlData0" runat="server" meta:resourcekey="ddlData0Resource1"
                                CssClass="ddlsmall">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ForeColor="Black" ID="ddlTime2" runat="server" Visible="False"
                                CssClass="ddlsmall" meta:resourcekey="ddlTime2Resource1">
                            </asp:DropDownList>
                        </td>
                        <td class="style4">
                            <asp:DropDownList ForeColor="Black" ID="ddlMin2" runat="server" meta:resourcekey="ddlMin2Resource1"
                                CssClass="ddlsmall">
                            </asp:DropDownList>
                        </td>
                        <td class="style3">
                            <asp:DropDownList ForeColor="Black" ID="DropDownList2" runat="server" Visible="False"
                                CssClass="ddlsmall" meta:resourcekey="DropDownList2Resource1">
                               <%-- <asp:ListItem Text="am" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                <asp:ListItem Text="pm" meta:resourcekey="ListItemResource7"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </td>
                        <td class="style2" class="a-center">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="TextBox1" runat="server" CssClass="small"
                                meta:resourcekey="TextBox1Resource1"></asp:TextBox>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="lblUOM2" runat="server" Text="mg/dl" meta:resourcekey="lblUOM2Resource1"></asp:Label>
                        </td>
                        <td class="style5" colspan="2">
                            <asp:DropDownList ForeColor="Black" ID="ddlData2" runat="server" meta:resourcekey="ddlData2Resource1"
                                CssClass="ddlsmall">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ForeColor="Black" ID="ddlTime3" runat="server" Visible="False"
                                CssClass="ddlsmall" meta:resourcekey="ddlTime3Resource1">
                            </asp:DropDownList>
                        </td>
                        <td class="style4">
                            <asp:DropDownList ForeColor="Black" ID="ddlMin3" runat="server" meta:resourcekey="ddlMin3Resource1"
                                CssClass="ddlsmall">
                            </asp:DropDownList>
                        </td>
                        <td class="style3">
                            <asp:DropDownList ForeColor="Black" ID="DropDownList3" runat="server" Visible="False"
                                CssClass="ddlsmall" meta:resourcekey="DropDownList3Resource1">
                                <%--<asp:ListItem Text="am" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                <asp:ListItem Text="pm" meta:resourcekey="ListItemResource9"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </td>
                        <td class="style2" class="a-center">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="TextBox2" runat="server" CssClass="small"
                                meta:resourcekey="TextBox2Resource1"></asp:TextBox>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="lblUOM3" runat="server" Text="mg/dl" meta:resourcekey="lblUOM3Resource1"></asp:Label>
                        </td>
                        <td class="style5" colspan="2">
                            <asp:DropDownList ForeColor="Black" ID="ddlData3" runat="server" meta:resourcekey="ddlData3Resource1"
                                CssClass="ddlsmall">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ForeColor="Black" ID="ddlTime4" runat="server" Visible="False"
                                CssClass="ddlsmall" meta:resourcekey="ddlTime4Resource1">
                            </asp:DropDownList>
                        </td>
                        <td class="style4">
                            <asp:DropDownList ForeColor="Black" ID="ddlMin4" runat="server" meta:resourcekey="ddlMin4Resource1"
                                CssClass="ddlsmall">
                            </asp:DropDownList>
                        </td>
                        <td class="style3">
                            <asp:DropDownList ForeColor="Black" ID="DropDownList4" runat="server" CssClass="ddlsmall"
                                Visible="False" meta:resourcekey="DropDownList4Resource1">
                               <%-- <asp:ListItem Text="am" meta:resourcekey="ListItemResource10"></asp:ListItem>
                                <asp:ListItem Text="pm" meta:resourcekey="ListItemResource11"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </td>
                        <td class="style2 a-center">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="TextBox3" runat="server" CssClass="small"
                                meta:resourcekey="TextBox3Resource1"></asp:TextBox>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="lblUOM4" runat="server" Text="mg/dl" meta:resourcekey="lblUOM4Resource1"></asp:Label>
                        </td>
                        <td class="style5" colspan="2">
                            <asp:DropDownList ForeColor="Black" ID="ddlData4" runat="server" meta:resourcekey="ddlData4Resource1"
                                CssClass="ddlsmall">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ForeColor="Black" ID="ddlTime5" runat="server" Visible="False"
                                CssClass="ddlsmall" meta:resourcekey="ddlTime5Resource1">
                            </asp:DropDownList>
                        </td>
                        <td class="style4">
                            <asp:DropDownList ForeColor="Black" ID="ddlMin5" runat="server" meta:resourcekey="ddlMin5Resource1"
                                CssClass="ddlsmall">
                            </asp:DropDownList>
                        </td>
                        <td class="style3">
                            <asp:DropDownList ForeColor="Black" ID="DropDownList5" runat="server" Visible="False"
                                CssClass="ddlsmall" meta:resourcekey="DropDownList5Resource1">
                               <%-- <asp:ListItem Text="am" meta:resourcekey="ListItemResource12"></asp:ListItem>
                                <asp:ListItem Text="pm" meta:resourcekey="ListItemResource13"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </td>
                        <td class="style2 a-center">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="TextBox4" runat="server" CssClass="small"
                                meta:resourcekey="TextBox4Resource1"></asp:TextBox>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="lblUOM5" runat="server" Text="mg/dl" meta:resourcekey="lblUOM5Resource1"></asp:Label>
                        </td>
                        <td class="style5" colspan="2">
                            <asp:DropDownList ForeColor="Black" ID="ddlData5" runat="server" meta:resourcekey="ddlData5Resource1"
                                CssClass="ddlsmall">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ForeColor="Black" ID="ddlTime6" runat="server" Visible="False"
                                CssClass="ddlsmall" meta:resourcekey="ddlTime6Resource1">
                            </asp:DropDownList>
                        </td>
                        <td class="style4">
                            <asp:DropDownList ForeColor="Black" ID="ddlMin6" runat="server" meta:resourcekey="ddlMin6Resource1"
                                CssClass="ddlsmall">
                            </asp:DropDownList>
                        </td>
                        <td class="style3">
                            <asp:DropDownList ForeColor="Black" ID="DropDownList6" runat="server" Visible="False"
                                CssClass="ddlsmall" meta:resourcekey="DropDownList6Resource1">
                               <%-- <asp:ListItem Text="am" meta:resourcekey="ListItemResource14"></asp:ListItem>
                                <asp:ListItem Text="pm" meta:resourcekey="ListItemResource15"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </td>
                        <td class="style2 a-center">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="TextBox5" runat="server" CssClass="small"
                                meta:resourcekey="TextBox5Resource1"></asp:TextBox>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="lblUOM6" runat="server" Text="mg/dl" meta:resourcekey="lblUOM6Resource1"></asp:Label>
                        </td>
                        <td class="style5" colspan="2">
                            <asp:DropDownList ForeColor="Black" ID="ddlData6" runat="server" meta:resourcekey="ddlData6Resource1"
                                CssClass="ddlsmall">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            &nbsp;
                        </td>
                        <td>
                            <asp:DropDownList ForeColor="Black" ID="ddlTime7" runat="server" Visible="False"
                                CssClass="ddlsmall" meta:resourcekey="ddlTime7Resource1">
                            </asp:DropDownList>
                        </td>
                        <td class="style4">
                            <asp:DropDownList ForeColor="Black" ID="ddlMin7" runat="server" meta:resourcekey="ddlMin7Resource1"
                                CssClass="ddlsmall">
                            </asp:DropDownList>
                        </td>
                        <td class="style3">
                            <asp:DropDownList ForeColor="Black" ID="DropDownList7" runat="server" Visible="False"
                                CssClass="ddlsmall" meta:resourcekey="DropDownList7Resource1">
                                <%--<asp:ListItem Text="am" meta:resourcekey="ListItemResource16"></asp:ListItem>
                                <asp:ListItem Text="pm" meta:resourcekey="ListItemResource17"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </td>
                        <td class="style2 a-center">
                            <asp:TextBox ForeColor="Black" Font-Bold="true" ID="TextBox6" runat="server" CssClass="small"
                                meta:resourcekey="TextBox6Resource1"></asp:TextBox>
                        </td>
                        <td colspan="2">
                            <asp:Label ID="lblUOM7" runat="server" Text="mg/dl" meta:resourcekey="lblUOM7Resource1"></asp:Label>
                        </td>
                        <td class="style5" colspan="2">
                            <asp:DropDownList ForeColor="Black" ID="ddldata7" runat="server" meta:resourcekey="ddldata7Resource1"
                                CssClass="ddlsmall">
                            </asp:DropDownList>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="GttAdd" runat="server" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                onmouseout="this.className='btn'" OnClientClick="return GttADD(this.id);" meta:resourcekey="GttAddResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="9">
                            <asp:HiddenField ID="hdnGtt" runat="server" />
                            <asp:HiddenField ID="hdnFirstLoad" runat="server" />
                            <table id="tblResult" class="dataheaderInvCtrl w-100p" runat="server" style="display: none;">
                                <tr class="colorforcontent" runat="server">
                                    <td class="bold font11 h-8 w-5p" style=" color: White;" runat="server">
                                        <asp:Label ID="Rs_Delete" Text="Delete" runat="server"></asp:Label>
                                    </td>
                                    <td class="bold font11 h-8 w-20p" style="color: White;" runat="server">
                                        <asp:Label ID="Rs_Time1" Text="Time" runat="server"></asp:Label>
                                    </td>
                                    <td class="bold font11 h-8 w-20p" style="color: White;" runat="server">
                                        <asp:Label ID="Rs_BloodResult" Text="Blood Result" runat="server"></asp:Label>
                                    </td>
                                    <td class="bold font11 h-8 w-20p" style="color: White;" runat="server">
                                        <asp:Label ID="Rs_UrineResult" Text="Urine Result" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
</table>
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
