<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LabAdminSummaryReportsPrint.aspx.cs"
    Inherits="Admin_LabAdminSummaryReportsPrint" EnableViewState="false" %>
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
    <form id="form1" runat="server" >  <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:Label ID="lblResult" Visible="false" ForeColor="#333" runat="server"></asp:Label>
    <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />                            
                          <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td align="left" >
                     
                                                    <asp:ImageButton ID="btnXL" OnClick="btnXL_Click" runat="server" Visible ="false"  
                                                        ImageUrl="../Images/ExcelImage.GIF"   ToolTip="Save As Excel" />                                         
                                                    
                                                </td>
                                            </tr>
                                        </table>
                            
                        
                             <table id="resultTab" runat="server" cellpadding="0" cellspacing="0" border="0" width="100%">
                                <tr>    
                            <td>
                            
                            
                            
                             <table id="orgHeaderTab" runat="server" cellpadding="0" cellspacing="0" border="0" width="100%">
                                <tr>
                                <td id="orgHeaderTextForReport" align="center" runat="server" style="color:#000000; font-size:12px; font-weight:bold;">
                                
                                </td>
                                </tr>
                                <tr>
                                <td id="dateTextForReport" align="left" runat="server" style="color:#000000;font-size:11px; font-weight:bold; padding-top:20px;">
                                
                                </td>
                                </tr>
                                </table>
                  
                            <table cellpadding="0" id="tabgrdResult" runat="server" cellspacing="0" style=" padding:15px;" border="0" width="80%">
                            <tr>
                                <td >
                                   <asp:Repeater ID="grdResult"  OnItemDataBound="grdResult_ItemDataBound" runat="server">
                                    <ItemTemplate>
                               
                                    <asp:Panel ID="billPanel" BorderWidth="0px" Width="80%" runat="server" >
                                     <table cellpadding="0" cellspacing="0" border="1px" width="80%">
                                   <tr ><td>
                                   <table cellpadding="5" class="tableFontBlackBold" cellspacing="0" border="0" width="100%">
                                   <tr >
                                   <td align="left" style=" width:10%;">
                                   Bill No:
                                   </td>
                                   <td align="left">
                                   <%# DataBinder.Eval(Container.DataItem,"BillID") %>
                                   &nbsp;&nbsp;
                                   <%# DataBinder.Eval(Container.DataItem,"IsCredit") %>
                                   </td>
                                   <td align="left" style=" width:10%;">
                                   Date:
                                   </td>
                                   <td align="left" style=" width:30%;">
                                   <%# DataBinder.Eval(Container.DataItem,"BillDate") %>
                                   </td>
                                   </tr>
                                   <tr style="color:#000000;">
                                   <td align="left" style=" width:8%;">
                                   Name:
                                   </td>
                                    <td align="left">
                                   <%# DataBinder.Eval(Container.DataItem,"Name") %>
                                   </td>
                                   <td align="left" style=" width:5%;">
                                   Age:
                                   </td>
                                    <td align="left" style=" width:30%;">
                                   <%# DataBinder.Eval(Container.DataItem,"Age") %>
                                   </td>
                                   </tr>
                                  
                                   </table>
                                    <table cellpadding="5" class="tableFontBlackBold" cellspacing="0" border="0" width="100%">
                                   <tr style="color:#000000;">
                                   <td align="left" style=" width:20%;">
                                   Dr Name:
                                   </td>
                                   <td align="left">
                                   <%# DataBinder.Eval(Container.DataItem,"ReferingPhysicianName") %>
                                   </td>
                                  
                                   </tr>
                                   <tr style="color:#000000;">
                                   <td align="left" style=" width:20%;">
                                   Hospital/Branch:
                                   </td>
                                   <td align="left">
                                   <%# DataBinder.Eval(Container.DataItem,"HospitalName") %>
                                   </td>
                                  
                                   </tr>
                                   <tr style="color:#000000;">
                                   <td align="left" style=" width:23%;">
                                  Collection Centre:
                                   </td>
                                   <td align="left">
                                   <%# DataBinder.Eval(Container.DataItem,"CollectionCentreName") %>
                                   </td>
                                  
                                   </tr>
                                   </table>
                                   <table cellpadding="5" class="tableFontBlackNormal" cellspacing="0" border="0" width="100%">
                                   <tr style=" font-weight:bold; text-decoration: underline;">
                                   <td>Item</td>
                                   <td align="right">Quantity</td>
                                   <td align="right">Rate</td>
                                   <td align="right">Amount</td>
                                   </tr>
                                    <asp:Repeater ID="grdChildResult" runat="server">
                                    <ItemTemplate>
                                   
                                    <tr>
                                   <td align="left" style=" width:30%;">
                                   <%# DataBinder.Eval(Container.DataItem,"ItemName") %>
                                   </td>
                                   <td align="right" style=" width:10%;">
                                   <%# DataBinder.Eval(Container.DataItem,"Quantity") %>
                                   </td>
                                    <td align="right" style=" width:10%;">
                                   <%# DataBinder.Eval(Container.DataItem,"Rate") %>
                                   </td>
                                    <td align="right" style=" width:10%;">
                                   <%# DataBinder.Eval(Container.DataItem,"Amount") %>
                                   </td>
                                   </tr>
                                  
                                    
                                   </ItemTemplate></asp:Repeater>
                                    <tr style="font-weight:bold;">
                                   <td colspan="3" align="right" style=" width:75%;">
                                   Total Amount:
                                   </td>
                                    <td align="right">
                                   <%# DataBinder.Eval(Container.DataItem,"GrossAmount","{0:0.00}" ) %>
                                   </td>
                                   </tr>
                                  
                                  
                                   </table>
                                  </td></tr></table>
                                   </asp:Panel>
                                    </ItemTemplate>
                                   </asp:Repeater> 
                                   <%--<table border="0" id="tabGranTotal" runat="server" visible="false" style=" font-weight:bold;"  cellpadding="5"  cellspacing="0" width="65%">
                                  <tr>
                                  <td align="right" style="width:80%;">Grand Total:</td>
                                  <td align="right" style="padding-right:15px;"><label id="lblGrandTotal" runat="server"></label></td>
                                  </tr>
                                  </table>--%>
                                </td>
                            </tr>
                        </table>
                          <table cellpadding="5" cellspacing="0" border="1" width="100%" 
        runat="server" style="display: none; border-color:#000000;" id="tblDoctorWisereport">
        <tr style=" color: #000000;">
            <td align="left" style="font-weight:bold;">
                <asp:Label ID="lblName" runat="server"></asp:Label>
               <asp:Label ID="lblDoctorName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="gvDoctorWiseReport" runat="server" AutoGenerateColumns="False" PageSize="1000">
                    <Columns>
                        <asp:TemplateField HeaderText="Department Name" ItemStyle-Width="14%">
                            <ItemTemplate>
                                <div style="text-align: center;">
                                    <asp:Label ID="lblDepartmentName" runat="server" Text='<%#Bind("DeptName") %>'></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="14%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Number Of Investigation" ItemStyle-Width="14%">
                            <ItemTemplate>
                                <div style="text-align: center;">
                                    <asp:Label ID="lblNumberOfItem" runat="server" Text='<%#Bind("NumberOfItem") %>'></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="14%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Number Of Cases" ItemStyle-Width="14%">
                            <ItemTemplate>
                                <div style="text-align: center;">
                                    <asp:Label ID="lblPatientCount" runat="server" Text='<%#Bind("PatientCount") %>'></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="14%" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
    
              <table cellpadding="5" cellspacing="0" border="0" width="100%">
                                        <%--<tr Class="Duecolor">
                                            <td align="center" style="width: 25%;">
                                                Department Name
                                            </td>
                                            <td align="center" style="width: 25%;">
                                                Date
                                            </td>
                                            <td align="center" style="width: 25%;">
                                                Number Of Items
                                            </td>
                                            <td align="center" style="width: 25%;">
                                                Amount
                                            </td>
                                        </tr>--%>
                                        <tr valign="top">
                                            <td colspan="4" valign="top">
                                                <asp:GridView Visible="false" ID="grdCollection" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                    CellPadding="0" DataKeyNames="BillID" ForeColor="#333333" PagerSettings-Mode="NextPrevious"
                                                    Width="100%" PageSize="1000" GridLines="Both" BorderColor="#000000" OnRowDataBound="grdCollection_RowDataBound" OnPageIndexChanging="grdCollection_PageIndexChanging">
                                                    <Columns>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <table cellpadding="5" cellspacing="0" border="0" style="border-color:#000000;" width="100%">
                                                                    <tr style=" color: #000000;">
                                                                        <td align="center" style="width: 25%;">
                                                                            Department Name
                                                                        </td>
                                                                        <td align="center" style="width: 25%;">
                                                                            Date
                                                                        </td>
                                                                        <td align="center" style="width: 25%;">
                                                                            Number Of Items
                                                                        </td>
                                                                        <td align="center" style="width: 25%;">
                                                                            Amount
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table cellpadding="0"   style="border-color: #000000; border-collapse: collapse;"
                                                                    cellspacing="0" border="0" width="100%">
                                                                    <tr>
                                                                        <td valign="top">
                                                                            <asp:GridView  ID="grdCollectionDetail" Visible="true" runat="server" AutoGenerateColumns="False"
                                                                                CellPadding="0"  PageSize="1000" ForeColor="#000000" GridLines="both" BorderColor="#000000" RowStyle-VerticalAlign="Top"
                                                                                Width="100%">
                                                                                <RowStyle Font-Bold="false" />
                                                                                <Columns>
                                                                                    <asp:TemplateField>
                                                                                        <HeaderTemplate>
                                                                                            <asp:Label ID="LBL" runat="server" Visible="false"></asp:Label>
                                                                                        </HeaderTemplate>
                                                                                    
                                                                                        <ItemTemplate>
                                                                                            <table width="100%" border="0" cellpadding="4" cellspacing="0">
                                                                                                <tr>
                                                                                                    <td align="center" style="width: 25%;">
                                                                                                        <%# DataBinder.Eval(Container.DataItem, "DeptName")%>
                                                                                                    </td>
                                                                                                    <td align="center" style="width: 25%;">
                                                                                                        <%# DataBinder.Eval(Container.DataItem, "BillDate","{0:dd/MM/yyyy}")%>
                                                                                                    </td>
                                                                                                    <td align="center" style="width: 25%;">
                                                                                                        <%# DataBinder.Eval(Container.DataItem, "NumberOfItem")%>
                                                                                                    </td>
                                                                                                    <td align="right" style="width: 25%;">
                                                                                                        <%# DataBinder.Eval(Container.DataItem, "GrossAmount")%>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <%--<asp:BoundField DataField="DeptName" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                                                                        Visible="true" ItemStyle-Width="25%">
                                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Width="25%"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="BillDate" DataFormatString="{0:dd/MM/yyyy}" HeaderStyle-HorizontalAlign="right"
                                                                                        ItemStyle-HorizontalAlign="right" Visible="true">
                                                                                        <HeaderStyle HorizontalAlign="right"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="right" Width="25%"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="NumberOfItem" HeaderStyle-HorizontalAlign="right" ItemStyle-HorizontalAlign="right"
                                                                                        Visible="true">
                                                                                        <HeaderStyle HorizontalAlign="right"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="right" Width="25%"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="GrossAmount" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                                                        ItemStyle-HorizontalAlign="Right" ItemStyle-Width="25%" Visible="true">
                                                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Right" Width="25%"></ItemStyle>
                                                                                    </asp:BoundField>--%>
                                                                                </Columns>
                                                                            </asp:GridView>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <table cellpadding="0" cellspacing="0" border="1" width="100%">
                                                                                <tr style="color: #000000; font-weight:bold;">
                                                                                    <td align="left" style="width: 75%; padding-right: 0px;">
                                                                                        &nbsp;
                                                                                    </td>
                                                                                    <td align="right" style="width: 25%;">
                                                                                        Total Amount :
                                                                                        <%# DataBinder.Eval(Container.DataItem,"GrossAmount","{0:0.00}") %>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                            <asp:Label runat="server" ID="lblForter" Visible="false"></asp:Label>
                                                            </FooterTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <PagerTemplate>
                                                        <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="false" CommandArgument="Prev"
                                                            CommandName="Page" ImageUrl="~/Images/previousimage.png" Width="18px" />
                                                        <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="false" CommandArgument="Next"
                                                            CommandName="Page" ImageUrl="~/Images/nextimage.png" Width="18px" />
                                                    </PagerTemplate>
                                                    <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
               
                  <asp:Table CellPadding="4" Visible="false" style=" color:#000000; border-width:1px; font-weight:normal; border-color:#000000;" Width="100%" CellSpacing="0" BorderWidth="1" runat="server" ID="consumableTab">
                                     
                                        </asp:Table>
                                        <table border="0" id="miscellaneousTotalTab" runat="server" visible="false" 
                                     cellpadding="5" style="color: #000000; font-weight:bold;" cellspacing="0" width="100%">
                                     <tr>
                                            <td align="right" style="width: 80%;">
                                             Miscellaneous Total:
                                            </td>
                                            <td align="right" style="padding-right: 15px;">
                                                <label id="lblMiscellaneousTotal" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                        </table>
                                    <table border="0" id="individualDeptCollectionTab" runat="server" visible="false" 
                                     cellpadding="5" style="color: #000000;font-weight:bold;" cellspacing="0" width="100%">
                                     <tr>
                                            <td align="right" style="width: 80%;">
                                              Total Collection Of Departments:
                                            </td>
                                            <td align="right" style="padding-right: 15px;">
                                                <label id="lblIndividualDeptCollection" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                        </table>
                                     <table border="0" id="combinedDeptCollectionTab" runat="server" visible="false" 
                                     cellpadding="5" style="color: #000000;font-weight:bold;" cellspacing="0" width="100%">
                                     <tr>
                                            <td align="right" style="width: 80%;">
                                             Total Collection Of Groups & Packages:
                                            </td>
                                            <td align="right" style="padding-right: 15px;">
                                                <label id="lblCombinedDeptCollection" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                        </table>
                                                                          
                                     <table border="0" id="tabGranTotal1" runat="server" visible="false" 
                                     cellpadding="5" style="color: #000000; font-weight:bold;" cellspacing="0" width="100%">
                                     <tr>
                                            <td align="right" style="width: 80%;">
                                               Grand Total:
                                            </td>
                                            <td align="right" style="padding-right: 15px;">
                                                <label id="lblGrandTotal" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                        </table>
                                    <table border="0" id="tabGranTotal2" runat="server" visible="false" 
                                        cellpadding="5" style="color: #000000;font-weight:bold;" cellspacing="0" width="100%">
                                       
                                        <tr>
                                        <td colspan="2" align="right">
                                        ----------------
                                        </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 80%;font-weight:bold;">
                                                Total Collection Amount:
                                            </td>
                                            <td align="right" style="padding-right: 15px;font-weight:bold;">
                                                <label id="lblCollectionAmount" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 80%;font-weight:bold;">
                                                Total Discount Amount:
                                            </td>
                                            <td align="right" style="padding-right: 15px;font-weight:bold;">
                                                <label id="lblDiscountAmount" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 80%;font-weight:bold;">
                                                Total Due Amount:
                                            </td>
                                            <td align="right" style="padding-right: 15px;font-weight:bold;">
                                                <label id="lblDueAmount" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                         <tr>
                                        <td colspan="2" align="right">
                                        ----------------
                                        </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 80%;font-weight:bold;">
                                                Total Cash Amount:
                                            </td>
                                            <td align="right" style="padding-right: 15px;font-weight:bold;">
                                                <label id="lblCashAmount" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td align="right" style="width: 80%;font-weight:bold;">
                                                Total Due Paid Amount:
                                            </td>
                                            <td align="right" style="padding-right: 15px;font-weight:bold;">
                                                <label id="lblDuePaidAmount" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                         <tr>
                                        <td colspan="2" align="right">
                                        ----------------
                                        </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 80%;font-weight:bold;">
                                                Grand Total Amount:
                                            </td>
                                            <td align="right" style="padding-right: 15px;font-weight:bold;">
                                                <label id="lblGrandTotalAmount" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                         <tr>
                                        <td colspan="2" align="right">
                                        ----------------
                                        </td>
                                        </tr>
                                    </table>
                                       <table cellpadding="5" cellspacing="0" border="0" width="100%" class="dataheaderInvCtrl"
                                        runat="server" style="display: none;" id="Table1">
                                        <tr Class="Duecolor">
                                            <td align="left">
                                               <asp:Label ID="Label2" runat="server"></asp:Label>
                                                <asp:Label ID="Label3" runat="server"></asp:Label><%--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:Label ID="lblId" runat="server"></asp:Label>
                                                <asp:Label ID="lblHospitalId" runat="server"></asp:Label>--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" PageSize="1000">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Department Name" HeaderStyle-ForeColor="#000000" ItemStyle-ForeColor="#000000" ItemStyle-Width="14%">
                                                            <ItemTemplate>
                                                                <div style="text-align: center;">
                                                                    <asp:Label ID="lblDepartmentName" runat="server" Text='<%#Bind("DeptName") %>'></asp:Label>
                                                                </div>
                                                            </ItemTemplate>
                                                        
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Number Of Investigation" HeaderStyle-ForeColor="#000000" ItemStyle-ForeColor="#000000" ItemStyle-Width="14%">
                                                            <ItemTemplate>
                                                                <div style="text-align: center;">
                                                                    <asp:Label ID="lblNumberOfItem" HeaderStyle-ForeColor="#000000" ItemStyle-ForeColor="#000000" runat="server" Text='<%#Bind("NumberOfItem") %>'></asp:Label>
                                                                </div>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Number Of Cases" HeaderStyle-ForeColor="#000000" ItemStyle-ForeColor="#000000" ItemStyle-Width="14%">
                                                            <ItemTemplate>
                                                                <div style="text-align: center;">
                                                                    <asp:Label ID="lblPatientCount" runat="server" Text='<%#Bind("PatientCount") %>'></asp:Label>
                                                                </div>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                  <%--  <HeaderStyle  Font-Bold="True"  HorizontalAlign="Left"/>--%>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
               
    
    <table cellspacing="0" border="0" width="100%" runat="server" id="tblAllDoctorsReport"
        style="display: none;">
        <tr>
            <td>
                <asp:GridView ID="grdDoctorsResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataKeyNames="ReferingPhysicianID" GridLines="none" Width="100%" OnRowDataBound="grdDoctorsResult_RowDataBound"
                    HeaderStyle-BorderWidth="0px" PageSize="1000">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <table cellpadding="0" style="border-color: #000000; border-collapse: collapse;"
                                    cellspacing="0" width="100%" border="1" >
                                    <tr>
                                        <td>
                                            <table cellpadding="5" cellspacing="0" border="0" width="100%">
                                                <tr style="font-weight:bold;">
                                                    <td align="left">
                                                       
                                                        <%# DataBinder.Eval(Container.DataItem,"HeaderName") %>
                                                    </td>
                                                    <td align="left" style="display: none;" visible="false">
                                                        <%# DataBinder.Eval(Container.DataItem, "ID")%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="gvChildDoctorsResult" runat="server" AutoGenerateColumns="False"
                                                GridLines="Both" Width="100%" PageSize="1000">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Department Name" ItemStyle-Width="14%">
                                                        <ItemTemplate>
                                                            <div style="text-align: center;">
                                                                <asp:Label ID="lblDepartmentName" runat="server" Text='<%#Bind("DeptName") %>'></asp:Label>
                                                            </div>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="14%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Number Of Investigation" ItemStyle-Width="14%">
                                                        <ItemTemplate>
                                                            <div style="text-align: center;">
                                                                <asp:Label ID="lblNumberOfItem" runat="server" Text='<%#Bind("NumberOfItem") %>'></asp:Label>
                                                            </div>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="14%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Number Of Cases" ItemStyle-Width="14%">
                                                        <ItemTemplate>
                                                            <div style="text-align: center;">
                                                                <asp:Label ID="lblPatientCount" runat="server" Text='<%#Bind("PatientCount") %>'></asp:Label>
                                                            </div>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="14%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                                </td> </tr> </table>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        
    </table>
    <br />
    <br />
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
        <tr>
        <td align="left" style=" padding-left:50px; font-size:12px; font-weight:bold;">
        Receptionist
        </td>
        <td align="right" style=" padding-right:50px; font-size:12px; font-weight:bold;">
        Accountant
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
