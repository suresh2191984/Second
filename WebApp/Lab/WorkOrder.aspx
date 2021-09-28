<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkOrder.aspx.cs" Inherits="Lab_WorkOrder" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/OrderedSamples.ascx" TagName="OrderedSamples"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Work Order</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

</head>
<body  oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index:2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>"  class="logostyle" />
                </div>
            </div>
                <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <%--<uc3:PatientHeader ID="patientHeader" runat="server" />--%>
                <uc6:UserHeader ID="UserHeader1" runat="server" />
            </div>
                    <div style="float: right;"  class="Rightheader"></div>
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
                                <uc7:ErrorDisplay ID="ErrorDisplay2" runat="server" />
                            </li>
                        </ul>
                    
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <asp:Table CellPadding="2" CssClass="colorforcontentborder" CellSpacing="0" Font-Size="11px"
                                        BorderWidth="0px" runat="server" ID="dispTab" Width="100%" 
                                        meta:resourcekey="dispTabResource1">
                                        <asp:TableRow Height="15px" BorderWidth="0" 
                                            meta:resourcekey="TableRowResource1">
                                            <asp:TableHeaderCell ForeColor="#000" HorizontalAlign="left" 
                                                meta:resourcekey="TableHeaderCellResource1">
                                                <asp:Literal ID="ColDrName" runat="server" Text="Dr. Name:" 
                                                meta:resourcekey="ColDrNameResource1"></asp:Literal>
                                                

                                                &nbsp;
                                                <asp:Literal ID="DrName" runat="server" meta:resourcekey="DrNameResource2"></asp:Literal>
                                            
</asp:TableHeaderCell>
                                            <asp:TableHeaderCell ForeColor="#000" HorizontalAlign="left" 
                                                meta:resourcekey="TableHeaderCellResource2">
                                                <asp:Literal ID="Literal3" runat="server" Text="Hospital/Branch:" 
                                                meta:resourcekey="Literal3Resource1"></asp:Literal>
                                                

                                                &nbsp;
                                                <asp:Literal ID="HospitalName" runat="server" 
                                                meta:resourcekey="HospitalNameResource1"></asp:Literal>
                                            
</asp:TableHeaderCell>
                                        </asp:TableRow>
                                        <asp:TableRow ID="TableRow1" runat="server" BorderWidth="0" 
                                            meta:resourcekey="TableRow1Resource1">
                                            <asp:TableHeaderCell ColumnSpan="4" HorizontalAlign="left" 
                                                meta:resourcekey="TableHeaderCellResource3">
                                                <asp:Table CellPadding="0" CellSpacing="0" BorderWidth="0" runat="server" ID="trCC"
                                                    Style="display: none;" Width="100%" meta:resourcekey="trCCResource1">
                                                    <asp:TableRow Height="15px" BorderWidth="0" 
                                                        meta:resourcekey="TableRowResource2">
                                                        <asp:TableHeaderCell ForeColor="#000" ColumnSpan="2" HorizontalAlign="left" 
                                                            meta:resourcekey="TableHeaderCellResource4">
                                                            <asp:Literal ID="Literal4" runat="server" Text="Collection Centre:" 
                                                            meta:resourcekey="Literal4Resource1"></asp:Literal>
                                                            

                                                            &nbsp;
                                                            <asp:Literal ID="CollectionCentre" runat="server" 
                                                            meta:resourcekey="CollectionCentreResource1"></asp:Literal>
                                                        
</asp:TableHeaderCell>
</asp:TableRow>
                                                
</asp:Table>
                                            
</asp:TableHeaderCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                    <asp:Panel ID="pnlptDetails" CssClass="dataheader2" BorderWidth="1px" 
                                        runat="server" meta:resourcekey="pnlptDetailsResource1">
                                        <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                            <tr style="height: 15px;" class="Duecolor">
                                                <td colspan="10">
                                                    <b><asp:Label ID="Rs_PatientDetails" Text="Patient Details" runat="server" 
                                                        meta:resourcekey="Rs_PatientDetailsResource1"></asp:Label></b>
                                                </td>
                                            </tr>
                                            <tr style="height: 20px;">
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    <asp:Label ID="Rs_PatientDetails1" Text="Patient No:" runat="server" 
                                                        meta:resourcekey="Rs_PatientDetails1Resource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    <asp:Label ID="lblPatientNo" runat="server" 
                                                        meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 13%;" align="left">
                                                    <asp:Label ID="Rs_PatientName" Text="Patient Name:" runat="server" 
                                                        meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000;" align="left">
                                                    <asp:Label ID="lblPatientName" runat="server" 
                                                        meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    <asp:Label ID="Rs_Gender" Text="Gender:" runat="server" 
                                                        meta:resourcekey="Rs_GenderResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                    <asp:Label ID="lblGender" runat="server" meta:resourcekey="lblGenderResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    <asp:Label ID="Rs_Age" Text="Age:" runat="server" 
                                                        meta:resourcekey="Rs_AgeResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                    <asp:Label ID="Rs_VisitNo" Text="Visit No:" runat="server" 
                                                        meta:resourcekey="Rs_VisitNoResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    <asp:Label ID="lblVisitNo" runat="server" 
                                                        meta:resourcekey="lblVisitNoResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc5:OrderedSamples ID="OrderedSamples1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <br />
                                    <asp:HyperLink ID="hypLnkPrint" ToolTip="Click here to Print the Work Order" Font-Bold="True"
                                        Font-Size="12px" ForeColor="Black" Target="ReportWindow" runat="server" 
                                        meta:resourcekey="hypLnkPrintResource1">
                                        <img id="imgPrint" runat="server" style="border-width: 0px;" src="~/Images/printer.gif" />
&nbsp;&nbsp;<u>Print
                                            <asp:Label ID="Rs_WorkOrder" Text="Work Order" runat="server" 
                                        meta:resourcekey="Rs_WorkOrderResource1"></asp:Label>
</u></asp:HyperLink>
                                    <asp:Button ID="btnBack" runat="server" CssClass="btn" ToolTip="Click here to go back to Sample Collection"
                                        Style="cursor: pointer;" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                        Text="Back" OnClick="btnCancel_Click" 
                                        meta:resourcekey="btnBackResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
