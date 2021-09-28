<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GenerateBill.aspx.cs" Inherits="Billing_GenerateBill"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/DisplayAllDataTemp.ascx" TagName="DisplayAllData"
    TagPrefix="uc17" %>
<%@ Register Src="../CommonControls/QuickBillReferedPhysician.ascx" TagName="ReferedPhysician"
    TagPrefix="uc16" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="paymentType"
    TagPrefix="uc13" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<%@ Register Src="../CommonControls/QuickPatientReg.ascx" TagName="QuickPatient"
    TagPrefix="uc18" %>
<%@ Register Src="../CommonControls/SurgeryAdvanceQuickBill.ascx" TagName="SurgeryBilling"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/IPClientTpaInsurance.ascx" TagName="ClientTpa"
    TagPrefix="uc19" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="Topheader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/DepositUsage.ascx" TagName="DepositUsage" TagPrefix="uc10" %>
<%@ Register Src="~/CommonControls/SecPrescriptionPage.ascx" TagName="ucSecPage"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientCreditLimt.ascx" TagName="CreditLimt"
    TagPrefix="uc22" %>
<%@ Register Src="../CommonControls/Ambulance.ascx" TagName="Ambulance" TagPrefix="uc23" %>
<%@ Register Src="~/CommonControls/ValidationMesseage.ascx" TagName="ucMandatory" TagPrefix="uc120" %>
<%@ Register Src="~/CommonControls/AmountApprovalDetails.ascx" TagName="ucAmountApprovalDetails"
    TagPrefix="uc121" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Patient Billing Bill</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="Stylesheet" type="text/css" />
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <link href="../StyleSheets/DHEBAdder.css" rel="Stylesheet" type="text/css" />
</head>
<body onkeydown="SuppressBrowserRefresh();">
    <form id="form1" runat="server">
   
    <asp:ScriptManager ID="scrpt" runat="server">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
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
                <td width="15%" valign="top" id="menu" style="display: none;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/show.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:Topheader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata1">
                        <asp:UpdatePanel ID="pnlQuickBill" runat="server">
                            <ContentTemplate>
                                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="pnlQuickBill" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter">
                                        </div>
                                        <div align="center" id="processMessage">
                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                            <br />
                                            <br />
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <table class="biltb" width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td class="dataheaderInvCtrl">
                                            <uc18:QuickPatient ID="QPR" runat="server"></uc18:QuickPatient>
                                        </td>
                                    </tr>
                                    <tr id="divMakeBill" runat="server">
                                        <td id="Td1" runat="server">
                                            <div>
                                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td colspan="3" class="dataheaderInvCtrl">
                                                            <div style="vertical-align: text-top;">
                                                                <div id="divRef1" onclick="showResponses('divRef1','divRef2','divRef3',1);" style="cursor: pointer;
                                                                    display: none;" runat="server">
                                                                    &nbsp;<img src="../Images/plus.png" alt="Show" />
                                                                    <asp:Label ID="Rs_ReferringPhysician" Text="Referring Physician" Font-Bold="True"
                                                                        runat="server" meta:resourcekey="Rs_ReferringPhysicianResource1" />
                                                                </div>
                                                                <div id="divRef2" style="cursor: pointer; display: block; cursor: pointer;" onclick="showResponses('divRef1','divRef2','divRef3',0);"
                                                                    runat="server">
                                                                    &nbsp;<img src="../Images/minus.png" alt="Show" />
                                                                    <asp:Label ID="lblrefphy1" Text="Referring Physician" Font-Bold="True" runat="server"
                                                                        meta:resourcekey="lblrefphy1Resource1" />
                                                                </div>
                                                            </div>
                                                            <div id="divRef3" style="display: block;" title="Referring Physician">
                                                                <uc16:ReferedPhysician SpecialityVisiblity="true" ReferringType="Visit Level Referring Physician : "
                                                                    ID="ReferDoctor1" runat="server" />
                                                                <div id="dvH" runat="server" style="display: none;">
                                                                    <asp:Label ID="lblreferHos" Text="Refering Hospital" Font-Bold="True" runat="server"
                                                                        meta:resourcekey="lblreferHosResource1" />
                                                                    <asp:DropDownList ID="ddlHospital" ToolTip="Select Refering Hospital" runat="server"
                                                                        TabIndex="25" Width="250px" OnSelectedIndexChanged="ddlHospital_SelectedIndexChanged"
                                                                        normalWidth="250px" onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);">
                                                                    </asp:DropDownList>
                                                                </div>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" class="dataheaderInvCtrl">
                                                            <div style="vertical-align: text-top;">
                                                                <div id="divMore1" onclick="showResponses('divMore1','divMore2','divMore3',1);" style="cursor: pointer;
                                                                    display: block;" runat="server">
                                                                    &nbsp;<img src="../Images/plus.png" alt="Show" />
                                                                    <asp:Label ID="Rs_ClientInsuranceTPA" Text="Client & Insurance / TPA" Font-Bold="True"
                                                                        runat="server" />
                                                                </div>
                                                                <div id="divMore2" style="cursor: pointer; display: block; cursor: pointer;" onclick="showResponses('divMore1','divMore2','divMore3',0);"
                                                                    runat="server">
                                                                </div>
                                                            </div>
                                                            <div id="divMore3" style="display: none;" title="Client And Insurance / TPA">
                                                                <uc19:ClientTpa IsBilling="Y" ID="uctlClientTpa" runat="server" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3">
                                                            <table class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Rs_SelectPaymentType" Text="Select Payment Type " runat="server" meta:resourcekey="Rs_SelectPaymentTypeResource1" />
                                                                        <asp:CheckBox ID="ChkMapped" Text="Show Only Mapped Items" class="btn" onClick="javascript:chkShowMapped();"
                                                                            runat="server" meta:resourcekey="ChkMappedResource1" />
                                                                    </td>
                                                                    <td id="tdIsAddedtoServices" runat="server" style="display: none">
                                                                        <asp:CheckBox ID="ChkIsAddedtoServices" Text="Is Added To Services?" class="btn"
                                                                            onClick="javascript:ShowNHideBtn();" runat="server" meta:resourcekey="ChkIsAddedtoServicesResource1" />
                                                                    </td>
                                                                    <td valign="top" align="right">
                                                                        <asp:Button ID="Btnrstbill1" runat="server" Text="Reset Billed Items" TabIndex="24"
                                                                            Height="20px" CssClass="btn" Font-Size="12px" OnClientClick="Javascript:return clearbilleditem();"
                                                                            meta:resourcekey="Btnrstbill1Resource1" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2" valign="top">
                                                                        <asp:RadioButtonList ID="rblFeeTypes" runat="server" RepeatDirection="Horizontal"
                                                                            RepeatColumns="8" onClick="Javascript:chkPros();resetpreviousradiodetails();changelabel();">
                                                                        </asp:RadioButtonList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2" class="dataheaderInvCtrl">
                                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                            <tr>
                                                                                <td colspan="10">
                                                                                    <uc16:ReferedPhysician ReferringType="Item Level Referring Physician : " ID="ReferDoctor2"
                                                                                        runat="server" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="Rs_Description" Text="Description" runat="server" meta:resourcekey="Rs_DescriptionResource1" />
                                                                                    <asp:Label ID="Rs_DoctorName" Text="Enter Doctor Name " runat="server" Style="display: none"
                                                                                        meta:resourcekey="Rs_DoctorNameResource1" />
                                                                                    <asp:Label ID="Rs_ItemName" Text="Enter Item Name " runat="server" Style="display: none"
                                                                                        meta:resourcekey="Rs_ItemNameResource1" />
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox CssClass="Txtboxsmall" ID="txtName" onfocus="DivCollapse();chkPros();"
                                                                                        runat="server" TabIndex="25" onkeydown="return setClientfocus();"  onchange="boxExpand(this);"></asp:TextBox>
                                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtName"
                                                                                        EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                                                        OnClientItemSelected="IAmSelected" CompletionListCssClass="wordWheel listMain .box"
                                                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                        ServiceMethod="GetBillingItems" ServicePath="~/OPIPBilling.asmx" UseContextKey="True"
                                                                                        OnClientItemOver="SelectedTest" DelimiterCharacters="" Enabled="True">
                                                                                    </ajc:AutoCompleteExtender>
                                                                                    <td>
                                                                                        <asp:Label ID="Rs_PerformingPhysicianName" Text="PerformingPhysicianName" runat="server"
                                                                                            meta:resourcekey="Rs_PerformingPhysicianNameResource1" />
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox CssClass="Txtboxsmall" ID="txtperphy" onfocus="DivCollapse();chkPros();"
                                                                                            runat="server" TabIndex="26" onchange="boxExpand(this);"></asp:TextBox>
                                                                                    </td>
                                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" TargetControlID="txtperphy"
                                                                                        EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                                                        OnClientItemSelected="funPerphy" CompletionListCssClass="wordWheel listMain .box"
                                                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                        ServiceMethod="GetPerformingPhysicianList" ServicePath="~/OPIPBilling.asmx" UseContextKey="True"
                                                                                        DelimiterCharacters="" Enabled="True">
                                                                                    </ajc:AutoCompleteExtender>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:Label ID="Rs_Quantity" Text="Quantity" runat="server" meta:resourcekey="Rs_QuantityResource1" />
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox CssClass="Txtboxverysmall" MaxLength="3"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                                                        ID="txtQty" Width="25px" Style="text-align: right;" runat="server" Text="1" TabIndex="27"></asp:TextBox>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:Label ID="Rs_Amount" Text="Amount" runat="server" meta:resourcekey="Rs_AmountResource1" />
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox CssClass="Txtboxsmall"  onkeypress="return ValidateOnlyNumeric(this);"  ID="txtAmount"
                                                                                        Width="60px" runat="server" Style="text-align: right;" Text="0" TabIndex="28"></asp:TextBox>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:Label ID="Rs_Date" Text="Date" runat="server" meta:resourcekey="Rs_DateResource1" />
                                                                                </td>
                                                                                <td nowrap="nowrap">
                                                                                    <asp:TextBox CssClass="Txtboxsmall" ID="txtDate" Width="105px" Style="text-align: right;"
                                                                                        runat="server" TabIndex="29"></asp:TextBox>
                                                                                    <a id="ahrImgBtn" href="javascript:NewCal('txtDate','ddmmyyyy',true,12);">
                                                                                        <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date" /></a>
                                                                                    <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                        CausesValidation="False" Style="display: none;" />
                                                                                </td>
                                                                                <td>
                                                                                    <asp:CheckBox CssClass="bilddltb" ID="chkIsRI" runat="server" Text="Is Reimbursable"
                                                                                        TabIndex="30" meta:resourcekey="chkIsRIResource1" />
                                                                                </td>
                                                                                <td>
                                                                                    <asp:Button ID="btnadd" runat="server" Text="Add" OnClientClick="return freetxtCheck();"
                                                                                        CssClass="btn" Width="70px" TabIndex="31" meta:resourcekey="btnaddResource1" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td id="tdAmbulance" style="display: none;" runat="server" colspan="15">
                                                                                    <uc23:Ambulance ID="ucAmb" runat="server" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                        <table width="100%">
                                                                            <tr>
                                                                                <div id="DivPaymentTypeDetails" runat="server">
                                                                                    <td>
                                                                                        <asp:Label ID="alert" runat="server" ForeColor="Red"></asp:Label>
                                                                                    </td>
                                                                                </div>
                                                                            </tr>
                                                                        </table>
                                                                        <asp:Label ID="lblRedirectURL" runat="server" Visible="False"></asp:Label>
                                                                        <asp:HiddenField ID="hdnSelectedPhysician" Value="0" runat="server" />
                                                                        <asp:HiddenField ID="hdnName" runat="server" />
                                                                        <asp:HiddenField ID="hdnTotalAmtRec" Value="0" runat="server" />
                                                                        <asp:HiddenField ID="hdnAmt" runat="server" />
                                                                        <asp:HiddenField ID="hdnID" runat="server" />
                                                                        <asp:HiddenField ID="hdnFeeType" runat="server" />
                                                                        <asp:HiddenField ID="hdnPhyLID" runat="server" />
                                                                        <asp:HiddenField ID="hdnSID" runat="server" />
                                                                        <asp:HiddenField ID="hdnNetValue" runat="server" Value="0" />
                                                                        <asp:HiddenField ID="hdnAddedAmt" runat="server" Value="0" />
                                                                        <asp:HiddenField ID="hdnURL" runat="server" />
                                                                        <asp:HiddenField ID="hdnOPIP" runat="server" />
                                                                        <asp:HiddenField ID="hdnRecVariableAmount" Value="0" runat="server" />
                                                                        <asp:HiddenField ID="hdnOPCardDetail" runat="server" />
                                                                        <asp:HiddenField ID="hdnperphyID" runat="server" />
                                                                        <asp:HiddenField ID="PatVistiRefID" Value="0" runat="server" />
                                                                        <asp:HiddenField ID="hdnDisorEnhpercent" runat="server" />
                                                                        <asp:HiddenField ID="hdnDisorEnhType" runat="server" />
                                                                        <asp:HiddenField ID="hdnRemarks" runat="server" />
                                                                        <asp:HiddenField ID="hdnvisittypenew" runat="server" />
                                                                        <asp:HiddenField ID="hdnNonReimbursableAmount" Value="0" runat="server" />
                                                                        <asp:HiddenField ID="hdnRefferedPhyID" Value="0" runat="server" />
                                                                        <asp:HiddenField ID="hdnRefferedPhyType" runat="server" />
                                                                        <asp:HiddenField ID="hdnActualAmount" Value="0.00" runat="server" />
                                                                        <asp:HiddenField ID="hdnAmbulanceDetails" runat="server" />
                                                                        <input id="hdnLocationID" type="hidden" value="0" runat="server" />
                                                                        <input id="hdnReimbursableAmount" runat="server" type="hidden" value="0" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="3" class="dataheaderInvCtrl">
                                                            <uc17:DisplayAllData ID="dspData" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="bottom" style="font-weight: bold;">
                                                            <div>
                                                                <uc22:CreditLimt ID="ucCreditLimit" runat="server" />
                                                                <asp:HiddenField ID="hdnNeedOrgCreditLimit" runat="server" Value="N" />
                                                            </div>
                                                            <div id="trDepositUsage" runat="server">
                                                                <uc10:DepositUsage ID="DepositUsageCtrl" runat="server" BaseControlID="txtGrandTotal"
                                                                    TargetControlID="hdnDepositUsed" OtherCurrencyControlID="OtherCurrencyDisplay1"
                                                                    DisplayControlID="txtAmountRecieved" />
                                                            </div>
                                                            <br />
                                                            <span id="spanAmount1" runat="server">
                                                                <asp:Label ID="lblNonMedicalDisplay" runat="server" Text="Non-MedicalItems : " meta:resourcekey="lblNonMedicalDisplayResource1">
                                                                </asp:Label><asp:Label ID="lblNonMedicalAmt" runat="server" Text="0.00" meta:resourcekey="lblNonMedicalAmtResource1"></asp:Label><br />
                                                            </span><span id="spanAmount2" runat="server">
                                                                <uc21:OtherCurrencyDisplay ID="OtherCurrencyDisplay1" runat="server" />
                                                            </span>
                                                        </td>
                                                          <td align="left" valign="bottom" style="font-weight: bold; display: none;" id="tdCopayment">
                                                            <table border="1">
                                                                <tr class="dataheader1">
                                                                    <td>
                                                                        <asp:Label ID="Label2" runat="server" Text="Claim Amount " />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label5" runat="server" Text="Medical Amount" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label3" runat="server" Text="Non Medical Amount" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label1" runat="server" Text="Actual Copayment " />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblPreAuthAmt" Text="Towards Amount" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="center">
                                                                        <asp:Label ID="lblClaminAmount" runat="server" Text="0.00"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblMedical" runat="server" Text="Medical Amount" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblNonMedical" runat="server" Text="0.00" />
                                                                    </td>
                                                                    <td align="center">
                                                                        <asp:Label ID="lblActualCopaymenttxt" runat="server" Text="0.00"></asp:Label>
                                                                    </td>
                                                                    <td align="center">
                                                                        <asp:Label ID="lblDifferenceAmount" runat="server" Text="0.00"></asp:Label>
                                                                    </td>
                                                                    <asp:HiddenField ID="hdnClaim" runat="server" Value="0" />
                                                                    <asp:HiddenField ID="hdnTotalCopayment" runat="server" Value="0" />
                                                                    <asp:HiddenField ID="hdnTowardsAmount" runat="server" Value="0" />
                                                                </tr>
                                                            </table>
                                                        </td>

                                                        <td align="right">
                                                            <table id="tblAmount" cellpadding="0" cellspacing="0" border="0" runat="server">
                                                                <tr runat="server">
                                                                    <td runat="server">
                                                                        <asp:Label ID="lblDueAmount" meta:resourcekey="lblDueAmountResource1" runat="server"
                                                                            Text="DueAmount" CssClass="labletext"></asp:Label>
                                                                    </td>
                                                                    <td align="left" runat="server">
                                                                        <img alt="" onclick="ChangeImage1();ChangeDisplay();" src="../Images/collapse.jpg"
                                                                            id="imgDue" style="display: none" />
                                                                        <asp:TextBox CssClass="Txtboxsmall" ID="txtDue" runat="server" Text="0.00" Width="50px"
                                                                            ReadOnly="True" />
                                                                        <asp:HiddenField ID="hdnDue" runat="server" Value="0" />
                                                                        <asp:HiddenField ID="hdnDPDetails" runat="server" />
                                                                    </td>
                                                                    <td runat="server">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td align="left" runat="server">
                                                                        <asp:Label ID="lblGross" runat="server" Text="Gross" class="defaultfontcolor" CssClass="labletext"
                                                                            meta:resourcekey="lblGrossResource1" />
                                                                    </td>
                                                                    <td align="right" runat="server">
                                                                        <asp:TextBox CssClass="Txtboxsmall" ID="txtGross" runat="server" Text="0.00" Enabled="False"></asp:TextBox>
                                                                        <asp:HiddenField ID="hdnGrossValue" runat="server" Value="0" />
                                                                    </td>
                                                                </tr>
                                                                <tr style="display: none;" runat="server">
                                                                    <td colspan="2" runat="server">
                                                                    </td>
                                                                    <td runat="server">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td align="right" runat="server">
                                                                        <asp:Label ID="lblRecievedAmount" runat="server" Text="Previous Received Amount"
                                                                            class="defaultfontcolor" CssClass="labletext" meta:resourcekey="lblRecievedAmountResource1" />
                                                                    </td>
                                                                    <td align="right" runat="server">
                                                                        <asp:TextBox CssClass="Txtboxsmall" ID="txtRecievedAmount" runat="server" Text="0.00"
                                                                            Enabled="False" />
                                                                    </td>
                                                                </tr>
                                                                <tr style="display: none;" runat="server">
                                                                    <td colspan="2" runat="server">
                                                                    </td>
                                                                    <td runat="server">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td align="left" runat="server">
                                                                    </td>
                                                                    <td align="right" runat="server">
                                                                        <asp:TextBox CssClass="Txtboxsmall" ID="txtSubDeduction" runat="server" Height="22px"
                                                                            Text="0.00" onblur="ChangeFormat();" Enabled="False"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server">
                                                                    <td align="right" runat="server">
                                                                        &nbsp;
                                                                        <asp:Label ID="tdDiscountLabel" Text="Select the Discount" runat="server" CssClass="labletext"
                                                                            meta:resourcekey="tdDiscountLabelResource1" />
                                                                    </td>
                                                                    <td align="left" runat="server">
                                                                        &nbsp;<asp:DropDownList ID="ddDiscountPercent" ToolTip="Select the Discount" onChange="javascript:setDiscount();"
                                                                            runat="server" Style="margin-left: 0px" TabIndex="32" CssClass="ddlsmall">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td align="left" runat="server">
                                                                        &nbsp;<asp:TextBox ID="txtDiscountPercent" runat="server" CssClass="invtextb" MaxLength="9"
                                                                            onkeyup="javascript:CorrectTotal();" onblur="ChangeFormat(); ValidateDiscountReason();"
                                                                             onkeypress="return ValidateOnlyNumeric(this);"  Style="display: none;" Text="0.00" />
                                                                    </td>
                                                                    <td align="left" runat="server">
                                                                        <asp:Label ID="lblDiscount" runat="server" Text="Discount" class="defaultfontcolor"
                                                                            CssClass="labletext" meta:resourcekey="lblDiscountResource1" />
                                                                    </td>
                                                                    <td align="right" runat="server">
                                                                        <asp:TextBox CssClass="Txtboxsmall" ID="txtDiscount" runat="server" onkeyup="javascript:CorrectTotal();totalCalculate();SetOtherCurrValues();"
                                                                            Text="0.00" onblur="ChangeFormat(); ValidateDiscountReason();"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                                            TabIndex="33" />
                                                                    </td>
                                                                </tr>
                                                                <tr id="trDiscountReason" style="display: none;" runat="server">
                                                                    <td align="right" class="style2" runat="server">
                                                                        &nbsp;
                                                                        <asp:Label ID="DiscountReason" Visible="False" Text="Select the Reason For Discount"
                                                                            runat="server" CssClass="labletext" meta:resourcekey="DiscountReasonResource1" />
                                                                    </td>
                                                                    <td align="left" runat="server">
                                                                        <asp:DropDownList ID="DdlDiscountreason" runat="server" onchange="GetDiscountReasonlist()" CssClass="ddlsmall">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td runat="server">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td align="left" runat="server">
                                                                        <asp:Label ID="lblreasonfordiscount" runat="server" Text="Reason for Discount" class="defaultfontcolor"
                                                                            CssClass="labletext" meta:resourcekey="lblreasonfordiscountResource1" />
                                                                    </td>
                                                                    <td align="right" runat="server">
                                                                        <asp:TextBox CssClass="Txtboxsmall" ID="txtDiscountReason" runat="server" />
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server">
                                                                    <td colspan="2" runat="server">
                                                                    </td>
                                                                    <td runat="server">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td align="left" valign="top" runat="server">
                                                                        <asp:Label ID="Rs_Tax" Text="Tax" runat="server" CssClass="labletext" meta:resourcekey="Rs_TaxResource1" />
                                                                    </td>
                                                                    <td align="right" runat="server">
                                                                        <asp:TextBox CssClass="Txtboxsmall" ID="txtTax" onkeyup="totalCalculate();SetOtherCurrValues();"
                                                                            runat="server" TabIndex="34"></asp:TextBox>
                                                                        <asp:HiddenField ID="hdnTaxAmount" runat="server" Value="0" />
                                                                        <asp:HiddenField ID="hdfTax" runat="server" />
                                                                        <div id="dvTaxDetails" align="left" runat="server">
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server">
                                                                    <td colspan="2" runat="server">
                                                                    </td>
                                                                    <td runat="server">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td align="left" runat="server">
                                                                        <asp:Label ID="Rs_ServiceCharge" Text="Service Charge" runat="server" CssClass="labletext"
                                                                            meta:resourcekey="Rs_ServiceChargeResource1" />
                                                                    </td>
                                                                    <td align="right" runat="server">
                                                                        <asp:TextBox CssClass="Txtboxsmall" ID="txtServiceCharge" Enabled="False" runat="server"
                                                                            Text="0.00" />
                                                                        <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server">
                                                                    <td colspan="2" runat="server">
                                                                    </td>
                                                                    <td runat="server">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td colspan="2" style="color: Black" runat="server">
                                                                        <div id="Due" style="display: none;" class="dataheaderInvCtrl">
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server">
                                                                    <td colspan="2" runat="server">
                                                                    </td>
                                                                    <td runat="server">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td align="left" runat="server">
                                                                        <asp:Label ID="Rs_RoundOffAmount" Text="Round Off Amount" runat="server" CssClass="labletext"
                                                                            meta:resourcekey="Rs_RoundOffAmountResource1" />
                                                                    </td>
                                                                    <td align="right" runat="server">
                                                                        <asp:TextBox CssClass="Txtboxsmall" ID="txtRoundOff" Enabled="False" runat="server"
                                                                            Text="0.00" TabIndex="9" />
                                                                        <asp:HiddenField ID="hdnRoundOff" runat="server" Value="0" />
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server">
                                                                    <td colspan="2" runat="server">
                                                                    </td>
                                                                    <td runat="server">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td align="left" runat="server">
                                                                        <asp:Label ID="lblGrandTotal" runat="server" Text="Net Value" class="defaultfontcolor"
                                                                            CssClass="labletext" meta:resourcekey="lblGrandTotalResource1" />
                                                                    </td>
                                                                    <td align="right" runat="server">
                                                                        <asp:TextBox CssClass="Txtboxsmall" ID="txtGrandTotal" Enabled="False" runat="server"
                                                                            Text="0.00" />
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server">
                                                                    <td colspan="2" runat="server">
                                                                    </td>
                                                                    <td runat="server">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td align="left" runat="server">
                                                                        <asp:Label ID="lblAmountRecieved" runat="server" Text="Amount Recieved" class="defaultfontcolor"
                                                                            CssClass="labletext" meta:resourcekey="lblAmountRecievedResource1" />
                                                                    </td>
                                                                    <td align="right" runat="server">
                                                                        <asp:TextBox CssClass ="Txtboxsmall" ID="txtAmountRecieved" runat="server" Text="0" ReadOnly="True"
                                                                            TabIndex="35" />
                                                                        <asp:HiddenField ID="hdnAmountReceived" runat="server" Value="0" />
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server" id="trNonReimburse">
                                                                    <td id="Td2" colspan="2" runat="server">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td id="Td3" runat="server">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td id="Td4" align="left" runat="server">
                                                                        <div id="Div1" style="display: block">
                                                                            <asp:Label ID="PaidAgainstNonMedicalItems" Text="Paid Against Non-MedicalItems" runat="server"
                                                                                CssClass="labletext" meta:resourcekey="PaidAgainstNonMedicalItemsResource1" />
                                                                        </div>
                                                                    </td>
                                                                    <td id="Td5" align="right" runat="server">
                                                                        <div id="Div2" style="display: block">
                                                                            <asp:TextBox ID="txtNonMedical" Enabled="False" runat="server" TabIndex="8" MaxLength="150"
                                                                                Text="0.00" CssClass ="Txtboxsmall" onblur="javascript:getPrecision(this);"  onkeypress="return ValidateOnlyNumeric(this);"  /></div>
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server" id="trCoPayment">
                                                                    <td id="Td6" colspan="2" runat="server">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td id="Td7" runat="server">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td id="Td8" align="left" runat="server">
                                                                        <div id="Div3" style="display: block">
                                                                            <asp:Label ID="Rs_CoPayment" Text="Co-Payment" runat="server" CssClass="labletext"
                                                                                meta:resourcekey="Rs_CoPaymentResource1" />
                                                                        </div>
                                                                    </td>
                                                                    <td id="Td9" align="right" runat="server">
                                                                        <div id="Div4" style="display: block">
                                                                            <asp:TextBox ID="txtCoPayment" runat="server" TabIndex="36" MaxLength="150" Text="0.00"
                                                                                CssClass="Txtboxsmall" onblur="javascript:getPrecision(this);customCoPayment();"
                                                                                onfocus="javascript:prepareCopayment();"  onkeypress="return ValidateOnlyNumeric(this);"  />
                                                                            <input type="hidden" value="0.00" id="hdnCoPayment" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server" id="trExcess">
                                                                    <td id="Td10" colspan="2" runat="server">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td id="Td11" runat="server">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td id="Td12" align="left" runat="server">
                                                                        <div id="Div5" style="display: none">
                                                                            <asp:Label ID="Rs_ExcessAmountReceived" Text="Excess Amount Received" runat="server"
                                                                                CssClass="labletext" meta:resourcekey="Rs_ExcessAmountReceivedResource1" />
                                                                        </div>
                                                                    </td>
                                                                    <td id="Td13" align="right" runat="server">
                                                                        <div id="Div6" style="display: none">
                                                                            <asp:TextBox ID="txtExcess" Enabled="False" runat="server" TabIndex="8" MaxLength="150"
                                                                                Text="0.00" CssClass="biltextb"  onkeypress="return ValidateOnlyNumeric(this);"  />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr id="divCollectAdvance" runat="server" style="display: none;">
                                        <td id="Td14" align="left" runat="server">
                                            <div style="margin-left: 17%;">
                                                <table width="80%" class="dataheaderInvCtrl">
                                                    <tr>
                                                        <td colspan="4" align="left">
                                                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                                <tr>
                                                                    <td align="left" class="colorforcontent" width="25%;" height="23" align="left">
                                                                        <div id="ACX2plusAdvPmt" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',1);"
                                                                            style="display: block; cursor: pointer width: 393px">
                                                                            &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top" />
                                                                            <span class="dataheader1txt" style="vertical-align: top;">&nbsp;<asp:Label ID="Rs_PreviousAdvancePayments"
                                                                                Text="Previous Advance Payments" runat="server" meta:resourcekey="Rs_PreviousAdvancePaymentsResource1" />
                                                                                <div style="text-align: right; font-weight: bold; vertical-align: top;">
                                                                                    <asp:Label ID="Rs_Total" Text="Total" runat="server" meta:resourcekey="Rs_TotalResource1" />
                                                                                    :&nbsp;<asp:Label ID="lblAdvancePaid1" runat="server" Text="0.00" meta:resourcekey="lblAdvancePaid1Resource1"></asp:Label></div>
                                                                            </span>
                                                                        </div>
                                                                        <div id="ACX2minusAdvPmt" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',0);"
                                                                            style="display: none; cursor: pointer">
                                                                            &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top" />
                                                                            <span class="dataheader1txt" style="vertical-align: top;">&nbsp;<asp:Label ID="Rs1_PreviousAdvancePayments"
                                                                                Text="Previous Advance Payments" runat="server" meta:resourcekey="Rs1_PreviousAdvancePaymentsResource1" />
                                                                                <div style="text-align: right; font-weight: bold; vertical-align: top;">
                                                                                    <asp:Label ID="Rs1_Total" Text="Total" runat="server" meta:resourcekey="Rs1_TotalResource1" />
                                                                                    :&nbsp;<asp:Label ID="lblAdvancePaid2" runat="server" Text="0.00" meta:resourcekey="lblAdvancePaid2Resource1"></asp:Label></div>
                                                                            </span>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr class="tablerow" id="ACX2responsesAdvPmt" style="display: none;">
                                                                    <td align="left">
                                                                        <div class="filterdatahe" id="divAdvancDetais" runat="server">
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Rs_TotalAmount" Text="Total Amount" runat="server" meta:resourcekey="Rs_TotalAmountResource1" />
                                                            :
                                                        </td>
                                                        <td>
                                                            <asp:TextBox CssClass="Txtboxsmall" ID="txtPayment" Width="70px" Style="text-align: right;"
                                                                runat="server" ReadOnly="True">0</asp:TextBox>
                                                            <asp:HiddenField ID="hdnNowPaid" runat="server" Value="0" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs1_ServiceCharge" Text="Service Charge" runat="server" meta:resourcekey="Rs1_ServiceChargeResource1" />
                                                            :
                                                        </td>
                                                        <td>
                                                            <asp:TextBox CssClass="Txtboxsmall" ID="txtAdvServiceCharge" Width="70px" Enabled="False"
                                                                runat="server" Text="0.00" Font-Bold="True" />
                                                            <asp:HiddenField ID="hdnAdvServiceCharge" runat="server" Value="0" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <uc21:OtherCurrencyDisplay IsDisplayPayedAmount="false" ID="OtherCurrencyDisplay2"
                                                                runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr style="display: none;" id="divSurgeryBill" runat="server">
                                        <td id="Td15" runat="server">
                                        </td>
                                    </tr>
                                    <tr style="text-align: center; display: none;" id="divSurgeryAdvance" runat="server">
                                        <td id="Td16" runat="server">
                                            <table class="dataheaderInvCtrl">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs1_TotalAmount" Text="Total Amount" runat="server" meta:resourcekey="Rs1_TotalAmountResource1" />
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:TextBox CssClass="Txtboxsmall" ID="txtSurAmount" Width="70px" Style="text-align: right;"
                                                            runat="server" ReadOnly="True" Text="0.00"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnSurPayment" runat="server" Value="0" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs2_ServiceCharge" Text="Service Charge" runat="server" meta:resourcekey="Rs2_ServiceChargeResource1" />
                                                        :
                                                    </td>
                                                    <td>
                                                        <asp:TextBox CssClass="Txtboxsmall" ID="txtsurService" Width="70px" Enabled="False"
                                                            runat="server" Text="0.00" Font-Bold="True" />
                                                        <asp:HiddenField ID="hdnSurService" runat="server" Value="0" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" colspan="4">
                                                        <uc21:OtherCurrencyDisplay ID="OtherCurrencyDisplay3" IsDisplayPayedAmount="false"
                                                            runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4">
                                                        <uc2:SurgeryBilling ID="SurgeryBilling1" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="divPaymentType" runat="server">
                                        <td id="Td17" align="center" runat="server">
                                            <uc13:paymentType ID="PaymentType" IsQuickBilling="Y" runat="server" />
                                        </td>
                                    </tr>
                                    <tr runat="server" id="trPrintOPCard" style="display: none;">
                                        <td id="Td18" runat="server">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblPrintOpCard" runat="server"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox ID="chkboxPrintOPCard" Text="Print OP Card" runat="server" class="defaultfontcolor"
                                                            TabIndex="45" meta:resourcekey="chkboxPrintOPCardResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr style="display: none;">
                                        <td align="center">
                                            <asp:Button ID="btnDueChart" runat="server" Text="Add to Dues" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClientClick="return CheckBilling();" OnClick="btnSave_Click"
                                                Visible="False" meta:resourcekey="btnDueChartResource1" />
                                            <asp:Button ID="btnSameRefresh" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" Height="0px" Width="0px" OnClick="btnSameRefresh_Click"
                                                meta:resourcekey="btnSameRefreshResource1" />
                                            <asp:HiddenField ID="hdnIPTempPID" runat="server" />
                                            <asp:HiddenField ID="hdnIPTempVID" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" nowrap="nowrap">
                                            <table width="20%" runat="server" id="tbOP" style="display: none;">
                                                <tr id="Tr1" runat="server">
                                                    <td id="tdtempSave" runat="server" style="display: none;">
                                                        <asp:Button ID="btnTempSave" runat="server" Text="Save" OnClick="btnTempSave_Click"
                                                            CssClass="btn" />
                                                    </td>
                                                    <td id="Td19" runat="server">
                                                        <asp:Button ID="btnSave" runat="server" Width="130px" Text="Generate Bill" CssClass="btn"
                                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="return CheckBill();"
                                                            OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                                        <asp:Button ID="btnGenerateVisit" runat="server" Width="130px" Text="Generate Visit"
                                                            CssClass="btn" Style="display: none" OnClientClick="return CheckGenerateVisit();" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'"  OnClick="btnGenerateVisit_Click" meta:resourcekey="btnGenerateVisitResource1" />
                                                    </td>
                                                    <td id="Td20" runat="server">
                                                        <asp:Button ID="btnClose" runat="server" Width="80px" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" Text="Close" OnClick="btnHome_Click" meta:resourcekey="btnCloseResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <table width="25%" id="tbIP" runat="server" style="display: none;">
                                                <tr id="Tr2" runat="server">
                                                    <td id="Td21" runat="server">
                                                        <asp:Button ID="btnIPAddToDueChart" runat="server" Text="Add to Due Chart" CssClass="btn"
                                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" Width="130px"
                                                            OnClientClick="javascript:shouldSubmit=true; return DiscountCheck()&& CreditLimitCheck();"
                                                            OnClick="btnIPAddToDueChart_Click" meta:resourcekey="btnIPAddToDueChartResource1" />
                                                    </td>
                                                    <td id="Td22" runat="server">
                                                        <asp:Button ID="btnMakePayment" runat="server" Width="130px" Text="Make Payment"
                                                            CssClass="btn" onmouseover="this.className='btn btnhov'" OnClick="btnIPbtnMakePayment_Click"
                                                            onmouseout="this.className='btn'" OnClientClick="return checkAmt();" meta:resourcekey="btnMakePaymentResource1" />
                                                    </td>
                                                    <td id="Td23" runat="server">
                                                        <asp:Button ID="btnIPClose" runat="server" Width="80px" Text="Close" CssClass="btn"
                                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnHome_Click"
                                                            meta:resourcekey="btnIPCloseResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <table width="25%" id="divServices" runat="server" style="display: none;">
                                                <tr runat="server">
                                                    <td runat="server">
                                                        <asp:Button ID="btnAddToSurgeryServices" runat="server" Text="Add To SurgeryServices"
                                                            CssClass="btn" onmouseover="this.className='btn btnhov'" OnClick="btnAddToSurgeryServices_Click"
                                                            onmouseout="this.className='btn'" Width="130px" meta:resourcekey="btnAddToSurgeryServicesResource1" />
                                                    </td>
                                                    <td runat="server">
                                                        <asp:Button ID="btnServClose" runat="server" Width="80px" Text="Close" CssClass="btn"
                                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnHome_Click"
                                                            meta:resourcekey="btnServCloseResource1" />
                                                    </td>
                                                </tr>
                                                  <tr>
                                                    <td>
                                                         <asp:label id="lblInsuranceName" runat="server" style="display:none;" meta:resourcekey="lblInsuranceNameResource1"></asp:label>
                                                         <div style="display:none" id="divGenerateVisit">
                                                            <asp:Xml ID="XmlOP" runat="server"></asp:Xml>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="tdOthers" runat="server" style="display: none;">
                                        <td id="Td24" align="center" runat="server">
                                            <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" runat="server" Text="Submit"
                                                CssClass="btn" OnClientClick="return CheckAdvanceDetals();" 
                                                onmouseout="this.className='btn'" TabIndex="46" meta:resourcekey="btnSubmitResource1" />&nbsp;&nbsp;
                                            <asp:Button ID="btnSubCancel" runat="server" CssClass="btn" 
                                                onmouseout="this.className='btn'" Text="Cancel" OnClick="btnSameRefresh_Click"
                                                TabIndex="47" meta:resourcekey="btnSubCancelResource1" />
                                        </td>
                                    </tr>
                                     <tr>

                                        <td>

                                            <uc120:ucMandatory ID="ucMandatory" runat="server" />
 
                                        </td>

                                    </tr>
                                    
                                     <tr>
                                        <td>
                                            <ajc:ModalPopupExtender ID="MPEFeeType" runat="server" TargetControlID="addNewPayment1"
                                                PopupControlID="Panel1" CancelControlID="btnpopCancel" BackgroundCssClass="modalBackground"
                                                Enabled="True" DropShadow="true" DynamicServicePath="" />
                                            <asp:Button runat="server" ID="addNewPayment1" Text="" Style="display: none;" />
                                            <asp:Button runat="server" ID="btnpopCancel" Text="" Style="display: none;" />
                                            <asp:Button runat="server" ID="btnReject" Text="" Style="display: none;" />
                                            <%-- <input type="button" id="Button1" runat="server" name="Click" value="Click" />--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup dataheaderPopup" Style="display: none;
                                                width: 600px; height: 300px;" meta:resourcekey="Panel1Resource1">
                                                <uc121:ucAmountApprovalDetails ID="ucAmountApprovalDetails1" runat="server" />
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    
                                </table>
                                <asp:HiddenField ID="hdnDiscountArray" runat="server" />
                                <asp:HiddenField ID="hdnDefaultRoundoff" Value="0" runat="server" />
                                <asp:HiddenField ID="hdnRoundOffType" runat="server" />
                                <input id="hdnSelectOnOption" type="hidden" runat="server" />
                                <div style="display: none;">
                                    <asp:CheckBox ID="chkisCreditTransaction" runat="server" class="defaultfontcolor"
                                        meta:resourceKey="chkisCreditTransactionResource1" Text="Credit Transaction" />
                                </div>
                                <asp:HiddenField ID="hdnFeeType1" runat="server" Value="Con" />
                                <asp:HiddenField ID="hdnFeeTypeSelected" runat="server" Value="OTH" />
                                <input id="hdnRecievedAmount" runat="server" type="hidden" />
                                <input id="hdnCurrentDue" runat="server" type="hidden" />
                                <input id="hdnGrandTotal" runat="server" type="hidden" />
                                <input id="hdnDeduction" runat="server" type="hidden" />
                                <input id="hdnCorporateDiscount" runat="server" type="hidden" />
                                <input id="hdnBookedSlots" runat="server" type="hidden" />
                                <input id="hdnOtherAmountReceived" runat="server" type="hidden" value="0" />
                                <input id="hdnOtherAmountPayble" runat="server" type="hidden" value="0" />
                                <input id="hdnNonReimburseAmt" runat="server" type="hidden" value="0.00" />
                                <input id="hdnDepositUsed" runat="server" type="hidden" value="0.00" />
                                <input id="hdnAdmissionDate" runat="server" type="hidden" value="01/01/1900" />
                                <input id="hdnVisitType" runat="server" type="hidden" value="OP" />
                                <asp:HiddenField ID="hdnFreeTextAllow" runat="server" Value="0" />
                                <asp:HiddenField ID="hdnFreeTextDescription" runat="server" />
                                <asp:HiddenField ID="hdnIsOrgNeedINVFreeText" runat="server" />
                                <asp:HiddenField ID="hdnRefPhy" runat="server" />
                                <asp:HiddenField ID="hdnOrgCreditLimt" runat="server" Value="N" />
                                <asp:HiddenField ID="hdnRatesfreetext" runat="server" Value="Y" />
                                <asp:HiddenField ID="hdnBillingLogic" runat="server" />
                                <div id="printANCCS" runat="server" align="center" style="display: none;">
                                    <uc7:ucSecPage ID="ucSPage" runat="server" />
                                </div>
                                <input id="hdnResetAll" runat="server" type="hidden" value="N" />
                                <input id="hdndiscountreason" runat="server" type="hidden" />
                                <input id="hdnDisplayvalue" runat="server" type="hidden" />
                                
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>

    <script type="text/javascript">


        function ShowAlertMsg(key) {

            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
            }
            else if (key == "Billing\GenerateBill.aspx_31") {
            alert('There was a problem in Save Billing Details.');
            }

            else if (key == "Billing\GenerateBill.aspx_32") {
            alert('Patient already registered with the given details');
            }
            
            return true;
        }

    
    
        function ADDAmbulanceDetails() {

            if (document.getElementById('tdAmbulance').style.display != 'none') {
                var AMBID = document.getElementById('ucAmb_hdnAMBID').value;
                var DRIVERID = document.getElementById('ucAmb_hdnDriverID').value;
                var LocationID = document.getElementById('ucAmb_hdnLocationID').value;
                var distancekgm = document.getElementById('ucAmb_txtDistanceKgm').value;
                var ArrFromDate = document.getElementById('ucAmb_txtArrivalFromDate').value;
                var ArrToDate = document.getElementById('ucAmb_txtArrivalToDate').value;

                var Duration = document.getElementById('ucAmb_txtDuration').value;
                document.getElementById('<%= hdnAmbulanceDetails.ClientID %>').value = document.getElementById('<%= hdnAmbulanceDetails.ClientID %>').value +
                                           AMBID + "$" + DRIVERID + "$" + LocationID + "$" + distancekgm + "$" + ArrFromDate + "$" + ArrToDate + '$' + Duration + '$' +
                                          document.getElementById('dspData_hdnAmbCode').value + '^';


                document.getElementById('dspData_hdnAmbCode').value = '';
                document.getElementById('ucAmb_txtDriverName').value = '';
                document.getElementById('ucAmb_txtAmbulanceNo').value = '';
                document.getElementById('ucAmb_txtLocation').value = '';
                document.getElementById('ucAmb_hdnDriverID').value = '0';
                document.getElementById('ucAmb_hdnAMBID').value = '0';
                document.getElementById('ucAmb_hdnLocationID').value = '0';
                document.getElementById('ucAmb_txtDistanceKgm').value = '';
                document.getElementById('ucAmb_txtDuration').value = '';
                document.getElementById('tdAmbulance').style.display = 'none';



            }
            return true;

        }





        var userMsg;
        function collapseDropDownList(elementRef) {
            elementRef.style.width = elementRef.normalWidth;
        }
        function expandDropDownList(elementRef) {
            elementRef.style.width = '450px';
        }

        function resetpreviousradiodetails() {
            document.getElementById('<%= txtQty.ClientID %>').value = 1;
            document.getElementById('<%= txtName.ClientID %>').value = "";
            document.getElementById('<%= txtAmount.ClientID %>').value = "0";
            ToTargetFormat($("#txtAmount"));
            document.getElementById('<%= hdnPhyLID.ClientID %>').value = "";
            document.getElementById('<%= hdnSID.ClientID %>').value = "";
            document.getElementById('hdnID').value = "-1";
            document.getElementById('<%= txtperphy.ClientID %>').value = "";
            document.getElementById('txtAmount').readOnly = false;
            document.getElementById('txtAmount').disabled = false;

        }
        function chkPros() {
            var radio = document.getElementsByName('<%= rblFeeTypes.ClientID %>');
            for (var ii = 0; ii < radio.length; ii++) {
                if (radio[ii].checked) {
                    document.getElementById('<%= hdnFeeType1.ClientID %>').value = (radio[ii].value);
                    if (document.getElementById('hdnID').value == "-1") {
                        document.getElementById('hdnFeeTypeSelected').value = radio[ii].value; //  == "LAB" ? "INV" : radio[ii].value;
                    }
                }

            }
            changelabel();
            var orgID = '<%= OrgID %>';
            var sval = document.getElementById('<%= hdnFeeType1.ClientID %>').value;
            var pvalue = document.getElementById('<%= hdnOPIP.ClientID %>').value;
            var sClientID = getClientID(pvalue);
             
            var sRateID = getRateID();
            var lcID = document.getElementById('<%= hdnLocationID.ClientID %>').value;
            var pVisitID = document.getElementById('QPR_hdnVisitID').value;
            var IsMapped;
            var BillPage;
            BillPage = "HOS";
            if (document.getElementById('ChkMapped').checked == true) {
                IsMapped = 'Y';
            }
            else {
                IsMapped = 'N';
            }
            if (pvalue == "OP" || pvalue == "IP" || pvalue == "DayCare") {
                sval = sval + '~' + sClientID + '~' + IsMapped + '~' + sRateID + '~' + pvalue + '~' + pVisitID + '~' + orgID + '~' + lcID;
                $find('AutoCompleteExtender3').set_contextKey(sval);
                

            }
        }
        function DivCollapse() {

            var obj = document.getElementById('<%= hdnOPIP.ClientID %>').value;

            if (obj == "") {
                //alert("Select Any One Visit Type");
                userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_1');
                if (userMsg == null) {
                    alert('Select Any one Visit type');
                    return false;
                }
                else {
                    alert(userMsg);
                    return false;
                }
                document.getElementById('QPR_rdoOP').focus();
                return false;
            }
            showResponses('divRef1', 'divRef2', 'divRef3', 0);
            showResponses('divMore1', 'divMore2', 'divMore3', 0);
            if (isCollapse()) {
                PatientDivCollapse(0);
            }
            if (obj == "DayCare") {
                if ((document.getElementById('QPR_rdoNewVisit').checked == false) && (document.getElementById('QPR_rdoExisingvisit').checked == false)) {
                    // alert('Please select Newsittings or Exisitingsitings ');
                    userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_2');
                    if (userMsg == null) {
                        alert('Please select New sittings or Existing sittings');
                        return false;
                    }
                    else {
                        alert(userMsg);
                        return false;
                    }
                    document.getElementById('QPR_rdoNewVisit').focus();
                    return false;
                }
            }

        }
          
    </script>

    <script type="text/javascript">

        function CheckBill() {

            if (document.getElementById('QPR_txtPatientName').value == '') {
                // alert('Please Enter Patient Name');
                userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_3');
                if (userMsg == null) {
                    alert('Please Enter Patient Name');
                    return false;
                }
                else {
                    alert(userMsg);
                    return false;
                }
                document.getElementById('QPR_txtPatientName').focus();
                return false;
            }
            if ((document.getElementById('QPR_tDOB').value == '') && (document.getElementById('QPR_txtDOBNos').value == '')) {
                // alert('Please Enter Date of birth OR Age');
                userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_4');
                if (userMsg == null) {
                    alert('Please Enter Date of birth OR Age');
                    return false;
                }
                else {
                    alert(userMsg);
                    return false;
                }
                document.getElementById('QPR_txtDOBNos').focus();
                return false;
            }

            if (document.getElementById('QPR_txtAddress').value == '') {
                // alert('Please Enter Address');
                userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_5');
                if (userMsg == null) {
                    alert('Please Enter Address');
                    return false;
                }
                else {
                    alert(userMsg);
                    return false;
                }
                document.getElementById('QPR_txtAddress').focus();
                return false;
            }
            if (document.getElementById('QPR_txtCity').value == '') {
                // alert('Please Enter City');
                userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_6');
                if (userMsg == null) {
                    alert('Please Enter City');
                    return false;
                }
                else {
                    alert(userMsg);
                    return false;
                }
                document.getElementById('QPR_txtCity').focus();
                return false;
            }
            if ((document.getElementById('QPR_txtPhone').value == '') && (document.getElementById('QPR_txtMobile').value == '')) {
                // alert('Please Enter Mobile or Phone Number');
                userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_7');
                if (userMsg == null) {
                    alert('Please Enter Mobile or Phone Number');
                    return false;
                }
                else {
                    alert(userMsg);
                    return false;
                }
                document.getElementById('QPR_txtPhone').focus();
                return false;
            }
            if ((document.getElementById('hdnRefPhy').value == 'Y')) {
                if (((document.getElementById('ReferDoctor1_txtNew').value == 'Type Physician Name') || (document.getElementById('ReferDoctor1_txtNew').value.trim() == 'No Physician Found') || (document.getElementById('ReferDoctor1_txtNew').value.trim() == '')) && ((document.getElementById('ReferDoctor2_txtNew').value == 'Type Physician Name') || (document.getElementById('ReferDoctor2_txtNew').value.trim() == 'No Physician Found') || (document.getElementById('ReferDoctor2_txtNew').value.trim() == ''))) {
                    // alert('Please Enter the Refering Physician');
                    userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_8');
                    if (userMsg == null) {
                        alert('Please Enter the Refering Physician');
                        return false;
                    }
                    else {
                        alert(userMsg);
                        return false;
                    }
                    return false;
                }
            }

            

            return CheckBilling();
        }
        function showorHidechkBox() {
            //dont delete this function
        }
        function getCashInHand() {
            var TotalCashandCreditLimitinHand = 0;
            if (document.getElementById('hdnOrgCreditLimt').value == "Y" && document.getElementById('ucCreditLimit_hdnIsCreditBill').value == 'N') {

                if (Number(ToInternalFormat($('ucCreditLimit_hdnCreditLimt'))) > 0) {

                    if (((Number(ToInternalFormat($('#ucCreditLimit_hdnCreditLimt'))) + Number(ToInternalFormat($('#ucCreditLimit_hdnTotalReceived')))) - Number(ToInternalFormat($('#ucCreditLimit_hdnTotalBilled')))) > 0) {
                        TotalCashandCreditLimitinHand = (Number(ToInternalFormat($('#ucCreditLimit_hdnCreditLimt'))) + Number(ToInternalFormat($('#ucCreditLimit_hdnTotalReceived')))) - Number(ToInternalFormat($('#ucCreditLimit_hdnTotalBilled')));
                    }
                
                    
                    else {
                        TotalCashandCreditLimitinHand = 0;
                    }

                }
                else {
                    if (((Number(ToInternalFormat($('#ucCreditLimit_hdnTotalReceived')))) - Number(ToInternalFormat($('#ucCreditLimit_hdnTotalBilled')))) > 0) {
                        TotalCashandCreditLimitinHand = Number(ToInternalFormat($('#ucCreditLimit_hdnTotalReceived'))) - Number(ToInternalFormat($('#ucCreditLimit_hdnTotalBilled')));
                    }     
                    else {
                        TotalCashandCreditLimitinHand = 0;
                    }
                }


            }
            else if (document.getElementById('hdnOrgCreditLimt').value == "Y" && document.getElementById('ucCreditLimit_hdnIsCreditBill').value == 'Y') {

            if (Number(ToInternalFormat($('ucCreditLimit_hdnCreditLimt'))) > 0) {
                TotalCashandCreditLimitinHand = (Number(ToInternalFormat($('#ucCreditLimit_hdnCreditLimt'))) + Number(ToInternalFormat($('#ucCreditLimit_hdnTotalReceived'))) + Number(ToInternalFormat($('#ucCreditLimit_hdnPreAuthAmount')))) - Number(ToInternalFormat($('#ucCreditLimit_hdnTotalBilled')));
            }


            else {
                TotalCashandCreditLimitinHand = (Number(ToInternalFormat($('#ucCreditLimit_hdnTotalReceived'))) + Number(ToInternalFormat($('#ucCreditLimit_hdnPreAuthAmount')))) - Number(ToInternalFormat($('#ucCreditLimit_hdnTotalBilled')));
                }

            }
            return TotalCashandCreditLimitinHand.toFixed(2);

        }
        function checkAmt() {
        
            var TotalAmount = ToInternalFormat($('#PaymentType_txtTotalAmount'));
            var AmtRecieved = ToInternalFormat($('#txtAmountRecieved'));
            var TotalCashandCreditLimitinHand = -1;
            TotalCashandCreditLimitinHand = getCashInHand();
            if (Number(TotalAmount <= 0)) {
                if (Number(AmtRecieved <= 0)) {
                    // alert("Please Enter The Amount");
                    userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_9');
                    if (userMsg == null) {
                        alert('Please Enter The Amount');
                        return false;
                    }
                    else {
                        alert(userMsg);
                        return false;
                    }
                    return false;
                }
                else {
                    if (document.getElementById('hdnOrgCreditLimt').value == "Y") {
                        var GrandTotal = ToInternalFormat($('#txtGrandTotal'));

                        TotalCashandCreditLimitinHand = Number(TotalCashandCreditLimitinHand) + Number(AmtRecieved);
                        if (Number(TotalCashandCreditLimitinHand) < Number(GrandTotal)) {
                            var mustCollectAmt = parseFloat(Number(GrandTotal) - Number(TotalCashandCreditLimitinHand)).toFixed(2);
                            // alert('You should Collect Rs. ' + mustCollectAmt);
                            userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_10');
                            document.getElementById('hdnDisplayvalue').value = mustCollectAmt;
                            ToTargetFormat($('#hdnDisplayvalue'))

                            if (userMsg == null) {
                                alert('You should Collect Rs. ' + document.getElementById('hdnDisplayvalue').value);
                                return false;
                            }
                            else {
                                alert(userMsg + document.getElementById('hdnDisplayvalue').value);
                                return false;
                            }
                            return false;
                        }
                        else {
                            return CheckBilling();
                        }
                    }
                    else {
                        return CheckBilling();
                    }
                }
            }
            else {
                if (document.getElementById('hdnOrgCreditLimt').value == "Y") {
                    var GrandTotal = ToInternalFormat($('#txtGrandTotal'));

                    TotalCashandCreditLimitinHand = Number(TotalCashandCreditLimitinHand) + Number(TotalAmount);
                    if (Number(TotalCashandCreditLimitinHand) < Number(GrandTotal)) {
                        var mustCollectAmt = parseFloat(Number(GrandTotal) - Number(TotalCashandCreditLimitinHand)).toFixed(2);
                        // alert('You should Collect Rs. ' + mustCollectAmt);
                        userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_10');
                        document.getElementById('hdnDisplayvalue').value = mustCollectAmt;
                        ToTargetFormat($('#hdnDisplayvalue'));


                        if (userMsg == null) {
                            alert('You should Collect Rs. ' + document.getElementById('hdnDisplayvalue').value);
                            return false;
                        }
                        else {
                            alert(userMsg + document.getElementById('hdnDisplayvalue').value);
                            return false;
                        }
                        return false;
                    }
                    else {
                        return CheckBilling();
                    }
                }
                else {
                    return CheckBilling();
                }
            }
        }
        function CreditLimitCheck() {
            var TotalCashandCreditLimitinHand = 0;
            if (document.getElementById('ucCreditLimit_hdnIsCreditBill').value == 'Y' && document.getElementById('ucCreditLimit_hdnIsPatientPortTrust').value == 'Y') {
                return CheckBilling();
            }
            else if (document.getElementById('hdnOrgCreditLimt').value == "Y" && document.getElementById('ucCreditLimit_hdnIsCreditBill').value == 'N') {
            if (Number(ToInternalFormat($('#ucCreditLimit_hdnCreditLimt'))) > 0) {

                    if (((Number(ToInternalFormat($('#ucCreditLimit_hdnCreditLimt'))) + Number(ToInternalFormat($('#ucCreditLimit_hdnTotalReceived')))) - Number(ToInternalFormat($('#ucCreditLimit_hdnTotalBilled')))) > 0) {
                        TotalCashandCreditLimitinHand = (Number(ToInternalFormat($('#ucCreditLimit_hdnCreditLimt'))) + Number(ToInternalFormat($('#ucCreditLimit_hdnTotalReceived')))) - Number(ToInternalFormat($('#ucCreditLimit_hdnTotalBilled')));
                    }
                    else {
                        TotalCashandCreditLimitinHand = 0;
                    }

                }
                else {
                    if ((Number(ToInternalFormat($('#ucCreditLimit_hdnTotalReceived'))) - Number(ToInternalFormat($('#ucCreditLimit_hdnTotalBilled')))) > 0) {
                        TotalCashandCreditLimitinHand = Number(ToInternalFormat($('#ucCreditLimit_hdnTotalReceived'))) - Number(ToInternalFormat($('#ucCreditLimit_hdnTotalBilled')));
                    }     
                   
                    else {
                        TotalCashandCreditLimitinHand = 0;
                    }
                }

                var GrandTotal = ToInternalFormat($('#txtGrandTotal')); 
                if (Number(GrandTotal) > Number(TotalCashandCreditLimitinHand)) {
                    // alert('Collect Advance or Make Payment');
                    userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_11');
                    if (userMsg == null) {
                        alert('Collect Advance or Make Payment');
                        return false;
                    }
                    else {
                        alert(userMsg);
                        return false;
                    }
                    return false;
                }
                else {
                    return CheckBilling();
                }
            }
            else if (document.getElementById('hdnOrgCreditLimt').value == "Y" && document.getElementById('ucCreditLimit_hdnIsCreditBill').value == 'Y') {
            if (Number(ToInternalFormat($('#ucCreditLimit_hdnCreditLimt'))) > 0) {
                TotalCashandCreditLimitinHand = (Number(ToInternalFormat($('#ucCreditLimit_hdnCreditLimt'))) + Number(ToInternalFormat($('#ucCreditLimit_hdnTotalReceived'))) + Number(ToInternalFormat($('#ucCreditLimit_hdnPreAuthAmount')))) - Number(ToInternalFormat($('#ucCreditLimit_hdnTotalBilled')));
                    
                }
                else {
                    TotalCashandCreditLimitinHand = (Number(ToInternalFormat($('#ucCreditLimit_hdnTotalReceived'))) + Number(ToInternalFormat($('#ucCreditLimit_hdnPreAuthAmount')))) - Number(ToInternalFormat($('#ucCreditLimit_hdnTotalBilled')));
                }
                var GrandTotal = ToInternalFormat($('#txtGrandTotal'));
                if (Number(GrandTotal) > Number(TotalCashandCreditLimitinHand)) {
                    // alert('Collect Advance or Make Payment');
                    userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_11');
                    if (userMsg == null) {
                        alert('Collect Advance or Make Payment');
                        return false;
                    }
                    else {
                        alert(userMsg);
                        return false;
                    }
                    return false;
                }
                else {
                    return CheckBilling();
                }
            }
            else {
                return CheckBilling();
            }
        }
        function CheckGenerateVisit() {

            if (document.getElementById('QPR_dPurpose').value != 5) {
                var returndatavalue = checkPatientnVisit();
            }
            else {
                var returndatavalue = true;
            }
            if (returndatavalue == true) {
                returndatavalue = CheckBillingItems();
            }

            return returndatavalue;

        }

        function CheckBilling() {

            if (document.getElementById('QPR_dPurpose').value != 5) {

                var returndatavalue = checkPatientnVisit();
            }
            else {
                var returndatavalue = true;
            }
            if (returndatavalue == true) {
                returndatavalue = CheckBillingItems();
            }



            if (returndatavalue == true) {

                returndatavalue = SaveValidation();
            }
            if (returndatavalue == true) {
                doCalcReimburse();


                var AmtRecieved = ToInternalFormat($('#txtAmountRecieved'));
                var AmtNet = ToInternalFormat($('#txtGrandTotal'));
                var TotalCashandCreditLimitinHand = 0;
                TotalCashandCreditLimitinHand = getCashInHand()

                if (Number(AmtNet) > (Number(AmtRecieved) + Number(TotalCashandCreditLimitinHand))) {
                    var pBill;
                    // var pBill = confirm("This BillAmount will be added to due.\n Do you want to continue");
                    userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_29');
                    if (userMsg == null)
                        pBill = confirm("This Bill Amount will be added to due.\n Do you want to continue");
                    else
                        pBill = confirm(userMsg);
                    if (pBill != true) {
                        document.getElementById('btnSave').style.display = 'block';
                        return false;
                    }
                }
                document.getElementById('<%= btnSave.ClientID %>').disabled = false;
                return true;
            }
            else {
                return false;
            }
            return returndatavalue;
        }
        function DiscountCheck() {
            if (Number(ToInternalFormat($('#txtDiscount'))) > 0 && document.getElementById('hdnVisitType').value == 'IP') {
                // alert('Discount is not allowed if the bill is added to due. Please use "Final settlement" page to provide discount. You can provide discount only for "Make payment" option.');
                userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_12');
                if (userMsg == null) {
                    alert('Discount is not allowed if the bill is added to due. Please use "Final settlement" page to provide discount. You can provide discount only for "Make payment" option');
                    return false;
                }
                else {
                    alert(userMsg);
                    return false;
                }
                return false;
            }
            else {
                return true;
            }

        }

    </script>

    <script type="text/javascript">


        function chkTaxPayment(idval, dPercent) {

            var sVal = Number(ToInternalFormat($('#txtTax')));
            var sGrand = format_number(Number(ToInternalFormat($('#txtGross'))) -
                                                    (Number(ToInternalFormat($('#txtDiscount')))), 2);
 
            var sControl = document.getElementById(idval);
            var arrayAlready = new Array();
            var iCount = 0;
            var tSelectedData = "";

            if (sControl.checked == true) {
                sVal = sVal + (Number(sGrand) * Number(dPercent) / 100);

                document.getElementById('hdfTax').value += ">" + idval + "~" + dPercent;
                document.getElementById('txtTax').value = format_number(sVal, 2);
                document.getElementById('hdnTaxAmount').value = format_number(document.getElementById('txtTax').value, 2);
                ToTargetFormat($('#txtTax'))
                ToTargetFormat($('#hdnTaxAmount'))

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
            ToTargetFormat($('#txtTax'))
            ToTargetFormat($('#hdnTaxAmount'))

            totalCalculate();
            SetOtherCurrValues();
        }

        
    </script>

    <script type="text/javascript">

        function clearDiscounts() {
            var DiscountCntrls = new Array();
            var tempCtrl = document.getElementById('<%= hdnDiscountArray.ClientID %>').value;
            document.getElementById('txtDiscount').value = 0;
            document.getElementById('txtDiscountPercent').value = 0;
            document.getElementById('ddDiscountPercent').value = 0;
            document.getElementById('trDiscountReason').style.display = "none";
            document.getElementById('txtDiscountReason').value = "";
            DiscountCntrls = tempCtrl.split('|');
            var iCnt = 0;
            var DiscountAmount = 0;

            for (iCnt = 0; iCnt < DiscountCntrls.length; iCnt++) {
                if (DiscountCntrls[iCnt] != '') {
                    document.getElementById(DiscountCntrls[iCnt]).value = 0;
                }
            }
            ToTargetFormat($('#txtDiscount'));
            ToTargetFormat($('#txtDiscountPercent'));
        }
        function clearServiceCharge() {
            document.getElementById('<%= hdnServiceCharge.ClientID %>').value = 0;
            document.getElementById('<%= txtServiceCharge.ClientID %>').value = 0;
            ToTargetFormat($('#hdnServiceCharge'));
            ToTargetFormat($('#txtServiceCharge'));
        }
        function clearDue() {
            document.getElementById('<%= txtDue.ClientID %>').value = 0;
            document.getElementById('<%= hdnDue.ClientID %>').value = 0;
            document.getElementById('<%= hdnDPDetails.ClientID %>').value = 0;
            ToTargetFormat($('#txtDue'));
            ToTargetFormat($('#hdnDue'));
             
        }
        function cleartaxamount() {
            document.getElementById('<%= hdnTaxAmount.ClientID %>').value = 0;
            document.getElementById('<%= txtTax.ClientID %>').value = 0;
            ToTargetFormat($('#hdnTaxAmount'));
            ToTargetFormat($('#txtTax'));
        }
        function CLEARAMOUNTRECEIVED() {
            document.getElementById('<%= txtAmountRecieved.ClientID %>').value = 0;
            document.getElementById('<%= hdnAmountReceived.ClientID %>').value = 0;
            document.getElementById('txtGrandTotal').value = 0;
            document.getElementById('hdnNetValue').value = 0;
            document.getElementById("txtExcess").value = 0;
            ToTargetFormat($('#txtAmountRecieved'));
            ToTargetFormat($('#hdnAmountReceived'));
            ToTargetFormat($('#txtGrandTotal'));
            ToTargetFormat($('#hdnNetValue'));
            ToTargetFormat($('#txtExcess'));
            
            
        }
       
        
    </script>

    <script language="javascript" type="text/javascript">




        calculateDiscountForCorporate();
        function calculateDiscountForCorporate() {
            var x, j, i, k, l;

            x = document.getElementById('hdnCorporateDiscount').value.split("^");

            i = x.length;
            for (j = 0; j < i; j++) {
                if (x[j] != "") {
                    k = x[j].split("~");

                    if (k[1] == "Percentage") {
                        document.getElementById('txtDiscount').value = parseFloat(parseFloat(parseFloat(ToInternalFormat($('#txtGross'))) / 100) * parseFloat(k[0])).toFixed(2);
                        document.getElementById('lblDiscount').innerText = " Discount %";
                    }
                    else {

                        if ((l == 0) && (document.getElementById('txtDiscount').value != "" ||ToInternalFormat($('#txtDiscount')) != "0.00")) {
                            l++;
                            document.getElementById('txtDiscount').value = parseFloat(k[0]).toFixed(2);
                            document.getElementById('trDiscountReason').style.display = "block";
                            ToTargetFormat($('#txtDiscount'));
                        }
                        document.getElementById('lblDiscount').innerText = " Discount";
                    }

                }
            }
        }
    </script>

    <script language="javascript" type="text/javascript">

        function IAmSelected(source, eventArgs) {
            var Result = eventArgs.get_value().split('^');
            document.getElementById('<%= hdnID.ClientID %>').value = Result[0];
            document.getElementById('<%= hdnFeeTypeSelected.ClientID%>').value = Result[2];

            if (Result[2] == 'GEN') {
                if (Result[4] == 'Y' && (Result[3] == 'AMB-IN' || Result[3] == 'AMB-OUT')) {
                    document.getElementById('dspData_hdnAmbCode').value = Result[3];
                    document.getElementById('tdAmbulance').style.display = 'block';
                }

                else {
                    document.getElementById('tdAmbulance').style.display = 'none';
                }

            }
            else {
                document.getElementById('tdAmbulance').style.display = 'none';
            }

            AddBillingItemsDetails();
        }
        function AddBillingItemsDetails() {

            var visitType = '';
            var pVisitID = 0;
            var orgID = '<%= OrgID %>';
            if (document.getElementById('QPR_rdoOP').checked == true) {
                visitType = 'OP';
            }
            else if (document.getElementById('QPR_rdoIP').checked == true) {
                visitType = 'IP';
                pVisitID = document.getElementById('QPR_hdnVisitID').value;
            }
            var rateID = getRateID();
            var sClientID = 0;

            sClientID = getClientID(visitType);

            if (sClientID > 0) {
                OPIPBilling.GetHospitalBillingItemsDetails(orgID, document.getElementById('hdnID').value, document.getElementById('hdnFeeTypeSelected').value, document.getElementById('txtName').value, sClientID, pVisitID, '', rateID, visitType, pSetValues);
            }
        }
        function pSetValues(tmpVal) {
            var list = new Array();
            for (var i = 0; i < tmpVal.length; i++) {

                list = tmpVal[i].ProcedureName.split('^');
                if (list.length > 0) {
                    pphyFeeId = list[0];
                    pname = list[1];
                    pfeeType = list[2];
                    pamount = list[7];
                    pphysicianLID = list[4];
                    pspecialityID = list[5];
                    pisReimursable = list[6];
                    pDisorEnhpercent = list[8];
                    pDisorEnhType = list[9];
                    pRemarks = list[10];
                    pReimbursableAmount = list[11];
                    pNonReimbursableAmount = list[12];
                   
                    document.getElementById('txtAmount').value = pamount;
                    ToTargetFormat($("#txtAmount"));
                    document.getElementById('hdnFeeTypeSelected').value = pfeeType;
                    document.getElementById('hdnName').value = pname;
                    document.getElementById('hdnAmt').value = pamount;
                    document.getElementById('hdnFreeTextAllow').value = "1";
                    document.getElementById('hdnFreeTextDescription').value = pname;
                    ToTargetFormat($("#hdnAmt"));
                    document.getElementById('hdnID').value = pphyFeeId;
                    document.getElementById('hdnPhyLID').value = pphysicianLID;
                    document.getElementById('hdnSID').value = pspecialityID;
                    document.getElementById('hdnDisorEnhpercent').value = pDisorEnhpercent;
                    ToTargetFormat($("#hdnDisorEnhpercent"));
                    document.getElementById('hdnDisorEnhType').value = pDisorEnhType;
                    document.getElementById('hdnRemarks').value = pRemarks;
                    document.getElementById('hdnReimbursableAmount').value = pReimbursableAmount;
                    ToTargetFormat($("#hdnReimbursableAmount"));
                    document.getElementById('hdnNonReimbursableAmount').value = pNonReimbursableAmount;
                    ToTargetFormat($("#hdnNonReimbursableAmount"));

                    if (pisReimursable == 'Y') {
                        document.getElementById('chkIsRI').checked = true;
                    }
                    else {
                        document.getElementById('chkIsRI').checked = false;
                    }
                }
            }
        }

        function IAmSelected_old(source, eventArgs) {
            //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            var phyFeeId;
            var name;
            var feeType;
            var amount;
            var physicianLID;
            var specialityID;
            var isReimursable;
            var DisorEnhpercent;
            var DisorEnhType;
            var Remarks;
            var ReimbursableAmount;
            var NonReimbursableAmount;
            //            eventArgs.get_value()[0].PatientID;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        phyFeeId = list[0];
                        name = list[1];
                        feeType = list[2];
                        amount = list[7];
                        physicianLID = list[4];
                        specialityID = list[5];
                        isReimursable = list[6];
                        DisorEnhpercent = list[8];
                        DisorEnhType = list[9];
                        Remarks = list[10];
                        ReimbursableAmount = list[11];
                        NonReimbursableAmount = list[12];
                        document.getElementById('txtAmount').value = amount;
                        ToTargetFormat($("#txtAmount"));
                        document.getElementById('hdnFeeTypeSelected').value = feeType;
                        document.getElementById('hdnName').value = name;
                        document.getElementById('hdnAmt').value = amount;
                        ToTargetFormat($("#hdnAmt"));
                        document.getElementById('hdnID').value = phyFeeId;
                        document.getElementById('hdnPhyLID').value = physicianLID;
                        document.getElementById('hdnSID').value = specialityID;
                        document.getElementById('hdnDisorEnhpercent').value = DisorEnhpercent;
                        ToTargetFormat($("#hdnDisorEnhpercent"));
                        document.getElementById('hdnDisorEnhType').value = DisorEnhType;
                        document.getElementById('hdnRemarks').value = Remarks;
                        document.getElementById('hdnReimbursableAmount').value = ReimbursableAmount;
                        ToTargetFormat($("#hdnReimbursableAmount"));
                        document.getElementById('hdnNonReimbursableAmount').value = NonReimbursableAmount;
                        ToTargetFormat($("#hdnNonReimbursableAmount"));
                        if (isReimursable == 'Y') {
                            document.getElementById('chkIsRI').checked = true;
                        }
                        else {
                            document.getElementById('chkIsRI').checked = false;
                        }
                    }
                }
                if (document.getElementById('hdnRatesfreetext').value == 'N') {
                    if (amount > 0) {
                        document.getElementById('txtAmount').readOnly = true;
                        document.getElementById('txtAmount').disabled = true;

                    }
                }

            }

            else {
                document.getElementById('hdnFeeID').value = -1;
                document.getElementById('hdnFeeTypeSelected').value = "OTH";
            }
            document.getElementById('hdnFreeTextAllow').value = "1";
            document.getElementById('hdnFreeTextDescription').value = name;
            if (event.keyCode == 13)
                document.getElementById('<%= txtQty.ClientID %>').focus();
            pageLoad();
            var Perphysicianname = document.getElementById('txtperphy').value;
            $find('AutoCompleteExtender3')._onMethodComplete = function(result, context) {

                $find('AutoCompleteExtender3')._update(context, result, /* cacheResults */false);

                webservice_callback(result, context);



            };
            $find('AutoCompleteExtender4')._onMethodComplete = function(result, context) {
                var Perphysicianname = document.getElementById('txtperphy').value;
                $find('AutoCompleteExtender4')._update(context, result, /* cacheResults */false);
                if (result == "") {
                    // alert('You Should be Select From the list');
                    userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_13');
                    if (userMsg == null) {
                        alert('You Should be Select From the list');
                        return false;
                    }
                    else {
                        alert(userMsg);
                        return false;
                    }
                }
            };


        }

        function freetxtCheck() {

            if (NeedINVFreeText == "N") {
                if (document.getElementById('hdnFeeTypeSelected').value == "INV" || document.getElementById('hdnFeeTypeSelected').value == "GRP") {
                    if (document.getElementById('hdnFreeTextAllow').value != "1" || document.getElementById('hdnFreeTextDescription').value.toLowerCase().trim() != document.getElementById('<%= txtName.ClientID %>').value.toLowerCase().trim()) {
                        document.getElementById('hdnFreeTextAllow').value = "0";
                        document.getElementById('<%= txtName.ClientID %>').value = ""
                        document.getElementById('<%= txtAmount.ClientID %>').value = ""

                        // alert('Free text not allowed for investigations');
                        userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_14');
                        if (userMsg == null) {
                                                
                            alert('Free text not allowed for investigations');
                            return false;
                        }
                        else {
                            alert(userMsg);
                            return false;
                        }
                        document.getElementById('<%= txtName.ClientID %>').focus();
                        return false;
                    }

                }

            }

            var pAmt = ToInternalFormat($('#txtAmount'));

            if (Number(pAmt) <= 0) {

                var userMsg = SListForApplicationMessages.Get("Billing\\GenerateBill.aspx_40");
                if (userMsg != null)
                 {
                    alert(userMsg);
                    return false;
                }
                else {
                alert('Amount should be greater than zero');
                return false;
                }
                document.getElementById('<%= txtAmount.ClientID %>').focus();
                return false;
            }
            if ((document.getElementById('hdnRefPhy').value == 'Y')) {
                if ((
                            (document.getElementById('ReferDoctor1_txtNew').value.trim() == "Type Physician Name") ||
                            (document.getElementById('ReferDoctor1_txtNew').value.trim() == 'None') ||
                            (document.getElementById('ReferDoctor1_txtNew').value.trim() == 'No Physician Found') ||
                            (document.getElementById('ReferDoctor1_txtNew').value.trim() == '')
                        )
                        &&
                        (
                            (document.getElementById('ReferDoctor2_txtNew').value.trim() == 'Type Physician Name') ||
                            (document.getElementById('ReferDoctor2_txtNew').value.trim() == 'None') ||
                            (document.getElementById('ReferDoctor2_txtNew').value.trim() == 'No Physician Found') ||
                            (document.getElementById('ReferDoctor2_txtNew').value.trim() == '')
                        )) {
                    // alert('Please Enter the Refering Physician');
                    userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_8');
                    if (userMsg == null) {
                        alert('Please Enter the Refering Physician');
                        return false;
                    }
                    else {
                        alert(userMsg);
                        return false;
                    }
                    return false;
                }
            }


            if (document.getElementById('tdAmbulance').style.display != 'none') {
                var AMBID = document.getElementById('ucAmb_hdnAMBID').value;
                var DRIVERID = document.getElementById('ucAmb_hdnDriverID').value;
                var LocationID = document.getElementById('ucAmb_hdnLocationID').value;

                var distancekgm = document.getElementById('ucAmb_txtDistanceKgm').value;
                var ArrFromDate = document.getElementById('ucAmb_txtArrivalFromDate').value;
                var ArrToDate = document.getElementById('ucAmb_txtArrivalToDate').value;

                var Duration = document.getElementById('ucAmb_txtDuration').value;

                if (AMBID == "0") {

                    var userMsg = SListForApplicationMessages.Get("Billing\\GenerateBill.aspx_50");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Please Enter or Current a Ambulance No');
                    return false;
                    }
                    document.getElementById('ucAmb_txtAmbulanceNo').focus();
                    return false;
                }
                else if (DRIVERID == "0") {

                var userMsg = SListForApplicationMessages.Get("Billing\\GenerateBill.aspx_51");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Please Enter or Current a Driver Name ');
                    return false;
                    }
                    document.getElementById('ucAmb_txtDriverName').focus();
                    return false;
                }
                else if (LocationID == "0") {
                 var userMsg = SListForApplicationMessages.Get("Billing\\GenerateBill.aspx_52");
                 if (userMsg != null) {
                     alert(userMsg);
                     return false;
                 }
                 else {
                     alert('Please Enter or Current a Location Name ');
                     return false;
                 }
                    document.getElementById('ucAmb_txtLocation').focus();
                    return false;
                }
                else if (distancekgm == "") {
                var userMsg = SListForApplicationMessages.Get("Billing\\GenerateBill.aspx_53");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Please Enter a Distance(in kg/m)');
                    return false;
                }
                    document.getElementById('ucAmb_txtDistanceKgm').focus();
                    return false;
                }
                else if (ArrFromDate == "") {
                var userMsg = SListForApplicationMessages.Get("Billing\\GenerateBill.aspx_54");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Please Select a Start Date');
                    return false;
                }
                    document.getElementById('ucAmb_txtArrivalToDate').focus();
                    return false;

                }
                else if (ArrToDate == "") {
                var userMsg = SListForApplicationMessages.Get("Billing\\GenerateBill.aspx_55");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {

                    alert('Please Select a To Date');
                    return false;
                }
                    document.getElementById('ucAmb_txtArrivalToDate').focus();
                    return false;
                }
                else if (Duration == "") {
                var userMsg = SListForApplicationMessages.Get("Billing\\GenerateBill.aspx_56");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Please Enter a Duration Hours');
                    return false;
                }
                    document.getElementById('ucAmb_txtDuration').focus();
                    return false;
                }
                //                    else if(DateCompare()!=true){
                //                         return false ;
                //                    }

            }

            addItems();

            document.getElementById('<%= txtName.ClientID %>').focus();
            document.getElementById('txtAmount').readOnly = false;
            document.getElementById('txtAmount').disabled = false;
            boxExpand(document.getElementById('<%= txtName.ClientID %>'));
            return false;
        }


        function addItems() {

            if (document.getElementById('<%= txtName.ClientID %>').value == "") {
                // alert('Provide description for the selected fee type')
                userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_15');
                if (userMsg == null) {
                    alert('Provide description for the selected fee type');
                    return false;
                }
                else {
                    alert(userMsg);
                    return false;
                }
                document.getElementById('<%= txtName.ClientID %>').focus();
                return false;
            }
            else if (document.getElementById('<%= txtQty.ClientID %>').value.trim() == "") {
                // alert('Provide the quantity')
                userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_16');
                if (userMsg == null) {
                    alert('Provide the quantity');
                    return false;
                }
                else {
                    alert(userMsg);
                    return false;
                }
                document.getElementById('<%= txtQty.ClientID %>').focus();
                return false;
            }
            else {
                var feeType = document.getElementById('hdnFeeTypeSelected').value;
                var itemDesc = document.getElementById('txtName').value;
                var amt = ToInternalFormat($('#txtAmount'));
                var id = document.getElementById('hdnID').value;
                var phyLID = document.getElementById('hdnPhyLID').value;
                var sID = document.getElementById('hdnSID').value;
                var Perphysicianname = document.getElementById('txtperphy').value;
                var PerphysicianId = document.getElementById('hdnperphyID').value;
                var DisorEnhpercent = ToInternalFormat($('#hdnDisorEnhpercent')); //document.getElementById('hdnDisorEnhpercent').value;
                var DisorEnhType = document.getElementById('hdnDisorEnhType').value;
                var Remarks = document.getElementById('hdnRemarks').value;
                var ReimbursableAmount = ToInternalFormat($('#hdnReimbursableAmount')); //document.getElementById('hdnReimbursableAmount').value;
                var NonReimbursableAmount = ToInternalFormat($('#hdnNonReimbursableAmount')); //document.getElementById('hdnNonReimbursableAmount').value;

                var tQty = document.getElementById('<%= txtQty.ClientID %>');
                var itemQty = tQty.value;
                var total = amt * itemQty;
                sID = sID + '>' + phyLID;
                var DTime = document.getElementById('txtDate').value;

                //Check the item is IsReimbursable or Not
                if (document.getElementById('chkIsRI').checked) {

                    var IsRI = "Yes";

                }
                else {

                    var IsRI = "No";
                }

                var AMBCODE;

                if (document.getElementById('ucAmb_hdnAMBID').value != '0') {
                    AMBCODE = document.getElementById('dspData_hdnAmbCode').value;
                }
                else {
                    AMBCODE = ''
                }
                
                
                
                CmdAddBillItemsType_onclick(feeType, id, sID, itemDesc, Perphysicianname, PerphysicianId, itemQty, amt, total, DTime, IsRI, DisorEnhpercent, DisorEnhType, Remarks, ReimbursableAmount, NonReimbursableAmount, AMBCODE);

                ClearItemsInControl();
                AddAmountinTextbox();

                totalCalculate();
                SetOtherCurrValues();

                document.getElementById('chkIsRI').checked = true;
                document.getElementById('hdnFreeTextAllow').value = "0";
                document.getElementById('hdnFreeTextDescription').value = "";

            }
        }


        function AddAmountinTextbox() {
            document.getElementById('txtGross').value = document.getElementById('dspData_lblTotalAmt').innerHTML;
            ToTargetFormat($('#txtGross'));
            document.getElementById('hdnGrossValue').value = document.getElementById('dspData_lblTotalAmt').innerHTML;
            ToTargetFormat($('#hdnGrossValue'));
            document.getElementById('hdnAddedAmt').value = document.getElementById('dspData_lblTotalAmt').innerHTML;
            ToTargetFormat($('#hdnAddedAmt'));
            document.getElementById('lblNonMedicalAmt').innerHTML = isNaN(document.getElementById('dspData_lblNonReimburseAmt').innerHTML) || (document.getElementById('dspData_lblNonReimburseAmt').innerHTML == "") ? "0.00" : document.getElementById('dspData_lblNonReimburseAmt').innerHTML;
            ToTargetFormat($('#lblNonMedicalAmt'))
            var due = ToInternalFormat($('#hdnDue'));
            var CurrAddedAmt = ToInternalFormat($('#hdnAddedAmt'));

            //document.getElementById('txtGrandTotal').value = Number(due) + Number(CurrAddedAmt);
            //document.getElementById('hdnNetValue').value = Number(due) + Number(CurrAddedAmt);
            document.getElementById('txtGrandTotal').value = Number(CurrAddedAmt);
            document.getElementById('hdnNetValue').value = Number(CurrAddedAmt);
            ToTargetFormat($('#txtGrandTotal'))
            ToTargetFormat($('#hdnNetValue'))
            totalCalculate(); doCalcReimburse();
            SetOtherCurrValues();


            //            document.getElementById('dspData_hdnQuickBill').value = "DELAmount";
        }

        function ResetFeeType() {
            var radioButtons = document.getElementsByName("rblFeeTypes");
            var fType1 = document.getElementById('<%= txtName.ClientID %>').value;
            var ft;
            for (var x = 0; x < radioButtons.length; x++) {
                ft = radioButtons[x].value;
                if (ft == fType1) {
                    radioButtons[x].checked = true;
                }
            }
            //alert(ft);
            if (ft = "") {
                // alert('Select the fee type')
                userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_17');
                if (userMsg == null) {
                    alert('Select the fee type');
                    return false;
                }
                else {
                    alert(userMsg);
                    return false;
                }
                document.getElementById('<%= txtName.ClientID %>').value = "";
                return false;
            }
            else {
                return true;
            }
        }
        
    
    </script>

    <script type="text/javascript">
        function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {


            //            var sVal = document.getElementById('txtAmountRecieved').value;
            //            var sNetValue = document.getElementById('txtGrandTotal').value;
            //            var tempService = document.getElementById('txtServiceCharge').value;




            var obtionValue = document.getElementById('hdnSelectOnOption').value;



            switch (obtionValue) {

                case "MAKE_BILL":
                    var ConValue = "OtherCurrencyDisplay1";

                    var sVal = getOtherCurrAmtValues("REC", ConValue);
                    var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
                    var tempService = getOtherCurrAmtValues("SER", ConValue);
                    var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);

                    ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
                    sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 4);
                    sVal = format_number(Number(sVal) + Number(TotalAmount), 4);

                    if (PaymentAmount > 0) {

                        if (Number(sNetValue) >= Number(sVal)) {
                            sVal = format_number(sVal, 2);
                            SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
                            var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
                            var pScrAmt = Number(pScr) * Number(CurrRate);
                            var pAmt = Number(sVal) * Number(CurrRate);

                            document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2)
                            document.getElementById('hdnServiceCharge').value = format_number(pScrAmt, 2)
                            ToTargetFormat($('#txtServiceCharge'))
                            ToTargetFormat($('#hdnServiceCharge'))
                            var amtRec = ToInternalFormat($('#hdnDepositUsed'));
                            amtRec = 0;
                            document.getElementById('hdnAmountReceived').value = format_number(Number(amtRec) + Number(pAmt), 2);
                            document.getElementById('txtAmountRecieved').value = format_number(Number(amtRec) + Number(pAmt), 2);
                            ToTargetFormat($('#hdnAmountReceived'))
                            ToTargetFormat($('#txtAmountRecieved'))
                            var pTotal = Number(Number(sNetValue)) * Number(CurrRate);


                            document.getElementById('txtGrandTotal').value = format_number(Number(pTotal), 2);
                            document.getElementById('hdnNetValue').value = format_number(Number(pTotal), 2);
                            ToTargetFormat($('#txtGrandTotal'))
                            ToTargetFormat($('#hdnNetValue'))
                            //alert(document.getElementById('txtAmountRecieved').value);

                            doCalcReimburse(); SetOtherCurrValues();
                            return true;
                        }
                        else {
                            // alert('Amount provided is greater than net amount')
                            userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_18');
                            if (userMsg == null) {
                                alert('Amount provided is greater than net amount');
                                return false;
                            }
                            else {
                                alert(userMsg);
                                return false;
                            }
                            return false;
                        }
                    }
                case "COLLECT_ADVANCE":

                    var oldAmount = ToInternalFormat($('#txtPayment'));

                    var ConValue = "OtherCurrencyDisplay2";

                    var sVal = getOtherCurrAmtValues("REC", ConValue);
                    var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
                    var tempService = getOtherCurrAmtValues("SER", ConValue);
                    var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);

                    ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
                    sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 4);
                    sVal = format_number(Number(sVal) + Number(TotalAmount), 4);

                    SetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
                    var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
                    var pScrAmt = Number(pScr) * Number(CurrRate);
                    var pAmt = Number(sVal) * Number(CurrRate);
                    oldAmount = Number(oldAmount) + Number(TotalAmount);

                    document.getElementById('<%= txtPayment.ClientID %>').value = format_number(pAmt, 2);
                    document.getElementById('<%= hdnNowPaid.ClientID %>').value = format_number(pAmt, 2);
                    document.getElementById('<%= txtAdvServiceCharge.ClientID %>').value = format_number(pScrAmt, 2);
                    document.getElementById('<%= hdnAdvServiceCharge.ClientID %>').value = format_number(pScrAmt, 2);
                    ToTargetFormat($('#txtPayment'));
                    ToTargetFormat($('#hdnNowPaid'));
                    ToTargetFormat($('#txtAdvServiceCharge'));
                    ToTargetFormat($('#hdnAdvServiceCharge'));
                    SetOtherCurrValues();
                    return true;
                case "SURGERY_BILL":

                    break;
                case "SURGERY_ADVANCE":

                    break;
                default:
                    break;
            }
        }




        function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            var obtionValue = document.getElementById('hdnSelectOnOption').value;
            switch (obtionValue) {

                case "MAKE_BILL":

                    var ConValue = "OtherCurrencyDisplay1";
                    var sVal = getOtherCurrAmtValues("REC", ConValue);
                    var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
                    var tempService = getOtherCurrAmtValues("SER", ConValue);
                    var CurrRate = GetOtherCurrency("OtherCurrRate");

                    //                    var sVal = document.getElementById('hdnAmountReceived').value;
                    //                    var tempService = document.getElementById('hdnServiceCharge').value;
                    //                    var sNetValue = document.getElementById('txtGrandTotal').value;

                    sVal = Number(Number(sVal) - Number(TotalAmount));
                    
                    ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
                    var pScr = format_number(Number(tempService) - Number(ServiceCharge), 2);
                    var pScrAmt = Number(pScr) * Number(CurrRate);
                    var pAmt = Number(sVal) * Number(CurrRate);
                    sNetValue = format_number(Number(sNetValue) - Number(ServiceCharge), 4);
                   
                    document.getElementById('hdnServiceCharge').value = format_number(pScrAmt, 2);
                    document.getElementById('txtServiceCharge').value = format_number(pScrAmt, 2);
                    ToTargetFormat($('#hdnServiceCharge'));
                    ToTargetFormat($('#txtServiceCharge'));

                    var amtRec = document.getElementById('hdnDepositUsed').value;
                    amtRec = 0;
                    document.getElementById('hdnAmountReceived').value = format_number(Number(sVal) + Number(amtRec), 2);
                    document.getElementById('txtAmountRecieved').value = format_number(Number(sVal) + Number(amtRec), 2);
                    ToTargetFormat($('#hdnAmountReceived'));
                    ToTargetFormat($('#txtAmountRecieved'));
                    
                    //                    document.getElementById('hdnAmountReceived').value = format_number(sVal, 2);
                    //                    document.getElementById('txtAmountRecieved').value = format_number(sVal, 2);

                    totalCalculate();

                    SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);
                    doCalcReimburse();
                    var pTotal = Number(Number(sNetValue)) * Number(CurrRate);

                    document.getElementById('txtGrandTotal').value = format_number(Number(pTotal), 2);
                    document.getElementById('hdnNetValue').value = format_number(Number(pTotal), 2);
                    ToTargetFormat($('#txtGrandTotal'));
                    ToTargetFormat($('#hdnNetValue'));
                    SetOtherCurrValues();
                    break;
                case "COLLECT_ADVANCE":

                    //                    var sVal = document.getElementById('hdnNowPaid').value;
                    //                    var tempService = document.getElementById('hdnServiceCharge').value;

                    var ConValue = "OtherCurrencyDisplay2";
                    var sVal = getOtherCurrAmtValues("REC", ConValue);
                    var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
                    var tempService = getOtherCurrAmtValues("SER", ConValue);
                    var CurrRate = GetOtherCurrency("OtherCurrRate");

                    sVal = Number(Number(sVal) - Number(TotalAmount));
                    ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
                    var pScr = format_number(Number(tempService) - Number(ServiceCharge), 2);
                    var pScrAmt = Number(pScr) * Number(CurrRate);
                    var pAmt = Number(sVal) * Number(CurrRate);
                    //                    sVal = format_number(Number(sVal) - Number(TotalAmount), 2);
                    //                    
                    //                    ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
                    SetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);

                    document.getElementById('<%= txtPayment.ClientID %>').value = format_number(sVal, 2);
                    document.getElementById('<%= hdnNowPaid.ClientID %>').value = format_number(sVal, 2);
                    document.getElementById('<%= txtAdvServiceCharge.ClientID %>').value = format_number(pScrAmt, 2);
                    document.getElementById('<%= hdnAdvServiceCharge.ClientID %>').value = format_number(pScrAmt, 2);
                    ToTargetFormat($('#txtPayment'));
                    ToTargetFormat($('#hdnNowPaid'));
                    ToTargetFormat($('#txtAdvServiceCharge'));
                    ToTargetFormat($('#hdnAdvServiceCharge'));
                    
                    SetOtherCurrValues();
                    break;
                case "SURGERY_BILL":

                    break;
                case "SURGERY_ADVANCE":

                    break;
                default:
                    break;
            }




        }
        function SurgeryModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {



            var oldAmount = ToInternalFormat($('#txtSurAmount')); 


            oldAmount = Number(oldAmount) + Number(TotalAmount);



            //var tempService = document.getElementById('txtsurService').value;
            //ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);

            var ConValue = "OtherCurrencyDisplay3";

            var sVal = getOtherCurrAmtValues("REC", ConValue);
            var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
            var tempService = getOtherCurrAmtValues("SER", ConValue);
            var CurrRate = GetOtherCurrency("OtherCurrRate", ConValue);

            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            sNetValue = format_number(Number(sNetValue) + Number(ServiceCharge), 4);
            sVal = format_number(Number(sVal) + Number(TotalAmount), 4);

            SurgerySetReceivedOtherCurr(sVal, format_number(Number(ServiceCharge) + Number(tempService), 2), ConValue);
            var pScr = format_number(Number(ServiceCharge) + Number(tempService), 2);
            var pScrAmt = Number(pScr) * Number(CurrRate);
            var pAmt = Number(sVal) * Number(CurrRate);




            document.getElementById('<%= hdnSurService.ClientID %>').value = format_number(pScrAmt, 2);
            document.getElementById('<%= txtsurService.ClientID %>').value = format_number(pScrAmt, 2);
            document.getElementById('<%= txtSurAmount.ClientID %>').value = format_number(pAmt, 2);
            document.getElementById('<%= hdnSurPayment.ClientID %>').value = format_number(pAmt, 2);
            ToTargetFormat($('#hdnSurService'));
            ToTargetFormat($('#txtsurService'));
            ToTargetFormat($('#txtSurAmount'));
            ToTargetFormat($('#hdnSurPayment'));
            
            SetOtherCurrValues();
            return true;

        }


        function SurgeryDeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            //            var oldAmount = document.getElementById('<%= txtSurAmount.ClientID %>').value;
            //            oldAmount = Number(oldAmount) - Number(TotalAmount);
            //            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            //            var tempService = document.getElementById('<%= txtsurService.ClientID %>').value;

            var ConValue = "OtherCurrencyDisplay3";
            var sVal = getOtherCurrAmtValues("REC", ConValue);
            var sNetValue = getOtherCurrAmtValues("PAY", ConValue);
            var tempService = getOtherCurrAmtValues("SER", ConValue);
            var CurrRate = GetOtherCurrency("OtherCurrRate");

            sVal = Number(Number(sVal) - Number(TotalAmount));
            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            var pScr = format_number(Number(tempService) - Number(ServiceCharge), 2);
            var pScrAmt = Number(pScr) * Number(CurrRate);
            var pAmt = Number(sVal) * Number(CurrRate);

            SurgerySetReceivedOtherCurr(sVal, format_number(Number(tempService) - Number(ServiceCharge), 2), ConValue);


            document.getElementById('<%= txtSurAmount.ClientID %>').value = format_number(sVal, 2);
            document.getElementById('<%= hdnSurPayment.ClientID %>').value = format_number(sVal, 2);
            document.getElementById('<%= txtsurService.ClientID %>').value = format_number(pScrAmt, 2);
            document.getElementById('<%= hdnSurService.ClientID %>').value = format_number(pScrAmt, 2);

            ToTargetFormat($('#hdnSurService'));
            ToTargetFormat($('#txtsurService'));
            ToTargetFormat($('#txtSurAmount'));
            ToTargetFormat($('#hdnSurPayment'));
            
            
            SetOtherCurrValues();
        }

    </script>

    <script type="text/javascript">

        function CheckBillingItems() {
            if (document.getElementById('dspData_hdfBillType1').value == "") {
                //alert(document.getElementById('dspData_hdfBillType').value);
                // alert('There are no items in the queue to be billed')
                userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_19');
                if (userMsg == null) {
                    alert('There are no items in the queue to be billed');
                    return false;
                }
                else {
                    alert(userMsg);
                    return false;
                }
                document.getElementById('txtName').focus();
                return false;
            }
            if (Number(ToInternalFormat($('#txtDiscount'))) > 0) {
                if (document.getElementById('txtDiscountReason').value == "") {
                    // alert('Enter Reason for Discount.');
                    userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_20');
                    if (userMsg == null) {
                        alert('Enter Reason for Discount');
                        return false;
                    }
                    else {
                        alert(userMsg);
                        return false;
                    }
                    document.getElementById('txtDiscountReason').focus();
                    return false;
                }
            }
            if (document.getElementById('btnSave').style.display == 'none') {

                var ctlDp = document.getElementById('PaymentType_ddlPaymentType');
                var PaymentName = trim((ctlDp.options[ctlDp.selectedIndex].innerHTML).split('@')[0], ' ');
                if (PaymentName != 'Cash' && PaymentMethodNumber == "" && ToInternalFormat($('#paymentType_hdnlastreceivedamt')) != ToInternalFormat($('#txtAmountRecieved'))) {
                    // alert("Please Enter Cheque/Card Number");
                    userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_21');
                    if (userMsg == null) {
                        alert('Please Enter Cheque/Card Number');
                        return false;
                    }
                    else {
                        alert(userMsg);
                        return false;
                    }
                    document.getElementById('paymentType_txtNumber>').focus();
                    return false;
                }
                else if (PaymentName != 'Cash' && PaymentBankType == "" && ToInternalFormat($('#paymentType_hdnlastreceivedamt')) != ToInternalFormat($('#txtAmountRecieved'))) {
                    // alert("Please Enter Bank Name/Card Type");
                    userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_22');
                    if (userMsg == null) {
                        alert('Please Enter Bank Name/Card Type');
                        return false;
                    }
                    else {
                        alert(userMsg);
                        return false;
                    }
                    document.getElementById('paymentType_txtBankType').focus();
                    return false;
                }
            }
            else {


                var alte = PaymentSaveValidation();
                if (alte == true) {
                    document.getElementById('btnSave').style.display = 'none';
                    return true;
                }
                else {
                    return false;
                }
            }
            return true;
        }



        function ValidateDiscountReason() {
            if (Number(ToInternalFormat($('#txtDiscount'))) > 0) {
                document.getElementById('trDiscountReason').style.display = "block";
                document.getElementById('txtDiscountReason').focus();
            }
            else {
                document.getElementById('trDiscountReason').style.display = "none";
                document.getElementById('txtDiscountReason').value = "";
            }
        }

        function ChangeFormat() {
            document.getElementById('txtSubDeduction').value = format_number(ToInternalFormat($('#txtSubDeduction')), 2);
            ToTargetFormat($("txtSubDeduction"));
            var discount = format_number(ToInternalFormat($('#txtDiscount')), 2);
            document.getElementById('txtDiscount').value = String(discount);
            ToTargetFormat($('#txtDiscount'))
            document.getElementById('txtAmountRecieved').value = format_number(ToInternalFormat($('#txtAmountRecieved')), 2);
            ToTargetFormat($("#txtAmountRecieved"));
            document.getElementById('hdnAmountReceived').value = format_number(ToInternalFormat($('#txtAmountRecieved')), 2);
            ToTargetFormat($("#hdnAmountReceived"));
            document.getElementById('txtTax').value = format_number(ToInternalFormat($('#txtTax')), 2);
            ToTargetFormat($("#txtTax"));
            document.getElementById('hdnTaxAmount').value = format_number(ToInternalFormat($('#txtTax')), 2);
            ToTargetFormat($("#hdnTaxAmount"));
            var gross = ToInternalFormat($('#txtGross')) ;
            
            if ((Number(gross)) < (Number(discount))) {
                document.getElementById('txtDiscount').value = "0.0";
                ToTargetFormat($('#txtDiscount'))
                totalCalculate();
                SetOtherCurrValues();
                //document.getElementById('txtGrandTotal').value = document.getElementById('txtGross').value;
                // alert('Discount amount is greater than gross value')
                userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_23');
                if (userMsg == null) {
                    alert('Discount amount is greater than gross value');
                    return false;
                }
                else {
                    alert(userMsg);
                    return false;
                }

                document.getElementById('txtGrandTotal').value = gross;
                document.getElementById('hdnNetValue').value = gross;
                ToTargetFormat($('#txtGrandTotal'))
                ToTargetFormat($('#hdnNetValue'))
            }
        }
        function totalCalculate() {
            var GrossAmount = ToInternalFormat($('#txtGross'));
            var DiscountAmount = ToInternalFormat($('#txtDiscount'));
            
            var PreviousReceived = 0;
            var PreviousDue = 0;
            var AdvanceReceivd = 0;

            var RefundAmount = 0;
            var TaxAMount = Number(ToInternalFormat($('#txtTax')));
            document.getElementById('hdnTaxAmount').value = format_number(ToInternalFormat($('#txtTax')), 2);
            ToTargetFormat($('#hdnTaxAmount'))
            var defRoundOff = ToInternalFormat($('#hdnDefaultRoundoff')); 
            var RoundOffType = document.getElementById('<%= hdnRoundOffType.ClientID %>').value;

            PreviousReceived = chkIsnumber(PreviousReceived);
            GrossAmount = chkIsnumber(GrossAmount);
            DiscountAmount = chkIsnumber(DiscountAmount);
            ////PreviousDue = chkIsnumber(PreviousDue);
            PreviousDue = 0;
            AdvanceReceivd = chkIsnumber(AdvanceReceivd);
            TaxAMount = chkIsnumber(TaxAMount);

            if ((Number(GrossAmount) - Number(DiscountAmount)) < 0 && Number(GrossAmount) > 0) {
                // alert('Discount cannot be greater than gross amount')
                userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_24');
                if (userMsg == null) {
                    alert('Discount cannot be greater than gross amount');
                    return false;
                }
                else {
                    alert(userMsg);
                    return false;
                }
                document.getElementById('<%= txtDiscount.ClientID  %>').value = GrossAmount;
                ToTargetFormat($('#txtDiscount'))
                CorrectTotal();
                totalCalculate();
                SetOtherCurrValues();

            }
            else {
                ////var totGrossAmount = format_number((Number(GrossAmount) + Number(TaxAMount) + Number(PreviousDue) - (Number(PreviousReceived) + Number(DiscountAmount) + Number(AdvanceReceivd))), 2);
                var totGrossAmount = format_number((Number(GrossAmount) + Number(TaxAMount) - (Number(PreviousReceived) + Number(DiscountAmount) + Number(AdvanceReceivd))), 2);
                
                var hdnRoundOff = document.getElementById('<%= hdnRoundOff.ClientID %>');
                document.getElementById('<%= txtRoundOff.ClientID %>').value=getCustomRoundoff(totGrossAmount, Number(defRoundOff), RoundOffType);
                
                // Code added by Vijay TV to fix 'NaN' being shown in RoundOff field on 08 July begins
                if (document.getElementById('<%= txtRoundOff.ClientID %>').value == 'NaN') // If the result is NaN (caused due to Divide by Zero), set the value to Zero.
                {
                    document.getElementById('<%= txtRoundOff.ClientID %>').value = 0;
                   
                }
                // Code added by Vijay TV to fix 'NaN' being shown in RoundOff field on 08 July ends



                hdnRoundOff.value = document.getElementById('<%= txtRoundOff.ClientID %>').value;

                totGrossAmount = format_number((Number(document.getElementById('<%= txtRoundOff.ClientID %>').value) + Number(totGrossAmount)), 2);

                if (Number(totGrossAmount) > 0) {
                    document.getElementById('<%= txtGrandTotal.ClientID  %>').value = totGrossAmount;
                }
                else {
                    
                    document.getElementById('<%= txtGrandTotal.ClientID  %>').value = 0;
                    //// RefundAmount.value = format_number((Number(PreviousReceived) + Number(DiscountAmount) + Number(AdvanceReceivd)) - (Number(GrossAmount) + Number(TaxAMount) + Number(PreviousDue)), 2);
                    //RefundAmount.value = format_number((Number(PreviousReceived) + Number(DiscountAmount) + Number(AdvanceReceivd)) - (Number(GrossAmount) + Number(TaxAMount)), 2);
                }
                ToTargetFormat($('#txtGrandTotal'));
                ToTargetFormat($('#txtRoundOff'));
                ToTargetFormat($('#hdnRoundOff'));
                //RefundAmount
                Calc_Copayment();  
            }

        }
        function CorrectTotal() {
            var gross = ToInternalFormat($('#txtGross'));
            var pDisCont = ToInternalFormat($("#ddDiscountPercent"));
            if (pDisCont != '0' && pDisCont != '') {
                if (pDisCont == '0.00') {
                    document.getElementById('txtDiscount').value = parseFloat((parseFloat(gross) / 100) * (ToInternalFormat($('#txtDiscountPercent')))).toFixed(2);
                    //document.getElementById('txtDiscountPercent').visible = true;
                    ToTargetFormat($('#txtDiscount'));
                    document.getElementById('txtDiscountPercent').style.display = 'Block';
                }
                else {
                    document.getElementById('txtDiscount').value = parseFloat((parseFloat(gross) / 100) * parseFloat(pDisCont)).toFixed(2);
                    ToTargetFormat($('#txtDiscount'));
                }
               
                document.getElementById('txtDiscount').readOnly = true;
            }

            else {
                document.getElementById('txtDiscount').readOnly = false;
            }
            var discount = ToInternalFormat($('#txtDiscount'));
            var net =ToInternalFormat($('#txtGrandTotal'));
            var hdnnet =  ToInternalFormat($('#hdnNetValue'));
            var TaxAMount = Number(ToInternalFormat($('#txtTax')), 2);
            var due = ToInternalFormat($('#hdnDue'));

            //var netvalue = gross + TaxAMount - discount + Number(due);
            //due amount comment by sureshkumar m
            var netvalue = gross + TaxAMount - discount;
            //alert(netvalue);
            document.getElementById('txtGrandTotal').value = netvalue;
            document.getElementById('hdnNetValue').value = netvalue;
            ToTargetFormat($('#txtGrandTotal'));
            ToTargetFormat($('#hdnNetValue'));
           
            SetOtherCurrValues();


        }

        
    </script>

    <script type="text/javascript">

        function clearbilleditem() {
            var response2;
            // var response2 = window.confirm("Do you want to clear the Billed items ?");
            userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_30');
            if (userMsg == null)
                response2 = confirm("Do you want to clear the Billed items?");
            else
                response2 = confirm(userMsg);
            if (response2) {
                ItemscloseData();
            }
            return false;
        }

        function ItemscloseData() {

            ClearReferringPhysician("ReferDoctor1");
            ClearReferringPhysician("ReferDoctor2");
            ClearPaymentControlEventsDAD();
            ClearPaymentControlEvents();
            SurgeryClearPaymentControlEvents()
            AddAmountinTextbox();
            clearDiscounts();
            clearDue();
            clearServiceCharge();
            cleartaxamount();
            CLEARAMOUNTRECEIVED();
            PaymentControlclear();
            SurgeryPaymentControlclear();
            if ($('#hdnBillingLogic').val() != 'after') {
                document.getElementById('<%= btnSave.ClientID %>').style.display = 'block';
            }
            ResetFeeType();
            GetCurrencyValues();
            ClearDisplayData();
            ClearOtherCurrValues("OtherCurrencyDisplay1");
            ClearOtherCurrValues("OtherCurrencyDisplay2");
            ClearOtherCurrValues("OtherCurrencyDisplay3");
            ClearCollectAdvanc();
            ClearCollectSurgeryAdvanc();
            if (typeof unCheckDepositUsage == 'function') {
                unCheckDepositUsage();
            }
            onchangeName();
            ClearItemsInControl();
            document.getElementById('<%= hdnAmbulanceDetails.ClientID %>').value = '';
            return false;
        }

        function ClearItemsInControl() {
            document.getElementById('<%= txtQty.ClientID %>').value = 1;
            document.getElementById('<%= txtName.ClientID %>').value = "";
            document.getElementById('<%= txtAmount.ClientID %>').value = "0";
            ToTargetFormat($('#txtAmount'));
            document.getElementById('<%= hdnPhyLID.ClientID %>').value = "";
            document.getElementById('<%= hdnSID.ClientID %>').value = "";
            document.getElementById('hdnID').value = "-1";
            document.getElementById('<%= txtperphy.ClientID %>').value = "";

            var radio = document.getElementsByName('<%= rblFeeTypes.ClientID %>');
            for (var ii = 0; ii < radio.length; ii++) {
                if (radio[ii].checked) {
                    document.getElementById('hdnFeeTypeSelected').value = radio[ii].value; //== "LAB" ? "INV" : radio[ii].value;
                }
            }
        }

        function ClearCollectSurgeryAdvanc() {

            document.getElementById('<%= txtSurAmount.ClientID %>').value = 0.00;
            document.getElementById('<%= hdnSurPayment.ClientID %>').value = 0.00;
            document.getElementById('<%= hdnSurService.ClientID %>').value = 0.00;
            document.getElementById('<%= txtsurService.ClientID %>').value = 0.00;
            ToTargetFormat($('#txtSurAmount'));
            ToTargetFormat($('#hdnSurPayment'));
            ToTargetFormat($('#hdnSurService'));
            ToTargetFormat($('#txtsurService'));
        }
        function ClearCollectAdvanc() {
            document.getElementById('divAdvancDetais').innerHTML = "";
            document.getElementById('<%= lblAdvancePaid2.ClientID %>').innerHTML = 0.00;
            document.getElementById('<%= lblAdvancePaid1.ClientID %>').innerHTML = 0.00;
            document.getElementById('<%= txtPayment.ClientID %>').value = 0.00;
            document.getElementById('<%= hdnNowPaid.ClientID %>').value = 0.00;
            document.getElementById('<%= txtAdvServiceCharge.ClientID %>').value = 0.00;
            document.getElementById('<%= hdnAdvServiceCharge.ClientID %>').value = 0.00;
            ToTargetFormat($('#lblAdvancePaid2'));
            ToTargetFormat($('#lblAdvancePaid1'));
            ToTargetFormat($('#txtPayment'));
            ToTargetFormat($('#hdnNowPaid'));
            ToTargetFormat($('#txtAdvServiceCharge'));
            ToTargetFormat($('#hdnAdvServiceCharge'));
        }
        function IPDisplayDue(DueAmount) {
            document.getElementById('<%= txtDue.ClientID %>').value = DueAmount;
            ToTargetFormat($('#txtDue'));
        }

        function DisplayData(stringval, dueamt, dueString) {
            document.getElementById('Due').innerHTML = stringval;
            document.getElementById('<%= txtDue.ClientID %>').value = parseFloat(dueamt).toFixed(2);
            document.getElementById('<%= hdnDue.ClientID %>').value = dueamt;
            document.getElementById('<%= hdnDPDetails.ClientID %>').value = dueString;
            ToTargetFormat($('#txtDue'));
            ToTargetFormat($('#hdnDue'));
            ToTargetFormat($('#hdnDPDetails'));
            if (Number(dueamt) > 0)
                alert('This patient has due amount of <%= CurrencyName %>  - ' + dueamt);
            
            AddAmountinTextbox();
        }

        function ChangeDisplay() {
            var dueAmt = ToInternalFormat($('#hdnDue'));
            
            if (Number(dueAmt, 2) > 0) {
                if (document.getElementById('Due').style.display == 'block')
                    document.getElementById('Due').style.display = 'none';
                else
                    document.getElementById('Due').style.display = 'none';
            }
            else {
                document.getElementById('Due').style.display = 'none';
            }
            return false;

        }

        function ChangeImage1() {
            if (Number(ToInternalFormat($('#txtDue'))) > 0) {

                if (document.getElementById('imgDue').src.split('Images')[1] == '/collapse.jpg')
                    document.getElementById('imgDue').src = '../Images/expand.jpg';
                else if (document.getElementById('imgDue').src.split('Images')[1] == '/expand.jpg')
                    document.getElementById('imgDue').src = '../Images/collapse.jpg';
            }
            else {
                // alert('There is no due in this invoice')
                userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_25');
                if (userMsg == null) {
                    alert('There is no due in this invoice');
                    return false;
                }
                else {
                    alert(userMsg);
                    return false;
                }
            }
        }
    </script>

    <script type="text/javascript">

        function SetPanelOPorIP(tvType, voption) {
            document.getElementById('tbOP').style.display = "none";
            document.getElementById('tbIP').style.display = "none";
            document.getElementById('tdOthers').style.display = "none";
            document.getElementById('hdnSelectOnOption').value = voption;
            document.getElementById('trPrintOPCard').style.display = "none";
            document.getElementById('hdnVisitType').value = tvType;

            switch (voption) {
                case "MAKE_BILL":
                    if (tvType == "OP") {
                        document.getElementById('tbOP').style.display = "block";
                        document.getElementById('tbIP').style.display = "none";
                        document.getElementById('trPrintOPCard').style.display = "block";
                    }
                    if (tvType == "IP" && document.getElementById('ChkIsAddedtoServices').checked == false) {
                        document.getElementById('tbOP').style.display = "none";
                        document.getElementById('tbIP').style.display = "block";
                        document.getElementById('trPrintOPCard').style.display = "none";
                    }
                    break;
                case "COLLECT_ADVANCE":
                case "SURGERY_BILL":
                case "SURGERY_ADVANCE":
                    if (tvType == "OP") {
                        document.getElementById('tbOP').style.display = "block";
                        document.getElementById('tbIP').style.display = "none";
                        document.getElementById('trPrintOPCard').style.display = "block";

                    }
                    if (tvType == "IP" && document.getElementById('ChkIsAddedtoServices').checked == false) {
                        document.getElementById('tdOthers').style.display = "block";
                        document.getElementById('tbOP').style.display = "none";
                        document.getElementById('tbIP').style.display = "none";
                        document.getElementById('trPrintOPCard').style.display = "none";
                    }
                    break;
                default:
                    break;
            }
        }

        function getCustomRoundoff(roundoffVal, DefaultRound, RoundOffType) {
            var result = 0;
            if (RoundOffType.toLowerCase() == "lower value") {
                result = (Math.floor(Number(roundoffVal) / Number(DefaultRound))) * (Number(DefaultRound));
            }
            else if (RoundOffType.toLowerCase() == "upper value") {
                result = (Math.ceil(Number(roundoffVal) / Number(DefaultRound))) * (Number(DefaultRound));
            }
            else if (RoundOffType.toLowerCase() == "none") {
                result = format_number_withSignNone(roundoffVal, 2);
            }
            else {
                result = roundoffVal;
            }
            result = Number(result) - Number(roundoffVal);
            result = format_number_withSign(result, 2);
            return result;
        }
    </script>

   
    <script type="text/javascript" language="javascript">
        function pBillingOption(obtionValue, pStatus) {
        
                document.getElementById('hdnSelectOnOption').value = obtionValue;
                switch (obtionValue) {
                    case "MAKE_BILL":
                        document.getElementById('divMakeBill').style.display = "block";
                        document.getElementById('divCollectAdvance').style.display = "none";
                        document.getElementById('divSurgeryAdvance').style.display = "none";
                        document.getElementById('divPaymentType').style.display = "block";
                        document.getElementById('tdOthers').style.display = "none";
                        break;
                    case "COLLECT_ADVANCE":
                        document.getElementById('divCollectAdvance').style.display = "block";
                        document.getElementById('divMakeBill').style.display = "none";
                        document.getElementById('divSurgeryAdvance').style.display = "none";
                        document.getElementById('divPaymentType').style.display = "block";
                        document.getElementById('tdOthers').style.display = "block";
                        break;
                    case "SURGERY_BILL":
                        if (pStatus == "Y") {
                            document.getElementById('<%= btnSubmit.ClientID %>').click();
                        }
                        break;
                    case "SURGERY_ADVANCE":
                        document.getElementById('divSurgeryAdvance').style.display = "block";
                        document.getElementById('divMakeBill').style.display = "none";
                        document.getElementById('divCollectAdvance').style.display = "none";
                        document.getElementById('divPaymentType').style.display = "none";
                        document.getElementById('tdOthers').style.display = "block";
                        break;
                    default:
                        break;
                }
            
        }
        function DisplayAdvancData(stringval, Advamt) {
            document.getElementById('divAdvancDetais').innerHTML = stringval;
            document.getElementById('<%= lblAdvancePaid2.ClientID %>').innerHTML = Advamt;
            document.getElementById('<%= lblAdvancePaid1.ClientID %>').innerHTML = Advamt;
            ToTargetFormat($('#lblAdvancePaid2'));
            ToTargetFormat($('#lblAdvancePaid1'));

        }
        function SetValueOPIO(obj) {
            document.getElementById('hdnOPIP').value = obj;
        }
    </script>

    <script language="javascript" type="text/javascript">

        function SetOtherCurrValues() {
            var obtionValue = document.getElementById('hdnSelectOnOption').value;
            var pnetAmt = 0;
            switch (obtionValue) {
                case "MAKE_BILL":
                    pnetAmt = ToInternalFormat($('#txtGrandTotal')) == "" ? "0" : ToInternalFormat($('#txtGrandTotal'));
                    var ConValue = "OtherCurrencyDisplay1";
                    SetPaybleOtherCurr(pnetAmt, ConValue, true);
                    setCreditBilled(pnetAmt);
                    break;
                case "COLLECT_ADVANCE":
                    var ConValue = "OtherCurrencyDisplay2";
                    SetPaybleOtherCurr(pnetAmt, ConValue, false);
                    break;
                case "SURGERY_ADVANCE":
                    var ConValue = "OtherCurrencyDisplay3";
                    SurgerySetPaybleOtherCurr(pnetAmt, ConValue, false);
                    break;
                default:
                    break;
            }
        }

        function openPOPupQuick(url) {
            window.open(url, "PrictBill", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
        }
        //        function setvalidateDaycare(tvType, voption) {
        //        if(tvType=="DayCare") {
        //            if (voption == "-----Select-----") {
        //                alert("Please Select  Episode");
        //                return false;
        //                }
        //             else{
        //                return true;
        //             }
        //            }
        //        }


        function CheckAdvanceDetals() {
            document.getElementById('btnSubmit').style.display = "none";
            var returndatavalue = checkPatientnVisit();
            if (returndatavalue == "Y") {
                document.getElementById('btnSubmit').style.display = "block";
                return false;
            }

            if (returndatavalue) {
                var obtionValue = document.getElementById('hdnSelectOnOption').value;
                var pnetAmt = 0;
                switch (obtionValue) {
                    case "COLLECT_ADVANCE":

                        var alte = PaymentSaveValidation();
                        if (Number(ToInternalFormat($('#txtPayment'))) == 0) {
                            // alert("Collect The Advance")
                            userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_26');
                            if (userMsg == null) {
                                alert('Collect The Advance');
                                return false;
                            }
                            else {
                                alert(userMsg);
                                return false;
                            }
                            document.getElementById('btnSubmit').style.display = "block";
                            return false;
                        }
                        if (alte == true) {
                            return true;
                        }
                        else {
                            document.getElementById('btnSubmit').style.display = "block";
                            return false;
                        }

                    case "SURGERY_ADVANCE":
                        var alte = SurgeryPaymentSaveValidation();
                        if (alte == true) {
                            return true;
                        }
                        else {
                            return false;
                        }

                }
            }
            else {
                // alert("Select the patient")
                userMsg = SListForApplicationMessages.Get('Billing\\GenerateBill.aspx_27');
                if (userMsg == null) {
                    alert('Select the patient');
                    return false;
                }
                else {
                    alert(userMsg);
                    return false;
                }
                document.getElementById('btnSubmit').style.display = "block";
                return false;
            }
        }
    </script>

    <script language="javascript" type="text/javascript">

        function doCalcReimburse() {

            var hdnNonMedical = 0;
            var txtServiceCharge = ToInternalFormat($('#txtServiceCharge'));
            var txtGrandTotal = ToInternalFormat($('#txtGrandTotal'));
            var txtAmountRecieved = ToInternalFormat($('#txtAmountRecieved'));
            document.getElementById('<%= hdnTotalAmtRec.ClientID %>').value = txtAmountRecieved;
            

            var txtNonMedical = ToInternalFormat($('#txtNonMedical'));
            var txtCoPayment = ToInternalFormat($('#txtCoPayment'));
            var txtExcess = ToInternalFormat($('#txtExcess'));

            var pPreAuthAmount = 0;
            //pro

            var NonReimburseAmt = Number(ToInternalFormat($('#<%= lblNonMedicalAmt.ClientID%>')));

            var AmtRecd = Number(txtAmountRecieved);

            var TpaPaidAmt = 0;

            pPreAuthAmount = TpaPaidAmt > 0 ? pPreAuthAmount - TpaPaidAmt : pPreAuthAmount;

            if (NonReimburseAmt > 0 && NonReimburseAmt < AmtRecd) {
                document.getElementById('<%= txtNonMedical.ClientID %>').value = parseFloat(NonReimburseAmt).toFixed(2);
                document.getElementById('<%= txtCoPayment.ClientID %>').value = parseFloat(AmtRecd - NonReimburseAmt).toFixed(2);
                

                if (Number(txtCoPayment) > Number(pPreAuthAmount)) {
                    document.getElementById('<%= txtExcess.ClientID %>').value = parseFloat(Number(txtCoPayment) - Number(pPreAuthAmount)).toFixed(2);
                    document.getElementById('<%= txtCoPayment.ClientID %>').value = Number(pPreAuthAmount).toFixed(2);
                    

                } else {
                document.getElementById('<%= txtExcess.ClientID %>').value = (0).toFixed(2);
                
                }

            } else if (NonReimburseAmt > 0 && NonReimburseAmt > AmtRecd) {

                document.getElementById('<%= txtNonMedical.ClientID %>').value = parseFloat(AmtRecd).toFixed(2);
                document.getElementById('<%= txtCoPayment.ClientID %>').value = (0).toFixed(2);
                document.getElementById('<%= txtExcess.ClientID %>').value = (0).toFixed(2);
                

            } else if (NonReimburseAmt == 0) {

                document.getElementById('<%= txtCoPayment.ClientID %>').value = parseFloat(AmtRecd).toFixed(2);
               
                if (Number(AmtRecd) > Number(pPreAuthAmount)) {
                    document.getElementById('<%= txtExcess.ClientID %>').value = parseFloat(Number(AmtRecd) - Number(pPreAuthAmount)).toFixed(2);
                    document.getElementById('<%= txtCoPayment.ClientID %>').value = Number(pPreAuthAmount).toFixed(2);
                    
                } else {
                document.getElementById('<%= txtExcess.ClientID %>').value = (0).toFixed(2);
                
                }
            }
            ToTargetFormat($('#txtExcess'));
            ToTargetFormat($('#txtCoPayment'));
            ToTargetFormat($('#txtNonMedical'));
            ToTargetFormat($('#<%= hdnTotalAmtRec.ClientID %>'));
            ToTargetFormat($('#txtServiceCharge'));
            ToTargetFormat($('#txtGrandTotal'));
            ToTargetFormat($('#txtAmountRecieved'));

        }

        function getPrecision(obj) {
            obj.value = obj.value == "" ? parseFloat(0).toFixed(2) : parseFloat(ToInternalFormat($(obj))).toFixed(2);
            ToTargetFormat($(obj)); // = ToInternalFormat($(obj)) == "" ? parseFloat(0).toFixed(2) : parseFloat(ToInternalFormat($(obj))).toFixed(2);
        }

        function customCoPayment() {
            var txtCoPayment = ToInternalFormat($("#txtCoPayment"));
            var txtExcess =ToInternalFormat($("#txtExcess")); 
            var hdnCoPayment = ToInternalFormat($("#hdnCoPayment"));  

            var excess = Number(txtExcess);
            var diffAmt = Number(txtCoPayment) - Number(hdnCoPayment);

            if (diffAmt > 0) {
                if (diffAmt > excess) {
                     document.getElementById("txtCoPayment").value = parseFloat(Number(hdnCoPayment) + excess).toFixed(2);
                    document.getElementById("txtExcess").value = parseFloat(0).toFixed(2);
                } else {
                document.getElementById("txtCoPayment").value = parseFloat(Number(hdnCoPayment) + diffAmt).toFixed(2);
                document.getElementById("txtExcess").value =  parseFloat(excess - diffAmt).toFixed(2);
                     
                }
            } else {
                diffAmt = (-1) * diffAmt;
                txtCoPayment.value = 
                txtExcess.value = 

                document.getElementById("txtCoPayment").value = parseFloat(Number(hdnCoPayment) - diffAmt).toFixed(2);
                document.getElementById("txtExcess").value = parseFloat(Number(txtExcess) + diffAmt).toFixed(2);

            }
            ToTargetFormat($("#txtCoPayment"));
            ToTargetFormat($("#txtExcess"));
        }

        function prepareCopayment() {
            var hdnCoPayment = document.getElementById("hdnCoPayment");
            var txtCoPayment = ToInternalFormat($("#txtCoPayment")) == "" ? parseFloat(0).toFixed(2) : parseFloat(ToInternalFormat($("#txtCoPayment"))).toFixed(2);
            hdnCoPayment.value = txtCoPayment;
            ToTargetFormat($("#hdnCoPayment"));
            
        }

        function PrintOPCard() {
            var chkprintOP = document.getElementById('<%= chkboxPrintOPCard.ClientID %>').checked;
            if (chkprintOP) {

                var patDetail = new Array();
                patDetail = document.getElementById('<%= hdnOPCardDetail.ClientID %>').value.split('~');
                document.getElementById('<%= printANCCS.ClientID %>').style.display = 'block';
                popupprintOPCard()
                document.getElementById('<%= chkboxPrintOPCard.ClientID %>').checked = false;

            }

        }
        function popupprintOPCard() {
            var prtContent = document.getElementById('<%= printANCCS.ClientID %>');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            document.getElementById('<%= printANCCS.ClientID %>').style.display = 'none';
        }

    </script>

    <script type="text/javascript" language="javascript">
        function setDiscount() {
            var pDiscon = ToInternalFormat($("#ddDiscountPercent"));
            if ((pDiscon) == '0') {
                document.getElementById('txtDiscount').value = parseFloat(0).toFixed(2);
                document.getElementById('txtDiscount').readOnly = false;
                document.getElementById('txtDiscountPercent').style.display = 'None';

            }
            else if ((pDiscon) == '0') {
                document.getElementById('txtDiscount').value = parseFloat(0).toFixed(2);

            }

            else {
                document.getElementById('txtDiscountPercent').style.display = 'None';

            }
            ClearPaymentControlEvents();
            ClearOtherCurrValues("OtherCurrencyDisplay1");
            ClearOtherCurrValues("OtherCurrencyDisplay2");
            ClearOtherCurrValues("OtherCurrencyDisplay3");
            var amtRec = ToInternalFormat($('#txtAmountRecieved'));
            if (amtRec != null) {
                document.getElementById('txtAmountRecieved').value = parseFloat(0).toFixed(2);
                ToTargetFormat($('#txtAmountRecieved'));

            }
            var amtExRec = ToInternalFormat($('#txtExcess'));
            if (amtExRec != null) {
                document.getElementById('txtExcess').value = parseFloat(0).toFixed(2);
                ToTargetFormat($('#txtExcess'));
            }
            document.getElementById('<%= txtGrandTotal.ClientID %>').value = '';

            CorrectTotal();
            ChangeFormat();
            ValidateDiscountReason();
        }


        function funPerphy(source, eventArgs) {
            var txtphyname = eventArgs.get_text();
            var txtPhyID = eventArgs.get_value();
            document.getElementById("txtperphy").value = txtphyname;
            document.getElementById("hdnperphyID").value = txtPhyID;
        }

        function boxExpand(me) {
            // alert(me);
            boxValue = me.value.length;
            // alert(boxValue);
            boxSize = me.size;
            minNum = 20;
            maxNum = 500;


            if (boxValue > minNum) {
                me.size = boxValue
            }
            else
                if (boxValue < minNum || boxValue != minNnum) {
                me.size = minNum
            }
        }


        function getpaymenttype() {
            var vtype = document.getElementById('<%= hdnOPIP.ClientID %>').value;
            var obj = document.getElementById('<%=hdnvisittypenew.ClientID %>');
            var tblstart = "<table>";
            var trstart = "<tr>";
            var tdstart = "<td>";
            var tdend = "</tr>";
            var trend = "</tr>";
            var tblboby = "";




        }



        function pageLoad() {

            $find('AutoCompleteExtender3')._onMethodComplete = function(result, context) {

                $find('AutoCompleteExtender3')._update(context, result, /* cacheResults */false);

                webservice_callback(result, context);



            };
            $find('AutoCompleteExtender4')._onMethodComplete = function(result, context) {

                $find('AutoCompleteExtender4')._update(context, result, /* cacheResults */false);


            };

            $find('ucAmb_AutoCompleteExtenderDriverName')._onMethodComplete = function(result, context) {

                $find('ucAmb_AutoCompleteExtenderDriverName')._update(context, result, /* cacheResults */false);


            };

            $find('ucAmb_AutoCompleteExtenderAmbulanceNo')._onMethodComplete = function(result, context) {

                $find('ucAmb_AutoCompleteExtenderAmbulanceNo')._update(context, result, /* cacheResults */false);


            };

            $find('ucAmb_AutoCompleteExtenderLocationID')._onMethodComplete = function(result, context) {

                $find('ucAmb_AutoCompleteExtenderLocationID')._update(context, result, /* cacheResults */false);


            };
        }
        function webservice_callback(result, context) {

            if (result == "") {
                document.getElementById('alert').innerHTML = 'One or more items does not seem to be selected from the predefined list. This may not get rightly reflected in the reports.';

            }
            else {
                document.getElementById('alert').innerHTML = "";

            }



        }


        function changelabel() {

            var radio = document.getElementsByName('<%= rblFeeTypes.ClientID %>');


            for (var j = 0; j < radio.length; j++) {
                if (radio[j].checked) {
                    if (radio[j].defaultValue == "CON") {
                        // alert("one");
                        document.getElementById('Rs_Description').style.display = 'none'
                        document.getElementById('Rs_DoctorName').style.display = 'block'
                        document.getElementById('Rs_ItemName').style.display = 'none'
                    }

                    else {
                        // alert("two");
                        document.getElementById('Rs_Description').style.display = 'none'
                        document.getElementById('Rs_DoctorName').style.display = 'none'
                        document.getElementById('Rs_ItemName').style.display = 'block'
                    }

                    if (radio[j].defaultValue == "GEN") {
                        if (document.getElementById('dspData_hdnAmbCode').value == '') {
                            document.getElementById('tdAmbulance').style.display = 'none';
                        }
                    }
                    else if (radio[j].defaultValue != "GEN") {
                        document.getElementById('dspData_hdnAmbCode').value = '';
                        document.getElementById('tdAmbulance').style.display = 'none';
                    }
                }

            }

        }



        function GetDiscountReasonlist() {
            var drploc = document.getElementById('DdlDiscountreason').options[document.getElementById('DdlDiscountreason').selectedIndex].value;
            var options = document.getElementById('hdndiscountreason').value;
            var drpLocation = document.getElementById('<%= DdlDiscountreason.ClientID %>');


            var list = options.split('^');
            for (i = 0; i < list.length; i++) {
                if (list[i] != "") {
                    var res = list[i].split('~');
                    if (drploc == res[0]) {
                        document.getElementById('txtDiscountReason').value = res[2];

                    }



                }
            }


        }
        function chkShowMapped() {
            document.getElementById('<%= txtName.ClientID %>').value = "";
        }
        function ShowNHideBtn() {
            if (document.getElementById('ChkIsAddedtoServices').checked == true) {
                document.getElementById('divServices').style.display = 'block';
                document.getElementById('tbIP').style.display = 'none';
            }
            else {
                document.getElementById('divServices').style.display = 'none';
                document.getElementById('tbIP').style.display = 'block';
            }
        }
        function resetSurgeryPkg() {
            document.getElementById('ChkIsAddedtoServices').checked = false;
            document.getElementById('tdIsAddedtoServices').style.display = 'none';
            document.getElementById('divServices').style.display = 'none';
        }
        function CheckIsmapped() {
            document.getElementById('ChkMapped').checked = true;
        }
        function ResetIsmapped() {
            document.getElementById('ChkMapped').checked = false;
        }
        function SelectedTest(source, eventArgs) {
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        //document.getElementById('lblInvType').innerHTML = list[2];
                    }
                }
            }
        }

        function Delete_AMBULANCEDETAILS(AMBCODE) {
            var ambvalue = document.getElementById('<%= hdnAmbulanceDetails.ClientID %>').value;

            var arrayChildData = new Array();

            arrayChildData = ambvalue.split('^');

            var Firstvalue = new Array();

            Firstvalue = arrayChildData[0].split('$');

            var lsFinalValue = '';

            if (Firstvalue[7] == AMBCODE && arrayChildData[1] == null) {
                lsFinalValue = '';
            }
            else if (Firstvalue[7] == AMBCODE && arrayChildData[1] != null) {
                lsFinalValue = arrayChildData[1] + '^';
            }

            else if (arrayChildData[1] != null) {
                var Secondvalue = new Array();

                Secondvalue = arrayChildData[1].split('$');

                if (Secondvalue[7] == AMBCODE) {
                    lsFinalValue = arrayChildData[0] + '^';
                }
            }


            document.getElementById('<%= hdnAmbulanceDetails.ClientID %>').value = lsFinalValue;

        }
        function setFeeTypeForVisit(objVisitType) {
            $('#<%=rblFeeTypes.ClientID%>').empty();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../OPIPBilling.asmx/GetFeeType",
                data: JSON.stringify({ orgID: '<%= OrgID %>', visitType: objVisitType }),
                dataType: "json",
                success: function(data, value) {
                    var GetData = data.d;
                    var temp = '<tr>'
                    $.each(GetData, function(index, Item) {
                        if (index == 0) {
                            temp += '<td><input type="radio" name="rblFeeTypes" checked="checked" value=' + Item.FeeType + '  id=rblFeeTypes_' + index + '><label>' + Item.FeeTypeDesc + '</label></td>';
                            document.getElementById('hdnFeeType1').value = Item.FeeType;
                        }
                        else
                            temp += '<td><input type="radio" name="rblFeeTypes" value=' + Item.FeeType + '  id=rblFeeTypes_' + index + '><label>' + Item.FeeTypeDesc + '</label></td>';
                    });
                    temp += '</tr>'
                    $('#<%=rblFeeTypes.ClientID%>').append(temp);
                    //                    SetVisitTypeProsAfterFeeTypeSet(objVisitType);
                },
                error: function(result) {
                    alert("Error");
                }
            });
        }
      
    </script>

    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script src="../Scripts/Format_Currency/jquery-1.7.2.min.js" type="text/javascript"></script>

    <script src="../Scripts/Format_Currency/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>

    <script src="../Scripts/Format_Currency/jquery.formatCurrency.all.js" type="text/javascript"></script>

    <script>

        function ToInternalFormat(pControl) {
            // debugger;
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
            // debugger;
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

        function PrintOpCard() {
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,Addressbar=no');
            WinPrint.document.write($('#divGenerateVisit').html());
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }

        

    </script>
  <script type="text/javascript" language="javascript">

        function GetGeneralDetails() {
            var Discount = document.getElementById('txtDiscount').value;
            var NetAmount = document.getElementById('txtGrandTotal').value;
            var GeneralDetails = Discount + '~' + NetAmount;
            return GeneralDetails
        }
        function FunClosePopup(objAppr) {       
            document.getElementById('btnpopCancel').click();
            if (objAppr == "Approve") {
                PaymentTypeValidation();
            }
            else {
                PaymentControlclear();
            }
            return false;
        }

        function InsertBillpaymentDetails() {
            document.getElementById('addNewPayment1').click();
            AssignApprovalDetails();
            return false;
        }
    </script>
</body>
</html>
