<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CollectionReportOPIPWithFilter.aspx.cs"
    Inherits="Reports_CollectionReportOPIPWithFilter" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="~/CommonControls/IncomeFromOtherSource.ascx" TagName="IncomeFromOtherSource"
    TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script language="javascript" type="text/javascript">

        function clearContextText() {
            $('#contentArea').hide();

        }
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
                                <td align="left">
                                    <div class="dataheaderWider">
                                        <table id="tbl">
                                            <tr id="trTrustedOrg" runat="server" style="display: block;">
                                                <td>
                                                    <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" runat="server"
                                                        CssClass="ddl">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="Txtboxsmall" Width="70px" ID="txtFDate" runat="server"></asp:TextBox>
                                                    <%-- <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
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
                                                    <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="Txtboxsmall" Width="70px" ID="txtTDate" runat="server"></asp:TextBox>
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
                                                    <asp:DropDownList CssClass="ddl" ID="ddlCurrency" ToolTip="Select Currency" runat="server"
                                                        Width="220px" meta:resourcekey="ddlCurrencyResource1">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="8">
                                                    <table>
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Panel ID="pnPatientType" Width="100%" GroupingText="Patient Type" runat="server">
                                                                    <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" RepeatColumns="3"
                                                                        runat="server" meta:resourcekey="rblVisitTypeResource1">
                                                                        <asp:ListItem Text="OP" Selected="True" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                        <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                        <asp:ListItem Text="OP&IP" Value="-1" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                                <asp:Panel ID="pnReportType" runat="server" Width="100%" GroupingText="Report Type">
                                                                    <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" runat="server"
                                                                        meta:resourcekey="rblReportTypeResource1">
                                                                        <asp:ListItem Text="Summary" Selected="True" Value="0" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                                        <asp:ListItem Text="Detail" Value="1" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                                <asp:Panel ID="PnlAdvance" Width="100%" GroupingText="Advance Filter" runat="server">
                                                                    <asp:RadioButtonList ID="rdoAdvList" RepeatDirection="Horizontal" RepeatColumns="3"
                                                                        runat="server" meta:resourcekey="rdoAdvListResource1">
                                                                        <asp:ListItem Text="Advance Only" Value="AO"></asp:ListItem>
                                                                        <asp:ListItem Text="Non Advance Only" Value="NAO"></asp:ListItem>
                                                                        <asp:ListItem Text="Both" Selected="True" Value="B"></asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </asp:Panel>
                                                            </td>
                                                            <td>
                                                                <asp:Panel ID="PnlBillFilter" Width="100%" GroupingText="Bill Filter" runat="server">
                                                                    <asp:RadioButtonList ID="rdoBTList" RepeatDirection="Horizontal" RepeatColumns="3"
                                                                        runat="server" meta:resourcekey="rdoBTListResource1">
                                                                        <asp:ListItem Text="Credit Bills" Value="CB"></asp:ListItem>
                                                                        <asp:ListItem Text="Non Credit Bills" Value="NCB"></asp:ListItem>
                                                                        <asp:ListItem Text="Both" Selected="True" Value="B"></asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </asp:Panel>
                                                            </td>
                                                            <td style="font-weight: bold;">
                                                                <asp:CheckBox ID="ChkBoxShowDescription" Text="Show Description" runat="server" Checked="false" />
                                                            </td>
                                                            <td align="left">
                                                                <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                    onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                                    OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                            </td>
                                                            <td align="left">
                                                                <asp:LinkButton ID="lnkBack" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                                    OnClick="lnkBack_Click">Back&nbsp;&nbsp;</asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
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
                                                    <td align="left" style="padding-right: 10px; color: #000000;">
                                                        <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                            ToolTip="Save As Excel" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                                        <b id="printText" runat="server">
                                                            <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                                        <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                            ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                                            <ContentTemplate>
                                                <div id="divOPDWCR" runat="server" style="display: none;">
                                                    <div id="prnReport">
                                                        <asp:Label ID="lblFromToDate" Font-Bold="True" runat="server" Visible="False" meta:resourcekey="lblFromToDateResource1"></asp:Label>
                                                        <asp:GridView ID="gvIPCreditMainGrandTotal" runat="server" AutoGenerateColumns="False"
                                                            Width="100%" Visible="False" ForeColor="#333333" CssClass="mytable1" OnRowDataBound="gvIPCreditMainGrandTotal_RowDataBound"
                                                            meta:resourcekey="gvIPCreditMainGrandTotalResource1">
                                                            <Columns>
                                                                <asp:BoundField DataField="PatientID" Visible="False" HeaderText="Patient No" meta:resourcekey="BoundFieldResource1">
                                                                    <ItemStyle HorizontalAlign="Left" Width="25px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="PatientName" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Age" HeaderText="Age" Visible="False" meta:resourcekey="BoundFieldResource3">
                                                                    <ItemStyle HorizontalAlign="Right" Wrap="False"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="BillNumber" Visible="False" HeaderText="Bill No" meta:resourcekey="BoundFieldResource4">
                                                                    <ItemStyle HorizontalAlign="Left" Width="25px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="ConsultantName" Visible="False" HeaderText="Consultant"
                                                                    meta:resourcekey="BoundFieldResource5">
                                                                    <ItemStyle HorizontalAlign="Left" Width="25px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="BillAmount" DataFormatString="{0:0.00}" HeaderText="Bill Amt"
                                                                    meta:resourcekey="BoundFieldResource6">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="PreviousDue" DataFormatString="{0:0.00}" HeaderText="Acc Due"
                                                                    Visible="False" meta:resourcekey="BoundFieldResource7">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="CreditDue" DataFormatString="{0:0.00}" HeaderText="Credit Due"
                                                                    Visible="False" meta:resourcekey="BoundFieldResource8">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Discount" DataFormatString="{0:0.00}" HeaderText="Discount"
                                                                    meta:resourcekey="BoundFieldResource9">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="NetValue" DataFormatString="{0:0.00}" HeaderText="Net Amt"
                                                                    meta:resourcekey="BoundFieldResource10">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="ReceivedAmount" DataFormatString="{0:0.00}" HeaderText="Rcvd Amt"
                                                                    meta:resourcekey="BoundFieldResource11">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Cash" DataFormatString="{0:0.00}" HeaderText="Cash" meta:resourcekey="BoundFieldResource12">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Cards" DataFormatString="{0:0.00}" HeaderText="Cards"
                                                                    meta:resourcekey="BoundFieldResource13">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Cheque" DataFormatString="{0:0.00}" HeaderText="Cheque"
                                                                    meta:resourcekey="BoundFieldResource14">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="DD" DataFormatString="{0:0.00}" HeaderText="Drafts" meta:resourcekey="BoundFieldResource15">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Due" DataFormatString="{0:0.00}" HeaderText="Bill Due"
                                                                    meta:resourcekey="BoundFieldResource16">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="IPAdvance" DataFormatString="{0:0.00}" HeaderText="ADV"
                                                                    meta:resourcekey="BoundFieldResource17">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="VisitType" Visible="False" HeaderText="Visit" meta:resourcekey="BoundFieldResource18">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="AmountRefund" DataFormatString="{0:0.00}" HeaderText="Rfd Amt"
                                                                    meta:resourcekey="BoundFieldResource19">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="PaidCurrency" DataFormatString="{0:0.00}" HeaderText="Paid Currency"
                                                                    meta:resourcekey="BoundFieldResource20">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="DepositUsed" DataFormatString="{0:0.00}" HeaderText="Deposit Used"
                                                                    meta:resourcekey="BoundFieldResource21">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                            </Columns>
                                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                            <RowStyle BackColor="White" Font-Bold="True" />
                                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                        </asp:GridView>
                                                        <br />
                                                        <br />
                                                        <asp:GridView ID="gvIPReport" runat="server" AutoGenerateColumns="False" Visible="False"
                                                            Width="100%" OnRowDataBound="gvIPReport_RowDataBound" HorizontalAlign="Right"
                                                            meta:resourcekey="gvIPReportResource1">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Collection Report" meta:resourcekey="TemplateFieldResource1">
                                                                    <ItemTemplate>
                                                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                            <tr>
                                                                                <td align="left" style="height: 25px;">
                                                                                    <b>
                                                                                        <asp:Label ID="Rs_Date" Text="Date:" runat="server" meta:resourcekey="Rs_DateResource1"></asp:Label>
                                                                                    </b>
                                                                                    <%# DataBinder.Eval(Container.DataItem, "VisitDate", "{0:dd/MM/yyyy}")%>
                                                                                    <b>
                                                                                        <asp:Label ID="Rs_TotalNoPatients" Text="Total No Patients:" runat="server" meta:resourcekey="Rs_TotalNoPatientsResource1"></asp:Label></b>
                                                                                    <asp:Label ID="LblTotvalue" runat="server" meta:resourcekey="LblTotvalueResource1"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:GridView ID="gvIPCreditMain" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                                        ForeColor="#333333" CssClass="mytable1" OnRowDataBound="gvIPCreditMain_RowDataBound"
                                                                                        meta:resourcekey="gvIPCreditMainResource1">
                                                                                        <Columns>
                                                                                            <asp:BoundField DataField="PatientID" HeaderText="Patient No" meta:resourcekey="BoundFieldResource22">
                                                                                                <ItemStyle HorizontalAlign="Left" Width="25px" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="PatientName" HeaderText="Name" meta:resourcekey="BoundFieldResource23">
                                                                                                <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="Age" HeaderText="Age" meta:resourcekey="BoundFieldResource24">
                                                                                                <ItemStyle HorizontalAlign="Right" Wrap="False"></ItemStyle>
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="BillNumber" HeaderText="Bill No" meta:resourcekey="BoundFieldResource25">
                                                                                                <ItemStyle HorizontalAlign="Left" Width="25px" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="ReceiptNo" HeaderText="Receipt No" meta:resourcekey="BoundFieldResource26">
                                                                                                <ItemStyle HorizontalAlign="Left" Width="25px" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="DueChartNo" HeaderText="Due Chart No" meta:resourcekey="BoundFieldResource27">
                                                                                                <ItemStyle HorizontalAlign="Left" Width="25px" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="ConsultantName" Visible="False" HeaderText="Consultant"
                                                                                                meta:resourcekey="BoundFieldResource28">
                                                                                                <ItemStyle HorizontalAlign="Left" Width="25px" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="BillAmount" DataFormatString="{0:0.00}" HeaderText="Bill Amt"
                                                                                                meta:resourcekey="BoundFieldResource29">
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="PreviousDue" HeaderText="Acc Due" DataFormatString="{0:0.00}"
                                                                                                meta:resourcekey="BoundFieldResource30">
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="CreditDue" HeaderText="Credit Due" DataFormatString="{0:0.00}"
                                                                                                meta:resourcekey="BoundFieldResource31">
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="Discount" HeaderText="Discount" DataFormatString="{0:0.00}"
                                                                                                meta:resourcekey="BoundFieldResource32">
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="NetValue" HeaderText="Net Amt" DataFormatString="{0:0.00}"
                                                                                                meta:resourcekey="BoundFieldResource33">
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="ReceivedAmount" HeaderText="Rcvd Amt" DataFormatString="{0:0.00}"
                                                                                                meta:resourcekey="BoundFieldResource34">
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="Cash" HeaderText="Cash" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource35">
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="Cards" HeaderText="Cards" DataFormatString="{0:0.00}"
                                                                                                meta:resourcekey="BoundFieldResource36">
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="Cheque" HeaderText="Cheque" DataFormatString="{0:0.00}"
                                                                                                meta:resourcekey="BoundFieldResource37">
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="DD" HeaderText="Drafts" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource38">
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="Due" HeaderText="Bill Due" DataFormatString="{0:0.00}"
                                                                                                meta:resourcekey="BoundFieldResource39">
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="IPAdvance" DataFormatString="{0:0.00}" HeaderText="ADV"
                                                                                                meta:resourcekey="BoundFieldResource40">
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="VisitType" HeaderText="Visit" Visible="False" meta:resourcekey="BoundFieldResource41">
                                                                                                <ItemStyle Width="25px" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="AmountRefund" DataFormatString="{0:0.00}" HeaderText="Rfd Amt"
                                                                                                meta:resourcekey="BoundFieldResource42">
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="PaidCurrency" HeaderText="Paid Currency" meta:resourcekey="BoundFieldResource43">
                                                                                                <ItemStyle Width="25px" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="PaidCurrencyAmount" DataFormatString="{0:0.00}" HeaderText="Paid Currency Amt"
                                                                                                meta:resourcekey="BoundFieldResource44">
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="DepositUsed" DataFormatString="{0:0.00}" HeaderText="Deposit Used"
                                                                                                meta:resourcekey="BoundFieldResource45">
                                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="RefundNo" HeaderText="Refund No"></asp:BoundField>
                                                                                            <asp:BoundField DataField="Due" HeaderText="Due"></asp:BoundField>
                                                                                            <asp:TemplateField HeaderText="Descriptions">
                                                                                                <ItemTemplate>
                                                                                                    <asp:GridView ID="gvChildDesp" CssClass="dataheaderInvCtrl" Font-Names="Verdana"
                                                                                                        runat="server" AutoGenerateColumns="false">
                                                                                                        <Columns>
                                                                                                            <asp:BoundField DataField="Description" HeaderText="Details" />
                                                                                                            <asp:BoundField DataField="BillAmount" HeaderText="Amount" />
                                                                                                        </Columns>
                                                                                                    </asp:GridView>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                        </Columns>
                                                                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                                        <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                                    </asp:GridView>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <RowStyle HorizontalAlign="Right" />
                                                        </asp:GridView>
                                                        <asp:GridView ID="gvOPIPCollDaywiseSummary" Visible="False" runat="server" AutoGenerateColumns="False"
                                                            Width="100%" ForeColor="#333333" OnRowDataBound="gvOPIPCollDaywiseSummary_RowDataBound"
                                                            meta:resourcekey="gvOPIPCollDaywiseSummaryResource1">
                                                            <RowStyle Font-Bold="False" Font-Names="Verdana" Font-Size="10pt" />
                                                            <Columns>
                                                                <asp:BoundField DataField="PatientID" HeaderText="Patient No" meta:resourcekey="BoundFieldResource46">
                                                                    <ItemStyle Width="25px" HorizontalAlign="Left"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="PatientName" HeaderText="Name" meta:resourcekey="BoundFieldResource47">
                                                                    <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Age" HeaderText="Age" meta:resourcekey="BoundFieldResource48">
                                                                    <ItemStyle HorizontalAlign="Right" Wrap="False"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="BillNumber" HeaderText="Bill No" meta:resourcekey="BoundFieldResource49">
                                                                    <ItemStyle Width="25px" HorizontalAlign="Left"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="ConsultantName" Visible="False" HeaderText="Consultant"
                                                                    meta:resourcekey="BoundFieldResource50">
                                                                    <ItemStyle HorizontalAlign="Left" Width="25px"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataFormatString="{0:0.00}" DataField="BillAmount" HeaderText="Bill Amt"
                                                                    meta:resourcekey="BoundFieldResource51">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataFormatString="{0:0.00}" DataField="PreviousDue" HeaderText="Acc Due"
                                                                    meta:resourcekey="BoundFieldResource52">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataFormatString="{0:0.00}" DataField="Discount" HeaderText="Discount"
                                                                    meta:resourcekey="BoundFieldResource53">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataFormatString="{0:0.00}" DataField="NetValue" HeaderText="Net Amt"
                                                                    meta:resourcekey="BoundFieldResource54">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataFormatString="{0:0.00}" DataField="ReceivedAmount" HeaderText="Received Amt"
                                                                    meta:resourcekey="BoundFieldResource55">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataFormatString="{0:0.00}" DataField="Cash" HeaderText="Cash" meta:resourcekey="BoundFieldResource56">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Cards" DataFormatString="{0:0.00}" HeaderText="Cards"
                                                                    meta:resourcekey="BoundFieldResource57">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Cheque" DataFormatString="{0:0.00}" HeaderText="Cheque"
                                                                    meta:resourcekey="BoundFieldResource58">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="DD" DataFormatString="{0:0.00}" HeaderText="Drafts" meta:resourcekey="BoundFieldResource59">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Due" DataFormatString="{0:0.00}" HeaderText="Bill Due"
                                                                    meta:resourcekey="BoundFieldResource60">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="IPAdvance" DataFormatString="{0:0.00}" HeaderText="ADV"
                                                                    meta:resourcekey="BoundFieldResource61">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="VisitType" HeaderText="Visit" meta:resourcekey="BoundFieldResource62">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="AmountRefund" DataFormatString="{0:0.00}" HeaderText="Rfd Amt"
                                                                    meta:resourcekey="BoundFieldResource63">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="PaidCurrency" HeaderText="Paid Currency" meta:resourcekey="BoundFieldResource64">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="PaidCurrencyAmount" DataFormatString="{0:0.00}" HeaderText="Paid Currency Amt"
                                                                    meta:resourcekey="BoundFieldResource65">
                                                                    <ItemStyle HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                            </Columns>
                                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                            <SelectedRowStyle BackColor="#669999" Font-Bold="False" ForeColor="White" />
                                                            <HeaderStyle CssClass="grdcolor" Font-Bold="False" Font-Names="Verdana" Font-Size="10pt" />
                                                        </asp:GridView>
                                                        <br />
                                                        <uc2:IncomeFromOtherSource ID="IncomeFromOtherSource" runat="server" />
                                                        <div id="breakup" style="display: none;">
                                                            <table border="0" id="tabGranTotal1" runat="server" visible="False" class="dataheaderWider"
                                                                cellpadding="5" style="color: #000000;" cellspacing="0" width="100%">
                                                                <tr runat="server">
                                                                    <td align="right" style="width: 80%;" runat="server">
                                                                        <asp:Label ID="Rs_GrandTotal" Text="Grand Total" runat="server"></asp:Label>
                                                                        <label id="Label1" style="color: Green;" runat="server">
                                                                            (A)</label>
                                                                        :
                                                                    </td>
                                                                    <td align="right" style="padding-right: 15px;" runat="server">
                                                                        <label id="lblGrandTotal" runat="server">
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server">
                                                                    <td align="right" style="width: 80%;" runat="server">
                                                                        <asp:Label ID="Rs_TotalDiscountAmount" Text="Total Discount Amount" runat="server"></asp:Label>
                                                                        <label id="Label5" style="color: Green;" runat="server">
                                                                            (B)</label>
                                                                        :
                                                                    </td>
                                                                    <td align="right" style="padding-right: 15px;" runat="server">
                                                                        <label id="lblDiscountAmount" runat="server">
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server">
                                                                    <td align="right" style="width: 80%;" runat="server">
                                                                        <asp:Label ID="Rs_ServiceCharge" Text="Service Charge" runat="server"></asp:Label>
                                                                        <label id="Label2" style="color: Green;" runat="server">
                                                                            (C)</label>
                                                                        :
                                                                    </td>
                                                                    <td align="right" style="padding-right: 15px;" runat="server">
                                                                        <label id="lblServiceCharge" runat="server">
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server">
                                                                    <td align="right" style="width: 80%;" runat="server">
                                                                        <asp:Label ID="Rs_Tax" Text="Tax" runat="server"></asp:Label>
                                                                        <label id="Label3" style="color: Green;" runat="server">
                                                                            (D)</label>
                                                                        :
                                                                    </td>
                                                                    <td align="right" style="padding-right: 15px;" runat="server">
                                                                        <label id="lblTax" runat="server">
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table border="0" id="tabGranTotal2" runat="server" visible="False" class="dataheaderWider"
                                                                cellpadding="5" style="color: #000000;" cellspacing="0" width="100%">
                                                                <tr runat="server">
                                                                    <td colspan="2" align="right" runat="server">
                                                                        ----------------
                                                                    </td>
                                                                </tr>
                                                                <tr id="trNetAmount" runat="server">
                                                                    <td align="right" style="width: 80%;" runat="server">
                                                                        <asp:Label ID="Rs_TotalNetAmount" Text="Total Net Amount" runat="server"></asp:Label>
                                                                        <label id="Label4" style="color: Green;" runat="server">
                                                                            (E)</label>
                                                                        :
                                                                    </td>
                                                                    <td align="right" style="padding-right: 15px;" runat="server">
                                                                        <label id="lblNetAmount" runat="server">
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server">
                                                                    <td align="right" style="width: 80%;" runat="server">
                                                                        <asp:Label ID="Rs_TotalReceivedAmount" Text="Total Received Amount" runat="server"></asp:Label>
                                                                        <label id="Label7" style="color: Green;" runat="server">
                                                                            (E)</label>
                                                                        :
                                                                    </td>
                                                                    <td align="right" style="padding-right: 15px;" runat="server">
                                                                        <label id="lblReceivedAmount" runat="server">
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server">
                                                                    <td align="right" style="width: 80%;" runat="server">
                                                                        <asp:Label ID="Rs_TotalDueAmount" Text="Total Due Amount" runat="server"></asp:Label>
                                                                        <label id="Label6" style="color: Green;" runat="server">
                                                                            (F)</label>
                                                                        :
                                                                    </td>
                                                                    <td align="right" style="padding-right: 15px;" runat="server">
                                                                        <label id="lblDueAmount" runat="server">
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server">
                                                                    <td colspan="2" align="right" runat="server">
                                                                        ----------------
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </td>
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
