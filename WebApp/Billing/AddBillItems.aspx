<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddBillItems.aspx.cs" Inherits="Billing_AddbIllItems"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/DueDetails.ascx" TagName="DueDetail" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="paymentType"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/ConsultationDetails.ascx" TagName="ipConsultationDetails"
    TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Billing</title>
 
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    
    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript">
        animatedcollapse.addDiv('Due', 'fade=1,height=1%');
        animatedcollapse.init();

        function CheckBilling() {
            var returndatavalue = SaveValidation();

            if (returndatavalue == true) {
                if (Number(document.getElementById('txtGrandTotal').value) < Number(document.getElementById('txtAmountRecieved').value)) {

                    alert('Amount received greater than current total');
                    document.getElementById('txtAmountRecieved').value = '';
                    document.getElementById('hdnAmountReceived').value = '0';
                    return false;
                }
                /*  if (document.getElementById('chkisCreditTransaction').checked == false) {

                if (Number(document.getElementById('txtAmountRecieved').value) <= 0) {

                alert('Provide received amount');
                return false;
                }
                } */
                document.getElementById('btnSave').style.display = 'none';
                return true;
            }
            else {
                return false;
            }
        }

        function DefaultText(id) {

            document.getElementById(id).value = "";

        }

        function total() {


            document.getElementById('txtGrossAmount').value = format_number(Number(document.getElementById('txtGross').value) -
                                                            (Number(document.getElementById('txtSubDeduction').value) + Number(document.getElementById('txtDiscount').value)), 2);
            document.getElementById('txtGrandTotal').value = format_number(Number(document.getElementById('txtGrossAmount').value) +
                                                            Number(document.getElementById('txtDue').value) + Number(document.getElementById('txtTax').value), 2);
            if (Number(document.getElementById('hdnRecievedAmount').value) > 0) {
                document.getElementById('txtGrandTotal').value = format_number(
                                                                Number(document.getElementById('txtGrandTotal').value) -
                                                                Number(document.getElementById('txtRecievedAmount').value), 2);
            }

            //document.getElementById('txtAmountRecieved').value = format_number(document.getElementById('txtGrandTotal').value, 2);
            document.getElementById('hdnGrossAmount').value = format_number(Number(document.getElementById('txtGrossAmount').value) + Number(document.getElementById('txtTax').value), 2);
            SetOtherCurrValues();
        }
        function AmountRecieved() {
            var grandTotal = document.getElementById('txtGrandTotal').value;
            var amountRecieved = document.getElementById('txtAmountRecieved').value;
        }

        function ChangeFormat() {
            document.getElementById('txtSubDeduction').value = format_number(document.getElementById('txtSubDeduction').value, 2);
            document.getElementById('txtDiscount').value = format_number(document.getElementById('txtDiscount').value, 2);
            document.getElementById('txtAmountRecieved').value = format_number(document.getElementById('txtAmountRecieved').value, 2);
            document.getElementById('hdnAmountReceived').value = format_number(document.getElementById('txtAmountRecieved').value, 2);
        }
        function DeductionCalculation() {
            var value = document.getElementById('ddlSubDeduction').value.split("*");
            if (value[2] == 'V') {
                document.getElementById('txtSubDeduction').value = format_number(value[1], 2);
                document.getElementById('hdnStdDedID').value = value[0];
                total();
            }
            else if (value[2] == 'P') {

                var Grossalue = document.getElementById('txtGross').value;
                document.getElementById('txtSubDeduction').value = format_number((Number(Grossalue) * Number(value[1]) / 100), 2);
                document.getElementById('hdnStdDedID').value = value[0];
                total();
            }
            else {

                document.getElementById('txtSubDeduction').value = "0.00";
                total();
            }
        }
        function checkIsCredit() {

            if (document.getElementById('chkisCreditTransaction').checked == true) {
                document.getElementById('txtAmountRecieved').value = '0.00';
                document.getElementById('hdnAmountReceived').value = '0.00';
                document.getElementById('txtAmountRecieved').disabled = true;
                ClearPaymentControlEvents();
            }
        }
        function validation() {
            return true;
        }

        function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            var ConValue = "OtherCurrencyDisplay1";
            var sVal = getOtherCurrAmtValues("REC", ConValue);
            var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
            var tempService = getOtherCurrAmtValues("SER", ConValue);
            var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);

            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 4);
            sVal = format_number(Number(sVal) + Number(TotalAmount), 4);


            if (Number(sNetValue) >= Number(sVal)) {
                sVal = format_number(sVal, 2);
                SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
                var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
                var pScrAmt = Number(pScr) * Number(CurrRate);
                var pAmt = Number(sVal) * Number(CurrRate);

                document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2)
                document.getElementById('hdnServiceCharge').value = format_number(pScrAmt, 2)
                document.getElementById('txtAmountRecieved').value = format_number(pAmt, 2);
                document.getElementById('hdnAmountReceived').value = format_number(pAmt, 2);
                var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

                document.getElementById('txtGrandTotal').value = format_number(Number(pTotal), 2);
                SetOtherCurrValues();

                return true;
            }
            else {
                alert('Amount provided is greater than net amount');
                return false;
            }
        }

        function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            var ConValue = "OtherCurrencyDisplay1";
            var sVal = getOtherCurrAmtValues("REC", ConValue);
            var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
            var tempService = getOtherCurrAmtValues("SER", ConValue);
            var CurrRate = GetOtherCurrency("OtherCurrRate");

            sVal = Number(Number(sVal) - Number(TotalAmount));
            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            var pScr = format_number(Number(tempService) - Number(ServiceCharge), 2);
            var pScrAmt = Number(pScr) * Number(CurrRate);
            var pAmt = Number(sVal) * Number(CurrRate);


            document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2);
            document.getElementById('hdnServiceCharge').value = format_number(pScrAmt, 2);

            document.getElementById('txtAmountRecieved').value = format_number(sVal, 2);
            document.getElementById('hdnAmountReceived').value = format_number(sVal, 2);
            SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);
            var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

            document.getElementById('txtGrandTotal').value = format_number(Number(pTotal), 2);
            SetOtherCurrValues();
        }



        function chkCreditPament() {
            document.getElementById('chkisCreditTransaction').checked = false;
        }
        
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server" defaultbutton="btnSave">

    <script type="text/javascript" language="javascript">
        function FuncChangeAmount(txtUnitPrice, hdnOldPrice, txtGross, txtDiscount,
                                     txtGrandTotal, hdnGross) {

            var UnitPrice = document.getElementById(txtUnitPrice);
            var OldPrice = document.getElementById(hdnOldPrice);
            var Gross = document.getElementById(txtGross);
            var Discount = document.getElementById(txtDiscount);
            var GrandTotal = document.getElementById(txtGrandTotal);
            var OldPricetoDelete = chkIsnumber(OldPrice.value);

            var hdnGrossBillAmount = document.getElementById(hdnGross);

            var OldAmounttoDelete = format_number(Number(OldPricetoDelete), 2);

            UnitPrice.value = chkIsnumber(UnitPrice.value);

            UnitPrice.value = format_number(Number(UnitPrice.value), 2);

            Gross.value = format_number((Number(Gross.value) + Number(UnitPrice.value) - Number(OldAmounttoDelete)), 2);
            hdnGrossBillAmount.value = Gross.value;

            OldPrice.value = UnitPrice.value;
            total();
        }

        function ChangeText(value) {
        }

        function chkTaxPayment(idval, dPercent) {

            var sVal = Number(document.getElementById('txtTax').value);
            var sGrand = format_number(Number(document.getElementById('hdnGross').value) -
                                                    (Number(document.getElementById('txtSubDeduction').value) + Number(document.getElementById('txtDiscount').value)), 2);

            var sControl = document.getElementById(idval);
            var arrayAlready = new Array();
            var iCount = 0;
            var tSelectedData = "";

            if (sControl.checked == true) {
                sVal = sVal + (Number(sGrand) * Number(dPercent) / 100);

                document.getElementById('hdfTax').value += ">" + idval + "~" + dPercent;
                document.getElementById('txtTax').value = format_number(sVal, 2);
                document.getElementById('hdnTaxAmount').value = format_number(document.getElementById('txtTax').value, 2);

            }
            else {
                sVal = sVal - (Number(sGrand) * Number(dPercent) / 100);
                var tempval = document.getElementById('hdfTax').value;

                arrayAlready = tempval.split('>');
                if (arrayAlready.length > 0) {
                    for (iCount = 0; iCount < arrayAlready.length; iCount++) {
                        if (arrayAlready[iCount].toLowerCase() == (idval.toLowerCase() + "~" + dPercent.toLowerCase())) {
                            arrayAlready[iCount] = "";
                        }
                    }
                    iCount = 0;
                    for (iCount = 0; iCount < arrayAlready.length; iCount++) {
                        if (arrayAlready[iCount].toLowerCase() != "") {
                            tSelectedData += ">" + arrayAlready[iCount];
                        }
                    }
                }
                document.getElementById('hdfTax').value = tSelectedData;
            }
            document.getElementById('txtTax').value = format_number(sVal, 2);
            document.getElementById('hdnTaxAmount').value = format_number(document.getElementById('txtTax').value, 2);

            total();
        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc8:PatientHeader ID="PatientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul style="display: none;">
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                <asp:Label ID="lblError" runat="server" meta:resourcekey="lblErrorResource1"></asp:Label>
                            </li>
                        </ul>
                        <table id="tblBilling" width="100%" border="0" runat="server" cellspacing="0" cellpadding="0">
                            <tr style="display: none;">
                                <td colspan="2">
                                    &nbsp;
                                    <input type="hidden" id="hdnDeduction" runat="server" />
                                    <input type="hidden" id="hdnGrossAmount" runat="server" />
                                    <input type="hidden" id="hdnGrandTotal" runat="server" />
                                    <input type="hidden" id="hdnCurrentDue" runat="server" />
                                    <input type="hidden" id="hdnRecievedAmount" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="left">

                                    <script language="javascript" type="text/javascript">

                                        function ImgDeleteclick(ImgDeleteID) {
                                            document.getElementById(ImgDeleteID).style.display = "none";
                                            var HidDeleteValue = document.getElementById('<%=iconHidDelete.ClientID %>').value;

                                            var list = HidDeleteValue.split('^');
                                            var newPhyList = '';
                                            if (document.getElementById('<%=iconHidDelete.ClientID %>').value != "") {
                                                for (var count = 0; count < list.length; count++) {

                                                    var PhyList = list[count].split('~');
                                                    if (PhyList[1] != '') {
                                                        if (PhyList[1] != ImgDeleteID) {
                                                            newPhyList += list[count] + "^";
                                                        }
                                                        else {
                                                            var DrDate = PhyList[3];
                                                            var netVal = document.getElementById('<%= hdnGross.ClientID %>').value;
                                                            netVal = chkIsnumber(netVal);
                                                            DrDate = chkIsnumber(DrDate);
                                                            netVal = Number(netVal) - Number(DrDate);
                                                            document.getElementById('<%= hdnGross.ClientID %>').value = netVal;
                                                            document.getElementById('<%= txtGross.ClientID %>').value = netVal;
                                                            total();
                                                        }
                                                    }
                                                }
                                                document.getElementById('<%=iconHidDelete.ClientID %>').value = newPhyList;
                                            }
                                        }

                                        function LoadPhysicianItems() {

                                            if (document.getElementById('<%=ddlPhysicianVis.ClientID %>').selectedIndex == 0) {
                                                alert('Select doctor name');
                                                document.getElementById('<%=ddlPhysicianVis.ClientID %>').focus();
                                                return false;
                                            }
                                            var ddlObjects = document.getElementById('<%=ddlPhysicianVis.ClientID %>');
                                            if ((ddlObjects.options[ddlObjects.selectedIndex].value) == -1) {
                                                if (document.getElementById('<%=txtOthers.ClientID %>').value == "") {
                                                    alert('Provide description');
                                                    return false;
                                                }

                                            }

                                            var PhysicianStatus = 0;
                                            var HidAddValue = document.getElementById('<%=iconHidDelete.ClientID %>').value;

                                            var list = HidAddValue.split('^');
                                            var DrId = document.getElementById('<%=ddlPhysicianVis.ClientID %>').value;
                                            var vals = DrId.split('~')[1];

                                            var DrName = document.getElementById('<%= ddlPhysicianVis.ClientID %>').options[document.getElementById('<%=ddlPhysicianVis.ClientID %>').selectedIndex].text;
                                            var DrDate = document.getElementById('<%= txtDate.ClientID %>').value;

                                            if ((ddlObjects.options[ddlObjects.selectedIndex].value) == -1) {
                                                DrName = document.getElementById('<%= txtOthers.ClientID %>').value;
                                                vals = -1;
                                            }
                                            var netVal = document.getElementById('<%= hdnGross.ClientID %>').value;
                                            netVal = chkIsnumber(netVal);
                                            DrDate = chkIsnumber(DrDate);
                                            netVal = Number(netVal) + Number(DrDate);
                                            document.getElementById('<%= hdnGross.ClientID %>').value = netVal;
                                            document.getElementById('<%= txtGross.ClientID %>').value = netVal;

                                            total();

                                            if (document.getElementById('<%= iconHidDelete.ClientID %>').value != "") {
                                                for (var count = 0; count < list.length; count++) {
                                                    var PhysicianList = list[count].split('~');
                                                    if (PhysicianList[0] != '') {
                                                        if (PhysicianList[0] == vals && PhysicianList[2] == DrName && PhysicianList[3] == DrDate) {
                                                            PhysicianStatus = 1;
                                                        }
                                                    }
                                                }
                                            }
                                            else {

                                                document.getElementById('<%=lblHeader.ClientID %>').style.display = 'block';
                                                var row = document.getElementById('<%=tblPhysician.ClientID %>').insertRow(1);
                                                var icout = document.getElementById('<%=tblPhysician.ClientID %>').rows.length;
                                                row.id = icout;
                                                vals = vals + "~" + icout;
                                                var cell1 = row.insertCell(0);
                                                var cell2 = row.insertCell(1);
                                                var cell3 = row.insertCell(2);
                                                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + icout + ");' src='../Images/Delete.jpg' />";
                                                cell1.width = "5%";
                                                cell2.innerHTML = DrName;
                                                cell3.innerHTML = DrDate;
                                                document.getElementById('<%=iconHidDelete.ClientID %>').value += vals + "~" + DrName + "~" + DrDate + "^";
                                                document.getElementById('<%=ddlPhysicianVis.ClientID %>').selectedIndex = 0;
                                                document.getElementById('<%=txtDate.ClientID %>').value = 0;
                                                document.getElementById('<%= txtOthers.ClientID %>').style.display = "none";

                                                PhysicianStatus = 0;
                                                return false;
                                            }
                                            if (PhysicianStatus == 0) {
                                                var row = document.getElementById('<%=tblPhysician.ClientID %>').insertRow(1);
                                                var icout = document.getElementById('<%=tblPhysician.ClientID %>').rows.length;
                                                row.id = icout;
                                                vals = vals + "~" + icout;
                                                var cell1 = row.insertCell(0);
                                                var cell2 = row.insertCell(1);
                                                var cell3 = row.insertCell(2);
                                                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + icout + ");' src='../Images/Delete.jpg' />";
                                                cell1.width = "5%";
                                                cell2.innerHTML = DrName;
                                                cell3.innerHTML = DrDate;
                                                document.getElementById('<%=iconHidDelete.ClientID %>').value += vals + "~" + DrName + "~" + DrDate + "^";
                                                document.getElementById('<%=ddlPhysicianVis.ClientID %>').selectedIndex = 0;
                                                document.getElementById('<%=txtDate.ClientID %>').value = 0;
                                                document.getElementById('<%= txtOthers.ClientID %>').style.display = "none";
                                                return false;

                                            }
                                            else if (PhysicianStatus == 1) {
                                                alert('Doctor name/description already added');
                                                return false;
                                            }
                                        }

                                        function LoadPhysicianExistingItems() {
                                            var HidLoadValue = document.getElementById('<%=iconHidDelete.ClientID %>').value;
                                            var list = HidLoadValue.split('^');
                                            if (document.getElementById('<%=iconHidDelete.ClientID %>').value != "") {
                                                document.getElementById('<%=lblHeader.ClientID %>').style.display = "block";
                                                for (var count = 0; count < list.length - 1; count++) {
                                                    var PhysicianList = list[count].split('~');

                                                    var row = document.getElementById('<%=tblPhysician.ClientID %>').insertRow(1);
                                                    row.id = PhysicianList[1];
                                                    var cell1 = row.insertCell(0);
                                                    var cell2 = row.insertCell(1);
                                                    var cell3 = row.insertCell(2);
                                                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgDeleteclick(" + PhysicianList[1] + ");' src='../Images/Delete.jpg' />";
                                                    cell1.width = "5%";
                                                    cell2.innerHTML = PhysicianList[1];
                                                    cell3.innerHTML = PhysicianList[2];
                                                    cell3.style.display = "none";
                                                }
                                            }
                                            return false;
                                        }
                                        function ChangeDatas(idVal) {
                                            var ddlData = document.getElementById(idVal);
                                            var txtBox = document.getElementById('<%= txtOthers.ClientID %>');
                                            var seldatas = ddlData.options[ddlData.selectedIndex].text;

                                            if (ddlData.options[ddlData.selectedIndex].value == -1) {
                                                txtBox.style.display = "block";
                                            }
                                            else {
                                                txtBox.style.display = "none";
                                                document.getElementById('<%= txtDate.ClientID %>').value = ddlData.options[ddlData.selectedIndex].value.split('~')[0];
                                            }


                                        }
                                    </script>

                                    <asp:HiddenField ID="iconHidDelete" runat="server" />
                                    <table width="70%">
                                        <tr>
                                            <td colspan="2" style="display: none;">
                                                <asp:RadioButton ID="rdoVisit" runat="server" Checked="True" Text="Visiting Consultation"
                                                    OnClick="DropShow();" GroupName="Phy" meta:resourcekey="rdoVisitResource1" />
                                            </td>
                                            <td colspan="3">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblPhysician" runat="server" Text="Dr Name" meta:resourcekey="lblPhysicianResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPhysicianVis" onChange="ChangeDatas(this.id);" runat="server"
                                                    Width="150px" CssClass="ddlsmall" meta:resourcekey="ddlPhysicianVisResource1">
                                                    <asp:ListItem Value="0" Text="--Select--" meta:resourcekey="ListItemResource1" ></asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:TextBox ID="txtOthers" runat="server" Style="display: none;" meta:resourcekey="txtOthersResource1"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="Rs_Amount" Text="Amount" runat="server" meta:resourcekey="Rs_AmountResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox runat="server" ID="txtDate"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                    MaxLength="10" size="25" Width="83px" CssClass="Txtboxsmall" meta:resourcekey="txtDateResource1"></asp:TextBox>
                                                &nbsp;
                                            </td>
                                            <td>
                                                <asp:Button ID="btnInvAdd" runat="server" Text="Add" CssClass="btn"
                                                    onmouseout="this.className='btn'" OnClientClick="return LoadPhysicianItems();"
                                                    meta:resourcekey="btnInvAddResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table id="Table1" width="50%" cellpadding="0px" cellspacing="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblHeader" runat="server" Text="Fee Details" Style="display: none;
                                                    font-size: 12px; vertical-align: middle; padding: 5px;" CssClass="Duecolor" meta:resourcekey="lblHeaderResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <table id="tblPhysician" class="dataheaderInvCtrl" runat="server" width="50%" cellspacing="0"
                                        border="2">
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                                <asp:Label ID="Rs_Description" Text="Description" runat="server" meta:resourcekey="Rs_DescriptionResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="Rs_Amount1" Text="Amount" runat="server" meta:resourcekey="Rs_Amount1Resource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>

                                    <script language="javascript" type="text/javascript">
                                        LoadPhysicianExistingItems();
                                    </script>

                                    <asp:HiddenField ID="hdnShowAmount" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td width="31%" align="right">
                                    <asp:Label ID="lblGross" runat="server" Text="Gross" class="defaultfontcolor" meta:resourcekey="lblGrossResource1" />
                                </td>
                                <td width="20%" align="right" class="details_value">
                                    <asp:TextBox ID="txtGross" runat="server" Text="0.00" TabIndex="1" CssClass="textBoxRightAlign"
                                        Enabled="False" meta:resourcekey="txtGrossResource1"></asp:TextBox>
                                    <asp:HiddenField ID="hdnGross" runat="server" />
                                    <input type="hidden" runat="server" id="hdnStdDedID" value="0" />
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td align="right">
                                    <asp:Label ID="lblSubDeduction" runat="server" Text="Sub. Deduction" class="defaultfontcolor"
                                        meta:resourcekey="lblSubDeductionResource1" />
                                </td>
                                <td align="right" class="details_value">
                                    <asp:DropDownList ID="ddlSubDeduction" runat="server" TabIndex="2" OnSelectedIndexChanged="ddlSubDeduction_SelectedIndexChanged"
                                        onChange="DeductionCalculation();" Width="125px" meta:resourcekey="ddlSubDeductionResource1">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td align="right">
                                </td>
                                <td align="right">
                                    <asp:TextBox ID="txtSubDeduction" runat="server" TabIndex="3" onkeyup="total();ChangeFormat();"
                                        Height="22px" Text="0.00" CssClass="textBoxRightAlign" Enabled="False" meta:resourcekey="txtSubDeductionResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblDiscount" runat="server" Text="Discount" class="defaultfontcolor"
                                        meta:resourcekey="lblDiscountResource1" />
                                </td>
                                <td align="right">
                                    <asp:TextBox ID="txtDiscount" runat="server" TabIndex="4" onkeyup="total();" Text="0.00"
                                        CssClass="textBoxRightAlign"  onkeypress="return ValidateOnlyNumeric(this);"  onfocus="DefaultText('txtDiscount');"
                                        meta:resourcekey="txtDiscountResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">
                                    <asp:Label ID="Rs_server" Text="Tax" runat="server" meta:resourcekey="Rs_serverResource1"></asp:Label>
                                </td>
                                <td align="right">
                                    <asp:TextBox ID="txtTax" runat="server" CssClass="textBoxRightAlign" meta:resourcekey="txtTaxResource1"></asp:TextBox>
                                    <asp:HiddenField ID="hdfTax" runat="server" />
                                    <asp:HiddenField ID="hdnTaxAmount" runat="server" Value="0" />
                                    <div id="dvTaxDetails" align="left" runat="server">
                                    </div>
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td align="right">
                                    <asp:Label ID="lblGrossAmount" runat="server" Text="Gross Amount" class="defaultfontcolor"
                                        meta:resourcekey="lblGrossAmountResource1" />
                                </td>
                                <td align="right">
                                    <asp:TextBox ID="txtGrossAmount" runat="server" Text="0.00" Enabled="False" TabIndex="5"
                                        CssClass="textBoxRightAlign" meta:resourcekey="txtGrossAmountResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblRecievedAmount" runat="server" Text="Received Amount" class="defaultfontcolor"
                                        meta:resourcekey="lblRecievedAmountResource1" />
                                </td>
                                <td align="right">
                                    <asp:TextBox ID="txtRecievedAmount" runat="server" Text="0.00" Enabled="False" TabIndex="6"
                                        CssClass="textBoxRightAlign" meta:resourcekey="txtRecievedAmountResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <img alt="" onclick="ChangeImage();" src="../Images/collapse.jpg" id="imgDue" />
                                    <a href="javascript:animatedcollapse.toggle('Due');" onclick="ChangeImage();" runat="server"
                                        style="color: Black; font-size: 11">
                                        <asp:Label ID="Rs_Due" Text="Due" runat="server" meta:resourcekey="Rs_DueResource1"></asp:Label>
                                    </a>
                                </td>
                                <td align="right">
                                    <asp:TextBox ID="txtDue" runat="server" Text="0" Enabled="False" TabIndex="7" CssClass="textBoxRightAlign"
                                        meta:resourcekey="txtDueResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="color: Black">
                                    <div id="Due" style="display: none; padding-left: 30px" title="Due Details">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td align="center">
                                                    <uc6:DueDetail ID="dueDetail" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Rs_ServiceCharge" Text="Service Charge" runat="server" meta:resourcekey="Rs_ServiceChargeResource1"></asp:Label>
                                </td>
                                <td align="right">
                                    <asp:TextBox ID="txtServiceCharge" Enabled="False" runat="server" Text="0.00" TabIndex="9"
                                        CssClass="textBoxRightAlign" meta:resourcekey="txtServiceChargeResource1" />
                                    <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblGrandTotal" runat="server" Text="Net Value" class="defaultfontcolor"
                                        meta:resourcekey="lblGrandTotalResource1" />
                                </td>
                                <td align="right">
                                    <asp:TextBox ID="txtGrandTotal" Enabled="False" runat="server" Text="0.00" TabIndex="8"
                                        CssClass="textBoxRightAlign" meta:resourcekey="txtGrandTotalResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblAmountRecieved" runat="server" Text="Amount Recieved" class="defaultfontcolor"
                                        meta:resourcekey="lblAmountRecievedResource1" />
                                </td>
                                <td align="right">
                                    <asp:TextBox ID="txtAmountRecieved" runat="server" TabIndex="9" Text="0" ReadOnly="True"
                                        CssClass="textBoxRightAlign" meta:resourcekey="txtAmountRecievedResource1" />
                                    <asp:HiddenField ID="hdnAmountReceived" runat="server" Value="0" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    &nbsp;
                                </td>
                                <td align="right">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2" style="display: none;">
                                    <asp:CheckBox ID="chkisCreditTransaction" Text="Credit Transaction" runat="server"
                                        class="defaultfontcolor" onclick="checkIsCredit();" meta:resourcekey="chkisCreditTransactionResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <strong>
                                        <uc21:OtherCurrencyDisplay ID="OtherCurrencyDisplay1" runat="server" />
                                    </strong>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <uc9:paymentType ID="PaymentType" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <asp:Button ID="btnSave" Enabled="False" Text="Save" runat="server" TabIndex="10"
                                        OnClick="btnSave_Click" CssClass="btn" OnClientClick="return CheckBilling()"
                                        onmouseout="this.className='btn'" meta:resourcekey="btnSaveResource1"
                                        Width="59px" />
                                    <asp:Button ID="btnPrintBill" Text="PrintBill" runat="server" TabIndex="10" CssClass="btn"
                                        onmouseout="this.className='btn'" Visible="False"
                                        OnClick="btnPrintBill_Click" meta:resourcekey="btnPrintBillResource1" Width="75px" />
                                    <asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn" 
                                        onmouseout="this.className='btn'" OnClick="btnCancel_Click" Height="25px" meta:resourcekey="btnCancelResource1"
                                        Width="76px" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdfPayments" runat="server" />
    <asp:HiddenField ID="hdnPaymentNameExists" runat="server" />
    <asp:HiddenField ID="hdnPaymentsDeleted" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">


        function SetOtherCurrValues() {
            var pnetAmt = 0;
            pnetAmt = document.getElementById('txtGrandTotal').value == "" ? "0" : document.getElementById('txtGrandTotal').value;
            var ConValue = "OtherCurrencyDisplay1";
            SetPaybleOtherCurr(pnetAmt, ConValue, true);
        }

        GetCurrencyValues();
    </script>

</body>
</html>
