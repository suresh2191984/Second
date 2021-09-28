<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RoomListRpt.aspx.cs" Inherits="Reports_RoomListRpt" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
        <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function popupprint() {
            var prtContent = document.getElementById('prnReport');
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
    <asp:ScriptManager ID="scriptManager1" runat="server">
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
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table id="tblCollectionOPIP" align="center" width="100%">
                            <tr align="center">
                                <td align="center">
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <ContentTemplate>
                                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                    <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                            <div id="divBackBtn" style="display: block;" runat="server">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td align="right" style="padding-right: 10px; color: #000000;">
                                                            <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " 
                                                                CssClass="details_label_age" OnClick="lnkBack_Click" 
                                                                meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <table cellpadding="0" cellspacing="0" border="0" width="30%">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_SelectRoomStatus" Text="Select Room Status:" runat="server" meta:resourcekey="Rs_SelectRoomStatusResource1"></asp:Label>
                                                        <asp:DropDownList ID="ddlRoomStatus" CssClass ="ddlsmall" runat="server" meta:resourcekey="ddlRoomStatusResource1">
                                                            <asp:ListItem Text="All" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                            <asp:ListItem Text="Available" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                            <asp:ListItem Text="Occupied" Value="2" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                            <asp:ListItem Text="Booked" Value="3" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <div id="divPrintPC" style="display: none;" runat="server">
                                                <table cellpadding="0" cellspacing="0" border="0" width="95%">
                                                    <tr>
                                                        <td align="center" style="padding-right: 10px; color: #000000;">
                                                            <b id="printText" runat="server">
                                                                <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>&nbsp;&nbsp;
                                                            <asp:ImageButton ID="btnPrintPC" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                                ToolTip="Print" meta:resourcekey="btnPrintPCResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="prnReport">
                                                <table id="divTblCount" style="display: block;" runat="server">
                                                    <tr id="Tr1" runat="server">
                                                        <td id="Td1" runat="server">
                                                            <asp:Label ID="lblAvailableCount" runat="server" BackColor="PaleGreen"></asp:Label>
                                                        </td>
                                                        <td id="Td2" runat="server">
                                                            <asp:Label ID="lblBookedCount" runat="server" BackColor="PapayaWhip"></asp:Label>
                                                        </td>
                                                        <td id="Td3" runat="server">
                                                            <asp:Label ID="lblOccupiedCount" runat="server" BackColor="LightPink"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr id="Tr2" runat="server">
                                                        <td id="Td4" runat="server">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%" id="tblgvPCReport"
                                                    style="display: block;" runat="server">
                                                    <tr id="divMsg" style="display: none;" runat="server">
                                                        <td id="Td5" runat="server">
                                                            <asp:Label ID="lblMsg" runat="server" Font-Bold="True" Text="No matching records found"
                                                                S></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr id="trDate" style="display: none;" runat="server">
                                                        <td id="Td6" runat="server">
                                                            <asp:Label ID="lblDate" runat="server" Font-Bold="True"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr id="Tr3" runat="server">
                                                        <td id="Td7" runat="server">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr id="Tr4" runat="server">
                                                        <td id="Td8" runat="server">
                                                            <asp:GridView ID="gvRoomListReport" runat="server" Width="100%" CellPadding="4" CssClass="mytable1"
                                                                AutoGenerateColumns="False" ForeColor="#333333" HorizontalAlign="Left" AllowSorting="True"
                                                                OnRowDataBound="gvRoomListReport_RowDataBound">
                                                                <Columns>
                                                                     <asp:TemplateField HeaderText="S.No">
                                                                        <ItemTemplate>
                                                                            <%# Container.DataItemIndex + 1 %>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Building Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblBuildingName" Text='<%#Eval("BuildingName") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Floor Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblFloorName" Text='<%#Eval("FloorName") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Room Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblRoomName" Text='<%#Eval("RoomName") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Bed Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblBedName" Text='<%#Eval("BedName") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Room Type Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblRoomTypeName" Text='<%#Eval("RoomTypeName") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Patient Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblPatientName" Text='<%#Eval("PatientName") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Room Status">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblRoomStatus" Text='<%#Eval("RoomStatus") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                <PagerStyle HorizontalAlign="Left" />
                                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
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
