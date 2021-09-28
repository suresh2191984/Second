<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DueReport.aspx.cs" Inherits="Reports_DueReport"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function validateToDate() {

            if (document.getElementById('txtFDate').value == '') {
                alert('Provide / select value for From date');
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                alert('Provide / select value for To date');
                document.getElementById('txtTDate').focus();
                return false;
            }
        }
        function popupprint() {
            var prtContent = document.getElementById('prnReport');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
        function ChkSelectType() {
            //  
            if (document.getElementById('rdoDuePaid').checked) {
                document.getElementById('tdName').style.display = 'none';
                document.getElementById('tdtypeofpatient').style.display = 'none';
                document.getElementById('hdnReportType').value = "DPL";
                document.getElementById('dvDuepaid').style.display = 'block';
                document.getElementById('divOPDWCR').style.display = 'none';
            }
            if (document.getElementById('rdoDueList').checked) {
                document.getElementById('tdName').style.display = 'block';
                document.getElementById('tdtypeofpatient').style.display = 'block';
                document.getElementById('hdnReportType').value = "DL";
                document.getElementById('dvDuepaid').style.display = 'none';
                document.getElementById('divOPDWCR').style.display = 'block';
            }
        }
        function clearContextText() {
            $('#contentArea').hide();

        }
    </script>

    <script runat="server">
        string _date;
        string GetDate(string Date)
        {
            if (Date != "01/01/0001")
            {
                _date = Date;
            }
            else
            {
                _date = "--";
            }
            return _date;
        }
    </script>

    <style type="text/css">
        .ui-datepicker
        {
            font-size: 8pt !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
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
                <uc3:Header ID="RHead" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: none;">
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

                        <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

                        <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>

                        <script type="text/javascript">
                            $(function() {
                                $("#txtFDate").datepicker({
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '2008:2030'
                                });
                                $("#txtTDate").datepicker({
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '2008:2030'
                                })
                            });

                        </script>

                        <table id="tblCollectionOPIP" align="center" width="100%">
                            <tr align="center">
                                <asp:UpdatePanel ID="updatePanel1" runat="server">
                                    <ContentTemplate>
                                        <td align="left">
                                            <div class="dataheaderWider">
                                                <table id="tbl">
                                                    <tr>
                                                        <td style="width: 20%;">
                                                            <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" runat="server"
                                                                CssClass="ddl">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td align="left">
                                                            <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                            <asp:TextBox ID="txtFDate" CssClass="Txtboxsmall" Width="70px" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                            <%--<ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                                PopupButtonID="ImgFDate" Enabled="True" />
                                                            <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                CultureTimePlaceholder="" Enabled="True" />
                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />--%>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                            <asp:TextBox ID="txtTDate" CssClass="Txtboxsmall" Width="70px" runat="server" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                            <%--<ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                                PopupButtonID="ImgTDate" Enabled="True" />
                                                            <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgTDateResource1" />
                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                CultureTimePlaceholder="" Enabled="True" />
                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                                ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />--%>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_SelectCurrency" Text="Select Currency" runat="server" meta:resourcekey="Rs_SelectCurrencyResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlCurrency" CssClass="ddl" ToolTip="Select Currency" runat="server"
                                                                Width="250px" meta:resourcekey="ddlCurrencyResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Panel ID="pnReportType" Width="100%" GroupingText="Report Type" runat="server">
                                                                <asp:RadioButton ID="rdoDuePaid" runat="server" GroupName="rdo" onclick="javascript:ChkSelectType();"
                                                                    Text="Due Paid Report" Checked="True" meta:resourcekey="rdoDuePaidResource1" />
                                                                <asp:RadioButton ID="rdoDueList" runat="server" onclick="javascript:ChkSelectType();"
                                                                    GroupName="rdo" Text="Due Report" meta:resourcekey="rdoDueListResource1" />
                                                            </asp:Panel>
                                                        </td>
                                                        <td colspan="5" id="tdName" runat="server" style="display: none;" align="left">
                                                            <table border="0">
                                                                <tr>
                                                                    <td>
                                                                        <asp:Panel ID="pnlVisitType" Width="100%" GroupingText="Visit Type" runat="server">
                                                                            <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" runat="server"
                                                                                meta:resourcekey="rblVisitTypeResource1">
                                                                                <asp:ListItem Text="OP" Selected="True" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                                <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                                <asp:ListItem Text="OP&IP" Value="-1" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </asp:Panel>
                                                                    </td>
                                                                    <td id="tdtypeofpatient" runat="server" style="display: none;" align="left">
                                                                        <asp:Panel ID="pnlBillType" Width="100%" GroupingText="Bill Type" runat="server">
                                                                            <asp:RadioButtonList ID="Rbltypeofpatient" RepeatDirection="Horizontal" runat="server"
                                                                                meta:resourcekey="RbltypeofpatientResource1">
                                                                                <asp:ListItem Text="Cash" Value="Cash" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                                                <asp:ListItem Text="Credit" Value="Credit" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                                                <asp:ListItem Text="Credit&Cash" Value="Creditandcash" Selected="True" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </asp:Panel>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblName" Text="Name:" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtName" CssClass="Txtboxsmall" autocomplete="off" runat="server"
                                                                            meta:resourcekey="txtNameResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblPNo" Text="Patient No:" runat="server" meta:resourcekey="lblPNoResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtPNo" CssClass="Txtboxsmall" autocomplete="off" runat="server"
                                                                            MaxLength="10" onkeypress="return onEnterKeyPress(event);" meta:resourcekey="txtPNoResource1"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center" colspan="6">
                                                            <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                                OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                            &nbsp; &nbsp;<asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server"
                                                                CssClass="details_label_age" OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                        &nbsp;&nbsp;
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                    <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                            <div id="contentArea">
                                                <div id="divPrint" style="display: none;" runat="server">
                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                        <tr>
                                                            <td align="right" style="padding-right: 10px; color: #000000;">
                                                                <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                                    ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                                                &nbsp;<asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                                                &nbsp;
                                                                <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                                    ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="prnReport">
                                                    <div id="divOPDWCR" runat="server" style="display: none;">
                                                        <asp:GridView ID="grdDueReport" runat="server" AutoGenerateColumns="False" Width="100%"
                                                            CssClass="dataheader2" OnRowDataBound="grdDueReport_RowDataBound">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <RowStyle HorizontalAlign="Left" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="S.No">
                                                                    <ItemTemplate>
                                                                        <%# Container.DataItemIndex + 1 %>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="PatientNumber" HeaderText="Patient No"></asp:BoundField>
                                                                <asp:BoundField DataField="PatientName" HeaderText="Name"></asp:BoundField>
                                                                <asp:BoundField DataField="Age" HeaderText="Age/Sex"></asp:BoundField>
                                                                <asp:BoundField DataField="BillNumber" HeaderText="Bill No"></asp:BoundField>
                                                                <asp:TemplateField HeaderText="Bill Date" SortExpression="VisitDate">
                                                                    <ItemTemplate>
                                                                        <%# GetDate(DataBinder.Eval(Container.DataItem,"VisitDate","{0:dd/MM/yyyy}").ToString())%>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="VisitType" HeaderText="Visit"></asp:BoundField>
                                                                <asp:BoundField DataField="IsCreditBill" HeaderText="Credit Bill" />
                                                                <asp:BoundField DataField="TotalAmount" HeaderText="Due Amount">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                            </Columns>
                                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                        </asp:GridView>
                                                        <br />
                                                        <div id="breakup">
                                                            <table border="0" id="tabGranTotal1" runat="server" visible="False" class="dataheaderWider"
                                                                cellpadding="5" style="color: #000000;" cellspacing="0" width="100%">
                                                                <tr id="Tr1" runat="server">
                                                                    <td id="Td1" align="right" style="width: 90%;" runat="server">
                                                                        <asp:Label ID="Rs_TotalDueAmount" Text="Total Due Amount" runat="server"></asp:Label>
                                                                        <label id="Label1" style="color: Green;" runat="server">
                                                                            (A)</label>
                                                                        :
                                                                    </td>
                                                                    <td id="Td2" align="right" style="padding-right: 15px;" runat="server">
                                                                        <label id="lblDueTotal" runat="server">
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </div>
                                                    <div id="dvDuepaid" runat="server" style="display: none;">
                                                        <table width="100%">
                                                            <tr>
                                                                <td class="dataheaderInvCtrl">
                                                                    <asp:Label ID="lblmsg" runat="server" Text="No Records Found" Visible="False" meta:resourcekey="lblmsgResource1"></asp:Label>
                                                                    <asp:GridView ID="gvDuepaidReport" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                        AllowPaging="True" PageSize="100" CssClass="dataheader2" OnRowDataBound="gvDuepaidReport_RowDataBound"
                                                                        OnPageIndexChanging="gvDuepaidReport_PageIndexChanging" ShowFooter="True" meta:resourcekey="gvDuepaidReportResource1">
                                                                        <HeaderStyle HorizontalAlign="Left" CssClass="dataheader1"></HeaderStyle>
                                                                        <PagerStyle CssClass="dataheader1" />
                                                                        <RowStyle HorizontalAlign="Left"></RowStyle>
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="S.No">
                                                                                <ItemTemplate>
                                                                                    <%# Container.DataItemIndex + 1 %>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Patient Name" meta:resourcekey="TemplateFieldResource2">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblName" runat="server" Text='<%# Bind("PatientName") %>' Width="100px"
                                                                                        meta:resourcekey="lblNameResource2"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Age" meta:resourcekey="TemplateFieldResource3">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblAge" runat="server" Text='<%# Bind("Age") %>' meta:resourcekey="lblAgeResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Due BillNo" meta:resourcekey="TemplateFieldResource4">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblDueBillNo" runat="server" Text='<%# Bind("DueBillNum") %>' meta:resourcekey="lblDueBillNoResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Due Paid BillNo" meta:resourcekey="TemplateFieldResource5">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblpaidBillNo" runat="server" Text='<%# Bind("PaidBillNum") %>' meta:resourcekey="lblpaidBillNoResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Due Bill Date" meta:resourcekey="TemplateFieldResource6">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblDueBillDate" runat="server" Text='<%# Bind("DueBillDate","{0:dd-MM-yyyy}") %>'
                                                                                        meta:resourcekey="lblDueBillDateResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="OutStandingAmt" HeaderText="Due Amount" />
                                                                            <asp:BoundField DataField="DiscountAmt" HeaderText="Discount Amount" />
                                                                            <asp:TemplateField HeaderText="Paid Amount" meta:resourcekey="TemplateFieldResource7">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblPaidAmount" runat="server" Text='<%# Bind("PaidAmount") %>' meta:resourcekey="lblPaidAmountResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Paid Date" meta:resourcekey="TemplateFieldResource8">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblPaidDate" runat="server" Text='<%# Bind("PaidDate","{0:dd-MM-yyyy}") %>'
                                                                                        meta:resourcekey="lblPaidDateResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="PaidCurrency" HeaderText="Paid Currency" meta:resourcekey="BoundFieldResource8" />
                                                                            <asp:BoundField DataField="PaidCurrencyAmount" HeaderText="Paid Currency Amt" meta:resourcekey="BoundFieldResource9">
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="BilledBy" HeaderText="Billed By" meta:resourcekey="BoundFieldResource10">
                                                                                <ItemStyle HorizontalAlign="left" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="ReceivedBy" HeaderText="Received By" meta:resourcekey="BoundFieldResource11">
                                                                                <ItemStyle HorizontalAlign="left" />
                                                                            </asp:BoundField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="centre">
                                                                    <asp:Label ID="lblPaidAmount" runat="server" meta:resourcekey="lblPaidAmountResource2"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <asp:HiddenField ID="hdnReportType" runat="server" Value="DPL" />
                                        </td>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="imgBtnXL" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
