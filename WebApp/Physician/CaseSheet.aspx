<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CaseSheet.aspx.cs" Inherits="Physician_CaseSheet" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/SmallSummary.ascx" TagName="SmallSummary" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/PatientPrescription.ascx" TagName="PatientPrescription"
    TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>CaseSheet</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        function openPrintWindow() {
            window.open("CaseSheetPrintView.aspx", "CaseSheet", "top=100;height=600,width=800,status=yes,toolbar=no,menubar=no,location=no");
            //window.showModalDialog("CaseSheetPrintView.aspx", "CaseSheet", "scroll:no;center:yes;dialogHeight:35;dialogWidth:45;resizable:no;edge:raised;status:yes;toolbar=no;menubar=no;location=no");
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server" defaultbutton="btnHideValues">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <uc1:MainHeader ID="MainHeader" runat="server" />
            <uc3:DocHeader ID="docHeader" runat="server" />
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
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
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table>
                            <tr>
                                <td>
                                    <asp:Panel BorderStyle="None" ID="pnlView" runat="server" 
                                        meta:resourcekey="pnlViewResource1">
                                        <table>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="defaultfontcolor">
                                                    <asp:Label ID="Rs_MEDICATIONTOBEFOLLOWED" Text="MEDICATION TO BE FOLLOWED" 
                                                        runat="server" meta:resourcekey="Rs_MEDICATIONTOBEFOLLOWEDResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <uc6:PatientPrescription ID="PatientPrescription1" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Literal ID="lblAdv" runat="server" meta:resourcekey="lblAdvResource1"></asp:Literal>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel GroupingText="Edit CaseSheet" ID="pnlEdit" runat="server" 
                                        Visible="False" meta:resourcekey="pnlEditResource1">
                                        <asp:Label ID="Label1" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" nowrap="nowrap">
                                    <input type="button" class="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                        id="btnPView" value="Print View" onclick="javascript:openPrintWindow();" />
                                    <asp:Button ID="btnClose" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" runat="server" OnClick="btnClose_Click" 
                                        meta:resourcekey="btnCloseResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    <asp:Button ID="btnHideValues" runat="server" CssClass="btn" OnClientClick="javascript:return false;"
        Style="height: 0px; width: 0px;" 
        meta:resourcekey="btnHideValuesResource1" />
    </form>
</body>
</html>
