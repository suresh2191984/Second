<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HISAdmission.aspx.cs" Inherits="Reception_HISAdmission"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/PhySchedule.ascx" TagName="PSchedule" TagPrefix="ps" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Reception</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>



    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript">
        function NurseHIS() {

            if (document.getElementById('rdoOxygenRequiredYes').checked) {
                document.getElementById('divShow1').style.display = 'block';
            }
            else {
                document.getElementById('divShow1').style.display = 'none';
            }
        }

        function saveHIS() {
            if (document.getElementById('rdoOxygenRequiredYes').checked == true) {

                if (document.getElementById('ddlModeofDelivery').value == '-----Select-----') {
                    var userMsg = SListForApplicationMessages.Get('Reception\HISAdmission.aspx_1');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;
                    }
                    else {
                     alert('Select mode of delivery');
                    return false;
                     }
                    document.getElementById('ddlModeofDelivery').focus();
                }
                if (document.getElementById('txtRateofDelivery').value == '') {
                 if (document.getElementById('ddlModeofDelivery').value == '-----Select-----') {
                    var userMsg = SListForApplicationMessages.Get('Reception\HISAdmission.aspx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                    return false;
                        
                    }else{

                        alert('Provide rate of delivery');
                    return false;
                        
                }
                    document.getElementById('txtRateofDelivery').focus();
                }
            }
            return true;
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="RecHome" runat="server">
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
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="RHead" runat="server" />
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
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <table class="tabletxt" width="100%" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="200px">
                                                <asp:Label ID="lblConfirmPatientCondition" runat="server" Text="Patient Condition"
                                                    meta:resourcekey="lblConfirmPatientConditionResource1"></asp:Label>
                                            </td>
                                            <td width="150px">
                                                <asp:DropDownList ID="ddlConfirmPatientCondition" runat="server" CssClass="selectoption4"
                                                    meta:resourcekey="ddlConfirmPatientConditionResource1">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table width="100%">
                            <tr>
                                <td class="bottombordercolor">
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table cellpadding="0" cellspacing="0" width="100%" height="25px">
                            <tr>
                                <td>
                                    <table cellpadding="0" cellspacing="0" height="25px">
                                        <tr>
                                            <td width="147px">
                                                <asp:Label ID="lblOxygenRequired" runat="server" Text="Oxygen Required" meta:resourcekey="lblOxygenRequiredResource1"></asp:Label>
                                            </td>
                                            <td width="65px">
                                                <asp:RadioButton ID="rdoOxygenRequiredYes" GroupName="Oxygen" runat="server" Text="Yes"
                                                    onClick="NurseHIS();" meta:resourcekey="rdoOxygenRequiredYesResource1" />
                                            </td>
                                            <td width="60px">
                                                <asp:RadioButton ID="rdoOxygenRequiredNo" GroupName="Oxygen" runat="server" Text="No"
                                                    onClick="NurseHIS();" meta:resourcekey="rdoOxygenRequiredNoResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <div id="divShow1" style="display: none">
                                        <table cellpadding="5" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblYes" runat="server" Text="Mode of Delivery" meta:resourcekey="lblYesResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlModeofDelivery" runat="server" CssClass="selectoption3"
                                                        meta:resourcekey="ddlModeofDeliveryResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblRateofDelivery" runat="server" Text="Rate of Delivery" meta:resourcekey="lblRateofDeliveryResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtRateofDelivery" runat="server" meta:resourcekey="txtRateofDeliveryResource1"></asp:TextBox>
                                                    <asp:Label ID="lbllmin" runat="server" Text="l/min" meta:resourcekey="lbllminResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td width="140px">
                                    <asp:Label ID="lblOrientationProvided" runat="server" Text="Orientation Provided"
                                        meta:resourcekey="lblOrientationProvidedResource1"></asp:Label>
                                </td>
                                <td width="60px">
                                    <asp:RadioButton ID="rdoOrientationProvidedYes" GroupName="Orientation" runat="server"
                                        Text="Yes" onClick="NurseHIS();" meta:resourcekey="rdoOrientationProvidedYesResource1" />
                                </td>
                                <td width="60px">
                                    <asp:RadioButton ID="rdoOrientationProvidedNo" GroupName="Orientation" runat="server"
                                        Text="No" onClick="NurseHIS();" meta:resourcekey="rdoOrientationProvidedNoResource1" />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table width="100%">
                            <tr>
                                <td class="bottombordercolor">
                                </td>
                            </tr>
                        </table>
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td colspan="6" height="10px">
                                </td>
                            </tr>
                            <tr height="28px">
                                <td colspan="2">
                                    <asp:Label ID="lblDieterySpecifications" runat="server" Text="Dietery Specifications"
                                        class="nursebgcolor" meta:resourcekey="lblDieterySpecificationsResource1"></asp:Label>
                                </td>
                                <td colspan="4">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" height="6px">
                                </td>
                            </tr>
                            <tr class="whiteborder">
                                <td width="120px">
                                    <asp:Label ID="lblDietType" runat="server" Text="Diet Type" meta:resourcekey="lblDietTypeResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlDietType" runat="server" CssClass="selectoption4" meta:resourcekey="ddlDietTypeResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lblDietPattern" runat="server" Text="Diet Pattern" meta:resourcekey="lblDietPatternResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlDietPattern" runat="server" CssClass="selectoption4" meta:resourcekey="ddlDietPatternResource1">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lblDietPlan" runat="server" Text="Diet Plan" meta:resourcekey="lblDietPlanResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlDietPlan" runat="server" CssClass="selectoption4" meta:resourcekey="ddlDietPlanResource1">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" height="10px">
                                </td>
                            </tr>
                        </table>
                        <table width="100%">
                            <tr>
                                <td class="bottombordercolor">
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="120px">
                                    <asp:Label ID="lblFluidRestriction" runat="server" Text="Fluid Restriction" meta:resourcekey="lblFluidRestrictionResource1"></asp:Label>
                                </td>
                                <td width="90px">
                                    <asp:TextBox ID="txtFluidRestriction" runat="server" meta:resourcekey="txtFluidRestrictionResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lbllmin1" runat="server" Text="l/min" meta:resourcekey="lbllmin1Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table width="100%">
                            <tr>
                                <td class="bottombordercolor">
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table cellspacing="0" cellpadding="0" width="95%">
                            <tr>
                                <td width="220px" colspan>
                                    <asp:CheckBox ID="chkVerifyIdentification" runat="server" Text="Verify Identification Marks"
                                        meta:resourcekey="chkVerifyIdentificationResource1" />
                                </td>
                                <td width="45px" align="right">
                                    1.&nbsp;&nbsp;&nbsp;
                                </td>
                                <td width="150px">
                                    <asp:TextBox ID="txtVerifyIdentificationMarks" ReadOnly="True" runat="server" meta:resourcekey="txtVerifyIdentificationMarksResource1"></asp:TextBox>
                                </td>
                                <td width="60px" align="right">
                                    2.&nbsp;&nbsp;&nbsp;
                                </td>
                                <td>
                                    <asp:TextBox ID="txtVerifyIdentificationMarks1" ReadOnly="True" runat="server" meta:resourcekey="txtVerifyIdentificationMarks1Resource1"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table width="100%">
                            <tr>
                                <td class="bottombordercolor">
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table cellspacing="0" cellpadding="0" width="95%">
                            <tr>
                                <td colspan="2" height="28px">
                                    <asp:Label ID="lblBelongingsHandover" runat="server" Text="Belongings Handover" CssClass="nursebgcolor"
                                        meta:resourcekey="lblBelongingsHandoverResource1"></asp:Label>
                                </td>
                                <td colspan="4">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" height="10px">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <asp:UpdatePanel ID="pnlBelong" runat="server">
                                        <ContentTemplate>
                                            <table>
                                                <tr>
                                                    <td align="left">
                                                        <asp:Label ID="lblHandOverItem" runat="server" Text="HandOver Item" meta:resourcekey="lblHandOverItemResource1"></asp:Label>
                                                        <asp:TextBox ID="txtBelongingHandover" runat="server" meta:resourcekey="txtBelongingHandoverResource1"></asp:TextBox>
                                                        <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                                            onmouseout="this.className='btn1'" OnClick="btnAdd_Click" meta:resourcekey="btnAddResource1" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <p style="margin: 5px;">
                                                            <asp:Table CellPadding="4" CssClass="colorforcontentborder" CellSpacing="0" BorderWidth="1px"
                                                                runat="server" ID="gridTab" Width="80%" meta:resourcekey="gridTabResource1">
                                                                <asp:TableRow CssClass="colorbillprt" BorderWidth="0px" runat="server" meta:resourcekey="TableRowResource1">
                                                                    <asp:TableHeaderCell BorderWidth="0px" runat="server" meta:resourcekey="TableHeaderCellResource1">
                                                                        <asp:Label ID="Rs_Remove" Text="Remove" runat="server" meta:resourcekey="Rs_RemoveResource1"></asp:Label>
                                                                    </asp:TableHeaderCell>
                                                                    <asp:TableHeaderCell runat="server" meta:resourcekey="TableHeaderCellResource2">
                                                                        <asp:Label ID="Rs_Belongings" Text="Belongings" runat="server" meta:resourcekey="Rs_BelongingsResource1"></asp:Label>
                                                                    </asp:TableHeaderCell>
                                                                </asp:TableRow>
                                                            </asp:Table>
                                                        </p>
                                                        <input type="hidden" id="did" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" height="10px">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" align="center">
                                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" OnClick="btnSave_Click" OnClientClick="return saveHIS()"
                                        meta:resourcekey="btnSaveResource1" />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table width="100%">
                            <tr>
                                <td class="bottombordercolor">
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
	<asp:HiddenField ID="hdnMessages" runat="server" />
    
    </form>
</body>
