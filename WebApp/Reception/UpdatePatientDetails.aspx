<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UpdatePatientDetails.aspx.cs"
    Inherits="Reception_UpdatePatientDetails" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/URNControl.ascx" TagName="URNControl" TagPrefix="uc7" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Patient Details</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>
     <script src ="../scripts/MessageHandler.js" language ="javascript" type ="text/javascript" ></script>

    <script type="text/javascript" language="javascript">
        var z;
            var userMsg;
        function pageLoad() {
            document.getElementById('txtPatientName').focus();
        }
        function age() {
            if (document.getElementById('txtAge').value == '') {
                document.getElementById('txtAge').value = '';
            }
        }
        function Validation() { 
         if (document.getElementById('txtPatientName').value.trim() == '') {
       userMsg = SListForApplicationMessages.Get('Reception\\UpdatePatientDetails.aspx_1');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                alert('Provide name for the patient');
                             return false;
                
                }
        document.getElementById('txtPatientName').focus();
        return false;
    }

    if (document.getElementById('txtAge').value.trim() == '') {
     userMsg = SListForApplicationMessages.Get('Reception\\UpdatePatientDetails.aspx_2');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{

                alert('Provide age for the  patient');
                             return false;
                
                }
        document.getElementById('txtAge').focus();
        return false;
    }

    //    if (document.getElementById('patientAddressCtrl_txtAddress2').value == '') 
    //    {
    //        alert('Please Enter Street/Road Name');
    //        document.getElementById('patientAddressCtrl_txtAddress2').focus();
    //        return false;
    //    }
    if (document.getElementById('URNControl1_txtURNo').value != '') {

        if (document.getElementById('URNControl1_ddlUrnType').value == '0') {
         userMsg = SListForApplicationMessages.Get('Reception\\UpdatePatientDetails.aspx_4');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{

                alert('Provide the URN type ');
                             return false;
                
                }
            document.getElementById('URNControl1_ddlUrnType').focus();
            return false;
        }
    }  
//    if (document.getElementById('ucPAdd_txtCity').value.trim() == '') {
//        alert('Please Enter City');
//        document.getElementById('ucPAdd_txtCity').focus();
//        return false;
//    }
   
    
        }
    </script>

</head>
<body id="oneColLayout" onload="pageLoad();" oncontextmenu="return false;">
    <form id="prFrm" runat="server" defaultbutton="btnFinish">
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
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
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
                        <table border="0" cellpadding="2" cellspacing="1" width="100%">
                            <tr>
                                <td height="32">
                                    <table border="0" id="mytable1" cellpadding="4" cellspacing="0" width="100%">
                                        <tr>
                                            <td colspan="5" id="us">
                                                <asp:Label ID="Rs_UpdatePatientsDetails" Text="Update Patient's Details." 
                                                    runat="server" meta:resourcekey="Rs_UpdatePatientsDetailsResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel1" CssClass="dataheader2" BorderWidth="1px" runat="server" 
                                        meta:resourcekey="Panel1Resource1">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="padding-top: 5px;">
                                                    <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td align="right" style="width: 18%;">
                                                                <asp:Label ID="Rs_PatientsName" Text="Patient's Name" runat="server" 
                                                                    meta:resourcekey="Rs_PatientsNameResource1"></asp:Label>
                                                            </td>
                                                            <td style="width: 32%;">
                                                                <asp:DropDownList ID="ddSalutation" runat="server" Width="70px" TabIndex="1"  CssClass ="ddl"
                                                                    meta:resourcekey="ddSalutationResource1">
                                                                </asp:DropDownList>
                                                                <asp:TextBox ID="txtPatientName" runat="server" MaxLength="60" TabIndex="2"  CssClass ="Txtboxsmall"
                                                                    meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" style="width: 15%;">
                                                                <asp:Label ID="Rs_DOB" Text="DOB" runat="server" 
                                                                    meta:resourcekey="Rs_DOBResource1"></asp:Label>
                                                            </td>
                                                            <td style="width: 35%;">
                                                                <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB"
                                                                    Mask="99/99/9999" MaskType="Date"
                                                                    ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                    CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                                <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB"
                                                                    PopupButtonID="ImgBntCalc" Enabled="True" />
                                                                <asp:TextBox ID="tDOB" ToolTip="Date Of Birth" runat="server" Width="130px" MaxLength="1" CssClass ="Txtboxsmall"
                                                                    Style="text-align: justify" ValidationGroup="MKE" TabIndex="5" 
                                                                    onblur="javascript:countAgeLab(this.id);" meta:resourcekey="tDOBResource1" />
                                                                <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                    CausesValidation="False" meta:resourcekey="ImgBntCalcResource1" />
                                                                <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                    ControlToValidate="tDOB" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" 
                                                                    meta:resourcekey="MaskedEditValidator5Resource1" />
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" /><img src="../Images/starbutton.png"
                                                                    alt="" align="middle" />
                                                            </td>
                                                            <td align="right" style="display: none;">
                                                                <asp:Label ID="Rs_Age" Text="Age" runat="server" 
                                                                    meta:resourcekey="Rs_AgeResource1"></asp:Label>
                                                            </td>
                                                            <td style="display: none;">
                                                                <asp:TextBox ID="txtAge" Width="65px" runat="server" MaxLength="3" TabIndex="5"  CssClass ="Txtboxsmall"
                                                                    meta:resourcekey="txtAgeResource1"></asp:TextBox>
                                                                <asp:DropDownList ID="ddlAgeUnit" runat="server" 
                                                                   CssClass ="ddl"  meta:resourcekey="ddlAgeUnitResource1">
                                                                    <asp:ListItem Value="Day(s)" meta:resourcekey="ListItemResource1">Day(s)</asp:ListItem>
                                                                    <asp:ListItem Value="Week(s)" meta:resourcekey="ListItemResource2">Week(s)</asp:ListItem>
                                                                    <asp:ListItem Value="Month(s)" meta:resourcekey="ListItemResource3">Month(s)</asp:ListItem>
                                                                    <asp:ListItem Value="Year(s)" Selected="True" 
                                                                        meta:resourcekey="ListItemResource4">Year(s)</asp:ListItem>
                                                                </asp:DropDownList>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                            <td align="right" style="width: 12%;">
                                                                <asp:Label ID="Rs_Sex" Text="Sex" runat="server" 
                                                                    meta:resourcekey="Rs_SexResource1"></asp:Label>
                                                            </td>
                                                            <td style="width: 32%;">
                                                                <asp:DropDownList ID="ddSex" runat="server" TabIndex="4"  CssClass="ddl"
                                                                    meta:resourcekey="ddSexResource1">
                                                                    <asp:ListItem Value="M" meta:resourcekey="ListItemResource5">Male</asp:ListItem>
                                                                    <asp:ListItem Value="F" meta:resourcekey="ListItemResource6">Female</asp:ListItem>
                                                                </asp:DropDownList>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" style="padding-bottom: 2px;">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td>
                                                                <uc7:URNControl ID="URNControl1" runat="server" StartIndex="9" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-bottom: 2px;">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td>
                                                                <uc8:AddressControl ID="ucPAdd" runat="server" StartIndex="6" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table border="0" width="100%">
                                                        <tr>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_Nationality" Text="Nationality" runat="server" 
                                                                    meta:resourcekey="Rs_NationalityResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlNationality" runat="server" TabIndex="11" 
                                                                   CssClass ="ddlsmall"  meta:resourcekey="ddlNationalityResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="Rs_Race"  Text="Race" runat="server" 
                                                                    meta:resourcekey="Rs_RaceResource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddRace" runat="server" TabIndex="16"  CssClass ="ddlsmall"
                                                                    meta:resourcekey="ddRaceResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 18%" align="right">
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td align="right">
                                                            </td>
                                                            <td style="width: 31%;">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" style="width: 18%;">
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td align="right">
                                                            </td>
                                                            <td style="width: 30%;" colspan="3">
                                                            </td>
                                                        </tr>
                                                        <tr style="display: block;">
                                                            <td colspan="4">
                                                                <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                                                    <tr>
                                                                        <td align="right" style="display: none;">
                                                                            <asp:Label ID="Rs_Mobile" Text="Mobile" runat="server" 
                                                                                meta:resourcekey="Rs_MobileResource1"></asp:Label>
                                                                        </td>
                                                                        <td style="display: none;">
                                                                            <asp:TextBox ID="txtMobile" TabIndex="18" ToolTip="Contact Mobile Number" 
                                                                                CssClass ="Txtboxsmall" runat="server" meta:resourcekey="txtMobileResource1"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                    <asp:Button ID="btnFinish" runat="server" OnClientClick="return Validation();" OnClick="btnFinish_Click"
                                        Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                        Width="42px" meta:resourcekey="btnFinishResource1" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                                        CssClass="btn" onmouseover="this.className='btn btnhov'" 
                                        onmouseout="this.className='btn'" meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
        <asp:HiddenField ID ="hdnMessages" runat ="server" />
    </div>
    </form>
</body>
</html>
