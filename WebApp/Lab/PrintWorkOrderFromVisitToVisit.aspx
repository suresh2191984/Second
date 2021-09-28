<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintWorkOrderFromVisitToVisit.aspx.cs"
    Inherits="Lab_PrintWorkOrderFromVisitToVisit" meta:resourcekey="PageResource1" %>

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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Print Work Order From Visit To Visit</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <style type="text/css" media="screen">
        #tblFooter {
         display: none; 
        } 
    </style>
    <style type="text/css" media="print">
        #header, #footer
        {
            display: none;
        }
        #listTab tfoot { display:table-footer-group }
        #tblFooter { display: block; position: fixed; bottom: 0; } 
    </style>

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        window.name = "WorkOrderWindow";
    </script>

</head>
<body id="oneColLayout" oncontextmenu="return false;">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <%-- <asp:Table ID="listTab" runat="server" CellPadding="4"
                            CellSpacing="0" BorderWidth="1px" 
        BorderColor="#000000" Width="100%" meta:resourcekey="listTabResource1">
                            </asp:Table>--%>
    <table id="tblFooter" width="100%">
        <tr>
            <td>
                <asp:Label ID="lblFooter" runat="server" Text="" Font-Bold="true" />
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td>
                WorkOrder Printed Date/Time Range:
            </td>
            <td>
                <asp:Label ID="lblDateRange" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <table id="listTab" cellspacing="0" cellpadding="2" border="0" width="100%">
        <thead>
        <asp:Repeater ID="grdResult" runat="server" OnItemDataBound="grdResult_ItemDataBound">
            <HeaderTemplate>
                <tr>
                    <th style="border-left:solid 1px #000000; border-top:solid 1px #000000; border-bottom:solid 1px #000000; border-collapse:collapse;">
                        Bill No/PID/VisitID
                    </th>
                    <th style="border-bottom:solid 1px #000000; border-top:solid 1px #000000; border-left:solid 1px #000000; border-collapse:collapse;">
                        Name/Age/Sex/Ref. Doctor
                    </th>
                    <th style="border-bottom:solid 1px #000000; border-top:solid 1px #000000; border-left:solid 1px #000000; border-right:solid 1px #000000; border-collapse:collapse;">
                    &nbsp;
                    </th>
                </tr>
                </thead>
                <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td style="border-left:solid 1px #000000; border-bottom:solid 1px #000000; border-collapse:collapse;">
                        <asp:Label ID="collectedon" runat="server" Text='<%# Eval("CollectedOn") %>' />
                        <br />
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("PatientNumber") %>' />
                        <br />
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("StrVisitID") %>' />
                    </td>
                    <td style="border-bottom:solid 1px #000000; border-left:solid 1px #000000; border-collapse:collapse;">
                        <asp:Label ID="PatientName" runat="server" Text='<%# Eval("PatientName") %>' />
                        <br />
                        <asp:Label ID="age" runat="server" Text='<%# Eval("Age") %>' />
                        <br />
                        <asp:Label ID="sex" runat="server" Text='<%# Eval("Sex") %>' />
                        <br />
                        <asp:Label ID="physicianname" runat="server" Text='<%# Eval("ReferingPhysicianName") %>' />
                    </td>
                    <td style="border-bottom:solid 1px #000000; border-left:solid 1px #000000; border-right:solid 1px #000000; border-collapse:collapse;">
                        <asp:GridView ID="gvDescription" Width="100%" GridLines="both" AutoGenerateColumns="False"
                            runat="server">
                            <Columns>
                                <asp:TemplateField HeaderText="Test Description" ItemStyle-Width="50%">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBilledFor" Text='<%# Eval("Description") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Font-Bold="true" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status" ItemStyle-Width="16%">
                                    <ItemTemplate>
                                        <asp:Label ID="status" Text='<%# Eval("Status") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Font-Bold="true" HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Source" ItemStyle-Width="15%">
                                    <ItemTemplate>
                                        <asp:Label ID="Sources" Text='<%# Eval("StrExternalVisitID") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Font-Bold="true" HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Destination" ItemStyle-Width="15%">
                                    <ItemTemplate>
                                        <asp:Label ID="Destination" Text='<%# Eval("ReceivedOn") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Font-Bold="true" HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
        </tbody>
        <tfoot>
            <tr>
                <td style="border:0px;">
                    <table border="0" width="100%">
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </tfoot>
    </table>
    </form>

    <script language="javascript" type="text/javascript">
        window.print();
       
    </script>

</body>
</html>
