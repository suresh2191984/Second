<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvoiceCapturewithoutKnockOff.aspx.cs" Inherits="Invoice_InvoiceCapturewithoutKnockOff" %>

<%--<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="PhyHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Invoice Capture</title>
 <script src="../Scripts/jquery-1.10.2.min.js" type="text/javascript"></script>
     <script src="../Scripts/InvoiceCapture.js" type="text/javascript"></script>
<style type="text/css">
        .style2
        {
        }
        .style3
        {
            font-weight: bold;
            text-decoration: underline;
        }
        .style4
        {
            font-weight: bold;
        }
        .style5
        {
        }
        .style6
        {
            height: 12px;
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


        function DisaplyPOP() {
            $find('ModalPopupExtender1').show();

        }

        function PreviousPayments(hdnComments) {

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

                cell1.innerHTML = "Client Name";
                cell1.width = "45%";
                cell2.innerHTML = "Payment Type";
                cell2.width = "15%";
                cell3.innerHTML = "Received Amt";
                cell3.width = "15%";
                cell4.innerHTML = "WriteOff Amt";
                cell4.width = "15%";
                cell5.innerHTML = "Cheque/DD Number";
                cell5.width = "15%";
                cell6.innerHTML = "Bank Name";
                cell6.width = "15%";
                cell7.innerHTML = "Paid Date";
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
                            alert('Provide reason');
                            $(reasonddl).focus();
                            return false;

                        }
                    }
                    else {
                        if ($(RecivingAmt).val() == "" || Number($(RecivingAmt).val()) == Number(0)) {
                            alert('Provide Receiving Amount');
                            $(RecivingAmt).focus();
                            isError = true;
                            return false;

                        }
                    }
                    if (Number(TotalAmt) < Number((Number(ReceivedAmt) + Number($(RecivingAmt).val())))) {
                        alert('Received Amount Should not be Greater than Total Amount');
                        $(RecivingAmt).focus();
                        isError = true;
                        return false;

                    }
                    if ($(RecivingAmt).val() != "") {
                        if (Number($(RecivingAmt).val()) > 0) {
                            if ($(bankName).val() == "" && $(PaymentType).val() != "1") {
                                alert('Provide Bank Name');
                                $(bankName).focus();
                                isError = true;
                                return false;

                            }
                            if ($(ChqorCardNo).val() == "" && $(PaymentType).val() != "1") {
                                alert('Provide the Cheque or Card Number');
                                $(ChqorCardNo).focus();
                                isError = true;
                                return false;
                            }
                        }
                    }
                    if ($(statusID).val() == "0") {
                        alert('Status cannot be Pending !!');
                        $(statusddl).focus();
                        isError = true;
                        return false;

                    }
                    if (Number(TotalAmt) == (Number(ReceivedAmt) + Number($(RecivingAmt).val())) && $(statusID).val() == "0") {
                        alert('Status cannot be Pending.');
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
                alert("There was a problem");
                return false;
            }

          
        }
 
       
    
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
	 <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div id="wrapper">
       
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
               <%-- <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />--%>
                   <%-- <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>--%>
                    <div class="contentdata1">
                        <%--<ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>--%>
                        <asp:UpdatePanel ID="up1" runat="server">
                            <ContentTemplate>
                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            <div class="dataheader3">
                                                <asp:GridView ID="grdInvoicePayments" runat="server" CellPadding="1" CssClass="mytable1"
                                                    AutoGenerateColumns="False" Width="100%" OnRowDataBound="grdInvoicePayments_RowDataBound">
                                                    <Columns>
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkBox" runat="server" Checked="True" Enabled="false" />
                                                                <asp:HiddenField ID="hdnComments" Value='<%# DataBinder.Eval(Container.DataItem,"Comments") %>'
                                                                    runat="server" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Action" HeaderStyle-VerticalAlign="Top">
                                                            <ItemTemplate>
                                                                <img alt="" src="../Images/view_button.gif" id="showmenu" style="cursor: pointer;" />
                                                            </ItemTemplate>
                                                            <HeaderStyle VerticalAlign="Top"></HeaderStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="InvoiceID" HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center"
                                                            Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblInvoiceID" runat="server" Text='<%# Bind("InvoiceID") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top"></HeaderStyle>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="InvoiceNumber" HeaderStyle-VerticalAlign="Top" HeaderText="Invoice No"
                                                            HeaderStyle-HorizontalAlign="Center">
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top"></HeaderStyle>
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="Client Name" HeaderStyle-Width="70px" HeaderStyle-Wrap="true"
                                                            HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label ID="ClientName" runat="server" Text='<%# Bind("ApproverRemarks") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Wrap="True" Width="70px">
                                                            </HeaderStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Date" HeaderStyle-VerticalAlign="Top" SortExpression="Date">
                                                            <ItemTemplate>
                                                                <%# (string)DataBinder.Eval(Container.DataItem, "CreatedAt", "{0:dd/MM/yyyy}")%>
                                                                </a>
                                                            </ItemTemplate>
                                                            <HeaderStyle VerticalAlign="Top"></HeaderStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Gross Amount" HeaderStyle-Width="70px" HeaderStyle-Wrap="true"
                                                            HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblInvoiceGAmt" runat="server" Text='<%# Bind("GrossValue") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Wrap="True" Width="70px">
                                                            </HeaderStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Net Amount" HeaderStyle-Width="70px" HeaderStyle-Wrap="true"
                                                            HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblInvoiceAmt" runat="server" Text='<%# Bind("NetValue") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Wrap="True" Width="70px">
                                                            </HeaderStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="RoundOff Total" HeaderStyle-VerticalAlign="Top" HeaderStyle-Width="70px"
                                                            HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblRoundOffTotal" runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Width="30px"></HeaderStyle>
                                                            <ItemStyle Width="30px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Round Off" HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="lblRoundOff" onkeypress="return validatenumber(event);" runat="server"
                                                                    Width="40px" Enabled="false" CssClass="Txtboxmedium"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top"></HeaderStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Received Amount" HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center"
                                                            HeaderStyle-Width="40px" HeaderStyle-Wrap="true">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblReceivedAmt" runat="server" Text='<%# Bind("ReceivedAmt") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Wrap="True" Width="40px">
                                                            </HeaderStyle>
                                                            <ItemStyle Width="40px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Due" HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center"
                                                            HeaderStyle-Width="40px" HeaderStyle-Wrap="true">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDuedAmt" runat="server" Text='<%# Bind("DueAmount") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Wrap="True" Width="30px">
                                                            </HeaderStyle>
                                                            <ItemStyle Width="30px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Receiving Amount" HeaderStyle-VerticalAlign="Top"
                                                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px" HeaderStyle-Wrap="true">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtReceiveAmt" onkeypress="return validatenumber(event);" runat="server"
                                                                    Width="60px" CssClass="Txtboxmedium"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Wrap="True" Width="50px">
                                                            </HeaderStyle>
                                                            <ItemStyle Width="30px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Write Off" HeaderStyle-VerticalAlign="Top" HeaderStyle-Width="15px"
                                                            HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkWOff" runat="server" />
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Width="15px"></HeaderStyle>
                                                        </asp:TemplateField>
                                                        
                                                        <asp:TemplateField HeaderText="Discount" HeaderStyle-VerticalAlign="Top"
                                                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px" HeaderStyle-Wrap="true">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtDiscountAmt" Text="0" runat="server"
                                                                    Width="60px" CssClass="Txtboxmedium"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Wrap="True" Width="50px">
                                                            </HeaderStyle>
                                                            <ItemStyle Width="30px" />
                                                        </asp:TemplateField>                                                       
                                                        
                                                        <asp:TemplateField HeaderText="TDS" HeaderStyle-VerticalAlign="Top"
                                                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px" HeaderStyle-Wrap="true">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtTDSAmt" Text="0" runat="server"
                                                                    Width="60px" CssClass="Txtboxmedium"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Wrap="True" Width="50px">
                                                            </HeaderStyle>
                                                            <ItemStyle Width="30px" />
                                                        </asp:TemplateField>
                                                        
                                                        
                                                        <asp:TemplateField HeaderText="Reason" HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddlReason" Enabled="false" runat="server" CssClass="drpsmall"
                                                                    Width="130px">
                                                                </asp:DropDownList>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top"></HeaderStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Payment Type" HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddlPayMentType" runat="server" CssClass="drpsmall">
                                                                </asp:DropDownList>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top"></HeaderStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Bank Name" HeaderStyle-VerticalAlign="Top" HeaderStyle-Wrap="true"
                                                            HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtBankName" runat="server" Width="70px" CssClass="Txtboxmedium"></asp:TextBox>
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
                                                            HeaderStyle-Width="60px" HeaderStyle-Wrap="true" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="lblChqorCardNo" runat="server" Width="60px" CssClass="Txtboxmedium"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Wrap="True" Width="60px">
                                                            </HeaderStyle>
                                                            <ItemStyle Width="60px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Status" HeaderStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="drpsmall" Width="80px">
                                                                    <asp:ListItem Text="Pending" Value="0"></asp:ListItem>
                                                                    <asp:ListItem Text="Completed" Value="1"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </ItemTemplate>
                                                            <ControlStyle />
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top"></HeaderStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Total Amount" HeaderStyle-HorizontalAlign="Center"
                                                            Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblWriteOffAmt" runat="server" Text='0'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                                <%--<input type="button" id="btnPop" runat="server" />--%>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                       <%--  <asp:Button ID="btnCalculate" runat="server" Text="Calculate" class="btn" />--%>
                                       <%-- <input id="btnCalculate" type="button" 
                                          value="Calculate" class="btn" onclick="btnCalculate_Click"  style="margin-left: 45%;"> </input>--%>
                                            <asp:Button ID="btnSave" runat="server" Text="Generate Receipt" class="btn" OnClick="btnSave_Click"
                                                OnClientClick="javascript:return checkItems();" />
                                            <asp:Button ID="btnBack" runat="server" Text="Back" class="btn" OnClick="btnBack_Click" />
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
                                                                        <asp:Image ID="imgBillLogo" runat="server" Visible="False" />
                                                                    </td>
                                                                    <td colspan="8" style="padding-left:100px;" align="center">
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
                                                                            Font-Bold="true"></asp:Label>
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
                                                                        <asp:Label ID="Rs_ClientName" runat="server" Text="Client Name" Font-Bold="true"></asp:Label>
                                                                    </td>
                                                                    <td class="style2">
                                                                        &nbsp; :
                                                                        <asp:Label ID="lblClientName" runat="server"></asp:Label>
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
                                                                        <asp:Label Style="font-weight: 700" ID="Rs_PaidDate" runat="server" Text="Paid Date"></asp:Label>
                                                                    </td>
                                                                    <td nowrap="nowrap" align="right" class="style2">
                                                                        :
                                                                    </td>
                                                                    <td nowrap="nowrap" align="Left" class="style2">
                                                                        <asp:Label ID="lblPaidDate" runat="server"></asp:Label>
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
                                                                        <asp:Label ID="Rs_ReceiptNumber" runat="server" Text="Receipt Number" Font-Bold="true"></asp:Label>
                                                                    </td>
                                                                    <td class="style5">
                                                                        &nbsp; :
                                                                        <asp:Label ID="lblReceiptNumber" runat="server"></asp:Label>
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
                                                                            <asp:Label ID="Rs_PrintDate" runat="server" Text="Print Date"></asp:Label>
                                                                        </label>
                                                                    </td>
                                                                    <td nowrap="nowrap" align="right" class="style5">
                                                                        <label>
                                                                            :</label>
                                                                    </td>
                                                                    <td nowrap="nowrap" align="left" class="style5">
                                                                        <asp:Label ID="lblPrintDate" runat="server"></asp:Label>
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
                                                                            <asp:GridView ID="gvReceipt" runat="server" Width="100%" AutoGenerateColumns="False" style="font-family: Verdana; font-size: 10px;"
                                                                                BorderStyle="Solid" BorderColor="#B6A8A8" BorderWidth="1px">
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="S.No" ItemStyle-Width="4%">
                                                                                        <ItemTemplate>
                                                                                            <%# Container.DataItemIndex + 1 %>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Payment Mode">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblPaymentMode" Text='<%# Bind("PaymentName") %>' runat="server"></asp:Label>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Card/Cheque No">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblChequeNo" Text='<%# Bind("ChequeorCardNumber") %>' runat="server"></asp:Label>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Bank/Card Name">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblBankName" Text='<%# Bind("bankNameorCardType") %>' runat="server"></asp:Label>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Amount">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblAmount" Text='<%# Bind("AmtReceived") %>' runat="server"></asp:Label>
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
                                                                        <asp:Label ID="lbtot" runat="server" Text="Total" Font-Bold="true"></asp:Label>
                                                                        :
                                                                        <asp:Label ID="lblGrandTotal" runat="server" />
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
                                                                        <asp:Label ID="lblrecivAmountinWords" runat="server" Text="The Sum of "></asp:Label>
                                                                        <asp:Label ID="lblrecivAmount" runat="server" />
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
                                                                        <asp:Label Font-Bold="True" ID="lbl_bill" Text="RECEIVER NAME" runat="server"></asp:Label><br />
                                                                        <asp:Label ID="lbl_Billedoutput" runat="server" Style="font-weight: 700" />
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
                                <asp:Panel ID="pnlOthers" runat="server" Style="display: none; width: 600px">
                                    <center>
                                        <div id="divOthers" class="modal" style="width: 500px; height: 180px; padding-top: 50px;
                                            padding-left: 15px">
                                            <table width="90%" align="center">
                                                <tr align="left">
                                                    <td>
                                                        <table id="tblDiagnosisItems" class="dataheaderInvCtrl" runat="server" cellpadding="4"
                                                            cellspacing="0" border="1">
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <input type="button" id="btnpopClose" onclick="javascript:return closePopup();" class="btn"
                                                            runat="server" value="Close" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </center>
                                </asp:Panel>

                                <script type="text/javascript" src="../Scripts/jquery-1.8.1.min.js" />

                                <asp:HiddenField ID="hiddenTargetControlFormpeOthers" runat="server" />
                                <asp:HiddenField ID="hdnChkValues" runat="server" />
                                <input type="hidden" runat="server" id="hdnDefaultRoundoff" />
                                <input type="hidden" runat="server" id="hdnRoundOffType" />
                                <input type="hidden" runat="server" id="Hiddenclientid" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <%--<uc5:Footer ID="Footer1" runat="server" />--%>
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script type="text/javascript" language="javascript">
        function showModalPopup(hdnComments) {
            var hdnComments = document.getElementById(hdnComments);
            document.getElementById('pnlOthers').style.display = "block";

            if (hdnComments.value != '') {
                document.getElementById('divOthers').style.display = "block";
                $('[id$="divOthers"]').show();
                PreviousPayments(hdnComments.value);
            }
            else {
                alert("No Previous Payment made to this Invoice");
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
