<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GenerateInvoice.aspx.cs"
    Inherits="Invoice_GenerateInvoice" meta:resourcekey="PageResource2" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<script src="../Scripts/AdobeReaderDetection.js" type="text/javascript" language="javascript" />

<script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

<%--<script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>--%>

<style type="text/css">
    .scrollable-container
    {
        max-height: 300px;
        min-height:80px;
        width: 100%;
        overflow: auto;
        border:none;
        background-image: url(../BB/Images/whitebg.png);
        background-repeat: repeat; /*width:720px;*/
        margin-left: 0px;
        margin-top: 0px;
        margin-bottom: 10px;

    }
.AlgRgh
{
  text-align:right;
  font-family:Verdana, Arial, Helvetica, sans-serif;
}
.tbllblClient td{ padding:5px;}

#lblHospitalName {
    line-height: 16px;
}
#grdInvoiceBill tr .smlTable {
    display: block;
}
#grdInvoiceBill tr .smlTable table.dataheaderInvCtrl {
    background: #fff none repeat scroll 0 0;
    border: 1px solid #a2a2a2;
    margin: 1%;
    width: 98%;
}
#grdInvoiceBill tr .smlTable table.dataheaderInvCtrl tr, #grdInvoiceBill tr .smlTable table.dataheaderInvCtrl th, #grdInvoiceBill tr .smlTable table.dataheaderInvCtrl tr td {
    background: rgba(0, 0, 0, 0) none repeat scroll 0 0 !important;
    border: medium none;
    height: auto;
    line-height: 20px;
    min-height: 10px;
    padding: 0 5px;
}
.smlTable .trOdd td:first-child, .smlTable .trEven td:first-child {
    display: none;
}
</style>

<script language="javascript" type="text/javascript">

    //    function PrintReport(InvID, reportPath) {
    //        var browser_info = perform_acrobat_detection();
    //        if (browser_info.acrobat == null) {
    //            alert("Please install adobe reader to perform print functionality");
    //        }
    //        else {
    //            $("#iframeplaceholder").html("<iframe id='myiframe' name='myname' src='PrintInvoiceDetails.aspx?InvID=" + InvID + "&reportPath=" + reportPath + "' style='position:absolute;top:0px; left:0px;width:0px; height:0px;border:0px;overfow:none; z-index:-1'></iframe>");
    //        }
    //    }


    var scroll = {
        Y: '#<%= hfScrollPosition.ClientID %>'
    };
    $(document).ready(function() {
        $("#scrollable-container").scrollTop($(scroll.Y).val());
    });

    function RestrictChar(id) {

        var exp = String.fromCharCode(window.event.keyCode)
        var r = new RegExp("[0-9.\r]", "g");
        if (exp.match(r) == null) {
            window.event.keyCode = 0
            return false;

        }
    }



    function ChkAllBox(sender) {

        var chkArrayMain = new Array();
        chkArrayMain = document.getElementById('hdnchkAll').value.split('~');
        if (document.getElementById(sender).checked) {
            for (var i = 0; i < chkArrayMain.length; i++) {
                document.getElementById(chkArrayMain[i]).checked = true;
            }
        }
        else {
            for (var i = 0; i < chkArrayMain.length; i++) {
                document.getElementById(chkArrayMain[i]).checked = false;
            }
        }
        var grid = document.getElementById('grdInvoiceBill');
        var TotalGrossAmt = Number(document.getElementById('txtGross').value);
        var TotalNetAmt = Number(document.getElementById('txtNetAmt').value);
        if (grid != null) {
            if (grid.rows.length > 0) {
                for (var i = 1; i < grid.rows.length; i++) {
                    if (document.getElementById(sender).checked) {
                        var GrossAmt = grid.rows[i].cells[5].innerText;
                        var Netamt = grid.rows[i].cells[6].innerText;
                        TotalGrossAmt += Number(GrossAmt);
                        TotalNetAmt += Number(Netamt);
                        document.getElementById('txtGross').value = TotalGrossAmt.toFixed(2);
                        document.getElementById('txtNetAmt').value = TotalNetAmt.toFixed(2);
                    }
                    else {
                        document.getElementById('txtGross').value = "0.00";
                        document.getElementById('txtNetAmt').value = "0.00";
                    }

                }
            }

        }
    }

    function PopupClose() {
        document.getElementById('hdnShowReport').value = 'false';
        location.href = '../Reception/LabReceptionHome.aspx?IsPopup=Y';
    }
    function ChkboxSelectedItems(ID, DropID) {
        if (document.getElementById(ID).checked == true) {
            var drpReason = document.getElementById(DropID);
            drpReason.index = 0;
            document.getElementById(DropID).style.display = "none";
        }
        else {
            document.getElementById(DropID).style.display = "block";
        }

        document.getElementById('txtGross').value = "0.00";
        var grid = document.getElementById('grdInvoiceBill');
        var GrdLenth = grid.rows.length;
        var inputList = grid.getElementsByTagName("input");
        var chkedGAmt = 0;
        for (var i = 1; i < GrdLenth; i++) {
            if (grid.getElementsByTagName("input")[i].checked == true) {
                var GAmt = grid.rows[i].cells[7].innerText;
                //var GAmt = document.getElementById(GAmtID).value;
                chkedGAmt += Number(GAmt);
                document.getElementById('txtGross').value = Number(chkedGAmt).toFixed(2);
            }
        }

        CalCulateAmtvalue();
    }

    function setDiscount() {
        document.getElementById('hdnDisPer').value = "0";
        var NetAmount = 0;
        var Gvalue = document.getElementById('txtGross').value;
        var disid = document.getElementById('ddDiscountPercent').value;
        if (disid > 0) {
            var hdnList = document.getElementById('hdnDiscount').value;
            var hdnVal = hdnList.split("^");
            for (var i = 0; i < hdnVal.length; i++) {
                if (hdnVal[i] != "") {
                    var id = hdnVal[i].split('~')[0];
                    if (id == disid) {
                        var disper = hdnVal[i].split('~')[2];
                        document.getElementById('lblDis').style.display = 'block';
                        document.getElementById('lblDis').innerHTML = Number(disper) + "%";
                        document.getElementById('hdnDisPer').value = Number(disper);

                    }

                }

            }
        }
        else {

            document.getElementById('lblDis').style.display = 'none';
            document.getElementById('txtDiscountAmt').value = "";
            document.getElementById('trDiscountReason').style.display = 'none';
            document.getElementById('txtDisCountReason').value = "";
            document.getElementById('DdlDiscountreason').selectedIndex = 0;


        }
        if (disper > 0) {
            NetAmount = Gvalue * disper / 100;
            document.getElementById('txtDiscountAmt').value = NetAmount;
            document.getElementById('trDiscountReason').style.display = 'table-row';
        }
        else {
            document.getElementById('txtDiscountAmt').value = (0).toFixed(2);
            document.getElementById('trDiscountReason').style.display = 'none';
        }
        CalCulateAmtvalue();

    }


    function CalCulateAmtvalue() {
        var AlrtWinHdr = SListForAppMsg.Get("Invoice_GenerateInvoice_aspx_07") != null ? SListForAppMsg.Get("Invoice_GenerateInvoice_aspx_07") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("Invoice_GenerateInvoice_aspx_01") != null ? SListForAppMsg.Get("Invoice_GenerateInvoice_aspx_01") : "Discount Amount Can not be Greater than Gross Amount";
        var UsrAlrtMsg1 = SListForAppMsg.Get("Invoice_GenerateInvoice_aspx_02") != null ? SListForAppMsg.Get("Invoice_GenerateInvoice_aspx_02") : "Tax Amount Can not be Greater than Gross Amount";
        
        var GrsAmt = 0, Discount = 0, NetAmt = 0, TOD = 0, TODInvoice, NetTotalAmount = 0, FinalNetAmt = 0, DivTax = 0, TOV = 0;CreditAmt = 0;
        GrsAmt = document.getElementById('txtGross').value;
        Discount = document.getElementById('txtDiscountAmt').value;
        //DivTax = document.getElementById('divGenerateTax').innerHTML;
        var lstTxtTax = $('input[id^="txtTax"]');
        var taxAmount = 0;
        $.each(lstTxtTax, function() {
            taxAmount += parseFloat($(this).val());
        });
        NetAmt = document.getElementById('txtNetAmt').value;
        TOD = document.getElementById('txtTOD').value;
        TODPer = document.getElementById('LblTODPer').innerHTML;
        TODInvoice = document.getElementById('hdnTODdetails').value;
        TOV = document.getElementById('hdnTovamout').value;
       CreditAmt = document.getElementById('hdnDebitAmt').value;

        if (Number(Discount) > Number(GrsAmt)) {
            //alert('Discount Amount Can not be Greater than Gross Amount ');
            ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
	
            document.getElementById('txtDiscountAmt').focus();
            return false;
        }

        if (Number(taxAmount) > Number(GrsAmt)) {
            //alert('Tax Amount Can not be Greater than Gross Amount ');
            ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
            return false;
        }


        if (GrsAmt > 0) {
            NetAmt = (Number(GrsAmt) + Number(taxAmount)) - Number(Discount);
            if (TODInvoice != "") {
                var pList = document.getElementById('hdnTODdetails').value.split("^");
                var pParentLst = document.getElementById('hdnTODdetails').value.split("^");
                for (j = 0; j < pParentLst.length; j++) {
                    if (pParentLst[j] != "") {
                        y = pList[j].split('~');

                        if (Math.round(GrsAmt) >= y[1] && Math.round(GrsAmt) <= y[2]) {
                            document.getElementById('LblTODPer').innerHTML = "(" + y[3] + "%)";
                            TODPer = y[3];

                        }


                    }
                }
                var TodAmt;

                TodAmt = Number(GrsAmt) * Number(TODPer) / 100;
                document.getElementById('txtTOD').value = TodAmt;
                document.getElementById('txtVolumeAmount').value = Number(TOV).toFixed(2);
                FinalNetAmt = Number(NetAmt) - Number(TodAmt)-Number(TOV);

                document.getElementById('txtNetAmt').value = Number(FinalNetAmt).toFixed(2);

            }
            else {
                document.getElementById('txtTOD').value = "0.00";
                document.getElementById('txtVolumeAmount').value = Number(TOV).toFixed(2);
                var FinalNetAmt = Number(NetAmt).toFixed(2) - Number(TOV).toFixed(2);
                document.getElementById('txtNetAmt').value = Number(FinalNetAmt).toFixed(2);
            }

            if (CreditAmt > 0) {
                var FinalNetAmount;
                FinalNetAmount = Number(FinalNetAmt).toFixed(2) - Number(CreditAmt).toFixed(2);
                document.getElementById('txtNetAmt').value = Number(FinalNetAmount).toFixed(2);
            }
            
        }
        else {
            document.getElementById('txtNetAmt').value = "0.00";
        }

    }

    function Checktxtbox() {
        var AlrtWinHdr = SListForAppMsg.Get("Invoice_GenerateInvoice_aspx_07") != null ? SListForAppMsg.Get("Invoice_GenerateInvoice_aspx_07") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("Invoice_GenerateInvoice_aspx_03") != null ? SListForAppMsg.Get("Invoice_GenerateInvoice_aspx_03") : "Provide reason";
        var UsrAlrtMsg1 = SListForAppMsg.Get("Invoice_GenerateInvoice_aspx_04") != null ? SListForAppMsg.Get("Invoice_GenerateInvoice_aspx_04") : "Gross Amount Should be Greater than Zero";
        var UsrAlrtMsg2 = SListForAppMsg.Get("Invoice_GenerateInvoice_aspx_05") != null ? SListForAppMsg.Get("Invoice_GenerateInvoice_aspx_05") : "Provide Discount Reason";
        var UsrAlrtMsg3 = SListForAppMsg.Get("Invoice_GenerateInvoice_aspx_06") != null ? SListForAppMsg.Get("Invoice_GenerateInvoice_aspx_06") : "Select Invoice Type";
        
        var grid = document.getElementById('grdInvoiceBill');
        var GrdLenth = grid.rows.length;
        var inputList = grid.getElementsByTagName("input");
        var chkedGAmt = 0;
        if (grid != null) {
            for (var i = 1; i < GrdLenth; i++) {
                if (grid.rows[i].cells[0].childNodes[0].type == "checkbox") {
                    if (grid.rows[i].cells[0].childNodes[0].checked == false) {
                        document.getElementById('hdnStatus').value = 1;
                        var drpReason = grid.rows[i].cells[9].childNodes[0].selectedIndex;
                        if (drpReason == "0") {

                            //alert("Provide reason");
                            ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                            //  document.getElementById(drpReason).focus();
                            return false;

                        }
                    }
                }
            }
        }
        //            for (var i = 1; i < GrdLenth; i++) {
        //                if (grid.getElementsByTagName("input")[i].checked == false) {
        //                    
        //                }
        //            } 
        //        }


        var GrAmt = document.getElementById('txtGross').value;
        var DisAmt = document.getElementById('txtDiscountAmt').value;
        var NtAmt = document.getElementById('txtNetAmt').value;
        var disRes = document.getElementById('txtDisCountReason').value;
        var InvID = document.getElementById('hdnInvID').value;
        if (GrAmt <= 0 || GrAmt == '') {
            //alert('Gross Amount Should be Greater than Zero');
            ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
            return false;
        }
        if (DisAmt > 0 && disRes == '') {
            //alert('Provide Discount Reason');
            ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
            return false;
        }
        var DrpinvoiceType = document.getElementById('ddlInvoiceType').selectedIndex
        if (DrpinvoiceType == "0") {
            //alert('Select Invoice Type');
            ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
            return false;
        }
//        if (NtAmt <= 0 || NtAmt == '') {
//            alert('Net Amount Should be Greater than Zero');
//            return false;

//        }
    }
    //        if (document.getElementById('chkApprover').checked != true) {

    //            if (InvID == 0) {
    //                if (Auth == '' || Auth == 'Name') {
    //                    alert('Provide Approver Name');
    //                    return false;
    //                }
    //            }
    //        }

    function GetDiscountReasonlist() {

        var drploc = document.getElementById('DdlDiscountreason').options[document.getElementById('DdlDiscountreason').selectedIndex].value;
        var options = document.getElementById('hdndiscountreason').value;
        var list = options.split('^');
        for (i = 0; i < list.length; i++) {
            if (list[i] != "") {
                var res = list[i].split('~');
                if (drploc == res[0]) {
                    document.getElementById('txtDisCountReason').value = res[2];
                    document.getElementById('hdnDisResCode').value = res[1];
                }
            }
        }
    }
    function DiscountAuthSelected(source, eventArgs) {
        document.getElementById('hdnApprovedByID').value = eventArgs.get_value();
    }

</script>

<head id="Head1" runat="server">
    <title>Generate Invoice</title>

<%--    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>--%>

    <script type="text/javascript">
        $(function() {
            $('btnGenerateInvoice').click(function() {
                var frame1 = document.getElementById('myiframe');
                var loadingDisplay = document.getElementById('loading').style;
                loadingDisplay.display = 'inline';
                if (frame1.onload == null) {
                    frame1.onload = function() {
                        loadingDisplay.display = 'none'
                    };
                    if (window.attachEvent) {
                        frame1.attachEvent('onload', frame1.onload);
                    }
                }
                return true;
            });

        });
        
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" ScriptMode="Release" EnablePageMethods="True">
    </asp:ScriptManager>
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <div>
                         <asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <ContentTemplate>
                                        <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                                            <ProgressTemplate>
                                            <div id="progressBackgroundFilter" class="a-center">
                                            </div>
                                            <div id="processMessage" class="a-center w-20p">
                                                <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                            </div>
                                        </ProgressTemplate>

                                    </asp:UpdateProgress>
                                        
                        <table class="w-100p searchPanel">
                            <tr>
                                <td class="a-center">
                                    <label id="lblHospitalName" runat="server">
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="w-100p tbllblClient">
                                        <tr>
                                            <td class="w-16p">
                                                <asp:Label ID="lblClientName" runat="server" Text="Client Name" meta:resourcekey="lblClientNameResource2"></asp:Label>:
                                            </td>
                                            <td>
                                                <asp:Label ID="lblClient" runat="server" meta:resourcekey="lblClientResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="w-10p">
                                                <asp:Label ID="lblCCode" runat="server" Text="Client Code" meta:resourcekey="lblCCodeResource1"></asp:Label>:
                                            </td>
                                            <td>
                                                <asp:Label ID="lblClientCode" runat="server" meta:resourcekey="lblClientCodeResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblPeriod" runat="server" Text="Period" meta:resourcekey="lblPeriodResource2"></asp:Label>:
                                            </td>
                                            <td>
                                                <asp:Label ID="lblfrom" runat="server" meta:resourcekey="lblfromResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblRevAmt" runat="server" Text="Last Received Payment:" Font-Bold="True"
                                                    meta:resourcekey="lblRevAmtResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblRecAmt" runat="server" Font-Bold="True" meta:resourcekey="lblRecAmtResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbldue" runat="server" Text="Previous Due Amount" Font-Bold="True"
                                                    meta:resourcekey="lbldueResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblDueAmt" runat="server" Font-Bold="True" meta:resourcekey="lblDueAmtResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="scrollable-container" class="scrollable-container" onscroll="$(scroll.Y).val(this.scrollTop);">
                                        <div class="dataheader3">
                                            <asp:GridView ID="grdInvoiceBill" runat="server" CellPadding="1" CssClass="mytable1 gridView w-100p"
                                                AutoGenerateColumns="False" OnRowDataBound="grdInvoiceBill_RowDataBound"
                                                meta:resourcekey="grdInvoiceBillResource2">
                                                <Columns>
                                                    <asp:TemplateField Visible="false" meta:resourcekey="TemplateFieldResource7">
                                                        <HeaderTemplate>
                                                            <asp:CheckBox onclick="ChkAllBox(this.id);" Visible="false" ToolTip="Select All" ID="chkSelectAll"
                                                                runat="server" Checked="True" meta:resourcekey="chkSelectAllResource2" />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkInvoiceItem" runat="server" Checked="True" Visible="false" meta:resourcekey="chkInvoiceItemResource2" />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource8">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFinalBillID" runat="server" Text='<%# Bind("FinalBillID") %>' meta:resourcekey="lblFinalBillIDResource2"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="FinalBillID" Visible="false" meta:resourcekey="BoundFieldResource6" />
                                                    <asp:BoundField DataField="BillNumber" HeaderText="Bill No" meta:resourcekey="BoundFieldResource7" />
                                                    <asp:BoundField DataField="VisitID" HeaderText="VisitID" meta:resourcekey="BoundFieldResource8" />
                                                    <asp:TemplateField HeaderText="Date" SortExpression="InvoiceDate" HeaderStyle-Width="8%"
                                                        meta:resourcekey="TemplateFieldResource9">
                                                        <ItemTemplate>
                                                            <%# (string)DataBinder.Eval(Container.DataItem, "billedDate", "{0:dd/MMM/yyyy}")%>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="8%"></HeaderStyle>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Name" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource9" />
                                                    <asp:TemplateField HeaderText="Test Description" meta:resourcekey="TemplateFieldResource10">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblBilledFor" CssClass="smlTable" Text='<%# Eval("FeeDescription") %>' runat="server"
                                                                meta:resourcekey="lblBilledForResource2"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right" meta:resourcekey="TemplateFieldResource11">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblAmount" Text='<%# Eval("Amount") %>' runat="server" meta:resourcekey="lblAmountResource2"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Rate" HeaderText="Net Amount" meta:resourcekey="BoundFieldResource10" />
                                                    <asp:TemplateField HeaderText="PayType" ItemStyle-HorizontalAlign="Right" meta:resourcekey="TemplateFieldResource12">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPT" Text='<%# Eval("PayType") %>' runat="server" meta:resourcekey="lblPTResource2"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Reason" ItemStyle-HorizontalAlign="Right" Visible="false"
                                                        meta:resourcekey="TemplateFieldResource13">
                                                        <ItemTemplate>
                                                            <asp:DropDownList runat="server" ID="ddlReason" meta:resourcekey="ddlReasonResource1">
                                                            </asp:DropDownList>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center" Width="190px"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="IsParent" ItemStyle-HorizontalAlign="Right" 
                                                        Visible="false" meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblIsParent" Text='<%# Eval("IsCreditBill") %>' runat="server" 
                                                                meta:resourcekey="lblIsParentResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <HeaderStyle CssClass="colorforcontent" ForeColor="White" />
                                                <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Black" />
                                            </asp:GridView>
                                            <table class="w-100p"><tr><td> <asp:Label ID="lblVolumeDiscounts" 
                                                    Text="Volume Based Discounts" runat="server" Visible="False"  Font-Bold="True" 
                                                    meta:resourcekey="lblVolumeDiscountsResource1"></asp:Label></td></tr></table>
                                            <asp:GridView ID="GrdVolumebased" runat="server" CellPadding="1" CssClass="mytable1 gridView w-100p"
                                                AutoGenerateColumns="False" 
                                                onrowdatabound="GrdVolumebased_RowDataBound" 
                                                meta:resourcekey="GrdVolumebasedResource1" >
                                                
                                                <Columns>
                                                    <asp:BoundField DataField="RangeFrom" Visible="false" HeaderText="Range From" 
                                                        meta:resourcekey="BoundFieldResource2"  />
                                                    <asp:BoundField DataField="RangeTo" HeaderText="Range To" Visible="false" 
                                                        meta:resourcekey="BoundFieldResource3"  /> 
                                                    <asp:TemplateField HeaderText="Investigation Name" 
                                                        ItemStyle-HorizontalAlign="Right" meta:resourcekey="TemplateFieldResource3">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblInvName" Text='<%# Eval("InvName") %>' runat="server" 
                                                                meta:resourcekey="lblInvNameResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField>  
                                                     <asp:TemplateField HeaderText="FeeType" ItemStyle-HorizontalAlign="Right" 
                                                        meta:resourcekey="TemplateFieldResource4">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFeetype" Text='<%# Eval("FeeType") %>' runat="server" 
                                                                meta:resourcekey="lblFeetypeResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField>  
                                                     <asp:TemplateField HeaderText="Test Count(s)" 
                                                        ItemStyle-HorizontalAlign="Right" meta:resourcekey="TemplateFieldResource5">
                                                        <ItemTemplate>
                                                        <asp:TextBox ID="labelcount" Text='<%# Eval("labelcount") %>' runat="server" 
                                                                ReadOnly="True" CssClass="AlgRgh" meta:resourcekey="labelcountResource1"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right" 
                                                        meta:resourcekey="TemplateFieldResource6">
                                                        <ItemTemplate>
                                                        <asp:TextBox ID="lblCAmount" Text='<%# Eval("Amount") %>' runat="server" 
                                                                ReadOnly="True" CssClass="AlgRgh" meta:resourcekey="lblCAmountResource1"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField> 
                                                    <asp:BoundField DataField="VolDiscount" ItemStyle-HorizontalAlign="Center" 
                                                        HeaderText="Discount (%)" DataFormatString="{0:0}" Visible="false" 
                                                        meta:resourcekey="BoundFieldResource4" >
<ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Discount (%)" ItemStyle-HorizontalAlign="Right" 
                                                        Visible="true" meta:resourcekey="TemplateFieldResource14" >
                                                        <ItemTemplate>
                                                         <asp:TextBox ID="lblvoldis" Text='<%# Eval("VolDiscount","{0:n0}") %>' 
                                                                runat="server" ReadOnly="True" CssClass="AlgRgh" 
                                                                meta:resourcekey="lblvoldisResource1"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField> 
                                                    <asp:BoundField DataField="TotalDiscounts" ItemStyle-HorizontalAlign="Right" 
                                                        HeaderText="Total Discounts"  DataFormatString="{0:0.00}" Visible="false" 
                                                        meta:resourcekey="BoundFieldResource5" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Total Discounts" 
                                                        ItemStyle-HorizontalAlign="Right" Visible="true" 
                                                        meta:resourcekey="TemplateFieldResource15">
                                                        <ItemTemplate>
                                                         <asp:TextBox ID="lbltotAmount" Text='<%# Eval("TotalDiscounts","{0:n2}") %>' 
                                                                runat="server" ReadOnly="True" CssClass="AlgRgh" 
                                                                meta:resourcekey="lbltotAmountResource1"  ></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField>  
                                                    <asp:TemplateField HeaderText="Amount" Visible="false" 
                                                        meta:resourcekey="TemplateFieldResource16" >                                                   
                                                    <FooterTemplate>
                                                    <asp:Label ID="lblTotal" runat="server" meta:resourcekey="lblTotalResource1" />
                                                    </FooterTemplate>
                                                    </asp:TemplateField>
                                                                                 
                                                </Columns>
                                                <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <HeaderStyle CssClass="colorforcontent" ForeColor="White" />
                                                <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Black" />
                                            </asp:GridView>
                                             
                                             <table class="w-100p"><tr><td> <asp:Label ID="lblCrDB" 
                                                     Text="Credit Debit Summary Details" runat="server" Visible="False"  
                                                     Font-Bold="True" meta:resourcekey="lblCrDBResource1"></asp:Label></td></tr></table>
                                              <asp:GridView ID="GrdCreditDebit" runat="server" CssClass="mytable1 gridView w-100p"
                                                AutoGenerateColumns="False" 
                                                onrowdatabound="GrdCreditDebit_RowDataBound" 
                                                meta:resourcekey="GrdCreditDebitResource1">
                                                
                                                <Columns>
                                                 <asp:TemplateField HeaderText="SummaryID" ItemStyle-HorizontalAlign="Right" 
                                                        Visible="false" meta:resourcekey="TemplateFieldResource17">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSummaryID" Text='<%# Eval("SummaryID") %>' runat="server" 
                                                                meta:resourcekey="lblSummaryIDResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="BillDate" SortExpression="Date" meta:resourcekey="TemplateFieldResource18"  
                                                        >
                                                        <ItemTemplate>
                                                          <asp:Label ID="lblCrDrDate" Text='<%# Eval("CrDrDate") %>' runat="server" 
                                                                meta:resourcekey="lblCrDrDateResource1"></asp:Label>
                                                        </ItemTemplate>
                                                      
                                                    </asp:TemplateField>
                                                 <asp:TemplateField HeaderText="Bill No" ItemStyle-HorizontalAlign="Right" 
                                                        meta:resourcekey="TemplateFieldResource19">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblReferenceID" Text='<%# Eval("ReferenceID") %>' runat="server" 
                                                                meta:resourcekey="lblReferenceIDResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    
                                                      <asp:TemplateField HeaderText="ReferenceType" 
                                                        ItemStyle-HorizontalAlign="Right" meta:resourcekey="TemplateFieldResource20">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblReferenceType" Text='<%# Eval("ReferenceType") %>' 
                                                                runat="server" meta:resourcekey="lblReferenceTypeResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    
                                                    <asp:TemplateField HeaderText="Receipt No" ItemStyle-HorizontalAlign="Right" 
                                                        meta:resourcekey="TemplateFieldResource21">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblReceiptNo" Text='<%# Eval("ReceiptNo") %>' runat="server" 
                                                                meta:resourcekey="lblReceiptNoResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField>  
                                                     <asp:TemplateField HeaderText="ClientId" ItemStyle-HorizontalAlign="Right" 
                                                        Visible="false" meta:resourcekey="TemplateFieldResource22">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblClientId" Text='<%# Eval("ClientId") %>' runat="server" 
                                                                meta:resourcekey="lblClientIdResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField>  
                                                     <asp:TemplateField HeaderText="ClientName" ItemStyle-HorizontalAlign="Right" 
                                                        Visible="false" meta:resourcekey="TemplateFieldResource23">
                                                        <ItemTemplate>
                                                        <asp:Label ID="lablClientName" Text='<%# Eval("ClientName") %>' runat="server" 
                                                                meta:resourcekey="lablClientNameResource1"></asp:Label>
                                                         
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    
                                                    <asp:TemplateField HeaderText="Item Type" ItemStyle-HorizontalAlign="Right" 
                                                        Visible="true" meta:resourcekey="TemplateFieldResource24" >
                                                        <ItemTemplate>
                                                         <asp:Label ID="lblItemType" Text='<%# Eval("ItemType") %>' runat="server" 
                                                                meta:resourcekey="lblItemTypeResource1"></asp:Label>
                                                       
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField>
                                                   
                                                     <asp:TemplateField HeaderText="Authorized By" ItemStyle-HorizontalAlign="Right" 
                                                        Visible="true" meta:resourcekey="TemplateFieldResource25" >
                                                        <ItemTemplate>
                                                         <asp:Label ID="lblvoldis" Text='<%# Eval("Authorizedby") %>' runat="server" 
                                                                meta:resourcekey="lblvoldisResource2"></asp:Label>
                                                       
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField> 
                                                    <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right" 
                                                        meta:resourcekey="TemplateFieldResource26">
                                                        <ItemTemplate>
                                                        <asp:Label ID="lblAmount" Text='<%# Eval("Amount") %>' runat="server" 
                                                                ReadOnly="true" CssClass="AlgRgh" meta:resourcekey="lblAmountResource1"></asp:Label>
                                                        
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField> 
                                                   
                                                   
                                                    
                                                    <asp:TemplateField HeaderText="Reason" ItemStyle-HorizontalAlign="Right" 
                                                        Visible="true" meta:resourcekey="TemplateFieldResource27">
                                                        <ItemTemplate>
                                                         <asp:Label ID="lblReason" Text='<%# Eval("Reason") %>' runat="server" 
                                                                meta:resourcekey="lblReasonResource1"></asp:Label>
                                                          
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                    </asp:TemplateField>  
                                                    <%--<asp:TemplateField HeaderText="Amount" Visible="false" >                                                   
                                                    <FooterTemplate>
                                                    <asp:Label ID="lblTotal" runat="server" />
                                                    </FooterTemplate>
                                                    </asp:TemplateField>--%>
                                                                                 
                                                </Columns>
                                                <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <HeaderStyle CssClass="colorforcontent" ForeColor="White" />
                                                <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Black" />
                                            </asp:GridView>
                                        </div>
                                        <asp:HiddenField ID="hfScrollPosition" runat="server" Value="0" />
                                    </div>
                                </td>
                            </tr>
                            <tr id="trAmtDetails" runat="server" style="display: table-row;">
                                <td class="paddingT10">
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                            </td>
                                            <td class="a-right" class="w-84p">
                                                &nbsp;
                                            </td>
                                            <td class="w-8p a-right" nowrap="nowrap">
                                                <asp:Label ID="lblGross" runat="server" Text="Gross Bill Amount" class="defaultfontcolor"
                                                    meta:resourcekey="lblGrossResource2" />
                                            </td>
                                            <td class="details_value a-right w-15p">
                                                <asp:HiddenField ID="hdnGross" runat="server" />
                                                <asp:TextBox ID="txtGross" runat="server" Text="0.00" CssClass="textBoxRightAlign"
                                                    onKeyPress="javascript: return false;" onKeyDown="javascript: return false;"
                                                    onPaste="javascript: return false;" meta:resourcekey="txtGrossResource2"></asp:TextBox>
                                                <input type="hidden" runat="server" id="hdnStdDedID" value="0" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td class="a-right">
                                                <asp:Label ID="lblDiscountAmt" runat="server" Text="Discount:" meta:resourcekey="lblDiscountAmtResource2" />
                                            </td>
                                            <td class="a-right" valign="bottom">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:DropDownList ID="ddDiscountPercent" ToolTip="Select the Discount" onChange="javascript:setDiscount();"
                                                                runat="server" meta:resourcekey="ddDiscountPercentResource2">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblDis" runat="server" Font-Bold="True" 
                                                                meta:resourcekey="lblDisResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td class="a-right">
                                                <asp:TextBox ID="txtDiscountAmt" runat="server" Text="0.00" onblur="CalCulateAmtvalue();"
                                                       onkeypress="return ValidateOnlyNumeric(this);"   CssClass="textBoxRightAlign" meta:resourcekey="txtDiscountAmtResource2" />
                                            </td>
                                        </tr>
                                        <tr id="trDiscountReason" runat="server" style="display: none;">
                                            <td>
                                            </td>
                                            <td class="a-right">
                                                <asp:Label ID="lblDiscountReason" runat="server" Text="DiscountReason:" meta:resourcekey="lblDiscountReasonResource2" />
                                            </td>
                                            <td class="a-left">
                                                <asp:DropDownList ID="DdlDiscountreason" runat="server" onchange="GetDiscountReasonlist()"
                                                    meta:resourcekey="DdlDiscountreasonResource2">
                                                </asp:DropDownList>
                                            </td>
                                            <td class="a-right">
                                                <asp:TextBox ID="txtDisCountReason" runat="server" CssClass="textBoxRightAlign" meta:resourcekey="txtDisCountReasonResource2" />
                                            </td>
                                        </tr>
                                        <tr>
                                                        <td>
                                                        </td>
                                                        <td class="a-right">
                                                            <asp:Label ID="lblInvoiceType" runat="server" Text="InvoiceType:" 
                                                                meta:resourcekey="lblInvoiceTypeResource1" />
                                                        </td>
                                                        <td class="a-right">
                                                            <asp:DropDownList ID="ddlInvoiceType" runat="server" 
                                                                meta:resourcekey="ddlInvoiceTypeResource1">
                                                            </asp:DropDownList>
                                                            &nbsp;
                                                        </td>
                                            <td class="a-right" colspan="2">
                                                <div id="divGenerateTax" runat="server" class="a-right">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                </td>
                                            <td class="a-right">
                                               </td>
                                            <td class="a-right v-middle" nowrap="nowrap">
                                                <asp:Label ID="lblVolumeDiscount" runat="server" class="defaultfontcolor" 
                                                     Text="VOD" meta:resourcekey="lblVolumeDiscountResource1" />
                                                     <asp:Label ID="lblVolDPer" runat="server" class="defaultfontcolor" 
                                                    meta:resourcekey="lblVolDPerResource1" />
                                            </td>
                                            <td class="a-right">
                                            <asp:TextBox ID="txtVolumeAmount" runat="server" Text="0.00" CssClass="textBoxRightAlign"
                                                    onKeyPress="javascript: return false;" onKeyDown="javascript: return false;"
                                                    onPaste="javascript: return false;" 
                                                    meta:resourcekey="txtVolumeAmountResource1"  />
                                                </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                            <td class="a-right" nowrap="nowrap">
                                                <asp:Label ID="lblTOD" runat="server" Text="TOD" class="defaultfontcolor" meta:resourcekey="lblTODResource2"></asp:Label>
                                                &nbsp;
                                                <asp:Label ID="LblTODPer" runat="server" class="defaultfontcolor" Font-Bold="True"
                                                    ForeColor="Black" meta:resourcekey="LblTODPerResource2"></asp:Label>
                                            </td>
                                            <td class="a-right">
                                                <asp:TextBox ID="txtTOD" runat="server" CssClass="textBoxRightAlign" onKeyPress="javascript: return false;"
                                                    onKeyDown="javascript: return false;" onPaste="javascript: return false;" meta:resourcekey="txtTODResource2"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td class="a-right">
                                                &nbsp;
                                            </td>
                                            <td class="a-right">
                                                <asp:Label ID="lblNetAmt" runat="server" Text="Net Total Amount" class="defaultfontcolor"
                                                    meta:resourcekey="lblNetAmtResource2" />
                                            </td>
                                            <td class="a-right">
                                                <asp:TextBox ID="txtNetAmt" runat="server" Text="0.00" CssClass="textBoxRightAlign"
                                                    onKeyPress="javascript: return false;" onKeyDown="javascript: return false;"
                                                    onPaste="javascript: return false;" meta:resourcekey="txtNetAmtResource2" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" align="right">
                                                <asp:Button ID="btnGenerateTask" runat="server" Text="Generate Task" CssClass="btn"
                                                    OnClick="btnGenerateTask_Click" OnClientClick="javascript:return Checktxtbox()"
                                                    meta:resourcekey="btnGenerateTaskResource2" />
                                                <asp:Button ID="btnGenerateInvoice" CssClass="btn" runat="server" Text="Generate Invoice"
                                                    OnClientClick="javascript:return Checktxtbox()" OnClick="btnGenerateInvoice_Click"
                                                    meta:resourcekey="btnGenerateInvoiceResource2" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnCancel" CssClass="btn" OnClick="btnCancel_Click" runat="server"
                                                    Text="Cancel" meta:resourcekey="btnCancelResource2" />
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:HiddenField ID="hdnTODdetails" runat="server" />
                                   
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none"
                                                            meta:resourcekey="hiddenTargetControlForModalPopupResource2" />
                                                        <ajc:ModalPopupExtender ID="rptMdlPopup" runat="server" PopupControlID="pnlAttrib"
                                                            TargetControlID="hiddenTargetControlForModalPopup" BackgroundCssClass="modalBackground"
                                                            CancelControlID="btnCnl" DynamicServicePath="" Enabled="True">
                                                        </ajc:ModalPopupExtender>
                                                        <asp:Panel ID="pnlAttrib" BorderWidth="1px" Height="95%" CssClass="modalPopup dataheaderPopup w-77p"
                                                            runat="server" meta:resourcekey="pnlAttribResource2">
                                                            <table class="w-100p" style="height: 100%">
                                                                <tr>
                                                                    <td class="v-top">
                                                                        <rsweb:ReportViewer ID="rReportViewer" runat="server" ProcessingMode="Remote" Font-Names="Verdana"
                                                                            Font-Size="8pt" meta:resourcekey="rReportViewerResource2" WaitMessageFont-Names="Verdana"
                                                                            WaitMessageFont-Size="14pt">
                                                                            <ServerReport ReportServerUrl="" />
                                                                        </rsweb:ReportViewer>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-center">
                                                                        <asp:Button ID="btnCnl" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                            onmouseout="this.className='btn'" OnClientClick="PopupClose()"
                                                                            meta:resourcekey="btnCnlResource2" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </table>
                                       
                                </td>
                            </tr>
                              <asp:HiddenField ID="hdnMessages" runat="server" Value="false" />
                            <asp:HiddenField ID="hdnShowReport" runat="server" Value="false" />
                            <asp:HiddenField ID="hdnchkAll" runat="server" />
                            <asp:HiddenField ID="hdnChkValue" runat="server" />
                            <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnGrsAmt" runat="server" />
                            <asp:HiddenField ID="hdndiscountreason" runat="server" />
                            <asp:HiddenField ID="hdnDisResCode" Value="0" runat="server" />
                            <asp:HiddenField ID="hdnApprovedByID" Value="0" runat="server" />
                            <asp:HiddenField ID="hdnInvID" Value="0" runat="server" />
                            <asp:HiddenField ID="hdnApproval" runat="server" />
                            <asp:HiddenField ID="hdnStatus" Value="0" runat="server" />
                            <asp:HiddenField ID="hdnClientTax" runat="server" />
                            <asp:HiddenField ID="hdnDiscount" runat="server" />
                            <asp:HiddenField ID="hdnDisPer" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnInvoiceDiscount" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnTovamout" runat="server" Value="0" />
                              <asp:HiddenField ID="hdnDebitAmt" runat="server" />
                              <asp:HiddenField ID="hdnIsWaters" runat="server" Value="" />
                        </table>
                         </ContentTemplate>
                                    </asp:UpdatePanel>
                                    </div>
                    </div>
     <Attune:Attunefooter ID="Attunefooter" runat="server" />          
    <asp:Button ID="btnmsgpopup" runat="server" Style="display: none" 
        meta:resourcekey="btnmsgpopupResource1" />
    <ajc:ModalPopupExtender ID="ModalPopupExtender2" runat="server" TargetControlID="btnmsgpopup"
        PopupControlID="pnlOthers" BackgroundCssClass="modalBackground" />
    <asp:Panel ID="pnlOthers" runat="server" Style="display: none; width: 250px" 
        CssClass="modalPopup dataheaderPopup" meta:resourcekey="pnlOthersResource1">
        <center>
            <table id="tblDiagnosisItems" runat="server" class="w-100p">
                <tr>
                    <td class="a-center">
                        <asp:Label ID="lblmsgs" runat="server" Text="Task Generated Successfully" Font-Bold="True"
                            Font-Size="Medium" meta:resourcekey="lblmsgsResource1"></asp:Label>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td class="a-center">
                        <asp:Button ID="btnpopClose" OnClick="btnpopClose_Click" runat="server" class="btn"
                            Text="Ok" meta:resourcekey="btnpopCloseResource1"/>
                    </td>
                </tr>
            </table>
        </center>
    </asp:Panel>
<%--
    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>--%>

    </form>
</body>
</html>
