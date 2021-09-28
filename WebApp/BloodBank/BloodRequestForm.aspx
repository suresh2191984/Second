<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BloodRequestForm.aspx.cs"
    Inherits="BloodBank_BloodRequestForm" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Department.ascx" TagName="Department" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Blood Or Blood Components Request</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>

    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <script language="javascript" type="text/javascript">
        function onClickAddComponent() {
            var hiddenfield;
            var table;
            var txtComponent;
            var txtUnits;
            hiddenfield = 'hdnComponents';
            table = 'tblComponents';
            txtComponent = 'ddlBloodComponent';
            txtUnits = 'txtNoOfUnits';
            var rwNumber = parseInt(110);
            var AddStatus = 0;
            var txtComponentName = document.getElementById(txtComponent).options[document.getElementById(txtComponent).selectedIndex].text;
            var txtComponentValue = document.getElementById(txtComponent).options[document.getElementById(txtComponent).selectedIndex].value;
            var txtUnitsValue = document.getElementById(txtUnits).value;
            var ProductID = document.getElementById('hdnProductID').value;
            var ProductName = document.getElementById('hdnProductName').value;
            document.getElementById(table).style.display = 'block';
            var HidValue = document.getElementById(hiddenfield).value;
            var list = HidValue.split('^');
            if (document.getElementById(hiddenfield).value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HistoryList = list[count].split('~');
                    if (HistoryList[1] != '') {
                        if (HistoryList[0] != '') {
                            rwNumber = parseInt(parseInt(HistoryList[0]) + parseInt(1));
                        }
                        if (txtComponentName != '') {
                            if (HistoryList[1] == txtComponentName) {
                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                if (txtComponentName != '') {
                    var row = document.getElementById(table).insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComponent(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = ProductName;
                    cell3.innerHTML = txtUnitsValue;
                    document.getElementById(hiddenfield).value += parseInt(rwNumber) + "~" + txtComponentValue + "~" + txtUnitsValue + "~" + ProductID +"~"+ProductName+ "^";
                    AddStatus = 2;
                }
            }
            if (AddStatus == 0) {
                if (txtComponentName != '') {
                    var row = document.getElementById(table).insertRow(1);
                    row.id = parseInt(rwNumber);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComponent(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = ProductName;
                    cell3.innerHTML = txtUnitsValue;
                    document.getElementById(hiddenfield).value += parseInt(rwNumber) + "~" + txtComponentValue + "~" + txtUnitsValue + "~" + ProductID +"~"+ProductName+ "^";
                }
            }
            else if (AddStatus == 1) {
                alert("Component Already Added!");
            }
            document.getElementById(txtComponent).value = '';
            document.getElementById(txtUnits).value = '';
            document.getElementById('txtBloodComponentName').value = '';
            return false;
        }
        function ImgOnclickComponent(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnComponents').value;
            var list = HidValue.split('^');
            var newHistoryList = '';
            if (document.getElementById('hdnComponents').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HistoryList = list[count].split('~');
                    if (HistoryList[0] != '') {
                        if (HistoryList[0] != ImgID) {
                            newHistoryList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnComponents').value = newHistoryList;
            }
            if (document.getElementById('hdnComponents').value == '') {
                document.getElementById('tblComponents').style.display = 'none';
            }
        }
        function checkDate1(obj) {

            var myValStr = document.getElementById(obj).value;

            if (myValStr != "__/____" && myValStr != "") {
                var Mon = myValStr.split('/')[0];
                var pyyyy = myValStr.split('/')[1];
                var isTrue = false;
                var myMonth = new Array('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12');
                for (i = 0; i < myMonth.length; i++) {
                    if (myMonth[i] != "" && Mon != "" && Mon == myMonth[i] && Mon.length == 2) {
                        isTrue = true;
                    }
                }
                if (!isTrue) {
                    document.getElementById(obj).focus();
                    alert("Provide valid date");
                    return isTrue;
                }
                var pdate = Mon + pyyyy;
                var pdatelen = pdate.length;
                for (j = 0; j < pdatelen; j++) {
                    if (pdate.charAt(j) == "_") {
                        document.getElementById(obj).focus();
                        alert("Provide valid date");
                        return false;
                    }
                }
            }
        }
        function showdiv1() {
            document.getElementById("divChkList").style.display = "block";
        }
        function showdivonClick1() {
            var objDLL = document.getElementById("divChkList");
            if (objDLL.style.display == "block")
                objDLL.style.display = "none";
            else
                objDLL.style.display = "block";
        }
        function getSelectedItem1(lstValue, lstNo, lstID, ctrlType) {
            var noItemChecked = 0;
            var ddlReport = document.getElementById("ddlChkList");
            var selectedItems = "";
            var arr = document.getElementById("chkLstItem").getElementsByTagName('input');
            var arrlbl = document.getElementById("chkLstItem").getElementsByTagName('label');
            var objLstId = document.getElementById('hdnMethods');
            for (i = 0; i < arr.length; i++) {
                checkbox = arr[i];
                if (i == lstNo) {
                    if (ctrlType == 'anchor') {
                        if (!checkbox.checked) {
                            checkbox.checked = true;
                        }
                        else {
                            checkbox.checked = false;
                        }
                    }
                }
                if (checkbox.checked) {
                    if (selectedItems == "") {
                        selectedItems = arrlbl[i].innerText;
                    }
                    else {
                        selectedItems = selectedItems + "," + arrlbl[i].innerText;
                    }
                    noItemChecked = noItemChecked + 1;
                }
            }
            ddlReport.title = selectedItems;
            var Text = ddlReport.options[ddlReport.selectedIndex].text;
            if (noItemChecked == 1)
                ddlReport.options[ddlReport.selectedIndex].text = lstValue;
            else
                ddlReport.options[ddlReport.selectedIndex].text = noItemChecked + " Items";
            document.getElementById('hdnMethods').value = ddlReport.options[ddlReport.selectedIndex].text;
            document.getElementById('lblCrossMatchingMethod').innerText = selectedItems;
        }
      document.onclick = check1;
        function check1(e) {
            var target = (e && e.target) || (event && event.srcElement);
            var obj = document.getElementById('divChkList');
            var obj1 = document.getElementById('ddlChkList');
            if (target.id != "alst" && !target.id.match("chkLstItem")) {
                if (!(target == obj || target == obj1)) {
                    obj.style.display = 'none';
                }
                else if (target == obj || target == obj1 || target == obj2 || target == obj3 || target == obj4 || target == obj5 || target == obj6 || target == obj7) {
                    if (obj.style.display == 'block') {
                        obj.style.display = 'block';
                    }
                    else {
                        obj.style.display = 'none';
                        document.getElementById('ddlChkList').blur();
                    }
                }
            }
        }


        
    </script>

</head>
<body>
    <form id="frmBloodRequest" runat="server">
    <script type ="text/javascript" >

        function ddlBloodComponentChange() {
            var BloodComponentID = document.getElementById("ddlBloodComponent").options[document.getElementById("ddlBloodComponent").selectedIndex].value;
            document.getElementById('hdnBloodComponentID').value = BloodComponentID;
        }
        function setContextInfo() {

            var sval = "";
            //            var orgID = '<%=OrgID%>';
            sval = document.getElementById('hdnBloodComponentID').value;

            $find('AutoCompleteExtenderBloodComponent').set_contextKey(sval);
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

        function IAmSelected(source, eventArgs) {
          
            var varGetVal = eventArgs.get_value();
            //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            var ProductID;
            var Productname;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        ProductID = list[0];
                        Productname = list[1];

                        document.getElementById('hdnProductID').value = ProductID;
                        document.getElementById('hdnProductName').value = Productname;

                    }
                }
            }
        }   
    </script>
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
                    <table cellpadding="0" cellspacing="0" border="0">
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
                        <asp:Panel ID="pnlRequest" runat="server" GroupingText="Request for Blood/BloodComponent"
                            meta:resourcekey="pnlRequestResource1">
                            <table width="100%" style="font-size: small" cellpadding="1" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblPriority" Text="Request Priority" runat="server" Font-Bold="True"
                                            meta:resourcekey="lblPriorityResource1"></asp:Label>
                                        <asp:CheckBox ID="rdoUrgent" Text="Urgent" runat="server" meta:resourcekey="rdoUrgentResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblName" Text="Blood Recepient's Name :: " runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtName" runat="server" meta:resourcekey="txtNameResource1"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblAge" Text="Age :: " runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAge" autocomplete="off" CssClass="Txtboxsmall" Width="10%" runat="server"
                                            MaxLength="3" Style="text-align: justify" meta:resourcekey="txtAgeResource1" />
                                        <asp:DropDownList ID="ddlAge" runat="server" CssClass="ddl" meta:resourcekey="ddlAgeResource1">
                                        </asp:DropDownList>
                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblSex" runat="server" Text="Sex:" meta:resourcekey="lblSexResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlSex" runat="server" CssClass="ddl" meta:resourcekey="ddlSexResource1">
                                        </asp:DropDownList>
                                        &nbsp;
                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblBloodGrp" Text="Blood Group" runat="server" meta:resourcekey="lblBloodGrpResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlBloodGrp" runat="server" Width="73%" meta:resourcekey="ddlBloodGrpResource1" Enabled ="false" >
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblContact" Text="Contact No. " runat="server" meta:resourcekey="lblContactResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtContact" runat="server" meta:resourcekey="txtContactResource1"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblAttender" Text="Attender Name " runat="server" meta:resourcekey="lblAttenderResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAttender" runat="server" meta:resourcekey="txtAttenderResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr id="trHospital" runat="server">
                                    <td runat="server">
                                        <asp:Label ID="lblInstitute" Text="Hospital" runat="server"></asp:Label>
                                    </td>
                                    <td runat="server">
                                        <asp:TextBox ID="txtInstitute" runat="server"></asp:TextBox>
                                    </td>
                                    <td runat="server">
                                        <asp:Label ID="lblLocation" Text="Hospital Location " runat="server"></asp:Label>
                                    </td>
                                    <td runat="server">
                                        <asp:TextBox ID="txtLocation" runat="server"></asp:TextBox>
                                    </td>
                                    <td runat="server">
                                        <asp:Label ID="lblPhone" Text="Hospital's Phone No. " runat="server"></asp:Label>
                                    </td>
                                    <td runat="server">
                                        <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblIndication" Text="Clinical Indication" runat="server" meta:resourcekey="lblIndicationResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtIndication" runat="server" meta:resourcekey="txtIndicationResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblRequestDate" Text="Date Of Request::" runat="server" meta:resourcekey="lblRequestDateResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtRequestDate"
                                            Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                            Enabled="True" />
                                        <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtRequestDate"
                                            PopupButtonID="ImgBntCalc" Enabled="True" />
                                        <asp:TextBox ID="txtRequestDate" runat="server" meta:resourcekey="txtRequestDateResource1"></asp:TextBox>
                                        <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            CausesValidation="False" meta:resourcekey="ImgBntCalcResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblTransfusionDate" Text="Date Of Transfusion Scheduled::" runat="server"
                                            meta:resourcekey="lblTransfusionDateResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtTransfusionDate"
                                            Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                            Enabled="True" />
                                        <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTransfusionDate"
                                            PopupButtonID="ImageButton1" Enabled="True" />
                                        <asp:TextBox ID="txtTransfusionDate" runat="server" meta:resourcekey="txtTransfusionDateResource1"></asp:TextBox>
                                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            CausesValidation="False" meta:resourcekey="ImgBntCalcResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="1">
                                        <asp:CheckBox ID="chkHOTransfusion" Text="H/O Transfusion Reactions" Font-Bold="True"
                                            runat="server" meta:resourcekey="chkHOTransfusionResource1"></asp:CheckBox>
                                    </td>
                                    <td colspan="3" align="justify">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblTransComponent" runat="server" Text="Transfusion Component" meta:resourcekey="lblTransComponentResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTransDate" runat="server" Text="Transfusion Date" meta:resourcekey="lblTransDateResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTransReaction" runat="server" Text="Transfusion Reaction" meta:resourcekey="lblTransReactionResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ID="ddlTransfusionComponent" runat="server" meta:resourcekey="ddlTransfusionComponentResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtPrevTransfusionDate" runat="server" onblur="return checkDate1(this.id);"
                                                        meta:resourcekey="txtPrevTransfusionDateResource1"></asp:TextBox>
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtPrevTransfusionDate"
                                                        Mask="99/9999" ClearMaskOnLostFocus="False" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                        Enabled="True" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtTransfusionReaction" runat="server" meta:resourcekey="txtTransfusionReactionResource1"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkPregnant" Font-Bold="True" Text="Pregnant" runat="server" meta:resourcekey="chkPregnantResource1">
                                        </asp:CheckBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPregnant" runat="server" meta:resourcekey="txtPregnantResource1"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCrossMatchingMethod1" Text="Cross-Matching Method" runat="server"
                                            meta:resourcekey="lblCrossMatchingMethod1Resource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:PlaceHolder ID="phCrossMatchingMethod" runat="server"></asp:PlaceHolder>
                                        <asp:Label ID="lblCrossMatchingMethod" Height="50%" Width="30%" runat="server" meta:resourcekey="lblCrossMatchingMethodResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            &nbsp;&nbsp;
                            <table cellpadding="0" cellspacing="10" class="datatable" width="80%">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblBloodOrder" Text="Order Blood/Components" runat="server" ForeColor="Black"
                                            Font-Bold="True" meta:resourcekey="lblBloodOrderResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblUnits" Text="No. Of Units" ForeColor="Black" runat="server" meta:resourcekey="lblUnitsResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:DropDownList ID="ddlBloodComponent" runat="server" onchange ="ddlBloodComponentChange();" meta:resourcekey="ddlBloodComponentResource1">
                                        </asp:DropDownList>
                                        <%--  </td>
                                 <td>--%>
                                        <asp:TextBox  ID="txtBloodComponentName" onfocus="javascript:setContextInfo();" runat="server"
                                            onchange="boxExpand(this);" Width="200px"></asp:TextBox>
                                      <ajc:AutoCompleteExtender ID="AutoCompleteExtenderBloodComponent" runat="server" TargetControlID="txtBloodComponentName"
                                            EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="30" OnClientItemSelected="IAmSelected"
                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetBloodComponent"
                                            FirstRowSelected="True" ServicePath="~/OPIPBilling.asmx" UseContextKey="True"
                                             Enabled="True">
                                        </ajc:AutoCompleteExtender>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtNoOfUnits" runat="server" meta:resourcekey="txtNoOfUnitsResource1"></asp:TextBox>
                                    </td>
                                    <td>
                                        <input type="button" id="btnAdd" onclick="onClickAddComponent();" value="Add" class="btn" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <input type="hidden" id="hdnComponents" runat="server"> </input>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <table id="tblComponents" runat="server" border="0" cellpadding="4" cellspacing="0"
                                            class="dataheaderInvCtrl" style="display: none; color: Black" width="97%">
                                            <tr id="Tr1" runat="server">
                                                <th id="Th1" runat="server" style="font-size: 10px; text-decoration: underline; text-align: left">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Delete 
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                </th>
                                                <th id="Th2" runat="server" style="font-size: 10px; text-decoration: underline; text-align: left">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Component 
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                </th>
                                                <th id="Th3" runat="server" style="font-size: 10px; text-decoration: underline; text-align: left">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No. Of Bags 
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                </th>
                                            </tr>
                                        </table>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                     
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <div>
                            <table class="datatable" width="80%" style="text-align: center">
                                <tr valign="bottom">
                                    <td>
                                        <asp:Button ID="btnSave" Text="Request" runat="server" CssClass="btncss" OnClick="btnSave_Click"
                                            meta:resourcekey="btnSaveResource1" />
                                        <asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btncss" OnClick="btnCancel_Click"
                                            meta:resourcekey="btnCancelResource1" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnRecords" runat="server" />
    <asp:HiddenField ID="hdnMethods" runat="server" />
    <asp:HiddenField ID="hdnBloodComponentID" runat="server" Value="0" />
    <asp:HiddenField ID ="hdnProductID" runat ="server" Value ="0" />
    <asp:HiddenField ID ="hdnProductName" runat ="server" />
    </form>
</body>
</html>
