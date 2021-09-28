<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CollectionReportLIMS.aspx.cs"
    Inherits="Reports_CollectionReportLIMS" EnableEventValidation="false" meta:resourcekey="PageResource1" %>
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
            if (document.getElementById('<%= txtReferringHospital.ClientID %>').value.trim() == "") {
                document.getElementById('<%= hdnReferringHospitalID.ClientID %>').value = "0";
            }
            if (document.getElementById('<%= txtReferringPhysician.ClientID %>').value.trim() == "") {
                document.getElementById('<%= hdnPhysicianID.ClientID %>').value = "0";
            }
        }
        function GetReferingPhysicianID(source, eventArgs) {
            document.getElementById('<%= txtReferringPhysician.ClientID %>').value = eventArgs.get_text();
            document.getElementById('<%= hdnPhysicianID.ClientID %>').value = eventArgs.get_value().split('^')[1];
        }
        function GetReferingOrgID(source, eventArgs) {
            document.getElementById('<%= txtReferringHospital.ClientID %>').value = eventArgs.get_text();
            document.getElementById('<%= hdnReferringHospitalID.ClientID %>').value = eventArgs.get_value();
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
                                })
                            });

                        </script>

                        <table id="tblCollectionOPIP" class="a-center w-100p">
                            <tr class="a-center">
                                <td class="a-left">
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <ContentTemplate>
                                            <div class="dataheaderWider">
                                                <table id="tbl">
                                                    <tr id="trTrustedOrg" runat="server" style="display: table-row;">
                                                        <td>
                                                            <asp:Label ID="lblOrgs" runat="server" Text="Select organization" 
                                                                meta:resourcekey="lblOrgsResource1"></asp:Label>
                                                            <asp:DropDownList ID="ddlTrustedOrg" AutoPostBack="true" onchange="javascript:clearContextText();"
                                                                runat="server" CssClass="ddl" 
                                                                OnSelectedIndexChanged="ddlTrustedOrg_SelectedIndexChanged" 
                                                                meta:resourcekey="ddlTrustedOrgResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblLoc" Text="Location" runat="server" 
                                                                meta:resourcekey="lblLocResource1"></asp:Label>
                                                            <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddl" 
                                                                meta:resourcekey="ddlLocationResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" 
                                                                meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox CssClass="Txtboxsmall" Width="70px" ID="txtFDate" runat="server" 
                                                                meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" 
                                                                meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox CssClass="Txtboxsmall" Width="70px" ID="txtTDate" runat="server" 
                                                                meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_SelectCurrency" Text="Select Currency" runat="server" 
                                                                meta:resourcekey="Rs_SelectCurrencyResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList CssClass="ddl" ID="ddlCurrency" ToolTip="Select Currency" runat="server"
                                                                Width="220px" meta:resourcekey="ddlCurrencyResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblReferingOrg" Text="Reference Hospital" runat="server" 
                                                                meta:resourcekey="lblReferingOrgResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtReferringHospital" runat="server" CssClass="Txtboxsmall" onfocus="return SetContextValue();"
                                                                onBlur="return ClearFields();" 
                                                                meta:resourcekey="txtReferringHospitalResource1"></asp:TextBox>
                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtenderReferringHospital" runat="server"
                                                                TargetControlID="txtReferringHospital" EnableCaching="False" FirstRowSelected="True"
                                                                CompletionInterval="1" MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box"
                                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                ServiceMethod="GetQuickBillRefOrg" ServicePath="~/WebService.asmx" OnClientItemSelected="GetReferingOrgID"
                                                                DelimiterCharacters="" Enabled="True">
                                                            </ajc:AutoCompleteExtender>
                                                            <asp:HiddenField ID="hdnReferringHospitalID" runat="server" Value="0" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="10">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblReferringPhysician" Text="Referring Physician" runat="server" 
                                                                            meta:resourcekey="lblReferringPhysicianResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtReferringPhysician" runat="server" onfocus="return SetContextValue();"
                                                                            CssClass="Txtboxsmall" onBlur="return ClearFields();" 
                                                                            meta:resourcekey="txtReferringPhysicianResource1"></asp:TextBox>
                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderReferringPhysician" runat="server"
                                                                            TargetControlID="txtReferringPhysician" EnableCaching="False" FirstRowSelected="True"
                                                                            CompletionInterval="1" MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box"
                                                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                            ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx" OnClientItemSelected="GetReferingPhysicianID"
                                                                            DelimiterCharacters="" Enabled="True">
                                                                        </ajc:AutoCompleteExtender>
                                                                        <asp:HiddenField ID="hdnPhysicianID" Value="0" runat="server"></asp:HiddenField>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblClientType" runat="server" Text="Client type" 
                                                                            meta:resourcekey="lblClientTypeResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlClientType" Width="120px" runat="server" 
                                                                            CssClass="ddl" meta:resourcekey="ddlClientTypeResource1">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblClient" Text="Client Name" runat="server" 
                                                                            meta:resourcekey="lblClientResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtClient" onfocus="setContextClientValue();"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"
                                                                            onblur="javascript:ClearValue(this.id);ConverttoUpperCase(this.id);" autocomplete="off"
                                                                            CssClass="Txtboxsmall" runat="server" Width="120px" 
                                                                            meta:resourcekey="txtClientResource1"></asp:TextBox>
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
                                                                        <asp:Panel ID="pnPatientType" CssClass="w-100p" GroupingText="Patient Type" runat="server" meta:resourcekey="pnPatientTypeResource1">
                                                                            <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" RepeatColumns="3"
                                                                                runat="server" meta:resourcekey="rblVisitTypeResource1">
                                                                                <%--<asp:ListItem Text="OP" Selected="True" Value="0" 
                                                                                    meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                                <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                                <asp:ListItem Text="OP&IP" Value="-1" meta:resourcekey="ListItemResource3"></asp:ListItem>--%>
                                                                            </asp:RadioButtonList>
                                                                        </asp:Panel>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Panel ID="pnReportType" runat="server" CssClass="w-100p" GroupingText="Report Type" meta:resourcekey="pnReportTypeResource1">
                                                                            <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" 
                                                                            runat="server" >
                                                                                <%--<asp:ListItem Text="Summary" Selected="True" Value="0" 
                                                                                    meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                                                <asp:ListItem Text="Detailed" Value="1" meta:resourcekey="ListItemResource5"></asp:ListItem>--%>
                                                                            </asp:RadioButtonList>
                                                                        </asp:Panel>
                                                                    </td>
                                                                    <td style="display: none;">
                                                                        <asp:Panel ID="PnlAdvance" CssClass="w-100p" GroupingText="Advance Filter" runat="server" meta:resourcekey="PnlAdvanceResource1">
                                                                            <asp:RadioButtonList ID="rdoAdvList" RepeatDirection="Horizontal" RepeatColumns="3"
                                                                                runat="server" >
                                                                               <%-- <asp:ListItem Text="Advance Only" Value="AO" 
                                                                                    meta:resourcekey="ListItemResource6"></asp:ListItem>
                                                                                <asp:ListItem Text="Non Advance Only" Value="NAO" 
                                                                                    meta:resourcekey="ListItemResource7"></asp:ListItem>
                                                                                <asp:ListItem Text="Both" Selected="True" Value="B" 
                                                                                    meta:resourcekey="ListItemResource8"></asp:ListItem>--%>
                                                                            </asp:RadioButtonList>
                                                                        </asp:Panel>
                                                                    </td>
                                                                    <td style="display: table-cell;">
                                                                        <asp:Panel ID="PnlBillFilter" CssClass="w-100p" GroupingText="Bill Filter" runat="server" meta:resourcekey="PnlBillFilterResource1">
                                                                            <asp:RadioButtonList ID="rdoBTList" RepeatDirection="Horizontal" RepeatColumns="3"
                                                                                runat="server" meta:resourcekey="rdoBTListResource1">
                                                                                <%--<asp:ListItem Text="Credit Bills" Value="CB" 
                                                                                    meta:resourcekey="ListItemResource9"></asp:ListItem>
                                                                                <asp:ListItem Text="Non Credit Bills" Value="NCB" 
                                                                                    meta:resourcekey="ListItemResource10"></asp:ListItem>
                                                                                <asp:ListItem Text="Both" Selected="True" Value="B" 
                                                                                    meta:resourcekey="ListItemResource11"></asp:ListItem>--%>
                                                                            </asp:RadioButtonList>
                                                                        </asp:Panel>
                                                                    </td>
                                                                    <td class="bold" style="display: none;">
                                                                        <asp:CheckBox ID="ChkBoxShowDescription" Text="Show Description" runat="server" 
                                                                            meta:resourcekey="ChkBoxShowDescriptionResource1" />
                                                                    </td>
                                                                    <td class="a-left">
                                                                        <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                            onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                                            OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                                            ToolTip="Save As Excel" OnClick="imgBtnXL_Click" 
                                                                            meta:resourcekey="imgBtnXLResource1" />
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
                                                        <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                                    </div>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                            <div id="divPrint" style="display: none;" runat="server">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="a-right paddingR10" style="color: #000000;">
                                                            <b id="printText" runat="server">
                                                                <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" 
                                                                meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                                ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divOPDWCR" runat="server" style="display: block;">
                                                <div id="prnReport">
                                                    <asp:GridView ID="gvIPCreditMainGrandTotal" runat="server" AutoGenerateColumns="False"
                                                        OnRowDataBound="gvIPCreditMainGrandTotal_RowDataBound" Width="100%" 
                                                        ForeColor="#333333" meta:resourcekey="gvIPCreditMainGrandTotalResource1">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Collection Report" 
                                                                meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <table class="w-100p">
                                                                        <tr class="h-15">
                                                                            <td class="a-left h-15">
                                                                                <b>
                                                                                    <asp:Label ID="lblOrg" Text="Organization Name: " runat="server" 
                                                                                    meta:resourcekey="lblOrgResource1"></asp:Label>
                                                                                </b>
                                                                                <asp:Label runat="server" ID="lblOrgName" 
                                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "OrganisationName") %>' 
                                                                                    meta:resourcekey="lblOrgNameResource1"></asp:Label>
                                                                                <asp:Label runat="server" Visible="False" ID="lblOrgID" 
                                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "OrgID") %>' 
                                                                                    meta:resourcekey="lblOrgIDResource1"></asp:Label>
                                                                                <b>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:GridView ID="gvOrgwiseGrandTotal" OnRowDataBound="gvOrgwiseGrandTotal_RowDataBound"
                                                                                    runat="server" AutoGenerateColumns="False" ForeColor="#333333" 
                                                                                    CssClass="w-100p gridView mytable1" 
                                                                                    meta:resourcekey="gvOrgwiseGrandTotalResource1">
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="PatientName" meta:resourcekey="BoundFieldResource1">
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="BillAmount" HeaderText="Bill Amount" 
                                                                                            meta:resourcekey="BoundFieldResource2"></asp:BoundField>
                                                                                        <asp:BoundField DataField="TaxAmount" HeaderText="Tax" 
                                                                                            meta:resourcekey="BoundFieldResource3"></asp:BoundField>
                                                                                        <asp:BoundField DataField="HOSRefund" HeaderText="Redeem" 
                                                                                            meta:resourcekey="BoundFieldResource4"></asp:BoundField> 
                                                                                        <asp:BoundField DataField="Discount" HeaderText="Discount" 
                                                                                            meta:resourcekey="BoundFieldResource5"></asp:BoundField>
                                                                                        <asp:BoundField DataField="ServiceCharge" HeaderText="Service charge" 
                                                                                            meta:resourcekey="BoundFieldResource6"></asp:BoundField>
                                                                                        <asp:BoundField DataField="NetValue" HeaderText="Net Amount" 
                                                                                            meta:resourcekey="BoundFieldResource7"></asp:BoundField>
                                                                                        <asp:BoundField DataField="ReceivedAmount" HeaderText="Received Amount" 
                                                                                            meta:resourcekey="BoundFieldResource8"></asp:BoundField>
                                                                                            <asp:BoundField DataField="AmtReceivedServiceCharge" HeaderText="Advance Amount"></asp:BoundField>
                                                                                        <asp:BoundField DataField="RefundAmt" HeaderText="Refund Amount" 
                                                                                            meta:resourcekey="BoundFieldResource9">
                                                                                        </asp:BoundField>
                                                                                         <asp:BoundField DataField="RoundOff" HeaderText="RoundOff amount" 
                                                                                            meta:resourcekey="BoundFieldResource10"/>
                                                                                        <asp:BoundField DataField="Cash" HeaderText="Cash" 
                                                                                            meta:resourcekey="BoundFieldResource11"></asp:BoundField>
                                                                                        <asp:BoundField DataField="Cards" HeaderText="Cards" 
                                                                                            meta:resourcekey="BoundFieldResource12"></asp:BoundField>
                                                                                        <asp:BoundField DataField="Cheque" HeaderText="Cheque" 
                                                                                            meta:resourcekey="BoundFieldResource13"></asp:BoundField>
                                                                                        <asp:BoundField DataField="DD" HeaderText="DD" 
                                                                                            meta:resourcekey="BoundFieldResource14"></asp:BoundField>
                                                                                        <asp:BoundField DataField="Coupon" HeaderText="Coupon" 
                                                                                            meta:resourcekey="BoundFieldResource15"></asp:BoundField>
                                                                                        <asp:BoundField DataField="Due" HeaderText="Due" 
                                                                                            meta:resourcekey="BoundFieldResource16"></asp:BoundField>
                                                                                        <asp:BoundField DataField="TotalAmount" HeaderText="Due Paid Amount" 
                                                                                            meta:resourcekey="BoundFieldResource17"></asp:BoundField> 
                                                                                        <asp:BoundField DataField="WriteOffAmount" HeaderText="Write-Off amount" 
                                                                                            meta:resourcekey="BoundFieldResource18"></asp:BoundField>
                                                                                    </Columns>
                                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                                </asp:GridView>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Right" />
                                                        <RowStyle BackColor="White" Font-Bold="True" HorizontalAlign="Right" />
                                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Left" />
                                                    </asp:GridView>
                                                    <br />
                                                    <br />
                                                    <asp:GridView ID="gvOrgwisePatientSummary" runat="server" AutoGenerateColumns="False"
                                                        OnRowDataBound="gvOrgwisePatientSummary_RowDataBound" Visible="true" CssClass="gridView w-100p"
                                                        HorizontalAlign="Right" meta:resourcekey="gvOrgwisePatientSummaryResource1">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Location wise Collection Report" 
                                                                ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource5">
                                                                <ItemTemplate>
                                                                    <table class="w-100p">
                                                                        <tr>
                                                                            <td class="a-left h-25">
                                                                                <b>
                                                                                    <asp:Label ID="lblOrg" Text="Organization Name: " runat="server" 
                                                                                    meta:resourcekey="lblOrgResource2"></asp:Label>
                                                                                </b>
                                                                                <asp:Label runat="server" ID="lblOrgName" 
                                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "OrganisationName") %>' 
                                                                                    meta:resourcekey="lblOrgNameResource2"></asp:Label>
                                                                                <asp:Label runat="server" Visible="False" ID="lblOrgID" 
                                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "OrgID") %>' 
                                                                                    meta:resourcekey="lblOrgIDResource2"></asp:Label>
                                                                                <b>
                                                                                    <%--<asp:Label ID="lblRowID" runat="server" Text='<% Container.DataItemIndex %>'></asp:Label>--%>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:GridView ID="gvDatewisePatientDetail" runat="server" AutoGenerateColumns="False"
                                                                                    OnRowDataBound="gvDatewisePatientDetail_RowDataBound" Width="100%" 
                                                                                    ForeColor="#333333" meta:resourcekey="gvDatewisePatientDetailResource1">
                                                                                    <Columns>
                                                                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource4">
                                                                                            <ItemTemplate>
                                                                                                <table class="w-100p">
                                                                                                    <tr class="a-left">
                                                                                                        <td class="a-left">
                                                                                                            <b>
                                                                                                                <asp:Label runat="server" Visible="False" ID="lblOrgID" 
                                                                                                                Text='<%# DataBinder.Eval(Container.DataItem, "OrgID") %>' 
                                                                                                                meta:resourcekey="lblOrgIDResource3"></asp:Label>
                                                                                                                <asp:Label runat="server" ID="lblDate" Text="Date: " 
                                                                                                                meta:resourcekey="lblDateResource1"></asp:Label>
                                                                                                            </b>
                                                                                                            <asp:Label runat="server" ID="lblBillDate" 
                                                                                                                Text='<%# DataBinder.Eval(Container.DataItem, "BillDate") %>' 
                                                                                                                meta:resourcekey="lblBillDateResource1"></asp:Label></b>
                                                                                                            <asp:Label runat="server" ID="lblPatientCount" Text="0" 
                                                                                                                meta:resourcekey="lblPatientCountResource1"></asp:Label>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:GridView ID="gvOrgwisePatientDetail" runat="server" AutoGenerateColumns="False"
                                                                                                                OnRowDataBound="gvOrgwisePatientDetail_RowDataBound" ForeColor="#333333"
                                                                                                                CssClass="mytable1 gridVIew w-100p" 
                                                                                                                meta:resourcekey="gvOrgwisePatientDetailResource1">
                                                                                                                <Columns>
                                                                                                                    <asp:BoundField DataField="PatientNumber"
                                                                                                                        HeaderText="Patient number" meta:resourcekey="BoundFieldResource19">
                                                                                                                        <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                                                                                    </asp:BoundField>
                                                                                                                    <asp:TemplateField HeaderText="Name" meta:resourcekey="TemplateFieldResource2">
                                                                                                                        <ItemTemplate>
                                                                                                                            <asp:Label runat="server" ID="lblPatientName" 
                                                                                                                                Text='<%# DataBinder.Eval(Container.DataItem, "PatientName") %>' 
                                                                                                                                meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                                                                                                        </ItemTemplate>
                                                                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                                                                    </asp:TemplateField>
                                                                                                                    <asp:BoundField DataField="Age" HeaderText="Age" 
                                                                                                                        meta:resourcekey="BoundFieldResource20"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="BillNumber" HeaderText="Bill number" 
                                                                                                                        meta:resourcekey="BoundFieldResource21"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="BillAmount" HeaderText="Bill amount" 
                                                                                                                        meta:resourcekey="BoundFieldResource22"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="TaxAmount" HeaderText="Tax" 
                                                                                                                        meta:resourcekey="BoundFieldResource23"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="ServiceCharge" HeaderText="Service charge" 
                                                                                                                        meta:resourcekey="BoundFieldResource24"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="HOSRefund" HeaderText="Redeem" 
                                                                                                                        meta:resourcekey="BoundFieldResource25"></asp:BoundField> 
                                                                                                                    <asp:BoundField DataField="Discount" HeaderText="Discount" 
                                                                                                                        meta:resourcekey="BoundFieldResource26"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="RefundAmt" HeaderText="Refund amount" 
                                                                                                                        meta:resourcekey="BoundFieldResource27">
                                                                                                                    </asp:BoundField>
                                                                                                                    <asp:BoundField DataField="RoundOff" HeaderText="RoundOff amount" 
                                                                                                                        meta:resourcekey="BoundFieldResource28"/>
                                                                                                                    <asp:BoundField DataField="NetValue" HeaderText="Net amount" 
                                                                                                                        meta:resourcekey="BoundFieldResource29"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="ReceivedAmount" HeaderText="Received amount" 
                                                                                                                        meta:resourcekey="BoundFieldResource30"></asp:BoundField>
                                                                                                                        <asp:BoundField DataField="AmtReceivedServiceCharge" HeaderText="Advance amount" ></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="Cash" HeaderText="Cash" 
                                                                                                                        meta:resourcekey="BoundFieldResource31"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="Cards" HeaderText="Cards" 
                                                                                                                        meta:resourcekey="BoundFieldResource32"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="Cheque" HeaderText="Cheque" 
                                                                                                                        meta:resourcekey="BoundFieldResource33"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="DD" HeaderText="DD" 
                                                                                                                        meta:resourcekey="BoundFieldResource34"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="Coupon" HeaderText="Coupon" 
                                                                                                                        meta:resourcekey="BoundFieldResource35"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="Due" HeaderText="Due" 
                                                                                                                        meta:resourcekey="BoundFieldResource36"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="TotalAmount" HeaderText="Due Paid Amount" 
                                                                                                                        meta:resourcekey="BoundFieldResource37"></asp:BoundField> 
                                                                                                                     <asp:TemplateField HeaderText="Due Paid Date" 
                                                                                                                        meta:resourcekey="TemplateFieldResource3">
                                                                                                                        <ItemTemplate>
                                                                                                                            <%# GetDate(DataBinder.Eval(Container.DataItem, "RegistrationDate", "{0:dd/MM/yyyy}").ToString())%>
                                                                                                                        </ItemTemplate>
                                                                                                                         <HeaderStyle HorizontalAlign="Left" />
                                                                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                                                                    </asp:TemplateField>
                                                                                                                    <asp:BoundField DataField="WriteOffAmount" HeaderText="Write-Off amount" 
                                                                                                                        meta:resourcekey="BoundFieldResource38"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="RefphysicianName" HeaderText="Physician" 
                                                                                                                        meta:resourcekey="BoundFieldResource39"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="ClientTypeName" HeaderText="Hospital" 
                                                                                                                        meta:resourcekey="BoundFieldResource40"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="ClientName" HeaderText="Client" 
                                                                                                                        meta:resourcekey="BoundFieldResource41"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="Location" HeaderText="Location" 
                                                                                                                        meta:resourcekey="BoundFieldResource42"></asp:BoundField>
                                                                                                                    <asp:BoundField DataField="VisitNumber" HeaderText="VisitNumber"
																													    meta:resourcekey="BoundFieldResource43"></asp:BoundField> 
                                                                                                                    <asp:BoundField DataField="UserName" HeaderText="User Name"
																													    meta:resourcekey="BoundFieldResource44"></asp:BoundField> 
																														 
                                                                                                                    <asp:TemplateField HeaderText="ClientType"  meta:resourcekey="TemplateField1Resource1">
                                                                                                                      <ItemTemplate>
                                                                                                                         <asp:Label ID="lblclienttype" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "WardName") %>'></asp:Label>
                                                                                                                      </ItemTemplate>
                                                                                                                    </asp:TemplateField>
                                                                                                                    <%--<asp:BoundField DataField="VisitNumber" HeaderText="VisitNumber" meta:resourcekey="BoundFieldResource43"></asp:BoundField> 
                                                                                                                    <asp:BoundField DataField="UserName" HeaderText="User Name" meta:resourcekey="BoundFieldResource44"></asp:BoundField> 
                                                                                                                    <asp:TemplateField HeaderText="ClientType" meta:resourcekey="TemplateField1Resource1">
                                                                                                                      <ItemTemplate>
                                                                                                                         <asp:Label ID="lblclienttype" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "WardName") %>'></asp:Label>
                                                                                                                      </ItemTemplate>
                                                                                                                    </asp:TemplateField>--%>
                                                                                                                </Columns>
                                                                                                                <RowStyle HorizontalAlign="Right" />
                                                                                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" HorizontalAlign="Right" />
                                                                                                            </asp:GridView>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                    </Columns>
                                                                                </asp:GridView>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <br />
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

<script language="javascript" type="text/javascript">
    function setContextClientValue() {
        var sval = document.getElementById('<%= ddlClientType.ClientID %>').value + "^" + document.getElementById('<%= ddlTrustedOrg.ClientID %>').value;
        $find('<%= AutoCompleteExtenderClient.ClientID %>').set_contextKey(sval);
        return false;
    }
    function SetContextValue() {
        var rec = document.getElementById('hdnReferringHospitalID').value;    
        var sval = document.getElementById('<%= ddlTrustedOrg.ClientID %>').value;
        $find('<%= AutoCompleteExtenderReferringHospital.ClientID %>').set_contextKey(sval);
        $find('<%= AutoCompleteExtenderReferringPhysician.ClientID %>').set_contextKey("RPH^" + sval + "^" + rec);
        return false;
    }
</script>

