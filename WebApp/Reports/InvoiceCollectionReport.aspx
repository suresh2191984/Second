<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvoiceCollectionReport.aspx.cs"
    Inherits="Reports_InvoiceCollectionReport" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/IncomeFromOtherSource.ascx" TagName="IncomeFromOtherSource"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script language="javascript" type="text/javascript">

        function clearContextText() {
            $('#divOPDWCR').hide();

        }
        function alpha(e) {
            var k;
            document.all ? k = e.keyCode : k = e.which;
            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57));
        }

        function SelectedClientID(source, eventArgs) {
            document.getElementById('<%= hdnSelectedClientID.ClientID %>').value = eventArgs.get_value();
        }
        function ClearValue(obj) {
            if (document.getElementById(obj).value == "") {
                document.getElementById('<%= hdnSelectedClientID.ClientID %>').value = "0";
            }
        }
        function ClearFields() {

        }

        function validateToDate() {

            if (document.getElementById('<%= txtFDate.ClientID %>').value == '') {
                alert('Provide / select value for From date');
                document.getElementById('<%= txtFDate.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%= txtTDate.ClientID %>').value == '') {
                alert('Provide / select value for To date');
                document.getElementById('<%= txtTDate.ClientID %>').focus();
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

    <script runat="server">
        string _date;
        string GetDate(string Date)
        {
            if (Date != "01/01/1900")
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
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table id="tblCollectionOPIP" class="a-center w-100p">
            <tr class="a-center">
                <td class="a-left">
                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="dataheaderWider">
                                <table id="tbl">
                                    <tr id="trTrustedOrg" runat="server" style="display: table-row;">
                                        <td>
                                            <asp:Label ID="lblOrgs" runat="server" Text="Select organization" meta:resourcekey="lblOrgsResource1"></asp:Label>
                                            <asp:DropDownList ID="ddlTrustedOrg" AutoPostBack="true" onchange="javascript:clearContextText();"
                                                runat="server" CssClass="ddl" OnSelectedIndexChanged="ddlTrustedOrg_SelectedIndexChanged"
                                                meta:resourcekey="ddlTrustedOrgResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblLoc" Text="Location" runat="server" meta:resourcekey="lblLocResource1"></asp:Label>
                                            <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddl" meta:resourcekey="ddlLocationResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox CssClass="Txtboxsmall" Width="70px" ID="txtFDate" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox CssClass="Txtboxsmall" Width="70px" ID="txtTDate" runat="server" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblClient" Text="Client Name" runat="server" meta:resourcekey="lblClientResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtClient" onfocus="setContextClientValue();" OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"
                                                            onblur="javascript:ClearValue(this.id);ConverttoUpperCase(this.id);" autocomplete="off"
                                                            CssClass="Txtboxsmall" runat="server" Width="120px" meta:resourcekey="txtClientResource1"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClient" runat="server" TargetControlID="txtClient"
                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientList"
                                                            OnClientItemSelected="SelectedClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                            Enabled="True">
                                                        </ajc:AutoCompleteExtender>
                                                        <asp:HiddenField ID="hdnSelectedClientID" runat="server" Value="0" />
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                            OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                            ToolTip="Save As Excel" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:LinkButton ID="lnkBack" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                            OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1">Back&nbsp;&nbsp;</asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                <ProgressTemplate>
                                    <div id="progressBackgroundFilter" class="a-center">
                                    </div>
                                    <div id="processMessage" class="a-center w-20p">
                                        <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                            meta:resourcekey="img1Resource1" />
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <div id="divPrint" style="display: none;" runat="server">
                                <table class="w-100p">
                                    <tr>
                                        <td class="a-right paddingR10" style="color: #000000;">
                                            <b id="printText" runat="server">
                                                <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="divOPDWCR" runat="server" style="display: block;">
                                <div id="prnReport">
                                    <asp:Panel runat="server" ID="Panel1" Style="display: none;">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="w-50p" style="vertical-align: TOP;">
                                                    <table class="w-100p" style="padding: 10px;">
                                                        <thead class="h-15">
                                                            <th style="border: 2px solid;">
                                                                User Collection Amount
                                                            </th>
                                                        </thead>
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="gvOrgwiseGrandTotal" runat="server" AutoGenerateColumns="False"
                                                                    OnRowCommand="grdCollection_ItemCommand" ForeColor="#333333" CssClass="w-100p gridView mytable1"
                                                                    ShowFooter="true" meta:resourcekey="gvOrgwiseGrandTotalResource1">
                                                                    <Columns>
                                                                        <asp:BoundField DataField="RowNUM" HeaderText="SL.NO" meta:resourcekey="BoundFieldResource9">
                                                                        </asp:BoundField>
                                                                        <%--     <asp:BoundField DataField="UserName" HeaderText="ReceivedBy" meta:resourcekey="BoundFieldResource9">
                                                                        </asp:BoundField>
                                                                        --%>
                                                                        <asp:TemplateField HeaderText="ReceivedBy">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%#Eval("ClientID")%>'
                                                                                    Text='<%#Eval("UserName")%>' CommandName="User">
                                                                                </asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="ReceivedAmount" HeaderText="Amount" meta:resourcekey="BoundFieldResource8">
                                                                        </asp:BoundField>
                                                                        <%--   <FooterTemplate>
                                                                                         <asp:Label ID="lblTotal" runat="server" />
                                                                                         </FooterTemplate>--%>
                                                                    </Columns>
                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table class="w-100p" style="padding: 10px;">
                                                        <thead class="h-15">
                                                            <th style="border: 2px solid;">
                                                                Client Collection Amount
                                                            </th>
                                                        </thead>
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="gvPCAmount" runat="server" AutoGenerateColumns="False" ForeColor="#333333"
                                                                    CssClass="w-100p gridView mytable1" OnRowCommand="grdCollection_ItemCommand"
                                                                    ShowFooter="true" meta:resourcekey="gvOrgwiseGrandTotalResource1">
                                                                    <Columns>
                                                                        <asp:BoundField DataField="RowNUM" HeaderText="SL.NO" meta:resourcekey="BoundFieldResource9">
                                                                        </asp:BoundField>
                                                                        <asp:TemplateField HeaderText="PaymentMode">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%#Eval("PaymentType")%>'
                                                                                    Text='<%#Eval("UserName")%>' CommandName="PaymentType">
                                                                                </asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="ReceivedAmount" HeaderText="Amount" meta:resourcekey="BoundFieldResource8">
                                                                        </asp:BoundField>
                                                                    </Columns>
                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="w-50p" style="vertical-align: TOP;">
                                                    <table class="w-100p" style="padding: 10px;">
                                                        <thead class="h-15">
                                                            <th style="border: 2px solid;">
                                                                User Collection Amount
                                                            </th>
                                                        </thead>
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="gvCCamount" runat="server" AutoGenerateColumns="False" ForeColor="#333333"
                                                                    OnRowCommand="grdCollection_ItemCommand" CssClass="w-100p gridView mytable1"
                                                                    ShowFooter="true" meta:resourcekey="gvOrgwiseGrandTotalResource1">
                                                                    <Columns>
                                                                        <asp:BoundField DataField="RowNUM" HeaderText="SL.NO" meta:resourcekey="BoundFieldResource9">
                                                                        </asp:BoundField>
                                                                        <%--                                                                        <asp:BoundField DataField="ClientName" HeaderText="ClientName" meta:resourcekey="BoundFieldResource9">
                                                                        </asp:BoundField>--%>
                                                                        <asp:TemplateField HeaderText="ClientName">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="LinkButton2" runat="server" CommandArgument='<%#Eval("ClientID")%>'
                                                                                    Text='<%#Eval("ClientName")%>' CommandName="Client">
                                                                                </asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="ReceivedAmount" HeaderText="Amount" meta:resourcekey="BoundFieldResource8">
                                                                        </asp:BoundField>
                                                                        <%--   <FooterTemplate>
                                                                                         <asp:Label ID="lblTotal" runat="server" />
                                                                                         </FooterTemplate>--%>
                                                                    </Columns>
                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table class="w-100p" style="padding: 10px;">
                                                        <thead class="h-15">
                                                            <th style="border: 2px solid;">
                                                                User Collection Amount
                                                            </th>
                                                        </thead>
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="gvDTSDWR" runat="server" AutoGenerateColumns="False" ForeColor="#333333"
                                                                    OnRowCommand="grdCollection_ItemCommand" CssClass="w-100p gridView mytable1"
                                                                    ShowFooter="true" meta:resourcekey="gvOrgwiseGrandTotalResource1">
                                                                    <Columns>
                                                                        <asp:BoundField DataField="RowNUM" HeaderText="SL.NO" meta:resourcekey="BoundFieldResource9">
                                                                        </asp:BoundField>
                                                                        <%--                                                                        <asp:BoundField DataField="PaymentType" HeaderText="Type" meta:resourcekey="BoundFieldResource9">
                                                                        </asp:BoundField>--%>
                                                                        <asp:TemplateField HeaderText="Type">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="LinkButton3" runat="server" CommandArgument='<%#Eval("RowNUM")%>'
                                                                                    Text='<%#Eval("PaymentType")%>' CommandName="Type">
                                                                                </asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="ReceivedAmount" HeaderText="Amount" meta:resourcekey="BoundFieldResource8">
                                                                        </asp:BoundField>
                                                                        <%--   <FooterTemplate>
                                                                                         <asp:Label ID="lblTotal" runat="server" />
                                                                                         </FooterTemplate>--%>
                                                                    </Columns>
                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <table class="w-30p" style="float: right; font-weight: bold; font-size: 12px; padding: 10px;">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="ll" runat="server" Text="Total Collected Amount">   </asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblTotalCollectedAmt" runat="server" Text="">   </asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="llll" runat="server" Text="Discount Amount">   </asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblDiscountAmount" runat="server" Text="">   </asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label4" runat="server" Text="TDS Amount">   </asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblTDS" runat="server" Text="Total Collected Amount">   </asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label6" runat="server" Text="Write off Amount">   </asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblWriteOFF" runat="server" Text="Write off Amount">   </asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label8" runat="server" Text="Credit">   </asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblCredit" runat="server" Text="Credit">   </asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label10" runat="server" Text="Total Pending Amount">   </asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblTotalPendingAMount" runat="server" Text="Total Pending Amount">   </asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel ID="pnlDetailedReport" runat="server" Style="display: none;">
                                        <input type="button" id="btnToogle" class="btn" value="Back" onclick="SetToogle();" />
                                        <asp:GridView ID="grdDetailedReport" runat="server" AutoGenerateColumns="False" ForeColor="#333333"
                                            CssClass="w-100p gridView mytable1" ShowFooter="true" meta:resourcekey="gvOrgwiseGrandTotalResource1">
                                            <Columns>
                                                <asp:BoundField DataField="RowNUM" HeaderText="SL.NO" meta:resourcekey="BoundFieldResource9">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="PaymentCollectionDate" HeaderText="Payment Collected Date"
                                                    meta:resourcekey="BoundFieldResource9"></asp:BoundField>
                                                <asp:BoundField DataField="UserName" HeaderText="User Name" meta:resourcekey="BoundFieldResource9">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="InvoiceDate" HeaderText="Invoice Date" meta:resourcekey="BoundFieldResource9">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ReferredBy" HeaderText="Invoice Cycle" meta:resourcekey="BoundFieldResource9">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="InvoiceNumber" HeaderText="Invoice No" meta:resourcekey="BoundFieldResource9">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ClientName" HeaderText="Client Name" meta:resourcekey="BoundFieldResource9">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="InvoiceAmount" HeaderText="Invoice Amount" meta:resourcekey="BoundFieldResource9">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Discount" HeaderText="Discount" meta:resourcekey="BoundFieldResource8">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="TDS" HeaderText="TDS" meta:resourcekey="BoundFieldResource8">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="WriteOffAmount" HeaderText="Write Off" meta:resourcekey="BoundFieldResource8">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ReceivedAmount" HeaderText="ReceivedAmount" meta:resourcekey="BoundFieldResource8">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="PaymentType" HeaderText="Payment Details" meta:resourcekey="BoundFieldResource8">
                                                </asp:BoundField>
                                                 <asp:BoundField DataField="PaymentDetails" HeaderText="Payment Details" meta:resourcekey="BoundFieldResource8">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="PendingAmount" HeaderText="Pending Amount" meta:resourcekey="BoundFieldResource8">
                                                </asp:BoundField>
                                            </Columns>
                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                        </asp:GridView>
                                        <table class="w-50p" style="float: right; font-weight: bold; font-size: 12px; padding: 10px;">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lll" runat="server" Text="Total Collected Amount">   </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTotalCollectedAmt1" runat="server" Text="">   </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label1" runat="server" Text="Discount Amount">   </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblDiscountAmount1" runat="server" Text="">   </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label11" runat="server" Text="TDS Amount">   </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTDS1" runat="server" Text="Total Collected Amount">   </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label12" runat="server" Text="Write off Amount">   </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblWriteOFF1" runat="server" Text="Write off Amount">   </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label13" runat="server" Text="Credit">   </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCredit1" runat="server" Text="Credit">   </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label14" runat="server" Text="Total Pending Amount">   </asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTotalPendingAMount1" runat="server" Text="Total Pending Amount">   </asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        
                                        <div runat="server">
                                            <%--<asp:HiddenField ID="hdnFDate" runat="server" />--%>
                                            <input type="hidden" id="hdnFDate" runat="server" />
                                            <input type="hidden" id="hdnTdate" runat="server" />
                                            <input type="hidden" id="hdnOrgID" runat="server" />
                                            <input type="hidden" id="hdnAdressID" runat="server" />
                                            <input type="hidden" id="hdnClientID" runat="server" />
                                    
                                        </div>
                                    </asp:Panel>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="imgBtnXL" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>

<script type="text/javascript">
    /* $(function() {
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
    });*/
    $(function() {
        setDatePicker();
    });

    function setDatePicker() {
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
        });
    }

    var prm = Sys.WebForms.PageRequestManager.getInstance();
    if (prm != null) {
        prm.add_endRequest(function(sender, e) {
            if (sender._postBackSettings.panelID != null) {
                setDatePicker();
            }
        });
    }
</script>

<script language="javascript" type="text/javascript">

    function setContextClientValue() {
        var sval = "0^" + document.getElementById('<%= ddlTrustedOrg.ClientID %>').value;
        $find('<%= AutoCompleteExtenderClient.ClientID %>').set_contextKey(sval);
        return false;
    }
    function SetContextValue() {
        var rec = document.getElementById('hdnReferringHospitalID').value;
        var sval = document.getElementById('<%= ddlTrustedOrg.ClientID %>').value;
        return false;
    }

    function SetToogle() {
        //  $('#pnlDetailedReport').hide();
        $("#pnlDetailedReport").css("display", "none");
        $('#Panel1').css("display", "block");
    }
</script>

