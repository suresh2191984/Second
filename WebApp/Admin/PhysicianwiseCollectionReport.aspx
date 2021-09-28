<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PhysicianwiseCollectionReport.aspx.cs"
    Inherits="Admin_PhysicianwiseCollectionReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Src="../CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Physician Wise Collection Report</title>
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript">
        function popupprint() {
            var prtContent = document.getElementById('grdResult');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false;
        }
        var ddlText, ddlValue, ddl, lblMesg;
        function CacheItems() {
            ddlText = new Array();
            ddlValue = new Array();
            ddl = document.getElementById('ddlDrName');
            for (var i = 0; i < ddl.options.length; i++) {
                ddlText[ddlText.length] = ddl.options[i].text;
                ddlValue[ddlValue.length] = ddl.options[i].value;
            }
        }

        window.onload = CacheItems;

        function FilterItems(value) {
            value = value.toLowerCase()
            ddl.options.length = 0;
            for (var i = 0; i < ddlText.length; i++) {
                if (ddlText[i].toLowerCase().indexOf(value) != -1) {
                    AddItem(ddlText[i], ddlValue[i]);
                }
            }

            if (ddl.options.length == 0) {
                AddItem("No Physician Found", "");
            }
        }

        function AddItem(text, value) {
            var opt = document.createElement("option");
            opt.text = text;
            opt.value = value;
            ddl.options.add(opt);
        }
        function AddPhysician() {
            var ddlPhy = document.getElementById('ddlDrName');
            var ddlPhyLength = ddlPhy.options.length;
            for (var i = 0; i < ddlPhyLength; i++) {
                if (ddlPhy.options[i].selected) {
                   if (ddlPhy.options[i].text != '-----Show All-----') {
                        document.getElementById('txtNew').value = ddlPhy.options[i].text;
                    }
                }
            }
        }
    </script>

</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
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
                <uc3:Header ID="AdminHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: none;">
                    <div id="navigation">
                        <uc121:LeftMenu ID="LeftMenu1" runat="server" />
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
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:Panel runat="server" CssClass="dataheader2" ID="pnlDate" Width="99%" meta:resourcekey="pnlDateResource1">
                            <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="height: 5px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td align="right" style="width: 15%">
                                                    <asp:Label runat="server" ID="fromDate" Text="From Date" CssClass="label_title" meta:resourcekey="fromDateResource1"></asp:Label>
                                                </td>
                                                <td style="width: 35%;">
                                                    <asp:TextBox ID="txtFrom" runat="server"  CssClass ="Txtboxsmall" TabIndex="4" MaxLength="1"
                                                        Style="text-align: justify" ValidationGroup="MKE" meta:resourcekey="txtFromResource1" />
                                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImageButton1Resource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFrom"
                                                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                        Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                    <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFrom"
                                                        PopupButtonID="ImageButton1" Format="dd/MM/yyyy" Enabled="True" />
                                                </td>
                                                <td align="right" style="width: 15%;">
                                                    <asp:Label runat="server" ID="toDate" Text="To Date" CssClass="label_title" meta:resourcekey="toDateResource1"></asp:Label>
                                                </td>
                                                <td style="width: 35%">
                                                    <asp:TextBox ID="txtTo" runat="server"  CssClass ="Txtboxsmall" TabIndex="5" MaxLength="1" Style="text-align: justify"
                                                        ValidationGroup="MKE" meta:resourcekey="txtToResource1" />
                                                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImageButton2Resource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtTo"
                                                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                        Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                        ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourcekey="MaskedEditValidator2Resource1" />
                                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtTo"
                                                        PopupButtonID="ImageButton2" Format="dd/MM/yyyy" Enabled="True" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="width: 15%;" align="right">
                                                    <asp:Label ID="Rs_SelectPhysician" Text="Select Physician" runat="server" meta:resourcekey="Rs_SelectPhysicianResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtNew" runat="server" ToolTip="Enter Text Here" onkeyup="FilterItems(this.value)" CssClass ="Txtboxsmall"
                                                        onblur="AddPhysician()" meta:resourcekey="txtNewResource1" />
                                                    <asp:DropDownList runat="server" ID="ddlDrName" TabIndex="1" CssClass ="ddlsmall"
                                                        meta:resourcekey="ddlDrNameResource1">
                                                    </asp:DropDownList>
                                                    <ajc:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtNew"
                                                        WatermarkText="Type Physician Name" Enabled="True" />
                                                </td>
                                                <td style="width: 15%;" align="right">
                                                    <asp:Label ID="Rs_CreditBills" Text="Credit Bills" runat="server" meta:resourcekey="Rs_CreditBillsResource1"></asp:Label>
                                                </td>
                                                <td style="width: 15%;" align="left">
                                                    <asp:RadioButtonList ID="rblIsCreditBill" RepeatDirection="Horizontal" runat="server"
                                                        meta:resourcekey="rblIsCreditBillResource1">
                                                        <asp:ListItem Text="Yes" Selected="True" Value="Y" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                        <asp:ListItem Text="No" Value="N" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                        <asp:ListItem Text="Both" Value="B" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td style="width: 15%;" align="left">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Button runat="server" ID="btnGo" Text=" Go " CssClass="btn" TabIndex="6" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClick="btnGo_Click" meta:resourcekey="btnGoResource1" />
                                        &nbsp;
                                        <asp:Button ID="btnCancel" runat="server" Text="Reset" Visible="false" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                            onmouseout="this.className='btn1'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                        <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click">
                                                Back
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 5px;">
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Label ID="lblResult" Font-Bold="True" ForeColor="#000333" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
                        <div id="divPrint" style="display: none;" runat="server">
                            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                <tr>
                                    <td align="left" style="padding-right: 10px; color: #000000;">
                                        <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="True" ForeColor="#000333"
                                            runat="server" meta:resourcekey="lbExcelResource1"></asp:Label>
                                        <asp:ImageButton ID="btnConverttoXL" runat="server" ImageUrl="~/Images/ExcelImage.GIF"
                                            OnClick="btnConverttoXL_Click" meta:resourcekey="btnConverttoXLResource1" />
                                    </td>
                                    <td align="right" style="padding-right: 10px; color: #000000;">
                                        <b id="printText" runat="server">
                                            <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>&nbsp;&nbsp;
                                        <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                            ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table id="tabGrandTotal" style="display: none;" runat="server" cellpadding="0" cellspacing="0"
                            border="0" width="100%">
                            <tr>
                                <td>
                                    <table cellpadding="0" cellspacing="0" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                                        border="1" width="100%">
                                        <tr style="height: 25px; font-weight: bold;">
                                            <td align="center" colspan="2" width="40%">
                                                <asp:Label ID="Rs_GrandTotal" Text="Grand Total" runat="server" meta:resourcekey="Rs_GrandTotalResource1"></asp:Label>
                                                <asp:Label ID="lblTPC" runat="server" ForeColor="Red" meta:resourcekey="lblTPCResource1"></asp:Label>
                                            </td>
                                            <td id="tdTCollectionAmount" width="12%" align="right" runat="server">
                                            </td>
                                            <td id="tdTDiscountAmount" width="12%" align="right" runat="server">
                                            </td>
                                            <td id="tdTRefundAmount" width="12%" align="right" runat="server">
                                            </td>
                                            <td id="tdTOrganisationAmount" width="12%" align="right" runat="server">
                                            </td>
                                            <td id="tdTPhysicianAmount" width="12%" align="right" runat="server">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>
                                        <asp:Label ID="Rs_OP" Text="OP" runat="server" meta:resourcekey="Rs_OPResource1"></asp:Label></b><asp:Label
                                            ID="Rs_OutPatient" Text=":Out Patient" runat="server" meta:resourcekey="Rs_OutPatientResource1"></asp:Label>
                                    <b>
                                        <asp:Label ID="Rs_IP" Text="IP" runat="server" meta:resourcekey="Rs_IPResource1"></asp:Label></b><asp:Label
                                            ID="Rs_InPatient" Text=":In Patient" runat="server"></asp:Label>
                                    <b>
                                        <asp:Label ID="Rs_IP1" Text="IP(S)" runat="server" meta:resourcekey="Rs_IP1Resource1"></asp:Label></b>
                                    <asp:Label ID="Rs_InPatient1" Text=":In Patient(Surgery), " runat="server" meta:resourcekey="Rs_InPatientResource1"></asp:Label>
                                    <b>
                                        <asp:Label ID="Rs_IP2" Text="IP(A)" runat="server"></asp:Label></b>
                                    <asp:Label ID="Label2" Text=":In Patient(Assistant Surgeon's Fee/Anesthetist), "
                                        runat="server"></asp:Label>
                                        <br />
                                    <b>
                                        <asp:Label ID="Rs_OP_PP" Text="OP-PerfPhy" runat="server" meta:resourcekey="Rs_OP_Perf_Phy_Res1"></asp:Label></b>
                                    <asp:Label ID="Rs_OP_PP1" Text=":Performing Physician(OP), " runat="server" meta:resourcekey="Rs_OP_Perf_Phy_Res2"></asp:Label>
                                    <b>
                                        <asp:Label ID="Rs_IP_PP" Text="IP-PerfPhy" runat="server" meta:resourcekey="Rs_IP_Perf_Phy_Res1"></asp:Label></b>
                                    <asp:Label ID="Rs_IP_PP1" Text=":Performing Physician(IP), " runat="server" meta:resourcekey="Rs_IP_Perf_Phy_Res2"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                            CellPadding="0" DataKeyNames="PhysicianID" ForeColor="#333333" GridLines="None"
                            Width="100%" PageSize="10" OnRowDataBound="grdResult_RowDataBound" OnPageIndexChanging="grdResult_PageIndexChanging"
                            HeaderStyle-BorderWidth="0px" meta:resourcekey="grdResultResource1">
                            <%-- <PagerTemplate>
                                <tr>
                                    <td align="center" colspan="6">
                                        <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="false" CommandArgument="Prev"
                                            CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" Width="18px" />
                                        <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="false" CommandArgument="Next"
                                            CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" Width="18px" />
                                    </td>
                                </tr>
                            </PagerTemplate>
                            <PagerSettings Mode="NumericFirstLast"></PagerSettings>--%>
                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                            <Columns>
                                <asp:TemplateField meta:resourcekey="TemplateFieldResource3">
                                    <ItemTemplate>
                                        <table cellpadding="0" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                                            cellspacing="0" border="1" width="100%">
                                            <tr>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                        <tr>
                                                            <td>
                                                                <table cellpadding="5" cellspacing="0" border="0" width="100%">
                                                                    <tr class="Duecolor">
                                                                        <td align="left" style="font-weight: bold;">
                                                                            <asp:Label ID="lblPhy" Text='<%# DataBinder.Eval(Container.DataItem,"PhysicianName") %>'
                                                                                runat="server" meta:resourcekey="lblPhyResource1"></asp:Label>
                                                                        </td>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="grdChildResult" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                                    PageSize="100" ForeColor="Black" GridLines="Both" OnRowDataBound="grdChildResult_RowDataBound"
                                                                    Width="100%" meta:resourcekey="grdChildResultResource1">
                                                                    <PagerTemplate>
                                                                        <tr>
                                                                            <td align="center" colspan="6">
                                                                                <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                                                    CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" Width="18px"
                                                                                    meta:resourcekey="lnkPrevResource1" />
                                                                                <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                                                    CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" Width="18px"
                                                                                    meta:resourcekey="lnkNextResource1" />
                                                                            </td>
                                                                        </tr>
                                                                    </PagerTemplate>
                                                                    <HeaderStyle Font-Underline="True" />
                                                                    <RowStyle Font-Bold="False" />
                                                                    <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="PaymentType" meta:resourcekey="TemplateFieldResource1">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="isCreditBill" runat="server" Text='<%# Eval("IsCreditBill") %>' meta:resourcekey="isCreditBillResource1" />
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Center" Width="11%" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Visit Type" meta:resourcekey="TemplateFieldResource2">
                                                                            <ItemTemplate>
                                                                                <asp:HyperLink ID="lnkID" Font-Bold="True" Font-Size="12px" NavigateUrl='<%# String.Format("PhysicianwiseCollectionDetailReport.aspx?physicianID={0}&fromDate="+txtFrom.Text+"&toDate="+txtTo.Text+"&type={1}&PhyName={2}&ftype={3}&creditBill={4}", Eval("PhysicianID"), Eval("VisitType"),Eval("PhysicianName"),Eval("FeeType"),Eval("IsCreditBill")) %>'
                                                                                    Text='<%# Bind("VisitType") %>' Font-Underline="True" ToolTip="Click To View Details"
                                                                                    ForeColor="Black" Target="ReportWindow" runat="server" meta:resourcekey="lnkIDResource1"></asp:HyperLink>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Center" Width="12%" />
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="FeeDescription" HeaderText="Description">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center" Width="12%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <%--<asp:BoundField DataField="FeeType" HeaderText="Fee Type">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center" Width="12%"></ItemStyle>
                                                                        </asp:BoundField>--%>
                                                                        <asp:BoundField DataField="Quantity" HeaderText="No's" meta:resourcekey="BoundFieldResource1">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center" Width="5%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Amount" DataFormatString="{0:0.00}" HeaderText="Collection Amount"
                                                                            meta:resourcekey="BoundFieldResource2">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                         <asp:BoundField DataField="DiscountAmount" DataFormatString="{0:0.00}" HeaderText="Discount Amount">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="RefundAmount" DataFormatString="{0:0.00}" HeaderText="Refund Amount">
                                                                            <HeaderStyle HorizontalAlign="center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="AmountToHostingOrg" DataFormatString="{0:0.00}" HeaderText="Amount To Organisation"
                                                                            meta:resourcekey="BoundFieldResource3">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="PhysicianAmount" DataFormatString="{0:0.00}" HeaderText="Amount To Physician"
                                                                            meta:resourcekey="BoundFieldResource4">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                                                        </asp:BoundField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <table border="1" width="100%">
                                                                    <tr style="font-weight: bold; color: Blue;">
                                                                        <td style="width: 11%;" align="center">
                                                                        </td>
                                                                        <td style="width: 12%;" align="center">
                                                                        </td>
                                                                        <td style="width: 12%;" align="center">
                                                                            <asp:Label ID="lblSubTotal" runat="server" meta:resourcekey="lblSubTotalResource1"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 5%;" align="center">
                                                                            <asp:Label ID="lblQty" runat="server" meta:resourcekey="lblQtyResource1"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 12%;" align="Right">
                                                                            <asp:Label ID="lblCA" runat="server" meta:resourcekey="lblCAResource1"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 12%;" align="Right">
                                                                            <asp:Label ID="lblDA" runat="server"></asp:Label>
                                                                        </td>
                                                                         <td style="width: 12%;" align="Right">
                                                                            <asp:Label ID="lblRA" runat="server"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 12%;" align="Right">
                                                                            <asp:Label ID="lblAmtToOrg" runat="server" meta:resourcekey="lblAmtToOrgResource1"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 12%;" align="Right">
                                                                            <asp:Label ID="lblAmtToPhy" runat="server" meta:resourcekey="lblAmtToPhyResource1"></asp:Label>
                                                                        </td>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle BorderWidth="0px"></HeaderStyle>
                        </asp:GridView>
                        <table id="tabPageTotal" style="display: none;" runat="server" cellpadding="0" cellspacing="0"
                            border="0" width="100%">
                            <tr>
                                <td>
                                    <table cellpadding="0" cellspacing="0" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                                        border="1" width="100%">
                                        <tr style="height: 25px; font-weight: bold;">
                                            <td colspan="2" align="center" width="40%">
                                                <asp:Label ID="Rs_PageTotal" Text="Page Total" runat="server" meta:resourcekey="Rs_PageTotalResource1"></asp:Label><asp:Label
                                                    ID="lblPTC" runat="server" ForeColor="Red" meta:resourcekey="lblPTCResource1"></asp:Label>
                                            </td>
                                            <td id="tdCollectionAmount" width="12%" align="right" runat="server">
                                            </td>
                                            <td id="tdDiscountAmount" width="12%" align="right" runat="server">
                                            </td>
                                            <td id="tdRefundAmount" width="12%" align="right" runat="server">
                                            </td>
                                            <td id="tdOrganisationAmount" width="12%" align="right" runat="server">
                                            </td>
                                            <td id="tdPhysicianAmount" width="12%" align="right" runat="server">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                             <tr>
                                <td id="tdscalc" runat="server" visible="false">
                                    <table cellpadding="4" cellspacing="0" class="dataheaderInvCtrl" style="border-collapse: collapse;font-weight:bold;"
                                        border="1" width="100%">
                                        <tr id="Tr1" align="right" runat="server">
                                            <td  width="88%">
                                                <asp:Label ID="lbltds" Text="TDS (10%)" runat="server" />
                                            </td>
                                            <td id="Td1" align="right" runat="server">
                                                <asp:Label ID="lbltdsamt" Text="0.00" runat="server" />
                                            </td>
                                        </tr>
                                        <tr id="Tr2" align="right" runat="server">
                                            <td>
                                            </td>
                                            <td id="Td2" align="right" runat="server">
                                                <asp:Label ID="Label1" Text="---------------" runat="server" />
                                            </td>
                                        </tr>
                                        <tr id="Tr3" align="right" runat="server">
                                            <td class="style2">
                                                <asp:Label ID="lbls" Text="Net Total" runat="server" />
                                            </td>
                                            <td id="Td3" align="right" runat="server">
                                                <asp:Label ID="lblnettotal" Text="0.00" runat="server" />
                                            </td>
                                        </tr>
                                        <tr id="Tr4" align="right" runat="server">
                                            <td>
                                            </td>
                                            <td id="Td4" align="right" runat="server">
                                                <asp:Label ID="Label4" Text="---------------" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
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
