<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OutBoundReferral.aspx.cs"
    Inherits="Reception_OutBoundReferral" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Referrals.ascx" TagName="Referrals" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Out Bound Referral</title>
    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function orderValidation() {
            if (document.getElementById("pVisitid").value == '') {
            
                var userMsg = SListForApplicationMessages.Get('Referrals\\OutBoundReferral.aspx_1');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{

                alert('Select a Patient');
                return false;
                }
            }
            var pValue = document.getElementById('dList').options[document.getElementById('dList').selectedIndex].text;
            var status = document.getElementById('pStatus').value;

            if (document.getElementById('pStatus').value == 'Picked') {
                if (pValue != 'Print Referral') {
                 var userMsg = SListForApplicationMessages.Get('Referrals\\OutBoundReferral.aspx_2');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{

                    alert('This Referral has already been picked ');
                    return false ;
                    }
                    document.getElementById('dList').focus();
                    return false;
                }
            }

            if (document.getElementById('pStatus').value == 'Cancel') {
                if (pValue == 'Cancel Referral') {
                 var userMsg = SListForApplicationMessages.Get('Referrals\\OutBoundReferral.aspx_3');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{

                    alert('This Referral has already been cancelled');
                    return false ;
                    }
                    document.getElementById('dList').focus();
                    return false;
                }
                if (pValue == 'Book Slots') {
                 var userMsg = SListForApplicationMessages.Get('Referrals\\OutBoundReferral.aspx_2');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                    alert('This Referral has already been picked ');
                    return false ;
                    }
                    document.getElementById('dList').focus();
                    return false;
                }
            }
            if (pValue == "Cancel Referral") {
                var agree = confirm("Are you sure you wish to cancel the Referral?");
                if (agree)
                    return true;
                else
                    return false;

            }
        }

    </script>

</head>
<body oncontextmenu="return false;">
    <form id="Rec" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <input type="hidden" id="pVisitid" runat="server" />
    <input type="hidden" id="Hidden1" runat="server" value="-1" />
    <input type="hidden" id="pIspatient" runat="server" />
    <input type="hidden" id="pRefId" runat="server" />
    <input type="hidden" id="pRefdetailsId" runat="server" />
    <input type="hidden" id="pId" runat="server" />
    <input type="hidden" id="pURN" runat="server" />
    <input type="hidden" id="pReferToOrg" runat="server" />
    <input type="hidden" id="pStatus" runat="server" />
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <table class="w-100p searchPanel">
                             <tr>
                                <td class="a-center">
                                    <div class="defaultfontcolor dataheader2">
                                        <asp:Panel ID="pnlPSearch" runat="server" DefaultButton="btnSearch" meta:resourcekey="pnlPSearchResource1">
                                            <table class="defaultfontcolor">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_PatientURN" Text="Patient URN:" runat="server" meta:resourcekey="Rs_PatientURNResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtURN"  CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtURNResource1"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_ReferedOrg" Text="Refered Org:" runat="server" meta:resourcekey="Rs_ReferedOrgResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:DropDownList ID="ddlReferedOrg"  CssClass ="ddlmedium" runat="server" meta:resourcekey="ddlReferedOrgResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-left"> 
                                                        <asp:Label ID="Rs_Status" Text="Status:" runat="server" meta:resourcekey="Rs_StatusResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlStatus" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlStatusResource1">
                                                            <asp:ListItem meta:resourcekey="ListItemResource1">Open</asp:ListItem>
                                                            <asp:ListItem meta:resourcekey="ListItemResource2">Picked</asp:ListItem>
                                                            <asp:ListItem meta:resourcekey="ListItemResource3">Cancel</asp:ListItem>
                                                            <asp:ListItem meta:resourcekey="ListItemResource4">Reject</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_ReferedDate" Text="Refered Date:" runat="server" meta:resourcekey="Rs_ReferedDateResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:TextBox ID="txtReferedDate" runat="server"  CssClass="Txtboxsmall" meta:resourcekey="txtReferedDateResource1"></asp:TextBox>
                                                        <asp:ImageButton ID="ImgBntCalc" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            meta:resourcekey="ImgBntCalcResource1" />
                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" AcceptNegative="Left"
                                                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                            TargetControlID="txtReferedDate" CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder=""
                                                            CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                            CultureTimePlaceholder="" Enabled="True" />
                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                            ControlToValidate="txtReferedDate" Display="Dynamic" EmptyValueBlurredText="*"
                                                            EmptyValueMessage="Date is required" InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid"
                                                            TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5"
                                                            meta:resourcekey="MaskedEditValidator5Resource1" />
                                                        <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                                            TargetControlID="txtReferedDate" Enabled="True" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="h-15">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4">
                                                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="h-10">
                                </td>
                            </tr>
                            <tr>
                                <td class="h-0">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc2:Referrals ID="Referrals1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="blackfontcolorbig h-32">
                                </td>
                            </tr>
                            <tr>
                                <td class="defaultfontcolor">
                                    <div id="divAction" visible="false" runat="server">
                                        <asp:Label ID="Rs_Info" Text="Select a Record and perform one of the following" runat="server"
                                            meta:resourcekey="Rs_InfoResource1"></asp:Label>
                                        <asp:DropDownList ID="dList" CssClass ="ddlmedium" runat="server" meta:resourcekey="dListResource1">
                                        </asp:DropDownList>
                                        <asp:Button ID="bGo" runat="server" Text="Go" CssClass="btn" OnClientClick="javascript:return orderValidation();"
                                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="bGo_Click"
                                            meta:resourcekey="bGoResource1" /></div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </div>
     <Attune:Attunefooter ID="Attunefooter" runat="server" />            
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

</body>
</html>
