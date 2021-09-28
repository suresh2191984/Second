<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CCStmtLims.aspx.cs" Inherits="ReportsLims_CCStmtLims"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <style type="text/css">
        .grd
        {
            text-align: right;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function validateToDate() {
            var AlrtWinHdr = SListForAppMsg.Get("ReportsLims_CCStmtLims_aspx_Alert") != null ? SListForAppMsg.Get("ReportsLims_CCStmtLims_aspx_Alert") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("ReportsLims_CCStmtLims_aspx_01") != null ? SListForAppMsg.Get("ReportsLims_CCStmtLims_aspx_01") : "Provide / select value for From date";
            var UsrAlrtMsg1 = SListForAppMsg.Get("ReportsLims_CCStmtLims_aspx_02") != null ? SListForAppMsg.Get("ReportsLims_CCStmtLims_aspx_02") : "Provide / select value for To date";
            
            if (document.getElementById('txtFDate').value == '') {
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                //alert('Provide / select value for From date');
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                //alert('Provide / select value for To date');
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
        function clearContextText() {
            $('#contentArea').hide();

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
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table id="tblCollectionOPIP" class="w-100p a-center">
            <tr class="a-center">
                <td class="a-left">
                    <div class="dataheaderWider">
                        <table id="tbl">
                            <tr id="trTrustedOrg" runat="server" style="display: table-row;">
                                <td colspan="5">
                                    <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization"></asp:Label>
                                    &nbsp;
                                    <asp:DropDownList ID="ddlTrustedOrg" AutoPostBack="true" onchange="javascript:clearContextText();"
                                        runat="server" CssClass="ddl" OnSelectedIndexChanged="ddlTrustedOrg_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                        <ContentTemplate>
                                            <asp:Label ID="lblPayment" runat="server" Text="Payment Mode"></asp:Label>
                                            &nbsp;
                                            <asp:DropDownList ID="ddlPaymentType" runat="server" CssClass="ddl">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlTrustedOrg" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                                <td>
                                    <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                    <asp:TextBox ID="txtFDate" CssClass="Txtboxsmall" Width="70px" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                    <asp:TextBox ID="txtTDate" CssClass="Txtboxsmall" Width="70px" runat="server" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                    <%-- <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
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
                                    <asp:Panel ID="pnlVisitType" Width="100%" GroupingText="Visit Type" runat="server">
                                        <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" runat="server"
                                            >
                                           <%-- <asp:ListItem Text="OP" Selected="True" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                            <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                            <asp:ListItem Text="OP&IP" Value="-1" meta:resourcekey="ListItemResource3"></asp:ListItem>--%>
                                        </asp:RadioButtonList>
                                    </asp:Panel>
                                </td>
                                <td>
                                    <asp:Panel ID="pnReportType" Width="100%" GroupingText="Report Type" runat="server">
                                        <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" runat="server"
                                            >
                                           <%-- <asp:ListItem Text="Summary" Selected="True" Value="0" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                            <asp:ListItem Text="Detail" Value="1" meta:resourcekey="ListItemResource5"></asp:ListItem>--%>
                                        </asp:RadioButtonList>
                                    </asp:Panel>
                                </td>
                                <td>
                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                        OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                </td>
                                <td>
                                    <asp:LinkButton ID="lnkBack" Width="100%" Text="Back" Font-Underline="True" runat="server"
                                        CssClass="details_label_age" OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
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
                            <table class="w-95p">
                                <tr>
                                    <td class="a-right paddingR10">
                                        <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                            ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
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
                                        <asp:GridView ID="gvIPReport" runat="server" AutoGenerateColumns="False" Visible="False"
                                            OnRowDataBound="gvIPReport_RowDataBound" CssClass="w-100p gridView" meta:resourcekey="gvIPReportResource1">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Collection Report" meta:resourcekey="TemplateFieldResource1">
                                                    <ItemTemplate>
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td class="a-left h-25">
                                                                    <b>
                                                                        <asp:Label ID="Rs_Date" Text="Date:" runat="server" meta:resourcekey="Rs_DateResource1"></asp:Label></b>
                                                                    <%# DataBinder.Eval(Container.DataItem, "VisitDate", "{0:dd/MM/yyyy}")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:GridView ID="gvIPCreditMain" runat="server" AutoGenerateColumns="False" ForeColor="#333333"
                                                                        CssClass="mytable1 w-100p gridView" OnRowDataBound="gvIPCreditMain_RowDataBound"
                                                                        meta:resourcekey="gvIPCreditMainResource1">
                                                                        <Columns>
                                                                            <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" meta:resourcekey="BoundFieldResource1">
                                                                                <ItemStyle Width="25px" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="PatientName" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                                                                <ItemStyle HorizontalAlign="Left" Wrap="False" Width="180px"></ItemStyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="CreditorDebitCard" HeaderText="Bank/Card Name" meta:resourcekey="BoundFieldResource3">
                                                                                <ItemStyle HorizontalAlign="Left" Wrap="False" Width="180px"></ItemStyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="Age" HeaderText="Age" meta:resourcekey="BoundFieldResource4">
                                                                                <ItemStyle HorizontalAlign="Left" Wrap="False" Width="80px"></ItemStyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="BillNumber" HeaderText="Bill No" meta:resourcekey="BoundFieldResource5">
                                                                                <ItemStyle Width="25px" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="ReceiptNo" ItemStyle-Width="75px" HeaderText="Receipt No" />
                                                                            <asp:BoundField DataField="VisitType" HeaderText="Visit" meta:resourcekey="BoundFieldResource6">
                                                                                <ItemStyle Width="25px" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="ReceivedAmount" HeaderText="Rcvd Amount" meta:resourcekey="BoundFieldResource7">
                                                                                <HeaderStyle Width="60px" />
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="ServiceCharge" HeaderText="Credit/Debit Card Charge (%)"
                                                                                meta:resourcekey="BoundFieldResource8">
                                                                                <HeaderStyle Width="30px" />
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                            </asp:BoundField>
                                                                        </Columns>
                                                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                        <PagerStyle BackColor="White" ForeColor="#000066" />
                                                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                        <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                    </asp:GridView>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <br />
                                        <div id="breakup" runat="server">
                                            <table border="0" id="tabGranTotal1" runat="server" visible="False" class="dataheaderWider w-100p">
                                                <tr runat="server">
                                                    <td class="a-right w-60p" runat="server">
                                                        <asp:Label ID="Rs_TotalCardAmount" Text="Total Card Amount" runat="server"></asp:Label>
                                                        <label id="Label1" style="color: Green;" runat="server">
                                                            (A)</label>
                                                        :
                                                    </td>
                                                    <td class="a-right w-20p" runat="server">
                                                        <label id="lblCardTotal" runat="server">
                                                        </label>
                                                    </td>
                                                    <td class="a-right" runat="server">
                                                    </td>
                                                </tr>
                                                <tr runat="server">
                                                    <td class="a-right w-60p" runat="server">
                                                        <asp:Label ID="Rs_TotalServiceCharge" Text="Total Service Charge" runat="server"></asp:Label>
                                                        <label id="Label5" style="color: Green;" runat="server">
                                                            (B)</label>
                                                        :
                                                    </td>
                                                    <td class="a-right" runat="server">
                                                    </td>
                                                    <td class="a-right w-20p" runat="server">
                                                        <label id="lblServiceCharge" runat="server">
                                                        </label>
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
     <asp:HiddenField ID="hdnMessages" runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
    <%--                        <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

                        <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>

    <script type="text/javascript">
        //                            $(function() {
        //                                $("#txtFDate").datepicker({
        //                                    changeMonth: true,
        //                                    changeYear: true,
        //                                    maxDate: 0,
        //                                    yearRange: '2008:2030'
        //                                });
        //                                $("#txtTDate").datepicker({
        //                                    changeMonth: true,
        //                                    changeYear: true,
        //                                    maxDate: 0,
        //                                    yearRange: '2008:2030'
        //                                })
        //                            });
        $(function() {
            $("#txtFDate").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    $("#txtTDate").datepicker("option", "minDate", selectedDate);

                    var date = $("#txtFDate").datepicker('getDate');
                    //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                    // $("#txtTo").datepicker("option", "maxDate", d);

                }
            });
            $("#txtTDate").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    $("#txtFDate").datepicker("option", "maxDate", selectedDate);
                }
            })
        });
    </script>

</body>
</html>
