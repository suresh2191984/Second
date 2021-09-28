<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DispensingReport.aspx.cs"
    Inherits="InventoryReports_DispensingReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Dispensing Report</title>
</head>
<body>
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" AsyncPostBackTimeout="10" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
     <script type="text/javascript" language="javascript">
        var errorMsg = SListForAppMsg.Get("InventoryReports_Error") == null ? "Error" : SListForAppMsg.Get("InventoryReports_Error")
        var InformationMsg = SListForAppMsg.Get("InventoryReports_Information") == null ? "Information" : SListForAppMsg.Get("InventoryReports_Information")
        var okMsg = SListForAppMsg.Get("InventoryReports_Ok") == null ? "Ok" : SListForAppMsg.Get("InventoryReports_Ok")
        var cancelMsg = SListForAppMsg.Get("InventoryReports_Cancel") == null ? "Cancel" : SListForAppMsg.Get("InventoryReports_Cancel")
       </script>
    <div class="contentdata">
        <table class="w-100p">
            <tr>
                <td>
                    <table class="w-100p  lh30 ">
                        <tr>
                            <td>
                                <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" meta:resourcekey="lblOrgsResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlTrustedOrg" AutoPostBack="True" onchange="javascript:clearContextText();"
                                    runat="server" CssClass="smaller" OnSelectedIndexChanged="ddlTrustedOrg_SelectedIndexChanged"
                                    meta:resourcekey="ddlTrustedOrgResource1">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lblDepartment" Text="Issued To Location" CssClass="label_title"
                                    meta:resourcekey="lblDepartmentResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="ddlLocation" runat="server" CssClass="small" meta:resourcekey="ddlLocationResource1">
                                        </asp:DropDownList>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="ddlTrustedOrg" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                            <td>
                                <asp:Label ID="LabelFromdt" runat="server" Text="From Date" meta:resourcekey="LabelFromdtResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFrom" runat="server" CssClass="datePicker xsmaller" onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtFromResource1" />
                            </td>
                            <td align="left">
                                <asp:Label ID="LabelTodt" runat="server" Text="To Date" meta:resourcekey="LabelTodtResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtTo" runat="server" CssClass="datePicker xsmaller"  onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtToResource1" />
                            </td>
                            <td>
                                <asp:Label ID="LabelproductName" runat="server" Text="Product Name" meta:resourcekey="LabelproductNameResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtProductName" onfocus="SetCompile();" onKeyPress="return ValidateMultiLangChar(this);" runat="server"
                                    Width="134px" CssClass="Txtboxsmall" meta:resourcekey="txtProductNameResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoGname1" runat="server" TargetControlID="txtProductName"
                                    ServiceMethod="GetAllProducts" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                    EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="30" OnClientItemSelected="IAmSelected"
                                    DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" Enabled="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                        </tr>
                        <tr class="lh20">
                            <td>
                                <asp:Label ID="LabelPatname" runat="server" Text="Patient Name" meta:resourcekey="LabelPatnameResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPatientName" runat="server" 
                                onKeyPress="return ValidateMultiLangCharacter(this);"  CssClass="smaller"
                                    meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label ID="Labelbillno" runat="server" Text="Bill No" meta:resourcekey="LabelbillnoResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtBillNo" runat="server" CssClass="small" 
                                 onKeyPress="return ValidateMultiLangChar(this);"  meta:resourcekey="txtBillNoResource1"></asp:TextBox>
                            </td>
                            <td colspan="2">
                                <fieldset class="scheduler-border w-80p">
                                    <legend class="scheduler-border"><asp:Label ID="lblVisittype" runat="server" Text="Visit Type" meta:resourcekey="lblVisittypeResource1"></asp:Label></legend>
                                <asp:RadioButtonList ID="rblVisitType" CssClass="w-100p" RepeatDirection="Horizontal" runat="server"
                                    meta:resourcekey="rblVisitTypeResource1">
                                </asp:RadioButtonList>
                                </fieldset>
                            </td>
                            <td>
                                <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                    OnClientClick="javascript:return CheckDates();" OnClick="btnSearch_Click"
                                    TabIndex="7" meta:resourcekey="btnSearchResource1" />
                            </td>
                            <td>
                             <%--   <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click"
                                    meta:resourcekey="lnkBackResource1">
                                    <asp:Label Text="Back" ID="lblBack" runat="server" meta:resourcekey="lblBackResource1"></asp:Label>
                                </asp:LinkButton>--%>
                                       <asp:Button ID="lnkBack" ToolTip="Search" meta:resourcekey="lnkBacksResource1" runat="server"
                                                        Text="Back" CssClass="btn" OnClick="lnkBack_Click" />
                            </td>
                            <td class="a-right">
                                <table id="tblTool" runat="server" class="hide">
                                    <tr class="a-right">
                                        <td class="a-right">
                                            <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="../PlatForm/Images/ExcelImage.GIF"
                                                ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource1" />
                                            <asp:LinkButton ID="lnkExportXL" CssClass="hide" OnClick="imgBtnXL_Click" runat="server" Font-Bold="True"
                                                Text="Export To XL" Font-Underline="True" Font-Size="12px" ForeColor="Black"
                                                ToolTip="Save As Excel" meta:resourcekey="lnkExportXLResource1"></asp:LinkButton>
                                            &nbsp;&nbsp;&nbsp;
                                        </td>
                                        <td class="a-right">
                                            <asp:ImageButton ID="imgBtnPrint" runat="server" CssClass="marginL5" ImageUrl="~/PlatForm/images/printer.gif"
                                                ToolTip="Print Dispensing Report" OnClientClick="return CallPrint();"
                                                meta:resourcekey="imgBtnPrintResource1" />
                                            <asp:LinkButton ID="lnkPrint" runat="server" CssClass="hide" OnClientClick="return CallPrint();" Text="Print" Font-Bold="true" ForeColor="Black" Font-Underline="true"
                                                ToolTip="Print Dispensing Report" meta:resourcekey="lnkPrintResource1">
                                            </asp:LinkButton>
                                            <%--<asp:HyperLink ID="HyperLink1" Font-Bold="True" Font-Size="12px" ForeColor="Black"
                                                Target="BillWindow" runat="server" ToolTip="Click Here To Print Stock Details"
                                                meta:resourcekey="HyperLink1Resource1">
                                                <img alt="" id="img1" runat="server" style="border-width: 0px;" src="~/PlatForm/Images/printer.gif" />
                                                &nbsp;
                                                <asp:Label ID="LabelPrntDispRpt" runat="server" Text="Print Dispensing Report" Font-Underline="true"
                                                    meta:resourcekey="LabelPrntDispRptResource1"></asp:Label>
                                            </asp:HyperLink>--%>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                
                    <td class="v-top">
                    <div id="printarea">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvResult" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvResult_RowDataBound"
                                    CssClass="gridView w-100p" AllowPaging="True" PageSize="20" OnPageIndexChanging="gvResult_PageIndexChanging"
                                    meta:resourcekey="gvResultResource1">
                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderText="Bill No" DataField="BillNumber" meta:resourcekey="BoundFieldResource1" />
                                        <asp:TemplateField HeaderText="ReceiptNo/InterimNo" meta:resourcekey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <asp:Label ID="lblReceiptNo" runat="server" Text='<%# Bind("ReceiptNo") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" DataField="CreatedAt"
                                            meta:resourcekey="BoundFieldResource2" />
                                        <asp:BoundField HeaderText="UHID" DataField="PatientNumber" meta:resourcekey="BoundFieldResource3" />
                                        <asp:BoundField HeaderText="Name" DataField="Name" meta:resourcekey="BoundFieldResource4" />
                                        <asp:BoundField HeaderText="Address" DataField="Address" meta:resourcekey="BoundFieldResource5">
                                            <ItemStyle Wrap="True" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Prescribed By" meta:resourcekey="TemplateFieldResource3">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPrescribedby" runat="server" Text='<%# Bind("Perphyname") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Visit Type" meta:resourcekey="TemplateFieldResource4">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGrdVisitType" runat="server" Text='<%# Bind("VisitType") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Details" meta:resourcekey="TemplateFieldResource6">
                                            <ItemTemplate>
                                                <asp:GridView OnRowDataBound="gvResult1_RowDataBound" AutoGenerateColumns="False"
                                                    Width="100%" runat="server" ID="rptChildResult" meta:resourcekey="rptChildResultResource1">
                                                    <Columns>
                                                        <asp:BoundField HeaderText="DrugName" DataField="FeeDescription" meta:resourcekey="BoundFieldResource6">
                                                        </asp:BoundField>
                                                        <asp:BoundField HeaderText="BatchNo" DataField="BatchNo" meta:resourcekey="BoundFieldResource7">
                                                        </asp:BoundField>
                                                       
                                                        <asp:TemplateField HeaderText="Exp.Date" meta:resourcekey="BoundFieldResource8">
                                                            <ItemTemplate>
                                                                <%# ((Eval("ExpiryDate", "{0:yyyy}")) == "1753" || (Eval("ExpiryDate", "{0:yyyy}")) == "9999" || (Eval("ExpiryDate", "{0:yyyy}")) == "0001") ? "**" : GetDate(Eval("ExpiryDate", "{0:MMM/yyyy}"))%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>    
                                                        <asp:TemplateField HeaderText="Quantity" meta:resourcekey="TemplateFieldResource5">
                                                            <ItemTemplate>
                                                                <%# Eval("Quantity") %>&nbsp;<%# Eval("SellingUnit") %>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField HeaderText="TotalAmount" DataField="BilledAmount" meta:resourcekey="BoundFieldResource9">
                                                        </asp:BoundField>
                                                    </Columns>
                                                    <RowStyle CssClass="results" HorizontalAlign="Left" />
                                                </asp:GridView>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="gridHeader" />
                                    <RowStyle VerticalAlign="Top" HorizontalAlign="Left" />
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        </div>
                    </td>
                
            </tr>
            <tr id="GrdFooter" runat="server" class="hide gridFooter">
                <td align="center" colspan="10" class="w-100p">
                    <asp:Label ID="Label1" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                    <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                    <asp:Label ID="Label2" runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label>
                    <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                    <asp:Button ID="Btn_Previous" runat="server" Text="Previous" CssClass="btn" OnClick="Btn_Previous_Click"
                        meta:resourcekey="Btn_PreviousResource1" />
                    <asp:Button ID="Btn_Next" runat="server" Text="Next" CssClass="btn" OnClick="Btn_Next_Click"
                        meta:resourcekey="Btn_NextResource1" />
                    <asp:HiddenField ID="hdnCurrent" runat="server" />
                    <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                    <asp:TextBox ID="txtpageNo" runat="server" Width="30px" onkeydown="javascript:return validatenumber(event);"
                        meta:resourcekey="txtpageNoResource1" OnkeyPress="return ValidateOnlyNumeric(this)"></asp:TextBox>
                    <asp:Button ID="btnGo1" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click1"
                        meta:resourcekey="btnGo1Resource1" />
                    <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />

    <script type="text/javascript" language="javascript">
       
        function SetCompile() {
            $find('AutoGname1').set_contextKey(0);
        }

        function checkForValues() {
            if (document.getElementById('<%=txtpageNo.ClientID %>').value == "") {
                var userMsg = SListForAppMsg.Get("InventoryReports_DispensingReport_aspx_01") == null ? "Please Enter Page No" : SListForAppMsg.Get("InventoryReports_DispensingReport_aspx_01");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }

            if (Number(document.getElementById('<%=txtpageNo.ClientID %>').value) < Number(1)) {
                var userMsg = SListForAppMsg.Get("InventoryReports_DispensingReport_aspx_02") == null ? "Please Enter Correct Page No" : SListForAppMsg.Get("InventoryReports_DispensingReport_aspx_02");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            else {
                if (Number(document.getElementById('<%=txtpageNo.ClientID %>').value) > Number(document.getElementById('<%=lblTotal.ClientID %>').innerText)) {
                    var userMsg = SListForAppMsg.Get("InventoryReports_DispensingReport_aspx_02") == null ? "Please Enter Correct Page No" : SListForAppMsg.Get("InventoryReports_DispensingReport_aspx_02");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }

            }
        }
        function CheckDates() {

            if (document.getElementById('txtFrom').value == '') {

                var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_01") == null ? "Select From Date!" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_01");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {
                var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_02") == null ? "Select To Date!" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_02");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            else {
                //Assign From And To Date from Controls 
                DateFrom = document.getElementById('txtFrom').value.split(splitChar);
                DateTo = document.getElementById('txtTo').value.split(splitChar);
                if (CheckFromToDate(DateFrom, DateTo)) {
                    return true;
                } else {
                    var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03") == null ? "From date should not be  greater then To date" : SListForAppMsg.Get("InventoryReports_PurchaseStatusReport_aspx_03");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }

            }

        }
        function ProductItemSelected(sender, args) {


            var ProductCategory = document.forms[0][sender.get_element().name].value; //$("#" + sender.get_element().name).val(); //document.getElementById(sender.get_element().name).value;  //
            var Product = '';
            var result = '';

            if (ProductCategory == '' || ProductCategory == undefined) {

                Product = ProductCategory;
                document.forms[0][sender.get_element().name].value = Product;

            }
            else {

                result = ProductCategory.match(/[^[\]]+(?=])/g)
                if (result != null) {
                    Product = ProductCategory.replace(/\s*\[.*?\]\s*/g, '');
                    document.forms[0][sender.get_element().name].value = Product;
                    // $('#' + sender.get_element().name).val(Product);
                }
                else {

                    Product = ProductCategory;
                    document.forms[0][sender.get_element().name].value = Product;

                }
            }
        }


        function IAmSelected(source, eventArgs) {
            var varGetText = eventArgs.get_text();
            if (varGetText != null && varGetText != "") {
                $('#txtProductName').val(varGetText);
            }
            ProductItemSelected(source, eventArgs);
        }


        function doDateValidation(from, to, bit) {
            var dayFlag = true;
            var monthFlag = true;
            var i = from.length - 1;
            if (Number(to[i]) >= Number(from[i])) {
                if (Number(to[i]) == Number(from[i])) {
                    monthFlag = false;
                }
                i--;
                if (Number(to[i]) >= Number(from[i])) {
                    if (Number(to[i]) == Number(from[i])) {
                        dayFlag = false;
                    }
                    i--;
                    if (Number(to[i]) >= Number(from[i])) {
                        i--;
                        return true;
                    }
                    else {
                        if (dayFlag) {
                            return true;
                        }
                        else {
                            if (bit == 0) {
                                var userMsg = SListForAppMsg.Get("InventoryReports_DispensingReport_aspx_05") == null ? "Mismatch Day Between Current & To Date" : SListForAppMsg.Get("InventoryReports_DispensingReport_aspx_05");
                                ValidationWindow(userMsg, errorMsg);
                                return false;
                            }
                            else {

                                var userMsg = SListForAppMsg.Get("InventoryReports_DispensingReport_aspx_06") == null ? "Mismatch Day Between From & To Date" : SListForAppMsg.Get("InventoryReports_DispensingReport_aspx_06");
                                ValidationWindow(userMsg, errorMsg);
                                return false;
                            }
                            return false;
                        }
                    }
                }
                else if (monthFlag) {
                    return true;
                }
                else {
                    if (bit == 0) {

                        var userMsg = SListForAppMsg.Get("InventoryReports_DispensingReport_aspx_07") == null ? "Mismatch Month Between Current & To Date" : SListForAppMsg.Get("InventoryReports_DispensingReport_aspx_07");
                        ValidationWindow(userMsg, errorMsg);
                        return false;
                    }
                    else {
                        var userMsg = SListForAppMsg.Get("InventoryReports_DispensingReport_aspx_08") == null ? "Mismatch Month Between From & To Date" : SListForAppMsg.Get("InventoryReports_DispensingReport_aspx_08");
                        ValidationWindow(userMsg, errorMsg);
                        return false;
                    }
                    return false;
                }
            }
            else {
                if (bit == 0) {
                    var userMsg = SListForAppMsg.Get("InventoryReports_DispensingReport_aspx_09") == null ? "Mismatch Year Between Current & To Date" : SListForAppMsg.Get("InventoryReports_DispensingReport_aspx_09");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
                else {
                    var userMsg = SListForAppMsg.Get("InventoryReports_DispensingReport_aspx_10") == null ? "Mismatch Year Between From & To Date" : SListForAppMsg.Get("InventoryReports_DispensingReport_aspx_10");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
                return false;
            }
        }
        function clearContextText() {
            $('#contentArea').hide();
        }

        function CallPrint() {
            var prtContent = document.getElementById('printarea');

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            //WinPrint.close();
            return false;
        }
		$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>

    </form>
</body>
</html>
