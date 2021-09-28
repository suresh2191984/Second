<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SurgeryBilling.aspx.cs" Inherits="InPatient_SurgeryBilling"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/SurgeryBilling.ascx" TagName="SurgeryBilling"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientCreditLimt.ascx" TagName="CreditLimt"
    TagPrefix="uc16" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Surgery Billing</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
         <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />
    <link href="../StyleSheets/DHEBAdder.css" rel="Stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <script src ="../scripts/MessageHandler.js" language ="javascript" type ="text/javascript" ></script>

    <script language="javascript" type="text/javascript">
        var userMsg;
        function CreditLimitCheck() {
            if (document.getElementById('hdnOrgCreditLimt').value == "Y" && document.getElementById('ucCreditLimit_hdnBalCreditLimit').value != "" && document.getElementById('ucCreditLimit_hdnCreditLimt').value > 0) {
                var GrandTotal = document.getElementById('txtGrandTotal').value;
                if (Number(GrandTotal) > Number(document.getElementById('ucCreditLimit_hdnBalCreditLimit').value)) {
                
                userMsg = SListForApplicationMessages.Get('InPatient\\SurgeryBilling.aspx_4');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                    alert('Collect Advance or Set Credit Limit or Make Payment');
                    return false;
                    }
                }
            }
            else {
                return checkForValues();
            }
        }
        function CreditLimitExit() {
         userMsg = SListForApplicationMessages.Get('InPatient\\SurgeryBilling.aspx_4');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
            alert('Collect Advance or Set Credit Limit or Make Payment');
            return false;
            }
        }
        function checkForValues() {
            if (document.getElementById('SurgeryBilling1_txtSurgigalFee').value == "" && document.getElementById('SurgeryBilling1_txtChiefSurgenFee').value == "") {
              userMsg = SListForApplicationMessages.Get('InPatient\\SurgeryBilling.aspx_1');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                alert('Provide the surgical fee or chief surgeon fee');
                             return false;
                
                }
                document.getElementById('SurgeryBilling1_txtSurgigalFee').focus();
                return false;
            }

            if (document.getElementById('SurgeryBilling1_txtBillDate').value == "") {
             userMsg = SListForApplicationMessages.Get('InPatient\\SurgeryBilling.aspx_2');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                alert('Provide the bill date');
                             return false;
                
                }
                document.getElementById('SurgeryBilling1_txtBillDate').focus();
                return false;
            }

            if (document.getElementById('SurgeryBilling1_txtBillDate').value == "") {
             userMsg = SListForApplicationMessages.Get('InPatient\\SurgeryBilling.aspx_3');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                alert("Enter The Bill Date");
                             return false;
                
                }
                document.getElementById('SurgeryBilling1_txtBillDate').focus();
                return false;
            }



        }
        
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server">
    <asp:ScriptManager ID="scrpt" runat="server">
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
                <uc8:PatientHeader ID="PatientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc121:LeftMenu ID="LeftMenu1" runat="server" />
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
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr id="trCreditLimit" runat="server">
                                <td>
                                    <uc16:CreditLimt ID="ucCreditLimit" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc2:SurgeryBilling ID="SurgeryBilling1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:HiddenField ID="hdnSurgeryBillingID" runat="server" />
                                    <asp:Button ID="btnAddToDueChart" runat="server" Text="Make Dues" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnAddToDueChart_Click"
                                        OnClientClick="javascript:return checkForValues();" meta:resourcekey="btnAddToDueChartResource1" />
                                    <asp:Button ID="btnMakePayment" runat="server" Text="Make Payment" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnMakePayment_Click"
                                        OnClientClick="javascript:return checkForValues();" meta:resourcekey="btnMakePaymentResource1" />
                                    <asp:Button ID="btnClose" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnClose_Click" meta:resourcekey="btnCloseResource1"
                                        Width="60px" />
                                </td>
                            </tr>
                        </table>
                        <br />
                    </div>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnOrgCreditLimt" runat="server" Value="N" />
        <uc5:Footer ID="Footer1" runat="server" />
            <asp:HiddenField ID ="hdnMessages" runat ="server" />

    </div>
    </form>
</body>
</html>
