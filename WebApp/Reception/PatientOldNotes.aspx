<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientOldNotes.aspx.cs"
    Inherits="Reception_PatientOldNotes" EnableViewState="true" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ImageUploadManager.ascx" TagName="ImageUploadManager"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Patient Old Notes </title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
           <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <link href="../StyleSheets/StyleSheet.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">
 function ShowAlertMsg(key) {
       var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false ;
            }
            else
            {
            alert('Please Upload File and then Save');
            return false ;
            }
         
           return true;
        }
        function ShowPanel() {
            if (document.getElementById('txtDocDate').value != '') {

                if (document.getElementById('txtdTitle').value != '') {

                    if (document.getElementById('txtDrname').value != '') {

                        //document.getElementById('Panel3').style.display = 'block';
                        return true;

                    }
                    else {
                        var userMsg = SListForApplicationMessages.Get('Reception\\PatientOldNotes.aspx_1');
                        if (userMsg != null) {
                            alert(userMsg);
                        } else {
                            alert('Provide name for the doctor');
                        }
                        document.getElementById('txtDrname').focus();
                        return false;
                    }
                }
                else {
                    var userMsg = SListForApplicationMessages.Get('Reception\\PatientOldNotes.aspx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                    } else {
                        alert('Provide document title');
                    }
                    document.getElementById('txtdTitle').focus();
                    return false;
                }

            }
            else {
                var userMsg = SListForApplicationMessages.Get('Reception\\PatientOldNotes.aspx_3');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert('Provide document date');
                }
                document.getElementById('txtDocDate').focus();
                return false;

            }
            return false;
        }

        function showCareCenterpanel() {

            if (document.getElementById('chkBox').checked == false) {
                document.getElementById('tblCarecentre').style.display = 'block';
                document.getElementById('tblCarecentre').style.display = 'block';
            }
            else {
                document.getElementById('tblCarecentre').style.display = 'none';
            }

        }
    </script>

</head>
<body oncontextmenu="return true;">
    <form id="prFrm" runat="server">
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
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="upa1" runat="server">
                            <ContentTemplate>
                                <table border="0" cellpadding="2" cellspacing="1" width="100%">
                                    <tr>
                                        <td align="center">
                                            <asp:Panel ID="Panel1" CssClass="dataheader2" BorderWidth="1px" runat="server" Width="512px"
                                                meta:resourcekey="Panel1Resource1">
                                                <table border="0" width="70%">
                                                    <tr>
                                                        <td style="font-weight: normal; font-size: 12px; color: #000; width: 25%; position: relative;">
                                                            <asp:Label ID="docDate" Text="Document Date" runat="server" meta:resourcekey="docDateResource1"></asp:Label>
                                                        </td>
                                                        <td align="left" style="width: 50%; height: 15%;">
                                                            <asp:TextBox ID="txtDocDate" runat="server"  CssClass ="Txtboxsmall" TabIndex="1" MaxLength="1"
                                                                Style="text-align: justify" ValidationGroup="MKE" meta:resourcekey="txtDocDateResource1" />
                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtDocDate"
                                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                Enabled="True" />
                                                            <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtDocDate"
                                                                PopupButtonID="ImgBntCalc" Enabled="True" />
                                                            <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgBntCalcResource1" />
                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                ControlToValidate="txtDocDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="font-weight: normal; font-size: 12px; color: #000; width: 25%;">
                                                            <asp:Label ID="lbldTitle" runat="server" Text="Document Title" meta:resourcekey="lbldTitleResource1"></asp:Label>
                                                        </td>
                                                        <td align="left" style="width: 75%;">
                                                            <asp:TextBox runat="server" ID="txtdTitle" TabIndex="2" CssClass="Txtboxsmall" meta:resourcekey="txtdTitleResource1"></asp:TextBox>
                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="font-weight: normal; font-size: 12px; color: #000; width: 25%;">
                                                            <asp:Label ID="lblDrName" runat="server" Text="Doctor Name" meta:resourcekey="lblDrNameResource1"></asp:Label>
                                                        </td>
                                                        <td align="left" style="width: 75%;">
                                                            <asp:TextBox runat="server" ID="txtDrname" TabIndex="3" CssClass ="Txtboxsmall" meta:resourcekey="txtDrnameResource1"></asp:TextBox>
                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <asp:CheckBox ID="chkBox" runat="server" onclick="javascript:showCareCenterpanel();"
                                                                Checked="True" Text="Perform With Same Organization" meta:resourcekey="chkBoxResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <table id="tblCarecentre" border="0" style="display: none;">
                                                                <tr>
                                                                    <td style="font-weight: normal; font-size: 12px; color: #000; width: 25%;">
                                                                        <asp:Label ID="lblCcenterName" runat="server" Text="Care Center Name" meta:resourcekey="lblCcenterNameResource1"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 75%">
                                                                        <asp:TextBox runat="server" ID="txtCCName" CssClass ="Txtboxsmall" meta:resourcekey="txtCCNameResource1"></asp:TextBox>
                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="font-weight: normal; font-size: 12px; color: #000; width: 25%;">
                                                                        <asp:Label ID="lblCLocation" runat="server" Text="CareCenter Location" meta:resourcekey="lblCLocationResource1"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 75%;">
                                                                        <asp:TextBox runat="server" ID="txtCLocation" CssClass ="Txtboxsmall" meta:resourcekey="txtCLocationResource1"></asp:TextBox>
                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" align="center">
                                                            <asp:Button ID="btnAttach" runat="server" OnClientClick="javascript:return ShowPanel();"
                                                                Text="Attach File" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                                OnClick="btnAttach_Click" meta:resourcekey="btnAttachResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: bold; font-size: 13px; height: 47px; text-align: center;">
                                            <asp:Label ID="Rs_SelectFilestoUpload" Text="Select File's to Upload" runat="server"
                                                meta:resourcekey="Rs_SelectFilestoUploadResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Panel ID="Panel3" CssClass="dataheader2" BorderWidth="1px" runat="server" meta:resourcekey="Panel3Resource1">
                                                <table border="0" width="100%">
                                                    <tr>
                                                        <td>
                                                            <uc2:ImageUploadManager ID="ImageUploadManager1" BatchID="0" MaxImageSize="5242880"
                                                                TempUploadPath="OldNotes" EnableState="true" TargetFormID="prFrm" IconWidth="100"
                                                                runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr align="center">
                                                        <td>
                                                            <asp:Panel ID="pnlSavebtn" Enabled="False" runat="server" meta:resourcekey="pnlSavebtnResource1">
                                                                <asp:Button ID="btnSave" runat="server" Text="Save" class="btn" onmouseout="this.className='btn'"
                                                                    onmouseover="this.className='btn btnhov'" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:HiddenField ID="hidPOldnotesID" runat="server" />
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
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
