<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuotationDetails.aspx.cs"
    Inherits="Waters_QuotationDetails" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quotation Details</title>
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" type="text/css" href="../StyleSheets/jquery.datatable.css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link rel="Stylesheet" type="text/css" href="../StyleSheets/Common.css" />

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <%--<link rel="Stylesheet" type="text/css" href="Bootstrap/css/bootstrap.min.css" />

    <script src="Bootstrap/js/bootstrap.min.js" language="javascript" type="text/javascript"></script>--%>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlquotationdetails" runat="server">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <asp:UpdatePanel ID="UpPnl" runat="server">
        <Triggers>
            <asp:PostBackTrigger ControlID="btnConverttoXL" />
        </Triggers>
        <ContentTemplate>
            <div class="contentdata">

                <script type="text/javascript">
                    function SelectedClient(source, eventArgs) {
                        //  document.getElementById('hdnSelectedClientDetails').value = eventArgs.get_value();
                        // var alldetails = document.getElementById('hdnSelectedClientDetails').value.split("~");
                        var ClientDetails = "";
                        var Clientname = eventArgs.get_value().split('~')[0];
                        var Clientcode = eventArgs.get_value().split('~')[1];
                        // var ClientID = eventArgs.get_value().split('~')[2];
                        document.getElementById('hdnClientID').value = eventArgs.get_value().split('~')[2];

                    }



                    $(function() {
                        TempDateandTime();

                    });

                    var AlertType;

                    function ValidateDate() {


                        AlertType = SListForAppMsg.Get('Waters_QuotationMaster_aspx_08') == null ? "Alert" : SListForAppMsg.Get('Waters_QuotationMaster_aspx_08');
                        if (document.getElementById('txtFrom').value == '') {
                            // userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_1');
                            userMsg = SListForAppMsg.Get('Waters_QuotationDetails_aspx_13') == null ? "Select From date" : SListForAppMsg.Get('Waters_QuotationDetails_aspx_13');
                            if (userMsg != null) {
                                ValidationWindow(userMsg, AlertType);
                                //alert(userMsg);
                                return false;

                            }
                            else {
                                ValidationWindow(vFromDate, AlertType);
                                return false;

                            }
                            document.getElementById('txtFrom').focus();
                            return false;
                        }
                        else if (document.getElementById('txtTo').value == '') {
                            userMsg = SListForAppMsg.Get('Waters_QuotationDetails_aspx_14') == null ? "Select From date" : SListForAppMsg.Get('Waters_QuotationDetails_aspx_14');
                            if (userMsg != null) {
                                //alert(userMsg);
                                ValidationWindow(userMsg, AlertType);
                                return false;

                            }
                            else {
                                ValidationWindow(vToDate, AlertType);
                                return false;

                            }
                            document.getElementById('txtTo').focus();
                            return false;
                        }
                        else {

                            return true;
                        }

                    }

                    function TempDateandTime() {


                        $("#txtFrom").datepicker({
                            dateFormat: 'dd/mm/yy',
                            defaultDate: "+1w",
                            changeMonth: true,
                            changeYear: true,
                            maxDate: 0,
                            showOn: "both",
                            buttonImage: "../images/Calendar_scheduleHS.png",
                            buttonImageOnly: true,

                            yearRange: '1900:2100',
                            onClose: function(selectedDate) {
                                $("#txtTo").datepicker("option", "minDate", selectedDate);

                                var date = $("#txtFrom").datepicker('getDate');
                                //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                                // $("#txtTo").datepicker("option", "maxDate", d);

                            }
                        });
                        $("#txtTo").datepicker({
                            dateFormat: 'dd/mm/yy',
                            defaultDate: "+1w",
                            changeMonth: true,
                            changeYear: true,
                            maxDate: 0,
                            showOn: "both",
                            buttonImage: "../images/Calendar_scheduleHS.png",
                            buttonImageOnly: true,
                            yearRange: '1900:2100',
                            onClose: function(selectedDate) {
                                $("#txtFrom").datepicker("option", "maxDate", selectedDate);
                            }
                        });

                    }

                    function OpenBillPrint(url) {
                        window.open(url + " &duplicateBill=N", "billprint", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
                    }

                    function Closepopup() {
                        $find('ModalPopupExtenderBill').hide();

                        return false;

                    }

                </script>

                <table class="defaultfontcolor w-100p">
                    <tr>
                        <td>
                            <asp:Panel ID="pnlFilter" runat="server" CssClass="defaultfontcolor">
                                <div>
                                    <table class="defaultfontcolor w-100p searchPanel">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblfrom" runat="server" Text="From" meta:resourcekey="lblfromResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <table border="0" cellpadding="2" cellspacing="1" class="w-100p">
                                                    <tr class="defaultfontcolor">
                                                        <td style="cursor: pointer;">
                                                            <asp:TextBox runat="server" ID="txtFrom" CssClass="Txtboxsmall" MaxLength="25" size="20"
                                                                meta:resourcekey="txtFromResource1"></asp:TextBox>
                                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblto" runat="server" Text="To" meta:resourcekey="lbltoResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <table border="0" cellpadding="2" cellspacing="1" class="w-100p">
                                                    <tr class="defaultfontcolor">
                                                        <td style="cursor: pointer;">
                                                            <asp:TextBox runat="server" ID="txtTo" MaxLength="25" CssClass="Txtboxsmall" size="20"
                                                                meta:resourcekey="txtToResource1"></asp:TextBox>
                                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblquotationno" runat="server" Text="Quotation No" meta:resourcekey="lblquotationnoResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtquotationno" CssClass="AutoCompletesearchBox Txtboxsmall" runat="server"
                                                    meta:resourcekey="txtquotationnoResource1"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderQuotationNo" runat="server" TargetControlID="txtquotationno"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                    MinimumPrefixLength="2" CompletionInterval="0" ServiceMethod="pGetListForAutoComp"
                                                    ServicePath="~/OPIPBilling.asmx" DelimiterCharacters="" Enabled="True" UseContextKey="True">
                                                </ajc:AutoCompleteExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblclientname" runat="server" Text="Client Name" meta:resourcekey="lblclientnameResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtclientname" runat="server" CssClass="AutoCompletesearchBox Txtboxsmall"
                                                    OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"
                                                    meta:resourcekey="txtclientnameResource1"></asp:TextBox>
                                                <asp:HiddenField ID="hdnClientID" runat="server" />
                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientName" runat="server" TargetControlID="txtclientname"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                    MinimumPrefixLength="2" CompletionInterval="0" ServiceMethod="GetQuotationClientName"
                                                    OnClientItemSelected="SelectedClient" ServicePath="~/OPIPBilling.asmx" DelimiterCharacters=""
                                                    Enabled="True" UseContextKey="True">
                                                </ajc:AutoCompleteExtender>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblSampletype" runat="server" Text="Sample Type" meta:resourcekey="lblSampletypeResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <%--<asp:DropDownList ID="drpSampletype" runat="server" meta:resourcekey="drpSampletypeResource1">
                                                </asp:DropDownList>--%>
                                                <asp:TextBox ID="txtSampType" runat="server" CssClass="AutoCompletesearchBox Txtboxsmall"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteSampType" runat="server" TargetControlID="txtSampType"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                    MinimumPrefixLength="2" CompletionInterval="0" ServiceMethod="pGetListForAutoComp"
                                                    ServicePath="~/OPIPBilling.asmx" DelimiterCharacters="" Enabled="True" UseContextKey="True">
                                                </ajc:AutoCompleteExtender>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblsalesperson" runat="server" Text="Sales Person" meta:resourcekey="lblsalespersonResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <%-- <asp:DropDownList ID="drpsalesperson" runat="server" meta:resourcekey="drpsalespersonResource1">
                                                </asp:DropDownList>--%>
                                                <asp:TextBox ID="txtSalesPerson" runat="server" CssClass="AutoCompletesearchBox Txtboxsmall"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteSalesPerson" runat="server" TargetControlID="txtSalesPerson"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                    MinimumPrefixLength="2" CompletionInterval="0" ServiceMethod="pGetListForAutoComp"
                                                    ServicePath="~/OPIPBilling.asmx" DelimiterCharacters="" Enabled="True" UseContextKey="True">
                                                </ajc:AutoCompleteExtender>
                                            </td>
                                            
                                        </tr>
                                        <tr>
                                        <td>
                                        <asp:Label ID="lblsamplestatus" runat="server" Text="Status" meta:resourcekey="lblsamplestatusResource1"></asp:Label>
                                        </td>
                                        <td>
                                               <asp:DropDownList ID="drpstatus1" runat="server" DataTextField="DisplayText" DataValueField="Code" >
                                                    </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:Button ID="btnsearch" runat="server" Text="Search" OnClientClick="return ValidateDate();"
                                                    CssClass="btn" meta:resourcekey="btnsearchResource1" OnClick="btnsearch_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-right padding10" style="color: #000000;" colspan="7">
                                                <asp:ImageButton ID="btnConverttoXL" runat="server" ImageUrl="~/Images/ExcelImage.GIF"
                                                    meta:resourcekey="btnConverttoXLResource1" OnClick="btnConverttoXL_Click" />
                                                <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="True" ForeColor="#000333"
                                                    runat="server" meta:resourcekey="lbExcelResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="pnlquoDetails" runat="server">
                    <div>
                        <table class="w-100p">
                            <tr>
                                <td>
                                <asp:Label ID="lblNumberofrecrdFetched" Text="No. of Records Fetched :" runat="server" ></asp:Label>
                                <asp:Label ID="lblNumberofRecords" runat="server" ></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="grdquoDetails" CssClass="mytable1 w-100p gridView" runat="server"
                                        AutoGenerateColumns="False" meta:resourcekey="grdquoDetailsResource1" OnRowDataBound="grdSampleForApproval_RowDataBound">
                                        <Columns>
                                            <asp:BoundField DataField="RowID" HeaderText="SI.NO" meta:resourcekey="BoundFieldResource1" />
                                            <asp:TemplateField HeaderText="QuotationNo">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lblQuotationNo" runat="server" Text='<%# Eval("QuotationNO") %>' OnClick="ShowQuotation"
                                                        Font-Underline="true" CssClass="a-center"  Style="cursor: pointer;"></asp:LinkButton>
                                                        <asp:HiddenField ID="hdnQuotationId" runat="server" Value='<%# Eval("QuotationID") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="ClientType" HeaderText="Client Type" meta:resourcekey="BoundFieldResource3" />
                                            <asp:BoundField DataField="ClientName" HeaderText="Client Name" meta:resourcekey="BoundFieldResource4" />
                                            <asp:BoundField DataField="SalesPerson" HeaderText="Sales Person" meta:resourcekey="BoundFieldResource5" />
                                            <asp:BoundField DataField="SampleType" HeaderText="Sample Type" meta:resourcekey="BoundFieldResource6" />
                                            <asp:BoundField DataField="TestName" HeaderText="Quotation Date" meta:resourcekey="BoundFieldResource7" />
                                            <asp:BoundField DataField="CollectionPerson" HeaderText="Expiry Date" meta:resourcekey="BoundFieldResource8" />
                                            <asp:TemplateField HeaderText="Status" meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="drpstatus" runat="server" DataSource='<%# LoadMeatData() %>'
                                                        DataTextField="DisplayText" DataValueField="Code" meta:resourcekey="drpstatusResource1">
                                                    </asp:DropDownList>
                                                    <asp:Label ID="SampleOriginalStatus" Text='<%# Eval("STATUS") %>' runat="server"
                                                        Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="w-100p" style="color: #000000;">
                                        <tr>
                                            <td class="a-center padding10">
                                                <asp:Button ID="btnClear" OnClick="btnClear_Click" runat="server" Text="Clear" CssClass="btn"
                                                    meta:resourcekey="btnClearResource1" />
                                                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" meta:resourcekey="btnSaveResource1"
                                                    OnClick="btnSave_Click" />
                                                <br></br>
                                                <br></br>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:Panel>
                <asp:Panel ID="GrdResult" runat="server" Visible="false">
                    <div>
                        No Matching Records Found</div>
                </asp:Panel>
                <asp:UpdateProgress DynamicLayout="False" ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter" class="a-center">
                        </div>
                        <div id="processMessage" class="a-center w-20p">
                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                meta:resourcekey="img1Resource1" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <Attune:Attunefooter ID="Attunefooter" runat="server" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:Panel ID="PopupBill" runat="server" Height="95%" ScrollBars="Vertical" CssClass="modalPopup dataheaderPopup w-65p"
        Enabled="True">
        <table id="tblBill" runat="server" class="w-100p">
            <tr>
                <td>
                    <rsweb:ReportViewer ID="rReportViewer" runat="server" ProcessingMode="Remote" Font-Names="Verdana"
                        Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
                        <ServerReport ReportServerUrl="" />
                    </rsweb:ReportViewer>
                </td>
            </tr>
            <tr class="a-center">
                <td class="a-center">
                    <asp:Button ID="BillClose" runat="server" CssClass="a-center" Text="Close" OnClientClick="return Closepopup();" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <ajc:ModalPopupExtender ID="ModalPopupExtenderBill" runat="server" BackgroundCssClass="modalBackground"
        PopupControlID="PopupBill" Enabled="True" TargetControlID="btnDummy1" DynamicServicePath="">
    </ajc:ModalPopupExtender>
    <input type="button" id="btnDummy1" runat="server" style="display: none;" />
    <asp:HiddenField ID="hdnMessages" runat="server" Value="" />
    </form>
</body>
</html>
