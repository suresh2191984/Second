<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BloodIssue.aspx.cs" Inherits="BloodBank_BloodIssue"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="paymentType"
    TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Department.ascx" TagName="Department" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/INVBillPrint.ascx" TagName="BillPrint" TagPrefix="uc11" %>

<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Blood Issue</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <script type="text/javascript" src="../Scripts/QuickBill.js"></script>

    <script src="../Scripts/InvOpBilling.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <script language="javascript" type="text/javascript">
    

    </script>

    <style type="text/css">
        #divRequestedComponents
        {
            width: 545px;
        }
        .style12
        {
            height: 23px;
        }
        .style13
        {
            width: 18%;
            height: 23px;
        }
        .style14
        {
            width: 7%;
        }
        .style15
        {
            width: 14px;
        }
        .style16
        {
            width: 10%;
            height: 23px;
        }
        .style17
        {
            width: 3%;
            height: 23px;
        }
        .style18
        {
            width: 25%;
            height: 23px;
        }
    </style>

    <script type="text/javascript">

        function ToInternalFormat(pControl) {

            if ("<%=LanguageCode%>" == "en-GB") {
                if (pControl.is('span')) {
                    return pControl.text();
                }
                else {
                    return pControl.val();
                }
            }
            else {
                return pControl.asNumber({ region: "<%=LanguageCode%>" });
            }
        }

        function ToTargetFormat(pControl) {
            // //debugger;
            if ("<%=LanguageCode%>" == "en-GB") {
                if (pControl.is('span')) {
                    return pControl.text();
                }
                else {
                    return pControl.val();
                }
            }
            else {
                return pControl.formatCurrency({ region: "<%=LanguageCode%>" }).val();
            }
        }

        function OnSuccess() {
            var rate = 0;
            var bagNumber = 0;
            var ComponentName = '';
            var ComponentID = 0;
            var Noofbags = 0;
            var hndField = ''; var HdnTotalAmt = 0;
            var hdnBagNumber = '';
            hdnBagNumber = document.getElementById('hdnBagNumber').value

            $('#divRequestedComponents table[id$="grdRequestedComponents"] input:checkbox[id$="chkIsTest"]:checked').each(function() {
                var $row = $(this).closest("tr");

                var chk = $row.find($('input[id$="chkIsTest"]')).attr('checked');
                if (chk != 'checked') {
                    alert("Compatability testing is should be done for issuing a blood commponents");
                    return false;
                }
                if (chk == 'checked') {
                    ComponentID = $row.find("input:text[id$=txtComponentID]").val();
                    ComponentName = $row.find("input:text[id$=txtComponentName]").val();
                    Noofbags = $row.find("input:text[id$=txtNoofunits]").val();
                    for (var i = 0; i < Noofbags; i++) {
                        // rate =$row.find("input:text[id$=txtRate" + i + "]").val() == "" ? "0" : $row.find("input:text[id$=txtRate" + i + "]").val();
                        bagNumber = $row.find("input:text[id$=txtBagNo" + i + "]").val();
                        if (bagNumber != hdnBagNumber) {
                            alert("Provide the Bagnumber from Stcok ");
                            return false;
                        }
                        hndField += ComponentID + "~" + ComponentName + "~" + Noofbags + "~" + rate + "~" + bagNumber + "^";
                        HdnTotalAmt += Number(rate);
                        console.log(HdnTotalAmt);
                    }
                }

            });

            document.getElementById('hdnIssueComponents').value = hndField;
            if (hndField !='') {
               fu_Tblist();
            }
            document.getElementById('hdnTotalAmount').value = HdnTotalAmt;

            SetOtherCurrValues();

        }

        function fu_Tblist() {
            while (count = document.getElementById('tblIssuecomponts').rows.length) {

                for (var j = 0; j < document.getElementById('tblIssuecomponts').rows.length; j++) {
                    document.getElementById('tblIssuecomponts').deleteRow(j);
                }
            }
            var Headrow = document.getElementById('tblIssuecomponts').insertRow(0);
            Headrow.id = "HeadID";
            Headrow.style.fontWeight = "bold";
            Headrow.className = "dataheader1"
            var cell1 = Headrow.insertCell(0);
            var cell2 = Headrow.insertCell(1);
            var cell3 = Headrow.insertCell(2);
            cell1.innerHTML = "Component Name";
            cell2.innerHTML = "BagNumber";
            cell3.innerHTML = "Action";
            var x = document.getElementById('<%= hdnIssueComponents.ClientID %>').value.split("^");
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split('~');
                    var row = document.getElementById('tblIssuecomponts').insertRow(1);
                    row.style.height = "13px";
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell4 = row.insertCell(2);
                    cell1.innerHTML = y[1];
                    cell2.innerHTML = y[4];
                    cell4.innerHTML =
                        "<input name='" + x[i] + "' onclick='btnDelete(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                }
            }
        }

        function btnDelete(sEditedData) {
            var i;
            var x = document.getElementById('<%= hdnIssueComponents.ClientID %>').value.split("^");
            document.getElementById('<%= hdnIssueComponents.ClientID %>').value = '';
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != sEditedData) {
                        document.getElementById('<%= hdnIssueComponents.ClientID %>').value += x[i] + "^";
                    }
                }
            }
            fu_Tblist();
        }


        function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            var ConValue = "OtherCurrencyDisplay1";
            var sVal = getOtherCurrAmtValues("REC", ConValue);
            var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
            var tempService = getOtherCurrAmtValues("SER", ConValue);
            var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);
            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 2);
            sVal = format_number(Number(sVal) + Number(TotalAmount), 2);
            if (PaymentAmount > 0) {

                if (Number(sNetValue) >= Number(sVal)) {
                    sVal = format_number(sVal, 2);
                    SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
                    var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
                    var pScrAmt = Number(pScr) * Number(CurrRate);
                    var pAmt = Number(sVal) * Number(CurrRate);

                    //                    document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2)
                    //                    ToTargetFormat($('#txtServiceCharge'));


                    var amtRec = document.getElementById('hdnTotalAmount').value;
                    amtRec = 0;
                    document.getElementById('hdnTotalAmount').value = format_number(Number(amtRec) + Number(pAmt), 2);
                    ToTargetFormat($('#hdnTotalAmount'));
                    //                    document.getElementById('txtAmountRecieved').value = format_number(Number(amtRec) + Number(pAmt), 2);
                    ToTargetFormat($('#hdnTotalAmount'));
                    var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

                    SetOtherCurrValues
                    //                    document.getElementById('txtNetAmount').value = format_number(Number(pTotal), 2);
                    //                    ToTargetFormat($('#txtNetAmount'));
                    //                    document.getElementById('hdnNetAmount').value = format_number(Number(pTotal), 2);
                    //                    ToTargetFormat($('#hdnNetAmount'));
                    //                    CheckDueTotal();
                    //                    doCalcReimburse();
                    return true;
                }
                else {
                    alert('Amount is provided  greater than net amount')
                    return false;
                }
            }
            //            else {
            //                doCalcReimburse();
            //                return true;
            //            }



        }
        function SetOtherCurrValues() {
            var pnetAmt = document.getElementById('hdnTotalAmount').value;
            var ConValue = "OtherCurrencyDisplay1";
            SetPaybleOtherCurr(pnetAmt, ConValue, true);

        }

        var ChkID = [];
        function GetProductDetails(ProductID) {
       
            $('#tblProductDetails').empty();

            $('#divRequestedComponents table[id$="grdRequestedComponents"] input:checkbox[id$=chkSelect]:checked').each(function() {
                var $row = $(this).closest("tr");

                var chk = $row.find($('input[id$="chkSelect"]')).attr('checked');

                if (chk == 'checked') {
                
                    ComponentID = $row.find("input:text[id$=txtComponentID]").val();
                    $.ajax({
                        type: "POST",
                        url: "../OPIPBilling.asmx/GetBloodBags",
                        data: "{'ProductID':'" + ComponentID + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        success: function(data, value) {
                        $('#tblProductDetails').empty();
                            var GetData = data.d;
                            if (GetData != '') {
                                Drawtable(GetData);
                            }
                            else {
                                alert("There is no Stock to be Issue");
                            }

                        },
                        error: function(result) {
                            alert("Error");
                        }
                    });
                }
                ChkID.push($row.find($('input[id$="chkSelect"]')).attr('id'));
            });
        }

        function FormatJsonDate(jsonDt) {
            var MIN_DATE = jsonDt; // const

            var date = new Date(parseInt(jsonDt.substr(6, jsonDt.length - 8)));
            return date.toString() == new Date(MIN_DATE).toString() ? "" : (date.getMonth() + 1) + "/" + date.getDate() + "/" + date.getFullYear();
            
            
        }

        function Drawtable(GetData) {
                $('#tblProductDetails').empty();
                $('#tblProductDetails').append('<tr class = "dataheader1"><td><asp:Label ID ="lblBagNumber" runat ="server" Text ="BagNumber"></asp:Label></td><td><asp:Label ID ="lblStockInHand" runat ="server" Text ="StockInHand"></asp:Label></td><td><asp:Label ID ="lblBatchno" runat ="server" Text ="Batch Number"></asp:Label></td><td><asp:Label ID ="lblExpiryDate" runat ="server" Text ="Expiry Date(MM/DD/YYYY)"></asp:Label></td></tr>');
                $.each(GetData, function(index, Item) {

                    $('#tblProductDetails').append('<tr><td>' + Item.BagNumber + '</td><td>' + Item.Volume + '</td><td>' + Item.BloodGroupName + '</td><td>' + FormatJsonDate(Item.ExpiryDate) + '</td></tr>');
                    document.getElementById('hdnSID').value = Item.ProductID;
                    document.getElementById('hdnExpDate').value = FormatJsonDate(Item.ExpiryDate);
                    document.getElementById('hdnBagNumber').value = Item.BagNumber;
                });
          
        }

        function popupprint() {
            var prtContent = "";

            prtContent = document.getElementById('POPUP');

            var WinPrint = window.open('', '', 'letf=400,top=200,toolbar=0,scrollbars=1,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            // WinPrint.close();
        }
    </script>

</head>
<body>
    <form id="frmBloodIssue" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
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
                <uc3:Header ID="AdminHeader" runat="server" />
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
                    <table cellpadding="0" cellspacing="0" width="100%" border="0">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:Panel ID="pnlIssue" runat="server" GroupingText="Issue Blood/BloodComponent"
                            Style="font-family: verdana">
                            <table width="100%" cellpadding="1" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblRequestNo" Text="Blood Request Number :" runat="server" meta:resourcekey="lblRequestNoResource1"></asp:Label>
                                        <asp:Label ID="lblRequestNoValue" runat="server" meta:resourcekey="lblRequestNoValueResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblRecepientName" Text="Recepient Name : " runat="server" meta:resourcekey="lblRecepientNameResource1"></asp:Label>
                                        <asp:Label ID="lblRecepientNameValue" runat="server" meta:resourcekey="lblRecepientNameValueResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblAge" Text="Age : " runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                        <asp:Label ID="lblAgeValue" runat="server" meta:resourcekey="lblAgeValueResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblSex" Text="Sex : " runat="server" meta:resourcekey="lblSexResource1"></asp:Label>
                                        <asp:Label ID="lblSexValue" runat="server" meta:resourcekey="lblSexValueResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblBloodGroup" Text="Blood Group : " runat="server" meta:resourcekey="lblBloodGroupResource1"></asp:Label>
                                        <asp:Label ID="lblBloodGroupValue" runat="server" meta:resourcekey="lblBloodGroupValueResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblAddress" Text="Address/PhoneNo : " runat="server" meta:resourcekey="lblAddressResource1"></asp:Label>
                                        <asp:Label ID="lblAddressValue" runat="server" meta:resourcekey="lblAddressValueResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            &nbsp;&nbsp;
                            <table width ="75%">
                                <tr  cssclass="Duecolor">
                                    <td align ="center" >
                                        <asp:Label ID="lblRequestedComponents" Text="Requested Blood Components" Font-Underline="True"
                                            Width="100%" Font-Bold="True" Font-Size="Medium" runat="server" ></asp:Label>
                                    </td>
                                </tr>
                                <tr >
                                    <td align ="center" >
                                        <div id="divRequestedComponents">
                                            <asp:GridView ID="grdRequestedComponents" runat="server" AutoGenerateColumns="False"
                                                BackColor="AliceBlue" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                CellPadding="3" Font-Names="Verdana" Font-Size="9pt" OnRowDataBound="grdRequestedComponents_RowDataBound"
                                                Width="672px">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Select">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkSelect" runat="server" onClick="GetProductDetails(this.value);" />
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="Duecolor" />
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Component Name">
                                                        <ItemTemplate>
                                                            <asp:TextBox Text='<%#Eval("ProductID") %>' ID="txtComponentID" runat="server" Style="display: none"></asp:TextBox>
                                                            <asp:Label Text='<%#Eval("ComponentName") %>' ID="lblComponentname" runat="server"></asp:Label>
                                                            <asp:TextBox Text='<%#Eval("ComponentName") %>' ID="txtComponentName" runat="server"
                                                                Style="display: none"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="Duecolor" />
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Bags">
                                                        <ItemTemplate>
                                                            <asp:Label Text='<%#Eval("NoOfUnits") %>' ID="lblnoofunits" runat="server"></asp:Label>
                                                            <asp:TextBox Text='<%#Eval("NoOfUnits") %>' ID="txtNoofunits" runat="server" Style="display: none"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="Duecolor" />
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Bag Number" meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                                                            <asp:HiddenField ID="hdnBagNumber" runat="server" />
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="Duecolor" />
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Rate" meta:resourcekey="TemplateFieldResource2" Visible ="false" >
                                                        <ItemTemplate>
                                                            <asp:PlaceHolder ID="PlaceHolder2" runat="server"></asp:PlaceHolder>
                                                            <asp:HiddenField ID="hdnrates" runat="server" />
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="Duecolor" />
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Is Compatability Testing done?">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkIsTest" runat="server" />
                                                        </ItemTemplate>
                                                        <ItemStyle Width="10%" />
                                                        <HeaderStyle CssClass="Duecolor" />
                                                    </asp:TemplateField>
                                                    
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                      
                                    </td>
                                    <td>
                                      <input type="button" id="btnAdd" value="Add" runat="server" onclick="OnSuccess();"
                                            class="btn" />    
                                    </td>
                                </tr>
                            </table>
                            <div>
                            <table cssclass="Duecolor" id="tblProductDetails" class="dataheaderInvCtrl" style="display: block">
                            </table>
                            </div>
                        </asp:Panel>
                        
                      
                        <table border="0" id="tblIssuecomponts" cssclass="dataheaderInvCtrl" width="60%">
                        </table>
                       
                        <div style ="display :none";>
                            <uc21:OtherCurrencyDisplay ID="OtherCurrencyDisplay1" runat="server" IsDisplayPayedAmount="false" />
                        </div>
                        <div id="divpayment" style="display: none">
                            <uc11:paymentType ID="Payment" runat="server" />
                        </div>
                        <div>
                            <table width="100%">
                                <tr>
                                    <td align="center">
                                        <asp:Button ID="btnSave" Text="Issue" runat="server" CssClass="btn" OnClick="btnSave_Click"
                                            meta:resourcekey="btnSaveResource1" />
                                        <asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn" OnClick="btnCancel_Click"
                                            meta:resourcekey="btnCancelResource1" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        
                        <div id="POPUP" align="center" style="display: none;">
                        <table>
                        <tr>
                        <td colspan ="7" align ="center" >
                        <asp:Label ID ="lblheader" Text ="Blood Component Issue Details" runat ="server" Font-Underline  ="true" Font-Bold ="true"  ></asp:Label>
                        </td>
                        </tr>
                         <tr>
                                            <td align="left" nowrap="nowrap" class="style16">
                                                <asp:Label  ID="PatientNo" Text="Patient No" runat="server" ></asp:Label>
                                            </td>
                                            <td align="left" nowrap="nowrap" class="style17">
                                                &nbsp; :                                             </td>
                                            <td align="left" nowrap="nowrap" class="style18">
                                                <span style="width: 23%">
                                                    <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight:bold;font-size:smaller" meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                                </span>
                                            </td>
                                             <td align="left" nowrap="nowrap" class="style16">
                                                <label>
                                                    <asp:Label ID="lblBillDate" Text="Issued Date" runat="server" ></asp:Label></label>
                                            </td>
                                             <td align="left" nowrap="nowrap" class="style17">
                                                &nbsp;:
                                            </td>
                                              <td align="left" nowrap="nowrap" class="style18">
                                                <asp:Label ID="lblIssuedDate" runat="server" Style="font-weight:bold;font-size:smaller" ></asp:Label>
                                            </td>
                                        </tr>
                                         <tr>
                                            <td align="left" nowrap="nowrap" style="width: 25%;">
                                                <asp:Label ID="Label1" runat="server" Text="Patient Name" 
                                                   ></asp:Label>
                                               
                                            </td>
                                          <td align="left" nowrap="nowrap" style="width: 3%">
                                                &nbsp; :
                                            </td>
                                            <td align="left" nowrap="nowrap">
                                                <span style="width: 23%">
                                                <asp:Label ID="lblTitleName" runat="server" 
                                                    Style="font-weight:bold;font-size:smaller" 
                                                    meta:resourcekey="lblTitleNameResource1"></asp:Label>
                                                    <asp:Label ID="lblName" runat="server" Style="font-weight:bold;font-size:smaller" ></asp:Label>
                                                </span>
                                            </td>
                                            <td align="left" nowrap="nowrap" class="style14">
                                                <asp:Label ID="Rs_BillNo" Text="Issued No" runat="server" ></asp:Label>
                                            </td>
                                            <td align="left" nowrap="nowrap" class="style15">
                                                &nbsp;:&nbsp;
                                            </td>
                                            <td align="left" nowrap="nowrap" style="width: 23%">
                                                <asp:Label ID="lblBillNo" runat="server" Style="font-weight:bold;font-size:smaller" ></asp:Label>
                                            </td>
                                        </tr>
                                         <tr>
                                            <td align="left" nowrap="nowrap" class="style12">
                                                <asp:Label ID="PatientAge" Text="Patient Age" runat="server"></asp:Label>
                                            </td>
                                            <td align="left" nowrap="nowrap" class="style13">
                                                &nbsp; :
                                            </td>
                                            <td align="left" nowrap="nowrap" class="style12">
                                                <asp:Label ID="lblPAge" runat="server" Style="font-weight:bold;font-size:smaller" ></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" nowrap="nowrap">
                                                <asp:Label ID="lblsexP" runat="server" Text="Sex" 
                                                    meta:resourcekey="Label2Resource1"></asp:Label>
                                                
                                            </td>
                                            <td align="left" nowrap="nowrap" class="style1">
                                                &nbsp; :
                                            </td>
                                            <td align="left" nowrap="nowrap">
                                                <asp:Label ID="lblSexValueP" runat="server" Style="font-weight:bold;font-size:smaller"></asp:Label>
                                            </td>
                                        </tr>
                                                                                        
                                                    </table>
                                                    <table width ="100%">
                                                        <asp:GridView ID="gvResult" runat="server" AutoGenerateColumns="False" Width="100%" runat ="server" > 
                                                    <Columns>
                                                        <asp:BoundField DataField="BatchNo" HeaderText="BagNumber"  />
                                                        <asp:BoundField DataField="FeeDescription" HeaderText="Description" />
                                                       
                                                    </Columns>
                                                    </asp:GridView>
                                                    </table>
                                                    
                        </div>
                       
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnBagNo" runat="server" />
    <asp:HiddenField ID="hdnRate" runat="server" />
    <asp:HiddenField ID="hdnIssueComponents" runat="server" />
    <asp:HiddenField ID="hdnTotalAmount" runat="server" Value="0" />
    <asp:HiddenField ID ="hdnSID" runat ="server" />
    <asp:HiddenField ID ="hdnExpDate" runat ="server" />
    <asp:HiddenField ID ="hdnBagNumber" runat ="server" />
    </form>
</body>
</html>

<script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>

