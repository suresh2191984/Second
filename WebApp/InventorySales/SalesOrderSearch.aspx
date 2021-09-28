<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SalesOrderSearch.aspx.cs"
    Inherits="InventorySales_SalesOrderSearch" EnableEventValidation="false" meta:resourcekey="PageResource1"  %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="../PlatForm/StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />

    <link href="../PlatForm/StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../PlatForm/Scripts/bid.js" type="text/javascript"></script>

    <script src="../PlatForm/Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function doBindStockStatus() {
            var flag = true;
            var HidValue = document.getElementById('hdnStatusCollection').value;
            var selSearchType = document.getElementById('ddlSearchType').value.split('~')[0];
            var list = HidValue.split('^');
            var ddlStat = document.getElementById('ddlStatus');
            ddlStat.options.length = 0;
            if (HidValue != "") {

                for (var count = 0; count < list.length; count++) {

                    var statusCh = list[count].split('~');

                    if (selSearchType == statusCh[2]) {
                        if (flag == true) {
                            var opt1 = document.createElement("option");
                            document.getElementById('ddlStatus').options.add(opt1);
                            opt1.text = '--Select One--';
                            opt1.value = 0;
                            flag = false;
                        }
                        var opt = document.createElement("option");
                        document.getElementById('ddlStatus').options.add(opt);
                        opt.text = statusCh[1];
                        opt.value = statusCh[0];
                    }
                }
            }
            if (selSearchType == "0") {
                ddlStat.options.length = 0;
                var opt1 = document.createElement("option");
                document.getElementById('ddlStatus').options.add(opt1);
                opt1.text = '--Select One--';
                opt1.value = 0;
            }
            if (document.getElementById('hdnStatusId').value.trim() != "") {
                document.getElementById('ddlStatus').value = document.getElementById('hdnStatusId').value;
                document.getElementById('hdnStatusId').value = "";
            }
            else {
                document.getElementById('ddlStatus').selectedIndex = 0;
            }
        }

        function SelectINVRowCommon(rid, ID, status, CID, SalesOrderID, SOFD, SupplierID, InvoiceNo) {
            chosen = "";

            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
            document.getElementById('hdnID').value = ID;
            document.getElementById('status').value = status;
            //document.getElementById('tdgo').style.display = 'block';
            $('#tdgo').removeClass().addClass('show');
            document.getElementById('hdnCID').value = CID;
            document.getElementById('hdnSalesOrderID').value = SalesOrderID;
            document.getElementById('hdnSOFD').value = SOFD;
            document.getElementById('hdnSupplierID').value = SupplierID;
            document.getElementById('hdninvoiceno').value = InvoiceNo;
        }

        function setvalues() {
            document.getElementById('hdnStatusId').value = document.getElementById('ddlStatus').value;

        }

        function orderValidation() {
            var userMsg;
            setvalues();
            if (document.getElementById('hdnID').value == '') {
                userMsg = SListForAppMsg.Get("InventorySales_SalesOrderSearch_aspx_01") == null ? "Please Select an Order" : SListForAppMsg.Get("InventorySales_SalesOrderSearch_aspx_01");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            if (document.getElementById('hdnCID').value == '') {
                userMsg = SListForAppMsg.Get("InventorySales_SalesOrderSearch_aspx_02") == null ? "Please Select Customer" : SListForAppMsg.Get("InventorySales_SalesOrderSearch_aspx_02");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            if (document.getElementById('dList').options[document.getElementById('dList').selectedIndex].text != "" || document.getElementById('dList').options[document.getElementById('dList').selectedIndex].text != null) {
                var pType = document.getElementById('dList').options[document.getElementById('dList').selectedIndex].text;
            }
            var sts = document.getElementById('status').value;

            if (pType == 'Copy PO') {
                if (sts == 'Inprogress' || sts == 'Pending') {
                    userMsg = SListForAppMsg.Get("InventorySales_SalesOrderSearch_aspx_03") == null ? "This Order already in '" + sts + "' status." : SListForAppMsg.Get("InventorySales_SalesOrderSearch_aspx_03");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
                return true;
            }
            if (pType == 'Cancel Order') {
                if (sts == 'Cancelled' || sts == 'Received' || sts == 'Inprogress') {
                    userMsg = SListForAppMsg.Get("InventorySales_SalesOrderSearch_aspx_03") == null ? "This Order already in '" + sts + "' status." : SListForAppMsg.Get("InventorySales_SalesOrderSearch_aspx_03");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
                return true;
            }
            if (pType == 'Approve Order') {

                if (sts == 'Cancelled' || sts == 'Received' || sts == 'Inprogress' || sts == 'Approved' || sts == 'Partial') {
                    userMsg = SListForAppMsg.Get("InventorySales_SalesOrderSearch_aspx_03") == null ? "This Order already in '" + sts + "' status." : SListForAppMsg.Get("InventorySales_SalesOrderSearch_aspx_03");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
                return true;
            }
            if (pType == 'Sales Order Issue') {

                if (sts == 'Booking') {
                    userMsg = SListForAppMsg.Get("InventorySales_SalesOrderSearch_aspx_04") == null ? "Cannot Issue this Sales Order" : SListForAppMsg.Get("InventorySales_SalesOrderSearch_aspx_04");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
                return true;
            }
        }
        function validate1() {
            setvalues();
            if (document.getElementById('ddlSearchType').options[document.getElementById('ddlSearchType').selectedIndex].value == "0") {
                var userMsg = SListForAppMsg.Get("InventorySales_SalesOrderSearch_aspx_05") == null ? "Please Select SearchType" : SListForAppMsg.Get("InventorySales_SalesOrderSearch_aspx_05");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlSearchType').focus();
                return false;
            }
            if (document.getElementById('ddlCustomerName').options[document.getElementById('ddlCustomerName').selectedIndex].value == "0") {
                userMsg = SListForAppMsg.Get("InventorySales_SalesOrderSearch_aspx_06") == null ? "Please Select CustomerName" : SListForAppMsg.Get("InventorySales_SalesOrderSearch_aspx_06");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlCustomerName').focus();
                return false;
            }
            //            if (
            //            document.getElementById('ddlSupplierList').options[document.getElementById('ddlSupplierList').selectedIndex].value == "0") {
            //                alert("Please Select Supplier");
            //                document.getElementById('ddlSupplierList').focus();
            //                return false;
            //            }
            return true;
        }
    
    
    </script>

</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        <Services>
            <asp:ServiceReference Path="~/InventorySales/WebService/InventorySalesService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p table">
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="paddingB10">
                    <table class="w-100p border1 custcellpadding custcellspacing1 dataheader2 defaultfontcolor" >
                        <tr>
                            <td class="h-10">
                            </td>
                        </tr>
                        <tr>
                            <td class="a-right w-15p">
                                
                                <asp:Label ID="lblSearchType" runat="server" Text="Search Type" meta:resourcekey="lblSearchTypeResource1" />
                            </td>
                            <td class="w-20p">
                                <asp:DropDownList ID="ddlSearchType" onchange="javascript:doBindStockStatus();"
                                    runat="server" CssClass="ddlsmall w-150" meta:resourcekey="ddlSearchTypeResource1">
                                </asp:DropDownList>
                                &nbsp;<img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                            </td>
                        </tr>
                        <tr>
                            <td class="a-right w-15p">
                                
                                <asp:Label ID="lblCustomerName" runat="server" Text="Customer Name" meta:resourcekey="lblCustomerNameResource1" />
                            </td>
                            <td class="w-20p">
                                <asp:DropDownList ID="ddlCustomerName" runat="server" CssClass="ddlsmall w-150"
                                    meta:resourcekey="ddlCustomerNameResource1">
                                </asp:DropDownList>
                                &nbsp;<img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                            </td>
                            <td class="a-right w-15p">
                                
                                <asp:Label ID="lblStatus" runat="server" Text="Status" meta:resourcekey="lblStatusResource1" />
                            </td>
                            <td class="w-30p">
                                <asp:DropDownList ID="ddlStatus" onchange="setvalues()" runat="server"
                                    CssClass="ddlsmall w-150" meta:resourcekey="ddlStatusResource1">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-right w-15p">
                                
                                <asp:Label ID="lblSearchNo" runat="server" Text="Search No" meta:resourcekey="lblSearchNoResource1" />
                            </td>
                            <td class="w-20p">
                                <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtNumber" runat="server" CssClass="Txtboxsmall w-150" autocomplete="off"
                                    meta:resourcekey="txtNumberResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteSearchNo" runat="server" CompletionInterval="1"
                                    UseContextKey="True" BehaviorID="AutoCompleteSearch" CompletionListCssClass="wordWheel listMain box"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListItemCssClass="listitemtwo"
                                    EnableCaching="False" FirstRowSelected="True" MinimumPrefixLength="1" ServiceMethod="GetDetailsSearchNo"
                                    ServicePath="~/InventorySales/WebService/InventorySalesService.asmx" TargetControlID="txtNumber"
                                    DelimiterCharacters="" Enabled="True">
                                </ajc:AutoCompleteExtender>
                                &nbsp;<img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                                <img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                            </td>
                            <td class="a-right w-15p">
                                
                                <asp:Label ID="lblSupplierName" runat="server" Text="Supplier Name" meta:resourcekey="lblSupplierNameResource1" />
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlSupplierList" runat="server" CssClass="ddlsmall w-150"
                                    meta:resourcekey="ddlSupplierListResource1">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-right w-15p">
                                
                                <asp:Label ID="lblDate" runat="server" Text="Date" meta:resourcekey="lblDateResource1" />
                            </td>
                            <td class="w-30p">
                                <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtOrderDate" ReadOnly="true" runat="server" CssClass="datePicker w-150"
                                    meta:resourcekey="txtOrderDateResource1"></asp:TextBox>
                               
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" class="h-44 a-center paddingB10">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClientClick="return validate1();"
                                    CssClass="btn" onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn'"
                                    OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                                &nbsp;
                                <asp:Button ID="btnCancel" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                    onmouseout="this.className='btn'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:UpdateProgress ID="Progressbar" runat="server">
                                    <ProgressTemplate>
                                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/PlatForm/images/working.gif"
                                            meta:resourcekey="imgProgressbarResource1" />
                                        Please wait....
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" class="a-center">
                                <div id="divTable" runat="server" visible="false">
                                </div>
                            </td>
                        </tr>
                    </table>
                    <table class="w-100p custcellspacing1 border1 custcellpadding4">
                        <tr>
                            <td>
                                <asp:Label ID="lblResult" ForeColor="#000333" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <table class="w-100p table">
                        <tr>
                            <td>
                                <asp:GridView ID="grdResult" class="w-100p custcellpadding" runat="server" AllowPaging="True"
                                    AutoGenerateColumns="False" OnRowDataBound="grdResult_RowDataBound" OnPageIndexChanging="grdResult_PageIndexChanging"
                                    CssClass="mytable1" OnRowCreated="grdResult_OnRowCreated" meta:resourcekey="grdResultResource1">
                                    <HeaderStyle CssClass="dataheader1" />
                                    <PagerStyle CssClass="dataheader1" />
                                    <Columns>
                                        <asp:BoundField Visible="false" DataField="ID" HeaderText="Order No" meta:resourcekey="BoundFieldResource1" />
                                        <asp:TemplateField ItemStyle-Width="2%" HeaderText="Select" HeaderStyle-HorizontalAlign="Left"
                                            meta:resourcekey="TemplateFieldResource1">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="OrderSelect"
                                                    meta:resourcekey="rdSelResource1" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                            <ItemStyle CssClass="w-2p"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="PrescriptionNO" HeaderText="Order No" HeaderStyle-HorizontalAlign="left"
                                            ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource2">
                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Left" CssClass="w-15p"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Order Date" meta:resourceKey="BoundFieldResource3">
                                            <ItemTemplate>
                                                <span>
                                                    <%#((DateTime)DataBinder.Eval(Container.DataItem, "Manufacture")).ToString(DateTimeFormat)%>
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--  <asp:BoundField DataField="Manufacture" HeaderText="Order Date" DataFormatString="{0:dd/MM/yyyy}"
                                            ItemStyle-Width="12%" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                            meta:resourcekey="BoundFieldResource3">
                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Left" CssClass="w-12p"></ItemStyle>
                                        </asp:BoundField>--%>
                                        <asp:TemplateField HeaderText="ValidTo" meta:resourceKey="BoundFieldResource4">
                                            <ItemTemplate>
                                                <span>
                                                    <%#((DateTime)DataBinder.Eval(Container.DataItem, "expiryDate")).ToString(DateTimeFormat)%>
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--<asp:BoundField DataField="expiryDate" Visible="false" HeaderText="ValidTo" ItemStyle-Width="12%"
                                            HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource4">
                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Left" CssClass="w-12p"></ItemStyle>
                                        </asp:BoundField>--%>
                                        <asp:BoundField DataField="RakNo" Visible="true" HeaderText="Status" ItemStyle-Width="12%"
                                            ItemStyle-HorizontalAlign="Center" meta:resourcekey="BoundFieldResource5">
                                            <ItemStyle HorizontalAlign="Center" CssClass="w-12p"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Name" Visible="true" HeaderText="Customer Name" ItemStyle-Width="30%"
                                            ItemStyle-HorizontalAlign="Center" meta:resourcekey="BoundFieldResource6">
                                            <ItemStyle HorizontalAlign="Center" CssClass="w-30p"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="description" Visible="false" HeaderText="Comments" ItemStyle-Width="12%"
                                            HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" meta:resourcekey="BoundFieldResource7">
                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Left" CssClass="w-12p"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="InvoiceNo" HeaderText="Invoice No" HeaderStyle-HorizontalAlign="left"
                                            ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource8">
                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Left" CssClass="w-15p"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DCNo" HeaderText="DC No" HeaderStyle-HorizontalAlign="left"
                                            ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource9">
                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Left" CssClass="w-15p"></ItemStyle>
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                    <table class="w-100p table">
                        <tr>
                            <td class="h-20">
                            </td>
                        </tr>
                        <tr>
                            <td id="tdgo" runat="server" class="defaultfontcolor hide">
                                
                                <asp:Label ID="lblRecordSelect" runat="server" Text="Select a Record and perform one of the following" meta:resourcekey="lblRecordSelectResource1" />
                                <asp:DropDownList ID="dList" runat="server" CssClass="ddlsmall" meta:resourcekey="dListResource1">
                                </asp:DropDownList>
                                <asp:Button ID="bGo" runat="server" Text="Go" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClick="bGo_Click" OnClientClick="javascript:return orderValidation();"
                                    meta:resourcekey="bGoResource1" />
                            </td>
                        </tr>
                    </table>
                    <input type="hidden" id="hdnSupplierID" runat="server" />
                    <input type="hidden" id="pid" runat="server" />
                    <input type="hidden" id="hdnStatus" runat="server" />
                    <input type="hidden" id="status" runat="server" />
                    <input type="hidden" id="hdnStatusId" runat="server" />
                    <input type="hidden" id="Bid" runat="server" />
                    <asp:HiddenField ID="hdnStatusCollection" runat="server" />
                    <input type="hidden" id="hdnSalesOrderID" runat="server" />
                    <input type="hidden" id="hdnSID" runat="server" />
                    <input type="hidden" id="hdnSOFD" runat="server" />
                    <input type="hidden" id="hdnCID" runat="server" />
                    <input type="hidden" id="hdnID" runat="server" />
                    <input type="hidden" id="hdninvoiceno" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>

<script language="javascript" type="text/javascript">

    //    function doBindStockStatus() {
    //        //debugger;
    //        var flag = true;
    //        var HidValue = document.getElementById('hdnStatusCollection').value;
    //        var selSearchType = document.getElementById('ddlSearchType').value.split('~')[0];
    //        var list = HidValue.split('^');
    //        var ddlStat = document.getElementById('ddlStatus');
    //        ddlStat.options.length = 0;
    //        if (HidValue != "") {

    //            for (var count = 0; count < list.length; count++) {

    //                var statusCh = list[count].split('~');

    //                if (selSearchType == statusCh[2]) {
    //                    if (flag == true) {
    //                        var opt1 = document.createElement("option");
    //                        document.getElementById('ddlStatus').options.add(opt1);
    //                        opt1.text = '--Select One--';
    //                        opt1.value = 0;
    //                        flag = false;
    //                    }
    //                    var opt = document.createElement("option");
    //                    document.getElementById('ddlStatus').options.add(opt);
    //                    opt.text = statusCh[1];
    //                    opt.value = statusCh[0];
    //                }
    //            }
    //        }
    //        if (selSearchType == "0") {
    //            ddlStat.options.length = 0;
    //            var opt1 = document.createElement("option");
    //            document.getElementById('ddlStatus').options.add(opt1);
    //            opt1.text = '--Select One--';
    //            opt1.value = 0;
    //        }
    //        if (document.getElementById('hdnStatusId').value.trim() != "") {
    //            document.getElementById('ddlStatus').value = document.getElementById('hdnStatusId').value;
    //            document.getElementById('hdnStatusId').value = "";
    //        }
    //        else {
    //            document.getElementById('ddlStatus').selectedIndex = 0;
    //        }
    //    }
    //    
    
</script>

