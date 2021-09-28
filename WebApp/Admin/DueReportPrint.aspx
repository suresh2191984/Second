<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DueReportPrint.aspx.cs"
    Inherits="Admin_DueReportPrint" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="AdminHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Admin Reports</title>
   <%-- <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <style type="text/css" media="print">
        #header, #footer
        {
            display: none;
        }
    </style>

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        window.name = "ReportWindow";
        window.resizeTo(1024, 768);
    </script>
</head>
<body id="oneColLayout" >
    <form id="form1" runat="server" >
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   
                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td>
                                    <asp:Label ID="lblResult" Visible="false" ForeColor="#333" runat="server"></asp:Label>
                          
                            
                             <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                             
                               <table cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td align="left" style="font-weight:bold;">
                 Export To Excel &nbsp;<asp:ImageButton ID="btnXL" OnClick="btnXL_Click" runat="server" 
                                                        ImageUrl="../Images/ExcelImage.GIF"   ToolTip="Save As Excel" />                                         
                                                  
                                                               
                               </td></tr></table>               
                      
                            <table id="resultTab" runat="server" cellpadding="0" cellspacing="0" style=" padding:0px;" border="0" width="80%">
                            <tr>
                                <td >
                                
                                 <table id="orgHeaderTab" runat="server" cellpadding="0" cellspacing="0" border="0" width="100%">
                                <tr>
                                <td id="orgHeaderTextForReport" align="center" runat="server" style="color:#000000; font-size:12px; font-weight:bold;">
                                
                                </td>
                                </tr>
                                <tr>
                                <td id="dateTextForReport" align="left" runat="server" style=" padding-left:5px;color:#000000;font-size:12px; font-weight:bold; padding-top:20px;">
                                
                                </td>
                                </tr>
                                </table>
                               
                                
                                    <asp:GridView ID="grdResult" runat="server" AllowPaging="false" AutoGenerateColumns="False"
                                        CellPadding="4" GridLines="None" Font-Names="arial" BorderWidth="0px" CssClass="mytable1" DataKeyNames="BillID" ForeColor="#333333"
                                        Width="99%" >
                                        <HeaderStyle  Font-Bold="true" Font-Size="12px" />
                                       <RowStyle Font-Size="11px" />
                                        <Columns >
                                            <asp:BoundField DataField="BillID" HeaderText="BillID" Visible="false" />
                                            <asp:BoundField DataField="BillID" HeaderStyle-HorizontalAlign="left" HeaderText="Bill No"
                                                ItemStyle-HorizontalAlign="Left" ItemStyle-Width="8%">
                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left" Width="8%"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="BillDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" HeaderStyle-HorizontalAlign="Left"
                                                HeaderText="Bill Date" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="18%">
                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left" Width="18%"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Name" HeaderStyle-HorizontalAlign="Left" HeaderText="Patient Name"
                                                ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="30%">
                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Age" HeaderStyle-HorizontalAlign="Left" HeaderText="Age"
                                                ItemStyle-HorizontalAlign="Left" Visible="true">
                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left" Width="10%"></ItemStyle>
                                            </asp:BoundField>
                                            
                                         <asp:BoundField DataField="Status" HeaderStyle-HorizontalAlign="Left" HeaderText="Due Status"
                                                ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="8%">
                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left" Width="8%"></ItemStyle>
                                            </asp:BoundField>
                                          
                                            <asp:BoundField DataField="AmountDue" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                HeaderText="Due Amount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="10%" Visible="true">
                                                <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Right" Width="10%"></ItemStyle>
                                            </asp:BoundField>
                                           
                                        </Columns>
                                    </asp:GridView>
                                    
                                     <table border="0" id="tabGranTotal1" runat="server" visible="false" 
                                     cellpadding="6" style="color: #000000;font-weight:bold;" cellspacing="0" width="100%">
                                     <tr>
                                            <td align="right" style="width: 80%;">
                                               Total Amount:
                                            </td>
                                            <td align="right" style="padding-right: 15px;">
                                                <label id="lblGrandTotal" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                        </table>
                                </td>
                            </tr>
                        </table>
                       
              
                                        
                                        
                                        </td></tr></table>
    </form>
     <script language="javascript" type="text/javascript">
         window.print();
       
    </script>

</body>
</html>
