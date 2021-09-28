<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DCSearch.aspx.cs" Inherits="InventorySales_DCSearch" meta:resourcekey="PageResource2" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>DC Search</title>
<script type="text/javascript" language="javascript">
    var ErrorMsg = SListForAppMsg.Get('InventorySales_DCSearch_aspx_01') != null ? SListForAppMsg.Get('InventorySales_DCSearch_aspx_01') : "Error";
    var ConfirmMsg = SListForAppMsg.Get('InventorySales_DCSearch_aspx_02') != null ? SListForAppMsg.Get('InventorySales_DCSearch_aspx_02') : "Confirm"
    var okMsg = SListForAppMsg.Get('InventorySales_DCSearch_aspx_03') != null ? SListForAppMsg.Get('InventorySales_DCSearch_aspx_03') : "Ok";
    var CancelMsg = SListForAppMsg.Get('InventorySales_DCSearch_aspx_04') != null ? SListForAppMsg.Get('InventorySales_DCSearch_aspx_04') : "Cancel";
</script>
    <script language="javascript" type="text/javascript">
        var datadiv_tooltip = false;
        var datadiv_tooltipShadow = false;
        var datadiv_shadowSize = 4;
        var datadiv_tooltipMaxWidth = 200;
        var datadiv_tooltipMinWidth = 100;
        var datadiv_iframe = false;
        var tooltip_is_msie = (navigator.userAgent.indexOf('MSIE') >= 0 && navigator.userAgent.indexOf('opera') == -1 && document.all) ? true : false;
        function showTooltip(e, tooltipTxt) {

            var bodyWidth = Math.max(document.body.clientWidth, document.documentElement.clientWidth) - 20;

            if (!datadiv_tooltip) {
                datadiv_tooltip = document.createElement('DIV');
                datadiv_tooltip.id = 'datadiv_tooltip';
                datadiv_tooltipShadow = document.createElement('DIV');
                datadiv_tooltipShadow.id = 'datadiv_tooltipShadow';

                document.body.appendChild(datadiv_tooltip);
                document.body.appendChild(datadiv_tooltipShadow);

                if (tooltip_is_msie) {
                    datadiv_iframe = document.createElement('IFRAME');
                    datadiv_iframe.frameborder = '5';
                    datadiv_iframe.removeClass().addClass('cust1backgrnd7');
                    datadiv_iframe.src = '#';
                    datadiv_iframe.style.zIndex = 100;
                    datadiv_iframe.style.position = 'absolute';
                    document.body.appendChild(datadiv_iframe);
                }

            }

            datadiv_tooltip.removeClass().addClass('show');
            datadiv_tooltipShadow.removeClass().addClass('show');
            if (tooltip_is_msie) datadiv_iframe.style.display = 'block';

            var st = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
            if (navigator.userAgent.toLowerCase().indexOf('safari') >= 0) st = 0;
            var leftPos = e.clientX + 10;

            datadiv_tooltip.style.width = null; // Reset style width if it's set 
            datadiv_tooltip.innerHTML = tooltipTxt;
            datadiv_tooltip.style.left = leftPos + 'px';
            datadiv_tooltip.style.top = e.clientY + 10 + st + 'px';


            datadiv_tooltipShadow.style.left = leftPos + datadiv_shadowSize + 'px';
            datadiv_tooltipShadow.style.top = e.clientY + 10 + st + datadiv_shadowSize + 'px';

            if (datadiv_tooltip.offsetWidth > datadiv_tooltipMaxWidth) {	/* Exceeding max width of tooltip ? */
                datadiv_tooltip.style.width = datadiv_tooltipMaxWidth + 'px';
            }

            var tooltipWidth = datadiv_tooltip.offsetWidth;
            if (tooltipWidth < datadiv_tooltipMinWidth) tooltipWidth = datadiv_tooltipMinWidth;


            datadiv_tooltip.style.width = tooltipWidth + 'px';
            datadiv_tooltipShadow.style.width = datadiv_tooltip.offsetWidth + 'px';
            datadiv_tooltipShadow.style.height = datadiv_tooltip.offsetHeight + 'px';

            if ((leftPos + tooltipWidth) > bodyWidth) {
                datadiv_tooltip.style.left = (datadiv_tooltipShadow.style.left.replace('px', '') - ((leftPos + tooltipWidth) - bodyWidth)) + 'px';
                datadiv_tooltipShadow.style.left = (datadiv_tooltipShadow.style.left.replace('px', '') - ((leftPos + tooltipWidth) - bodyWidth) + datadiv_shadowSize) + 'px';
            }

            if (tooltip_is_msie) {
                datadiv_iframe.style.left = datadiv_tooltip.style.left;
                datadiv_iframe.style.top = datadiv_tooltip.style.top;
                datadiv_iframe.style.width = datadiv_tooltip.offsetWidth + 'px';
                datadiv_iframe.style.height = datadiv_tooltip.offsetHeight + 'px';

            }

        }

        function hideTooltip() {
            datadiv_tooltip.removeClass().addClass('hide');
            datadiv_tooltipShadow.removeClass().addClass('hide');
            if (tooltip_is_msie) datadiv_iframe.style.display = 'none';
        }

        function ValidateDate() {
            var userMsg = SListForAppMsg.Get('InventorySales_DCSearch_aspx_05') != null ? SListForAppMsg.Get('InventorySales_DCSearch_aspx_05') : "Select from date and to date";
            if (document.getElementById('txtFrom').value == '') {
                ValidationWindow(userMsg, ErrorMsg);
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {
            ValidationWindow(userMsg, ErrorMsg);
                return false;

            }
            else {
                return CheckFromToDate('txtFrom', 'txtTo');
            }
        }

        function validate1() {
                 var userMsg = SListForAppMsg.Get('InventorySales_DCSearch_aspx_06') != null ? SListForAppMsg.Get('InventorySales_DCSearch_aspx_06') : "Please Select CustomerName"; 
                if (document.getElementById('ddlCustomerName').options[document.getElementById('ddlCustomerName').selectedIndex].value == "0") {
                ValidationWindow(userMsg,ErrorMsg);
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
        function CallPrint() {
            var prtContent = document.getElementById('divPrintarea');

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false;
        }
        function SelectAll(ID, Value) {
            document.getElementById(ID).checked = Value;
        }
//        function SelectINVRowCommon(rid, Dcno, sid, sofid) {
//            document.getElementById('hdnsalesorderID').value += sid + '^';
//            document.getElementById('hdntemp').value += Dcno + '~' + sid + '~' + sofid + '^';
//            document.getElementById('tdgo').style.display = 'block';
        //        }
        function SelectINVRowCommon(rid, Dcno, sid, sofid, status) {
            document.getElementById('hdnStatus').value = status;
            document.getElementById('hdnsalesorderID').value += sid + '^';
            document.getElementById('hdntemp').value += Dcno + '~' + sid + '~' + sofid + '^';
            //document.getElementById('tdgo').style.display = 'block';
            $('#tdgo').removeClass().addClass('show');
        }
        function orderValidation() {
            //  setvalues();

            if (document.getElementById('dList').options[document.getElementById('dList').selectedIndex].text != "" || document.getElementById('dList').options[document.getElementById('dList').selectedIndex].text != null) {
                var pType = document.getElementById('dList').options[document.getElementById('dList').selectedIndex].text;
            }
            var sts = document.getElementById('hdnStatus').value;

            if (pType == 'Generate Invoice') {
                if (sts == 'Issued Invoice') {
                 var userMsg = SListForAppMsg.Get('InventorySales_DCSearch_aspx_07') != null ? SListForAppMsg.Get('InventorySales_DCSearch_aspx_07') : "This Order already in Issued status !!"; 
                     ValidationWindow(userMsg,ErrorMsg);
                    return false;
                }
                return true;
            }
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
                    <div class="contentdata1">
                       
                        <table class="w-100p table">
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="paddingB10">
                                    <table class="w-100p" class="dataheader2 defaultfontcolor border1 custcellpadding custcellspacing1" >
                                        <tr>
                                            <td class="h-10">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-right w-15p" >
                                                <asp:Label runat="server" ID="fromDate" Text="From" meta:resourcekey="fromDateResource"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtFrom" runat="server" Width="130px" TabIndex="1" MaxLength="1"
                                                    ValidationGroup="MKE" CssClass="datePicker" meta:resourcekey="txtFromResource1"/>
                                                
                                            </td>
                                            <td class="a-right w-15p" >
                                                <asp:Label runat="server" ID="toDate" Text="To" meta:resourcekey="fromDateResource"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtTo" runat="server" TabIndex="2" MaxLength="1"
                                                    ValidationGroup="MKE" CssClass="datePicker w-130 custtxtalign" meta:resourcekey="txtToResource1"/>
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-right w-15p" >
                                             <asp:Label runat="server" ID="lblCustomerName" Text="Customer Name" meta:resourcekey="lblCustomerNameResource"></asp:Label>                                               
                                            </td>
                                            <td class="w-20p">
                                                <asp:DropDownList ID="ddlCustomerName" Width="150px" runat="server" CssClass="ddlsmall w-150" meta:resourcekey="ddlCustomerNameResource1">
                                                </asp:DropDownList>
                                                &nbsp;<img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                                            </td>
                                            <td class="a-right w-15p">
                                             <asp:Label runat="server" ID="lblStatus" Text="Status" meta:resourcekey="lblStatusResource"></asp:Label>                                               
                                            </td>
                                            <td class="w-30p">
                                                <asp:DropDownList ID="ddlStatus" Width="150px" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlStatusResource1">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-right w-15p" >
                                             <asp:Label runat="server" ID="lblSales" Text="Sales Order No" meta:resourcekey="lblSalesResource1"></asp:Label>                                                
                                            </td>
                                            <td class="w-20p">
                                                <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtNumber" runat="server" CssClass="Txtboxsmall w-150" meta:resourcekey="txtNumberResource1"></asp:TextBox>
                                                  <ajc:AutoCompleteExtender ID="AutoCompleteSearchNo" runat="server" CompletionInterval="1"
                                                UseContextKey="true" BehaviorID="AutoCompleteSearch" CompletionListCssClass="wordWheel listMain box"
                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListItemCssClass="listitemtwo"
                                                EnableCaching="false" FirstRowSelected="true" MinimumPrefixLength="1" ServiceMethod="GetDetailsSearchNo"
                                                ServicePath="~/InventoryCommon/Webservice/InventoryWebService.asmx" TargetControlID="txtNumber">
                                            </ajc:AutoCompleteExtender>
                                            &nbsp;<img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                                            <img src="../PlatForm/images/starbutton.png" alt="" class="a-center" />
                                            </td>
                                            <td class="a-right w-15p hide" >
                                             <asp:Label runat="server" ID="lblSupplier" Text="Supplier Name" meta:resourcekey="lblSupplierResource1"></asp:Label>                                                
                                            </td>
                                            <td class="hide" >
                                                <asp:DropDownList ID="ddlSupplierList" runat="server" CssClass="ddlsmall w-150" meta:resourcekey="ddlSupplierListResource1">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-right w-15p">
                                             <asp:Label runat="server" ID="lblDCNo" Text="DC No" meta:resourcekey="lblDCNoResource1"></asp:Label>                                                
                                            </td>
                                            <td class="w-30p">
                                                <asp:TextBox onKeyPress="return ValidateSpecialAndNumeric(this);" ID="txtDcNo" runat="server" CssClass="Txtboxsmall w-150" autocomplete="off" meta:resourcekey="txtDcNoResource1"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionInterval="1"
                                                    UseContextKey="true" BehaviorID="AutoCompleteSearch" CompletionListCssClass="wordWheel listMain box"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListItemCssClass="listitemtwo"
                                                    EnableCaching="false" FirstRowSelected="true" MinimumPrefixLength="1" ServiceMethod="GetDetailsSearchNo"
                                                    ServicePath="~/InventorySales/WebService/InventorySalesService.asmx" TargetControlID="txtDcNo">
                                                </ajc:AutoCompleteExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="a-center paddingB10">
                                                <asp:Button ID="btnSearch" OnClientClick="return validate1();" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                                    onmouseout="this.className='btn'" OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource" />
                                                &nbsp;
                                                <asp:Button ID="btnCancel" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                                    onmouseout="this.className='btn'" onclick="btnCancel_Click1" meta:resourcekey="btnCancelResource"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:UpdateProgress ID="Progressbar" runat="server">
                                                    <ProgressTemplate>
                                                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/PlatForm/images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                        <asp:Label runat="server" ID="toDate" Text="To" meta:resourcekey="fromDateResource">
                                                </asp:Label>
                                                 <asp:Label runat="server" ID="lblPlease" Text="Please wait...." meta:resourcekey="lblPleasewaitResource"> </asp:Label>
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
                                    <table  class="w-100p table">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblResult" ForeColor="#000333" runat="server" 
                                                    meta:resourcekey="lblResultResource"></asp:Label></td></tr></table><table  class="w-100p table">
                                        <tr>
                                            <td>
                                                <asp:GridView ID="grdResult" class="w-100p custcellpadding" runat="server" AllowPaging="True"
                                                    AutoGenerateColumns="False" CssClass="mytable1"
                                                    OnRowDataBound="grdResult_RowDataBound" 
                                                    meta:resourcekey="grdResultResource2"><HeaderStyle CssClass="dataheader1" />
                                                    <PagerStyle CssClass="dataheader1" />
                                                    <Columns>
                                                        <asp:BoundField Visible="false" DataField="StockOutFlowID" HeaderText="Order No" meta:resourcekey="BoundField10Resource1"/>
                                                        <asp:TemplateField 
                                                            ItemStyle-Width="2%"  HeaderStyle-HorizontalAlign="Left" 
                                                            meta:resourcekey="TemplateFieldResource2"><%-- <HeaderTemplate>
                                                                <input id='chkBox1' name='chkAll' type='checkbox'>
                                                            </HeaderTemplate>--%>
                                                            <ItemTemplate>
                                                           <asp:CheckBox ID="chkBox" runat="server" 
                                                                    meta:resourcekey="chkBoxResource2" /></ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>

<ItemStyle CssClass="w-2p"></ItemStyle>
</asp:TemplateField>
                                                        <asp:BoundField DataField="PrescriptionNO" HeaderText="Order No" HeaderStyle-HorizontalAlign="left"
                                                            ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Left" 
                                                            meta:resourcekey="BoundField1Resource"><HeaderStyle HorizontalAlign="Left"></HeaderStyle>

<ItemStyle HorizontalAlign="Left" CssClass="w-15p"></ItemStyle>
</asp:BoundField><asp:BoundField DataField="Name" HeaderText="Customer Name" HeaderStyle-HorizontalAlign="Left"
                                                            ItemStyle-Width="20%" meta:resourcekey="BoundField2Resource" ><HeaderStyle HorizontalAlign="Left"></HeaderStyle>

<ItemStyle CssClass="w-20p"></ItemStyle>
</asp:BoundField><%--     <asp:BoundField DataField="SupplierName" HeaderText="Supplier Name" HeaderStyle-HorizontalAlign="left"
                                                            ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Left" />--%>
                                                        <asp:BoundField 
                                                            DataField="ProductName" Visible="true" HeaderText="Status" ItemStyle-Width="12%"
                                                            ItemStyle-HorizontalAlign="Center"  meta:resourcekey="BoundField3Resource"><ItemStyle HorizontalAlign="Center" CssClass="w-12p"></ItemStyle>
</asp:BoundField><%--<asp:BoundField DataField="SupplierName" Visible="true" HeaderText="Vendor" ItemStyle-Width="30%"
                                                            ItemStyle-HorizontalAlign="Center" />--%>
                                                        <asp:BoundField 
                                                            DataField="InvoiceNo" HeaderText="Invoice No" HeaderStyle-HorizontalAlign="left"
                                                            ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Left" 
                                                            meta:resourcekey="BoundField4Resource"><HeaderStyle HorizontalAlign="Left"></HeaderStyle>

<ItemStyle HorizontalAlign="Left" CssClass="w-15p"></ItemStyle>
</asp:BoundField><asp:BoundField DataField="DCNo" HeaderText="DC No" HeaderStyle-HorizontalAlign="left"
                                                            ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Left" 
                                                            meta:resourcekey="BoundField5Resource" ><HeaderStyle HorizontalAlign="Left"></HeaderStyle>

<ItemStyle HorizontalAlign="Left" CssClass="w-15p"></ItemStyle>
</asp:BoundField></Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                    <table  class="w-100p table">
                                        <tr>
                                            <td class="h-20">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="tdgo" runat="server" style="display: none;" class="defaultfontcolor ">
                                            <asp:Label ID="lblMsg" Text="Select a Record and perform one of the following" runat="server" meta:resourcekey="lblMsgResource1"></asp:Label><asp:DropDownList ID="dList" runat="server" CssClass="ddlsmall" meta:resourcekey="dListResource1">
                                                </asp:DropDownList>
                                                <asp:Button ID="bGo" runat="server" Text="Go" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" OnClick="bGo_Click" OnClientClick="Javascript:return orderValidation();" meta:resourcekey="bGoResource"/>
                                            </td>
                                        </tr>
                                    </table>
                                    <input type="hidden" id="hdnSupplierID" runat="server" />
                                    <input type="hidden" id="pid" runat="server" />
                                    <input type="hidden" id="hdnStatus" runat="server" />
                                    <input type="hidden" id="status" runat="server" />
                                    <input type="hidden" id="hdnStatusId" runat="server" />
                                    <input type="hidden" id="Bid" runat="server" />
                                    <input type="hidden" id="hdntemp" runat="server" />
                                    <input type="hidden" id="hdnsalesorderID" runat="server" />
                                    <asp:HiddenField 
                                        ID="hdnStatusCollection" runat="server" /><input type="hidden" id="Hidden1" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </div>
     <Attune:Attunefooter ID="Attunefooter" runat="server" />          
    </form>
</body>
</html>
