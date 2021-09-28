<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ANCCaseSheet.aspx.cs" Inherits="ANC_ANCCaseSheet" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc13" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/FeesEntry.ascx" TagName="Billing" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/BillPrint.ascx" TagName="BillPrinting" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc12" %>
<%@ Register Src="~/ANC/ANCCaseSheet.ascx" TagName="ANCCaseSheet" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ANC Case Sheet</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script language="javascript" type="text/javascript">
        function avoiddoubleentry() {
            document.getElementById('btnOk').style.display = 'none';
        }

        function popupprint() {
            var prtContent = document.getElementById('printANCCS');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
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
                <uc1:MainHeader ID="OrgHeader" runat="server" />
                <uc13:PatientHeader ID="patientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
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
                        <table width="100%" enableviewstate="false">
                            <tr>
                                <td align="center">
                                    <div align="center" id="printANCCS">
                                        <uc2:ANCCaseSheet ID="ancCS" runat="server" />
                                    </div>
                                    <br />
                                    <uc8:Billing ID="billing" runat="server" />
                                    <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="return popupprint();" 
                                        meta:resourcekey="btnPrintResource1" Width="45px" />
                                    <asp:Button Text="OK" ID="btnOk" Visible="False" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="return avoiddoubleentry();"
                                        OnClick="btnOk_Click" meta:resourcekey="btnOkResource1" Width="38px" />
                                    <asp:Button Text="Edit" ID="btnEdit" Visible="False" runat="server" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" 
                                        onmouseout="this.className='btn'" OnClientClick="return avoiddoubleentry();"
                                        OnClick="btnEdit_Click" meta:resourcekey="btnEditResource1" Width="42px" />
                                    <%--<table width="100%">
                                        <tr>
                                            <td align="center">
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                <asp:Label ID="lblDocterName" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <table width="75%">
                                                    <tr>
                                                        <td>
                                                            <b>Vital Details</b></td>
                                                        <td>
                                                            <b>Clinical Details</b></td>
                                                        <td>
                                                            <b>Past Medical</b></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;</td>
                                                        <td>
                                                            &nbsp;</td>
                                                        <td>
                                                            &nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: left">
                                                            Pulse -
                                                            <asp:Label ID="lblPulse" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="text-align: left">
                                                            G-<sub>
                                                            <asp:Label ID="lblG" runat="server"></asp:Label></sub>
                                                            , P-<sub>
                                                            <asp:Label ID="lblP" runat="server"></asp:Label></sub>
                                                            , L-<sub>
                                                            <asp:Label ID="lblL" runat="server"></asp:Label></sub>
                                                            , A-<sub>
                                                            <asp:Label ID="lblA" runat="server"></asp:Label></sub>
                                                        </td>
                                                        <td>
                                                            &nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: left">
                                                            BP - 
                                                            <asp:Label ID="lblBP" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="text-align: left">
                                                            EDD -
                                                            <asp:Label ID="lblEDD" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            &nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: left">
                                                            RR -
                                                            <asp:Label ID="lblRR" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="text-align: left">
                                                            &nbsp;</td>
                                                        <td>
                                                            &nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: left">
                                                            Temp -
                                                            <asp:Label ID="lblTemp" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="text-align: left">
                                                            &nbsp;</td>
                                                        <td>
                                                            &nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: left">
                                                            Weight -
                                                            <asp:Label ID="lblWeight" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="text-align: left">
                                                            &nbsp;</td>
                                                        <td>
                                                            &nbsp;</td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td align="center" style="text-align: left">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td align="center" style="text-align: left">
                                                <asp:Label ID="lblComplaintDesc" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td align="center" style="text-align: left">
                                                TREATMENT :-</td>
                                        </tr>
                                        <tr>
                                            <td align="center" style="text-align: left">
                                                <asp:Label ID="lblPrescription" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" style="text-align: left">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td align="center" style="text-align: left">
                                                GENERAL ADVICE :-</td>
                                        </tr>
                                        <tr>
                                            <td align="center" style="text-align: left">
                                                <asp:Label ID="lblANCAdvice" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" style="text-align: left">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td align="center" style="text-align: left">
                                                Next Review Date :-
                                                <asp:Label ID="lblReviewDate" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <asp:Label ID="lblAdvice" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td align="right" nowrap="nowrap">
                                                            <asp:Button ID="btnPrint" Text="Print" CssClass="btn" onmouseover="this.className='btn btnhov'" 
                                                                onmouseout="this.className='btn'" runat="server"/>
                                                            <asp:Button ID="btnHome" Text="Home" CssClass="btn" onmouseover="this.className='btn btnhov'"          
                                                                onmouseout="this.className='btn'" runat="server"/>                                                                
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc12:Footer ID="Footer" runat="server" />
    </div>
    </form>
</body>
</html>
