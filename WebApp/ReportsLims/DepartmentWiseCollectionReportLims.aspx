<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DepartmentWiseCollectionReportLims.aspx.cs"
    Inherits="ReportsLims_DepartmentWiseCollectionReportLims" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

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
        function clearContextText() {
            $('#tblContent').hide();

        }

        function CallPrint() {


            $('#trPrint').css('display', 'table-row');
            var prtContent = document.getElementById('tblContent');

            // var strOldOne=prtContent.innerHTML;



            var WinPrint = window.open('', '', 'left=0,top=0,width=1000,height=1000,status=0');
            WinPrint.document.write(prtContent.innerHTML);

            WinPrint.document.close();

            WinPrint.focus();



            WinPrint.print();



            WinPrint.print();

            WinPrint.close();

            // prtContent.innerHTML=strOldOne;

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
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <table id="tblCollectionOPIP" class="a-center w-100p">
                            <tr class="a-center">
                                <td class="a-left">
                                    <div class="dataheaderWider">
                                        <table id="tbl">
                                            <tr id="trTrustedOrg" runat="server" style="display: table-row;">
                                                <td>
                                    <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" meta:resourcekey="lblOrgsResource1"></asp:Label>
                                                    <asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" runat="server"
                                                        CssClass="ddl">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                 <asp:Label ID="lblfrmdt" runat="server" Text="From Date :" meta:resourcekey="lblfrmdtResource1"></asp:Label>
                                    <asp:TextBox ID="txtFDate" runat="server" CssClass="Txtboxsmall" Width="70px" meta:resourcekey="txtFDateResource1"></asp:TextBox>
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
                                               <asp:Label ID="lbltodt" runat="server" Text="To Date :" meta:resourcekey="lbltodtResource1"></asp:Label>
                                    <asp:TextBox ID="txtTDate" runat="server" CssClass="Txtboxsmall" Width="70px" meta:resourcekey="txtTDateResource1"></asp:TextBox>
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
                                    <asp:Panel ID="pnPatientType" Width="100%" GroupingText="Patient Type" runat="server" Visible="false"
                                        meta:resourcekey="pnPatientTypeResource1">
                                                        <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" RepeatColumns="3"
                                                            runat="server">
                                            <%--<asp:ListItem Text="OP" Selected="True" Value="0" 
                                                                meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                            <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                            <asp:ListItem Text="OP&IP" Value="-1" meta:resourcekey="ListItemResource3"></asp:ListItem>--%>
                                                        </asp:RadioButtonList>
                                                    </asp:Panel>
                                                </td>
                                                <td>
                                    <asp:Panel ID="pnReportType" runat="server" Width="100%" GroupingText="Report Type">
                                                       <%-- <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" runat="server">
                                            <asp:ListItem Text="RIS" Selected="True" Value="0" 
                                                                meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                            <asp:ListItem Text="LIS" Value="1" Selected="True" ></asp:ListItem>
                                                        </asp:RadioButtonList>--%>
                                                        <asp:CheckBoxList runat="server" ID="rblReportType">
                                                       <asp:ListItem Text="RIS" Value="0" 
                                                                ></asp:ListItem>
                                                            <asp:ListItem Text="LIS" Value="1" ></asp:ListItem>
                                                        </asp:CheckBoxList>
                                                    </asp:Panel>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                        OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                </td>
                                                <td>
                                    <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click"
                                        meta:resourcekey="lnkBackResource1">Back&nbsp;&nbsp;&nbsp;</asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="btn_export" runat="server" Font-Bold="true" Visible="true" Text="Export to Excel"
                                                        BackColor="" OnClick="btn_export_Click" Style="border-width: 2px;" Font-Size="12px"
                                                        ForeColor="#000000" Font-Underline="true"  meta:resourcekey="btn_exportResource1"/>
                                                </td>
                                                <td>
                                                  <input type="button" value="Print" runat="server" ID="btnPrintAll"  class="details_label_age" Visible="false" onclick="CallPrint();"
                                     />
                                    
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <table id="tblContent" class="w-100p">
                                        <tr>
                                            <td class="v-top w-40p">
                                                <asp:UpdateProgress ID="Progressbar" runat="server">
                                                    <ProgressTemplate>
                                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                        Please wait....
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                                <asp:UpdatePanel ID="updatePanel1" runat="server">
                                                    <ContentTemplate>
                                                        <div id="tblWithSplit" runat="server" style="display: none;">
                                                            <table>
                                                                <tr>
                                                                    <td class="v-top">
                                                                        <asp:Label ID="lblMessage" runat="server" Text="No Matching Records Found!" Font-Bold="true"
                                                            Visible="False" meta:resourcekey="lblMessageResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr style="display:none;" id="trPrint">
                                                                <td>
                                                                   <asp:Label ID="lblreport" runat="server"></asp:Label>
                                                                <asp:Label ID="lblfromdate" runat="server"></asp:Label>
                                                                <asp:Label ID="lblto" Text="To" runat="server"></asp:Label>
                                                                  <asp:Label ID="lbltodate" runat="server"></asp:Label>
                                                                
                                                                </td>
                                                                
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                    
                                                        <asp:Label ID="lblCash" runat="server" Text="Paid Patients :" Font-Bold="True" Visible="False"
                                                            meta:resourcekey="lblCashResource1"></asp:Label>
                                                                        <asp:GridView ID="grdCash" OnRowDataBound="grdCash_RowDataBound" runat="server" AutoGenerateColumns="False" Visible="false"
                                                            ForeColor="#333333" CssClass="mytable1 gridView w-100p" RowStyle-BackColor="White"
                                                            meta:resourcekey="grdCashResource1">
                                                                            <Columns>
                                                                <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                                                                    <ItemTemplate>
                                                                                        <%# Container.DataItemIndex + 1 %>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                <asp:BoundField HeaderText="Department" DataField="FeeType" HeaderStyle-HorizontalAlign="Center"
                                                                    meta:resourcekey="BoundFieldResource1" />
                                                                <asp:BoundField HeaderText="Amount Received" DataField="AmountReceived" Visible="false"
                                                                    meta:resourcekey="BoundFieldResource2" />
                                                                <asp:BoundField HeaderText="Due" DataField="Due" Visible="false" meta:resourcekey="BoundFieldResource3" />
                                                                                <asp:BoundField HeaderText="Billed Amount" DataField="BillAmount" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource4" />
                                                                                <%--<asp:BoundField HeaderText="Amount Received" DataFormatString="{0:0.00}" DataField="AmountReceived"
                                                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource5" />
                                                                                <asp:BoundField HeaderText="Cash" DataField="Cash" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource6" />
                                                                                <asp:BoundField HeaderText="Card" DataField="Cards" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource7" />
                                                                                <asp:BoundField HeaderText="Cheque" DataField="Cheque" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource8" />
                                                                                <asp:BoundField HeaderText="DD" DataField="DD" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource9" />
                                                                                <asp:BoundField HeaderText="Coupon" DataField="Coupon" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource10" />--%>
                                                                                <asp:BoundField HeaderText="Qty" DataField="Qty" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource11" />
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="v-top">
                                                                        <asp:Label ID="lblCredit" runat="server" Text="Credit Patients :" Font-Bold="true"
                                                            Visible="False" meta:resourcekey="lblCreditResource1"></asp:Label>
                                                                        <asp:GridView ID="grdCredit" OnRowDataBound="grdCredit_RowDataBound" runat="server" AutoGenerateColumns="False" Visible="false"
                                                            ForeColor="#333333" CssClass="mytable1 gridView w-100p" RowStyle-BackColor="White"
                                                            meta:resourcekey="grdCreditResource1">
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource101" >
                                                                                    <ItemTemplate>
                                                                                        <%# Container.DataItemIndex + 1 %>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                <asp:BoundField HeaderText="Department" DataField="FeeType" HeaderStyle-HorizontalAlign="Center"
                                                                    meta:resourcekey="BoundFieldResource12" />
                                                                                <asp:BoundField HeaderText="Amount Received" DataField="AmountReceived" Visible="false"
                                                                    DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource13" />
                                                                <asp:BoundField HeaderText="Due" DataField="Due" Visible="false" meta:resourcekey="BoundFieldResource14" />
                                                                                <asp:BoundField HeaderText="Billed Amount" DataField="BillAmount" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource15" />
                                                                              <%--  <asp:BoundField HeaderText="Amount Received" DataField="AmountReceived" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource16" />
                                                                                <asp:BoundField HeaderText="Cash" DataField="Cash" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource17" />
                                                                                <asp:BoundField HeaderText="Card" DataField="Cards" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource18" />
                                                                                <asp:BoundField HeaderText="Cheque" DataField="Cheque" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource19" />
                                                                                <asp:BoundField HeaderText="DD" DataField="DD" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource20" />
                                                                                <asp:BoundField HeaderText="Coupon" DataField="Coupon" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource21" />--%>
                                                                                <asp:BoundField HeaderText="Qty" DataField="Qty" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource22" />
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="v-top">
                                                                        <asp:Label ID="lblTotal" runat="server" Text="Paid & Credit Combined :" Font-Bold="true"
                                                            Visible="False" meta:resourcekey="lblTotalResource1"></asp:Label>
                                                                        <asp:GridView ID="grdTotal" runat="server" AutoGenerateColumns="False" Visible="false"
                                                                             ForeColor="#333333" CssClass="mytable1 w-100p gridView" RowStyle-BackColor="White"
                                                            OnRowDataBound="grdTotal_RowDataBound" OnRowCreated="grdTotal_RowCreated1" meta:resourcekey="grdTotalResource1">
                                                                            <Columns>
                                                                                <%-- <asp:TemplateField HeaderText="Department" meta:resourcekey="TemplateFieldResource1"  >
                                                                           <ItemTemplate >
                                                                            <asp:LinkButton ID="lnkDept" ForeColor="Blue" Font-Size="12px" Text='<%# Eval("FeeType") %>'
                                                                            runat="server" meta:resourcekey="lnkDeptResource1"></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="47%" />
                                                                            </asp:TemplateField>--%>
                                                                <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource3">
                                                                                    <ItemTemplate>
                                                                                        <%# Container.DataItemIndex + 1 %>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                <asp:BoundField HeaderText="Department" DataField="FeeType" HeaderStyle-HorizontalAlign="Center"
                                                                    meta:resourcekey="BoundFieldResource23" />
                                                                                <asp:BoundField HeaderText="Amount Received" DataField="AmountReceived" Visible="false"
                                                                    DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource24" />
                                                                <asp:BoundField HeaderText="Due" DataField="Due" Visible="false" DataFormatString="{0:0.00}"
                                                                    meta:resourcekey="BoundFieldResource25" />
                                                                                <asp:BoundField HeaderText="Billed Amount" DataField="BillAmount" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource26" />
                                                                               <%-- <asp:BoundField HeaderText="Amount Received" DataField="AmountReceived" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource27" />
                                                                                <asp:BoundField HeaderText="Cash" DataField="Cash" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource28" />
                                                                                <asp:BoundField HeaderText="Card" DataField="Cards" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource29" />
                                                                                <asp:BoundField HeaderText="Cheque" DataField="Cheque" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource30" />
                                                                                <asp:BoundField HeaderText="DD" DataField="DD" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource31" />
                                                                                <asp:BoundField HeaderText="Coupon" DataField="Coupon" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource32" />--%>
                                                                                <asp:BoundField HeaderText="Qty" DataField="Qty" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource33" />
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </td>
                                                                </tr>
                                                                <asp:HiddenField ID="hdnNeedSplitup" runat="server" Value="N" />
                                                            </table>
                                                        </div>
                                                        <div id="tblWithoutSplit" runat="server" style="display: none;">
                                                            <table class="w-100p">
                                                                <tr>
                                                                    <td class="v-top">
                                                                        <asp:Label ID="lblMessageError" runat="server" Text="No Matching Records Found!"
                                                            Font-Bold="True" Visible="False" meta:resourcekey="lblMessageErrorResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr class="v-top">
                                                                    <td>
                                                                        <asp:Label ID="lblCashPatient" runat="server" Text="Revenue From Cash Patients :"
                                                            Font-Bold="True" meta:resourcekey="lblCashPatientResource1"></asp:Label>
                                                                        <asp:GridView ID="grdCashPatient" runat="server" AutoGenerateColumns="False"
                                                                            ForeColor="#333333" CssClass="mytable1 w-100p gridView" RowStyle-BackColor="White" meta:resourcekey="grdCashPatientResource1">
                                                                            <Columns>
                                                                <asp:BoundField HeaderText="Department" DataField="FeeType" HeaderStyle-HorizontalAlign="Center"
                                                                    meta:resourcekey="BoundFieldResource34" />
                                                                                <asp:BoundField HeaderText="Amount Received" DataField="AmountReceived" Visible="false"
                                                                    DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource35" />
                                                                <asp:BoundField HeaderText="Due" DataField="Due" Visible="false" DataFormatString="{0:0.00}"
                                                                    meta:resourcekey="BoundFieldResource36" />
                                                                                <asp:BoundField HeaderText="Billed Amount" DataField="BillAmount" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource37">
                                                                </asp:BoundField>
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                    <td class="v-top">
                                                                        <asp:Label ID="lblCreditPatient" runat="server" Text="Revenue From Cash Patients :"
                                                            Font-Bold="True" meta:resourcekey="lblCreditPatientResource1"></asp:Label>
                                                                        <asp:GridView ID="grdCreditPatient" runat="server" AutoGenerateColumns="False"
                                                                            ForeColor="#333333" CssClass="mytable1 w-100p gridView" RowStyle-BackColor="White"  meta:resourcekey="grdCreditPatientResource1">
                                                                            <Columns>
                                                                                <asp:BoundField HeaderText="Department" DataField="FeeType" HeaderStyle-HorizontalAlign="Center"
                                                                    DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource38" />
                                                                                <asp:BoundField HeaderText="Amount Received" DataField="AmountReceived" Visible="false"
                                                                    DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource39" />
                                                                <asp:BoundField HeaderText="Due" DataField="Due" Visible="false" DataFormatString="{0:0.00}"
                                                                    meta:resourcekey="BoundFieldResource40" />
                                                                                <asp:BoundField HeaderText="Billed Amount" DataField="BillAmount" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource41" />
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                    <td class="v-top">
                                                                        <asp:Label ID="lblCashCreditPatient" runat="server" Text="Revenue From Cash & Credit Patients :"
                                                            Font-Bold="True" meta:resourcekey="lblCashCreditPatientResource1"></asp:Label>
                                                                        <asp:GridView ID="grdCashCreditPatient" runat="server" AutoGenerateColumns="False"
                                                                            ForeColor="#333333" CssClass="mytable1 gridView w-100p" RowStyle-BackColor="White"
                                                            OnRowDataBound="grdTotal_RowDataBound" OnRowCreated="grdTotal_RowCreated1" meta:resourcekey="grdCashCreditPatientResource1">
                                                                            <Columns>
                                                                                <asp:BoundField HeaderText="Department" DataField="FeeType" HeaderStyle-HorizontalAlign="Center"
                                                                                    DataFormatString="{0:0.00}" />
                                                                                <asp:BoundField HeaderText="Amount Received" DataField="AmountReceived" Visible="false"
                                                                    DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource43" />
                                                                <asp:BoundField HeaderText="Due" DataField="Due" Visible="false" DataFormatString="{0:0.00}"
                                                                    meta:resourcekey="BoundFieldResource44" />
                                                                                <asp:BoundField HeaderText="Billed Amount" DataField="BillAmount" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource45" />
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
                                            <td class="a-right v-top" style="padding-left: 100px; padding-right: 300px;">
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalGross">
                                                    <asp:Label runat="server" ID="lblTotalGross" Style="padding-top: 10px; padding-bottom: 10px;
                                        padding-right: 10px;" Height="10px" Font-Bold="True"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalAdvance">
                                                    <asp:Label runat="server" ID="lblTotalAdvance" Style="padding-top: 10px; padding-bottom: 10px;
                                        padding-right: 10px;" Height="10px" Font-Bold="True"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalDiscount">
                                                    <asp:Label runat="server" ID="lblTotalDiscount" Style="padding-top: 10px; padding-bottom: 10px;
                                        padding-right: 10px;" Height="10px" Font-Bold="True"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalNet">
                                                    <asp:Label runat="server" ID="lblTotalNet" Style="padding-top: 10px; padding-bottom: 10px;
                                        padding-right: 10px;" Height="10px" Font-Bold="True"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalReceived">
                                                    <asp:Label runat="server" ID="lblTotalReceived" Style="padding-top: 10px; padding-bottom: 10px;
                                        padding-right: 10px;" Height="10px" Font-Bold="True"></asp:Label>
                                                </div>
                                              
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalRefund">
                                                    <asp:Label runat="server" ID="lblTotalRefund" Style="padding-top: 10px; padding-bottom: 10px;
                                        padding-right: 10px;" Height="10px" Font-Bold="True"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalBalance">
                                                    <asp:Label runat="server" ID="lblTotalBalance" Style="padding-top: 10px; padding-bottom: 10px;
                                        padding-right: 10px;" Height="10px" Font-Bold="True"></asp:Label>
                                                </div>
                                                
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalAmountInHand">
                                                    <asp:Label runat="server" ID="lblTotalAmountInHand" Style="padding-top: 10px; padding-bottom: 10px;
                                        padding-right: 10px;" Height="10px" Font-Bold="True"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divTotalDeposit">
                                                    <asp:Label runat="server" ID="lblTotalNetAmount" Style="padding-top: 10px; padding-bottom: 10px;
                                        padding-right: 10px;" Height="10px" Font-Bold="True"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divPharmacytotRefund">
                                                    <asp:Label runat="server" ID="lblPharmacytotRefund" Style="padding-top: 10px; padding-bottom: 10px;
                                        padding-right: 10px;" Height="10px" Font-Bold="True"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divCashDiscount">
                                                    <asp:Label runat="server" ID="lblCashDiscount" Style="padding-top: 10px; padding-bottom: 10px;
                                        padding-right: 10px;" Height="10px" Font-Bold="True"></asp:Label>
                                                </div>
                                                <div class="dataheaderWider" visible="false" runat="server" id="divCreditDiscount">
                                                    <asp:Label runat="server" ID="lblCreditDiscount" Style="padding-top: 10px;
                                        padding-bottom: 10px; padding-right: 10px;" Height="10px" Font-Bold="True"></asp:Label>
                                                </div>
                                                  <div class="dataheaderWider" visible="false" runat="server" id="divTotalDue">
                                                    <asp:Label runat="server" ID="lblTotalDue" Style="padding-top: 10px; padding-bottom: 10px;
                                        padding-right: 10px;" Height="10px" Font-Bold="True"></asp:Label>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
          <Attune:Attunefooter ID="Attunefooter" runat="server" />            
    </form>
<%--     <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

                        <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>

                        <script type="text/javascript">
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
