<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CashDenominationForm.aspx.cs"
    Inherits="Cashier_CashDenominationForm" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Cash Closure Denomination</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        function blacktext(e) {

            //if (!((e.keyCode >= 48) && (e.keyCode <= 57) && e.keyCode == 46) {
            if (!((e.keyCode >= 48) && (e.keyCode <= 57))) {
                //alert("Only Digits Are Allowed");
                if (e.keyCode == 46) {
                    return true;
                }
                else {
                    e.keyCode = 0;
                }
            }

        }
        function openPOPupQuick(url) {
            window.open(url, "PrictBill", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
        }
        function CalcItemCost(lblDetail, txtAmount, lblSumAmt, hdnSumAmount, hdnOldPrice) {

            var lblDetail = document.getElementById(lblDetail);
            var txtAmount = document.getElementById(txtAmount);
            var lblSumAmt = document.getElementById(lblSumAmt);
            var hdnTotalAmount = document.getElementById('<%= hdnTotalAmount.ClientID %>').value;
            var txtGrand = document.getElementById('<%= txtGrand.ClientID %>').value;
            var hdnSumAmount = document.getElementById(hdnSumAmount);
            var hdnOldPrice = document.getElementById(hdnOldPrice);
            var sumAmount = 0;
            hdnTotalAmount = chkIsnumber(hdnTotalAmount);
            lblDetail.innerHTML = chkIsnumber(lblDetail.innerHTML);
            txtAmount.value = chkIsnumber(txtAmount.value);
            sumAmount = (Number(lblDetail.innerHTML) * Number(txtAmount.value));
            var hdnOldPriceDelete = chkIsnumber(hdnOldPrice.value)
            lblSumAmt.innerHTML = sumAmount.toFixed(2);
            hdnSumAmount.value = sumAmount.toFixed(2);
            hdnOldPrice.value = sumAmount.toFixed(2);
            document.getElementById('<%= hdnTotalAmount.ClientID %>').value = (Number(chkIsnumber(hdnTotalAmount)) + sumAmount - Number(hdnOldPriceDelete)).toFixed(2);
            hdnTotalAmount = Number(hdnTotalAmount) + sumAmount;
            document.getElementById('txtGrand').value = document.getElementById('<%= hdnTotalAmount.ClientID %>').value;

        }
        function validateAmt() {
            var _actualAmt = document.getElementById('lblClosingBalance').innerHTML;
            var _paidAmt = document.getElementById('<%= hdnTotalAmount.ClientID %>').value;
            if (Number(chkIsnumber(_actualAmt)) < Number(chkIsnumber(_paidAmt))) {
                alert('Denomination amount Cannot be greater than Cash Closure Amount');
                return false;
            } 
            if(Number(chkIsnumber(_actualAmt)) > Number(chkIsnumber(_paidAmt))) {
                var ans = window.confirm('Cash Closure amount Greater than Denomination Amount.\n Do you want to continue?');
                if (ans == true) {
                    $get('btnSubmit').disabled = true;
                    javascript: __doPostBack('btnSubmit', '');

                }
                return false;
                
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="ReceptionHeader" runat="server" />
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
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table cellpadding="2" cellspacing="1" width="100%">
                                    <tr>
                                        <td style="text-align: left;" colspan="2">
                                            <div class="dataheader2" id="divtimeDisplay" runat="server">
                                                <asp:Label ID="lblReceivedTime" Style="text-align: left; padding-left: 5px;" runat="server"></asp:Label>
                                                <br />
                                                <asp:Label ID="lblRefundTime" Style="text-align: left; padding-left: 5px;" runat="server"></asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;">
                                            Total Collected Amount&nbsp;&nbsp;
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:Label ID="lblTotal" runat="server" Text="0.00"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;">
                                            Total Refunded Amount&nbsp;&nbsp;
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:Label ID="lblRefund" runat="server" Text="0.00"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;">
                                            Total Cancelled Bill Amount&nbsp;&nbsp;
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:Label ID="lblCancelledAmount" runat="server" Text="0.00"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;">
                                            Total Paid Amount to Physician&nbsp;&nbsp;
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:Label ID="lblPhyAmount" runat="server" Text="0.00"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;">
                                            Total Paid Miscellaneous Amount&nbsp;&nbsp;
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:Label ID="lblOthersAmount" runat="server" Text="0.00"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;">
                                            Closing Balance&nbsp;&nbsp;
                                        </td>
                                        <td style="text-align: right;">
                                            <asp:Label ID="lblClosingBalance" runat="server" Text="0.00"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trCashInHand" runat="server">
                                        <td colspan="2">
                                            <table cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td colspan="2">
                                                        --------------------------------------------------------------------
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: right; font-weight: bold;" valign="top">
                                                        Closing Cash In Hand:&nbsp;&nbsp;
                                                    </td>
                                                    <td style="text-align: right;">
                                                        <asp:Label ID="lblClosingCashInHand" ForeColor="Green" runat="server" Text="0.00"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="2">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                        </td>
                                        <td align="center">
                                        </td>
                                    </tr>
                                </table>
                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            <asp:GridView ID="grdResult" Width="100%" CellPadding="4" AutoGenerateColumns="False"
                                                ForeColor="#333333" CssClass="mytable1" runat="server" OnRowDataBound="grdResult_RowDataBound">
                                                <HeaderStyle CssClass="dataheader1" />
                                                <Columns>
                                                    <asp:TemplateField ItemStyle-Width="1%" HeaderText="S.No">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="ID" Visible="false">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblID" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ID") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Details">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDetail" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Rupees") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="left" Width="2%" />
                                                        <HeaderStyle Width="30px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Unit">
                                                        <ItemTemplate>
                                                            <asp:TextBox style="text-align:right;" onblur="if(this.value!='')this.value=parseFloat(this.value).toFixed(2);"    onkeypress="return ValidateOnlyNumeric(this);"   ID="txtAmount" Width="100px" Text="0.00"
                                                                runat="server"></asp:TextBox>
                                                            <asp:HiddenField ID="hdnOldPrice" Value="0.00" runat="server" />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Right" Width="5%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Amount">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSumAmt" Text="0.00" runat="server"></asp:Label>
                                                            <asp:HiddenField ID="hdnSumAmount" Value="0.00" runat="server" />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Right" Width="5%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:Label Text="Sum" runat="server" ID="lblTotalSum"></asp:Label>
                                            <asp:TextBox Style="text-align: right;" Width="5%" ReadOnly="true" Enabled="false"
                                                ID="txtGrand" runat="server" Text="0.00"></asp:TextBox>
                                            <asp:HiddenField ID="hdnTotalAmount" runat="server" Value="0.00" />
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:Button ID="btnSubmit" OnClientClick="return validateAmt();" runat="server" Text="Submit" CssClass="btn" OnClick="btnSubmit_Click" />
                                            &nbsp;
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" OnClick="btnCancel_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblResult" Visible="False" runat="server" CssClass="label_error"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr align="center" valign="middle">
                                        <td align="center" valign="middle">
                                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                                                    Please wait....
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
