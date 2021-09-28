<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillSearch.aspx.cs" Inherits="Billing_BillSearch" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/BillSearch.ascx" TagName="BillSearch" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="PhyHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Bill Search</title>
<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server" defaultbutton="bGo">

    <script language="javascript" type="text/javascript">
        function VisitDetails(visitID, PatientID, PName, Bid) {

            document.getElementById("<%= hdnVID.ClientID %>").value = visitID;
            document.getElementById("<%= hdnPID.ClientID %>").value = PatientID;
            document.getElementById("<%= hdnPNAME.ClientID %>").value = PName;
            document.getElementById("<%= hdnBID.ClientID %>").value = Bid;

        }


        function CheckVisitID() {
            if (document.getElementById("<%= hdnVID.ClientID %>").value == '0') {
                alert('Select bill detail');
                    return false;
                }
                else {
                    document.getElementById("<%= hdnVisitDetail.ClientID %>").value =
                    document.getElementById("<%= dList.ClientID %>").options[document.getElementById("<%= dList.ClientID %>").selectedIndex].innerHTML;
                return true;
            }

        }
    </script> 

    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="userHeader" runat="server" />
                <uc7:PhyHeader ID="physicianHeader" runat="server" />
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
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td style="padding-bottom: 10px;">
                                    <div class="defaultfontcolor dataheader2">
                                        <uc2:BillSearch ID="uctrlBillSearch" runat="server" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="defaultfontcolor">
                                    <asp:Label ID="lblResult" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="aRow" style="width: 100%" runat="server" visible="false">
                                <td style="width: 100%" class="defaultfontcolor">
                                    <asp:Label ID="Rs_SelectaBillandPerformoneofthefollowing" 
                                        Text="Select a Bill and Perform one of the following" runat="server" 
                                        meta:resourcekey="Rs_SelectaBillandPerformoneofthefollowingResource1"></asp:Label>
                                    <asp:DropDownList ID="dList" runat="server" CssClass ="ddlsmall"  meta:resourcekey="dListResource1"> 
                                    </asp:DropDownList>
                                    <%--<asp:UpdatePanel ID="updatePanel1" runat="server">
                                    <ContentTemplate>--%>
                                    <asp:Button ID="bGo" runat="server" Text="Go" OnClick="bGo_Click" CssClass="btn"
                                        OnClientClick="return CheckVisitID()" 
                                       onmouseout="this.className='btn'" meta:resourcekey="bGoResource1" />
                                    <%--</ContentTemplate>
                                    </asp:UpdatePanel>--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
          <input type="hidden" id="hdnBID" name="bid" value="0" runat="server" />
         <input type="hidden" id="hdnVID" name="vid" value="0" runat="server" />
        <input type="hidden" id="hdnPID" name="pid" value="0" runat="server" />
        <input type="hidden" id="hdnPNAME" name="PName" runat="server" />
        <input type="hidden" id="hdnVisitDetail" runat="server" />
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
    <p>
    </p>
</body>
</html>
