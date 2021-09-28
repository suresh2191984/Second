<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BillSearch.ascx.cs" Inherits="CommonControls_BillSearch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<link rel="stylesheet" type="text/css" href="../StyleSheets/style.css" />--%>
<%@ Register Src="PaymentTypeDetails.ascx" TagName="PaymentTypeDetails" TagPrefix="uc6" %>

<script language="javascript" type="text/javascript">
    var x;
    function nameValidate(id) {
        x = id.split("_");
        if (document.getElementById(x[0] + "_txtBillNo").value == '' && document.getElementById(x[0] + "_txtPatientName").value == '' && document.getElementById(x[0] + "_txtBillDate").value == '' && document.getElementById(x[0] + "_txtDrName").value == '') {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\BillSearch.ascx_1');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert("Please Choose Atleast one Search Criteria.");
            }
            document.getElementById(x[0] + "_txtBillNo").focus();
            return false;
        }
        return true;
        return checkForCurrentDate(x[0] + '_txtBillDate', 'Bill Date');

    }
    function validateLabRefPhysicianDetails() {
        if (document.getElementById('txtDrName').value.trim() == '') {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\BillSearch.ascx_2');
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Please Enter Physician Name');
            }
            document.getElementById('txtDrName').focus();
            return false;
        }
    }

    function checkSearchName() {
        if (document.getElementById('txtSearchPhysicianName').value.trim() == '') {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\BillSearch.ascx_3')
            if (userMsg != null) {
                alert(userMsg);
            }
            else {
                alert('Please Enter the Search Text to find the Physician');
            }
            document.getElementById('txtSearchPhysicianName').focus();
            return false;
        }
    }

    function chec() {
        //alert('as');
        var txtname = document.getElementById('txtDrName').value;
        //alert(txtname);
        txtname = txtname.toLowerCase();
        if (txtname != "") {
            arg = 1;
            sUrl = "../Admin/ChkUserName.aspx?login=" + txtname + "&" + "phytype=ref";
            ReloadData(sUrl);
        }
    }

    var xmlhttp;
    function ReloadData(url) {
        xmlhttp = null;
        if (window.XMLHttpRequest) {
            xmlhttp = new XMLHttpRequest();
        }
        else if (window.ActiveXObject) {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        if (xmlhttp != null) {
            xmlhttp.onreadystatechange = state_Change;
            xmlhttp.open("GET", url, true);
            document.getElementById('div_error').innerHTML = "<img src='../Images/working.gif' width='10' height='10' align='absmiddle' vspace='3' border=0>&nbsp; Checking Physician Already in use..";
            xmlhttp.send(null);

        }
        else {
            document.getElementById('div_error').innerHTML = "Your browser does not support XMLHTTP.";
        }
    }

    function state_Change() {
        if (xmlhttp.readyState == 4) {
            if (xmlhttp.status == 200) {
                if (arg == 1) {
                    //alert(xmlhttp.reponseText);
                    if (xmlhttp.responseText == "true")
                        document.getElementById('div_error').innerHTML = "Selected Dr Name already in use. Please Verify...";
                    else
                        document.getElementById('div_error').innerHTML = "";
                }
            }
            else {
                document.getElementById('div_error').innerHTML = "Problem retrieving User Availability";
            }
        }
    }

    function removesplit(id) {
        x = id.split('_');
        var txtname = document.getElementById(x[0] + '_txtDrName').value;
        var name = txtname.split('~');
        document.getElementById(x[0] + '_txtDrName').value = name[0];

    }
    function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
        //            var sVal = document.getElementById('hdnAmt').value;
        ////            var sNetValue = document.getElementById('txtGrandTotal').value;
        ////            var tempService = document.getElementById('txtServiceCharge').value;
        //            if (Number(sVal) < PaymentAmount) {
        //                
        //            }
        //            else {
        //                alert("Amount Entered is greater than Net Amount");
        //                return false;
        //            }
        //
        return true;
    }

    function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {


        //            var sVal = document.getElementById('txtAmountRecieved').value;
        //            sVal = format_number(Number(sVal) - Number(TotalAmount), 2);
        //            var tempService = document.getElementById('txtServiceCharge').value;
        //            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);

        //            document.getElementById('txtServiceCharge').value = format_number(Number(tempService) - Number(ServiceCharge), 2);
        //            document.getElementById('hdnServiceCharge').value = format_number(Number(tempService) - Number(ServiceCharge), 2);

        //            document.getElementById('txtAmountRecieved').value = sVal;
        //            document.getElementById('hdnAmountReceived').value = sVal;
        //            var sNetValue = document.getElementById('txtGrandTotal').value;
        //            document.getElementById('txtGrandTotal').value = format_number(Number(sNetValue) - Number(ServiceCharge), 2);
    }
</script>

<asp:Panel ID="pnlPSearch" runat="server" DefaultButton="btnSearch" 
    meta:resourcekey="pnlPSearchResource1">
    
    <table width="100%" class="dataheader2" border="0" cellpadding="4" cellspacing="0"
        class="defaultfontcolor">
        <tr>
            <td style="height: 10px;">
            </td>
        </tr>
        <tr>
            <td style="width: 20%;" align="right">
              <asp:Label ID="Rs_BillNo" Text="Bill No" runat="server" 
                    meta:resourcekey="Rs_BillNoResource1" />
            </td>
            <td style="width: 10%">
                <asp:TextBox ID="txtBillNo" ToolTip="Bill No" runat="server" MaxLength="255" 
                    CssClass="txtboxps" meta:resourcekey="txtBillNoResource1"></asp:TextBox>
            </td>
            <td align="right">
               <asp:Label id="Rs_BillDate" Text="Bill Date" runat="server" 
                    meta:resourcekey="Rs_BillDateResource1" />
            </td>
            <td style="width: 50%">
                <asp:TextBox ID="txtBillDate" ToolTip="Bill Date" runat="server" 
                    CssClass="txtboxps" meta:resourcekey="txtBillDateResource1"></asp:TextBox>
                <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                    CausesValidation="False" meta:resourcekey="ImgBntCalcResource1" />
                <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtBillDate"
                    Mask="99/99/9999" MaskType="Date"
                    ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                    CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                    ControlToValidate="txtBillDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" 
                    meta:resourcekey="MaskedEditValidator5Resource1" />
                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtBillDate"
                    Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc" Enabled="True" />
            </td>
        </tr>
        <tr>
            <td style="width: 20%;" align="right">
              <asp:Label ID="Rs_DoctorName" Text="Doctor Name" runat="server" 
                    meta:resourcekey="Rs_DoctorNameResource1" />
            </td>
            <td style="width: 10%">
                <asp:TextBox ID="txtDrName" runat="server" ToolTip="Refering Physician(Doctor) Name"
                    onblur="javascript:return removesplit(id);" MaxLength="255" 
                    CssClass="txtboxps" meta:resourcekey="txtDrNameResource1"></asp:TextBox>
                <cc1:AutoCompleteExtender ID="AutoRname" runat="server" TargetControlID="txtDrName"
                    FirstRowSelected="True" ServiceMethod="GetPhysician" 
                    ServicePath="~/WebService.asmx" EnableCaching="False" MinimumPrefixLength="2" BehaviorID="AutoCompleteEx1"
                    CompletionInterval="10" DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box"
                    CompletionListItemCssClass="wordWheel itemsMain" 
                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" Enabled="True">
                </cc1:AutoCompleteExtender>
            </td>
            <td style="width: 20%;" align="right">
              <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" 
                    meta:resourcekey="Rs_PatientNameResource1" />
            </td>
            <td style="width: 10%" colspan="3">
                <asp:TextBox ID="txtPatientName" ToolTip="Patient Name" runat="server" MaxLength="255"
                    CssClass="txtboxps" meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                <cc1:AutoCompleteExtender ID="AptName" runat="server" TargetControlID="txtPatientName"
                    EnableCaching="False" FirstRowSelected="True" MinimumPrefixLength="2" CompletionListCssClass="listtwo"
                    CompletionListItemCssClass="listitemtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                    ServiceMethod="GetPatientListWithDetails" 
                    ServicePath="~/InventoryWebService.asmx" DelimiterCharacters="" Enabled="True">
                </cc1:AutoCompleteExtender>
            </td>
        </tr>
        <tr>
            <td colspan="4" style="padding-bottom: 10px;" align="center">
                <asp:Button ID="btnSearch" runat="server" Style="cursor: pointer;" ToolTip="Click here to Search the Bill"
                    Text="Search" CssClass="btn1" OnClientClick="return nameValidate(id);" onmouseover="this.className='btn1 btnhov1'"
                    onmouseout="this.className='btn1'" OnClick="btnSearch_Click" 
                    meta:resourcekey="btnSearchResource1" />
                &nbsp;
                <input ID="btnCancel" class="btn1" 
                    onclick="getElementById('').value='';getElementById('').value='';var now = new Date();
                    getElementById('').value=now.format('dd/MM/yyyy');getElementById('').value='';" 
                    type="button" value="Reset" />
            </td>
        </tr>
        <tr>
            <td colspan="4" align="center">
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="5" cellspacing="0">
        <tr>
            <td>
                <asp:Label ID="lblResult" ForeColor="#000333" runat="server" 
                    meta:resourcekey="lblResultResource1"></asp:Label>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <asp:GridView ID="grdResult" Width="100%" runat="server" AllowPaging="True" CellPadding="4"
                    AutoGenerateColumns="False" DataKeyNames="BillID"
                    OnRowDataBound="grdResult_RowDataBound" ForeColor="#333333" 
                    OnPageIndexChanging="grdResult_PageIndexChanging" OnRowCommand="grdResult_RowCommand"
                    CssClass="mytable1" meta:resourcekey="grdResultResource1">
                    <HeaderStyle CssClass="dataheader1" />
                    <Columns>
                        <asp:BoundField Visible="False" DataField="BillID" HeaderText="BillID" 
                            meta:resourcekey="BoundFieldResource1" />
                        <asp:TemplateField HeaderText="Select" 
                            meta:resourcekey="TemplateFieldResource1">
                            <ItemTemplate>
                                <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" 
                                    GroupName="BillSelect" meta:resourcekey="rdSelResource1" />
                            </ItemTemplate>
                            <ItemStyle Width="3%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Bill No" 
                            meta:resourcekey="TemplateFieldResource2">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" CommandName="ShowBill" Font-Underline="True" CommandArgument='<%# Eval("BillNumber") %>'
                                    ForeColor="Black" Text='<%# Eval("BillNumber") %>' ID="lnkEdit" 
                                    meta:resourcekey="lnkEditResource1"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="BillNumber" HeaderText="Bill No" 
                            meta:resourcekey="BoundFieldResource2" >
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" Width="10%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BillDate" DataFormatString="{0:dd/MM/yyyy hh:mm}" 
                            HeaderText="Bill Date" meta:resourcekey="BoundFieldResource3" >
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" Width="14%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PatientVisitId" HeaderText="Visit No" 
                            meta:resourcekey="BoundFieldResource4" >
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" Width="10%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Name" HeaderText="Patient Name" 
                            meta:resourcekey="BoundFieldResource5" >
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle Width="23%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DrName" HeaderText="Doctor Name" 
                            meta:resourcekey="BoundFieldResource6" >
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle Width="22%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="RefOrgName" HeaderText="Hospital/CC/Branch" 
                            meta:resourcekey="BoundFieldResource7" >
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle Width="25%" />
                        </asp:BoundField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                <table border="0" width="80%">
                    <tr>
                        <td>
                            <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" 
                                Style="display: none" 
                                meta:resourcekey="hiddenTargetControlForModalPopupResource1" />
                            <cc1:ModalPopupExtender ID="programmaticModalPopup" runat="server" BackgroundCssClass="modalBackground"
                                PopupControlID="pnlAttrib" CancelControlID="btnCancel" 
                                TargetControlID="hiddenTargetControlForModalPopup" DynamicServicePath="" 
                                Enabled="True">
                            </cc1:ModalPopupExtender>
                            <asp:Panel ID="pnlAttrib" BorderWidth="1px" Width="80%" CssClass="modalPopup dataheaderPopup"
                                runat="server" meta:resourcekey="pnlAttribResource1">
                                <table border="2" style="border-color: Red;">
                                    <tr>
                                        <td align="left">
                                            <uc6:PaymentTypeDetails ID="PaymentTypeDetails1" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:GridView ID="GridView1" OnRowDataBound="GridView1_RowDataBound" Width="100%"
                                                runat="server" AutoGenerateColumns="False" 
                                                DataKeyNames="AmtReceived,AmtReceivedID,FinalBillID" PageSize="1" 
                                                meta:resourcekey="GridView1Resource1">
                                                <HeaderStyle CssClass="dataheader1" />
                                                <Columns>
                                                    <asp:BoundField DataField="PaymentName" HeaderText="PaymentType" 
                                                        meta:resourcekey="BoundFieldResource8" />
                                                    <asp:BoundField DataField="CreatedAt" HeaderText="Amount Received Date" 
                                                        meta:resourcekey="BoundFieldResource9" />
                                                    <asp:BoundField DataField="BankNameorCardType" HeaderText="BankName" 
                                                        meta:resourcekey="BoundFieldResource10" />
                                                    <asp:BoundField DataField="AmtReceived" HeaderText="Amount Paid" 
                                                        meta:resourcekey="BoundFieldResource11" />
                                                    <asp:TemplateField HeaderText="Amount to be Updated" 
                                                        meta:resourcekey="TemplateFieldResource3">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtAmount" runat="server" 
                                                                meta:resourcekey="txtAmountResource1" 
                                                                   onkeypress="return ValidateOnlyNumeric(this);"   
                                                                Text='<%# Eval("AmtReceived") %>' Width="80%"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="BankNameorCardType" 
                                                        meta:resourcekey="TemplateFieldResource4">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtbankName" runat="server" 
                                                                meta:resourcekey="txtbankNameResource1" Width="80%"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="ChequeorCardNumber" 
                                                        meta:resourcekey="TemplateFieldResource5">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtCheque" runat="server" 
                                                                meta:resourcekey="txtChequeResource1" 
                                                                   onkeypress="return ValidateOnlyNumeric(this);"   Width="80%"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Payment Type" 
                                                        meta:resourcekey="TemplateFieldResource6">
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddlList" runat="server" 
                                                                meta:resourcekey="ddlListResource1">
                                                            </asp:DropDownList>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="15%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                    PageButtonCount="5" PreviousPageText="" />
                                                <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="Update" runat="server" Text="Update" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" OnClick="Update_Click" 
                                                            meta:resourcekey="UpdateResource1" />
                                                    </td>
                                                    <td align="center">
                                                        <asp:Button ID="Button1" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" meta:resourcekey="Button1Resource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <input type="hidden" id="bid" name="bid" />
    <asp:HiddenField ID="hdnFinalBillID" runat="server" />
    <asp:HiddenField ID="hdnAmt" runat="server" />
</asp:Panel>
