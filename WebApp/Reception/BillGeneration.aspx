<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillGeneration.aspx.cs" Inherits="BillGeneration"
    meta:resourcekey="PageResource1" %>

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
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Bill Print</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">

        function checkTotal(id) {
            x = id.split("_");
           if (parseFloat(document.getElementById(x[0] + '_txtNetAmount').value) != parseFloat(parseFloat(document.getElementById(x[0] + '_txtAmountReceived').value) + parseFloat(document.getElementById(x[0] + '_txtAmountDue').value)))
           {
               var userMsg = SListForApplicationMessages.Get('Reception\\BillGeneration.aspx_1');
                if (userMsg != null)
                {
                    alert(userMsg);
                    return false;
                }

                else
                 {
                     alert('The total is incorrect. Please check');
                     return false;
                 }
                //return false;
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
                        <table border="0" cellpadding="2" cellspacing="1" width="100%">
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel1" CssClass="dataheader2" BorderWidth="1px" runat="server" meta:resourcekey="Panel1Resource1">
                                        <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    <asp:Label ID="Rs_PatientNo" Text="Patient No:" runat="server" meta:resourcekey="Rs_PatientNoResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    <asp:Label ID="lblPatientNo" runat="server" meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 13%;" align="left">
                                                    <asp:Label ID="Rs_PatientName" Text="Patient Name:" runat="server" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000;" align="left">
                                                    <asp:Label ID="lblPatientName" runat="server" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    <asp:Label ID="Rs_Gender" Text="Gender:" runat="server" meta:resourcekey="Rs_GenderResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                    <asp:Label ID="lblGender" runat="server" meta:resourcekey="lblGenderResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    <asp:Label ID="Rs_Age" Text="Age:" runat="server" meta:resourcekey="Rs_AgeResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                    <asp:Label ID="Rs_VisitNo" Text="Visit No:" runat="server" meta:resourcekey="Rs_VisitNoResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    <asp:Label ID="lblVisitNo" runat="server" meta:resourcekey="lblVisitNoResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="dinves" runat="server" style="display: block">
                                        <uc2:InvestigationControl ID="InvestigationControl1" runat="server" />
                                        <asp:Table BorderWidth="0px" runat="server" Width="40%" meta:resourcekey="TableResource1">
                                            <asp:TableRow Height="15px" BorderWidth="0" meta:resourcekey="TableRowResource1">
                                                <asp:TableCell HorizontalAlign="Center" meta:resourcekey="TableCellResource1">
                                                    <asp:Button ID="btnBillShow" runat="server" Text="Generate Bill" OnClick="btnBillShow_Click"
                                                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                        meta:resourcekey="btnBillShowResource1" />
                                                    <asp:Button ID="btnHome" runat="server" Text="Home" OnClick="btnHome_Click" CssClass="btn"
                                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnHomeResource1" />
                                                </asp:TableCell></asp:TableRow>
                                        </asp:Table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="dBill" runat="server">
                                        <asp:LinkButton ID="lnkAddMore" CssClass="colorsample" runat="server" OnClick="lnkAddMore_Click"
                                            meta:resourcekey="lnkAddMoreResource1"><u>Add More..</u></asp:LinkButton>
                                        <uc8:BillPrintControl ID="BillPrintCtrl" runat="server" />
                                        <asp:Table CellPadding="4" CssClass="colorforcontentborder" CellSpacing="0" BorderWidth="0px"
                                            runat="server" ID="BtnTab" Width="65%" meta:resourcekey="BtnTabResource1">
                                            <asp:TableRow Height="15px" BorderWidth="0" meta:resourcekey="TableRowResource2">
                                                <asp:TableCell HorizontalAlign="Center" meta:resourcekey="TableCellResource2">
                                                    <asp:Button ID="btnFinish" UseSubmitBehavior="true" runat="server" OnClientClick="return checkTotal(this.id);"
                                                        OnClick="btnFinish_Click" Text="Finish" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" meta:resourcekey="btnFinishResource1" />
                                                    <asp:Button ID="btnCancel" runat="server" Text="Home" OnClick="btnCancel_Click" CssClass="btn"
                                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnCancelResource1" />
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
    </div>
    </form>
</body>
</html>
