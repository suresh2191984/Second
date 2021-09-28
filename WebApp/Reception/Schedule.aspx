<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Schedule.aspx.cs" Inherits="Reception_Schedule"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%--<%@ Register Src="~/CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>--%>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Schedule</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>
    
    <script src="../Scripts/LabQuickBilling.js" type="text/javascript"></script>

    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function ValidateSchedule() {

            if (document.getElementById('txtPatientName').value == "") {
                var userMsg = SListForApplicationMessages.Get('Reception\\Schedule.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                    document.getElementById('txtPatientName').focus();
                    return false;
                } else {
                    alert('Please Enter Patient Name');
                    document.getElementById('txtPatientName').focus();
                    return false;
                }
            }
//            else if (document.getElementById('txtPatientNumber').value == "") {
//                var userMsg = SListForApplicationMessages.Get('Reception\\Schedule.aspx_2');
//                if (userMsg != null) {
//                    alert(userMsg);
//                    document.getElementById('txtPatientNumber').focus();
//                    return false;

//                } else {
//                    alert('Please Enter Patient Number');
//                    document.getElementById('txtPatientNumber').focus();
//                    return false;
//                }
//            }
            else if (document.getElementById('txtPhoneNumber').value == "") {
                var userMsg = SListForApplicationMessages.Get('Reception\\Schedule.aspx_3');
                if (userMsg != null) {
                    alert(userMsg);
                    document.getElementById('txtPhoneNumber').focus();
                    return false;
                }
                else {
                    alert('Please Enter PhoneNumber');
                    document.getElementById('txtPhoneNumber').focus();
                    return false;
                }
            }
            return true;
        }
    </script>

</head>
<body >
    <form id="prFrm" runat="server" oncontextmenu="return false;">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>

    <script language="javascript" type="text/javascript">

        function ProductsListPopup() {

            var PName;
            var pNo;
            pName = document.getElementById('txtPatientName').value.trim();
            pNo = document.getElementById('txtPatientNumber').value.trim();
            var pOrg = document.getElementById('hdnOrgId').value.trim();
            //window.showModalDialog("PatientList.aspx?pName=" + pName + "&pNo=" + pNo + "&pOrg=" + pOrg + "", "Products List", "dialogWidth:550px;dialogHeight:450px");
            window.open("../Inventory/PatientList.aspx?pName=" + pName + "&IsPopup=Y&pNo=" + pNo + "&pOrg=" + pOrg + "&pCaller=Schd", "Patient", "height=450,width=550,scrollbars=yes");
        }
        function PatientsResult(vpname, vpnumber) {
            document.getElementById('<%= txtPatientName.ClientID %>').value = vpname;
            document.getElementById('<%= txtPatientNumber.ClientID %>').value = vpnumber;
        }
        
    </script>

    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="ReceptionHeader" runat="server" />
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
                        <ul>
                            <li class="dataheader">
                                <asp:Label ID="Rs_Schedulefor" Text="Schedule for" runat="server" meta:resourcekey="Rs_ScheduleforResource1"></asp:Label>
                                <asp:Literal ID="litName" runat="server" meta:resourcekey="litNameResource1"></asp:Literal></li>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <input type="hidden" id="rtid" runat="server" />
                        <table width="100%" border="0">
                            <tr>
                                <td class="blackfontcolormedium">
                                    &nbsp;&nbsp;&nbsp;<asp:Label ID="Rs_AvailableSlots" Text="Available Slots" runat="server"
                                        meta:resourcekey="Rs_AvailableSlotsResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <asp:Table ID="tSchAv" runat="server" meta:resourcekey="tSchAvResource1">
                                    </asp:Table>
                                </td>
                                <td valign="top">
                                    <div id="desc" class="DivBooking1" style="display: none;">
                                        <table width="100%" class="defaultfontcolor">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbtkNo" runat="server" Text="Token No" Class="defaultfontcolor" meta:resourcekey="lbtkNoResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" Class="blackfontcolormedium" ID="lblToken" meta:resourcekey="lblTokenResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbTime" runat="server" Text="Time" Class="defaultfontcolor" meta:resourcekey="lbTimeResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" Class="blackfontcolormedium" ID="lblTime" meta:resourcekey="lblTimeResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label class="defaultfontcolor">
                                                        <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server"   onfocus="javascript:setPatientSearch();" onKeyDown="javascript:clearPageControlsValue('Y');"
                                                                          OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" onblur="javascript:ConverttoUpperCase(this.id);" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                                    </label>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtPatientName"  autocomplete="off" ></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderPatientName" runat="server" TargetControlID="txtPatientName"
                                                        ServiceMethod="GetLabQuickBillPatientList" ServicePath="~/OPIPBilling.asmx" EnableCaching="False"
                                                        CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                         OnClientItemSelected="SelectedPatientDetails" Enabled="True">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label class="defaultfontcolor">
                                                        <asp:Label ID="Rs_PatientNo" Text="Patient No." runat="server" meta:resourcekey="Rs_PatientNoResource1"></asp:Label>
                                                    </label>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtPatientNumber" meta:resourcekey="txtPatientNumberResource1"></asp:TextBox>
                                                    <asp:Button ID="btnSearch" runat="server" TabIndex="3" Text="Search" CssClass="btn1"
                                                        onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                                                        OnClientClick="ProductsListPopup(); return false;" meta:resourcekey="btnSearchResource1" />
                                                    <input type="hidden" id="hdnOrgId" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top">
                                                    <label class="defaultfontcolor">
                                                        <asp:Label ID="Rs_PhoneNo" Text="Phone No." runat="server" meta:resourcekey="Rs_PhoneNoResource1"></asp:Label>
                                                    </label>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtPhoneNumber" MaxLength="25" meta:resourcekey="txtPhoneNumberResource1"></asp:TextBox>
                                                    <br />
                                                    <span style="font-size: 8pt;">
                                                        <asp:Label ID="Rs_info" Text="note : Seleprate multiple phone numbers with hyphen (-)"
                                                            runat="server" meta:resourcekey="Rs_infoResource1" />
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:HiddenField ID="hdnConsumedById" Value="-1" runat="server" />
                                                    <label class="defaultfontcolor">
                                                        <asp:Label ID="Rs_Description" Text="Description" runat="server" meta:resourcekey="Rs_DescriptionResource1"></asp:Label></label>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="tBkDesc" TextMode="MultiLine" MaxLength="240" meta:resourcekey="tBkDescResource1"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2">
                                                    <asp:Button runat="server" ID="btnSave" Text="Book" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClick="bSave_Click" meta:resourcekey="btnSaveResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="blackfontcolormedium">
                                    &nbsp;&nbsp;&nbsp;
                                    <asp:Label runat="server" ID="lblBkd" Text="Booked Slots" meta:resourcekey="lblBkdResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <asp:Table ID="tSchBk" Style="text-align: left;" runat="server" meta:resourcekey="tSchBkResource1">
                                    </asp:Table>
                                </td>
                                <td valign="top">
                                    <div id="canDiv" class="DivBooking" style="display: none;">
                                        <table width="100%">
                                            <tr>
                                                <td class="defaultfontcolor">
                                                    <asp:Label ID="Rs_Description1" Text="Description:" runat="server"></asp:Label>
                                                </td>
                                                <td valign="bottom">
                                                    <asp:Label ID="lDesc" runat="server" meta:resourcekey="lDescResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label class="defaultfontcolor">
                                                        <asp:Label ID="Rs_ReasonforCancellation" Text="Reason for Cancellation:" runat="server"
                                                            meta:resourcekey="Rs_ReasonforCancellationResource1"></asp:Label></label>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="tCanDesc" TextMode="MultiLine" meta:resourcekey="tCanDescResource1"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td align="left">
                                                    <asp:Button runat="server" ID="bCancel" Text="CancelBooking" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClick="bCancel_Click" meta:resourcekey="bCancelResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table class="defaultfontcolor">
                            <tr>
                                <td>
                                    <asp:HiddenField runat="server" ID="hidBKID" />
                                    <asp:HiddenField runat="server" ID="hidDate" />
                                    <asp:HiddenField runat="server" ID="hidToken" />
                                    <asp:HiddenField runat="server" ID="hidDesc" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
    </div>
    </form>
</body>
</html>
