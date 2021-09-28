<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PORequestSearch.aspx.cs"
    EnableEventValidation="false" Inherits="PORequest_PORequestSearch" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Purchase Order Request Search</title>

    <script src="../PlatForm/Scripts/dateTimePicker-UI.js" type="text/javascript"></script>

    

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <%--<Services>
            <asp:ServiceReference Path="~/InventoryWebService.asmx" />
        </Services>--%>
    </asp:ScriptManager>
    <attune:attuneheader id="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p searchPanel" >
            <tr class="lh30">
                <td>
                   <%=Resources.PORequest_ClientDisplay.PORequest_PORequestSearch_aspx_01%>
                </td>
                <td id="txtrustedorg">
                    <asp:DropDownList ID="ddlTrustedOrg" runat="server" CssClass="medium" 
                        OnChange="GetLocationlist()" meta:resourcekey="ddlTrustedOrgResource1">
                    </asp:DropDownList>
                </td>
                <td>
                   <%=Resources.PORequest_ClientDisplay.PORequest_PORequestSearch_aspx_02%>
                </td>
                <td id="txlocation">
                    <asp:DropDownList ID="ddlLocation" runat="server" CssClass="medium" onclick="return validateorg();"
                        onchange="return locationdetails();" 
                        meta:resourcekey="ddlLocationResource1">
                        <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="defaultfontcolor">
                    <asp:Label ID="lblFrom" Text="From Date" runat="server" 
                        meta:resourcekey="lblFromResource1"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtFrom" runat="server" onKeyPress="return ValidateSpecialAndNumeric(this);" CssClass="medium datePicker" TabIndex="3" 
                        meta:resourcekey="txtFromResource1"></asp:TextBox>
                   <%-- <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/PlatForm/images/Calendar_scheduleHS.png"
                        CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                    <ajc:maskededitextender id="MaskedEditExtender5" runat="server" targetcontrolid="txtFrom"
                        mask="99/99/9999" messagevalidatortip="true" onfocuscssclass="MaskedEditFocus"
                        oninvalidcssclass="MaskedEditError" masktype="Date" displaymoney="Left" acceptnegative="Left"
                        errortooltipenabled="True" />
                    <ajc:maskededitvalidator id="MaskedEditValidator5" runat="server" controlextender="MaskedEditExtender5"
                        controltovalidate="txtFrom" emptyvaluemessage="Date is required" invalidvaluemessage="Date is invalid"
                        display="Dynamic" tooltipmessage="(dd-mm-yyyy)" emptyvalueblurredtext="*" invalidvalueblurredmessage="*"
                        validationgroup="MKE" ErrorMessage="MaskedEditValidator5" 
                        meta:resourcekey="MaskedEditValidator5Resource1" />
                    <ajc:calendarextender id="CalendarExtender1" runat="server" targetcontrolid="txtFrom"
                        format="dd/MM/yyyy" popupbuttonid="ImgBntCalcFrom" />--%>
                </td>
            </tr>
            <tr class="lh30">
                <td class="defaultfontcolor">
                    <asp:Label ID="lblTo" Text="To Date" runat="server" 
                        meta:resourcekey="lblToResource1"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtTo" runat="server" onKeyPress="return ValidateSpecialAndNumeric(this);" CssClass="medium datePicker" TabIndex="4" 
                        meta:resourcekey="txtToResource1"></asp:TextBox>
                    <%--<asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/PlatForm/images/Calendar_scheduleHS.png"
                        CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                    <ajc:maskededitextender id="MaskedEditExtender1" runat="server" targetcontrolid="txtTo"
                        mask="99/99/9999" messagevalidatortip="true" onfocuscssclass="MaskedEditFocus"
                        oninvalidcssclass="MaskedEditError" masktype="Date" displaymoney="Left" acceptnegative="Left"
                        errortooltipenabled="True" />
                    <ajc:maskededitvalidator id="MaskedEditValidator1" runat="server" controlextender="MaskedEditExtender5"
                        controltovalidate="txtTo" emptyvaluemessage="Date is required" invalidvaluemessage="Date is invalid"
                        display="Dynamic" tooltipmessage="(dd-mm-yyyy)" emptyvalueblurredtext="*" invalidvalueblurredmessage="*"
                        validationgroup="MKE" ErrorMessage="MaskedEditValidator1" 
                        meta:resourcekey="MaskedEditValidator1Resource1" />
                    <ajc:calendarextender id="CalendarExtender2" runat="server" targetcontrolid="txtTo"
                        format="dd/MM/yyyy" popupbuttonid="ImgBntCalcTo" />--%>
                </td>
                <td>
                    <%=Resources.PORequest_ClientDisplay.PORequest_PORequestSearch_aspx_03%>
                </td>
                <td>
                    <asp:TextBox ID="txtPrno"  CssClass="medium" runat="server" onKeyPress="return ValidateMultiLangChar(this);" 
                        meta:resourcekey="txtPrnoResource1"></asp:TextBox>
                </td>
                <td id="Td1" visible="false">
                    <asp:DropDownList ID="ddlstatus" runat="server" CssClass="small" 
                        Visible="False" meta:resourcekey="ddlstatusResource1">
                        <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                        <asp:ListItem Text="Pending" Value="1" meta:resourcekey="ListItemResource3"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr class="lh30">
                <td class="a-center" colspan="6">
                    <asp:Button ID="btnsearch" runat="server" CssClass="btn" Text="Search" OnClientClick="return validations();"
                        OnClick="btnsearch_Click" meta:resourcekey="btnsearchResource1" />
                </td>
            </tr>
        </table>
        <table class="w-100p">
            <tr>
                <td>
                    <asp:GridView ID="grdResult" runat="server" AllowPaging="True"  AutoGenerateColumns="False"
                        OnPageIndexChanging="grdResult_PageIndexChanging"
                        CssClass="gridView w-100p" OnRowDataBound="grdResult_RowDataBound" 
                        meta:resourcekey="grdResultResource1">
                        <HeaderStyle CssClass="gridHeader" />
                        <PagerStyle CssClass="gridPager" />
                        <Columns>
                            <asp:BoundField Visible="false" DataField="PurchaseRequestID" 
                                HeaderText="Order No" meta:resourcekey="BoundFieldResource1" />
                            <asp:TemplateField ItemStyle-Width="2%" HeaderText="Select" 
                                HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkBox" runat="server" meta:resourcekey="chkBoxResource1" />
                                    <br />
                                    <asp:HiddenField ID="hdnvalue" runat="server" />
                                    <asp:HiddenField ID="hdnRequestID" runat="server" Value='<%#bind("PurchaseRequestID")%>' />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <%--     <asp:BoundField DataField="OrderNo" HeaderText="Order No" HeaderStyle-HorizontalAlign="left"
                                                ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Left" />--%>
                            <asp:TemplateField HeaderText="RequestNo" 
                                meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:Label ID="PurchaseRequestNo" runat="server" 
                                        Text='<%# Bind("PurchaseRequestNo") %>' 
                                        meta:resourcekey="PurchaseRequestNoResource1" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="RequestDate" HeaderText="Date" ItemStyle-Width="25%" HeaderStyle-HorizontalAlign="Left"
                                ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource2" >
                            </asp:BoundField>--%>
                            <asp:TemplateField HeaderText="Date" meta:resourcekey="BoundFieldResource2">
                                <ItemTemplate>
                                    <span>
                                        <%#((DateTime)DataBinder.Eval(Container.DataItem, "RequestDate")).ToString(DateTimeFormat)%></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Status" Visible="true" HeaderText="Status" ItemStyle-Width="12%"
                                ItemStyle-HorizontalAlign="Center" meta:resourcekey="BoundFieldResource3"/>
                            <%--New Column included in the grid view   --%>
                            <%--                    <asp:BoundField DataField="SupplierName" Visible="true" HeaderText="Vendor" ItemStyle-Width="12%"
                                                ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField DataField="Comments" Visible="true" HeaderText="Comments" HeaderStyle-HorizontalAlign="left"
                                                ItemStyle-HorizontalAlign="left" />
                                            <asp:BoundField DataField="InvoiceNo" HeaderText="Invoice No" HeaderStyle-HorizontalAlign="left"
                                                ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Left" />--%>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td id="tdgo" runat="server" class="defaultfontcolor">
                    <%=Resources.PORequest_ClientDisplay.PORequest_PORequestSearch_aspx_02%>
                    <asp:DropDownList ID="dList" runat="server" CssClass="medium" 
                        meta:resourcekey="dListResource1">
                    </asp:DropDownList>
                    <asp:Button ID="btngo" runat="server" Text="Go" OnClick="btngo_Click" CssClass="btn"
                        OnClientClick="javascript:return requestvalidation();"  meta:resourcekey="btngoResource1" />
                </td>
            </tr>
        </table>
    </div>
    <input type="hidden" id="hdnlocation" runat="server" />
    <asp:HiddenField ID="hdnpoids" runat="server" />
    <input type="hidden" id="hdntemp" runat="server" />
    <input type="hidden" id="hdnPRequestID" runat="server" />
    <input type="hidden" id="hdnSelectOrgid" runat="server" />
    <input type="hidden" id="hdnLocationID" runat="server" value="0" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    <attune:attunefooter id="Attunefooter" runat="server" />
    </form>
    
    <script type="text/javascript" language="javascript">
        var errorMsg = SListForAppMsg.Get("PORequest_Error") == null ? "Alert" : SListForAppMsg.Get("PORequest_Error");
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
			$(datadiv_tooltip).removeClass().addClass('show');
            //datadiv_tooltipShadow.style.display = 'block';
			$(datadiv_tooltipShadow).removeClass().addClass('show');
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
			$(datadiv_tooltip).removeClass().addClass('hide');
            //datadiv_tooltipShadow.style.display = 'none';
			$(datadiv_tooltipShadow).removeClass().addClass('hide');
            if (tooltip_is_msie) datadiv_iframe.style.display = 'none';
        }

        function locationdetails() {

            var Trustedorgid = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;
            if (Trustedorgid > 0) {

                document.getElementById('hdnSelectOrgid').value = Trustedorgid;
            }

            var locationid = document.getElementById('ddlLocation').options[document.getElementById('ddlLocation').selectedIndex].value;

            if (locationid > 0) {

                document.getElementById('hdnLocationID').value = locationid;
            }

        }
        function Setlocationdetails(obj) {
            document.getElementById('ddlLocation').value = obj;
        }
        function GetLocationlist() {
            var drploc = document.getElementById('ddlTrustedOrg').value;
            document.getElementById('hdnSelectOrgid').value = drploc;
            var options = document.getElementById('hdnlocation').value;
            var drpLocation = document.getElementById('ddlLocation');
            drpLocation.options.length = 1;

            var list = options.split('^');
            for (i = 0; i < list.length; i++) {
                if (list[i] != "") {
                    var res = list[i].split('~');
                    if (drploc == res[0]) {
                        var optn = document.createElement("option");
                        drpLocation.options.add(optn);
                        optn.text = res[2];
                        optn.value = res[1];
                    }

                }
            }


        }

        function validations() {

            //            document.getElementById('ddlTrustedOrg').value = '0';
        }
        function validateorg() {
            if (document.getElementById('ddlTrustedOrg').value == 0) {
                //                var userMsg = SListForAppMsg.Get('PORequest_PORequestSearch_aspx_01');
                //                var errorMsg = SListForAppMsg.Get('PORequest_Error');
                //                if (userMsg != null && errorMsg != null) {
                //                    ValidationWindow(userMsg, errorMsg);
                //                    return false;
                //                }
                //                else {
                //                    ValidationWindow('select the organisation','Alert');
                //                    return false;
                //                }
                var userMsg = SListForAppMsg.Get("PORequest_PORequestSearch_aspx_01") == null ? "select the organisation" : SListForAppMsg.Get("PORequest_PORequestSearch_aspx_01");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlTrustedOrg').focus();
                return false;
            }
        }

        function SelectINVRowCommon(rid, prid, Raiseorgid, curorgid, ReqNo) {

            document.getElementById('hdnPRequestID').value += prid + '^';
            document.getElementById('hdntemp').value += Raiseorgid + '~' + curorgid + '~' + ReqNo + '^';

        }
        function requestvalidation() {

            if (document.getElementById('hdnPRequestID').value == "") {
                //                var userMsg = SListForAppMsg.Get('PORequest_PORequestSearch_aspx_02');
                //                var errorMsg = SListForAppMsg.Get('PORequest_Error');
                //                if (userMsg != null && errorMsg != null) {
                //                    ValidationWindow(userMsg, errorMsg);
                //                    return false;
                //                }
                //                else {
                //                    ValidationWindow("select PO Request","Alert");
                //                    return false;
                //                }
                var userMsg = SListForAppMsg.Get("PORequest_PORequestSearch_aspx_02") == null ? "select PO Request" : SListForAppMsg.Get("PORequest_PORequestSearch_aspx_02");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }

            var drplist = document.getElementById('dList').options[document.getElementById('dList').selectedIndex].text;
            if (drplist == "RaisePO") {
                var x = document.getElementById('hdntemp').value.split('^');
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        var z = x[i].split('~');
                        if (z[0] != z[1]) {
                            //                            alert("Current Login Hospital to Raise Purchase Order");
                            //                            document.getElementById('ddlTrustedOrg').focus();
                            //                            return false;
                        }
                        return true;
                    }
                }
            }
        }
        
    </script>
    
</body>
</html>
