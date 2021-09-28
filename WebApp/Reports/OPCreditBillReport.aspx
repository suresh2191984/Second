<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OPCreditBillReport.aspx.cs"
    Inherits="Reports_OPCreditBillReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/DueDetails.ascx" TagName="DueDetail" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<%@ Register Src="../CommonControls/DateSelection.ascx" TagName="DateSelection" TagPrefix="DateCtrl" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
       <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function ShowDDl() {

            var obj = document.getElementById('<%= ddlType.ClientID %>');

            if (obj.options[obj.selectedIndex].value == 1) {
                document.getElementById('<%= ddlCorporate.ClientID %>').style.display = "block";
                document.getElementById('<%= ddlTpaName.ClientID %>').style.display = "none";
                document.getElementById('<%= ddlTpaName.ClientID %>').selectedIndex = "0";
            }
            else if (obj.options[obj.selectedIndex].value == 2) {
                document.getElementById('<%= ddlTpaName.ClientID %>').style.display = "block";
                document.getElementById('<%= ddlCorporate.ClientID %>').style.display = "none";
                document.getElementById('<%= ddlCorporate.ClientID %>').selectedIndex = "0";
            }
            else {
                document.getElementById('<%= ddlCorporate.ClientID %>').selectedIndex = "0";
                document.getElementById('<%= ddlTpaName.ClientID %>').selectedIndex = "0";
                document.getElementById('<%= ddlCorporate.ClientID %>').style.display = "none";
                document.getElementById('<%= ddlTpaName.ClientID %>').style.display = "none";
            }
            return false;
        }
        function ValidatePatientName() {
            if (document.getElementById("hdnrdo").value == '') {
                alert('Select patient');
                return false;
            }
            else {
                return true;
            }
        }
         
    </script>

</head>
<body>
    <form id="form1" runat="server">
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
                                <uc7:ErrorDisplay ID="ErrorDisplay2" runat="server" />
                            </li>
                        </ul>
                        <div>
                            <table border="0" cellpadding="1" cellspacing="1" width="100%" class="dataheader2 defaultfontcolor">
                                <tr>
                                    <td>
                                        <asp:Label ID="Rs_SelectClient" Text="Select Client" runat="server" />
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ID="ddlType"  CssClass ="ddlsmall" onChange="javascript:return ShowDDl();"
                                                        runat="server">
                                                        <asp:ListItem Text="Any" Value="0"></asp:ListItem>
                                                        <asp:ListItem Text="Client" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Insurance" Value="2"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlTpaName" CssClass ="ddlsmall" Style="display: none" runat="server"
                                                        meta:resourcekey="ddlTpaNameResource1">
                                                    </asp:DropDownList>
                                                    <asp:DropDownList ID="ddlCorporate" CssClass ="ddlsmall" Style="display: none" runat="server"
                                                        meta:resourcekey="ddlCorporateResource1">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <DateCtrl:DateSelection ID="ucDateCtrl" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="3">
                                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClientClick="return chkdateEmpty('ucDateCtrl');"
                                            OnClick="btnSearch_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="YesData" runat="server">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td colspan="3">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="center">
                                        <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" Width="100%"
                                            CssClass="dataheaderInvCtrl" PagerSettings-Mode="NextPrevious" AllowPaging="true"
                                            PageSize="25">
                                            <PagerStyle HorizontalAlign="Center" />
                                            <HeaderStyle CssClass="dataheader1" />
                                            <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                            <Columns>
                                                <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" ItemStyle-HorizontalAlign="Left" />
                                                <asp:BoundField DataField="PatientName" ItemStyle-HorizontalAlign="Left" HeaderText="Patient Name" />
                                                <asp:BoundField DataField ="BillNumber" HeaderText ="Bill No"  ItemStyle-HorizontalAlign="Left" />
                                                <asp:BoundField DataField ="BillDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Bill Date" />
                                                <asp:BoundField DataField="DrName" ItemStyle-HorizontalAlign="left" HeaderText="Physician Name" />
                                                <asp:BoundField DataField="Amount" HeaderText="Bill Amount" ItemStyle-HorizontalAlign="Right" />
                                                <asp:BoundField DataField="AmountReceived" HeaderText="Amount Received" ItemStyle-HorizontalAlign="Right" />
                                                <asp:BoundField DataField="clientname" HeaderText="TPA/Client Name" ItemStyle-HorizontalAlign="left" />
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
