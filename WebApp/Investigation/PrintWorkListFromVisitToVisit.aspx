<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintWorkListFromVisitToVisit.aspx.cs" Inherits="Investigation_PrintWorkListFromVisitToVisit" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/SampleBillPrint.ascx" TagName="BillPrintControl" TagPrefix="uc8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Print Work List From Visit To Visit</title>
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
        window.name = "WorkListWindow";
    </script>

</head>
<body id="oneColLayout">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table id="tblFooter" width="100%"> 
      <tr> 
        <td> 
          <asp:Label ID="lblFooter" runat="server" Text="" Font-Bold="true" />
        </td>
      </tr>
    </table>
    <asp:Label ID="lbltxt" Visible="false" runat="server" Text="** is in cancel status"></asp:Label>
       <asp:Table ID="listTab" runat="server" CellPadding="1"
                            CellSpacing="0" BorderWidth="0" BorderColor="#000" Font-Size="Small" style="padding-left:0px;padding-right:0.5px;padding-top:0px;padding-bottom:0.5px" Width="90%">
                            </asp:Table>
    </form>

    <script language="javascript" type="text/javascript">
        window.print();
       
    </script>

</body>
</html>
