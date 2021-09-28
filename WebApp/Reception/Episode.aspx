<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Episode.aspx.cs" Inherits="Reception_Episode" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="ucAdd" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/DoctorSchedule.ascx" TagName="DoctorSchedule"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc20" %>
<%@ Register Src="../CommonControls/IPClientTpaInsurance.ascx" TagName="ClientTpa"
    TagPrefix="uc19" %>
<%@ Register Src="../CommonControls/PatientVisitSummary.ascx" TagName="VisitSummary"
    TagPrefix="uc11" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/Department.ascx" TagName="Department" TagPrefix="uc9" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<%@ Register Src="../CommonControls/Tasks.ascx" TagName="Tasks" TagPrefix="uc7" %>--%>
<%@ Register Src="../CommonControls/QuickBillReferedPhysician.ascx" TagName="ReferedPhysician"
    TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="Task" TagPrefix="uc8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Day Care</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../Images/favicon.ico" rel="shortcut icon" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript">
        function collapseDropDownList(elementRef) {
            elementRef.style.width = elementRef.normalWidth;
        }
        function expandDropDownList(elementRef) {
            elementRef.style.width = '450px';
        }
        function Validate() {
            if (document.getElementById('ddlEpisode').selectedIndex == '0' && document.getElementById('txtNewEpisode').value=='') {
                alert('Select the Episode');
                document.getElementById('ddlEpisode').focus();
                return false;
            }
            if (document.getElementById('txtNoOfVisit').value == '') {
                alert('Enter the Number of Sitting');
                document.getElementById('txtNoOfVisit').focus();
                return false;
            }
            if (document.getElementById('txtStartDt').value == '') {
                alert('Select Start Date and End date');
                document.getElementById('txtStartDt').focus();
                return false;
            }
            if (document.getElementById('txtEndDt').value == '') {
                alert('Select Start Date and End date');
                document.getElementById('txtEndDt').focus();
                return false;

            }
//            if (document.getElementById('txtStartDt').value != '' && document.getElementById('txtEndDt').value != '') {
//                return checkStartDateEndDate('txtStartDt', 'txtEndDt');
//            }
        }


        function checkStartDateEndDate(obj1, StartDt, wedFlag, BAflage) {
            var obj = document.getElementById(obj1);
            var currentTime;
            if (obj.value != '') {
                dobDt = obj.value.split('/');
                var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
                var mMonth = dobDtTime.getMonth() + 1;
                var mDay = dobDtTime.getDate();
                var mYear = dobDtTime.getFullYear();
                if (wedFlag == 0) {
                    currentTime = new Date();
                }
                else {
                    wedDt = document.getElementById(StartDt).value.split('/');
                    var currentTime = new Date(wedDt[2] + '/' + wedDt[1] + '/' + wedDt[0]);
                }
                var month = currentTime.getMonth() + 1;
                var day = currentTime.getDate();
                var year = currentTime.getFullYear();
                if (BAflage == 0) {
//                    if (mYear > year) {
//                        alert('Invalid date');
//                        obj.value = '__/__/____';
//                        obj.focus();
//                        return false;
//                    }
//                    else 
                    if (mYear == year && mMonth < month) {
                        alert('Invalid date');
                        obj.value = '__/__/____';
                        obj.focus();
                        return false;
                    }
                    else if (mYear == year && mMonth == month && mDay < day) {
                        alert('Invalid date');
                        obj.value = '__/__/____';
                        obj.focus();
                        return false;
                    }
                }
                else {
                    if (mYear < year) {
                        alert('Invalid date. Provide only a future date');
                        obj.value = '__/__/____';
                        obj.focus();
                        return false;
                    }
                    else if (mYear == year && mMonth < month) {
                        alert('Invalid date. Provide only a future date');
                        obj.value = '__/__/____';
                        obj.focus();
                        return false;
                    }
                    else if (mYear == year && mMonth == month && mDay < day) {
                        alert('Invalid date. Provide only a future date');
                        obj.value = '__/__/____';
                        obj.focus();
                        return false;
                    }
                }
                return true;
            }
        }
        
//        function checkStartDateEndDate(fromDate, toDate) {
//            var today = new Date();
//            var stfromDate = document.getElementById(fromDate).value;
//            var sttoDate = document.getElementById(toDate).value;
//            var dd = stfromDate.substring(0, 2);
//            var mm = stfromDate.substring(3, 5);
//            var yy = stfromDate.substring(6, 10);
//            var fromDate = new Date();
//            fromDate.setFullYear(yy, mm - 1, dd);

//            dd = sttoDate.substring(0, 2);

//            mm = sttoDate.substring(3, 5);

//            yy = sttoDate.substring(6, 10);

//            var toDate = new Date();
//            toDate.setFullYear(yy, mm - 1, dd);

//            if (fromDate.format("dd/yy") > today.format("dd/yy")) {
//                alert("Please Check. From Date Greater than Current Date.");
//                 return false;
//            }

//            if (toDate.format("dd/yy") > today.format("dd/yy")) {
//                 alert("Please Check. To Date Greater than Current Date.");
//                 return false;
//            }

//            if (toDate.format("dd/yy") < fromDate.format("dd/yy")) {
//                 alert("Please Check. To Date is Less than From Date.");
//                 return false;
//            }

//        }
        function showNewEpisode() {
            
            if(document.getElementById('tblNewEpisode').style.display =='none')
            {
                document.getElementById('tblNewEpisode').style.display = "block";
            }
            else
            {
                document.getElementById('tblNewEpisode').style.display = "none";
            }
            //document.getElementById('tblNewEpisode').style.display = 'block';
            document.getElementById('ddlEpisode').selectedIndex = 0;
            document.getElementById('txtNoOfVisit').value = '';
            return false;
        }
        function EpisodeCheck() {
            if (document.getElementById('txtNewEpisode').value == '') {
                alert('Enter the Episode Name');
                document.getElementById('txtNewEpisode').focus();
                return false;
            }
        }
        function ValidateDate() {
            alert('ValidateDate');
            if (document.getElementById('txtStartDt').value == '') {
                alert('Select Start Date and End date');
                document.getElementById('txtStartDt').focus();
                return false;
            }
            else if (document.getElementById('txtEndDt').value == '') {
                alert('Select Start Date and End date');
                document.getElementById('txtEndDt').focus();
                return false;

            }
//            else {
//                alert('ValidateDate');
//                return checkStartDateEndDate('txtStartDt', 'txtEndDt');
//            }

        }
        function Epiclear() {
            document.getElementById("ddlEpisode").selectedIndex = 0;
            document.getElementById("txtNoOfVisit").value = "";
            document.getElementById("txtStartDt").value = "";
            document.getElementById("txtNewEpisode").value = "";
            document.getElementById("txtEndDt").value = "";
            
           
            document.getElementById("trEpisode").style.display = "none";
            SetRateID(0);
            SetPreAuthAmount(0);
            document.getElementById("divMore1").style.display = "block";
            document.getElementById("divMore2").style.display = "none";
            document.getElementById("divMore3").style.display = "none";
            document.getElementById("trEpi").style.display = "block";
            //document.getElementById('lnkNewEpisode').style.enabled = "false";
            return false;
        }
        function showEpisode() {
            document.getElementById("ddlOpenEpisode").selectedIndex = 0;
            document.getElementById("trEpi").style.display = "none";
            if (document.getElementById("trEpisode").style.display == "none") {
                document.getElementById("trEpisode").style.display = "block";
                document.getElementById("trClient").style.display = "block";
                document.getElementById("btnFinish").enabled = true;
            }
            else {
                Epiclear();
            }
            return false;
        }
        function SetSitting() {
            var e = document.getElementById('ddlEpisode');
            var SelEpi = e.options[e.selectedIndex].value;
            var Sitt = SelEpi.split('~');
            document.getElementById('txtNoOfVisit').value = Sitt[1];
            document.getElementById('txtStartDt').focus();
            if (document.getElementById('ddlEpisode').selectedIndex > 0) {
                document.getElementById('txtNewEpisode').value = "";
                document.getElementById('tblNewEpisode').style.display = "none";
            }
            return false;
        }
        function SetIsvalidation(obj1, obj2) {
            document.getElementById("hdnEpisode").value = "N";
            document.getElementById('divMore3').style.display = "block";
            if (obj2 == "plus") {

                document.getElementById("hdnEpisode").value = "Y";
                document.getElementById('divMore3').style.display = "none";

            }
            if (obj2 == "minus") {
                document.getElementById("hdnEpisode").value = "N";
                document.getElementById('divMore3').style.display = "block";

            }
        }
        function SetIsvalidation1(obj1, obj2) {
            document.getElementById("hdnRef").value = "N";
            document.getElementById('divRef3').style.display = "block";
            if (obj2 == "plus") {

                document.getElementById("hdnRef").value = "Y";
                document.getElementById('divRef3').style.display = "none";

            }
            if (obj2 == "minus") {
                document.getElementById("hdnRef").value = "N";
                document.getElementById('divRef3').style.display = "block";

            }
        }
        function DivCollapse() {
            showResponses('divRef1', 'divRef2', 'divRef3', 0);
            showResponses('divMore1', 'divMore2', 'divMore3', 0);
            if (isCollapse()) {
                PatientDivCollapse(0);
            }
        }
    </script>

    

    <script type="text/javascript" language="javascript">
        function SetRateID(pValue) {
            document.getElementById('hdnRateID').value = pValue;
        }
        function SetTPAID(pValue) {
            document.getElementById('hdnTPAID').value = pValue;
        }
        function SethdnClientID(pValue) {
            document.getElementById('hdnClientID').value = pValue;
        }

        function SetPreAuthAmount(pValue) {
            document.getElementById('hdnPreAuthAmount').value = pValue;
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server" defaultbutton="btnFinish">
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
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc3:DocHeader ID="docHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
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
                    <asp:UpdatePanel ID="upEpisode" runat="server">
                        <ContentTemplate>
                            <div id="dvOpenEpisode" class="contentdata">
                                <table id="tblOpenEpisode" border="0" runat="server" class="dataheader2" width="100%">
                                    <tr>
                                        <td>
                                            <strong>
                                                <asp:Label ID="lblPatientName" runat="server"></asp:Label></strong>
                                        </td>
                                        <td>
                                            <strong>
                                                <asp:Label ID="lblPatientNumber" runat="server"></asp:Label></strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lIpVisits0" Text="No. of. Episode:" runat="server"></asp:Label>&nbsp;
                                            <asp:Label ID="lblDayCare" Style="font-weight: bold; text-align: left;" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trEpi" runat="server" style="display: block">
                                        <td>
                                            <asp:Label ID="lblOpen" Text="Open episode for this patient" runat="server"></asp:Label>
                                            <asp:DropDownList ID="ddlOpenEpisode" runat="server" AutoPostBack="false">
                                            </asp:DropDownList>
                                            <asp:Button ID="btnGo" runat="server" CssClass="btn" OnClick="btnGo_Click" onmouseout="this.className='btn'"
                                                onmouseover="this.className='btn btnhov'" Text="Go" UseSubmitBehavior="true" />
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="lnkNew" ForeColor="#0033CC" OnClientClick="javascript:return showEpisode();"
                                                runat="server"> Create New Episode </asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table border="0" runat="server" id="trEpisode" style="display: none;" class="dataheader2"
                                    width="100%">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblName" Text="Episode Name" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlEpisode" onChange="return SetSitting();" runat="server"
                                                AutoPostBack="false">
                                            </asp:DropDownList>
                                            <asp:LinkButton ID="lnkNewEpisode" ForeColor="#0033CC" OnClientClick="javascript:return showNewEpisode();"
                                                runat="server"> Add New </asp:LinkButton>
                                            <table id="tblNewEpisode" runat="server" style="display: none">
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtNewEpisode" onblur="javascript:document.getElementById('txtNoOfVisit').focus();return ConverttoUpperCase(this.id);"
                                                            runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                            <%--<asp:TextBox ID="txtEpisode" onblur="return ConverttoUpperCase(this.id);" runat="server"
                                        TabIndex="1"></asp:TextBox>--%>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblVisit" Text="No. of Sitting" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtNoOfVisit" Width="100px" runat="server" TabIndex="2"   onkeypress="return ValidateOnlyNumeric(this);"  
                                                MaxLength="8"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblStartDt" Text="Start Date" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtStartDt" runat="server" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                Width="100px" TabIndex="3" MaxLength="1" Style="text-align: left" />
                                            <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtStartDt"
                                                Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                ErrorTooltipEnabled="True" />
                                            <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtStartDt"
                                                PopupButtonID="ImageButton1" Format="dd/MM/yyyy" />
                                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                CausesValidation="False" Width="16px" />
                                            <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                ControlToValidate="txtStartDt" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                ValidationGroup="MKE" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblEndDt" Text="End Date" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtEndDt" runat="server" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                Width="100px" TabIndex="4" MaxLength="1" Style="text-align: left" />
                                            <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtEndDt"
                                                Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                ErrorTooltipEnabled="True" />
                                            <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtEndDt"
                                                PopupButtonID="ImageButton2" Format="dd/MM/yyyy" />
                                            <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                CausesValidation="False" />
                                            <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender1"
                                                ControlToValidate="txtEndDt" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                ValidationGroup="MKE" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="dataheaderInvCtrl">
                                            <%-- %>div style=&quot;vertical-align: text-top;&quot;--&gt;
                                    
                                        
                                   <%-- </div>--%>
                                            <div id="divRef1" onclick="SetIsvalidation1('Address','plus');showResponses('divRef1','divRef2','divRef3',1);"
                                                style="cursor: pointer; display: block;" runat="server">
                                                &nbsp;<img src="../Images/plus.png" alt="Show" />
                                                <asp:Label ID="Rs_ReferringPhysician" Text="Referring Physician" Font-Bold="True"
                                                    runat="server" />
                                            </div>
                                            <div id="divRef2" style="cursor: pointer; display: none; cursor: pointer;" onclick="showResponses('divRef1','divRef2','divRef3',0);"
                                                runat="server">
                                                &nbsp;<img src="../Images/minus.png" alt="hide" />
                                                <asp:Label ID="Rs_ReferringPhysician1" Text="Referring Physician" Font-Bold="True"
                                                    runat="server" />
                                            </div>
                                            <div id="divRef3" style="display: none;" title="Referring Physician">
                                                <uc10:referedphysician specialityvisiblity="true" referringtype="Visit Level Referring Physician : "
                                                    id="ReferDoctor1" runat="server" />
                                                <div id="dvH" runat="server" style="display: none;">
                                                    <asp:Label ID="lblreferHos" Text="Referring Hospital" Font-Bold="True" runat="server" />
                                                    <asp:DropDownList ID="ddlHospital" ToolTip="Select Referring Hospital" runat="server"
                                                        TabIndex="25" Width="250px" OnSelectedIndexChanged="ddlHospital_SelectedIndexChanged"
                                                        normalWidth="250px" onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);">
                                                    </asp:DropDownList>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr id="trClient" style="display: none;">
                                        <td style="text-align: left" colspan="4">
                                            <table width="100%">
                                                <tr>
                                                    <td style="text-align: left; vertical-align: top">
                                                        <div id="divMore1" onclick="SetIsvalidation('Address','plus');showResponses('divMore1','divMore2','divMore3',1);"
                                                            style="cursor: pointer; display: block;" runat="server">
                                                            &nbsp;<img src="../Images/plus.png" alt="Show" />
                                                            <asp:Label ID="Label1" Text="Client & Insurance / TPA" Font-Bold="True" runat="server" />
                                                        </div>
                                                        <div id="divMore2" style="cursor: pointer; display: none; cursor: pointer;" onclick="SetIsvalidation('Address','minus');showResponses('divMore1','divMore2','divMore3',0);"
                                                            runat="server">
                                                            &nbsp;<img src="../Images/minus.png" alt="hide" />
                                                            <asp:Label ID="Label2" Text="Client & Insurance / TPA" Font-Bold="True" runat="server" />
                                                        </div>
                                                        <div id="divMore3" style="display: none;" runat="server" title="Client And Insurance / TPA">
                                                            <uc19:ClientTpa IsQuickBill="Y" ID="uctlClientTpa" runat="server" />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <asp:Button ID="btnFinish" runat="server" CssClass="btn" TabIndex="5" OnClick="btnFinish_Click"
                                                onmouseout="this.className='btn'" OnClientClick="javascript:return Validate();return ValidateDate();"
                                                onmouseover="this.className='btn btnhov'" Text="Save" UseSubmitBehavior="true" />
                                            &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="btn" TabIndex="6" OnClientClick="javascript:return Epiclear();"
                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Cancel"
                                                UseSubmitBehavior="true" />
                                        </td>
                                    </tr>
                                </table>
                                <%--<table id="tblNewEpisode" runat="server" style="display:none">
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtNewEpisode" runat="server" ></asp:TextBox>
                                    <asp:Button ID="btnEpisode" Text="Save" runat="server" />
                                </td>
                            </tr>
                        </table>--%>
                                <asp:HiddenField ID="hdnEpisode" Value="N" runat="server" />
                                <asp:HiddenField ID="hdnRef" Value="N" runat="server" />
                                <asp:HiddenField ID="PatVistiRefID" Value="0" runat="server" />
                                <input type="hidden" id="hdnRateID" runat="server" />
                                <input type="hidden" id="hdnClientID" runat="server" />
                                <input type="hidden" id="hdnTPAID" runat="server" />
                                <input type="hidden" id="hdnPreAuthAmount" runat="server" />
                                <input type="hidden" id="hdnEpisodeDet" runat="server" />
                                <input type="hidden" id="hdnPreAuthApprovalNumber" runat="server" />
                                <input type="hidden" id="Hidden1" runat="server" />
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <uc2:Footer ID="Footer1" runat="server" />
    </form>
</body>
</html>
