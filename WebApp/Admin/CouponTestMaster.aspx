<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CouponTestMaster.aspx.cs"
    Inherits="Admin_CouponTestMaster" meta:resourcekey="PageResource1" EnableEventValidation="true" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Coupon Test Master</title>
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />

<%-- <script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>--%>

    <script language="javascript" type="text/javascript">
        function CheckSearch() {
            var txtbarcode = document.getElementById('txtbarcode').value;
            var txtTestName = document.getElementById('txtTestName').value;
            var txtBarcodeValue = document.getElementById('txtBarcodeValue').value;
            var Couponlength = document.getElementById('hdnCouponlength').value;
            
            //Couponlength = ++Couponlength;
          
                      if (txtTestName == "") {

                document.getElementById('txtTestName').focus();
                alert('Please Enter The Test Name');
                return false;
            }
            var txtDrName = document.getElementById('txtDrName').value;
            if (txtDrName == "") {

                document.getElementById('txtDrName').focus();
                alert('Please Enter The Ref.Dr.Name');
                return false;
            }
            if (document.getElementById('txtFrmDate').value == '') {
                alert('Please Select Valid From Date');
                document.getElementById('txtFrmDate').focus();
                return false;
            }
            if (document.getElementById('txtToDate').value == '') {
                alert('Please Select Valid To Date');
                document.getElementById('txtToDate').focus();
                return false;
            }
            // alert(document.getElementById('rdosingle').checked);
            if (document.getElementById('rdosingle').checked == true) {
                if (txtbarcode == "") {
                    document.getElementById('txtbarcode').focus();
                    alert('Please Enter The Barcode');
                    return false;

                }

                if (txtbarcode.length != Couponlength) {
                    document.getElementById('txtbarcode').focus();
                    alert("Barcode Length should be "+ Couponlength +"  characters");
                    return false;
                }
                if (txtBarcodeValue == "") {
                    document.getElementById('txtBarcodeValue').focus();
                    alert('Please Enter The Barcode Amount');
                    return false;

                }
            }
            if (document.getElementById('rdobulk').checked == true) {

                var fulSelect = document.getElementById('fulSelect').value;
                if (fulSelect == "") {
                    document.getElementById('fulSelect').focus();
                    alert('Please Select The File To Upload');
                    return false;
                }
            }
            var dateEntered = document.getElementById("txtFrmDate").value;
            var date1 = dateEntered.substring(0, 2);
            var month1 = dateEntered.substring(3, 5);
            var year1 = dateEntered.substring(6, 10);
            var dateToCompare1 = new Date(year1, month1 - 1, date1);

            var dateEnteredto = document.getElementById("txtToDate").value;
            var date2 = dateEnteredto.substring(0, 2);
            var month2 = dateEnteredto.substring(3, 5);
            var year2 = dateEnteredto.substring(6, 10);
            var dateToCompare2 = new Date(year2, month2 - 1, date2);

            var currentDate = new Date();
            var date = currentDate.getDate();
            var month = currentDate.getMonth() + 1;
            var year = currentDate.getFullYear();
            var dateToCompare = new Date(year, month - 1, date);
            if (dateToCompare1 >= dateToCompare) {
                if (dateToCompare1 <= dateToCompare2) {
                    return true;
                }
                else {
                    alert("Valid To Date should not be lesser than Valid From date");
                    return false;
                }
                return true;
            }
            else {
                alert("Date should not be lesser than current date");
                return false;
            }

        }

        function CheckSearchUpdate() {

            var txtTestName = document.getElementById('txtTestName').value;
            if (txtTestName == "") {

                document.getElementById('txtTestName').focus();
                alert('Please Enter The Test Name');
                return false;
            }
            var txtDrName = document.getElementById('txtDrName').value;
            if (txtDrName == "") {

                document.getElementById('txtDrName').focus();
                alert('Please Enter The Ref.Dr.Name');
                return false;
            }
            if (document.getElementById('txtFrmDate').value == '') {
                alert('Please Select Valid From Date');
                document.getElementById('txtFrmDate').focus();
                return false;
            }
            if (document.getElementById('txtToDate').value == '') {
                alert('Please Select Valid To Date');
                document.getElementById('txtToDate').focus();
                return false;
            }

            if (document.getElementById('rdosingle').checked == true) {
                var txtbarcode = document.getElementById('txtbarcode').value;
                if (txtbarcode == "") {
                    document.getElementById('txtbarcode').focus();
                    alert('Please Enter The Barcode');
                    return false;
                }
                var txtBarcodeValue = document.getElementById('txtBarcodeValue').value;
                if (txtBarcodeValue == "") {
                    document.getElementById('txtBarcodeValue').focus();
                    alert('Please Enter The Barcode Value');
                    return false;
                }

            }
            if (document.getElementById('rdobulk').checked == true) {

                var fulSelect = document.getElementById('fulSelect').value;
                if (fulSelect == "") {
                    document.getElementById('fulSelect').focus();
                    alert('Please Select The File To Upload');
                    return false;
                }
            }
            var dateEntered = document.getElementById("txtFrmDate").value;
            var date1 = dateEntered.substring(0, 2);
            var month1 = dateEntered.substring(3, 5);
            var year1 = dateEntered.substring(6, 10);
            var dateToCompare1 = new Date(year1, month1 - 1, date1);

            var dateEnteredto = document.getElementById("txtToDate").value;
            var date2 = dateEnteredto.substring(0, 2);
            var month2 = dateEnteredto.substring(3, 5);
            var year2 = dateEnteredto.substring(6, 10);
            var dateToCompare2 = new Date(year2, month2 - 1, date2);

            var currentDate = new Date();
            var date = currentDate.getDate();
            var month = currentDate.getMonth() + 1;
            var year = currentDate.getFullYear();
            var dateToCompare = new Date(year, month - 1, date);

            if (dateToCompare1 <= dateToCompare2) {
                return true;
            }
            else {
                alert("Valid To Date should not be lesser than Valid From date");
                return false;
            }
            return true;

        }

        function RestrictChar(id) {

            var exp = String.fromCharCode(window.event.keyCode)
            var r = new RegExp("[0-9a-zA-Z \r]", "g");
            if (exp.match(r) == null) {
                window.event.keyCode = 0
                return false;
            }
        }
        function doValidate() {
            if (document.getElementById('fulSelect').value == '') {
                alert("Select Excel Sheet");
                return false;
            }
            else {

                return true;
            }
        }
        function rdocheck() {
            if (document.getElementById('rdobulk').checked == true) {
                document.getElementById('grpupload').style.display = 'block';
                document.getElementById('trBarcodevalue').style.display = 'none';
                document.getElementById('btnshow').style.display = 'none';

            }
            else {
                document.getElementById('grpupload').style.display = 'none';
                document.getElementById('trBarcodevalue').style.display = 'block';
                document.getElementById('btnshow').style.display = 'block';

            }
        }
    </script>

    <style type="text/css">
        .style2
        {
            height: 30px;
        }
    </style>
</head>
<body oncontextmenu="return false;">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                
                                <table class="dataheader3 w-100p">
                                    <tr>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <br />
                                                        <asp:HyperLink ID="lnkSampleFile" NavigateUrl="~/UploadFileSample/UploadCouponCode.csv" Target="_blank"
                                                            ForeColor="blue" Text="Help - Upload File Format" runat="server"></asp:HyperLink>
                                                        <br />
                                                        <span style="color: #009900">Note:<br />
                                                            Uploading File format should be *.csv
                                                            <br />
                                                            Length of the Upload File name should be less than or equal to 50.
                                                            <br />
                                                            Please upload less than or equal to 1000 entries in a file.<br />
                                                            <br />
                                                        </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="pnlcomman" runat="server">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblTestName" runat="server" Text="Test Name"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtTestName" ToolTip="Test Name" CssClass="AutoCompletesearchBox"
                                                                            runat="server"></asp:TextBox>
                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtTestName"
                                                                            EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" OnClientItemSelected="BillingItemSelected"
                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetBillingItems"
                                                                            FirstRowSelected="false" OnClientItemOver="TempBillingItemSelected" ServicePath="~/OPIPBilling.asmx"
                                                                            UseContextKey="True" DelimiterCharacters="" OnClientShown="InvPopulated" Enabled="True"
                                                                            OnClientPopulated="onTestListPopulated">
                                                                        </ajc:AutoCompleteExtender>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblRefDr" runat="server" Text="Ref.Phy"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtDrName" CssClass="AutoCompletesearchBox" runat="server" ToolTip="Refering Physician(Doctor) Name"
                                                                            MaxLength="255" meta:resourcekey="txtDrNameResource1"></asp:TextBox>
                                                                        <ajc:AutoCompleteExtender ID="AutoRname" runat="server" TargetControlID="txtDrName"
                                                                            FirstRowSelected="true" ServiceMethod="GetPhysician" ServicePath="~/WebService.asmx"
                                                                            CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="2" BehaviorID="AutoCompleteEx"
                                                                            CompletionInterval="10" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected">
                                                                        </ajc:AutoCompleteExtender>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblFrmDate" runat="server" Text="Valid From"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtFrmDate" ToolTip="Valid From Date" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                                        <td>
                                                                            <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                CausesValidation="False" />
                                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFrmDate"
                                                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                                Enabled="True" />
                                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                                ControlToValidate="txtFrmDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" />
                                                                            <ajc:CalendarExtender ID="CalendarExtender1" runat="server" PopupPosition="TopRight"
                                                                                TargetControlID="txtFrmDate" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom"
                                                                                Enabled="True" />
                                                                            <%--
                                                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="True" Format="dd/MM/yyyy"
                                                                        PopupButtonID="ImgFDate" TargetControlID="txtFrmDate" />
                                                                    <asp:ImageButton ID="ImgFDate" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                        meta:resourcekey="ImgFDateResource1" />--%>
                                                                        </td>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblToDate" runat="server" Text="Valid To"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtToDate" ToolTip="Valid To Date" runat="server" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                                        <td>
                                                                            &nbsp;&nbsp;
                                                                            <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                CausesValidation="False" />
                                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtToDate"
                                                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                                Enabled="True" />
                                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                                                ControlToValidate="txtToDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" />
                                                                            <ajc:CalendarExtender ID="CalendarExtender2" runat="server" PopupPosition="TopRight"
                                                                                TargetControlID="txtToDate" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo"
                                                                                Enabled="True" />
                                                                            <%--<ajc:CalendarExtender ID="CalendarExtender2" runat="server" Enabled="True" Format="dd/MM/yyyy"
                                                                        PopupButtonID="ImgTDate" TargetControlID="txtToDate" />
                                                                    <asp:ImageButton ID="ImgTDate" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                        meta:resourcekey="ImgTDateResource1" />--%>
                                                                        </td>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr id="trBarcodevalue">
                                                    <td>
                                                        <asp:Panel ID="pnlCoupon" runat="server">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblBarcode" runat="server" Text="Coupon Code"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtbarcode" ToolTip="Coupon Code" runat="server" 
                                                                               onkeypress="return ValidateOnlyNumeric(this);"  ></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblBarcodeValue" runat="server" Text="Amount"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtBarcodeValue" ToolTip="Coupon Code Value" runat="server"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                                            meta:resourcekey="txtConversionRateResource1"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Panel ID="Panel1" runat="server" class="w-50p">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:RadioButton ID="rdosingle" runat="server" Text="Single Record" Checked="true"
                                                                            onclick="rdocheck()" GroupName="GRP" TabIndex="1" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:RadioButton ID="rdobulk" runat="server" Text="Bulk Record" onclick="rdocheck()"
                                                                            GroupName="GRP" TabIndex="2" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblStatus" runat="server" Text="Coupon Status" Visible="false"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:CheckBox ID="chkStatus" runat="server" Visible="false" />
                                                                    </td>
                                                                    <td colspan="2">
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblActiveStatus" runat="server" Text="InActive"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:CheckBox ID="chkActiveStatus" ToolTip="InActive" runat="server" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                        <br />
                                                    </td>
                                                </tr>
                                                <tr class="a-left" id="grpupload" style="display: none;">
                                                    <td>
                                                        <asp:Panel ID="pnlupload" runat="server">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblSelectFile" runat="server" Text=" Upload File :" meta:resourcekey="lblSelectFileResource1"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:FileUpload ID="fulSelect" runat="server" />
                                                                        <td>
                                                                            <asp:Button ID="BtnSheet" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                onmouseout="this.className='btn'" Text="Save" meta:resourcekey="BtnSheetResource1"
                                                                                OnClick="BtnSheet_Click" OnClientClick="javascript:return CheckSearch();" />
                                                                        </td>
                                                                        <td>
                                                                            <asp:Button ID="btnUploadCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                onmouseout="this.className='btn'" meta:resourcekey="BtnSheetResource1" OnClick="btnUploadCancel_Click" />
                                                                        </td>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr id="btnshow" class="a-center">
                                                    <td>
                                                        <asp:Panel ID="pnlbtn" runat="server">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Button ID="btnSave" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                            onmouseout="this.className='btn'" Text="Save" meta:resourcekey="BtnSheetResource1"
                                                                            OnClick="btnSave_Click" OnClientClick="javascript:return CheckSearch();" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="btnUpdate" runat="server" CssClass="btn" Visible="false" onmouseover="this.className='btn btnhov'"
                                                                            onmouseout="this.className='btn'" Text="Update" meta:resourcekey="BtnSheetResource1"
                                                                            OnClientClick="javascript:return CheckSearchUpdate();" OnClick="btnUpdate_Click" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                            onmouseout="this.className='btn'" meta:resourcekey="BtnSheetResource1" OnClick="btnCancel_Click" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                            onmouseout="this.className='btn'" meta:resourcekey="BtnSheetResource1" OnClick="btnReset_Click" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <asp:Panel ID="Panel7" CssClass="dataheader2" runat="server" meta:resourcekey="Panel7Resource1">
                                    <table>
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblSTestName" Text="Test Name" runat="server" meta:resourcekey="STestName1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            &nbsp;&nbsp;&nbsp; &nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtSTestName" ToolTip="Test Name" CssClass="AutoCompletesearchBox"
                                                                runat="server"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtSTestName"
                                                                EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" OnClientItemSelected="BillingItemSelected1"
                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetBillingItems"
                                                                FirstRowSelected="false" OnClientItemOver="TempBillingItemSelected1" ServicePath="~/OPIPBilling.asmx"
                                                                UseContextKey="True" DelimiterCharacters="" OnClientShown="InvPopulated1" Enabled="True"
                                                                OnClientPopulated="onTestListPopulated1">
                                                            </ajc:AutoCompleteExtender>
                                                            &nbsp;
                                                        </td>
                                                        &nbsp;&nbsp;&nbsp; &nbsp;
                                                        <td>
                                                            <asp:Label ID="lblSDrName" Text="Ref.Phy" runat="server" meta:resourcekey="SDrName1"></asp:Label>
                                                        </td>
                                                        <td>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtSDrName" CssClass="AutoCompletesearchBox" runat="server" ToolTip="Refering Physician(Doctor) Name"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" TargetControlID="txtSDrName"
                                                                FirstRowSelected="true" ServiceMethod="GetPhysician" ServicePath="~/WebService.asmx"
                                                                CompletionSetCount="10" EnableCaching="false" MinimumPrefixLength="2" BehaviorID="AutoCompleteEx1"
                                                                CompletionInterval="10" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected">
                                                            </ajc:AutoCompleteExtender>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblSCouponCode" Text="Coupon Code" runat="server" meta:resourcekey="SCouponCode1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            &nbsp;&nbsp;&nbsp; &nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtSCouponCode" ToolTip="Coupon Code" runat="server" meta:resourcekey="txtSCouponCode1"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnSearch" runat="server" Style="cursor: pointer;" Text="Search"
                                                                CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                                meta:resourcekey="btnSearchResource1" OnClick="btnSearch_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <table class="w-100p">
                                    <tr id="trgrduplicate" runat="server">
                                        <td>
                                            <table cssclass="mytable1">
                                                <tr id="tr1" runat="server">
                                                    <td>
                                                        <asp:Label ID="lblCouponMsg" runat="server" CssClass="mytable1" Text="Please check the below item(s)"
                                                            Visible="false"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="grdduplicate" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                            AllowPaging="true" CssClass="mytable1 gridView" PageSize="5" meta:resourcekey="grdResultResource1"
                                                            OnPageIndexChanging="grdduplicate_PageIndexChanging">
                                                            <PagerTemplate>
                                                                <tr>
                                                                    <td align="center" colspan="6">
                                                                        <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                                            CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" Width="18px"
                                                                            meta:resourcekey="lnkPrevResource1" />
                                                                        <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                                            CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" Width="18px"
                                                                            meta:resourcekey="lnkNextResource1" />
                                                                    </td>
                                                                </tr>
                                                            </PagerTemplate>
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <RowStyle Font-Bold="False" />
                                                            <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                            <Columns>
                                                                <asp:BoundField DataField="CouponBarcode" ReadOnly="true" HeaderText="Coupon Code " />
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="grdCouponTestMaster1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                            CellPadding="4" CssClass="mytable1 gridView w-100p" ForeColor="#333333" OnPageIndexChanging="grdCouponTestMaster1_PageIndexChanging"
                                                            DataKeyNames="CouponId,CouponName,CouponBarcode,CouponValue,PhysicianId,PhysicianName,ValidFrom,ValidTo,IsDelete,Status,InvestigationID,Type"
                                                            OnRowCommand="grdCouponTestMaster1_RowCommand" OnRowDataBound="grdCouponTestMaster1_RowDataBound"
                                                            meta:resourcekey="grdResultResource1" PageSize="10">
                                                            <PagerTemplate>
                                                                <tr>
                                                                    <td class="a-center" colspan="8">
                                                                        <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                                            CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" Width="18px"
                                                                            meta:resourcekey="lnkPrevResource1" />
                                                                        <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                                            CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" Width="18px"
                                                                            meta:resourcekey="lnkNextResource1" />
                                                                    </td>
                                                                </tr>
                                                            </PagerTemplate>
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <RowStyle Font-Bold="False" />
                                                            <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                            <Columns>
                                                                <asp:BoundField DataField="CouponId" HeaderText="Coupon Id" Visible="False" meta:resourcekey="BoundFieldResource1" />
                                                                <asp:BoundField DataField="CouponName" HeaderText="Coupon Name" meta:resourcekey="BoundFieldResource3" />
                                                                <asp:BoundField DataField="CouponBarcode" HeaderText="Coupon Barcode" meta:resourcekey="BoundFieldResource4" />
                                                                <asp:BoundField DataField="CouponValue" HeaderText="Coupon Value" meta:resourcekey="BoundFieldResource5" />
                                                                <asp:BoundField DataField="PhysicianId" HeaderText="Physician Id" Visible="False"
                                                                    meta:resourcekey="BoundFieldResource6" />
                                                                <asp:BoundField DataField="PhysicianName" HeaderText="Physician Name" meta:resourcekey="BoundFieldResource7" />
                                                                <asp:BoundField DataField="ValidFrom" HeaderText="Valid From" DataFormatString="{0:dd/MM/yyyy }"
                                                                    meta:resourcekey="BoundFieldResource8" />
                                                                <asp:BoundField DataField="ValidTo" HeaderText="Valid To" DataFormatString="{0:dd/MM/yyyy }"
                                                                    meta:resourcekey="BoundFieldResource9" />
                                                                <asp:BoundField DataField="IsDelete" HeaderText="InActive" meta:resourcekey="BoundFieldResource10" />
                                                                <asp:BoundField DataField="Status" HeaderText="Status" meta:resourcekey="BoundFieldResource11" />
                                                                <asp:BoundField DataField="InvestigationID" HeaderText="InvestigationID" Visible="False"
                                                                    meta:resourcekey="BoundFieldResource12" />
                                                                <asp:BoundField DataField="Type" HeaderText="Type" Visible="False" meta:resourcekey="BoundFieldResource13" />
                                                            </Columns>
                                                        </asp:GridView>
                                                        <input type="hidden" id="hdnCouponId" runat="server" />
                                                        <input type="hidden" id="hdnPhysicianId" runat="server" />
                                                        <input type="hidden" id="hdnType" runat="server" />
                                                        <input type="hidden" id="hdnInvestigationID" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="BtnSheet" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
               
        <asp:HiddenField ID="hdnFeeType1" runat="server" Value="COM" />
        <input id="hdnID" type="hidden" runat="server" />
        <input id="hdnName" type="hidden" runat="server" />
        <input id="hndLocationID" type="hidden" value="0" runat="server" />
        <input id="hdnDrId" type="hidden" runat="server" />
        <input id="hdnFeeTypeSelected" type="hidden" runat="server" value="COM" />
        <input id="hdnUID" type="hidden" runat="server" />
        <input id="hdnUName" type="hidden" runat="server" />
        <input id="hdnUFeeTypeSelected" type="hidden" runat="server" value="COM" />
        <input type="hidden" runat="server" id="hdnCouponlength" />
     <Attune:Attunefooter ID="Attunefooter" runat="server" /> 

    <script type="text/javascript" language="javascript">

        function BillingItemSelected1(source, eventArgs) {

            var varGetVal = eventArgs.get_value();
            var arrGetVal = new Array();
            arrGetVal = varGetVal.split("^");
            document.getElementById('txtSTestName').value = arrGetVal[1]
            var ID;
            var name;
            var feeType;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                if (list[i] != "") {
                    ID = list[0];
                    name = list[1].trim();
                    feeType = list[2];
                    document.getElementById('hdnUID').value = ID;
                    document.getElementById('hdnUName').value = name;
                    document.getElementById('hdnUFeeTypeSelected').value = feeType;
                }
            }
            else {
                document.getElementById('hdnUID').value = -1;
                document.getElementById('hdnUFeeTypeSelected').value = "OTH";
            }
            //            pageLoad();

            $find('AutoCompleteExtender1')._onMethodComplete = function(result, context) {

                $find('AutoCompleteExtender1')._update(context, result, /* cacheResults */false);

                webservice_callback(result, context);
            };
        }

        function TempBillingItemSelected1(source, eventArgs) {

            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        if (list[1] != "" && list[1] != null) {
                            document.getElementById('txtSTestName').value = list[1];

                        }
                    }
                }
            }

            var varGetVal = eventArgs.get_value();
            var arrGetVal = new Array();
            arrGetVal = varGetVal.split("^");
            document.getElementById('txtSTestName').value = arrGetVal[1]
            var ID;
            var name;
            var feeType;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                if (list[i] != "") {
                    ID = list[0];
                    name = list[1].trim();
                    feeType = list[2];
                    document.getElementById('hdnUID').value = ID;
                    document.getElementById('hdnUName').value = name;
                    document.getElementById('hdnUFeeTypeSelected').value = feeType;
                }
            }
            else {
                document.getElementById('hdnUID').value = -1;
                document.getElementById('hdnUFeeTypeSelected').value = "OTH";
            }

            $find('AutoCompleteExtender1')._onMethodComplete = function(result, context) {
                $find('AutoCompleteExtender1')._update(context, result, /* cacheResults */false);
                webservice_callback(result, context);
            };
        }


        function onTestListPopulated1() {
            var completionList = $find("AutoCompleteExtender1").get_completionList().childNodes;
            for (var i = 0; i < completionList.length; i++) {
                var temp = completionList[i].innerHTML;
                if ($('#AutoCompleteExtender1_completionListElem').length > 0 && temp.length != '') {
                    if (temp.length > 0 && temp.length < 10) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '150px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '350px');
                        });
                    }
                    else if (temp.length > 10 && temp.length < 25) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '200px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '350px');
                        });
                    }
                    else if (temp.length > 25 && temp.length < 30) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '250px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '450px');
                        });
                    }
                    else if (temp.length > 30 && temp.length < 35) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '300px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '500px');
                        });
                    }
                    else if (temp.length > 35 && temp.length < 40) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '320px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '550px');
                        });
                    }
                    else if (temp.length > 40 && temp.length < 45) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '340px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '600px');
                        });
                    }
                    else if (temp.length > 45 && temp.length < 50) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '370px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '650px');
                        });
                    }
                    else if (temp.length > 50 && temp.length < 55) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '400px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '700px');
                        });
                    }
                    else if (temp.length > 55 && temp.length < 60) {
                        $('#AutoCompleteExtender1_completionListElem').css('width', '450px');
                        $("#AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '750px');
                        });
                    }
                    else if (temp.length > 60 && temp.length < 65) {
                        $('AutoCompleteExtender1_completionListElem').css('width', '500px');
                        $("AutoCompleteExtender1_completionListElem li").each(function(n) {
                            $(this).css('width', '800px');
                        });
                    }
                }
            }
        }
        function removesplit1(id) {
            x = id.split('_');
            var txtname = document.getElementById('txtSDrName').value;
            var name = txtname.split('~');
            document.getElementById('txtSDrName').value = name[0];

        }
        function InvPopulated1(sender, e) {

            var behavior = $find('AutoCompleteExtender1');
            var target = behavior.get_completionList();
            for (i = 0; i < target.childNodes.length; i++) {
                var text = target.childNodes[i]._value;
                var ItemArray;
                ItemArray = text.split('^');
                if (ItemArray[4].trim().toLowerCase() == 'y') {
                    // target.childNodes[i].className = "focus"
                }
                if (ItemArray[2].trim().toLowerCase() == 'inv') {
                    // target.childNodes[i].className = "focus"

                    target.childNodes[i].style.color = "Black";
                    //target.childNodes[i].style.fontcolor('Orange');
                }
                else if (ItemArray[2].trim().toLowerCase() == 'pkg') {
                    target.childNodes[i].style.color = "blue";

                }
                else {

                    target.childNodes[i].style.color = "MediumVioletRed";
                    //target.childNodes[i].style.fontcolor('red');
                }

            }
        }
        
    </script>

    <script type="text/javascript" language="javascript">

        function BillingItemSelected(source, eventArgs) {

            var varGetVal = eventArgs.get_value();
            var arrGetVal = new Array();
            arrGetVal = varGetVal.split("^");
            document.getElementById('txtTestName').value = arrGetVal[1]
            var ID;
            var name;
            var feeType;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                if (list[i] != "") {
                    ID = list[0];
                    name = list[1].trim();
                    feeType = list[2];
                    document.getElementById('hdnID').value = ID;
                    document.getElementById('hdnName').value = name;
                    document.getElementById('hdnFeeTypeSelected').value = feeType;
                }
            }
            else {
                document.getElementById('hdnID').value = -1;
                document.getElementById('hdnFeeTypeSelected').value = "OTH";
            }
            //            pageLoad();

            $find('AutoCompleteExtender3')._onMethodComplete = function(result, context) {

                $find('AutoCompleteExtender3')._update(context, result, /* cacheResults */false);

                webservice_callback(result, context);
            };
        }

        function TempBillingItemSelected(source, eventArgs) {

            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        if (list[1] != "" && list[1] != null) {
                            document.getElementById('txtTestName').value = list[1];

                        }
                    }
                }
            }

            var varGetVal = eventArgs.get_value();
            var arrGetVal = new Array();
            arrGetVal = varGetVal.split("^");
            document.getElementById('txtTestName').value = arrGetVal[1]
            var ID;
            var name;
            var feeType;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                if (list[i] != "") {
                    ID = list[0];
                    name = list[1].trim();
                    feeType = list[2];
                    document.getElementById('hdnID').value = ID;
                    document.getElementById('hdnName').value = name;
                    document.getElementById('hdnFeeTypeSelected').value = feeType;
                }
            }
            else {
                document.getElementById('hdnID').value = -1;
                document.getElementById('hdnFeeTypeSelected').value = "OTH";
            }

            $find('AutoCompleteExtender3')._onMethodComplete = function(result, context) {
                $find('AutoCompleteExtender3')._update(context, result, /* cacheResults */false);
                webservice_callback(result, context);
            };
        }


        function onTestListPopulated() {
            var completionList = $find("AutoCompleteExtender3").get_completionList().childNodes;
            for (var i = 0; i < completionList.length; i++) {
                var temp = completionList[i].innerHTML;
                if ($('#AutoCompleteExtender3_completionListElem').length > 0 && temp.length != '') {
                    if (temp.length > 0 && temp.length < 10) {
                        $('#AutoCompleteExtender3_completionListElem').css('width', '150px');
                        $("#AutoCompleteExtender3_completionListElem li").each(function(n) {
                            $(this).css('width', '350px');
                        });
                    }
                    else if (temp.length > 10 && temp.length < 25) {
                        $('#AutoCompleteExtender3_completionListElem').css('width', '200px');
                        $("#AutoCompleteExtender3_completionListElem li").each(function(n) {
                            $(this).css('width', '350px');
                        });
                    }
                    else if (temp.length > 25 && temp.length < 30) {
                        $('#AutoCompleteExtender3_completionListElem').css('width', '250px');
                        $("#AutoCompleteExtender3_completionListElem li").each(function(n) {
                            $(this).css('width', '450px');
                        });
                    }
                    else if (temp.length > 30 && temp.length < 35) {
                        $('#AutoCompleteExtender3_completionListElem').css('width', '300px');
                        $("#AutoCompleteExtender3_completionListElem li").each(function(n) {
                            $(this).css('width', '500px');
                        });
                    }
                    else if (temp.length > 35 && temp.length < 40) {
                        $('#AutoCompleteExtender3_completionListElem').css('width', '320px');
                        $("#AutoCompleteExtender3_completionListElem li").each(function(n) {
                            $(this).css('width', '550px');
                        });
                    }
                    else if (temp.length > 40 && temp.length < 45) {
                        $('#AutoCompleteExtender3_completionListElem').css('width', '340px');
                        $("#AutoCompleteExtender3_completionListElem li").each(function(n) {
                            $(this).css('width', '600px');
                        });
                    }
                    else if (temp.length > 45 && temp.length < 50) {
                        $('#AutoCompleteExtender3_completionListElem').css('width', '370px');
                        $("#AutoCompleteExtender3_completionListElem li").each(function(n) {
                            $(this).css('width', '650px');
                        });
                    }
                    else if (temp.length > 50 && temp.length < 55) {
                        $('#AutoCompleteExtender3_completionListElem').css('width', '400px');
                        $("#AutoCompleteExtender3_completionListElem li").each(function(n) {
                            $(this).css('width', '700px');
                        });
                    }
                    else if (temp.length > 55 && temp.length < 60) {
                        $('#AutoCompleteExtender3_completionListElem').css('width', '450px');
                        $("#AutoCompleteExtender3_completionListElem li").each(function(n) {
                            $(this).css('width', '750px');
                        });
                    }
                    else if (temp.length > 60 && temp.length < 65) {
                        $('AutoCompleteExtender3_completionListElem').css('width', '500px');
                        $("AutoCompleteExtender3_completionListElem li").each(function(n) {
                            $(this).css('width', '800px');
                        });
                    }
                }
            }
        }
        function removesplit(id) {
            x = id.split('_');
            var txtname = document.getElementById('txtDrName').value;
            var name = txtname.split('~');
            document.getElementById('txtDrName').value = name[0];

        }
        function InvPopulated(sender, e) {

            var behavior = $find('AutoCompleteExtender3');
            var target = behavior.get_completionList();
            for (i = 0; i < target.childNodes.length; i++) {
                var text = target.childNodes[i]._value;
                var ItemArray;
                ItemArray = text.split('^');
                if (ItemArray[4].trim().toLowerCase() == 'y') {
                    // target.childNodes[i].className = "focus"
                }
                if (ItemArray[2].trim().toLowerCase() == 'inv') {
                    // target.childNodes[i].className = "focus"

                    target.childNodes[i].style.color = "Black";
                    //target.childNodes[i].style.fontcolor('Orange');
                }
                else if (ItemArray[2].trim().toLowerCase() == 'pkg') {
                    target.childNodes[i].style.color = "blue";

                }
                else {

                    target.childNodes[i].style.color = "MediumVioletRed";
                    //target.childNodes[i].style.fontcolor('red');
                }

            }
        }
    </script>

    </form>
</body>
</html>
