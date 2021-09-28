<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SampleBillPrint.aspx.cs"
    Inherits="SampleBillPrint" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/SampleBillPrint.ascx" TagName="BillPrintControl"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/InvestigationSearchControl.ascx" TagName="InvestigationSearchControl"
    TagPrefix="uc2" %>
    <%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%--<%@ Register Src="../CommonControls/InvestigationSearchControl.ascx" TagName="InvestigationControl"
    TagPrefix="uc2" %>--%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Bill Print</title>
   <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>
    <script src ="../scripts/MessageHandler.js" language ="javascript" type ="text/javascript" ></script>
<%--<script language="javascript" type="text/javascript">


    function SetOtherCurrValues() {
        var pnetAmt = 0;
        pnetAmt = document.getElementById('BillPrintCtrl_txtNetAmount').value == "" ? "0" : document.getElementById('BillPrintCtrl_txtNetAmount').value;
        var ConValue = document.getElementById('BillPrintCtrl_OtherCurrencyDisplay1').id;
        SetPaybleOtherCurr(pnetAmt, ConValue, true);
    }

    GetCurrencyValues();
</script>--%>

    <script language="javascript" type="text/javascript">
        function setCheckHospitalCredit(id) {
            if (document.getElementById(id).value != "0") {
                document.getElementById('hdnUpdateHospitalID').value = document.getElementById(id).value;
                document.getElementById('BillPrintCtrl_hdnCheckHospitalCredit').value = "0";
                document.getElementById('BillPrintCtrl_chkUseCredit').checked = true;
            }
            else {
                document.getElementById('BillPrintCtrl_hdnCheckHospitalCredit').value = "1";
                document.getElementById('BillPrintCtrl_chkUseCredit').checked = false;
            }
        }
        function chkBill(idval) {
            var alte1 = PaymentSaveValidation();
            var alte = checkBillForTotal(idval);
            if (alte == true) {
               
                if (alte1 == true) {
                    document.getElementById('btnFinish').style.display = 'none';
                    return true;
                }
                else {
                    return false;
                } 
            }
            else {
                return false;
                      
            }
        }
    </script>

</head>
<body  oncontextmenu="return true;">
    <form id="prFrm" defaultbutton="btnFinish" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index:2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>"  class="logostyle" />
                </div>
            </div>
                <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="ReceptionHeader" runat="server" />
             </div>
                    <div style="float: right;"  class="Rightheader"></div>
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
                            <tr id="trPriority" runat="server" style="display: none;">
                                <td align="center">
                                    <asp:Label ID="lblPriority" Font-Bold="True" ForeColor="#403F3E" runat="server" 
                                        meta:resourcekey="lblPriorityResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel1" CssClass="dataheader2" BorderWidth="1px" runat="server" 
                                        meta:resourcekey="Panel1Resource1">
                                        <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    <asp:Label ID="Rs_PatientNo" Text="Patient No:" runat="server" 
                                                        meta:resourcekey="Rs_PatientNoResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    <asp:Label ID="lblPatientNo" runat="server" 
                                                        meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 13%;" align="left">
                                                    <asp:Label ID="Rs_PatientName" Text="Patient Name: "  runat="server" 
                                                        meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                                    
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000;" align="left">
                                                    <asp:Label ID="lblPatientName" runat="server" 
                                                        meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                   <asp:Label ID= "Rs_Gender" Text="Gender:" runat="server" 
                                                        meta:resourcekey="Rs_GenderResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                    <asp:Label ID="lblGender" runat="server" meta:resourcekey="lblGenderResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    <asp:Label ID="Rs_Age" Text="Age:" runat="server" 
                                                        meta:resourcekey="Rs_AgeResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                    <asp:Label ID="Rs_VisitNo" Text="Visit No:"  runat="server" 
                                                        meta:resourcekey="Rs_VisitNoResource1"></asp:Label>
                                                    
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    <asp:Label ID="lblVisitNo" runat="server" 
                                                        meta:resourcekey="lblVisitNoResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="hidden" id="hdnUpdateHospitalID" runat="server" value="0" />
                                    <div id="trHospital" class="dataheaderInvCtrl" style="display: none; width: 97%"
                                        runat="server">
                                        <table border="0" width="100%" cellpadding="4" cellspacing="0">
                                            <tr>
                                                <td align="right" style="width: 20%;">
                                                    <asp:Label runat="server" ID="lblHospital" Text="Select a Hospital" 
                                                        meta:resourcekey="lblHospitalResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlHospital" ToolTip="Select Refering Hospital" onchange="javascript:setCheckHospitalCredit(this.id);"
                                                        runat="server" meta:resourcekey="ddlHospitalResource1">
                                                    </asp:DropDownList>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="dBill" runat="server">
                                        <asp:LinkButton ID="lnkAddMore" CssClass="colorsample" runat="server" ToolTip="Click here to Add More Investigation / Group / Package / Consumables"
                                            OnClick="lnkAddMore_Click" meta:resourcekey="lnkAddMoreResource1"><u>Add More..</u></asp:LinkButton>
                                        <uc8:BillPrintControl ID="BillPrintCtrl" runat="server" />
                                        <asp:Table CellPadding="4" CssClass="colorforcontentborder" CellSpacing="0" BorderWidth="0px"
                                            runat="server" ID="BtnTab" Width="65%">
                                            <asp:TableRow Height="15px" BorderWidth="0" 
                                                >
                                                <asp:TableCell HorizontalAlign="Center">
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Button ID="btnFinish" ToolTip="Click here to Save & View the Bill" Style="cursor: pointer;"
                                                                    OnClientClick="javascript:if(!chkBill(this.id)) return false;" runat="server"
                                                                    OnClick="btnFinish_Click" Text="Finish" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                    onmouseout="this.className='btn'" />
                                                            

                                                            </td>
                                                            <td>
                                                                <asp:Button ID="btnCancel" runat="server" Text="Home" ToolTip="Click here to Cancel the Bill, View the Home Page"
                                                                    OnClick="btnCancel_Click" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                    onmouseout="this.className='btn'"  />
                                                            

                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </div>
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
