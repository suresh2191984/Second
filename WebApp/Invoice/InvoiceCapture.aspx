<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvoiceCapture.aspx.cs" Inherits="Invoice_InvoiceCapture"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <script src="../Scripts/jquery-1.10.2.min.js" type="text/javascript"></script>

    <script src="../Scripts/InvoiceCapture.js" type="text/javascript"></script>
<head id="Head1" runat="server">
    <title>
        <%--Invoice Capture--%><%=Resources.Invoice_ClientDisplay.Invoice_InvoiceCapture_aspx_001%>
    </title>
    <style type="text/css">
        #tableArea
        {
            height: 250px;
            overflow-y: auto;
        }
        .divArea
        {
            width: 90%;
            <%--height: 110px;--%>
            border: 2px solid black;
            margin: auto;
            background: white;
            border-radius: 10px 10px 10px 10px;
        }
        .txtDisabled
        {
            font-weight: 700;
        }
        .trrow
        {
            background-color: White;
        }
        .toodle
        {
            font-size: x-large;
            font-weight: bold;
        }
        .mytable1 td, .mytable1 th
        {
            border: 1px solid #686868;
            border-bottom: 1px solid #686868;
        }
        .searchBox
        {
            font-family: Arial, Helvetica, sans-serif;
            text-align: left;
            height: 15px;
            width: 150px;
            border: 1px solid #999999;
            font-size: 11px;
            margin-left: 0px;
            background-image: url('../Images/magnifying-glass.png');
            background-repeat: no-repeat;
            padding-left: 20px;
            background-color: #F3E2A9;
        }
        .mediumList
        {
            min-width: 330px;
        }
        .bigList
        {
            min-width: 800px;
        }
        .listMain
        {
            min-height: 0px;
        }
        h1, h2, h3, h4, h5, h6
        {
            margin: 10px 0;
            font-family: inherit;
            font-weight: bold;
            line-height: 1;
            color: inherit;
            text-rendering: optimizelegibility;
        }
        h1 small, h2 small, h3 small, h4 small, h5 small, h6 small
        {
            font-weight: normal;
            line-height: 1;
            color: #999999;
        }
        h1
        {
            font-size: 36px;
            line-height: 40px;
        }
        h2
        {
            font-size: 30px;
            line-height: 40px;
        }
        h3
        {
            font-size: 24px;
            line-height: 40px;
        }
        h4
        {
            font-size: 18px;
            line-height: 20px;
        }
        h5
        {
            font-size: 14px;
            line-height: 20px;
        }
        h6
        {
            font-size: 12px;
            line-height: 20px;
        }
        h1 small
        {
            font-size: 24px;
        }
        h2 small
        {
            font-size: 18px;
        }
        h3 small
        {
            font-size: 14px;
        }
        h4 small
        {
            font-size: 14px;
        }
        .close
        {
            float: right;
            font-size: 20px;
            font-weight: bold;
            line-height: 20px;
            color: #000000;
            text-shadow: 0 1px 0 #ffffff;
            opacity: 0.2;
            filter: alpha(opacity=20);
        }
        .close:hover
        {
            color: #000000;
            text-decoration: none;
            cursor: pointer;
            opacity: 0.4;
            filter: alpha(opacity=40);
        }
        button.close
        {
            padding: 0;
            cursor: pointer;
            background: transparent;
            border: 0;
            -webkit-appearance: none;
        }
        .modal-backdrop
        {
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            z-index: 1040;
            background-color: #000000;
        }
        .modal-backdrop.fade
        {
            opacity: 0;
        }
        .modal-backdrop, .modal-backdrop.fade.in
        {
            opacity: 0.8;
            filter: alpha(opacity=80);
        }
        .modal
        {
            font-family: "Helvetica Neue" , Helvetica, Arial, sans-serif;
            font-size: 14px;
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            z-index: 1050;
            margin: -250px 0 0 -280px;
            overflow: auto;
            color: #333333;
            padding: 3px;
            background-color: #e0ebf5;
            border: 1px solid #999;
            border: 1px solid rgba(0, 0, 0, 0.3); *border:1pxsolid#999;-webkit-border-radius:6px;-moz-border-radius:6px;border-radius:6px;-webkit-box-shadow:03px7pxrgba(0, 0, 0, 0.3);-moz-box-shadow:03px7pxrgba(0, 0, 0, 0.3);box-shadow:03px7pxrgba(0, 0, 0, 0.3);-webkit-background-clip:padding-box;-moz-background-clip:padding-box;background-clip:padding-box;}
        .modal-header
        {
            padding: 9px 15px;
            border-bottom: 1px solid #eee;
        }
        .modal-header .close
        {
            margin-top: 2px;
        }
        .modal-header h3
        {
            margin: 0;
            line-height: 30px;
        }
        .modal-body
        {
            max-height: 400px;
            padding: 15px;
            overflow-y: auto;
        }
        .modal-form
        {
            margin-bottom: 0;
        }
        .modal-footer
        {
            padding: 14px 15px 15px;
            margin-bottom: 0;
            text-align: right;
            background-color: #e0ebf5;
            color: #333333;
            border-top: 1px solid #ddd;
            -webkit-border-radius: 0 0 6px 6px;
            -moz-border-radius: 0 0 6px 6px;
            border-radius: 0 0 6px 6px; *zoom:1;-webkit-box-shadow:inset01px0#ffffff;-moz-box-shadow:inset01px0#ffffff;box-shadow:inset01px0#ffffff;}
        .modal-footer:before, .modal-footer:after
        {
            display: table;
            line-height: 0;
            content: "";
        }
        .modal-footer:after
        {
            clear: both;
        }
        .modal-footer .btn + .btn
        {
            margin-bottom: 0;
            margin-left: 5px;
        }
        .modal-footer .btn-group .btn + .btn
        {
            margin-left: -1px;
        }
        fieldset
        {
            border: 1px solid green;
            padding: 5px;
            text-align: left;
        }
        legend
        {
            margin-bottom: 0px;
            margin-left: 5px;
            padding: 1px;
            font-size: 12px;
            font-weight: bold;
            color: White;
            text-align: right;
            background-color: #2C88B1;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <input type="hidden" runat="server" id="hdnResultInvoice" value="N" />
    <input type="hidden" runat="server" id="hdnSubtable" value="N" />
    <input type="hidden" runat="server" id="hdnClientID" value="" />
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="up1" runat="server">
            <ContentTemplate>
                <table class="w-100p">
                    <tr>
                        <td>
                            <div class="dataheader3" style="display: block; overflow: auto; width: 1357px;">
                                <asp:GridView ID="grdInvoicePayments" runat="server" CellPadding="1" CssClass="mytable1 gridView"
                                    AutoGenerateColumns="False" OnRowDataBound="grdInvoicePayments_RowDataBound"
                                    Width="1200px" Style="display: none;" meta:resourcekey="grdInvoicePaymentsResource1">
                                    <Columns>
                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkBox" runat="server" Checked="True" Enabled="False" meta:resourcekey="chkBoxResource1" />
                                                <asp:HiddenField ID="hdnComments" Value='<%# DataBinder.Eval(Container.DataItem,"Comments") %>'
                                                    runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action" HeaderStyle-VerticalAlign="Top" meta:resourcekey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <img alt="" src="../Images/view_button.gif" id="showmenu" style="cursor: pointer;" />
                                            </ItemTemplate>
                                            <HeaderStyle VerticalAlign="Top"></HeaderStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Invoice ID" HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center"
                                            Visible="false" meta:resourcekey="TemplateFieldResource3">
                                            <ItemTemplate>
                                                <asp:Label ID="lblInvoiceID" runat="server" Text='<%# Bind("InvoiceID") %>' meta:resourcekey="lblInvoiceIDResource1"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top"></HeaderStyle>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="InvoiceNumber" HeaderStyle-VerticalAlign="Top" HeaderText="Invoice No"
                                            HeaderStyle-HorizontalAlign="Center" meta:resourcekey="BoundFieldResource1">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top"></HeaderStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ApproverRemarks" HeaderStyle-VerticalAlign="Top" HeaderText="Client Name"
                                            ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Center" meta:resourcekey="BoundFieldResource2">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top"></HeaderStyle>
                                            <ItemStyle Width="200px"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Date" HeaderStyle-VerticalAlign="Top" SortExpression="Date"
                                            meta:resourcekey="TemplateFieldResource4">
                                            <ItemTemplate>
                                                <%# (string)DataBinder.Eval(Container.DataItem, "CreatedAt", "{0:dd/MM/yyyy}")%>
                                                </a>
                                            </ItemTemplate>
                                            <HeaderStyle VerticalAlign="Top"></HeaderStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Gross Amount" HeaderStyle-Width="70px" HeaderStyle-Wrap="true"
                                            HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource5">
                                            <ItemTemplate>
                                                <asp:Label ID="lblInvoiceGAmt" runat="server" Text='<%# Bind("GrossValue") %>' meta:resourcekey="lblInvoiceGAmtResource1"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Wrap="True" Width="70px">
                                            </HeaderStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Net Amount" HeaderStyle-Width="70px" HeaderStyle-Wrap="true"
                                            HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource6">
                                            <ItemTemplate>
                                                <asp:Label ID="lblInvoiceAmt" runat="server" Text='<%# Bind("NetValue") %>' meta:resourcekey="lblInvoiceAmtResource1"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Wrap="True" Width="70px">
                                            </HeaderStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="RoundOff Total" HeaderStyle-VerticalAlign="Top" HeaderStyle-Width="70px"
                                            HeaderStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource7">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRoundOffTotal" runat="server" meta:resourcekey="lblRoundOffTotalResource1"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Width="30px"></HeaderStyle>
                                            <ItemStyle Width="30px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Round Off" HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center"
                                            meta:resourcekey="TemplateFieldResource8">
                                            <ItemTemplate>
                                                <asp:TextBox ID="lblRoundOff"      onkeypress="return ValidateOnlyNumeric(this);"    runat="server"
                                                    Width="40px" Enabled="False" CssClass="Txtboxmedium" meta:resourcekey="lblRoundOffResource1"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top"></HeaderStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Received Amount" HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center"
                                            HeaderStyle-Width="40px" HeaderStyle-Wrap="true" meta:resourcekey="TemplateFieldResource9">
                                            <ItemTemplate>
                                                <asp:Label ID="lblReceivedAmt" runat="server" Text='<%# Bind("ReceivedAmt") %>' meta:resourcekey="lblReceivedAmtResource1"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Wrap="True" Width="40px">
                                            </HeaderStyle>
                                            <ItemStyle Width="40px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Due" HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center"
                                            HeaderStyle-Width="40px" HeaderStyle-Wrap="true" meta:resourcekey="TemplateFieldResource10">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDuedAmt" runat="server" Text='<%# Bind("DueAmount") %>' meta:resourcekey="lblDuedAmtResource1"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Wrap="True" Width="30px">
                                            </HeaderStyle>
                                            <ItemStyle Width="30px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Receiving Amount" HeaderStyle-VerticalAlign="Top"
                                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px" HeaderStyle-Wrap="true"
                                            meta:resourcekey="TemplateFieldResource11">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtReceiveAmt"      onkeypress="return ValidateOnlyNumeric(this);"    runat="server"
                                                    Width="60px" CssClass="Txtboxmedium" meta:resourcekey="txtReceiveAmtResource1"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Wrap="True" Width="50px">
                                            </HeaderStyle>
                                            <ItemStyle Width="30px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Write Off" HeaderStyle-VerticalAlign="Top" HeaderStyle-Width="15px"
                                            HeaderStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource12">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkWOff" runat="server" meta:resourcekey="chkWOffResource1" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Width="15px"></HeaderStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Reason" HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center"
                                            meta:resourcekey="TemplateFieldResource13">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlReason" Enabled="False" runat="server" CssClass="drpsmall"
                                                    Width="130px" meta:resourcekey="ddlReasonResource1">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top"></HeaderStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Payment Type" HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center"
                                            meta:resourcekey="TemplateFieldResource14">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlPayMentType" runat="server" CssClass="drpsmall" meta:resourcekey="ddlPayMentTypeResource1">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top"></HeaderStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bank Name" HeaderStyle-VerticalAlign="Top" HeaderStyle-Wrap="true"
                                            HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource15">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtBankName" runat="server" Width="70px" CssClass="Txtboxmedium"
                                                    meta:resourcekey="txtBankNameResource1"></asp:TextBox>
                                                <Ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtBankName"
                                                    EnableCaching="False" FirstRowSelected="True" MinimumPrefixLength="2" CompletionListCssClass="listtwo"
                                                    CompletionListItemCssClass="listitemtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                                    ServiceMethod="GetBankName" ServicePath="~/InventoryWebService.asmx" DelimiterCharacters=""
                                                    Enabled="True">
                                                </Ajc:AutoCompleteExtender>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Wrap="True" Width="70px">
                                            </HeaderStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cheque/ Card No." HeaderStyle-VerticalAlign="Top"
                                            HeaderStyle-Width="60px" HeaderStyle-Wrap="true" HeaderStyle-HorizontalAlign="Center"
                                            meta:resourcekey="TemplateFieldResource16">
                                            <ItemTemplate>
                                                <asp:TextBox ID="lblChqorCardNo" runat="server" Width="60px" CssClass="Txtboxmedium"
                                                    meta:resourcekey="lblChqorCardNoResource1"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Wrap="True" Width="60px">
                                            </HeaderStyle>
                                            <ItemStyle Width="60px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status" HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center"
                                            meta:resourcekey="TemplateFieldResource17">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="drpsmall" Width="80px"
                                                    meta:resourcekey="ddlStatusResource1">
                                                 <%--  <asp:ListItem Text="Pending" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                    <asp:ListItem Text="Completed" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>--%>
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <ControlStyle />
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top"></HeaderStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Total Amount" HeaderStyle-HorizontalAlign="Center"
                                            Visible="false" meta:resourcekey="TemplateFieldResource18">
                                            <ItemTemplate>
                                                <asp:Label ID="lblWriteOffAmt" runat="server" Text='<%# Bind("WriteOffAmt") %>' meta:resourcekey="lblWriteOffAmtResource1"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center">
                            <asp:Button ID="btnSave" runat="server" Text="Save" Style="display: none;" class="btn"
                                OnClick="btnSave_Click" OnClientClick="javascript:return checkItems();" meta:resourcekey="btnSaveResource1" />
                            <%--<asp:Button ID="btnBack" runat="server" Text="Back" class="btn" OnClick="btnBack_Click"
                                meta:resourcekey="btnBackResource1" />--%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="printcontent" runat="server" style="display: none;">
                                <table width="100%" border="1" align="center" id="tblBillPrint" runat="server">
                                    <tr>
                                        <td>
                                            <table width="100%" border="0" cellspacing="0" style="font-family: Verdana; font-size: 10px;"
                                                cellpadding="0" align="center" id="tbl1" runat="server">
                                                <tr>
                                                    <td align="center">
                                                        <asp:Image ID="imgBillLogo" runat="server" Visible="False" meta:resourcekey="imgBillLogoResource1" />
                                                    </td>
                                                    <td colspan="8" style="padding-left: 100px;" align="center">
                                                        <label id="lblHospitalName" runat="server">
                                                        </label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="9" align="center">
                                                        <br />
                                                        <span style="text-decoration: underline;">
                                                            <asp:Label ID="lbpaymentvoucher" runat="server" Text="Invoice  Receipt" meta:resourcekey="lbpaymentvoucherResource1"></asp:Label>
                                                        </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="9">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" class="style5">
                                                        <asp:Label ID="Rs_InvoiceNumber" runat="server" Text="Invoice Number" meta:resourcekey="lbforResource1"
                                                            Font-Bold="True"></asp:Label>
                                                    </td>
                                                    <td class="style5">
                                                        &nbsp; :
                                                        <asp:Label ID="lblInvoiceNumber" runat="server" meta:resourcekey="lbInvoiceNumber"></asp:Label>
                                                    </td>
                                                    <td class="style5">
                                                    </td>
                                                    <td class="style5">
                                                        &nbsp;
                                                    </td>
                                                    <td class="style5">
                                                        &nbsp;
                                                    </td>
                                                    <td class="style5">
                                                        &nbsp;
                                                    </td>
                                                    <td nowrap="nowrap" align="right" class="style5">
                                                        <label style="font-weight: 700">
                                                            <asp:Label ID="Rs_InvoiceDate" runat="server" Text="Invoice Date" meta:resourcekey="lbprintdateResource1"></asp:Label>
                                                        </label>
                                                    </td>
                                                    <td nowrap="nowrap" align="right" class="style5">
                                                        <label>
                                                            :</label>
                                                    </td>
                                                    <td nowrap="nowrap" align="left" class="style5">
                                                        <asp:Label ID="lblInvoiceDate" runat="server" meta:resourcekey="lblInvoiceDateResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td nowrap="nowrap" align="right">
                                                        &nbsp;
                                                    </td>
                                                    <td nowrap="nowrap" align="right">
                                                        &nbsp;
                                                    </td>
                                                    <td nowrap="nowrap" align="right">
                                                        &nbsp;
                                                    </td>
                                                    <td nowrap="nowrap" align="right">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" nowrap="nowrap">
                                                        <asp:Label ID="Rs_ClientName" runat="server" Text="Client Name" Font-Bold="True"
                                                            meta:resourcekey="Rs_ClientNameResource1"></asp:Label>
                                                    </td>
                                                    <td class="style2">
                                                        &nbsp; :
                                                        <asp:Label ID="lblClientName" runat="server" meta:resourcekey="lblClientNameResource1"></asp:Label>
                                                    </td>
                                                    <td class="style2">
                                                        &nbsp;
                                                    </td>
                                                    <td class="style2">
                                                        &nbsp;
                                                    </td>
                                                    <td class="style2">
                                                        &nbsp;
                                                    </td>
                                                    <td class="style2">
                                                    </td>
                                                    <td nowrap="nowrap" align="right" class="style4">
                                                        <asp:Label Style="font-weight: 700" ID="Rs_PaidDate" runat="server" Text="Paid Date"
                                                            meta:resourcekey="Rs_PaidDateResource1"></asp:Label>
                                                    </td>
                                                    <td nowrap="nowrap" align="right" class="style2">
                                                        :
                                                    </td>
                                                    <td nowrap="nowrap" align="Left" class="style2">
                                                        <asp:Label ID="lblPaidDate" runat="server" meta:resourcekey="lblPaidDateResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td nowrap="nowrap" align="right">
                                                        &nbsp;
                                                    </td>
                                                    <td nowrap="nowrap" align="right">
                                                        &nbsp;
                                                    </td>
                                                    <td nowrap="nowrap" align="right">
                                                        &nbsp;
                                                    </td>
                                                    <td nowrap="nowrap" align="right">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" class="style5">
                                                        <asp:Label ID="Rs_ReceiptNumber" runat="server" Text="Receipt Number" Font-Bold="True"
                                                            meta:resourcekey="Rs_ReceiptNumberResource1"></asp:Label>
                                                    </td>
                                                    <td class="style5">
                                                        &nbsp; :
                                                        <asp:Label ID="lblReceiptNumber" runat="server" meta:resourcekey="lblReceiptNumberResource1"></asp:Label>
                                                    </td>
                                                    <td class="style5">
                                                    </td>
                                                    <td class="style5">
                                                        &nbsp;
                                                    </td>
                                                    <td class="style5">
                                                        &nbsp;
                                                    </td>
                                                    <td class="style5">
                                                        &nbsp;
                                                    </td>
                                                    <td nowrap="nowrap" align="right" class="style5">
                                                        <label style="font-weight: 700">
                                                            <asp:Label ID="Rs_PrintDate" runat="server" Text="Print Date" meta:resourcekey="Rs_PrintDateResource1"></asp:Label>
                                                        </label>
                                                    </td>
                                                    <td nowrap="nowrap" align="right" class="style5">
                                                        <label>
                                                            :</label>
                                                    </td>
                                                    <td nowrap="nowrap" align="left" class="style5">
                                                        <asp:Label ID="lblPrintDate" runat="server" meta:resourcekey="lblPrintDateResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="9">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="9" style="text-decoration: none;">
                                                        <asp:Label ID="lbpaymentdet" runat="server" Text="Payment Details" meta:resourcekey="lbpaymentdetResource1"></asp:Label>
                                                        :
                                                        <br />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="9" class="style3">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="9">
                                                        <div id="dvDetails" runat="server">
                                                            <asp:GridView ID="gvReceipt" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                Style="font-family: Verdana; font-size: 10px;" BorderStyle="Solid" BorderColor="#B6A8A8"
                                                                BorderWidth="1px" meta:resourcekey="gvReceiptResource1">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="S.No" ItemStyle-Width="4%" meta:resourcekey="TemplateFieldResource19">
                                                                        <ItemTemplate>
                                                                            <%# Container.DataItemIndex + 1 %>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="4%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Payment Mode" meta:resourcekey="TemplateFieldResource20">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblPaymentMode" Text='<%# Bind("paymentName") %>' runat="server" meta:resourcekey="lblPaymentModeResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Card/Cheque No" meta:resourcekey="TemplateFieldResource21">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblChequeNo" Text='<%# Bind("ChequeorCardNumber") %>' runat="server"
                                                                                meta:resourcekey="lblChequeNoResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Bank/Card Name" meta:resourcekey="TemplateFieldResource22">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblBankName" Text='<%# Bind("bankNameorCardType") %>' runat="server"
                                                                                meta:resourcekey="lblBankNameResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Amount" meta:resourcekey="TemplateFieldResource23">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAmount" Text='<%# Bind("AmtReceived") %>' runat="server" meta:resourcekey="lblAmountResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <HeaderStyle Font-Bold="True" ForeColor="Black" />
                                                            </asp:GridView>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="style2" colspan="9">
                                                        &nbsp;&nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="style2" colspan="9" align="right">
                                                        <asp:Label ID="lbtot" runat="server" Text="Total" Font-Bold="True" meta:resourcekey="lbtotResource1"></asp:Label>
                                                        :
                                                        <asp:Label ID="lblGrandTotal" runat="server" meta:resourcekey="lblGrandTotalResource1" />
                                                        /-
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="style2" colspan="9" align="right">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="9" class="style2">
                                                        &nbsp;
                                                        <asp:Label ID="lblrecivAmountinWords" runat="server" Text="The Sum of " meta:resourcekey="lblrecivAmountinWordsResource1"></asp:Label>
                                                        <asp:Label ID="lblrecivAmount" runat="server" meta:resourcekey="lblrecivAmountResource1" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td style="text-align: right;">
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td colspan="4">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;
                                                    </td>
                                                    <td align="center">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td align="left">
                                                    </td>
                                                    <td align="left">
                                                    </td>
                                                    <td colspan="4" align="center">
                                                    </td>
                                                    <td align="center">
                                                    </td>
                                                    <td align="center">
                                                        <asp:Label Font-Bold="True" ID="lbl_bill" Text="RECEIVER NAME" runat="server" meta:resourcekey="lbl_billResource1"></asp:Label><br />
                                                        <asp:Label ID="lbl_Billedoutput" runat="server" Style="font-weight: 700" meta:resourcekey="lbl_BilledoutputResource1" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td style="text-align: right;">
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td colspan="4">
                                                        &nbsp; &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="9">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td colspan="4">
                                                        &nbsp;
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
                <asp:Panel ID="pnlOthers" runat="server" Style="display: none; width: 500px" meta:resourcekey="pnlOthersResource1">
                    <center>
                        <div id="divOthers" class="modal" style="width: 500px; height: 180px; padding-top: 50px;
                            padding-left: 15px">
                            <table class="w-90p a-center">
                                <tr class="a-left">
                                    <td>
                                        <table id="tblDiagnosisItems" class="dataheaderInvCtrl" runat="server" cellpadding="4"
                                            cellspacing="0" border="1">
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-center">
                                        <button id="btnpopClose" onclick="javascript:return closePopup();" class="btn" runat="server"
                                             > <%=Resources.Invoice_ClientDisplay.Invoice_InvoiceCapture_aspx_101%>
                                        </button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </center>
                </asp:Panel>
         </ContentTemplate>
        </asp:UpdatePanel>
         
                <div id="ClientLedMain">
                    <div id="ClientLedHeader" style="height: 40px;">
                        <span id="lbl" style="margin-left: 40%; border: 2px solid; width: 20%; background-color: #335b74;
                            height: 45%;">
                            <p style="margin-left: 35%; font-weight: bolder; color: white; /* background-color: aqua;
                                */">
                                Client Ledger</p>
                        </span>
                    </div>
                    <table id="MainContent" style="width: 90%;height: 60px;    margin: auto;">
                        <tbody>
                            <tr>
                                <td style="width: 150px; ">
                                    Pending Outstanding
                                </td>
                                <td>
                                    <input id="txtpendOut" type="text" class="txtDisabled">
                                </td>
                                <td style="width: 50px;">
                                </td>
                                <td style="width: 150px;">
                                    Total Invoice Amount
                                </td>
                                <td>
                                    <input id="txttlInv" type="text" class="txtDisabled">
                                </td>
                                <td style="width: 56px;">
                                </td>
                                <td style="width: 120px;">
                                    Amount Received
                                </td>
                                <td>
                                    <input id="txtAmuRec" type="text" class="txtDisabled">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div id="tableArea" >
                    </div>
                </div>
                <br /><br />
                <div id="Calculatebtn" >
                    <%--<input id="btnCalculate" type="button" onclick="javascript:return CalculationArea();"
                        value="Calculate" class="btn" style="
    margin-left: 45%;
"> </input><asp:Button ID="btnBack" runat="server" Text="Back" class="btn" OnClick="btnBack_Click"
                                meta:resourcekey="btnBackResource1" />--%>
                </div>
                <br />
                <br />
                <div id="tblAreaIn" runat="server" class="divArea" style="height:130px;>
               
                    <table id="tblInvoiceAmountArea" style="width: 90%; margin: auto;">
                        <tbody>
                            <tr>
                                <td style="width: 150px;">
                                    Total Invoice Amount
                                </td>
                                <td>
                                    <input id="txtTotalInAmt" type="text" class="txtDisabled">
                                </td>
                                <td style="width: 50px;">
                                </td>
                                <td style="width: 150px;">
                                    Received Amount
                                </td>
                                <td>
                                    <input id="txtReceivedAmt" type="text" onkeyup="SetOutstating(this)" class="txtDisabled">
                                </td>
                                <td style="width: 56px;">
                                </td>
                                <td style="width: 120px;">
                                    Knoff Amount
                                </td>
                                <td>
                                    <input id="txtknoff" type="text" class="txtDisabled">
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 150px;">
                                    Write Off Amount
                                </td>
                                <td>
                                    <input id="txtwrite" type="text" class="txtDisabled">
                                </td>
                                <td style="width: 50px;">
                                </td>
                                <td style="width: 150px;">
                                    Discount Amount
                                </td>
                                <td>
                                    <input id="txtDiscountAmount" type="text" onblur="SplitAmounttoDiscount()">
                                    <asp:HiddenField ID="hdntxtDiscountamount" runat="server" Value="0"  />
                                </td>
                                <td style="width: 56px;">
                                </td>
                                <td style="width: 120px;">
                                    TDS
                                </td>
                                <td>
                                    <input id="txtTDSAmount" type="text" onblur="SplitAmounttoTDS()" >
                                    <asp:HiddenField ID="hdntxtTDSAmount" runat="server" Value="0" />

                                </td>
                            </tr>
                            <td style="width: 150px;">
                                    Credit Amount
                                </td>
                                <td>
                                    <input id="txtCredit" type="text">
                                </td>
                                <td style="width: 56px;">
                                </td>
                                <td style="width: 120px;">
                                    Total Outstanding
                                </td>
                                <td>
                                    <input id="txtTotal" type="text" class="txtDisabled">
                                </td>
                                <td style="width: 56px;">
                                </td>
                                <td >
                                </td>
                            <tr>
                            </tr>
                            <div id="divPayment" runat="server" visible="false">
                            <tr>
                                <td style="width: 150px;">
                                    Payment Type
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlPaymentType" runat="server" meta:resourcekey="ddlPaymentTypeResource1">
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 50px;">
                                </td>
                                <td style="width: 150px;">
                                    Bank/Card Type
                                </td>
                                <td>
                                    <input id="txtCardType" type="text">
                                </td>
                                <td style="width: 56px;">
                                </td>
                                <td style="width: 120px;">
                                    Cheque/Card/DD No
                                </td>
                                <td>
                                    <input id="txtCheque" type="text">
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <asp:Label ID="lblCheque" Text="Cheque Date" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                                </td>
                                <td class="a-left">
                                
                                    <asp:TextBox ID="txtChequeValid" TabIndex="6" CssClass="small" runat="server" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                    <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                        CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" /><br />
                                    <Ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtChequeValid"
                                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                        Enabled="True" />
                                    <Ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                        ControlToValidate="txtChequeValid" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                    <Ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtChequeValid"
                                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                </td>
                                <td style="width: 50px;"></td>
                                                    <td colspan="3">
                                                    <div id="TRFimage">
                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                <tr valign="top">
                                                                    <td>
                                                        <asp:FileUpload ID="FileUpload1" runat="server" accept="gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG|pdf|PDF"
                                                            class="multi" meta:resourcekey="FileUpload1Resource1" />
                                                                    </td>
                                                                    <td id="tdDocScanner" runat="server" style="display: none;">
                                                                        <table >
                                                                            <tr>
                                                                                <td>
                                                                                    <input id="btnDocScanner" onclick="onAttDocumentScanner();" type="button" value="DocumentScanner" />
                                                                                    <input id="hdnDocScanner" runat="server" type="hidden" />
                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                <td>
                                                                                    <div class="MultiFile-list" id="tblDocumentScanner">
                                                                                    </div>
                                                </td>
                                                                            </tr>
                                                                        </table>
                                                </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                            </tr>
                            </div>
                        </tbody>
                    </table>
            
                </div>
                <br />
                <br />
                <div id="DivbtnSaveArea">
                    <input id="btnCalculate" type="button" onclick="javascript:return CalculationArea();"
                        value="Calculate" class="btn" style="margin-left: 45%;"> </input>
                    <asp:Button ID="btnBack" runat="server" Text="Back" class="btn" OnClick="btnBack_Click"
                        meta:resourcekey="btnBackResource1" />
                   <%-- <input id="btnSaveIn" type="button" onclick="javascript:return SaveDetails();" value="Save"
                        class="btn"> </input>--%>
                        <asp:Button ID="btnSaveIn" runat="server" Text="Save" class="btn" OnClientClick="javascript:return DataValidation();" OnClick="btnSaveIn_Click"
                        meta:resourcekey="btnSaveResource1" />
                </div>
           
 
        <script type="text/javascript" src="../Scripts/jquery-1.8.1.min.js" />

        <asp:HiddenField ID="hiddenTargetControlFormpeOthers" runat="server" />
        <asp:HiddenField ID="hdnChkValues" runat="server" />
        <input type="hidden" runat="server" id="hdnDefaultRoundoff" />
        <input type="hidden" runat="server" id="hdnRoundOffType" />
        <input type="hidden" runat="server" id="hdnInvoiceMultiplePayment" />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script src="../Scripts/jquery-1.10.2.min.js" type="text/javascript"></script>
    

    <script src="../Scripts/InvoiceCapture.js" type="text/javascript"></script>

    <style type="text/css">
        #supbill tr
        {
            background-color:#fbf3f3;
        }
        #supbill th
        {
            border: 1px solid black;
            background-color: rgba(226, 150, 76, 0.79) !important;
        }
        #supbill tr, #tableArea tr
        {
            border: 1px solid black;
        }
        .hide
        {
            display: none;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function popupprint() {
            //document.getElementById('printcontent').style.display = 'block';
            var prtContent = document.getElementById('printcontent');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0, scrollbars=yes,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            //WinPrint.close();
            //return false;
        }
        function txtdisable() {
                 $('#txtpendOut').attr('disabled', 'disabled');
                 $('#txttlInv').attr('disabled', 'disabled');
                 $('#txtAmuRec').attr('disabled', 'disabled');
                 $('#txtTotalInAmt').val("");
                 $('#txtReceivedAmt').val("");
                 $('#txtknoff').val("");
                 $('#txtwrite').val("");
                 $('#txtTotal').val("");
                 $('#txtCredit').val("");
                 $('#txtCardType').val("");
                 $('#txtCheque').val("");
                 $('#txtChequeValid').val("");
                 $('#txtknoff').attr('disabled', 'disabled');
                 $('#txtwrite').attr('disabled', 'disabled');
                 $('#txtTotal').attr('disabled', 'disabled');
                 $('#txtTotalInAmt').attr('disabled', 'disabled');
                 $('#txtReceivedAmt').attr('disabled', 'disabled');
        }
        
        function showHideReason(ddlID, chkID) {
            if (document.getElementById(chkID).checked == true) {
                document.getElementById(ddlID).disabled = false;
            }
            else {
                document.getElementById(ddlID).disabled = true;
            }
        }
        function hidemenu() {
            document.getElementById('menu').style.display = 'none';
        }


        function PreviousPayments(hdnComments) {

            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_002") != null ? SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_002") : "Client Name";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_003") != null ? SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_003") : "Payment Type";
            var UsrAlrtMsg2 = SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_004") != null ? SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_004") : "Received Amt";
            var UsrAlrtMsg3 = SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_005") != null ? SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_005") : "WriteOff Amt";
            var UsrAlrtMsg4 = SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_006") != null ? SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_006") : "Cheque/DD Number";
            var UsrAlrtMsg5 = SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_007") != null ? SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_007") : "Bank Name";
            var UsrAlrtMsg6 = SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_008") != null ? SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_008") : "Paid Date";
            
            
            
            
            var oTable = document.getElementById("tblDiagnosisItems");
            while (oTable.rows.length > 0)
                oTable.deleteRow(oTable.rows.length - 1);

            if (document.getElementById('tblDiagnosisItems').rows.length < 1) {
                var row = document.getElementById('tblDiagnosisItems').insertRow(0);
                row.style.background.bold;
                row.id = 0;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);
                var cell6 = row.insertCell(5);
                var cell7 = row.insertCell(6);

//                cell1.innerHTML = "Client Name";
//                cell1.width = "45%";
//                cell2.innerHTML = "Payment Type";
//                cell2.width = "15%";
//                cell3.innerHTML = "Received Amt";
//                cell3.width = "15%";
//                cell4.innerHTML = "WriteOff Amt";
//                cell4.width = "15%";
//                cell5.innerHTML = "Cheque/DD Number";
//                cell5.width = "15%";
//                cell6.innerHTML = "Bank Name";
//                cell6.width = "15%";
//                cell7.innerHTML = "Paid Date";
//                cell7.width = "15%";


                cell1.innerHTML = UsrAlrtMsg;
                cell1.width = "45%";
                cell2.innerHTML = UsrAlrtMsg1;
                cell2.width = "15%";
                cell3.innerHTML = UsrAlrtMsg2;
                cell3.width = "15%";
                cell4.innerHTML = UsrAlrtMsg3;
                cell4.width = "15%";
                cell5.innerHTML = UsrAlrtMsg4;
                cell5.width = "15%";
                cell6.innerHTML = UsrAlrtMsg5;
                cell6.width = "15%";
                cell7.innerHTML = UsrAlrtMsg6;
                cell7.width = "15%";
            }

            var rwNumber = parseInt(110);
            var list = hdnComments.split(',');
            if (list.length > 0 && list.value != '') {

                for (var i = 0; i < list.length; i++) {
                    var tempList = list[i].split('-');

                    var row = document.getElementById('tblDiagnosisItems').insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    var cell7 = row.insertCell(6);
                    cell1.innerHTML = tempList[0];
                    cell1.width = "45%";
                    cell2.innerHTML = tempList[1];
                    cell2.width = "15%";
                    cell3.innerHTML = tempList[2];
                    cell3.width = "15%";
                    cell4.innerHTML = tempList[3];
                    cell4.width = "15%";
                    cell5.innerHTML = tempList[4];
                    cell5.width = "15%";
                    cell6.innerHTML = tempList[5];
                    cell6.width = "15%";
                    cell7.innerHTML = tempList[6];

                }

                alternate('tblDiagnosisItems')

            }

        }
        function alternate(id) {
            if (document.getElementsByTagName) {
                var table = document.getElementById(id);
                var rows = table.getElementsByTagName("tr");
                for (i = 0; i < rows.length; i++) {
                    //manipulate rows <br>
                    if (i == 0)
                        rows[i].className = "dataheader1";
                    else {
                        if (i % 2 == 0) {
                            rows[i].className = "even";
                        } else {
                            rows[i].className = "odd";
                        }
                    }
                }
            }
        }

        function checkItems() {
            try {
                var chkedGAmt = 0; var TotalAmt = 0; var ReceivedAmt = 0;
                var RecivingAmt = 0; var WrightOff = 0; var bankName; var 
                           ChqorCardNo; var flag = 0;

                var AlrtWinHdr = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_02") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_02") : "Alert";
                var UsrAlrtMsg = SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_01") != null ? SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_01") : "Provide reason";
                var UsrAlrtMsg1 = SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_02") != null ? SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_02") : "Provide Receiving Amount";
                var UsrAlrtMsg2 = SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_03") != null ? SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_03") : "Received Amount Should not be Greater than Total Amount";
                var UsrAlrtMsg3 = SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_04") != null ? SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_04") : "Provide Bank Name";
                var UsrAlrtMsg4 = SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_05") != null ? SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_05") : "Provide the Cheque or Card Number";
                var UsrAlrtMsg5 = SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_06") != null ? SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_06") : "Status cannot be Pending !!";
                var UsrAlrtMsg6 = SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_07") != null ? SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_07") : "There was a problem";
	
                var isError = false;

                $('table[id$="grdInvoicePayments"] input[id$="chkBox"]:checked').each(function() {

                    flag = 1;
                    var $row = $(this).closest("tr");
                    var writeOff = $row.find($('input[id$="chkWOff"]')).is(':checked');

                var TotalAmt = $row.find($('span[id$="lblInvoiceAmt"]')).html();
                var RecivedAmt = $row.find($('span[id$="lblReceivedAmt"]')).html();
                var RecivingAmt = $row.find($('input[id$="txtReceiveAmt"]'));
                var reasonID = $row.find($('select[id$="ddlReason"] option:selected'));
                var statusID = $row.find($('select[id$="ddlStatus"] option:selected'));

                var reasonddl = $row.find($('select[id$="ddlReason"]'));
                var statusddl = $row.find($('select[id$="ddlStatus"]'));
                
                var bankName = $row.find($('input[id$="txtBankName"]'));
                var ChqorCardNo = $row.find($('input[id$="lblChqorCardNo"]'));
                    var PaymentType = $row.find($('select[id$="ddlPayMentType"] option:selected'));
                var Disabled = $(RecivingAmt).attr("disabled");

                if (Disabled != "disabled") {

                        if (writeOff == true) {
                            if ($(reasonID).val() == "0") {
                                isError = true;
                                //alert('Provide reason');
                                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                                $(reasonddl).focus();
                                return false;

                            }
                        }
                        else {
                            if ($(RecivingAmt).val() == "" || Number($(RecivingAmt).val()) == Number(0)) {
                                //alert('Provide Receiving Amount');
                                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                                $(RecivingAmt).focus();
                                isError = true;
                                return false;

                            }
                        }
                        if (Number(TotalAmt) < Number((Number(ReceivedAmt) + Number($(RecivingAmt).val())))) {
                            //alert('Received Amount Should not be Greater than Total Amount');
                            ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                            $(RecivingAmt).focus();
                            isError = true;
                            return false;

                        }
                        if ($(RecivingAmt).val() != "") {
                            if (Number($(RecivingAmt).val()) > 0) {
                                if ($(bankName).val() == "" && $(PaymentType).val() != "1") {
                                    //alert('Provide Bank Name');
                                    ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                                    $(bankName).focus();
                                    isError = true;
                                    return false;

                                }
                                if ($(ChqorCardNo).val() == "" && $(PaymentType).val() != "1") {
                                    //alert('Provide the Cheque or Card Number');
                                    ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
                                    $(ChqorCardNo).focus();
                                    isError = true;
                                    return false;
                                }
                            }
                        }
                        if ($(statusID).val() == "0") {
                            //alert('Status cannot be Pending !!');
                            ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
                            $(statusddl).focus();
                            isError = true;
                            return false;

                        }
                        if (Number(TotalAmt) == (Number(ReceivedAmt) + Number($(RecivingAmt).val())) && $(statusID).val() == "0") {
                            //alert('Status cannot be Pending.');
                            ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
                            $(statusddl).focus();
                            isError = true;
                            return false;

                    }

                }

            });
            if (isError)
                return false;
            }
            catch (e) {
                //alert("There was a problem");
                ValidationWindow(UsrAlrtMsg6, AlrtWinHdr);
                return false;
            }

          
        }


       
    
    </script>
    <script type="text/javascript" language="javascript">
        function showModalPopup(hdnComments) {
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_02") != null ? SListForAppMsg.Get("Invoice_InvoiceTracker_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_08") != null ? SListForAppMsg.Get("Invoice_InvoiceCapture_aspx_08") : "No Previous Payment made to this Invoice";
	
            var hdnComments = document.getElementById(hdnComments);
            document.getElementById('pnlOthers').style.display = "block";

            if (hdnComments.value != '') {
                document.getElementById('divOthers').style.display = "block";
                $('[id$="divOthers"]').show();
                PreviousPayments(hdnComments.value);
            }
            else {
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
               // alert("No Previous Payment made to this Invoice");
            }
        }
        function closePopup() {
            document.getElementById('pnlOthers').style.display = "none";
            document.getElementById('divOthers').style.display = "none";
             $('[id$="divOthers"]').hide();
        }
    </script>
</body>
</html>
