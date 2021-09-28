<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DoctorSchedule.aspx.cs" Inherits="Admin_DoctorSchedule"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/PhyBookedSchedule.ascx" TagName="PhysicainSchedule"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>
        <%=Resources.Admin_ClientDisplay.Admin_DoctorSchedule_aspx_01%>
    </title>
 <%--   <script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>
--%>
    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        function ClearALL() {

            document.getElementById('txtTestName').value = "";
            document.getElementById('txtDuration').value = "";
            document.getElementById('txtclient').value = "";
            $('#DivPhyBooked').hide();
            document.getElementById('lblInvType').innerHTML = '';   
            document.getElementById('hdnInvID').value = '';
            document.getElementById('hdnInvName').value = '';
            document.getElementById('hdnInvType').value = '';
            document.getElementById('hdnPhyID').value = '';
            document.getElementById('hdnOrgID').value = '';
            document.getElementById('hdnClientID').value = '';
            document.getElementById('hdnIsInvSched').value = '';
            document.getElementById('hdnSTID').value = '';
            document.getElementById('hdnRTID').value = '';
            document.getElementById('hdnResourceID').value = '';
            document.getElementById('hdnRecurrenceID').value = '';
            document.getElementById('hdnPRCylID').value = '';
            document.getElementById('hdnRCylID').value = '';
            document.getElementById('HdnInvestigationID').value = '';
            document.getElementById('HdnFeeType').value = '';
            document.getElementById('Hdnrawdata').value = '';
            document.getElementById('hdnSelectedTest').value = '';
            document.getElementById('dRepeat').style.display = "none";
            document.getElementById('tdtest').style.display = "none";
            document.getElementById('lblMW').innerHTML = "";
            document.getElementById('dMonthly').style.display = 'none';
            document.getElementById('dWeekly').style.display = 'none';
            document.getElementById('ddlMonths').value = 1;           
            document.getElementById('ddlFrom').value = -1;
            document.getElementById('ddlTo').value = -1;



        }
        function dropclear() {
            document.getElementById('txtDuration').value = "";
        }

        function RestrictChar() {

            var exp = String.fromCharCode(window.event.keyCode)
            var exp = String.fromCharCode(window.event.keyCode)
            var r = new RegExp("[0-9\r]", "g");
            if (exp.match(r) == null) {
                window.event.keyCode = 0
                return false;
            }
        }

        function txtboxvalidate() {

            if (document.getElementById('ddlDurationType').options[document.getElementById('ddlDurationType').selectedIndex].innerHTML == 'Mins') {
                number = document.getElementById('txtDuration').value;
                if (number > 59) {

                    document.getElementById('txtDuration').value = "59";


                }
            }

            

        }

        function clearfn() {

            if (document.getElementById('txtTestName').value.length <= 0) {
                document.getElementById('lblInvType').innerHTML = '';
            }
            else {
                document.getElementById('lblInvType').innerHTML = document.getElementById('hdnInvType').value;
            }
        }
        function IAmSelected(source, eventArgs) {

            var varGetVal = eventArgs.get_value();
            //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            var ID;
            var name;
            var InvType;

            //            eventArgs.get_value()[0].PatientID;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        ID = list[0];
                        name = list[1];
                        InvType = list[2];
                        document.getElementById('hdnInvID').value = ID;
                        document.getElementById('hdnInvName').value = name;
                        document.getElementById('hdnInvType').value = InvType;
                        document.getElementById('ddlFrom').focus();

                    }
                }


            }
        }

        function SelectedTest(source, eventArgs) {
            document.getElementById('hdnSelectedTest').value = eventArgs.get_value();
            var x = document.getElementById('hdnSelectedTest').value.split("~");
            var Type = x[0].split("^");
            var InvType = Type[2];
            document.getElementById('lblInvType').innerHTML = InvType;



        }
        function PhySelected(source, eventArgs) {

            var varGetVal = eventArgs.get_value();
            //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            var ID;


            //            eventArgs.get_value()[0].PatientID;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        ID = list[0];

                        document.getElementById('hdnPhyID').value = ID;
                        document.getElementById('ddlFrom').focus();



                    }
                }



            }
        }


        function Getphyschedules() {
            var OrgId = parseInt(document.getElementById('hdnOrgID').value);
            var ResourceId = parseInt(document.getElementById('hdnPhyID').value);

            WebService.GetAllPhysicianSchedules(OrgId, ResourceId);
        }


        function ClientSelected(source, eventArgs) {

            var varGetVal = eventArgs.get_value();
            //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            var ID;


            //            eventArgs.get_value()[0].PatientID;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        ID = list[0];

                        document.getElementById('hdnClientID').value = ID;
                        document.getElementById('ddlFrom').focus();



                    }
                }



            }
        }






        function ValidateSchedule() {
            //debugger;
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_DoctorSchedule_aspx_01") != null ? SListForAppMsg.Get("Admin_DoctorSchedule_aspx_01") : "Enter Physician Name";
            var userMsg1 = SListForAppMsg.Get("Admin_DoctorSchedule_aspx_02") != null ? SListForAppMsg.Get("Admin_DoctorSchedule_aspx_02") : "Enter Duration";
            var userMsg2 = SListForAppMsg.Get("Admin_DoctorSchedule_aspx_03") != null ? SListForAppMsg.Get("Admin_DoctorSchedule_aspx_03") : "Choose a valid date";
            var userMsg3 = SListForAppMsg.Get("Admin_DoctorSchedule_aspx_04") != null ? SListForAppMsg.Get("Admin_DoctorSchedule_aspx_04") : "Enter the Duration";
            var userMsg4 = SListForAppMsg.Get("Admin_DoctorSchedule_aspx_05") != null ? SListForAppMsg.Get("Admin_DoctorSchedule_aspx_05") : "Select Client Type";
            var userMsg5 = SListForAppMsg.Get("Admin_DoctorSchedule_aspx_06") != null ? SListForAppMsg.Get("Admin_DoctorSchedule_aspx_06") : "Enter Client Name";
            var userMsg6 = SListForAppMsg.Get("Admin_DeviceIntegrationMapping_aspx_05") != null ? SListForAppMsg.Get("Admin_DeviceIntegrationMapping_aspx_05") : "Enter Investigation Name";
            var userMsg7 = SListForAppMsg.Get("Admin_DoctorSchedule_aspx_02") != null ? SListForAppMsg.Get("Admin_DoctorSchedule_aspx_02") : "Enter Duration";
            var userMsg8 = SListForAppMsg.Get("Admin_DoctorSchedule_aspx_07") != null ? SListForAppMsg.Get("Admin_DoctorSchedule_aspx_07") : "Select Repeats for Schedule";
            if (document.getElementById('hdnSelectedTab').value == "tabPhysician") {

                if (document.form1.txtNew.value == "") {
                    //var userMsg = SListForApplicationMessages.Get("Admin\\DoctorSchedule.aspx_1");
                    if (userMsg != null) {
                        // alert(userMsg);
                        ValidationWindow(userMsg, AlrtWinHdr);
                        return false;
                    }
                    else {
                        //alert('Enter Physician Name');
                        ValidationWindow(userMsg, AlrtWinHdr);
                       
                    }
                    document.form1.txtNew.focus();
                    return false;

                }


                else if (document.form1.txtDuration.value == "") {
                    // var userMsg = SListForApplicationMessages.Get("Admin\\DoctorSchedule.aspx_2");
                    if (userMsg1 != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg1, AlrtWinHdr);
                    return false;
                }
                else {
                        //alert('Enter Duration');
                        ValidationWindow(userMsg1, AlrtWinHdr);
                    
                }
                    document.form1.txtDuration.focus();
                    return false;

                }

                else if (document.form1.tDOB.value == "") {
                    //var userMsg = SListForApplicationMessages.Get("Admin\\DoctorSchedule.aspx_3");
                    if (userMsg2 != null) {
                        // alert(userMsg);
                        ValidationWindow(userMsg2, AlrtWinHdr);
                    return false;
                }
                else {
                        // alert('Choose a valid date');
                        ValidationWindow(userMsg2, AlrtWinHdr);
                   
                }
                    document.form1.tDOB.focus();
                    return false;
                }
                else if (document.getElementById('txtDuration').value == "") {
                    //var userMsg = SListForApplicationMessages.Get("Admin\\DoctorSchedule.aspx_4");
                    if (userMsg3 != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg3, AlrtWinHdr);
                    return false;
                }
                else {
                        // alert('Enter the Duration ');
                        ValidationWindow(userMsg3, AlrtWinHdr);
                    
                }
                    document.form1.txtDuration.focus();
                    return false;
                }
                document.getElementById('dRepeat').style.display = "none";

            }
             if (document.getElementById('hdnSelectedTab').value == "tabClient") {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DoctorSchedule.aspx_5");
                if (document.form1.drpClientType.value == "Select") {
                    if (userMsg4 != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg4, AlrtWinHdr);
                        return false;
                    }
                    else {
                        //alert('Select Client Type');
                        ValidationWindow(userMsg4, AlrtWinHdr);
                       
                    }
                    document.form1.drpClientType.focus();
                    return false;
                }
                else if (document.form1.txtclient.value == "") {
                    //var userMsg = SListForApplicationMessages.Get("Admin\\DoctorSchedule.aspx_6");
                    if (userMsg5 != null) {
                        //                        alert(userMsg);
                        ValidationWindow(userMsg5, AlrtWinHdr);
                    return false;
                }
                else {
                        // alert('Enter Client Name');
                        ValidationWindow(userMsg5, AlrtWinHdr);
                    
                }
                    document.form1.txtclient.focus();
                    return false;
                }

                else if (document.form1.tDOB.value == "") {
                    //var userMsg = SListForApplicationMessages.Get("Admin\\DoctorSchedule.aspx_7");
                    if (userMsg2 != null) {
                        // alert(userMsg);
                        ValidationWindow(userMsg2, AlrtWinHdr);
                    return false;
                }
                else {
                        // alert('Choose a valid date');
                        ValidationWindow(userMsg2, AlrtWinHdr);
                  
                }
                    document.form1.tDOB.focus();
                    return false;
                }

                

                document.getElementById('dRepeat').style.display = "none";


            }

             if (document.getElementById('hdnSelectedTab').value == "tabInvestigation") {
                if (document.form1.txtTestName.value == "") {
                    //var userMsg = SListForApplicationMessages.Get("Admin\\DoctorSchedule.aspx_8");
                    if (userMsg6 != null) {
                        // alert(userMsg);
                        ValidationWindow(userMsg6, AlrtWinHdr);
                        return false;
                    }
                    else {
                        // alert('Enter Investigation Name');
                        ValidationWindow(userMsg6, AlrtWinHdr);
                    }
                    document.form1.txtTestName.focus();
                    return false;
                }



                else if (document.form1.txtDuration.value == "") {
                    //var userMsg = SListForApplicationMessages.Get("Admin\\DoctorSchedule.aspx_9");
                    if (userMsg7 != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg7, AlrtWinHdr);
                    return false;
                }
                else {
                        //alert('Enter Duration');
                        ValidationWindow(userMsg7, AlrtWinHdr);
                    
                }
                    document.form1.txtDuration.focus();
                    return false;

                }

                else if (document.form1.tDOB.value == "") {
                    //  var userMsg = SListForApplicationMessages.Get("Admin\\DoctorSchedule.aspx_7");
                    if (userMsg2 != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg2, AlrtWinHdr);
                    return false;
                }
                else {
                        //  alert('Choose a valid date');
                        ValidationWindow(userMsg2, AlrtWinHdr);
                   
                }
                    document.form1.tDOB.focus();
                    return false;
                }
                else if (document.getElementById('txtDuration').value == "") {
                    //var userMsg = SListForApplicationMessages.Get("Admin\\DoctorSchedule.aspx_9");
                    if (userMsg7 != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg7, AlrtWinHdr);
                    return false;
                }
                else {
                        // alert('Enter the Duration ');
                        ValidationWindow(userMsg7, AlrtWinHdr);
                   
                }
                    document.form1.txtDuration.focus();
                    return false;
                }

                document.getElementById('dRepeat').style.display = "none";


            }

            if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == 'Select') {
                // var userMsg = SListForApplicationMessages.Get("Admin\\DoctorSchedule.aspx_12");
                if (userMsg8 != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg8, AlrtWinHdr);
                    return false;
                }
                else {
                    // alert('Select Repeats for Schedule');
                    ValidationWindow(userMsg8, AlrtWinHdr);
                    
                }
                document.form1.ddlRepeat.focus();
                return false;
            }

            return true;
        }


        

        
    </script>  

</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnSave">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:UpdateProgress ID="Progressbar" runat="server">
                                    <ProgressTemplate>
                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                      <asp:Label ID="lblPleasewait" runat="server" Text="Please wait...." 
                                            meta:resourcekey="lblPleasewaitResource1"></asp:Label>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <div id="TabsMenu" class="TabsMenu">
                                    <ul id="ulTabsMenu">
                                        <li id="tabPhysician" onclick="ShowTabContent('tabPhysician','tabContentPhysician')"
                                            class="active"><a href="#">
                                <asp:Label ID="lblPhysiciantab" runat="server" Text="Physician" meta:resourcekey="lblPhysiciantabResource1" /></a></li>
                                        <li id="tabClient" onclick="ShowTabContent('tabClient', 'tabContentClient')"><a href="#">
                            <asp:Label ID="lblClienttab" runat="server" Text="Client" meta:resourcekey="lblClienttabResource1" /></a></li>
                                        <li id="tabInvestigation" onclick="ShowTabContent('tabInvestigation', 'tabContentInvestigation')">
                                            <a href="#">
                                <asp:Label ID="lblInvestigationtab" runat="server" Text="Investigation" meta:resourcekey="lblInvestigationtabResource1" /></a></li>
                                    </ul>
                                </div>
                                <br />
                                <asp:UpdatePanel ID="updatePanel2" runat="server">
                                    <ContentTemplate>
                                        <table class="w-30p">
                                            <tr id="trInvName" runat="server" style="display: none;">
                                                <td>
                                                    <table>
                                                        <tr>
                                            <td>
                                                <asp:Label ID="lblInvestigationName" runat="server" meta:resourcekey="lblInvestigationNameResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table class="padding10 scheduledataheader2 w-35p">
                            <tr>
                                <td colspan="2">
                                    <table class="w-80p" id="tabContentPhysician" style="display: none;">
                                        <tr id="trType" runat="server">
                                            <td class="w-37p a-left" runat="server" id="tddoc">
                                                <asp:Label runat="server" ID="lblDoctor" Text="Doctor Name" meta:resourcekey="lblDoctorResource1"></asp:Label>
                                            </td>
                                            <td class="a-left" runat="server" id="tddocname">
                                                <asp:TextBox ID="txtNew" CssClass="Txtboxsmall" runat="server" ToolTip="Enter Text Here"
                                                    AutoPostBack="True" OnTextChanged="txtNew_TextChanged" TabIndex="4" meta:resourcekey="txtNewResource1"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtNew"
                                                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetAllPhysicianName"
                                                    ServicePath="~/WebService.asmx" UseContextKey="True" DelimiterCharacters="" Enabled="True"
                                                    OnClientItemSelected="PhySelected">
                                                </ajc:AutoCompleteExtender>
                                            </td>
                                        </tr>
                                    </table>
                                            <table class="w-80p" id="tabContentClient" style="display: none;">
                                                <tr id="trclienttype" runat="server">
                                                   
                                                    <td class="w-38p a-left">
                                                <asp:Label ID="lblClientid" runat="server" Text="Client Type" meta:resourcekey="lblClientidResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="drpClientType" CssClass="ddlsmall" runat="server" AutoPostBack="True"
                                                    OnSelectedIndexChanged="drpClientType_SelectedIndexChanged" TabIndex="2" >
                                                </asp:DropDownList>
                                                                </td>
                                                                
                                                         </tr>
                                                         <tr>
                                                          
                                                            <td class="a-left">
                                                                   <asp:Label ID="lblClient" runat="server" Text="Client Name"></asp:Label>
                                                                </td>
                                                                <td>
                                                <asp:TextBox ID="txtclient" runat="server" Enabled="False" AutoPostBack="True" OnTextChanged="txtclient_TextChanged"
                                                    TabIndex="3" meta:resourcekey="txtclientResource1"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtclient"
                                                                        EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetClientNamebyClientType"
                                                                        ServicePath="~/WebService.asmx" UseContextKey="True" DelimiterCharacters="" Enabled="True"
                                                                        OnClientItemSelected="ClientSelected">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>
                                                          
                                                
                                                </tr>
                                            </table>
                                      
                                       
                                            <table class="w-100p" id="tabContentInvestigation" style="display: none;" >
                                                <tr>
                                                    <td class="a-left w-29p" id="tdtest" runat="server">
                                                <asp:Label ID="lblTestName" Text="Investigation Name" runat="server" meta:resourcekey="lblTestNameResource1"></asp:Label>
                                                    </td>
                                                    <td id="tdtestname" runat="server" class="a-left">
                                                        <asp:TextBox onkeydown="javascript:clearfn();" CssClass="small" ID="txtTestName"
                                                    runat="server" AutoPostBack="True" OnTextChanged="txtTestName_TextChanged" TabIndex="1"
                                                    meta:resourcekey="txtTestNameResource1"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtTestName"
                                                            EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="True"
                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetOrgInvestigationsGroupandPKG"
                                                            OnClientItemSelected="IAmSelected" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                            DelimiterCharacters="" Enabled="True" OnClientItemOver="SelectedTest">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                            <td>
                                                <asp:Label ID="lblInvType" runat="server" ForeColor="Red" Font-Bold="True" meta:resourcekey="lblInvTypeResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                                <td class="w-19p a-left">
                                    <asp:Label runat="server" ID="Label1" Text="Start Date" meta:resourcekey="Label1Resource1"></asp:Label>
                                                </td>
                                                <td>
                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB"
                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB"
                                        PopupButtonID="ImgBntCalc" Enabled="True" />
                                    <asp:TextBox ID="tDOB" runat="server" CssClass="Txtboxsmall" Width="130px" TabIndex="5"
                                        MaxLength="1" Style="text-align: justify" ValidationGroup="MKE" meta:resourcekey="tDOBResource1" />
                                    <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                        CausesValidation="False" TabIndex="6" meta:resourcekey="ImgBntCalcResource1" />
                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                        ControlToValidate="tDOB" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label runat="server" ID="lblTiming" Text="Timing" meta:resourcekey="lblTimingResource1"></asp:Label>
                                                </td>
                                                <td class="a-left w-45p">
                                                    <table class="w-43p">
                                                        <tr>
                                                            <td>
                                                <asp:Label runat="server" ID="lblFrm" Text="From" meta:resourcekey="lblFrmResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:DropDownList runat="server" ID="ddlFrom" TabIndex="7" CssClass="ddl" >
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td id="tdcl1" runat="server" class="a-left">
                                                <asp:Label runat="server" ID="lblTo" Text="To" meta:resourcekey="lblToResource1"></asp:Label>
                                                            </td>
                                                            <td id="tdcl2" runat="server" class="a-left w-61p">
                                                                <asp:DropDownList runat="server" ID="ddlTo" TabIndex="8" CssClass="ddl" >
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr id="trcl3" runat="server">
                                                <td>
                                                    <label>
                                        <%=Resources.Admin_ClientDisplay.Admin_DoctorSchedule_aspx_02 %>
                                    </label>
                                                </td>
                                                <td>
                                                    <table class="w-20p">
                                                        <tr id="trTime">
                                                            <td class="w-5p">
                                                                <asp:DropDownList runat="server" ID="ddlDurationType" TabIndex="9" CssClass="ddl"
                                                                    onchange="dropclear()">
                                                    <%--<asp:ListItem Value="Mins" meta:resourcekey="ListItemResource1">Mins</asp:ListItem>
                                                    <asp:ListItem Value="Hours" meta:resourcekey="ListItemResource2">Hours</asp:ListItem>--%>
                                                                </asp:DropDownList>
                                                            </td>
                                            <td class="w-5p">
                                                <asp:TextBox ID="txtDuration" runat="server" Width="30px" MaxLength="2" Style="text-align: justify"
                                                    CssClass="TXtboxverysmall"    onkeypress="return ValidateOnlyNumeric(this);"  
                                                    onchange="return txtboxvalidate()" TabIndex="10" meta:resourcekey="txtDurationResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left">
                                    <asp:Label runat="server" ID="lblRepeat" Text="Repeats" meta:resourcekey="lblRepeatResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlRepeat" TabIndex="11" CssClass="ddlsmall">
                                        <%--<asp:ListItem Value="0" meta:resourcekey="ListItemResource3">Select</asp:ListItem>
                                        <asp:ListItem Value="1" meta:resourcekey="ListItemResource4">Daily</asp:ListItem>
                                        <asp:ListItem Value="2" meta:resourcekey="ListItemResource5">Weekly</asp:ListItem>
                                        <asp:ListItem Value="3" meta:resourcekey="ListItemResource6">Monthly</asp:ListItem>
                                        <asp:ListItem Value="4" meta:resourcekey="ListItemResource7">Yearly</asp:ListItem>--%>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td>
                                    <div id="dRepeat" style="display: none" runat="server" class="scheduledataheader2">
                                        <table class="w-100p">
                                            <tr>
                                                <td colspan="2">
                                                    <div id="dWords" style="display: block;">
                                                        <table>
                                                            <tr>
                                                                <td class="blackfontcolormedium h-25">
                                                                    <asp:Label runat="server" ID="lblRepeatWords" meta:resourcekey="lblRepeatWordsResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="w-8p">
                                                    <asp:Label runat="server" ID="lblMonths" Text="Repeat every:" meta:resourcekey="lblMonthsResource1"></asp:Label>
                                                </td>
                                                <td class="w-25p">
                                                    <asp:DropDownList runat="server" ID="ddlMonths" TabIndex="12" CssClass="ddl" onchange="loadText();">
                                                    </asp:DropDownList>
                                                    <label id="lblMW">
                                                        <%=Resources.Admin_ClientDisplay.Admin_DoctorSchedule_aspx_01 %></label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <div id="dMonthly" style="display: block;">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label runat="server" ID="Label5" Text="Repeat By:" meta:resourcekey="Label5Resource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="a-center w-25p">
                                                                    <asp:RadioButtonList runat="server" CssClass="radiobutton" ID="rdrptBy" RepeatDirection="Horizontal"
                                                                        onclick="loadText();" TabIndex="13" meta:resourcekey="rdrptByResource1">
                                                                        <%--<asp:ListItem meta:resourcekey="ListItemResource8">day of the month</asp:ListItem>
                                                                        <asp:ListItem Enabled="false" meta:resourcekey="ListItemResource9">day of the week</asp:ListItem>--%>
                                                                    </asp:RadioButtonList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <div id="dWeekly" runat="server" style="display: block;">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label runat="server" ID="Label6" Text="Repeat On:" meta:resourcekey="Label6Resource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:CheckBoxList runat="server" ID="chkDays" TabIndex="14" RepeatDirection="Horizontal"
                                                                        CssClass="radiobutton" onclick="loadText();" meta:resourcekey="chkDaysResource1">
                                                                        <%--<asp:ListItem Value="0" meta:resourcekey="ListItemResource10">Sun</asp:ListItem>
                                                                        <asp:ListItem Value="1" meta:resourcekey="ListItemResource11">Mon</asp:ListItem>
                                                                        <asp:ListItem Value="2" meta:resourcekey="ListItemResource12">Tue</asp:ListItem>
                                                                        <asp:ListItem Value="3" meta:resourcekey="ListItemResource13">Wed</asp:ListItem>
                                                                        <asp:ListItem Value="4" meta:resourcekey="ListItemResource14">Thu</asp:ListItem>
                                                                        <asp:ListItem Value="5" meta:resourcekey="ListItemResource15">Fri</asp:ListItem>
                                                                        <asp:ListItem Value="6" meta:resourcekey="ListItemResource16">Sat</asp:ListItem>--%>
                                                                    </asp:CheckBoxList>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                        <table>
                                        <tr style="display: none;">
                                            <td>
                                    <%=Resources.Admin_ClientDisplay.Admin_DoctorSchedule_aspx_02 %>  &nbsp;
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlOrgLocation" CssClass="ddlsmall" runat="server" TabIndex="15">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>                                       
                                        <tr>
                                            <td>
                                                <asp:HiddenField ID="weekNo" runat="server" />
                                            </td>
                                            <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnSave" runat="server" CssClass="btn1" OnClick="btnSave_Click" TabIndex="16"
                                                    Text="Save" meta:resourcekey="btnSaveResource1" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnclear" TabIndex="17" runat="server" CssClass="btn" Text="Clear"
                                                    OnClientClick="ClearALL();" meta:resourcekey="btnclearResource1" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnCancel" runat="server" CssClass="btn1" OnClick="btnCancel_Click"
                                                    TabIndex="18" Text="Cancel" meta:resourcekey="btnCancelResource1" />
                                                <asp:Button ID="btnDelete" runat="server" TabIndex="19" CssClass="btn1" Style="display: none;"
                                                    Text="Delete" OnClick="btnDelete_Click" meta:resourcekey="btnDeleteResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                        </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <div class="dataheader2" align="center" id="DivPhyBooked">
                                    <uc8:PhysicainSchedule ID="phyBooked" runat="server" />
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />         
    <asp:HiddenField ID="hdnSTID" runat="server" />
    <asp:HiddenField ID="hdnRTID" runat="server" />
    <asp:HiddenField ID="hdnResourceID" runat="server" />
    <asp:HiddenField ID="hdnRecurrenceID" runat="server" />
    <asp:HiddenField ID="hdnPRCylID" runat="server" />
    <asp:HiddenField ID="hdnRCylID" runat="server" />
    <asp:HiddenField ID="HdnInvestigationID" runat="server" />
    <asp:HiddenField ID="HdnFeeType" runat="server" />
    <asp:HiddenField ID="Hdnrawdata" runat="server" />
    <asp:HiddenField ID="hdnIsInvSched" runat="server" />
    <asp:HiddenField ID="hdnInvID" runat="server" />
    <asp:HiddenField ID="hdnInvName" runat="server" />
    <asp:HiddenField ID="hdnInvType" runat="server" />
    <asp:HiddenField ID="hdnSelectedTest" runat="server" />
    <asp:HiddenField ID="hdnPhyID" runat="server" />
    <asp:HiddenField ID="hdnClientID" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat="server" />

    <script language="javascript" type="text/javascript">
        function SelectedDatas(sNextOccur, stid, rtid, hrecid, hprcid, hrcid, ifrom, ito,
                                iduration, yearly, monthly, weekly, monthyear, dfmonth,
                                dfweek, sun, mon, tue, wed, thur, fri, sat, locid) {
            document.getElementById('<%= tDOB.ClientID %>').value = sNextOccur;
            document.getElementById('<%= ddlFrom.ClientID %>').value = ifrom;
            document.getElementById('<%= ddlTo.ClientID %>').value = ito;
            var Hours = "Hours";

            if (iduration >= 60) {
                var Duration = iduration / 60;

                document.getElementById('<%= txtDuration.ClientID %>').value = Duration;
                document.getElementById('<%= ddlDurationType.ClientID %>').value = Hours;
            }
            else {
                document.getElementById('<%= txtDuration.ClientID %>').value = iduration;

            }

            document.getElementById('<%= hdnSTID.ClientID %>').value = stid;
            document.getElementById('<%= hdnRTID.ClientID %>').value = rtid;
            document.getElementById('<%= hdnRecurrenceID.ClientID %>').value = hrecid;
            document.getElementById('<%= hdnPRCylID.ClientID %>').value = hprcid;
            document.getElementById('<%= hdnRCylID.ClientID %>').value = hrcid;

            var d = new Date();
            var curr_year = d.getFullYear();
            var curr_Month = d.getMonth();
            var curr_date = d.getDate();

            if (yearly != "0") {
                document.getElementById('dRepeat').style.display = 'block';
                document.getElementById('lblMW').innerHTML = "Years";
                document.getElementById('dMonthly').style.display = 'none';
                document.getElementById('dWeekly').style.display = 'none';
                var Year = document.getElementById('ddlRepeat');
                Year.value = 4;
                document.getElementById('<%= tDOB.ClientID %>').value = monthyear + "/" + curr_year;
                document.getElementById('ddlMonths').value = yearly;

            }
            else if (monthly != "0") {
                document.getElementById('dRepeat').style.display = 'block';
                document.getElementById('lblMW').innerHTML = "Month";
                document.getElementById('dMonthly').style.display = 'block';
                document.getElementById('dWeekly').style.display = 'none';
                var Months = document.getElementById('ddlRepeat');
                Months.value = 3;

                document.getElementById('ddlMonths').value = monthly;
                if (dfmonth != "0") {
                    document.getElementById('rdrptBy_0').checked = true;
                }
                else {
                    document.getElementById('rdrptBy_0').checked = false;
                }
                if (dfweek != "0") {
                    document.getElementById('rdrptBy_1').checked = true;
                }
                else {
                    document.getElementById('rdrptBy_1').checked = false;
                }
            }
            else if (weekly != "0") {
                document.getElementById('dRepeat').style.display = 'block';
                document.getElementById('lblMW').innerHTML = "Weeks";
                document.getElementById('dMonthly').style.display = 'none';
                document.getElementById('dWeekly').style.display = 'block';
                var Weeks = document.getElementById('ddlRepeat');
                Weeks.value = 2;

                document.getElementById('ddlMonths').value = weekly;
                if (sun == "Y") {
                    document.getElementById('chkDays_0').checked = true;
                }
                else {
                    document.getElementById('chkDays_0').checked = false;
                }

                if (mon == "Y") {
                    document.getElementById('chkDays_1').checked = true;
                }
                else {
                    document.getElementById('chkDays_1').checked = false;
                }

                if (tue == "Y") {
                    document.getElementById('chkDays_2').checked = true;
                }
                else {
                    document.getElementById('chkDays_2').checked = false;
                }

                if (wed == "Y") {
                    document.getElementById('chkDays_3').checked = true;
                }
                else {
                    document.getElementById('chkDays_3').checked = false;
                }

                if (thur == "Y") {
                    document.getElementById('chkDays_4').checked = true;
                }
                else {
                    document.getElementById('chkDays_4').checked = false;
                }

                if (fri == "Y") {
                    document.getElementById('chkDays_5').checked = true;
                }
                else {
                    document.getElementById('chkDays_5').checked = false;
                }

                if (sat == "Y") {
                    document.getElementById('chkDays_6').checked = true;
                }
                else {
                    document.getElementById('chkDays_6').checked = false;
                }


            }

            else {
                document.getElementById('dRepeat').style.display = 'block';
                document.getElementById('lblMW').innerHTML = "Days";
                document.getElementById('dMonthly').style.display = 'none';
                document.getElementById('dWeekly').style.display = 'block';
                var Daily = document.getElementById('ddlRepeat');
                Daily.value = 1;
                document.getElementById('dRepeat').style.display = 'none';

                document.getElementById('ddlMonths').value = 1;
                document.getElementById('chkDays_0').checked = true;
                document.getElementById('chkDays_1').checked = true;
                document.getElementById('chkDays_2').checked = true;
                document.getElementById('chkDays_3').checked = true;
                document.getElementById('chkDays_4').checked = true;
                document.getElementById('chkDays_5').checked = true;
                document.getElementById('chkDays_6').checked = true;
            }

            loadText();
            document.getElementById('btnSave').disabled = false;
            document.getElementById('<%= ddlOrgLocation.ClientID %>').value = locid;





        }


        function WPM(y, m) {
            var DoM, DoW, Thu;
            with (new Date(y, m, 13)) {
                DoM = getDate();
                DoW = getDay();
            }
            Thu = DoM - (DoW + 3) % 7;
            return ((Thu + 6) / 7) | 0;
        }
        function deletedData(stid, rtid) {
            document.getElementById('<%= hdnSTID.ClientID %>').value = stid;
            document.getElementById('<%= hdnRTID.ClientID %>').value = rtid;
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_DoctorSchedule_aspx_08") != null ? SListForAppMsg.Get("Admin_DoctorSchedule_aspx_08") : "Are you sure you wish to delete the Schedule?";
            var userMsg1 = SListForAppMsg.Get("Admin_DoctorSchedule_aspx_09") != null ? SListForAppMsg.Get("Admin_DoctorSchedule_aspx_09") : "Deleted Successfully ... !!";
           // var userMsg = SListForApplicationMessages.Get("Admin\\DoctorSchedule.aspx_13");
            if (userMsg != null) {
                result = confirm(userMsg);
            }
            else {
                //result = confirm('Are you sure you wish to delete the Schedule?');
                result = confirm(userMsg);
            }
            
            var i = result;
            if (i == true) {
                document.getElementById('<%= btnDelete.ClientID %>').click();

                //var userMsg = SListForApplicationMessages.Get("Admin\\DoctorSchedule.aspx_14");
                if (userMsg1 != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg1, AlrtWinHdr);
                }
                else {
                    // alert('Deleted Successfully');
                    ValidationWindow(userMsg1, AlrtWinHdr);
                }
               
                window.location.reload()

            }
        }

        function loadText() {
            var days = new Array('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
            var months = new Array('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');
            var chkText;
            var count = 0;
            var rptDays = 0;
            var number;
            for (var i = 0; i < 7; i++) {
                if (document.getElementById('chkDays_' + i).checked) {
                    if (count == 0) {
                        rptDays = days[i];
                        count++;
                    }
                    else {
                        rptDays = rptDays + "," + days[i];
                    }
                }
            }
            //to get the day from given date
            if (rptDays == 0) {
                var date = document.getElementById('tDOB').value;
                date = date.split('/');
                var mydate = new Date(date[2], date[1] - 1, date[0]);
                var dayno = mydate.getDay();
                rptDays = days[dayno];
            }
            if ((document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == 'Weekly')
    && (document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML == '1')) {
                document.getElementById('dWords').style.display = 'block';
                document.getElementById('lblRepeatWords').innerHTML = "Weekly on " + rptDays;
            }
            else if ((document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == 'Weekly')
&& (document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML != '1')) {
                document.getElementById('dWords').style.display = 'block';
                number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
                document.getElementById('lblRepeatWords').innerHTML = "Every " + number + " weeks on " + rptDays;
            }
            else if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == 'Daily') {
                document.getElementById('dWords').style.display = 'block';
                number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
                if (number == '1') {
                    document.getElementById('lblRepeatWords').innerHTML = "Every day";
                }
                else {
                    document.getElementById('lblRepeatWords').innerHTML = "Every " + number + " days";
                }
            }
            else if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == 'Monthly') {
                if (document.getElementById('rdrptBy_0').checked == true) {
                    document.getElementById('dWords').style.display = 'block';
                    number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
                    var date = document.getElementById('tDOB').value;
                    date = date.split('/');
                    document.getElementById('lblRepeatWords').innerHTML = "Every " + number + " month on day " + date[0];
                }
                else if (document.getElementById('rdrptBy_1').checked == true) {
                    document.getElementById('dWords').style.display = 'block';
                    number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
                    var date = document.getElementById('tDOB').value;
                    date = date.split('/');
                    var mydate1 = new Date(date[2], date[1] - 1, date[0]);
                    var dayno = mydate1.getDay();
                    rptDays = days[dayno];
                    var FDofMonth = new Date(mydate1.getYear(), mydate1.getMonth(), 1);
                    var weekNo = new Date();
                    var weekText;
                    for (i = 0; i < 5; i++) {
                        if (i == 0) {
                            weekNo.setDate(FDofMonth.getDate() + 7);
                            if (mydate1 <= weekNo) {
                                weekText = "First";
                                break;
                            }
                        }
                        else if (i == 1) {
                            weekNo.setDate(FDofMonth.getDate() + 14);
                            if (mydate1 <= weekNo) {
                                weekText = "Second";
                                break;
                            }
                        }
                        else if (i == 2) {
                            weekNo.setDate(FDofMonth.getDate() + 21);
                            if (mydate1 <= weekNo) {
                                weekText = "Third";
                                break;
                            }
                        }
                        else if (i == 3) {
                            weekNo.setDate(FDofMonth.getDate() + 28);
                            if (mydate1 <= weekNo) {
                                weekText = "Fourth";
                                break;
                            }
                        }
                        else {
                            weekText = "Fifth";
                            break;
                        }
                    }
                    document.getElementById('weekNo').value = weekText;
                    if (document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML == '1') {
                        document.getElementById('lblRepeatWords').innerHTML = "Monthly on " + weekText + " " + rptDays;

                    }
                    else {
                        number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
                        document.getElementById('lblRepeatWords').innerHTML = "Every " + number + " month on the " + weekText + " " + rptDays;

                    }
                }
                else {
                    document.getElementById('rdrptBy_0').checked = true;
                    document.getElementById('dWords').style.display = 'block';
                    number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
                    var date = document.getElementById('tDOB').value;
                    date = date.split('/');
                    document.getElementById('lblRepeatWords').innerHTML = "Every " + number + " month on day " + date[0];
                }
            }
            else if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == 'Yearly') {
                document.getElementById('dWords').style.display = 'block';
                number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
                var date = document.getElementById('tDOB').value.split('/');
                var mon = date[1];
                document.getElementById('lblRepeatWords').innerHTML = "Every " + number + " years on " + months[date[1] - 1] + " " + date[0];
            }
            else if (document.getElementById('ddlRepeat').options[document.getElementById('ddlRepeat').selectedIndex].innerHTML == 'Yearly') {
                document.getElementById('dWords').style.display = 'block';
                number = document.getElementById('ddlMonths').options[document.getElementById('ddlMonths').selectedIndex].innerHTML;
                document.getElementById('lblRepeatWords').innerHTML = "Every " + number + " days";
            }
        }
        
    </script>

    <script type="text/javascript">

        function blockNonNumbers(obj, e, allowDecimal, allowNegative) {
            var key;
            var isCtrl = false;
            var keychar;
            var reg;

            if (window.event) {
                key = e.keyCode;
                isCtrl = window.event.ctrlKey
            }
            else if (e.which) {
                key = e.which;
                isCtrl = e.ctrlKey;
            }

            if (isNaN(key)) return true;

            keychar = String.fromCharCode(key);

            // check for backspace or delete, or if Ctrl was pressed
            if (key == 8 || isCtrl) {
                return true;
            }

            reg = /\d/;
            var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
            var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;

            return isFirstN || isFirstD || reg.test(keychar);
        }
        function CloseWindow() {
            window.close();
        }

        function SendValueToParent() {

            var InvID = document.getElementById('HdnInvestigationID').value;


            window.opener.GetValueFromChild(InvID);

            return false;
        }
        function ClosePopUp() {
            var IsInvSched = document.getElementById('hdnIsInvSched').value;
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_DoctorSchedule_aspx_10") != null ? SListForAppMsg.Get("Admin_DoctorSchedule_aspx_10") : " Schedule Successfully ..!!";
            if (IsInvSched == "Y") {

                //var userMsg = SListForApplicationMessages.Get("Admin\\DoctorSchedule.aspx_15");
                if (userMsg != null) {
                    result = confirm(userMsg);
                }
                else {
                    result = confirm(userMsg);
                    //result = confirm('Scheduled Successfully');
                }
            
            
            
                var r = confirm(result);
                if (r == true) {
                    SendValueToParent();
                    CloseWindow();
                }
                else {
                    SendValueToParent();
                    CloseWindow();
                }
            }
            else {
                //var userMsg = SListForApplicationMessages.Get("Admin\\DoctorSchedule.aspx_15");
                if (userMsg != null) {
                    ValidationWindow(userMsg, AlrtWinHdr);
                    //alert(userMsg);
                    return false;
                }
                else {
                    //alert("Scheduled Successfully");
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                } 
                          
              

            }
        }
    
    </script>

    <asp:HiddenField ID="hdnMessages" runat="server" />
    <input id="hdnSelectedDiv" type="hidden" runat="server" value="tabContentPhysician" />
     <input id="hdnSelectedTab" type="hidden" runat="server" value="tabPhysician" />
    </form>



    <script type="text/javascript">
        $(document).ready(function() {
            $('body').append('<div id="ajaxBusy"><p><img src="../Images/working.gif">Please Wait...</p></div>');

            $('#ajaxBusy').css({
                display: "none",
                margin: "0px",
                paddingLeft: "0px",
                paddingRight: "0px",
                paddingTop: "0px",
                paddingBottom: "0px",
                position: "absolute",
                right: "3px",
                top: "150px",
                width: "auto"
            });
        });
        $(document).ajaxStart(function() {
            $('#ajaxBusy').show();
        }).ajaxStop(function() {
            $('#ajaxBusy').hide();
        });

        $(function() {
            $('[id^="tabContent"]').hide();
            $('#tabPhysician').addClass('active');
            $('#tabContentPhysician').show();
        });
        function ShowTabContent(tabId, DivId) {
            $('#TabsMenu li').removeClass('active');
            $('#' + tabId).addClass('active');
            $('[id^="tabContent"]').hide();
            $('#' + DivId).show();
            if (DivId == 'tabContentClient') {
                $('#tdcl1').hide();
                $('#tdcl2').hide();
                $('#trcl3').hide();
            }
            else {
                $('#tdcl1').show();
                $('#tdcl2').show();
                $('#trcl3').show(); 
            }
           
            $('#hdnSelectedTab').val(tabId);
            $('#hdnSelectedDiv').val(DivId);
            loadMonths();            
            $('#dRepeat').hide();
            document.getElementById('btnSave').disabled = false;        
            document.getElementById('txtTestName').value = '';
            document.getElementById('txtclient').value = '';
            document.getElementById('txtNew').value = '';
            $('#DivPhyBooked').hide();
            document.getElementById('lblInvType').innerHTML = '';          
            document.getElementById('txtDuration').value = ''; 
            document.getElementById('ddlRepeat').value =0;

        }


        function ShowTabContentPostBack(tabId, DivId) {
            $('#TabsMenu li').removeClass('active');
            $('#' + tabId).addClass('active');
            $('[id^="tabContent"]').hide();
            $('#' + DivId).show();
            if (DivId == 'tabContentClient') {
                $('#tdcl1').hide();
                $('#tdcl2').hide();
                $('#trcl3').hide();
            }
            else {
                $('#tdcl1').show();
                $('#tdcl2').show();
                $('#trcl3').show();
                }

            $('#hdnSelectedTab').val(tabId);
            $('#hdnSelectedDiv').val(DivId);
            loadMonths();
            $('#dRepeat').hide();           
           

        }
        
        
        
    </script>

</body>
</html>
