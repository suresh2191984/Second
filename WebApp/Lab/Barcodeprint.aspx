<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Barcodeprint.aspx.cs" Inherits="Lab_Barcodeprint" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/OrderedSamples.ascx" TagName="OrderedSamples"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>BarcodePrint</title>
</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <script language="javascript" type="text/javascript">
        function popupprint() {

            var prtContent = document.getElementById('divbar');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,width=400,height=400');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
           
        }
       
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div style="float: left; width: 4%;">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div style="float: left; width: 87.8%;">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <%--<uc3:PatientHeader ID="patientHeader" runat="server" />--%>
                <uc6:UserHeader ID="UserHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
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
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <div runat="server" id="divPatientDetails">
                            <ucPatientdet:PatientDetails ID="PatientDetail" runat="server" />
                        </div>                        
                               <h5> Sample details</h5>
                        <div runat="server" id="divbar">
                            
                            <asp:GridView ID="grdbarcode" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                PageSize="100" ForeColor="Black" GridLines="Both" Width="50%">
                                <HeaderStyle Font-Underline="True" />
                                <RowStyle Font-Bold="False" />
                                <Columns>
                                    <asp:BoundField DataField="PaymentStatus" HeaderText="PatientName" Visible="false">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center" Width="12%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ComplaintId" HeaderText="PatientNo" Visible="false">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center" Width="12%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="VisitID" HeaderText="PatientvisitID" Visible="false">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center" Width="5%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Name" HeaderText="InvestigationName" Visible="false" meta:resourcekey="BoundFieldResource2">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ID" HeaderText="InvestigationID" Visible="false">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="InvestigationsType" HeaderText="Samplename" Visible="false">
                                        <HeaderStyle HorizontalAlign="center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Type" HeaderText="DeptName" meta:resourcekey="BoundFieldResource3" Visible="false">
                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:TemplateField>
                                    <ItemTemplate>
                                    <table >                                    
                                    <tr>
                                    <td colspan="3"  align="center">
                                    <asp:Image ID="imbbarcode" runat="server"  ImageUrl='<%# "../admin/userImageHandler.ashx?isBarCode=Y&key="+Eval("PaymentStatus")+"&val="+Eval("Status") %>' /> 
                                    </td>
                                    </tr>
                                    <tr>
                                    <td align="left">
                                    Sample Name:                                    
                                    <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"InvestigationsType") %>'></asp:Label>
                                    </td>
                                    <%--<td align="left">
                                    Dept Name:
                                    <asp:Label ID="Label2" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Type") %>'></asp:Label>
                                    </td>--%>
                                    </tr>                                    
                                    </table>
                                    </ItemTemplate>                                    
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>               
                         <table>
                         <tr>
                         <td>
                         <asp:Button ID="Button1" runat="server" Text="Print" CssClass="btn"
                                onmouseover="this.className='btn btnhov'" 
                                onmouseout="this.className='btn'" OnClientClick="return popupprint();" />
                         </td>
                         <td>
                         <asp:Button ID="Button2" runat="server" Text="Home" CssClass="btn"
                                onmouseover="this.className='btn btnhov'" 
                                onmouseout="this.className='btn'" OnClick="btnclose_click" /> 
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
