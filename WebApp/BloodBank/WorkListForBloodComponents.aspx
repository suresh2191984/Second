<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkListForBloodComponents.aspx.cs" Inherits="BloodBank_WorkListForBloodComponents"
     %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc14" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="ucPatHeader" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitals" TagPrefix="ucVitals" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>

<script type="text/javascript" src="../Scripts/bid.js"></script>

<script type="text/javascript" src="../Scripts/test.js"></script>

<
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>WorkList For Blood Components </title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        input:focus
        {
            /*background: #8AC0DA;*/
            outline: .25px solid #8f0000;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scm1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div style="float: left; width: 4%;">
                    <img alt="" src="" class="logostyle" />
                </div>
            </div>
            <div style="float: left; width: 87.8%;">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <ucPatHeader:PatientHeader ID="patientHeader" runat="server" />
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
                    <div class="contentdata" id="dMain">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:GridView ID="gvSummary" runat="server" AutoGenerateColumns="False" Width="100%"
                             Font-Names="Verdana" Font-Size="12px">
                            <Columns>
                               
                                <asp:BoundField HeaderText="Bag Number" DataField="BagNumber" />
                                <asp:BoundField HeaderText="Total Stock" DataField="Volume"  />
                                <asp:BoundField HeaderText="Produc tName" DataField="ProductName"  />
                                <asp:BoundField HeaderText="Batch No" DataField="BloodGroupName" />
                                <asp:BoundField HeaderText="Expiry Date" DataField="ExpiryDate"  />
                                <asp:BoundField HeaderText="Separated Date" DataField="ModifiedAt"
                                    />
                               
                            </Columns>
                            <RowStyle HorizontalAlign="Left" />
                        </asp:GridView>
                    </div>
                </td>
            </tr>
        </table>
        <uc14:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
