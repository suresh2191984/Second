<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InventorySearch.ascx.cs"
    Inherits="InventoryCommon_Controls_InventorySearch" %>
<%--<link rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/style.css" />--%>

<%-- <asp:ScriptManager ID="ScriptManager1" runat="server">
           <Services>
            <asp:ServiceReference Path="~/InventoryWebService.asmx" />
             </Services>
      </asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">--%>

<script language="javascript" type="text/javascript">
    function SelectINVRowCommon(rid, patid, status, Bid, SupplierID, statusID, OrderNo) {
        chosen = "";
        document.getElementById('uctlInventorySearch_hdnSupplierID').value = SupplierID + "~" + patid;
        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        document.getElementById(rid).checked = true;
        document.getElementById('<%= pid.ClientID %>').value = patid;
        document.getElementById('<%= PurchaseorderNO.ClientID %>').value = OrderNo;
        document.getElementById('<%= status.ClientID %>').value = status;
        //document.getElementById('<%= tdgo.ClientID %>').style.display = 'table-cell';
        $('#<%= tdgo.ClientID %>').removeClass().addClass('displaytd w-100p a-center');
        document.getElementById('<%= Bid.ClientID %>').value = Bid;
        document.getElementById('<%= statusID.ClientID %>').value = statusID;
    }

    function setvalues() {
        document.getElementById('<%= hdnStatusId.ClientID %>').value = document.getElementById('<%= ddlStatus.ClientID %>').value;
    }
    function setvalues1() {
        document.getElementById('<%= hdnStatusId.ClientID %>').value = document.getElementById('<%= ddlStatus.ClientID %>').value;
        var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
        if ($('#<%= ddlSearchType.ClientID %>').val() == '0' || $('#<%= ddlSearchType.ClientID %>').val() == '') {
            var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_InventorySearch_ascx_01') != null ? SListForAppMsg.Get('InventoryCommon_Controls_InventorySearch_ascx_01') : "Please Select The Search Type";
            //var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
        if (document.getElementById('<%= txtOrderDate.ClientID %>').value == '') {
            var userMsg = SListForAppMsg.Get("InventoryCommon_Controls_InventorySearch_ascx_05") == null ? "Select From Date" : SListForAppMsg.Get("InventoryCommon_Controls_InventorySearch_ascx_05");
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
        else if (document.getElementById('<%= txtOrdertodate.ClientID %>').value == '') {
        var userMsg = SListForAppMsg.Get("InventoryCommon_Controls_InventorySearch_ascx_08") == null ? "Select To Date" : SListForAppMsg.Get("InventoryCommon_Controls_InventorySearch_ascx_08");
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
        else {
            DateFrom = document.getElementById('<%= txtOrderDate.ClientID %>').value;
            DateTo = document.getElementById('<%= txtOrdertodate.ClientID %>').value;
            if (CheckFromToDate(DateFrom, DateTo)) {
                return true;
            }
            else {
                var userMsg = SListForAppMsg.Get("InventoryCommon_Controls_InventorySearch_ascx_07") == null ? "Select Valid From and to Date" : SListForAppMsg.Get("InventoryCommon_Controls_InventorySearch_ascx_07");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
        }
    }


    function orderValidation() {
        setvalues();
        if (document.getElementById('<%= pid.ClientID %>').value == '') {
            var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_InventorySearch_ascx_02') != null ? SListForAppMsg.Get('InventoryCommon_Controls_InventorySearch_ascx_02') : "Please Select an Order";
            var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
        if (document.getElementById('<%= dList.ClientID %>').options[document.getElementById('<%= dList.ClientID %>').selectedIndex].text != "" || document.getElementById('<%= dList.ClientID %>').options[document.getElementById('<%= dList.ClientID %>').selectedIndex].text != null) {
            var pType = document.getElementById('<%= dList.ClientID %>').options[document.getElementById('<%= dList.ClientID %>').selectedIndex].text;
        }
        var sts = document.getElementById('<%= status.ClientID %>').value;

         var CopyPO = SListForAppDisplay.Get('InventoryCommon_Controls_InventorySearch_ascx_01');
         if (CopyPO == null) {
             CopyPO = 'Copy PO';
        }

        var CancelOrder = SListForAppDisplay.Get('InventoryCommon_Controls_InventorySearch_ascx_02');
        if (CancelOrder == null) {
            CancelOrder = 'Cancel Order';
        }

        var ApproveOrder = SListForAppDisplay.Get('InventoryCommon_Controls_InventorySearch_ascx_03');
        if (ApproveOrder == null) {
            ApproveOrder = 'Approve Order';
        }

        var Inprogress = SListForAppDisplay.Get('InventoryCommon_Controls_InventorySearch_ascx_04');
        if (Inprogress == null) {
            Inprogress = 'Inprogress';
        }

        var Pending = SListForAppDisplay.Get('InventoryCommon_Controls_InventorySearch_ascx_05');
        if (Pending == null) {
            Pending = 'Pending';
        }

        var Cancelled = SListForAppDisplay.Get('InventoryCommon_Controls_InventorySearch_ascx_06');
        if (Cancelled == null) {
            Cancelled = 'Cancelled';
        }

        var Received = SListForAppDisplay.Get('InventoryCommon_Controls_InventorySearch_ascx_07');
        if (Received == null) {
            Received = 'Received';
        }

        var Approved = SListForAppDisplay.Get('InventoryCommon_Controls_InventorySearch_ascx_08');
        if (Approved == null) {
            Approved = 'Approved';
        }

        var Partial = SListForAppDisplay.Get('InventoryCommon_Controls_InventorySearch_ascx_09');
        if (Partial == null) {
            Partial = 'Partial';
        }

        var ApproveQuotation = SListForAppDisplay.Get('InventoryCommon_Controls_InventorySearch_ascx_17') == null ? "Approve Quotation" : SListForAppDisplay.Get('InventoryCommon_Controls_InventorySearch_ascx_17');
        

        if (pType == CopyPO) {
            if (sts == Inprogress || sts == Pending) {
                var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_InventorySearch_ascx_03') != null ? SListForAppMsg.Get('InventoryCommon_Controls_InventorySearch_ascx_03') : "This Order already in '" + sts + "' status.";
                var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
                if (SListForAppMsg.Get('InventoryCommon_Controls_InventorySearch_ascx_03') != null) {
                    userMsg = userMsg.replace('{0}', sts);
                }
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            return true;
        }
        if (pType == CancelOrder) {
            if (sts == Cancelled || sts == Received || sts == Inprogress) {
                var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_InventorySearch_ascx_03') != null ? SListForAppMsg.Get('InventoryCommon_Controls_InventorySearch_ascx_03') : "This Order already in '" + sts + "' status.";
                var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
                if (SListForAppMsg.Get('InventoryCommon_Controls_InventorySearch_ascx_03') != null) {
                    userMsg = userMsg.replace('{0}', sts);
                }
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            return true;
        }

        if (pType == ApproveOrder) {
            if (sts == Cancelled || sts == Received || sts == Inprogress || sts == Approved || sts == Partial) {
                if (document.getElementById('uctlInventorySearch_ddlSearchType').options[document.getElementById('uctlInventorySearch_ddlSearchType').selectedIndex].text != 'Quotation') {
                    var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_InventorySearch_ascx_03') != null ? SListForAppMsg.Get('InventoryCommon_Controls_InventorySearch_ascx_03') : "This Order already in '" + sts + "' status.";
                    var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
                    if (SListForAppMsg.Get('InventoryCommon_Controls_InventorySearch_ascx_03') != null) {
                        userMsg = userMsg.replace('{0}', sts);
                    }
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
            }            
            return true;
        }
        if (pType == ApproveQuotation) {
            if (sts == Cancelled || sts == Approved || sts == Rejected) {
                if (document.getElementById('uctlInventorySearch_ddlSearchType').options[document.getElementById('uctlInventorySearch_ddlSearchType').selectedIndex].text == 'Quotation') {
                    var userMsg = SListForAppMsg.Get('InventoryCommon_Controls_InventorySearch_ascx_03') != null ? SListForAppMsg.Get('InventoryCommon_Controls_InventorySearch_ascx_03') : "This Order already in '" + sts + "' status.";
                    var errorMsg = SListForAppMsg.Get('InventoryCommon_Error') != null ? SListForAppMsg.Get('InventoryCommon_Error') : "Alert";
                    if (SListForAppMsg.Get('InventoryCommon_Controls_InventorySearch_ascx_03') != null) {
                        userMsg = userMsg.replace('{0}', sts);
                    }
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
            }
            return true;
        }
    }
            
   
</script>

<script type="text/javascript">

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
                datadiv_iframe.style.backgroundColor = '#FFFFFF';
                datadiv_iframe.src = '#';
                datadiv_iframe.style.zIndex = 100;
                datadiv_iframe.style.position = 'absolute';
                document.body.appendChild(datadiv_iframe);
            }

        }

        //datadiv_tooltip.style.display = 'block';
        //datadiv_tooltipShadow.style.display = 'block';
        $('#' + datadiv_tooltip).removeClass().addClass('show');
        $('#' + datadiv_tooltipShadow).removeClass().addClass('show');
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
        //datadiv_tooltip.style.display = 'none';
        //datadiv_tooltipShadow.style.display = 'none';
        $('#' + datadiv_tooltip).removeClass().addClass('hide');
        $('#' + datadiv_tooltipShadow).removeClass().addClass('hide');
        if (tooltip_is_msie) datadiv_iframe.style.display = 'none';
    }

            
</script>

<asp:UpdatePanel ID="UpdatePanel2" runat="server">
    <ContentTemplate>
        <asp:Panel ID="pnlPSearch" runat="server" DefaultButton="btnSearch">
            <table class="w-100p" >
                <tr class="lh30">
                    <td class="w-13p" >
                        <asp:Label ID="lblsearchtyp" runat="server" Text="Search Type" meta:resourcekey="lblsearchtypResource1" ></asp:Label>
                    </td>
                    <td class="w-22p" >
                        <asp:DropDownList ID="ddlSearchType" onchange="javascript:doBindStockStatus(); $find('AutoCompleteSearch').set_contextKey(this.value);"
                            CssClass="small" runat="server" meta:resourcekey="ddlSearchTypeResource1">
                        </asp:DropDownList>
                        &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="v-middle" />
                    </td>
                    <td class="w-13p" >
                        <asp:Label ID="lb1searchno" runat="server" Text="Search No" meta:resourcekey="lb1searchnoResource1" ></asp:Label>
                    </td>
                    <td class="w-22p" >
                        <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtNumber"  runat="server" CssClass="small" autocomplete="on" meta:resourcekey="txtNumberResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteSearchNo" runat="server" CompletionInterval="1"
                            UseContextKey="true" BehaviorID="AutoCompleteSearch" CompletionListCssClass="wordWheel listMain box"
                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListItemCssClass="listitemtwo"
                            EnableCaching="false" FirstRowSelected="true" MinimumPrefixLength="1" ServiceMethod="GetDetailsSearchNo"
                            ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx" TargetControlID="txtNumber">
                        </ajc:AutoCompleteExtender>
                        &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" class="v-middle" />
                        <img src="../PlatForm/Images/starbutton.png" alt="" class="v-middle" />
                    </td>
                    <td class="w-8p " >
                        <asp:Label ID="lblstat" runat="server" Text="Status" meta:resourcekey="lblstatResource1" ></asp:Label>
                    </td>
                    <td  >
                        <asp:DropDownList ID="ddlStatus" onchange="setvalues()" CssClass="small" runat="server" >
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr class="lh30">
                    <td >
                        <asp:Label ID="lb1dt" runat="server" Text="Date" meta:resourcekey="lb1dtResource1" ></asp:Label>
                    </td>
                    <td >
                        <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtOrderDate" runat="server" CssClass="small datePicker" meta:resourcekey="txtOrderDateResource1"></asp:TextBox>
                        <%--<asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/PlatForm/images/Calendar_scheduleHS.png"
                            CausesValidation="False" />
                        <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtOrderDate"
                            Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                            OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                            ErrorTooltipEnabled="True" />
                        <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                            ControlToValidate="txtOrderDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                            ValidationGroup="MKE" />
                        <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtOrderDate"
                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc" />
                 --%>   </td>
                 <td>
                 <asp:Label ID="lbltodate" runat="server" Text="To Date"  meta:resourcekey="lbltodateResource1"></asp:Label>
                 </td>
                 <td><asp:TextBox ID="txtOrdertodate" runat="server" CssClass="small datePicker" ></asp:TextBox></td>
                    <td >
                        <asp:Label ID="lblsuppliername" runat="server" Text="Supplier Name" meta:resourcekey="lblsuppliernameResource1" ></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlSupplierList" CssClass="small" runat="server" meta:resourcekey="ddlSupplierListResource1">
                        </asp:DropDownList>
                    </td>
                    </tr>
                    <tr>
                    <td></td>
                    <td colspan="2"  class="a-left " >
                        <asp:Button ID="btnSearch" OnClientClick="javascript:return setvalues1();" runat="server" Text="Search"
                            CssClass="btn" OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                        &nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Reset" CssClass="cancel-btn" 
                         OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                    </td>
                    <td>
                        <asp:CheckBox ID="chkSetDefault" runat="server" Text="Set Default" meta:resourcekey="chkSetDefaultResource1" />&nbsp;&nbsp;&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdateProgress ID="Progressbar" runat="server">
                            <ProgressTemplate>
                                <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/PlatForm/Images/working.gif"  meta:resourcekey="imgProgressbarResource1"  />
                      <asp:Label ID="lblplswait" runat="server" Text="Please wait...." meta:resourcekey="lblplswaitResource1" ></asp:Label>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
                <tr>
                    <td colspan="6" class="a-center">
                        <div id="divTable" runat="server" visible="false">
                        </div>
                    </td>
                </tr>
            </table>
            <table class="w-100p" >
                <tr>
                    <td>
                        <asp:Label ID="lblResult" ForeColor="#333" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            <table class="w-100p" >
                <tr>
                    <td>
                        <asp:GridView ID="grdResult" runat="server" AllowPaging="True"
                            AutoGenerateColumns="False" OnRowDataBound="grdResult_RowDataBound" OnPageIndexChanging="grdResult_PageIndexChanging"
                            PageSize="10" GridLines="Both" CssClass="gridView w-100p" OnRowCreated="grdResult_OnRowCreated">
                            <HeaderStyle CssClass="gridHeader" />
                            <PagerStyle CssClass="gridPager" />
                            <Columns>
                                <asp:BoundField Visible="false" DataField="OrderId" HeaderText="Order No" meta:resourcekey="BoundFieldResource1" />
                                <asp:TemplateField ItemStyle-Width="2%" HeaderText="Select" HeaderStyle-HorizontalAlign="Left"
                                    meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="OrderSelect" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="OrderNo" HeaderText="Order No" HeaderStyle-HorizontalAlign="left"
                                    ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource2" />
                                <%-- <asp:BoundField DataField="OrderDate" HeaderText="Date" DataFormatString="{0:D}"
                                    ItemStyle-Width="12%" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                    meta:resourcekey="BoundFieldResource3" />--%>
                                <asp:TemplateField HeaderText="Date" meta:resourcekey="BoundFieldResource3">
                                    <ItemTemplate>
                                        <span>
                                            <%#((DateTime)DataBinder.Eval(Container.DataItem, "OrderDate")).ToString(DateFormat)%></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:BoundField DataField="ApprovedAt" Visible="false" HeaderText="ValidTo" ItemStyle-Width="12%"
                                    HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource4" />
                              --%>
                                <asp:TemplateField HeaderText="ApprovedAt" Visible="false" meta:resourcekey="BoundFieldResource4">
                                    <ItemTemplate>
                                        <span>
                                            <%#((DateTime)DataBinder.Eval(Container.DataItem, "ApprovedAt")).ToString(DateTimeFormat)%></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Status" Visible="true" HeaderText="Status" ItemStyle-Width="12%"
                                    ItemStyle-HorizontalAlign="Center" meta:resourcekey="BoundFieldResource5" />
                                <%--New Column included in the grid view   --%>
                                <asp:BoundField DataField="SupplierName" Visible="true" HeaderText="Vendor" ItemStyle-Width="30%"
                                    ItemStyle-HorizontalAlign="Center" meta:resourcekey="BoundFieldResource6" />
                                <asp:BoundField DataField="Comments" Visible="true" HeaderText="Comments" ItemStyle-Width="12%"
                                    HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left" meta:resourcekey="BoundFieldResource7" />
                                <asp:BoundField DataField="InvoiceNo" HeaderText="Invoice No" HeaderStyle-HorizontalAlign="left"
                                    ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource8" />
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>
            <table class="w-100p">
                <tr>
                    <td id="tdgo" runat="server"  class="a-center hide" >
                        <asp:Label ID="lblselectrecd" runat="server" meta:resourcekey="lblselectrecdResource1" Text="Select a Record and perform one of the following"></asp:Label>
                        <asp:DropDownList ID="dList" runat="server" meta:resourcekey="dListResource1">
                        </asp:DropDownList>
                        <asp:Button ID="bGo" runat="server" Text="Go" OnClick="bGo_Click" CssClass="btn"
                            OnClientClick="javascript:return orderValidation();" meta:resourcekey="bGoResource1"  />
                    </td>
                </tr>
            </table>
            <input type="hidden" id="hdnSupplierID" runat="server" />
            <input type="hidden" id="pid" runat="server" />
            <input type="hidden" id="hdnStatus" runat="server" />
            <input type="hidden" id="status" runat="server" />
            <input type="hidden" id="hdnStatusId" runat="server" />
               <input type="hidden" id="statusID" runat="server" />  
                  <input type="hidden" id="TaskStatusId" runat="server" />  
                  <input type="hidden" id="PurchaseorderNO" runat="server" />
            <input type="hidden" id="Bid" runat="server" />
            <asp:HiddenField ID="hdnStatusCollection" runat="server" Value="" />
            <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
        </asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>

<script language="javascript" type="text/javascript">

    function doBindStockStatus() {

        var flag = true;
        var HidValue = document.getElementById('<%= hdnStatusCollection.ClientID %>').value;
        var selSearchType = document.getElementById('<%= ddlSearchType.ClientID %>').value.split('~')[0];
        var list = HidValue.split('^');
        var ddlStat = document.getElementById('<%= ddlStatus.ClientID %>');
        if ($('#<%= ddlSearchType.ClientID %>').val() == '0') {
            var Select = SListForAppDisplay.Get('InventoryCommon_Controls_InventorySearch_ascx_16');
            if (Select == null) {
                Select="--Select One--";
            }
            $('#uctlInventorySearch_ddlStatus').empty().append('<option value="0">Select</option>');
            return false;
        }
        ddlStat.options.length = 0;
        if (HidValue != "") {

            for (var count = 0; count < list.length; count++) {

                var statusCh = list[count].split('~');

                if (selSearchType == statusCh[2]) {
                    if (flag == true) {
                        var opt1 = document.createElement("option");
                        document.getElementById('<%= ddlStatus.ClientID %>').options.add(opt1);
                        var Select = SListForAppDisplay.Get('InventoryCommon_Controls_InventorySearch_ascx_16');
                        if (Select == null) {
                            Select = "--Select One--";
                        }
                        opt1.text = Select;
                        opt1.value = 0;
                        flag = false;
                    }
                    var opt = document.createElement("option");
                    document.getElementById('<%= ddlStatus.ClientID %>').options.add(opt);
                    opt.text = statusCh[1];
                    opt.value = statusCh[0];

                }
            }

        }
//        if (document.getElementById('<%= hdnStatusId.ClientID %>').value.trim() != "") {
//            $("[id$='ddlStatus']").each(function () {
//                if ($(this).val() == $('#<%= hdnStatusId.ClientID %>').val()) {
//                    $('#<%= ddlStatus.ClientID %>').val($('#<%= hdnStatusId.ClientID %>').val())
//                    $('#<%= hdnStatusId.ClientID %>').val('');
//                }
//                else {
//                    $('#<%= ddlStatus.ClientID %>').val(0);
//                }
//            });
//        } else {
//            $('#<%= ddlStatus.ClientID %>').val(0);
        //        }
        $("#<%= ddlStatus.ClientID %> option[value='"+$('#<%= hdnStatusId.ClientID %>').val()+"']").attr('selected', 'selected'); 
        recalldatepicker();
    }
</script>

<%--To Remove/Hide Columns in the Gried View--%>
<%--<style type="text/css">
    .hiddencol
    {
        display: none;
    }
    .viscol
    {
        display: block;
    }
</style>--%>
