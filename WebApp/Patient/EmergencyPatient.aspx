<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmergencyPatient.aspx.cs"
    Inherits="Patient_EmegencyPatient" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="~/CommonControls/URNControl.ascx" TagName="URNControl1" TagPrefix="uc100" %>
<%@ Register Src="~/CommonControls/Ambulance.ascx" TagName="ucAmb" TagPrefix="uc101" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitals" TagPrefix="uc6" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Emergency Patient Registration</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/StyleSheet.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
        <Services>
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
                <uc3:Header ID="docHeader" runat="server" />
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
                    <div class="contentdata1">
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                                <ul>
                                    <li>
                                        <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                    </li>
                                </ul>
                                <table border="1" width="100%">
                                    <tr>
                                        <td>
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <div style="vertical-align: text-top; width: 110px;">
                                                            <div id="div4" onclick="showResponses('div4','div5','div6',1);" style="cursor: pointer;
                                                                display: none;" runat="server">
                                                                &nbsp;<img src="../Images/plus.png" alt="Show" />
                                                                <asp:Label ID="Label3" Text="Attender Details" Font-Bold="True" runat="server" meta:resourcekey="Label3Resource1" />
                                                            </div>
                                                            <div id="div5" style="cursor: pointer; display: block; cursor: pointer;" onclick="showResponses('div4','div5','div6',0);"
                                                                runat="server">
                                                                &nbsp;<img src="../Images/minus.png" alt="hide" />
                                                                <asp:Label ID="Label4" Text="Attender Details" Font-Bold="True" runat="server" meta:resourcekey="Label4Resource1" />
                                                            </div>
                                                        </div>
                                                        <div id="div6" style="display: block;" title="Attender Identity">
                                                            <table border="0" cellpadding="0" cellspacing="2" width="100%" class="dataheader3">
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblAttenderName" runat="server" Text="Attender Name" meta:resourcekey="lblAttenderNameResource1" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtATTName" runat="server" onblur="ConverttoUpperCase(this.id);"
                                                                            CssClass="Txtboxsmall" MaxLength="55" meta:resourcekey="txtATTNameResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblAddress" runat="server" Text="Address" meta:resourcekey="lblAddressResource1" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtAddress" runat="server" onblur="ConverttoUpperCase(this.id);"
                                                                            CssClass="Txtboxsmall" MaxLength="55" meta:resourcekey="txtAddressResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblRelation" runat="server" Text="Relationship" meta:resourcekey="lblRelationResource1" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlRelation" CssClass="ddl" runat="server" meta:resourcekey="ddlRelationResource1">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblContactno" runat="server" Text="Contact No" meta:resourcekey="lblContactnoResource1" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtContactNo" runat="server" CssClass="Txtboxsmall" MaxLength="20"
                                                                            meta:resourcekey="txtContactNoResource1"></asp:TextBox>
                                                                        <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="filtxtMobile"
                                                                            TargetControlID="txtContactNo" Enabled="True">
                                                                        </ajc:FilteredTextBoxExtender>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div style="vertical-align: text-top; width: 110px;">
                                                            <div id="divMore1" onclick="showResponses('divMore1','divMore2','divMore3',1);" style="cursor: pointer;
                                                                display: none;" runat="server">
                                                                &nbsp;<img src="../Images/plus.png" alt="Show" />
                                                                <asp:Label ID="Rs_MoreDetails" Text="Patient Identity" Font-Bold="True" runat="server"
                                                                    meta:resourcekey="Rs_MoreDetailsResource1" />
                                                            </div>
                                                            <div id="divMore2" style="cursor: pointer; display: block; cursor: pointer;" onclick="showResponses('divMore1','divMore2','divMore3',0);"
                                                                runat="server">
                                                                &nbsp;<img src="../Images/minus.png" alt="hide" />
                                                                <asp:Label ID="Rs1_MoreDetails" Text="Patient Identity" Font-Bold="True" runat="server"
                                                                    meta:resourcekey="Rs1_MoreDetailsResource1" />
                                                            </div>
                                                        </div>
                                                        <div id="divMore3" style="display: block;" title="Patient Identity">
                                                            <table border="0" cellpadding="0" cellspacing="2" width="100%" class="dataheader3">
                                                                <tr>
                                                                    <td width="10%">
                                                                        <asp:Label ID="lblPatientName" runat="server" Text="Patient Name" meta:resourcekey="lblPatientNameResource1" />
                                                                    </td>
                                                                    <td width="10%">
                                                                        <asp:TextBox ID="txtPatientName" runat="server" onblur="ConverttoUpperCase(this.id);"
                                                                            CssClass="Txtboxsmall" MaxLength="55" meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td width="5%">
                                                                        <asp:Label ID="lblSex" runat="server" Text="Sex" meta:resourcekey="lblSexResource1" />
                                                                    </td>
                                                                    <td width="10%">
                                                                        <asp:DropDownList ID="ddlSex" runat="server" CssClass="ddl" meta:resourcekey="ddlSexResource1">
                                                                        </asp:DropDownList>
                                                                        <img src="../Images/starbutton.png" alt="" align="middle" /><img src="../Images/starbutton.png"
                                                                            alt="" align="middle" />
                                                                    </td>
                                                                    <td width="5%">
                                                                        <asp:Label ID="lblAge" runat="server" Text="Age" meta:resourcekey="lblAgeResource1" />
                                                                    </td>
                                                                    <td width="15%">
                                                                        <asp:TextBox ID="txtAge" runat="server" CssClass="Txtboxsmall" Width="30px"
                                                                             MaxLength="5"></asp:TextBox>
                                                                        <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="FilteredTextBoxExtender1"
                                                                            TargetControlID="txtAge" Enabled="True">
                                                                        </ajc:FilteredTextBoxExtender>
                                                                        <asp:DropDownList ID="ddlDOBDWMY" CssClass="ddl" runat="server" meta:resourcekey="ddlDOBDWMYResource1">
                                                                        </asp:DropDownList>
                                                                        <img src="../Images/starbutton.png" alt="" align="middle" /><img src="../Images/starbutton.png"
                                                                            alt="" align="middle" />
                                                                    </td>
                                                                    <td width="10%">
                                                                        <asp:Label ID="lblPatientConditon" runat="server" Text="Patient Condition" meta:resourcekey="lblPatientConditonResource1" />
                                                                    </td>
                                                                    <td width="15%">
                                                                        <asp:DropDownList ID="ddlPatientCondition" CssClass="ddlsmall" Width="100px" runat="server"
                                                                            meta:resourcekey="ddlPatientConditionResource1">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                    <asp:Label ID="lblSeverityLevel" runat="server" Text="Severity Level"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                    <asp:DropDownList ID="ddlSeverity" runat="server" CssClass="ddlsmall" Width="100px"></asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="7">
                                                                        <uc100:URNControl1 ID="URNControl1" runat="server" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblEPNotes" runat="server" Text="Notes" meta:resourcekey="lblEPNotesResource1" />
                                                                    </td>
                                                                    <td colspan="6">
                                                                        <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Width="528px" Height="79px"
                                                                            meta:resourcekey="txtNotesResource1"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td nowrap="nowrap">
                                                        <div style="vertical-align: text-top; width: 110px;">
                                                            <div id="div1" onclick="showResponses('div1','div2','div3',1);" style="cursor: pointer;
                                                                display: none;" runat="server">
                                                                &nbsp;<img src="../Images/plus.png" alt="Show" />
                                                                <asp:Label ID="Label1" Text="Ambulance Details" Font-Bold="True" runat="server" meta:resourcekey="Label1Resource1" />
                                                            </div>
                                                            <div id="div2" style="cursor: pointer; display: block; cursor: pointer;" onclick="showResponses('div1','div2','div3',0);"
                                                                runat="server">
                                                                &nbsp;<img src="../Images/minus.png" alt="hide" />
                                                                <asp:Label ID="Label2" Text="Ambulance Details" Font-Bold="True" runat="server" meta:resourcekey="Label2Resource1" />
                                                            </div>
                                                        </div>
                                                        <div id="div3" style="display: block;" title="Ambulance Details">
                                                            <table border="0" cellpadding="0" cellspacing="2" width="100%" class="dataheader3">
                                                                <tr>
                                                                    <td>
                                                                        <uc101:ucAmb ID="ucAmb" runat="server" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td nowrap="nowrap">
                                                        <div style="vertical-align: text-top; width: 110px;">
                                                            <div id="div7" onclick="showResponses('div7','div8','div9',1);" style="cursor: pointer;
                                                                display: none;" runat="server">
                                                                &nbsp;<img src="../Images/plus.png" alt="Show" />
                                                                <asp:Label ID="lblVitals" Text="Patient Vitals" Font-Bold="True" runat="server" />
                                                            </div>
                                                            <div id="div8" style="cursor: pointer; display: block; cursor: pointer;" onclick="showResponses('div7','div8','div9',0);"
                                                                runat="server">
                                                                &nbsp;<img src="../Images/minus.png" alt="hide" />
                                                                <asp:Label ID="lblVitals1" Text="Patient Vitals" Font-Bold="True" runat="server" />
                                                            </div>
                                                        </div>
                                                        <div id="div9" style="display: block;" title="PatientVitals">
                                                            <table border="0" cellpadding="0" cellspacing="2" width="100%" class="dataheader3">
                                                                <tr>
                                                                    <td>
                                                                         <uc6:PatientVitals ID="uctPatientVitalsControl" runat="server" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table border="0" cellpadding="0" cellspacing="2" width="100%" class="dataheader3">
                                                            <tr>
                                                                <td align="center" colspan="2">
                                                                    <asp:Button ID="btnFinish" runat="server" CssClass="btn" Text="Finish" OnClick="btnFinish_Click"
                                                                        OnClientClick="return Check_Validation();" meta:resourcekey="btnFinishResource1" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btn"
                    PopupControlID="Panel1" BackgroundCssClass="modalBackground" DynamicServicePath=""
                    Enabled="True" CancelControlID="btnOK" />
                <input type="button" id="btn" runat="server" style="display: none;" />
                <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup dataheaderPopup" Width="25%"
                    Style="display: none" meta:resourcekey="Panel1Resource1">
                    <table width="100%">
                        <tr>
                            <td align="center">
                                <table width="90%">
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="lblPatientNumber1" Text="Patient Name" runat="server" meta:resourcekey="lblPatientNumber1Resource1" />
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblViewPatientName" runat="server" Font-Bold="True" meta:resourcekey="lblViewPatientNameResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="lblPateim" Text="Patient Number" runat="server" meta:resourcekey="lblPateimResource1" />
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblViewPatientNumber" runat="server" Font-Bold="True" meta:resourcekey="lblViewPatientNumberResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Button ID="btnOK" runat="server" Text="Ok" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="btnOKResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnPatientid" runat="server" />
    <asp:HiddenField ID="hdnVistID"   runat="server" />

    <script type="text/javascript">
        function PreSBPKeyPress() {
            var key = window.event.keyCode;
            if ((key != 16) && (key != 4) && (key != 9)) {
                var sVal = document.getElementById('uctPatientVitalsControl_txtSBP').value;
                var ctrlDBP = document.getElementById('uctPatientVitalsControl_txtDBP');
                if (sVal.length == 3) {
                    ctrlDBP.focus();
                }
            }
        }
        function Check_Validation() {
            var check = "0";
            if (document.getElementById('<%= ddlSex.ClientID %>').selectedIndex == 0 && document.getElementById('<%= txtAge.ClientID %>').value == "") {
                var userMsg = SListForApplicationMessages.Get('Patient\\EmergencyPatient_8');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Please Enter a Sex or Age');
                }

                return false;
            }
            else if (check == "1") {
                if (document.getElementById('ucAmb_hdnAMBID').value == "0") {
                    var userMsg = SListForApplicationMessages.Get('Patient\\EmergencyPatient_1');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert('Please Enter a Ambulance No');
                    }

                    return false;
                }
                else if (document.getElementById('ucAmb_hdnDriverID').value == "0") {
                    var userMsg = SListForApplicationMessages.Get('Patient\\EmergencyPatient_2');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert('Please Enter a Driver Name ');
                    }
                    return false;
                }
                else if (document.getElementById('ucAmb_hdnLocationID').value == "0") {
                    var userMsg = SListForApplicationMessages.Get('Patient\\EmergencyPatient_3');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert('Please Enter a Location Name ');
                    }
                    return false;
                }
                else if (document.getElementById('ucAmb_txtDistanceKgm').value == "") {
                    var userMsg = SListForApplicationMessages.Get('Patient\\EmergencyPatient_4');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert('Please Enter a Duration');
                    }
                    return false;
                }
                else if (document.getElementById('ucAmb_txtDuration').value == "") {
                    var userMsg = SListForApplicationMessages.Get('Patient\\EmergencyPatient_5');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert('Please Enter a Duration ');
                    }
                    return false;
                }
                else if (document.getElementById('ucAmb_txtArrivalFromDate').value == "") {
                    var userMsg = SListForApplicationMessages.Get('Patient\\EmergencyPatient_6');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert('Please Select a Start Date  ');
                    }
                    return false;
                }
                else if (document.getElementById('ucAmb_txtArrivalToDate').value == "") {
                    var userMsg = SListForApplicationMessages.Get('Patient\\EmergencyPatient_7');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                        alert('Please Select a To Date  ');
                    }
                    return false;
                }
                return true;
            }
            else {
                return true;
            }
        }                   
            
    </script>

    </form>
</body>
</html>
