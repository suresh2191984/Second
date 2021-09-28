<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MonthwiseDispensingReport.aspx.cs"
    Inherits="InventoryReports_MonthwiseDispensingReport" meta:resourcekey="PageResource1"
    EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Month wise Dispensing Report</title>
    <style type="text/css">
        .TableDesign
        {
            border: solid 1px #FFFFFF;
            width: 100;
            border: solid 1px #FFFFFF;
            margin: 1px 1px 1px 1px;
            padding: 1px 1px 1px 1px;
            font-weight: bold;
            font-size: larger;
            color: White;
            background-color: #3093cf;
        }
        .Tableheader
        {
            border: solid 1px #FFFFFF;
            width: 100;
            border: solid 1px #FFFFFF;
            margin: 1px 1px 1px 1px;
            padding: 1px 1px 1px 1px;
            font-weight: bold;
            font-size: larger;
            color: Black;
            background-color: #3093cf;
        }
    </style>

   

    <script runat="server">
        decimal TotalUnitPrice;
        decimal GetUnitPrice(decimal Price)
        {
            //if (Price == "")
            //    Price = 0;
            TotalUnitPrice += Price;
            return Price;
        }
        decimal GetTotal()
        {
            return TotalUnitPrice;
        }
    </script>

    <style type="text/css">
        .Grid
        {
            border: solid 1px #FFFFFF;
        }
        .Grid td
        {
            border: solid 1px #FFFFFF;
            margin: 1px 1px 1px 1px;
            padding: 1px 1px 1px 1px;
        }
        .GridHeader
        {
            font-weight: bold;
            font-size: larger;
            color: White;
            background-color: #3093cf;
        }
        .GridItem
        {
            background-color: #e6e6e6;
        }
        .GridAltItem
        {
            background-color: #3093cf;
        }
    </style>
</head>
<body id="oneColLayout">
    <form id="form1" runat="server">
    <asp:scriptmanager id="ctlTaskScriptMgr" runat="server">
    </asp:scriptmanager>
    <attune:attuneheader id="Attuneheader" runat="server"></attune:attuneheader>
    <div class="contentdata" id="divcontentdata" runat="server">
        <table class="searchPanel w-100p">
            <tr>
                <td>
                    <table width="100%" id="Table2" runat="server" border="0" cellspacing="0" cellpadding="0" style="font-family: Verdana; font-size: 10px;">
                        <tr>
                            <td align="center">
                                <asp:label id="lblReportHeader" runat="server" text="LAPORAN PEMAKAIAN OBAT PER PASIEN" style="font-size: 14px; font-weight: bold;" meta:resourcekey="lblReportHeaderResource1"></asp:label><br>
                                <asp:label id="lblSel" runat="server" text="SELURUH GUDANG" meta:resourcekey="lblSelResource1"></asp:label><br>
                                <asp:label id="lblSelu1" runat="server" text="SELURUH JENIS TRANSSAKSI" meta:resourcekey="lblSelu1Resource1"></asp:label><br>
                                <asp:label id="lblPeriod" runat="server"></asp:label><br>
                            </td>
                        </tr>
                        <tr id="trSelect" runat="server">
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:label id="Rs_FromDate" text="Select Month  " runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDisFMon"  onkeypress="return ValidateSpecialAndNumeric(this);"
                                                CssClass="small monthYearPicker" runat="server"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:label id="Label5" text="From  " runat="server" meta:resourcekey="Label5Resource1"></asp:label>
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" ID="txtFromDate"  onkeypress="return ValidateSpecialAndNumeric(this);"
                                                CssClass="small datePickerPres"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:label id="Label6" text="To" runat="server" meta:resourcekey="Label6Resource1"></asp:label>
                                        </td>
                                        <td>
                                            <asp:TextBox runat="server" ID="txtToDate"  onkeypress="return ValidateSpecialAndNumeric(this);"
                                                CssClass="small datePickerPres"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:label id="lblPatientNumber" text="UHID" runat="server" meta:resourcekey="lblPatientNumberResource1"></asp:label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPatientNumber" OnkeyPress="return ValidateMultiLangChar(this)"
                                                CssClass="small" runat="server"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:label id="Label1" text="Patient Name" runat="server" meta:resourcekey="Label1Resource1"></asp:label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPatientName" OnkeyPress="return ValidateMultiLangCharacter(this)"
                                                CssClass="small" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap">
                                            <asp:label id="Label2" text="Client Name" runat="server" meta:resourcekey="Label2Resource1"></asp:label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtClientname" OnkeyPress="return ValidateMultiLangChar(this)" CssClass="small"
                                                runat="server"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientname"
                                                EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetRateCardForBillingClient"
                                                ServicePath="~/PlatForm/CommonWebServices/CommonServices.asmx" DelimiterCharacters=""
                                                Enabled="True" OnClientItemSelected="ClientSelected">
                                            </ajc:AutoCompleteExtender>
                                            <asp:HiddenField ID="HdnClientID" runat="server" Value="0"></asp:HiddenField>
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:label id="Label4" text="Location Name" runat="server" meta:resourcekey="Label4Resource1"></asp:label>
                                        </td>
                                        <td>
                                            <asp:dropdownlist id="ddlLocation" runat="server" cssclass="small"></asp:dropdownlist>
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:label id="Label7" text="Status" runat="server" meta:resourcekey="Label7Resource1"></asp:label>
                                        </td>
                                        <td>
                                            <asp:dropdownlist id="ddlStatus" runat="server" cssclass="small">
                                                <asp:listitem value="0" text="--Select--" selected="True"></asp:listitem>
                                                <asp:listitem value="Admitted" text="Admission"></asp:listitem>
                                                <asp:listitem value="Discharged" text="Discharge"></asp:listitem>
                                            </asp:dropdownlist>
                                        </td>
                                        <td colspan="2">
                                            <asp:button id="btnGo" text="Go" runat="server" onclick="btnGo_Click" cssclass="btn" onclientclick="javascript:return Validation();" meta:resourcekey="btnGoResource1"></asp:button>&nbsp;
                                                 <asp:linkbutton id="lnkBack" text="Back" font-underline="True" runat="server" cssclass="btn" onclick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:linkbutton>&nbsp;
                                            <asp:imagebutton id="imgBtnXL" onclick="imgBtnXL_Click" runat="server" imageurl="../PlatForm/images/ExcelImage.GIF" tooltip="Save As Excel"></asp:imagebutton>&nbsp;
                                            <asp:imagebutton id="btnPrint" runat="server" imageurl="~/PlatForm/images/printer.gif" onclientclick="return popupprint();" tooltip="Print" width="16px"></asp:imagebutton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr id="TrSecondRow" runat="server">
                            <td>
                                <table>
                                    <tr>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div id="prnReport">
                                    <asp:gridview id="gvIPReport" runat="server" autogeneratecolumns="False" visible="true" showheader="false" meta:resourcekey="gvIPReportResource1" onrowdatabound="gvIPReport_RowDataBound" allowpaging="true" pagesize="1" onpageindexchanging="gvIPReport_PageIndexChanging">
                                        <columns>
                                            <asp:templatefield meta:resourcekey="gvIPReport_templatefieldResource2">
                                                <itemtemplate>
                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                        <br>
                                                        <br>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:label id="lblDateText" text="Date" runat="server" meta:resourcekey="lblDateTextResource1"></asp:label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:label id="lblDate" runat="server" style="font-weight: 700"></asp:label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:label id="Label3" text="Visit Date" runat="server" meta:resourcekey="Label3Resource1"></asp:label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:label id="lblVisitDate" runat="server" style="font-weight: 700" text='<%# Eval("VisitDate", "{0:d}")%>'></asp:label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:label id="lblMrdNo" text="UHID" runat="server" meta:resourcekey="lblMrdNoResource1"></asp:label>/
                                                                <asp:label id="Rs_PatientName" text="Name" runat="server" meta:resourcekey="Rs_PatientNameResource1"></asp:label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:label id="lblPatientNumber" runat="server" style="font-weight: 700" text='<%# Bind("PatientNumber") %>'></asp:label>/
                                                                <asp:label id="lblName" runat="server" style="font-weight: 700" text='<%# Bind("Name") %>'></asp:label>
                                                                <asp:hiddenfield id="hdnFinalBillId" runat="server" value='<%# Bind("FinalBillID") %>'></asp:hiddenfield>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:label id="lblLunas" text="Sts Lunas Pembayaran Medis" runat="server" meta:resourcekey="lblLunasResource1"></asp:label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:label id="lblLuans" runat="server" style="font-weight: 700" text="-" meta:resourcekey="lblLuansResource1"></asp:label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:label id="lblRegistrasi" text="Registration No" runat="server" meta:resourcekey="lblRegistrasiResource1"></asp:label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:label id="lblRegNo" runat="server" style="font-weight: 700;" text='<%# Bind("VersionNo") %>'></asp:label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:label id="lblRoomtext" text="Room" runat="server" meta:resourcekey="lblRoomtextResource1"></asp:label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:label id="lblRoom" runat="server" style="font-weight: 700" text='<%# Bind("FileNo") %>'></asp:label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:label id="lblDockerText" text="Doctor Name" runat="server" meta:resourcekey="lblDockerTextResource1"></asp:label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:label id="lblDockor" runat="server" style="font-weight: 700;" text='<%# Bind("PhysicianName") %>'></asp:label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:label id="lblClienttext" text="Client Name" runat="server" meta:resourcekey="lblClienttextResource1"></asp:label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:label id="lblClientname" runat="server" style="font-weight: 700;" text='<%# Bind("TPAName") %>'></asp:label>
                                                            </td>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:label id="lblPesertaText" text="No.Peserta" runat="server" meta:resourcekey="lblPesertaTextResource1"></asp:label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:label id="lblPeserta" runat="server" style="font-weight: 700;" text="-" meta:resourcekey="lblPesertaResource1"></asp:label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:label id="lblNoSip" text="SIP No" runat="server" meta:resourcekey="lblNoSipResource1"></asp:label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:label id="lblSIPNo" runat="server" style="font-weight: 700;" text="-" meta:resourcekey="lblSIPNoResource1"></asp:label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap">
                                                                <asp:label id="lblMonthtext" text="Month-Year" runat="server" meta:resourcekey="lblMonthtextResource1"></asp:label>
                                                            </td>
                                                            <td width="83%" align="left" nowrap="nowrap">
                                                                <asp:label id="lblMonth" runat="server" style="font-weight: 700;"></asp:label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4">
                                                                <asp:gridview id="gvIPCreditMain" runat="server" autogeneratecolumns="False" cssclass="gridView w-100p" meta:resourcekey="gvIPCreditMainResource1" headerstyle-cssclass="gridHeader">
                                                                    <columns>
                                                                        <asp:templatefield headertext="No" meta:resourcekey="gvIPCreditMain_templatefieldResource2">
                                                                            <itemtemplate>
                                                                                <%# Container.DataItemIndex + 1 %>
                                                                                <asp:hiddenfield id="hdnFinalId" runat="server" value='<%# Bind("FinalBillID") %>'></asp:hiddenfield>
                                                                                <asp:hiddenfield id="hdnFeeID" runat="server" value='<%# Bind("FeeId") %>'></asp:hiddenfield>
                                                                                <asp:hiddenfield id="hdnFeeDescription" runat="server" value='<%# Bind("FeeDescription") %>'></asp:hiddenfield>
                                                                            </itemtemplate>
                                                                        </asp:templatefield>
                                                                        <asp:boundfield datafield="FeeDescription" headertext="Product Name" headerstyle-width="20%" meta:resourcekey="gvIPCreditMain_boundfieldResource4"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_1" headertext="1" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource6"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_2" headertext="2" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource8"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_3" headertext="3" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource10"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_4" headertext="4" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource12"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_5" headertext="5" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource14"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_6" headertext="6" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource16"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_7" headertext="7" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource18"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_8" headertext="8" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource20"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_9" headertext="9" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource22"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_10" headertext="10" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource24"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_11" headertext="11" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource26"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_12" headertext="12" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource28"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_13" headertext="13" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource30"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_14" headertext="14" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource32"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_15" headertext="15" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource34"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_16" headertext="16" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource36"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_17" headertext="17" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource38"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_18" headertext="18" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource40"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_19" headertext="19" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource42"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_20" headertext="20" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource44"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_21" headertext="21" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource46"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_22" headertext="22" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource48"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_23" headertext="23" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource50"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_24" headertext="24" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource52"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_25" headertext="25" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource54"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_26" headertext="26" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource56"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_27" headertext="27" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource58"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_28" headertext="28" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource60"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_29" headertext="29" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource62"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_30" headertext="30" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource64"></asp:boundfield>
                                                                        <asp:boundfield datafield="Col_31" headertext="31" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource66"></asp:boundfield>
                                                                        <asp:boundfield datafield="Total" headertext="Total" dataformatstring="{0:N}" meta:resourcekey="gvIPCreditMain_boundfieldResource68"></asp:boundfield>
                                                                    </columns>
                                                                </asp:gridview>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </itemtemplate>
                                            </asp:templatefield>
                                        </columns>
                                    </asp:gridview>
                                    <div id="divContainer" runat="server">
                                    </div>
                                    <asp:label id="lblMainReport" runat="server"></asp:label>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <attune:attunefooter id="Attunefooter" runat="server"></attune:attunefooter>
    <asp:hiddenfield id="hdnMessages" runat="server"></asp:hiddenfield>

    <script type="text/javascript">

        function popupprint() {

            document.getElementById('trSelect').style.display = "none";
            document.getElementById('TrSecondRow').style.display = "none";

            var prtContent = document.getElementById('divcontentdata');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            document.getElementById('trSelect').style.display = "block";
            document.getElementById('TrSecondRow').style.display = "block";
            return false;

        }
        function ClientSelected(source, eventArgs) {
            var Result = JSON.parse(eventArgs.get_value());
            var list = Result.lstClientName;
            document.getElementById('<%= HdnClientID.ClientID %>').value = list.ClientID;
            document.getElementById('<%= txtClientname.ClientID %>').value = list.ClientName;
        }
        function SilentPrint() {
            window.print();
        }
    </script>

    <div id="tblHostional" style="display: none;">
        <table>
            <tr>
                <td valign='bottom'>
                    <img id="imgPath" runat="server">
                </td>
                <td>
                    <asp:label id="lblHosital" runat="server" style="font-weight: bold;"></asp:label>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:label id="lblReport" runat="server" style="font-weight: bold;"></asp:label>
                </td>
            </tr>
        </table>
    </div>
    <asp:hiddenfield id="hdnPageName" runat="server"></asp:hiddenfield>

    <script language="javascript" type="text/javascript">
        function Validation() {
            var errorMsg = SListForAppMsg.Get('InventoryReports_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryReports_Error');

          
            if (document.getElementById('txtDisFMon').value == '') {
                // alert('Please Select a Month..');
                var userMsg = SListForAppMsg.Get("InventoryReports_MonthwiseDispensingReport_aspx_01") == null ? "Please Select a Month!" : SListForAppMsg.Get("InventoryReports_MonthwiseDispensingReport_aspx_01");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            else if (document.getElementById('HdnClientID').value == '0') {
            var userMsg = SListForAppMsg.Get("InventoryReports_MonthwiseDispensingReport_aspx_02") == null ? "Please Select a Client Name!" : SListForAppMsg.Get("InventoryReports_MonthwiseDispensingReport_aspx_02");
                ValidationWindow(userMsg, errorMsg);
               // alert('Please Select a Client Name..');
                return false;
            }           
            else {
                return true;
            }
        }
		$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>

    </form>
</body>
</html>
