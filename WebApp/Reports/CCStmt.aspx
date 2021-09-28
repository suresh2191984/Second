<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CCStmt.aspx.cs" Inherits="Reports_CCStmt"
    meta:resourcekey="PageResource1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <style type="text/css">
        .grd
        {
            text-align: right;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function validateToDate() {
            var AlertType = SListForAppMsg.Get('Reports_CancelledBillReport_aspx_02') == null ? "Alert" : SListForAppMsg.Get('Reports_CancelledBillReport_aspx_02');
            var objcli = SListForAppMsg.Get('Reports_CCStmt_aspx_01') == null ? "Provide / select value for From date" : SListForAppMsg.Get('Reports_CCStmt_aspx_01');

            if (document.getElementById('txtFDate').value == '') {
                ValidationWindow(objcli, AlertType);
                //alert('Provide / select value for From date');
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                ValidationWindow(objcli, AlertType);
               // alert('Provide / select value for To date');
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
       

<%--        <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

        <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>

        <script type="text/javascript">
//            $(function() {
//                $("#txtFDate").datepicker({
//                    changeMonth: true,
//                    changeYear: true,
//                    maxDate: 0,
//                    yearRange: '2008:2030'
//                });
//                $("#txtTDate").datepicker({
//                    changeMonth: true,
//                    changeYear: true,
//                    maxDate: 0,
//                    yearRange: '2008:2030'
//                })
            //            });
            $(function() {
                $("#txtFDate").datepicker({
                    dateFormat: 'dd/mm/yy',
                    defaultDate: "+1w",
                    changeMonth: true,
                    changeYear: true,
                    maxDate: 0,
                    yearRange: '1900:2100',
                    onClose: function(selectedDate) {
                        $("#txtTo").datepicker("option", "minDate", selectedDate);

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
                        $("#txtFrom").datepicker("option", "maxDate", selectedDate);
                    }
                })
            });

        </script>

        <table id="tblCollectionOPIP" class="a-center w-100p">
            <tr align="center">
                <td align="left">
                    <div class="dataheaderWider">
                        <table id="tbl">
                            <tr id="trTrustedOrg" runat="server" style="display: table-row;">
                                <td colspan="5">
                                    <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" 
                                        meta:resourcekey="lblOrgsResource1"></asp:Label>
                                    &nbsp;
                                    <asp:DropDownList ID="ddlTrustedOrg" AutoPostBack="true" onchange="javascript:clearContextText();"
                                        runat="server" CssClass="ddl" OnSelectedIndexChanged="ddlTrustedOrg_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="Rs_Location" runat="server" Text="Location" meta:resourcekey="Rs_LocationResource1"></asp:Label>
                                    &nbsp;
                                    <asp:DropDownList CssClass="ddlsmall" runat="server" ID="ddlLocation" meta:resourcekey="ddLOResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                        <ContentTemplate>
                                            <asp:Label ID="lblPayment" runat="server" Text="Payment Mode" 
                                        meta:resourcekey="lblPaymentResource1"></asp:Label>
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
                                    <asp:Label ID="lblPatientName" Text="PatientName" runat="server" meta:resourcekey="lblResource1"></asp:Label>
                                    <asp:TextBox ID="txtPatientName" CssClass="Txtboxsmall" Width="100px" runat="server"
                                        meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Panel ID="pnlVisitType" CssClass="w-100p" GroupingText="Visit Type" 
                                        runat="server" meta:resourcekey="pnlVisitTypeResource1">
                                        <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" runat="server">
                                          <%--  <asp:ListItem Text="OP" Selected="True" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                            <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                            <asp:ListItem Text="OP&IP" Value="-1" meta:resourcekey="ListItemResource3"></asp:ListItem>--%>
                                        </asp:RadioButtonList>
                                    </asp:Panel>
                                </td>
                                <td>
                                    <asp:Panel ID="pnReportType" CssClass="w-100p" GroupingText="Report Type" 
                                        runat="server" meta:resourcekey="pnReportTypeResource1">
                                        <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" runat="server">
                                            
                                         <%--   <asp:ListItem Text="Summary" Selected="True" Value="0" meta:resourcekey="ListItemResource4"></asp:ListItem>
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
                                    <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age"
                                        OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <asp:Panel ID="pHeader1" runat="server" meta:resourcekey="pHeaderResource1">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Image ID="ImgCollapse" runat="server" meta:resourcekey="ImgCollapseResource1" />
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblText" runat="server" meta:resourcekey="lblTextResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel ID="pBody" runat="server" meta:resourcekey="pBodyResource1">
                                        <table class="w-100p bg-row">
                                            <tr>
                                                <td>
                                                    <asp:CheckBoxList ID="chkUser" runat="server" RepeatColumns="8" 
                                                        meta:resourcekey="chkUserResource1">
                                                    </asp:CheckBoxList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-right">
                                                    <asp:Button ID="btnUpdateFilter" runat="server" onmouseout="this.className='btn'"
                                                        onmouseover="this.className='btn btnhov'" Text="Ok" OnClick="btnSubmit_Click"
                                                        meta:resourcekey="btnUpdateFilterResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <ajc:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" TargetControlID="pBody"
                                        CollapseControlID="pHeader1" ExpandControlID="pHeader1" Collapsed="True" TextLabelID="lblText"
                                        CollapsedText="Show User Filter" ExpandedText="Hide User Filter" ImageControlID="ImgCollapse"
                                        ExpandedImage="../images/collapse.jpg" CollapsedImage="../images/expand.jpg"
                                        Enabled="True" meta:resourcekey="CollapsiblePanelExtender1Resource1" >
                                    </ajc:CollapsiblePanelExtender>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <asp:UpdateProgress ID="Progressbar" runat="server">
                        <ProgressTemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>
                    </asp:UpdateProgress>
                    <div id="contentArea">
                        <div id="divPrint" style="display: none;" runat="server">
                            <table class="w-95p">
                                <tr>
                                    <td class="a-right0 paddingR10" style="color: #000000;">
                                        <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                            ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                        <asp:LinkButton ID="lnkExportXL" Text="Export To XL" Font-Underline="True" runat="server"
                                            Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel" OnClick="lnkBtnXL_Click"
                                            meta:resourcekey="lnkExportXLResource1"></asp:LinkButton>
                                        <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                            ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                        <b id="printText" runat="server">
                                            <asp:LinkButton ID="lnkPrint" Text="Print Report" Font-Underline="True" OnClientClick="return popupprint();"
                                                runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel"
                                                meta:resourcekey="lnkExportXLResource2"></asp:LinkButton></b>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                            <ContentTemplate>
                                <div id="divOPDWCR" runat="server" style="display: none;">
                                    <div id="prnReport">
                                        <table class="w-100p">
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="GvSum" runat="server" AutoGenerateColumns="False" CssClass="w-80p gridView mytable1" ForeColor="#333333"
                                                        meta:resourcekey="gvIPCreditMainResource12">
                                                        <Columns>
                                                            <asp:BoundField DataField="VisitDate" HeaderText="Bill Date" DataFormatString="{0:d}"
                                                                meta:resourcekey="BoundFieldResource20">
                                                                <HeaderStyle Width="20%" HorizontalAlign="Center" Wrap="false" />
                                                                <ItemStyle Width="20%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="CollectedName" HeaderText="Receiver Name" meta:resourcekey="BoundFieldResource20">
                                                                <HeaderStyle Width="20%" HorizontalAlign="Center" Wrap="false" />
                                                                <ItemStyle Width="20%" HorizontalAlign="Left" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="PatientCount" HeaderText="Bill Count" meta:resourcekey="BoundFieldResource15">
                                                                <HeaderStyle Width="10%" HorizontalAlign="Center" Wrap="false" />
                                                                <ItemStyle Width="10%" />
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Payertype" HeaderText="Payment Mode" meta:resourcekey="BoundFieldResource25">
                                                                <HeaderStyle Width="15%" Wrap="false" HorizontalAlign="Center" />
                                                                <ItemStyle Width="10%" />
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="ReceivedAmount" HeaderText="Total Received Amount" meta:resourcekey="BoundFieldResource17">
                                                                <HeaderStyle Width="20%" HorizontalAlign="Center" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Right" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="ServiceCharge" HeaderText="Total Credit/Debit CardCharge(%)"
                                                                meta:resourcekey="BoundFieldResource18">
                                                                <HeaderStyle Width="20%" Wrap="false" HorizontalAlign="Center" />
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
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="gvIPCreditMain" runat="server" OnRowDataBound="gvIPCreditMain_RowDataBound"
                                                        AutoGenerateColumns="False" ForeColor="#333333" CssClass="mytable1 w-100p gridView"
                                                        meta:resourcekey="gvIPCreditMainResource1">
                                                        <Columns>
                                                            <asp:BoundField DataField="VisitDate" HeaderText="Bill Date" DataFormatString="{0:d}"
                                                                meta:resourcekey="BoundFieldResource9">
                                                                <HeaderStyle Width="10%" HorizontalAlign="Left" Wrap="false" />
                                                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="BillNumber" HeaderText="Bill No" meta:resourcekey="BoundFieldResource5">
                                                                <HeaderStyle Width="10%" HorizontalAlign="Center" Wrap="false" />
                                                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" meta:resourcekey="BoundFieldResource1">
                                                                <HeaderStyle Width="10%" HorizontalAlign="Center" Wrap="false" />
                                                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="PatientName" HeaderText="PatientName" meta:resourcekey="BoundFieldResource2">
                                                                <HeaderStyle Width="20%" HorizontalAlign="Left" Wrap="false" />
                                                                <ItemStyle Width="20%" HorizontalAlign="Left" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Age" HeaderText="Age/Gender" meta:resourcekey="BoundFieldResource14">
                                                                <HeaderStyle Width="10%" HorizontalAlign="Center" Wrap="false" />
                                                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="VisitState" HeaderText="Visit Number" meta:resourcekey="BoundFieldResource21">
                                                                <HeaderStyle Width="10%" HorizontalAlign="Center" Wrap="false" />
                                                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="VisitType" HeaderText="Visit" meta:resourcekey="BoundFieldResource6">
                                                                <HeaderStyle Width="10%" HorizontalAlign="Center" Wrap="false" />
                                                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Payertype" HeaderText="Payment Mode" meta:resourcekey="BoundFieldResource37">
                                                                <HeaderStyle Width="15%" HorizontalAlign="Center" Wrap="false" />
                                                                <ItemStyle Width="15%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="ReceivedAmount" HeaderText="Rcvd Amount" meta:resourcekey="BoundFieldResource7">
                                                                <HeaderStyle Width="15%" HorizontalAlign="Center" Wrap="false" />
                                                                <ItemStyle Width="15%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="CreditorDebitCard" HeaderText="Bank/Card Name" meta:resourcekey="BoundFieldResource3">
                                                                <HeaderStyle Width="20%" HorizontalAlign="Center" Wrap="false" />
                                                                <ItemStyle Width="20%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="CollectedName" HeaderText="Receiver Name" meta:resourcekey="BoundFieldResource20">
                                                                <HeaderStyle Width="30%" HorizontalAlign="Center" Wrap="false" />
                                                                <ItemStyle Width="30%" HorizontalAlign="Left" />
                                                            </asp:BoundField>
                                                            <%--<asp:BoundField DataField="ReceiptNo" ItemStyle-Width="75px" HeaderText="Receipt No" />--%>
                                                            <asp:BoundField DataField="ServiceCharge" HeaderText="Credit/Debit Card Charge (%)"
                                                                meta:resourcekey="BoundFieldResource8">
                                                                <HeaderStyle Width="20%" HorizontalAlign="Center" Wrap="false" />
                                                                <ItemStyle Width="20%" HorizontalAlign="Center" />
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
                                        <br />
                                        <div id="breakup" runat="server">
                                            <table id= "tabGranTotal1" runat="server" visible="False" class="dataheaderWider w-100p"
                                                style="color: #000000;">
                                                <tr runat="server">
                                                    <td class="a-right w-30p" runat="server">
                                                        <asp:Label ID="Rs_TotalCardAmount" Text="Total Amount" runat="server" 
                                                            meta:resourcekey="Rs_TotalCardAmountResource1"></asp:Label>
                                                        <label id="Label1" style="color: Green;" runat="server">
                                                            <%=Resources.Reports_ClientDisplay.Reports_CCStmt_aspx_01%><%--(A)--%></label>:
                                                    </td>
                                                    <td class="a-center w-20p" runat="server">
                                                        <label id="lblCardTotal" runat="server">
                                                        </label>
                                                    </td>
                                                    <td class="a-right" runat="server">
                                                    </td>
                                                </tr>
                                                <tr runat="server">
                                                    <td class="a-right w-60p" runat="server">
                                                        <asp:Label ID="Rs_TotalServiceCharge" Text="Total Service Charge" 
                                                            runat="server" meta:resourcekey="Rs_TotalServiceChargeResource1"></asp:Label>
                                                        <label id="Label5" style="color: Green;" runat="server">
                                                            <%=Resources.Reports_ClientDisplay.Reports_CCStmt_aspx_02%>
                                                            <%--(B)--%></label>
                                                        :
                                                    </td>
                                                    <td class="a-center w-20p" runat="server">
                                                        <label id="lblServiceCharge" runat="server">
                                                        </label>
                                                    </td>
                                                    <td id="Td1" class="a-left" runat="server">
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
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
