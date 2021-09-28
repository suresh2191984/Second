<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InBoundReferral.aspx.cs"
    Inherits="Reception_InBoundReferral" meta:resourcekey="PageResource1" %>

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
    <title>In Bound Referral</title>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function orderValidation() {
            if (document.getElementById("pVisitid").value == '') {
            
           var  userMsg = SListForApplicationMessages.Get('Referrals\\InBoundReferral.aspx_1');
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
            if (document.getElementById("pRefId").value == '') {
             var  userMsg = SListForApplicationMessages.Get('Referrals\\InBoundReferral.aspx_1');
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

        }

    </script>

</head>
<body oncontextmenu="return false;">
    <form id="Rec" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <input type="hidden" id="pVisitid" runat="server" />
    <input type="hidden" id="pURN" runat="server" value="-1" />
    <input type="hidden" id="pIspatient" runat="server" />
    <input type="hidden" id="pRefId" runat="server" />
    <input type="hidden" id="pId" runat="server" />
    <input type="hidden" id="pRefdetailsId" runat="server" />
    <input type="hidden" id="pReferToOrg" runat="server" />
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                        <table class="w-100p">
                            <tr>
                                <td class="a-center">
                                    <%--    <div class="defaultfontcolor dataheader2">
                            <asp:Panel ID="pnlPSearch" runat="server" DefaultButton="btnSearch">
                                    <table border="0" cellpadding="3" cellspacing="0" class="defaultfontcolor">
                                        <tr>
                                            <td>
                                                Patient URN&nbsp; :
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtURN" Width="120px" runat="server">
                                                </asp:TextBox>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Refering Org&nbsp;&nbsp; :
                                            </td>
                                            <td align="left">
                                                <asp:DropDownList ID="ddlReferedOrg" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Status&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlStatus" Width="120px" runat="server">
                                                    <asp:ListItem>Open</asp:ListItem>
                                                    <asp:ListItem>Picked</asp:ListItem>
                                                    <asp:ListItem>Cancel</asp:ListItem>
                                                    <asp:ListItem>Reject</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Refered Date :
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtReferedDate" runat="server" CssClass="txtboxps"></asp:TextBox>
                                                <asp:ImageButton ID="ImgBntCalc" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png" />
                                                <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" AcceptNegative="Left"
                                                    DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                                                    MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                                                    TargetControlID="txtReferedDate" />
                                                <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                    ControlToValidate="txtReferedDate" Display="Dynamic" EmptyValueBlurredText="*"
                                                    EmptyValueMessage="Date is required" InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid"
                                                    TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE" />
                                                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                                    TargetControlID="txtReferedDate" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 15px">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" onclick="btnSearch_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                    </asp:Panel>
                                    </div>--%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc2:Referrals ID="Referrals1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="blackfontcolorbig" height="32px">
                                </td>
                            </tr>
                            <tr>
                                <td class="defaultfontcolor">
                                    <div id="divAction" visible="false" runat="server">
                                        <asp:Label ID="Rs_SelectaRecordandperformoneofthefollowing" Text="Select a Record and perform one of the following"
                                            runat="server" meta:resourcekey="Rs_SelectaRecordandperformoneofthefollowingResource1"></asp:Label>
                                        <asp:DropDownList ID="dList"  CssClass ="ddlmedium" runat="server" meta:resourcekey="dListResource1">
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
