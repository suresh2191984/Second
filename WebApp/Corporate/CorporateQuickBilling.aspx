<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CorporateQuickBilling.aspx.cs"
    Inherits="CorporateQuickBilling" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="patHeader" %>
<%@ Register Src="../CommonControls/CorporateDisplayTempData.ascx" TagName="DisplayAllData"
    TagPrefix="uc17" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="Topheader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/ConsultingName.ascx" TagName="consulting" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/QuickBillReferedPhysician.ascx" TagName="ReferedPhysician"
    TagPrefix="uc16" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register src="../CommonControls/IPClientTpaInsurance.ascx" tagname="IPClientTpaInsurance" tagprefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Patient Order Entry</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        function GetRefPhysicianDetails(pType) {
            var refType = "";
            var refID = 0
            var refName = "";
            var tRes = refType + "~" + refID + "~" + refName;
            var pVal = document.getElementById(pType + "_hdnPhysicianValue").value.split("~");

            if (pVal.length == 3) {
                refType = pVal[0];
                refID = pVal[1];
                refName = pVal[2];
                tRes = refType + "~" + refID + "~" + refName;
            }
            return tRes;
        }

        function collapseDropDownList(elementRef) {
            elementRef.style.width = elementRef.normalWidth;
        }
        function expandDropDownList(elementRef) {
            elementRef.style.width = '450px';
        }
        function FnIsvalid(obj) {
            if (obj = 1) {
                alert("Service(s) Ordered Successfully");
                document.getElementById('btnCancel').click();
                 
            }
            else {
                alert("The service(s) have been Faild.");
                return false;
            }
           
        }
        
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scrpt" runat="server">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
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
                <uc3:Header ID="userHeader" runat="server" />
                <%--<uc8:PatientHeader ID="PatientHeader" runat="server" />--%>
                <%--<patHeader:PatientHeader ID="PatientHeader" runat="server" />--%>
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
                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" />
                                            <br />
                                            <br />
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <table class="biltb" width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr id="divMakeBill" runat="server">
                                        <td id="Td1" runat="server">
                                            <div>
                                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td colspan="3">
                                                            <table class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                                <tr>
                                                                    <td>
                                                                        <uc16:ReferedPhysician ReferringType="Referring Physician : " ID="ReferDoctor1" runat="server" />
                                                                        <div id="dvH" runat="server" style="display: none;">
                                                                            <asp:Label ID="lblreferHos" Text="Referring Hospital" Font-Bold="True" runat="server" />
                                                                            <asp:DropDownList ID="ddlHospital" ToolTip="Select Referring Hospital" runat="server"
                                                                                TabIndex="25" Width="250px" OnSelectedIndexChanged="ddlHospital_SelectedIndexChanged"
                                                                                normalWidth="250px" onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);">
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <br />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label Font-Bold="true" ID="RS_VisitPurpose" runat="server" Text="Visit Purpose:"
                                                                            meta:resourcekey="RS_VisitPurposeResource1"></asp:Label>
                                                                        <asp:DropDownList ID="dPurpose" CssClass="ddlsmall" ToolTip="Click here to select Visit Purpose"
                                                                            runat="server" meta:resourcekey="dPurposeResource1" onchange="fnChangeType()">
                                                                        </asp:DropDownList>
                                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <br />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label runat="server" Text="Select Type" Font-Bold="true"></asp:Label>
                                                                        <table>
                                                                            <tr>
                                                                                <td id="tdMapped" style="display:none" runat="server">
                                                                                 <asp:CheckBox ID="ChkMapped" Text="Show Only Mapped Items" class="btn" Checked="false" TextAlign="Right" runat="server" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                        
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2" valign="top">
                                                                        <asp:RadioButtonList ID="rblFeeTypes" runat="server" RepeatDirection="Horizontal"
                                                                            RepeatColumns="8" onClick="Javascript:AllowIsMapped();chkPros();resetpreviousradiodetails();">
                                                                        </asp:RadioButtonList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="display:none;">
                                                                     
                                                                        <uc2:IPClientTpaInsurance ID="IPClientTpaInsurance1" runat="server" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2" class="dataheaderInvCtrl" style="width: 80%;">
                                                                        <table width="80%" border="0" cellpadding="0" cellspacing="0" align="center">
                                                                            <tr>
                                                                                <td id="trDescription" style="display: block" runat="server">
                                                                                    <asp:Label ID="Rs_Description" Text="Description" runat="server" />
                                                                                </td>
                                                                                <td id="trProcedureItem" style="display: none" runat="server">
                                                                                    <asp:Label ID="Rs_Procedure" Text="Enter Procedure Name" runat="server" />
                                                                                </td>
                                                                                <td id="trDocrName" style="display: none" runat="server">
                                                                                    <asp:Label ID="lblSpeciality" runat="server" Text="Speciality"></asp:Label>&nbsp;&nbsp;
                                                                                    <asp:DropDownList ID="ddlSpeciality" CssClass="ddlsmall" runat="server" onclick="selSpeciality();">
                                                                                    </asp:DropDownList>
                                                                                    <asp:Label ID="Rs_DoctorName" Text="Doctor Name" runat="server" />
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox CssClass="Txtboxmedium" ID="txtName" onfocus="chkPros();" Width="280px"
                                                                                        runat="server" TabIndex="25" ReadOnly="true"></asp:TextBox>
                                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtName"
                                                                                        EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                                                        OnClientItemSelected="IAmSelected" CompletionListCssClass="wordWheel listMain .box"
                                                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                        ServiceMethod="GetQuickBillItems" ServicePath="~/OPIPBilling.asmx" UseContextKey="True"
                                                                                        DelimiterCharacters="" Enabled="True">
                                                                                    </ajc:AutoCompleteExtender>
                                                                                    <td style="display: none">
                                                                                        <asp:Label ID="Rs_PerformingPhysicianName" Text="PerformingPhysicianName" runat="server" />
                                                                                    </td>
                                                                                    <td style="display: none">
                                                                                        <asp:TextBox CssClass="Txtboxsmall" ID="txtperphy" onfocus="chkPros();" Width="150px"
                                                                                            runat="server" TabIndex="26"></asp:TextBox>
                                                                                    </td>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:Label ID="Rs_Quantity" Text="Quantity" runat="server" />
                                                                                </td>
                                                                                <td>
                                                                                    <asp:TextBox CssClass="Txtboxverysmall" MaxLength="3"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                                                        ReadOnly="true" ID="txtQty" Width="25px" Style="text-align: right;" runat="server"
                                                                                        Text="1" TabIndex="27"></asp:TextBox>
                                                                                </td>
                                                                                <td runat="server" style="display: none">
                                                                                    <asp:Label ID="Rs_Amount" Text="Amount" runat="server" />
                                                                                </td>
                                                                                <td runat="server" style="display: none">
                                                                                    <asp:TextBox CssClass="Txtboxsmall"  onkeypress="return ValidateOnlyNumeric(this);"  ID="txtAmount"
                                                                                        Width="60px" Style="text-align: right;" runat="server" Text="0" TabIndex="28"></asp:TextBox>
                                                                                </td>
                                                                                <td runat="server" style="display: none">
                                                                                    <asp:Label ID="Rs_Date" Text="Date" runat="server" />
                                                                                </td>
                                                                                <td nowrap="nowrap" runat="server" style="display: none">
                                                                                    <asp:TextBox CssClass="Txtboxsmall" ID="txtDate" Width="105px" Style="text-align: right;"
                                                                                        runat="server" TabIndex="29"></asp:TextBox>
                                                                                    <a id="ahrImgBtn" href="javascript:NewCal('txtDate','ddmmyyyy',true,12);">
                                                                                        <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date" /></a>
                                                                                    <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                                        CausesValidation="False" Style="display: none;" />
                                                                                </td>
                                                                                <td runat="server" style="display: none">
                                                                                    <asp:CheckBox CssClass="bilddltb" ID="chkIsRI" runat="server" Text="Is Reimbursable"
                                                                                        Checked="False" TabIndex="30" />
                                                                                </td>
                                                                                <td>
                                                                                    <input type="button" id="btnAdd" onclick="addItems();" style="width: 70px;" class="btn"
                                                                                        value="Add" tabindex="31" />
                                                                                </td>
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
                                                                        <asp:HiddenField ID="hdnSpecality" runat="server" />
                                                                        <asp:HiddenField ID="hdnVisitPurpose" runat="server" />
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
                                                        <td align="center">
                                                            <asp:Button Text="Submit" ID="btnSubmit" runat="server" CssClass="btn" OnClientClick="return QulickItemValue();"
                                                                OnClick="btnSubmit_Click" />
                                                            &nbsp;
                                                            <asp:Button Text="Cancel" runat="server" ID="btnCancel" CssClass="btn" OnClick="btnCancel_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <asp:HiddenField ID="hdnDiscountArray" runat="server" />
                                <asp:HiddenField ID="hdnDefaultRoundoff" Value="0" runat="server" />
                                <asp:HiddenField ID="hdnRoundOffType" runat="server" />
                                <input id="hdnSelectOnOption" type="hidden" runat="server" />
                                <asp:HiddenField ID="hdnFeeType1" runat="server" Value="Con" />
                                <asp:HiddenField ID="hdnFeeTypeSelected" runat="server" Value="OTH" />
                                <input id="hdnRecievedAmount" runat="server" type="hidden" />
                                <input id="hdnCurrentDue" runat="server" type="hidden"></input>
                                <input id="hdnGrandTotal" runat="server" type="hidden"></input>
                                <input id="hdnDeduction" runat="server" type="hidden"></input>
                                <input id="hdnCorporateDiscount" runat="server" type="hidden"></input>
                                <input id="hdnRateID" runat="server" type="hidden"></input>
                                <input id="hdnTPAID" runat="server" type="hidden"></input>
                                <input id="hdnClientID" runat="server" type="hidden"></input>
                                <input id="hdnPreAuthAmount" runat="server" type="hidden" value="0.00"></input>
                                <input id="hdnBookedSlots" runat="server" type="hidden"></input>
                                <input id="hdnOtherAmountReceived" runat="server" type="hidden" value="0"></input>
                                <input id="hdnOtherAmountPayble" runat="server" type="hidden" value="0"></input>
                                <input id="hdnNonReimburseAmt" runat="server" type="hidden" value="0.00"></input>
                                <input id="hdnDepositUsed" runat="server" type="hidden" value="0.00"></input>
                                <input id="hdnAdmissionDate" runat="server" type="hidden" value="01/01/1900"> </input>
                                <input id="hdnVisitType" runat="server" type="hidden" value="OP"> </input>
                                <asp:HiddenField ID="hdnFreeTextAllow" runat="server" Value="0" />
                                <asp:HiddenField ID="hdnFreeTextDescription" runat="server" />
                                <asp:HiddenField ID="hdnIsOrgNeedINVFreeText" runat="server" />
                                <asp:HiddenField ID="hdnRefPhy" runat="server" />
                                <asp:HiddenField ID="hdnOrgCreditLimt" runat="server" Value="N" />
                                <asp:HiddenField ID="hdnPatientID" runat="server" />
                                <asp:HiddenField ID="hdnStatus" runat="server" Value="1" />
                                <div id="printANCCS" runat="server" align="center" style="display: none;">
                                    <input id="hdnResetAll" runat="server" type="hidden" value="N"></input>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>

    <script type="text/javascript">
        function selSpeciality() {

            var SplityCMD = document.getElementById('<%= hdnSpecality.ClientID %>').value.split('^');
            var drpSpeciality1 = document.getElementById('<%= ddlSpeciality.ClientID %>').value;
            var drpSpeciality = document.getElementById('<%= ddlSpeciality.ClientID %>');

            //---------------------------------Specaility Dropdown 1~gen:rs(100)
            for (var i = 0; i < SplityCMD.length - 1; i++) {
                var SplityID = SplityCMD[i].split('~');
                if (SplityID[0] == drpSpeciality1) {
                    var SplityString = SplityID[1];
                    var split1 = SplityID[1].split(':');
                    var speName = split1[0];
                    var SPeAM = split1[1];
                    var SPaA = SPeAM.split('Rs-');
                    var SPeAMt = SPaA[1];
                    document.getElementById('txtName').value = speName;
                    var amount = SPeAMt;
                    var id = SplityID[0];
                    document.getElementById('txtAmount').value = amount;
                    document.getElementById('hdnID').value = id;
                    document.getElementById('hdnFeeTypeSelected').value = 'SPE';
                }
            }

            if (document.getElementById('<%= ddlSpeciality.ClientID %>').value == '-----Select-----') {
                document.getElementById('<%= txtName.ClientID %>').readOnly = false;
                document.getElementById('<%= txtName.ClientID %>').value = '';
            }
            else {
                document.getElementById('<%= txtName.ClientID %>').readOnly = true;
            }
            // ---------------------------------------------------------
            //var speName = drpSpeciality.options[drpSpeciality.selectedIndex].text.split('<%= CurrencyName %>')[0].split('-')[0];
            //var SPeAMt = drpSpeciality.options[drpSpeciality.selectedIndex].text.split('<%= CurrencyName %>')[1].split('-')[1];

            //            if (phyName == "--Select--") {

            //                CmdAddBillItemsType_onclick('SPE', 0, drpSpeciality.value, speName, 1, SPeAMt, SPeAMt);
            //            }
            //            else {
            //                var amtVal = phyName.split('<%= CurrencyName %>')[1].split('-')[1];
            //                CmdAddBillItemsType_onclick('CON', drpSlots.value, drpSpeciality.value, phyName.split('<%=CurrencyName %>')[0].split(':')[0], 1, amtVal, amtVal);
            //            }
        }
        function resetpreviousradiodetails() {
            document.getElementById('<%= txtQty.ClientID %>').value = 1;
            document.getElementById('<%= txtName.ClientID %>').value = "";
            document.getElementById('<%= txtAmount.ClientID %>').value = "0";
            document.getElementById('<%= hdnPhyLID.ClientID %>').value = "";
            document.getElementById('<%= hdnSID.ClientID %>').value = "";
            document.getElementById('hdnID').value = "-1";
            document.getElementById('<%= txtperphy.ClientID %>').value = "";

        }
        function AllowIsMapped() {
            var radio = document.getElementsByName('<%= rblFeeTypes.ClientID %>');
            var dpurpose = document.getElementById('<%= dPurpose.ClientID %>');
            for (var ii = 0; ii < radio.length; ii++) {
                if (radio[ii].checked) {
                    document.getElementById('<%= hdnFeeType1.ClientID %>').value = (radio[ii].value);
                    if (document.getElementById('hdnID').value == "-1") {
                        document.getElementById('hdnFeeTypeSelected').value = radio[ii].value == "LAB" ? "INV" : radio[ii].value;
                    }
                }
            }
            if ('CON' == document.getElementById('<%= hdnFeeType1.ClientID %>').value) {
                document.getElementById('<%=ChkMapped.ClientID %>').checked = false; 
                document.getElementById('<%= txtName.ClientID %>').readOnly = false;
                document.getElementById('<%=tdMapped.ClientID %>').style.display = "none";
            }
            else if ('LAB' == document.getElementById('<%= hdnFeeType1.ClientID %>').value) {
                document.getElementById('<%=ChkMapped.ClientID %>').checked = true;
                document.getElementById('<%= txtName.ClientID %>').readOnly = false;
                document.getElementById('<%=tdMapped.ClientID %>').style.display = "block";
            }
            else if ('PRO' == document.getElementById('<%= hdnFeeType1.ClientID %>').value) {
                document.getElementById('<%=ChkMapped.ClientID %>').checked = false;
                document.getElementById('<%= txtName.ClientID %>').readOnly = false;
                document.getElementById('<%=tdMapped.ClientID %>').style.display = "none";
            }
            else if ('PKG' == document.getElementById('<%= hdnFeeType1.ClientID %>').value) {
                document.getElementById('<%=ChkMapped.ClientID %>').checked = false;
                document.getElementById('<%= txtName.ClientID %>').readOnly = false;
                document.getElementById('<%=tdMapped.ClientID %>').style.display = "none";
            }
            else {
                document.getElementById('<%=ChkMapped.ClientID %>').checked = false;
                document.getElementById('<%= txtName.ClientID %>').readOnly = false;
                document.getElementById('<%=tdMapped.ClientID %>').style.display = "none";
            }
        }

        function chkPros() {            
            //ddlSpeciality
            var radio = document.getElementsByName('<%= rblFeeTypes.ClientID %>');            
            var dpurpose = document.getElementById('<%= dPurpose.ClientID %>');  
            for (var ii = 0; ii < radio.length; ii++) {
                if (radio[ii].checked) {
                    document.getElementById('<%= hdnFeeType1.ClientID %>').value = (radio[ii].value);
                    if (document.getElementById('hdnID').value == "-1") {
                        document.getElementById('hdnFeeTypeSelected').value = radio[ii].value == "LAB" ? "INV" : radio[ii].value;
                    }
                }
            }
            if ('CON' == document.getElementById('<%= hdnFeeType1.ClientID %>').value) {
                document.getElementById('<%=trDescription.ClientID %>').style.display = "none";
                document.getElementById('<%=trProcedureItem.ClientID %>').style.display = "none";
                document.getElementById('<%=trDocrName.ClientID %>').style.display = "block";
                document.getElementById('<%= txtName.ClientID %>').readOnly = false;
                document.getElementById('<%= txtQty.ClientID %>').readOnly = true;
                dpurpose.selectedIndex = 0;
            }
            else if ('LAB' == document.getElementById('<%= hdnFeeType1.ClientID %>').value) {
                document.getElementById('<%=trProcedureItem.ClientID %>').style.display = "none";
                document.getElementById('<%=trDescription.ClientID %>').style.display = "block";
                document.getElementById('<%=trDocrName.ClientID %>').style.display = "none";
                document.getElementById('<%= txtName.ClientID %>').readOnly = false;
                document.getElementById('<%= txtQty.ClientID %>').readOnly = true;
                dpurpose.selectedIndex = 1;
            }
            else if ('PRO' == document.getElementById('<%= hdnFeeType1.ClientID %>').value) {
                document.getElementById('<%=trProcedureItem.ClientID %>').style.display = "block";
                document.getElementById('<%=trDescription.ClientID %>').style.display = "none";
                document.getElementById('<%=trDocrName.ClientID %>').style.display = "none";
                document.getElementById('<%= txtName.ClientID %>').readOnly = false;
                document.getElementById('<%= txtQty.ClientID %>').readOnly = false;
                dpurpose.selectedIndex = 3;
            }
            else if ('PKG' == document.getElementById('<%= hdnFeeType1.ClientID %>').value) {
                document.getElementById('<%=trProcedureItem.ClientID %>').style.display = "block";
                document.getElementById('<%=trDescription.ClientID %>').style.display = "none";
                document.getElementById('<%=trDocrName.ClientID %>').style.display = "none";
                document.getElementById('<%= txtName.ClientID %>').readOnly = false;
                document.getElementById('<%= txtQty.ClientID %>').readOnly = false;
                dpurpose.selectedIndex = 4;
            }
            else {
                dpurpose.selectedIndex = 0;
            }
            var IsMapped;
            if (document.getElementById('ChkMapped').checked == true) {
                IsMapped = 'Y';
            }
            else {
                IsMapped = 'N';
            }
            var orgID = '<%= OrgID %>';
            var sval = document.getElementById('<%= hdnFeeType1.ClientID %>').value;
            var sRateID = document.getElementById('<%= hdnRateID.ClientID %>').value;
            var pvalue = document.getElementById('<%= hdnOPIP.ClientID %>').value;
            qs();
            var pVisitID = qsParm['VID'];
            var BillPage = "HOS";
            sval = sval + '~' + orgID + '~' + sRateID + '~' + pvalue + '~' + pVisitID + '~' + IsMapped + '~' + BillPage;
            $find('AutoCompleteExtender3').set_contextKey(sval);
        }

        var qsParm = new Array();
        function qs() {
            var query = window.location.search.substring(1);
            var parms = query.split('&');
            for (var i = 0; i < parms.length; i++) {
                var pos = parms[i].indexOf('=');
                if (pos > 0) {
                    var key = parms[i].substring(0, pos);
                    var val = parms[i].substring(pos + 1);
                    qsParm[key] = val;
                }
            }
        } 
        
    </script>

    <script language="javascript" type="text/javascript">

        function IAmSelected(source, eventArgs) {
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
                        document.getElementById('txtAmount').value = amount;

                        document.getElementById('hdnFeeTypeSelected').value = feeType;
                        document.getElementById('hdnName').value = name;
                        document.getElementById('hdnAmt').value = amount;
                        document.getElementById('hdnID').value = phyFeeId;
                        document.getElementById('hdnPhyLID').value = physicianLID;
                        document.getElementById('hdnSID').value = specialityID;
                        document.getElementById('hdnDisorEnhpercent').value = DisorEnhpercent;
                        document.getElementById('hdnDisorEnhType').value = DisorEnhType;
                        document.getElementById('hdnRemarks').value = Remarks;

                        if (isReimursable == 'Y') {
                            document.getElementById('chkIsRI').checked = true;
                        }
                        else {
                            document.getElementById('chkIsRI').checked = false;
                        }
                    }
                }
            }
            else {
                document.getElementById('hdnFeeID').value = -1;
                document.getElementById('hdnFeeTypeSelected').value = "OTH";
            }
            if (event.keyCode == 13)
                document.getElementById('<%= txtQty.ClientID %>').focus();
        }

        function addItems() {
            if (document.getElementById('<%= txtName.ClientID %>').value == "") {
                alert('Please Enter an Order')
                document.getElementById('<%= txtName.ClientID %>').focus();
                return false;
            }
            else if (document.getElementById('<%= txtQty.ClientID %>').value == "") {
                alert('Provide the quantity')
                document.getElementById('<%= txtQty.ClientID %>').focus();
                return false;
            }
            else {
                var feeType = document.getElementById('hdnFeeTypeSelected').value;
                var id = document.getElementById('hdnID').value;
                var OrgID = '<%= OrgID%>';
                var PatientID = document.getElementById('hdnPatientID').value;
                if (id != -1) {
                    if (feeType == "PRO") {
                        OPIPBilling.GetProcedureStatus(OrgID, PatientID, id, Duelist);
                    }
                    else {
                        addDetails();
                    }
                }
            }
        }
        function addDetails() {
            var feeType = document.getElementById('hdnFeeTypeSelected').value;
            var itemDesc = document.getElementById('txtName').value;
            var amt = document.getElementById('txtAmount').value;
            var id = document.getElementById('hdnID').value;
            var phyLID = document.getElementById('hdnPhyLID').value;
            var sID = document.getElementById('hdnSID').value;
            var Perphysicianname = document.getElementById('txtperphy').value;
            var PerphysicianId = document.getElementById('hdnperphyID').value;
            var DisorEnhpercent = document.getElementById('hdnDisorEnhpercent').value;
            var DisorEnhType = document.getElementById('hdnDisorEnhType').value;
            var Remarks = document.getElementById('hdnRemarks').value;

            var tQty = document.getElementById('<%= txtQty.ClientID %>');
            var itemQty = tQty.value;
            var total = amt * itemQty;
            sID = sID + '>' + phyLID;
            var DTime = document.getElementById('txtDate').value;
            if (id != -1) {
                if (document.getElementById('chkIsRI').checked) {

                    var IsRI = "Yes";

                }
                else {

                    var IsRI = "No";
                }

                CmdAddBillItemsType_onclick(feeType, id, sID, itemDesc, Perphysicianname, PerphysicianId, itemQty, amt, total, DTime, IsRI, DisorEnhpercent, DisorEnhType, Remarks);

                ClearItemsInControl();
            }
        }




        function Duelist(tmpVal) {
            if (tmpVal == 'Open') {
                var ans = confirm("Procedure already in progress. Are you sure to continue?");
                if (ans == true) {
                    document.getElementById('hdnStatus').value = 1;                    
                    addDetails();
                }
                else {
                    document.getElementById('hdnStatus').value = 0;
                    document.getElementById('<%= txtQty.ClientID %>').value = "1";
                    document.getElementById('<%= txtName.ClientID %>').value = "";
                    document.getElementById('<%= txtName.ClientID %>').focus();
                }
            }
            else {
                document.getElementById('hdnStatus').value = 0;
                addDetails();
            }

        }
        function ClearItemsInControl() {
            document.getElementById('<%= txtQty.ClientID %>').value = 1;
            document.getElementById('<%= txtName.ClientID %>').value = "";
            document.getElementById('<%= txtAmount.ClientID %>').value = "0";
            document.getElementById('<%= txtName.ClientID %>').value = "";
            document.getElementById('<%= hdnPhyLID.ClientID %>').value = "";
            document.getElementById('<%= hdnSID.ClientID %>').value = "";
            document.getElementById('hdnID').value = "-1";
            document.getElementById('<%= txtperphy.ClientID %>').value = "";

            var radio = document.getElementsByName('<%= rblFeeTypes.ClientID %>');
            for (var ii = 0; ii < radio.length; ii++) {
                if (radio[ii].checked) {
                    document.getElementById('hdnFeeTypeSelected').value = radio[ii].value == "LAB" ? "INV" : radio[ii].value;
                }
            }
        }
        function QulickItemValue() {
            if (document.getElementById('dspData_hdfBillType1').value == '') {
                alert('Provide the Order')
                return false;
            }
        }
        function fnChangeType() {
            var vtype = -1;
            var dpurpose = document.getElementById('<%= dPurpose.ClientID %>');
            if (dpurpose.selectedIndex > -1) {
                vtype = dpurpose.options[dpurpose.selectedIndex].value;
            }            
            if (vtype == 1) {
                selectRadio("CON");
            }
            else if (vtype == 3) {
                selectRadio("LAB");
            }
            else {
                selectRadio("PRO");
            }
        }
        function selectRadio(feeType) {
            var radio = document.getElementsByName('<%= rblFeeTypes.ClientID %>');
            for (var i = 0; i < radio.length; i++) {
                if (radio[i].value == feeType) {
                    radio[i].checked = true;
                    chkPros();                    
                }
            }
        }      
        
    </script>

    </form>
</body>
</html>
