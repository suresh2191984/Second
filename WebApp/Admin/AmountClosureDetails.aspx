<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AmountClosureDetails.aspx.cs"
    Inherits="Admin_AmountClosureDetails" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/PharmacyHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="~/CommonControls/FileUpload.ascx" TagName="FileUpload" TagPrefix="TRF" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Amount ClosureDetails</title>
</head>
<body>
    <%--parseInt--%>

    <script type="text/javascript">
        var userMsg = null;
        function ShowTRFUpload(obj, id) {
            if (obj.checked) {
                document.getElementById('divUpload').style.display = 'block';
            }
            else {
                document.getElementById('divUpload').style.display = 'none';
            }
        }
        function SetTotalAmount(Id, obj) {
            var GethdnACDId = document.getElementById("hdnACDId").value
            var tempACDId = "";
            var TGethdnACDId = "";
            var GetTotalAmount = Number(document.getElementById("hdnTotalAmount").value).toFixed(2);
            var GetAmount = 0;
            if (document.getElementById(Id).checked == true) {
                if (GethdnACDId == "") {
                    GethdnACDId = obj.value.split('~')[0];
                }
                else {
                    GethdnACDId = GethdnACDId + ',' + obj.value.split('~')[0];
                }
                GetAmount = obj.value.split('~')[1];
                GetTotalAmount = parseInt(GetTotalAmount) + parseInt(GetAmount);
                document.getElementById("hdnTotalAmount").value = GetTotalAmount.toFixed(2);
                document.getElementById("txtTotalAmount").value = GetTotalAmount.toFixed(2);
                document.getElementById("hdnACDId").value = GethdnACDId;
            }
            else {
                tempACDId = GethdnACDId.split(',');
                for (var i = 0; i < tempACDId.length; i++) {
                    if (obj.value.split('~')[0] != tempACDId[i]) {
                        if (TGethdnACDId == "") {
                            TGethdnACDId = tempACDId[0];
                        }
                        else {
                            TGethdnACDId = TGethdnACDId + ',' + tempACDId[0];
                        }
                    }
                }
                GetAmount = obj.value.split('~')[1];
                GetTotalAmount = parseInt(GetTotalAmount) - parseInt(GetAmount);
                document.getElementById("hdnTotalAmount").value = GetTotalAmount.toFixed(2)
                document.getElementById("txtTotalAmount").value = GetTotalAmount.toFixed(2);
                document.getElementById("hdnACDId").value = TGethdnACDId;
            }
        }
        function SubmitValidation() {
            var GetACMId = document.getElementById("hdnACDId").value
            var TotalAmount = document.getElementById("txtTotalAmount").value;
            var DepositAmount = document.getElementById("txtDebitAmount").value;
            if (GetACMId == "") {
                document.getElementById("ChkTRFImage").checked = false;
                //  userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_27');
                if (userMsg == null) {
                    alert('Please select the User');

                }
                else {
                    alert(userMsg);
                }
                return false;
            }
            if (parseFloat(DepositAmount) == 0) {
                document.getElementById("ChkTRFImage").checked = false;
                //  userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_27');
                if (userMsg == null) {
                    alert('Please check the Deposit Amount');

                }
                else {
                    alert(userMsg);
                }
                document.getElementById('txtDebitAmount').focus;
                return false;
            }
            if (parseFloat(DepositAmount) > parseFloat(TotalAmount)) {
                document.getElementById("ChkTRFImage").checked = false;
                // userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_27');
                if (userMsg == null) {
                    alert('Deposit Amount greater than Total Amount');
                }
                else {
                    alert(userMsg);
                }
                document.getElementById('txtDepositDate').focus;
                return false;
            }
        }      
    </script>

    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager2" runat="server">
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
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <asp:HiddenField ID="hdnId" Value="0" runat="server" />
                                <table width="100%" class="dataheader2 defaultfontcolor" border="0" cellpadding="4"
                                    cellspacing="0">
                                    <tr>
                                        <td colspan="3" align="center">
                                            &nbsp;<asp:Label ID="lblmsg" runat="server" meta:resourcekey="lblmsgResource1"></asp:Label>
                                            <input type="hidden" id="hdnStatus" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblFromDate" runat="server" Text="From Date" 
                                                meta:resourcekey="lblFromDateResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="Txtboxsmall" 
                                                TabIndex="1" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                            <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromDate"
                                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                CultureTimePlaceholder="" Enabled="True" />
                                            <asp:ImageButton ID="ImgBntFromDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                CausesValidation="False" Height="13px" TabIndex="2" 
                                                meta:resourcekey="ImgBntFromDateResource1" />
                                            <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromDate"
                                                Format="dd/MM/yyyy" PopupButtonID="ImgBntFromDate" Enabled="True" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lbltoDate" runat="server" Text="To Date" 
                                                meta:resourcekey="lbltoDateResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtToDate" runat="server" CssClass="Txtboxsmall" TabIndex="3" 
                                                meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                            <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtToDate"
                                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                CultureTimePlaceholder="" Enabled="True" />
                                            <asp:ImageButton ID="ImgBntToDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                CausesValidation="False" Height="13px" TabIndex="4" 
                                                meta:resourcekey="ImgBntToDateResource1" />
                                            <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToDate"
                                                Format="dd/MM/yyyy" PopupButtonID="ImgBntToDate" Enabled="True" />
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="chkPending" Text="Pending all" runat="server" Checked="True" 
                                                TabIndex="5" meta:resourcekey="chkPendingResource1" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnSearch" runat="server" CssClass="btn" Height="26px" Text="Search"
                                                TabIndex="6" OnClick="btnSearch_Click" 
                                                meta:resourcekey="btnSearchResource1" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnClear" runat="server" CssClass="btn" Height="26px" Text="cancel"
                                                TabIndex="7" OnClick="btnClear_Click" 
                                                meta:resourcekey="btnClearResource1" />
                                        </td>
                                    </tr>
                                </table>
                                <table width="100%" class="dataheader2 defaultfontcolor" border="0" cellpadding="4"
                                    cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:GridView ID="grdAmountClosureDetails" Width="100%" runat="server" CellPadding="4"
                                                AutoGenerateColumns="False" ForeColor="#333333" DataKeyNames="ClosureID" 
                                                meta:resourcekey="grdAmountClosureDetailsResource1">
                                                <HeaderStyle CssClass="dataheader1" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Select" 
                                                        meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <input id="chkSelect" runat="server" type="checkbox" value='<%# Eval("ClosureID")+"~"+Eval("AmountClosed") %>'
                                                                onclick="SetTotalAmount(this.id,this)" />
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left" />
                                                        <ItemStyle Width="2%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <input type="hidden" id="hdnAMDIDKey" runat="server" 
                                                                value='<%# Eval("ClosureID") %>' />
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left" />
                                                        <ItemStyle Width="2%" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="UserName" HeaderText="User Name" 
                                                        meta:resourcekey="BoundFieldResource1" >
                                                        <HeaderStyle HorizontalAlign="Left" />
                                                        <ItemStyle HorizontalAlign="Left" Width="15%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="AmountClosed" HeaderText="Total Amount" 
                                                        meta:resourcekey="BoundFieldResource2" >
                                                        <HeaderStyle HorizontalAlign="Left" />
                                                        <ItemStyle HorizontalAlign="Left" Width="15%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="CreatedAt" HeaderText="Date" 
                                                        meta:resourcekey="BoundFieldResource3" >
                                                        <HeaderStyle HorizontalAlign="Left" />
                                                        <ItemStyle HorizontalAlign="Left" Width="15%" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblTotalAmount" runat="server" Text="TotalAmount" 
                                                meta:resourcekey="lblTotalAmountResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtTotalAmount" runat="server" CssClass="Txtboxsmall" ReadOnly="True"
                                                Text="0.00" meta:resourcekey="txtTotalAmountResource1"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDebitAmount" runat="server" Text="Debit Amount" 
                                                meta:resourcekey="lblDebitAmountResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDebitAmount" runat="server" Text="0.00" CssClass="Txtboxsmall"
                                                TabIndex="8" MaxLength="9"  onkeypress="return ValidateOnlyNumeric(this);"  
                                                meta:resourcekey="txtDebitAmountResource1"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDate" runat="server" Text="Deposit date" 
                                                meta:resourcekey="lblDateResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDepositDate" runat="server" CssClass="Txtboxsmall" 
                                                TabIndex="9" meta:resourcekey="txtDepositDateResource1"></asp:TextBox>
                                            <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtDepositDate"
                                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                CultureTimePlaceholder="" Enabled="True" />
                                            <asp:ImageButton ID="ImageDepositDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                CausesValidation="False" Height="13px" TabIndex="10" 
                                                meta:resourcekey="ImageDepositDateResource1" />
                                            <ajc:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtDepositDate"
                                                Format="dd/MM/yyyy" PopupButtonID="ImageDepositDate" Enabled="True" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblFileUpload" runat="server" Text="Attachment" 
                                                meta:resourcekey="lblFileUploadResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                <ContentTemplate>
                                                    <table>
                                                        <tr>
                                                            <td colspan="2">
                                                                <input id="ChkTRFImage" runat="server" value="Upload" type="checkbox" onclick="ShowTRFUpload(this, this.id);"
                                                                    tabindex="11" />
                                                                <label for="chkUploadPhoto" id="Label10" runat="server" style="color: #2C88B1; font-size: small;">
                                                                    File Upload</label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <div id="divUpload" runat="server" style="display: none">
                                                                    <table cellpadding="0" style="border: 0px; border-color: Red" border="0" cellspacing="0"
                                                                        width="70%">
                                                                        <tr>
                                                                            <td colspan="4">
                                                                                <TRF:FileUpload ID="TRFImageUpload" runat="server" Rows="6" OnClick="DebitFileUpload_Click" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDesc" runat="server" Text="Description" 
                                                meta:resourcekey="lblDescResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine" TabIndex="12" 
                                                meta:resourcekey="txtDescResource1"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnsubmit" runat="server" CssClass="btn" OnClick="btnSubmit_Click"
                                                TabIndex="14" OnClientClick="javascript:return SubmitValidation();" Height="26px"
                                                Text="Save" meta:resourcekey="btnsubmitResource1" />
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
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnTotalAmount" runat="server" Value="0.00" />
    <input type="hidden" id="hdnFileValue" runat="server" />
    <input type="hidden" id="hdnReferenceID" value="0" runat="server" />
    <input type="hidden" id="hdnACDId" value="" runat="server" />
    </form>
</body>
</html>
