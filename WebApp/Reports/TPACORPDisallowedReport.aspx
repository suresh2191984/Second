<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TPACORPDisallowedReport.aspx.cs"
    Inherits="Reports_TPACORPDisallowedReport" Culture="auto" meta:resourcekey="PageResource1"
     %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
    <%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>TPA Corp out standing Report</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/AutoComplete.js" language="javascript"></script>

    <script type="text/javascript" src="../Scripts/DHEBAdder.js"></script>

<%--    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>--%>
<script type ="text/javascript" language ="javascript" >
    function ShowAlertMsg(key) {
        var AlrtWinHdr = SListForAppMsg.Get("Reports_TPACORPDisallowedReport_Alert") != null ? SListForAppMsg.Get("Reports_TPACORPDisallowedReport_Alert") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("Reports_TPACORPDisallowedReport_aspx_01") != null ? SListForAppMsg.Get("Reports_TPACORPDisallowedReport_aspx_01") : "No Datas Found";
       var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                ValidationWindow(userMsg, AlrtWinHdr);
                //alert(userMsg);
                return false ;
            }
            else
            {
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
           // alert('No Datas Found');
            return false ;
            }
         
           return true;
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

</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <div>
                            <table class="dataheader2 defaultfontcolor a-left w-100p searchPanel">
                                <tr>
                                    <td>
                                        <table class="w-50p">
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lbfrom" runat="server" Text="From :" meta:resourcekey="lbfromResource1"></asp:Label>
                                                    <asp:TextBox runat="server" ID="txtFromDate" MaxLength="10"  size="25" CssClass ="Txtboxsmall"
                                                        meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                    &nbsp;<asp:Image runat="server" ID="ImgBntCalc" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        Width="16px" Height="16px" border="0" alt="Pick from date" meta:resourcekey="ImgBntCalcResource1" />
                                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                                        TargetControlID="txtFromDate" Enabled="True" />
                                                    <asp:Label ID="lbto" runat="server" Text="To :" meta:resourcekey="lbtoResource1"></asp:Label>
                                                    <asp:TextBox runat="server" ID="txtToDate" MaxLength="10" CssClass="Txtboxsmall" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                                    &nbsp;<asp:Image runat="server" ID="ImgToDate" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        Width="16px" Height="16px" AlternateText="Pick to date" meta:resourcekey="ImgToDateResource1" />
                                                    <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgToDate"
                                                        TargetControlID="txtToDate" Enabled="True" />
                                                    <asp:Button runat="server" ID="btnGo" Text=" Go " CssClass="btn" TabIndex="6" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClick="btnGo_Click" meta:resourcekey="btnGoResource1" />
                                                    &nbsp;
                                                    <asp:Button ID="btnCancel" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                                        onmouseout="this.className='btn1'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                                    <%--<asp:LinkButton ID="lnkBack" runat="server" CssClass="btn" OnClick="lnkBack_Click"
                                                        meta:resourcekey="lnkBackResource1">
                                                        <asp:Label ID="lbback" runat="server" Text="Back" meta:resourcekey="lbbackResource1"></asp:Label>
                                                    </asp:LinkButton>--%>
                                                    &nbsp;
                                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="a-center" id="printCashClosure">
                            <table class="defaultfontcolor a-left w-100p">
                                <tr id="tralldetails" runat="server">
                                    <td class="v-top">
                                        <div id="divAllUsers" runat="server">
                                            <table style="color: Black; font-family: Verdana;" width="100%" class="defaultfontcolor a-left w-100p">
                                                <tr>
                                                    <td class="v-top dataheader2" nowrap="nowrap">
                                                        <asp:GridView ID="grdResult" runat="server" EmptyDataText="No Results Found." AutoGenerateColumns="False"
                                                            CellPadding="4" CssClass="mytable1 gridView w-100p" meta:resourcekey="grdResultResource1">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <RowStyle HorizontalAlign="Left" Font-Size="10px" />
                                                            <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                                PageButtonCount="5" PreviousPageText="" />
                                                            <Columns>
                                                                <asp:BoundField DataField="BillNumber" HeaderText="Bill No" meta:resourcekey="BoundFieldResource1" />
                                                                <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" meta:resourcekey="BoundFieldResource2" />
                                                                <asp:BoundField DataField="Name" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource3" />
                                                                <asp:BoundField DataField="NetAmount" HeaderText="Net Amount" DataFormatString="{0:0.00}"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource4">
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="ReceivedAmount" HeaderText="Pt-Settled Amount" DataFormatString="{0:0.00}"
                                                                    ItemStyle-ForeColor="Red" ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource5">
                                                                    <ItemStyle HorizontalAlign="Right" ForeColor="Red"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="Patient Due Amount" ItemStyle-HorizontalAlign="Right"
                                                                    meta:resourcekey="TemplateFieldResource1">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblPatientDueAmt" Text='<%# CalcPatientDueAmount(Eval("NetAmount"),Eval("TPABillAmount"),Eval("ReceivedAmount")) %>'
                                                                            runat="server" meta:resourcekey="lblPatientDueAmtResource1"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="TPAName" HeaderText="TPA/Insurance/Corporate" meta:resourcekey="BoundFieldResource6" />
                                                                <asp:BoundField DataField="PreAuthAmount" DataFormatString="{0:0.00}" HeaderText="TPA Pre-Auth Amt"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource7">
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="TPABillAmount" DataFormatString="{0:0.00}" HeaderText="Claim Amt"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource8">
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="TPAAmount" DataFormatString="{0:0.00}" HeaderText="TPA/Corp Cheque Amt"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource9">
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="TDS" DataFormatString="{0:0.00}" HeaderText="TPA/Corp TDS Deduction"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource10">
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="TPADiscountAmt" DataFormatString="{0:0.00}" HeaderText="TPA/Corp Discount Amt"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource11">
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="TPASettledAmt" DataFormatString="{0:0.00}" ItemStyle-ForeColor="Red"
                                                                    HeaderText="TPA/Corp Settled Amt" ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource12">
                                                                    <ItemStyle HorizontalAlign="Right" ForeColor="Red"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="TPADisallowedAmt" DataFormatString="{0:0.00}" HeaderText="Disallowed Amt"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource13">
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="TPARemarks" HeaderText="DA Reason" meta:resourcekey="BoundFieldResource14" />
                                                                <asp:BoundField DataField="WriteOffApprover" HeaderText="Entered By" meta:resourcekey="BoundFieldResource15" />
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                     <asp:HiddenField ID="hdnMessages" runat="server" />
        <Attune:Attunefooter ID="Attunefooter" runat="server" />        
    </form>
</body>
</html>
