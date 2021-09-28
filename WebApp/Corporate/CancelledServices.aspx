<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CancelledServices.aspx.cs"
    Inherits="Corporate_CancelledServices" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="PhyHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript" language="javascript">
        function checkFeeType(chkid) {
            var grid = document.getElementById('grdRefund');
            var len1 = grid.rows.length;
            var flag = 0;
            var setCheck = 1;
            var len = document.forms[0].elements.length;
            if (len1 > 0) {
                for (var i = 1; i < len1; i++) {
                    var grdChk = grid.rows[i].childNodes[0].childNodes[0].id;
                    if (grdChk != "") {
                        var grdFeeType = grid.rows[i].childNodes[5].childNodes[0].id;
                        if (grdChk == chkid) {
                            var TID = document.getElementById(grdFeeType).innerText;
                            if (document.getElementById(grdFeeType).innerText != "") {
                                if (document.getElementById(grdChk).checked == true) {

                                    flag = 1;
                                }
                                else {
                                    if (flag == 0 && document.getElementById(grdFeeType).innerText == TID) {
                                        setCheck = 0;
                                        flag = 1;
                                    }
                                }
                            }
                        }
                    }
                }
                if (flag == 1) {
                    for (var i = 1; i < len1; i++) {
                        var grdChk = grid.rows[i].childNodes[0].childNodes[0].id;
                        if (grdChk != "") {
                            var grdFeeType = grid.rows[i].childNodes[5].childNodes[0].id;
                            if (document.getElementById(grdFeeType).innerText == TID) {
                                document.getElementById(grdChk).checked = true;

                            }
                            if (setCheck == 0) {
                                if (document.getElementById(grdFeeType).innerText == TID) {
                                    document.getElementById(grdChk).checked = false;

                                }
                            }


                        }
                    }
                    if (setCheck != 0) {
                        alert("Cancelling will cause one or more related services also to get cancelled and they need to be ordered again. Do you wish to continue?");
                    }
                }

            }
        }

        function ChequeValidate1() {
            var grid = document.getElementById('grdRefund');
            var len1 = grid.rows.length;
            var flag = 0;
            var len = document.forms[0].elements.length;
            if (len1 > 0) {
                for (var i = 1; i < len1; i++) {
                    var grdChk = grid.rows[i].childNodes[0].childNodes[0].id;
                    if (grdChk != "") {
                        var grdRfdTxt = grid.rows[i].childNodes[4].childNodes[0].id;
                        if (document.getElementById(grdChk).checked == true) {
                            flag = 1;
                            if (document.getElementById(grdRfdTxt).value == "") {
                                alert('Please provide the reason for cancelling the service');
                                document.getElementById(grdRfdTxt).focus();
                                return false;
                            }
                        }
                        else {
                            if (flag == 0) {
                                flag = -1;
                            }
                        }
                    }
                    
                }
                if (flag == -1) {
                    alert('Please select a Service to Cancel');
                    return false;
                }
                if (flag == 0) {
                    alert('Already canceled this service.');
                    return false;
                }
            }
        }
        function checkInv() {
            var grid = document.getElementById('grdRefund');
            var len1 = grid.rows.length;
            if (len1 > 0) {
                for (var i = 1; i < len1; i++) {
                    var grdChk = grid.rows[i].childNodes[0].childNodes[0].id;
                    var feeType = grid.rows[i].cells[2].innerText;
                    if (feeType == "INV") {
                        document.getElementById('grdChk').checked = true;
                    }
                }
            }
        }
        function ServiceSelectBillID(Cid, Feetype, Reasontext) {
            var len = document.forms[0].elements.length;
            var TblgrdRefund = document.getElementById('grdRefund');
            var grdlength;
            if (TblgrdRefund == null) {
                grdlength = 0;
            }
            else {
                grdlength = TblgrdRefund.rows.length;
            }
            for (i = 1; i <= grdlength - 1; i++) {
                var desigID = TblgrdRefund.rows[i].cells[0].innerHTML;
                var designame = TblgrdRefund.rows[i].cells[2].innerHTML;
                if (designame == 'INV') {
                    alert("Name Already Exit");
                    return false;
                }
            }
            if (Feetype == 'INV' || Feetype == 'GRP' || Feetype == 'PKG') {
                if (document.getElementById(Cid).checked == true) {
                    if (document.getElementById('<%=hdnFeetype.ClientID %>').value == 1) {
                        alert('Select All Investigation.Return to Order Investigation');
                        document.getElementById('<%=hdnFeetype.ClientID %>').value = 2;
                    }

                }
            }

        }
        function FnIsvalid(obj) {
            if (obj = 1) {
                alert("The service(s) have been Canceled successfully.");
                document.getElementById('btnCancel').click();

            }
            else {
                alert("The service(s) have been Faild.");
                return false;
            }

        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="userHeader" runat="server" />
                <uc7:PhyHeader ID="physicianHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <div class="dataheader3">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label1" runat="server" Text="Service Number: " 
                                                        meta:resourcekey="Label1Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label3" runat="server" Text=": " 
                                                        meta:resourcekey="Label3Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblServiceNo" runat="server" 
                                                        meta:resourcekey="lblServiceNoResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label2" runat="server" Text="Employee / Dependents Name " 
                                                        meta:resourcekey="Label2Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label4" runat="server" Text=": " 
                                                        meta:resourcekey="Label4Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblEmpName" runat="server" 
                                                        meta:resourcekey="lblEmpNameResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:Panel ID="pnlptDetails" CssClass="dataheader2" BorderWidth="1px" 
                                            runat="server" meta:resourcekey="pnlptDetailsResource1">
                                            <table width="100%" class="dataheader2 defaultfontcolor" border="0" cellpadding="0"
                                                cellspacing="0">
                                                <tr style="height: 15px;" class="Duecolor">
                                                    <td colspan="10">
                                                        <b>Patient Details</b>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 9%">
                                                        <asp:Label ID="Label5" Text="Patient No: " runat="server" 
                                                            meta:resourcekey="Label5Resource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblPNo" runat="server" meta:resourcekey="lblPNoResource1"></asp:Label>
                                                    </td>
                                                    <td style="width: 5%">
                                                        <asp:Label ID="Label6" Text="Name: " runat="server" 
                                                            meta:resourcekey="Label6Resource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                                                    </td>
                                                    <td style="width: 9%">
                                                        <asp:Label ID="Label7" Text="Visit Date: " runat="server" 
                                                            meta:resourcekey="Label7Resource1"></asp:Label>
                                                    </td>
                                                    <td style="width: 9%">
                                                        <asp:Label ID="lblDate" runat="server" meta:resourcekey="lblDateResource1"></asp:Label>
                                                    </td>
                                                    <td style="width: 4%">
                                                        <asp:Label ID="Label8" Text="Age: " runat="server" 
                                                            meta:resourcekey="Label8Resource1"></asp:Label>
                                                    </td>
                                                    <td style="width: 9%">
                                                        <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                                    </td>
                                                    <td style="width: 4%">
                                                        <asp:Label ID="Label9" Text="Sex: " runat="server" 
                                                            meta:resourcekey="Label9Resource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblSex" runat="server" meta:resourcekey="lblSexResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="grdRefund" Width="100%" CellPadding="4" AutoGenerateColumns="False"
                                        DataKeyNames="BillingDetailsID" oreColor="#333333" CssClass="mytable1" runat="server"
                                        OnRowDataBound="grdRefund_RowDataBound" 
                                        meta:resourcekey="grdRefundResource1">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <Columns>
                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkRefund" onclick="return checkFeeType(this.id);" runat="server"
                                                        meta:resourcekey="chkRefundResource1" />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField Visible="False" HeaderText="Bill No" meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBillDetailsID" runat="server" Text='<%# Bind("BillingDetailsID") %>'
                                                        meta:resourcekey="lblBillDetailsIDResource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Bill No" meta:resourcekey="TemplateFieldResource3">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFinalBillID" runat="server" Text='<%# Bind("BillNumber") %>' meta:resourcekey="lblFinalBillIDResource1"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Fee Type" Visible="false" 
                                                meta:resourcekey="TemplateFieldResource4">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFeeType" runat="server" Text='<%# Bind("FeeType") %>' 
                                                        meta:resourcekey="lblFeeTypeResource1"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="0%" />
                                            </asp:TemplateField>
                                            <%--  <asp:BoundField DataField="FeeType"  HeaderText="Fee Type" meta:resourcekey="BoundFieldResource1">
                                                <ItemStyle HorizontalAlign="Left" Width="0%" />
                                            </asp:BoundField>--%>
                                            <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource4">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDescription" runat="server" Text='<%# Bind("FeeDescription") %>'
                                                        meta:resourcekey="lblDescriptionResource1"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="35%" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="FORENAME" HeaderText="Received By" meta:resourcekey="BoundFieldResource2">
                                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Billed Amount" meta:resourcekey="TemplateFieldResource5"
                                                Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("Amount","{0:0.00}") %>'
                                                        meta:resourcekey="lblAmountResource1"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Right" Width="15%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Reason" meta:resourcekey="TemplateFieldResource9">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtRfdReason" MaxLength="255" Width="100%" Text='<%# Bind("Remarks") %>'
                                                        runat="server" meta:resourcekey="txtRfdReasonResource1"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="20%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Task ID" 
                                                meta:resourcekey="TemplateFieldResource6">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTaskID" runat="server" Text='<%# Bind("TaskID") %>' 
                                                        meta:resourcekey="lblTaskIDResource1"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="0%" />
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table align="center">
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnSubmit" runat="server" Text="Cancel Service" CssClass="btn" OnClientClick="return ChequeValidate1();"
                                                    OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnCancel" runat="server" Text="Close" CssClass="btn" 
                                                    OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <asp:HiddenField ID="hdnCon" runat="server" />
                        <asp:HiddenField ID="hdnLab" runat="server" />
                        <asp:HiddenField ID="hdntaskstatusID" runat="server" />
                        <asp:HiddenField ID="hdnLabtaskstatusID" runat="server" />
                        <asp:HiddenField ID="hdnFeetype" runat="server" Value="1" />
                    </div>
                    <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
