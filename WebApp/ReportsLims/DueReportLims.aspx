<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DueReportLims.aspx.cs" Inherits="ReportsLims_DueReportLims"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>
        <%=Resources.ReportsLims_AppMsg.ReportsLims_DueReportLims_aspx_hdr %>
    </title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script language="javascript" type="text/javascript">
        function alpha(e) {
            var k;
            document.all ? k = e.keyCode : k = e.which;
            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57));
        }
        function setContextValue() {
            var sval = document.getElementById('ddlClientType').value + "^" + document.getElementById('ddlTrustedOrg').value;
            $find('AutoCompleteExtenderClient').set_contextKey(sval);
            return false;
        }
        function ClearValue(obj) {
            if (document.getElementById(obj).value == "") {
                document.getElementById('hdnSelectedClientID').value = "0";
            }
        }
        function SelectedClientID(source, eventArgs) {
            document.getElementById('hdnSelectedClientID').value = eventArgs.get_value();
        }
        function validateToDate() {
            var UsrDispAlrt = SListForAppMsg.Get("ReportsLims_DueReportLims_aspx_01") != null ? SListForAppMsg.Get("ReportsLims_DueReportLims_aspx_01") : "Provide / select value for From date";
            var AlrtWinHdr = SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") != null ? SListForAppMsg.Get("ReportsLims_DiscountReportLims_aspx_winhdr") : "Alert";
            var UsrDispAlrt1 = SListForAppMsg.Get("ReportsLims_DueReportLims_aspx_02") != null ? SListForAppMsg.Get("ReportsLims_DueReportLims_aspx_02") : "Provide / select value for To date";
            if (document.getElementById('txtFDate').value == '') {
                // alert('Provide / select value for From date');
                ValidationWindow(UsrDispAlrt, AlrtWinHdr);
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                //alert('Provide / select value for To date');
                ValidationWindow(UsrDispAlrt1, AlrtWinHdr);
                document.getElementById('txtTDate').focus();
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
        function ChkSelectType() {
            //  
            if (document.getElementById('rdoDuePaid').checked) {
                document.getElementById('tdName').style.display = 'none';
                document.getElementById('hdnReportType').value = "DPL";
                document.getElementById('divOPDWCR').style.display = 'none';
                document.getElementById('dvDuepaid').style.display = 'block';
                document.getElementById('Payment').style.display = 'table-cell';
                document.getElementById('PaymentDrp').style.display = 'table-cell';
            }
            if (document.getElementById('rdoDueList').checked) {
                document.getElementById('tdName').style.display = 'table';
                document.getElementById('hdnReportType').value = "DL";
                document.getElementById('divOPDWCR').style.display = 'block';
                document.getElementById('dvDuepaid').style.display = 'none';
                document.getElementById('Payment').style.display = 'none';
                document.getElementById('PaymentDrp').style.display = 'none';
            }
        }
        function clearContextText() {
            $('#contentArea').hide();

        }
    </script>

    <script runat="server">
        string _date;
        string GetDate(string Date)
        {
            if (Date != "01/01/0001")
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
                          /*  $(function() {
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
                                <asp:UpdatePanel ID="updatePanel1" runat="server">
                                    <ContentTemplate>
                                        <td class="a-left">
                                            <div class="dataheaderWider">
                                                <table id="tbl">
                                                    <tr>
                                        <td class="w-7p">
                                            <asp:Label ID="lblOrgs" runat="server" Text="Organization : " meta:resourcekey="lblOrgsResource1"></asp:Label>
                                                        </td>
                                                        <td class="w-10p">
                                                            <asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" runat="server"
                                                                CssClass="ddl">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td id="Td3" class="w-5p" runat="server">
                                            <asp:Label ID="lblLocation" Text="Location : " Font-Bold="False" runat="server" meta:resourcekey="lblLocationResource1"></asp:Label>
                                                        </td>
                                                        <td id="Td4" class="w-10p" runat="server">
                                                            <asp:DropDownList ID="drpLocation" Width="180px" runat="server" CssClass="ddl">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="a-left w-13p">
                                            <asp:Label ID="Rs_FromDate" Text="From date:" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                            <asp:TextBox ID="txtFDate" CssClass="Txtboxsmall" Width="70px" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                        </td>
                                                        <td class="w-12p">
                                            <asp:Label ID="Rs_ToDate" Text="To date :" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                            <asp:TextBox ID="txtTDate" CssClass="Txtboxsmall" Width="70px" runat="server" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                        </td>
                                                        <td class="w-20p">
                                            <asp:Label ID="Rs_SelectCurrency" Text="Select currency : " runat="server" meta:resourcekey="Rs_SelectCurrencyResource1"></asp:Label>
                                                            <asp:DropDownList ID="ddlCurrency" CssClass="ddl" ToolTip="Select currency" runat="server"
                                                                Width="120px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="a-left v-top w-18p">
                                            <asp:Panel ID="pnReportType" CssClass="w-100p" GroupingText="Report type" runat="server"
                                                meta:resourcekey="pnReportTypeResource1">
                                                                <asp:RadioButton ID="rdoDuePaid" runat="server" GroupName="rdo" onclick="javascript:ChkSelectType();"
                                                    Text="Due paid report" Checked="True" meta:resourcekey="rdoDuePaidResource1" />
                                                                <asp:RadioButton ID="rdoDueList" runat="server" onclick="javascript:ChkSelectType();"
                                                    GroupName="rdo" Text="Due report" meta:resourcekey="rdoDueListResource1" />
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <tr class="v-top">
                                        <td class="w-6p" id="Payment" runat="server">
                                            <asp:Label ID="Rs_PaymentMode" Text="Payment Mode : " runat="server" meta:resourcekey="Rs_PaymentModeResource1"></asp:Label>
                                                        </td>
                                                        <td  id="PaymentDrp" runat="server">
                                                        <asp:DropDownList ID="DropDownListPM" CssClass="ddl" ToolTip="Select Mode" runat="server"
                                                                Width="120px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td colspan="8">
                                                            <table class="w-100p" id="tdName" runat="server"
                                                                style="display: none;">
                                                                <tr class="v-top">
                                                                    <%--<td style="width: 6%;">
                                                                        <asp:Panel ID="pnlVisitType" Width="100%" GroupingText="Visit type" runat="server">
                                                                            <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" runat="server">
                                                                                <asp:ListItem Text="OP" Selected="True" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                                <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                                <asp:ListItem Text="OP&IP" Value="-1" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </asp:Panel>
                                                                    </td>--%>
                                                                    <td class="w-20p a-left" id="tdtypeofpatient" runat="server">
                                                        <asp:Panel ID="pnlBillType" CssClass="w-100p" GroupingText="Bill type" runat="server"
                                                            meta:resourcekey="pnlBillTypeResource1">
                                                                            <asp:RadioButtonList ID="Rbltypeofpatient" RepeatDirection="Horizontal" runat="server">
                                                                <%--<asp:ListItem Text="Cash" Value="Cash" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                                                <asp:ListItem Text="Credit" Value="Credit" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                                                <asp:ListItem Text="Credit&Cash" Value="Creditandcash" Selected="True" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                                            --%></asp:RadioButtonList>
                                                                        </asp:Panel>
                                                                    </td>
                                                                    <td class="w-30p">
                                                        <asp:Panel ID="Panel1" CssClass="w-100p" GroupingText="Patient" runat="server" meta:resourcekey="Panel1Resource1">
                                                                            <table class="w-100p">
                                                                                <tr>
                                                                                    <td class="w-50p">
                                                                        <asp:Label ID="lblName" Text="Name:" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                                                                                        <asp:TextBox ID="txtName" Width="120px" CssClass="Txtboxsmall" autocomplete="off"
                                                                            runat="server" meta:resourcekey="txtNameResource1"></asp:TextBox>
                                                                                    </td>
                                                                                    <td class="w-45p">
                                                                        <asp:Label ID="lblPNo" Text="No:" runat="server" meta:resourcekey="lblPNoResource1"></asp:Label>
                                                                                        <asp:TextBox ID="txtPNo" Width="120px" CssClass="Txtboxsmall" autocomplete="off"
                                                                            runat="server" MaxLength="10" onkeypress="return onEnterKeyPress(event);" meta:resourcekey="txtPNoResource1"></asp:TextBox>
                                                                                    </td>
                                                                                    <td class="w-5p">
                                                                                        &nbsp;
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:Panel>
                                                                    </td>
                                                                    <td id="tblClientType" class="w-30p">
                                                        <asp:Panel ID="Panel2" CssClass="&quot;w-100p&quot;&quot;" GroupingText="Client"
                                                            runat="server" meta:resourcekey="Panel2Resource1">
                                                                            <table class="w-100p">
                                                                                <tr class="v-bottom">
                                                                                    <td class="w-45p">
                                                                        <asp:Label ID="lblClientType" Font-Bold="False" runat="server" Text="Type : " meta:resourcekey="lblClientTypeResource1"></asp:Label>
                                                                        <asp:DropDownList ID="ddlClientType" Width="120px" runat="server" CssClass="ddl"
                                                                            meta:resourcekey="ddlClientTypeResource1">
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    <td class="w-10p">
                                                                        <asp:Label ID="lblClient" Style="display: block;" Text="Name : " Font-Bold="False"
                                                                            runat="server" meta:resourcekey="lblClientResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td class="w-45p">
                                                                        <asp:TextBox ID="txtClient" onfocus="setContextValue();" Style="display: block; width: 90%;"
                                                                                              OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" onblur="javascript:ClearValue(this.id);ConverttoUpperCase(this.id);"
                                                                            autocomplete="off" CssClass="Txtboxsmall" runat="server" Width="120px" meta:resourcekey="txtClientResource1"></asp:TextBox>
                                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClient" runat="server" TargetControlID="txtClient"
                                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientList"
                                                                                            OnClientItemSelected="SelectedClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                                            Enabled="True">
                                                                                        </ajc:AutoCompleteExtender>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:Panel>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-center" colspan="10">
                                                            <asp:Button ID="btnSubmit" runat="server" Text="Get report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                            &nbsp; &nbsp;<asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server"
                                                                CssClass="details_label_age" OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                        &nbsp;&nbsp;
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <div id="progressBackgroundFilter" class="a-center">
                                                    </div>
                                                    <div id="processMessage" class="a-center w-20p">
                                        <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                            meta:resourcekey="img1Resource1" />
                                                    </div>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                            <div id="contentArea">
                                                <div id="divPrint" style="display: none;" runat="server">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="a-right paddingR10" style="color: #000000;">
                                                                <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                    ToolTip="Save as excel" Style="width: 16px" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                                &nbsp;<asp:Label ID="Rs_PrintReport" Text="Print report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                                                &nbsp;
                                                                <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                                    ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div id="prnReport">
                                                    <div id="divOPDWCR" runat="server" style="display: none;">
                                        <asp:GridView ID="grdDueReport" runat="server" AutoGenerateColumns="False" CssClass="dataheader2 gridView w-100p"
                                            OnRowDataBound="grdDueReport_RowDataBound" meta:resourcekey="grdDueReportResource1">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <RowStyle HorizontalAlign="Left" />
                                                            <Columns>
                                                <asp:TemplateField HeaderText="S.no" meta:resourcekey="TemplateFieldResource1">
                                                                    <ItemTemplate>
                                                                        <%# Container.DataItemIndex + 1 %>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                <asp:BoundField DataField="PatientName" HeaderStyle-HorizontalAlign="Center" HeaderText="Name"
                                                    meta:resourcekey="BoundFieldResource1"></asp:BoundField>
                                                <asp:BoundField DataField="PatientNumber" HeaderStyle-HorizontalAlign="Center" HeaderText="Patient no"
                                                    meta:resourcekey="BoundFieldResource2"></asp:BoundField>
                                                <asp:BoundField DataField="Age" HeaderStyle-HorizontalAlign="Center" HeaderText="Age/Sex"
                                                    meta:resourcekey="BoundFieldResource3"></asp:BoundField>
                                                <asp:BoundField DataField="BillNumber" HeaderStyle-HorizontalAlign="Center" HeaderText="Bill no"
                                                    meta:resourcekey="BoundFieldResource4"></asp:BoundField>
                                                <asp:TemplateField HeaderText="Bill date" HeaderStyle-HorizontalAlign="Center" SortExpression="VisitDate"
                                                    meta:resourcekey="TemplateFieldResource2">
                                                                    <ItemTemplate>
                                                                        <%# GetDate(DataBinder.Eval(Container.DataItem,"VisitDate","{0:D}").ToString())%>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                 <%--<asp:BoundField DataField="PaidCurrency" HeaderStyle-HorizontalAlign="Center" HeaderText="Paid Amount">
                                                                </asp:BoundField>--%>
                                                <asp:BoundField DataField="VisitType" HeaderStyle-HorizontalAlign="Center" HeaderText="Visit"
                                                    meta:resourcekey="BoundFieldResource5" />
                                                <asp:BoundField DataField="VisitNumber" HeaderStyle-HorizontalAlign="Center" HeaderText="Visit Number"
                                                    meta:resourcekey="BoundFieldResource6" />
                                                <asp:BoundField DataField="ReferredBy" HeaderStyle-HorizontalAlign="Center" HeaderText="Ref Physician Name"
												meta:resourcekey="BoundFieldResource14" />
                                                                
                                                <asp:BoundField DataField="IsCreditBill" HeaderStyle-HorizontalAlign="Center" HeaderText="Credit bill"
                                                    meta:resourcekey="BoundFieldResource7" />
                                                <asp:BoundField DataField="ClientName" HeaderStyle-HorizontalAlign="Center" HeaderText="Client name"
                                                    meta:resourcekey="BoundFieldResource8" />
                                                <asp:BoundField DataField="ClientTypeName" HeaderStyle-HorizontalAlign="Center" HeaderText="Client type"
                                                    meta:resourcekey="BoundFieldResource9" />
                                                <asp:BoundField DataField="UserName" HeaderStyle-HorizontalAlign="Center" HeaderText="User name"
                                                    meta:resourcekey="BoundFieldResource10" />
                                                <asp:BoundField DataField="NetValue" HeaderStyle-HorizontalAlign="Center" HeaderText="Net amount" />
                                                <asp:BoundField DataField="PaidCurrency" HeaderStyle-HorizontalAlign="Center" 
                                                  HeaderText="Amount Received"></asp:BoundField>     
                                                <asp:BoundField DataField="Discount" HeaderStyle-HorizontalAlign="Center" HeaderText="Discount"
                                                    meta:resourcekey="BoundFieldResource12" />
                                                <asp:BoundField DataField="Due" HeaderStyle-HorizontalAlign="Center" HeaderText="Due amount"
                                                    meta:resourcekey="BoundFieldResource13" />
                                                                
                                                            </Columns>
                                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                        </asp:GridView>
                                                        <br />
                                                        <div id="breakup">
                                                            <table id="tabGranTotal1" runat="server" visible="False" class="dataheaderWider w-100p" style="color: #000000;">
                                                                <tr id="Tr1" runat="server">
                                                                    <td id="Td1" class="a-right w-90p"  runat="server">
                                                        <asp:Label ID="Rs_TotalDueAmount" Text="Total due amount" runat="server" meta:resourcekey="Rs_TotalDueAmountResource1"></asp:Label>
                                                                        <label id="Label1" style="color: Green;" runat="server">
                                                                             <%=Resources.Reports_ClientDisplay.Reports_CCStmt_aspx_01%><%--(A)--%></label>
                                                                        :
                                                                    </td>
                                                                    <td id="Td2" class="a-right paddingR15" runat="server">
                                                                        <label id="lblDueTotal" runat="server">
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </div>
                                                    <div id="dvDuepaid" runat="server" style="display: none;">
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td class="dataheaderInvCtrl">
                                                                    <asp:Label ID="lblmsg" runat="server" Visible="False" meta:resourcekey="lblmsgResource1"></asp:Label>
                                                                    <asp:GridView ID="gvDuepaidReport" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                        AllowPaging="True" PageSize="100" CssClass="dataheader2" OnRowDataBound="gvDuepaidReport_RowDataBound"
                                                                        OnPageIndexChanging="gvDuepaidReport_PageIndexChanging" ShowFooter="True" meta:resourcekey="gvDuepaidReportResource1">
                                                                        <HeaderStyle HorizontalAlign="Left" CssClass="dataheader1"></HeaderStyle>
                                                                        <PagerStyle CssClass="dataheader1" />
                                                                        <RowStyle HorizontalAlign="Left"></RowStyle>
                                                                        <Columns>
                                                            <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource3">
                                                                                <ItemTemplate>
                                                                                    <%# Container.DataItemIndex + 1 %>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="VersionNo" HeaderStyle-HorizontalAlign="Center" HeaderText="Visit No."
                                                                meta:resourcekey="BoundFieldResource44"></asp:BoundField>
                                                                            <asp:TemplateField HeaderText="Patient Name">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblName" runat="server" Text='<%# Bind("PatientName") %>' Width="100px"
                                                                                        ></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Age/Sex" >
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblAge" runat="server" Text='<%# Bind("Age") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Due BillNo" >
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblDueBillNo" runat="server" Text='<%# Bind("DueBillNum") %>' ></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Due Paid BillNo" meta:resourcekey="TemplateFieldResource5">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblpaidBillNo" runat="server" Text='<%# Bind("PaidBillNum") %>' ></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="DueBillDate" HeaderText="Due Bill Date" meta:resourcekey="BoundFieldResource15" />
                                                            <asp:BoundField DataField="OutStandingAmt" HeaderText="Due Amount" meta:resourcekey="BoundFieldResource16" />
                                                            <asp:BoundField DataField="DiscountAmt" HeaderText="Discount Amount" meta:resourcekey="BoundFieldResource17" />
                                                                            <asp:TemplateField HeaderText="Paid Amount" meta:resourcekey="TemplateFieldResource7">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblPaidAmount" runat="server" Text='<%# Bind("PaidAmount") %>' meta:resourcekey="lblPaidAmountResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Paid Date" meta:resourcekey="TemplateFieldResource8">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblPaidDate" runat="server" Text='<%# Bind("PaidDate","{0:dd-MM-yyyy}") %>'
                                                                                        meta:resourcekey="lblPaidDateResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <%--<asp:BoundField DataField="PaidCurrency" HeaderText="Paid Currency" meta:resourcekey="BoundFieldResource8" />
                                                                            <asp:BoundField DataField="PaidCurrencyAmount" HeaderText="Paid Currency Amt" meta:resourcekey="BoundFieldResource9">
                                                                                <ItemStyle HorizontalAlign="Right" />
                                                                            </asp:BoundField>--%>
                                                                            <asp:BoundField DataField="BilledBy" HeaderText="Billed By" >
                                                                                <ItemStyle HorizontalAlign="left" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="ReceivedBy" HeaderText="Received By" >
                                                                                <ItemStyle HorizontalAlign="left" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="PaymentMode" HeaderText="Payment Mode">
                                                                                <ItemStyle HorizontalAlign="left" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="ChequeorCardNumber" HeaderText="Cheque or Card No." >
                                                                                <ItemStyle HorizontalAlign="left" />
                                                                            </asp:BoundField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="a-center">
                                                                    <asp:Label ID="lblPaidAmount" runat="server" meta:resourcekey="lblPaidAmountResource2"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <asp:HiddenField ID="hdnSelectedClientID" runat="server" Value="0" />
                                            <asp:HiddenField ID="hdnReportType" runat="server" Value="DPL" />
                                        </td>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="imgBtnXL" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </tr>
                        </table>
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />             
    </form>
</body>
</html>
