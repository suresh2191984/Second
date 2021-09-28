<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LabAdminReportsPrint.aspx.cs" Inherits="Admin_LabAdminReportsPrint" %>
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
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

</head>
<body id="oneColLayout" >
    <form id="form1" runat="server"  >
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    
       
                       <asp:Table CellPadding="2" CssClass="colorforcontentborder" CellSpacing="0" BorderWidth="0" runat="server" ID="billMasterTab"
                                                                    Width="70%" >
                                                                    <asp:TableRow  Height="15px" BorderWidth="0" >
                                                                    <asp:TableHeaderCell   HorizontalAlign="Left" ColumnSpan="2">
                                                                    <asp:Literal ID="ColBillNo" runat="server" Text="Client Package:"></asp:Literal>
                                                                    &nbsp; <asp:Literal ID="clientPackage" runat="server" ></asp:Literal>
                                                                    </asp:TableHeaderCell>
                                                                   
                                                                    </asp:TableRow>
                                                                    
                                                                    <asp:TableRow  Height="15px" BorderWidth="0" >
                                                                    <asp:TableHeaderCell HorizontalAlign="Left">
                                                                    <asp:Literal ID="ColPatientName" runat="server" Text="From Date:"></asp:Literal>
                                                                      &nbsp;<asp:Literal ID="lblFromDate" runat="server" ></asp:Literal>
                                                                      &nbsp;&nbsp;&nbsp;
                                                                      <asp:Literal ID="ColDrName" runat="server" Text="To Date:" ></asp:Literal>
                                                                    &nbsp;  <asp:Literal ID="lblToDate" runat="server" ></asp:Literal>
                                                                    </asp:TableHeaderCell>
                                                                   <asp:TableHeaderCell   HorizontalAlign="right">
                                                                  
                                                                    </asp:TableHeaderCell>
                                                                    </asp:TableRow>
                                                                    
                                                                    </asp:Table>       
                               
                              <table id="tab1" runat="server" width="80%">
                                    <tr>
                                        <td colspan="2">
                                       
                            <asp:GridView ID="grdResult" BorderColor="#333" BorderWidth="1px" Width="99%" runat="server" AllowPaging="True" CellPadding="4" AutoGenerateColumns="False"
                                DataKeyNames="BillID" PagerSettings-Mode="NextPrevious" OnRowDataBound="grdResult_RowDataBound"
                                ForeColor="#333333" OnPageIndexChanging="grdResult_PageIndexChanging" PageSize="100" GridLines="Both" CssClass="mytable1">
                                <PagerTemplate>
                                    <tr>
                                        <td colspan="6" align="center">
                                            <asp:ImageButton ID="lnkPrev" CommandName="Page" runat="server" CausesValidation="false"
                                                CommandArgument="Prev" ImageUrl="~/Images/previousimage.png" Width="18px" Height="18px" />
                                            <asp:ImageButton ID="lnkNext" CommandName="Page" runat="server" CausesValidation="false"
                                                CommandArgument="Next" ImageUrl="~/Images/nextimage.png" Width="18px" Height="18px" />
                                        </td>
                                    </tr>
                                </PagerTemplate>
                                <HeaderStyle CssClass="dataheader1" />
                                <Columns>
                                    <asp:BoundField Visible="false" DataField="BillID" HeaderText="BillID" />
                                   
                                    <asp:BoundField DataField="BillID"  ItemStyle-BorderWidth="1px"  HeaderStyle-BorderWidth="1px"  HeaderText="Bill No" HeaderStyle-HorizontalAlign="left" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="BillDate" ItemStyle-BorderWidth="1px" HeaderStyle-BorderWidth="1px" DataFormatString="{0:dd MMM yyyy}" HeaderText="Bill Date"
                                        ItemStyle-Width="15%"   HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                                       
                                    <asp:BoundField DataField="DrName" ItemStyle-BorderWidth="1px" HeaderStyle-BorderWidth="1px" Visible="true" HeaderText="Doctor's Name" HeaderStyle-HorizontalAlign="left"  />
                                    <asp:BoundField DataField="RefOrgName"  ItemStyle-BorderWidth="1px" HeaderStyle-BorderWidth="1px" Visible="true" HeaderText="Hospital/CC/Branch"  HeaderStyle-HorizontalAlign="left"  />
                                     <asp:BoundField DataField="Amount" ItemStyle-BorderWidth="1px" HeaderStyle-BorderWidth="1px" Visible="true" HeaderText="Amount"  HeaderStyle-HorizontalAlign="right" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="15%" />
                                </Columns>
                            </asp:GridView>
                                               
                                        </td>
                                    </tr>
                                </table>
                                
               
    </form>
    <script language="javascript" type="text/javascript">
        window.print();
        window.close();
    </script>
</body>
</html>