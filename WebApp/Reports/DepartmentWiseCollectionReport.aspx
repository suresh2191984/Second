<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DepartmentWiseCollectionReport.aspx.cs"
    Inherits="Reports_DepartmentWiseCollectionReport" %>

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

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

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
        function clearContextText() {
            $('#tblContent').hide();

        }
       
    
    </script>

    <style type="text/css">
        .ui-datepicker
        {
            font-size: 8pt !important;
        }
    </style>
    <style type="text/css">
        .style1
        {
            width: 370px;
        }
        .style2
        {
            width: 15px;
        }
        .style3
        {
            width: 111px;
        }
        .GroupBox
        {
            border: 2px solid #FFFFFF;
            display: inline;
            height: 25px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper" style="overflow:auto; height:600px;">
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
                                                    <asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" runat="server"
                                                        CssClass="ddl">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    From Date :
                                                    <asp:TextBox ID="txtFDate" runat="server" CssClass="Txtboxsmall" Width="70px"></asp:TextBox>
                                                    <%-- <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                        PopupButtonID="ImgFDate" />
                                                    <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                        Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                        OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" />--%>
                                                </td>
                                                <td>
                                                    To Date :
                                                    <asp:TextBox ID="txtTDate" runat="server" CssClass="Txtboxsmall" Width="70px"></asp:TextBox>
                                                    <%--<ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                        PopupButtonID="ImgTDate" />
                                                    <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                        Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                        OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" />--%>
                                                </td>
                                                <td>
                                                    <asp:Panel ID="pnPatientType" Width="100%" GroupingText="Patient Type" runat="server">
                                                        <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" RepeatColumns="3"
                                                            runat="server">
                                                            <asp:ListItem Text="OP" Selected="True" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="IP" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="OP&IP" Value="-1"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </asp:Panel>
                                                </td>
                                                <td>
                                                    <asp:Panel ID="pnReportType" runat="server" Width="100%" GroupingText="Report Type">
                                                        <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" runat="server">
                                                            <asp:ListItem Text="Summary" Selected="True" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="Detail" Value="1"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </asp:Panel>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                        OnClick="btnSubmit_Click" />
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click">Back&nbsp;&nbsp;&nbsp;</asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="btn_export" runat="server" Font-Bold="true" Visible="true" Text="Export to Excel"
                                                        BackColor="" OnClick="btn_export_Click" Style="border-width: 2px;" Font-Size="12px"
                                                        ForeColor="#000000" Font-Underline="true" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <table id="tblContent" cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td style="width: 40%;" valign="top">
                                                <asp:UpdateProgress ID="Progressbar" runat="server">
                                                    <ProgressTemplate>
                                                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                                                        Please wait....
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                                <asp:UpdatePanel ID="updatePanel1" runat="server">
                                                    <ContentTemplate>
                                                        <div id="tblWithSplit" runat="server" style="display: none;">
                                                            <table>
                                                                <tr>
                                                                    <td valign="top">
                                                                        <asp:Label ID="lblMessage" runat="server" Text="No Matching Records Found!" Font-Bold="true"
                                                                            Visible="false"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblCash" runat="server" Text="Paid Patients :" Font-Bold="true" Visible="false"></asp:Label>
                                                                        <asp:GridView ID="grdCash" runat="server" AutoGenerateColumns="False" Visible="false"
                                                                            Width="100%" ForeColor="#333333" CssClass="mytable1" RowStyle-BackColor="White">
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="S.No">
                                                                                    <ItemTemplate>
                                                                                        <%# Container.DataItemIndex + 1 %>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:BoundField HeaderText="Department" DataField="FeeType" HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField HeaderText="Amount Received" DataField="AmountReceived" Visible="false" />
                                                                                <asp:BoundField HeaderText="Due" DataField="Due" Visible="false" />
                                                                                <asp:BoundField HeaderText="Billed Amount" DataField="BillAmount" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Amount Received" DataFormatString="{0:0.00}" DataField="AmountReceived"
                                                                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" />
                                                                                <asp:BoundField HeaderText="Cash" DataField="Cash" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Card" DataField="Cards" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Cheque" DataField="Cheque" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="DD" DataField="DD" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Qty" DataField="Qty" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" />
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td valign="top">
                                                                        <asp:Label ID="lblCredit" runat="server" Text="Credit Patients :" Font-Bold="true"
                                                                            Visible="false"></asp:Label>
                                                                        <asp:GridView ID="grdCredit" runat="server" AutoGenerateColumns="False" Visible="false"
                                                                            Width="100%" ForeColor="#333333" CssClass="mytable1" RowStyle-BackColor="White">
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="S.No">
                                                                                    <ItemTemplate>
                                                                                        <%# Container.DataItemIndex + 1 %>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:BoundField HeaderText="Department" DataField="FeeType" HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField HeaderText="Amount Received" DataField="AmountReceived" Visible="false"
                                                                                    DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Due" DataField="Due" Visible="false" />
                                                                                <asp:BoundField HeaderText="Billed Amount" DataField="BillAmount" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Amount Received" DataField="AmountReceived" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Cash" DataField="Cash" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Card" DataField="Cards" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Cheque" DataField="Cheque" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="DD" DataField="DD" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Qty" DataField="Qty" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" />
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td valign="top">
                                                                        <asp:Label ID="lblTotal" runat="server" Text="Paid & Credit Combined :" Font-Bold="true"
                                                                            Visible="false"></asp:Label>
                                                                        <asp:GridView ID="grdTotal" runat="server" AutoGenerateColumns="False" Visible="false"
                                                                            Width="100%" ForeColor="#333333" CssClass="mytable1" RowStyle-BackColor="White"
                                                                            OnRowDataBound="grdTotal_RowDataBound" OnRowCreated="grdTotal_RowCreated1">
                                                                            <Columns>
                                                                                <%-- <asp:TemplateField HeaderText="Department" meta:resourcekey="TemplateFieldResource1"  >
                                                                           <ItemTemplate >
                                                                            <asp:LinkButton ID="lnkDept" ForeColor="Blue" Font-Size="12px" Text='<%# Eval("FeeType") %>'
                                                                            runat="server" meta:resourcekey="lnkDeptResource1"></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="47%" />
                                                                            </asp:TemplateField>--%>
                                                                                <asp:TemplateField HeaderText="S.No">
                                                                                    <ItemTemplate>
                                                                                        <%# Container.DataItemIndex + 1 %>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:BoundField HeaderText="Department" DataField="FeeType" HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField HeaderText="Amount Received" DataField="AmountReceived" Visible="false"
                                                                                    DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Due" DataField="Due" Visible="false" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Billed Amount" DataField="BillAmount" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Amount Received" DataField="AmountReceived" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Cash" DataField="Cash" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Card" DataField="Cards" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Cheque" DataField="Cheque" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="DD" DataField="DD" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Qty" DataField="Qty" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" />
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </td>
                                                                </tr>
                                                                <asp:HiddenField ID="hdnNeedSplitup" runat="server" Value="N" />
                                                            </table>
                                                        </div>
                                                        <div id="tblWithoutSplit" runat="server" style="display: none;">
                                                            <table width="100%">
                                                                <tr>
                                                                    <td valign="top">
                                                                        <asp:Label ID="lblMessageError" runat="server" Text="No Matching Records Found!"
                                                                            Font-Bold="true" Visible="false"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr valign="top">
                                                                    <td>
                                                                        <asp:Label ID="lblCashPatient" runat="server" Text="Revenue From Cash Patients :"
                                                                            Font-Bold="true"></asp:Label>
                                                                        <asp:GridView ID="grdCashPatient" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                            ForeColor="#333333" CssClass="mytable1" RowStyle-BackColor="White">
                                                                            <Columns>
                                                                                <asp:BoundField HeaderText="Department" DataField="FeeType" HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField HeaderText="Amount Received" DataField="AmountReceived" Visible="false"
                                                                                    DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Due" DataField="Due" Visible="false" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Billed Amount" DataField="BillAmount" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                    <td valign="top">
                                                                        <asp:Label ID="lblCreditPatient" runat="server" Text="Revenue From Cash Patients :"
                                                                            Font-Bold="true"></asp:Label>
                                                                        <asp:GridView ID="grdCreditPatient" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                            ForeColor="#333333" CssClass="mytable1" RowStyle-BackColor="White">
                                                                            <Columns>
                                                                                <asp:BoundField HeaderText="Department" DataField="FeeType" HeaderStyle-HorizontalAlign="Center"
                                                                                    DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Amount Received" DataField="AmountReceived" Visible="false"
                                                                                    DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Due" DataField="Due" Visible="false" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Billed Amount" DataField="BillAmount" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                    <td valign="top">
                                                                        <asp:Label ID="lblCashCreditPatient" runat="server" Text="Revenue From Cash & Credit Patients :"
                                                                            Font-Bold="true"></asp:Label>
                                                                        <asp:GridView ID="grdCashCreditPatient" runat="server" AutoGenerateColumns="False"
                                                                            Width="100%" ForeColor="#333333" CssClass="mytable1" RowStyle-BackColor="White"
                                                                            OnRowDataBound="grdTotal_RowDataBound" OnRowCreated="grdTotal_RowCreated1">
                                                                            <Columns>
                                                                                <asp:BoundField HeaderText="Department" DataField="FeeType" HeaderStyle-HorizontalAlign="Center"
                                                                                    DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Amount Received" DataField="AmountReceived" Visible="false"
                                                                                    DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Due" DataField="Due" Visible="false" DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Billed Amount" DataField="BillAmount" HeaderStyle-HorizontalAlign="Center"
                                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" />
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </td>
                                                                </tr>
                                                                <asp:HiddenField ID="HiddenField1" runat="server" Value="N" />
                                                            </table>
                                                        </div>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                            <td align="right" valign="top" style="padding-left: 100px; padding-right: 300px;">
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalGross">
                                                    <asp:Label runat="server" ID="lblTotalGross" Style="padding-top: 10px; padding-bottom: 10px;
                                                        padding-right: 10px;" Height="40px" Font-Bold="true"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalDiscount">
                                                    <asp:Label runat="server" ID="lblTotalDiscount" Style="padding-top: 10px; padding-bottom: 10px;
                                                        padding-right: 10px;" Height="40px" Font-Bold="true"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalNet">
                                                    <asp:Label runat="server" ID="lblTotalNet" Style="padding-top: 10px; padding-bottom: 10px;
                                                        padding-right: 10px;" Height="40px" Font-Bold="true"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalReceived">
                                                    <asp:Label runat="server" ID="lblTotalReceived" Style="padding-top: 10px; padding-bottom: 10px;
                                                        padding-right: 10px;" Height="40px" Font-Bold="true"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalDue">
                                                    <asp:Label runat="server" ID="lblTotalDue" Style="padding-top: 10px; padding-bottom: 10px;
                                                        padding-right: 10px;" Height="40px" Font-Bold="true"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalRefund">
                                                    <asp:Label runat="server" ID="lblTotalRefund" Style="padding-top: 10px; padding-bottom: 10px;
                                                        padding-right: 10px;" Height="40px" Font-Bold="true"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalBalance">
                                                    <asp:Label runat="server" ID="lblTotalBalance" Style="padding-top: 10px; padding-bottom: 10px;
                                                        padding-right: 10px;" Height="40px" Font-Bold="true"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalAdvance">
                                                    <asp:Label runat="server" ID="lblTotalAdvance" Style="padding-top: 10px; padding-bottom: 10px;
                                                        padding-right: 10px;" Height="40px" Font-Bold="true"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalAmountInHand">
                                                    <asp:Label runat="server" ID="lblTotalAmountInHand" Style="padding-top: 10px; padding-bottom: 10px;
                                                        padding-right: 10px;" Height="40px" Font-Bold="true"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalDeposit">
                                                    <asp:Label runat="server" ID="lblTotalDeposit" Style="padding-top: 10px; padding-bottom: 10px;
                                                        padding-right: 10px;" Height="40px" Font-Bold="true"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divPharmacytotRefund">
                                                    <asp:Label runat="server" ID="lblPharmacytotRefund" Style="padding-top: 10px; padding-bottom: 10px;
                                                        padding-right: 10px;" Height="40px" Font-Bold="true"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divPharmacyItemRefund">
                                                    <asp:Label runat="server" ID="lblPharmacyItemRefund" Style="padding-top: 10px; padding-bottom: 10px;
                                                        padding-right: 10px;" Height="40px" Font-Bold="true"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divPharmacyDateRangeRefund">
                                                    <asp:Label runat="server" ID="lblPharmacyDateRangeRefund" Style="padding-top: 10px;
                                                        padding-bottom: 10px; padding-right: 10px;" Height="40px" Font-Bold="true"></asp:Label>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <uc5:Footer ID="Footer1" runat="server" />
              </tr>
      </table>
      </div>

    </form>
</body>
</html>
