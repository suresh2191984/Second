<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Printworkorder.aspx.cs" Inherits="Lab_Printworkorder" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
      <script language="javascript" type="text/javascript">
        window.name = "ReportWindow";
    </script>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <style type="text/css" media="print">
        #header, #footer
        {
            display: none;
        }
    </style>

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

</head>

<body id="oneColLayout" oncontextmenu="return false;">
    <form id="prFrm" runat="server">  <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div>
     
    
     <asp:Table CellPadding="2" CssClass="colorforcontentborder" CellSpacing="0" Font-Size="Small"
                                BorderWidth="0px" runat="server" ID="dispTab" 
            Width="50%" meta:resourcekey="dispTabResource1">
                                <asp:TableRow Height="15px" BorderWidth="0" 
                                    meta:resourcekey="TableRowResource3">
                        <asp:TableHeaderCell ColumnSpan="2" HorizontalAlign="Left" 
                                        meta:resourcekey="TableHeaderCellResource1">
                            <asp:Table CellPadding="2" CssClass="colorforcontentborder" CellSpacing="0" Font-Size="Small"
                                BorderWidth="0" runat="server" ID="dispTab1" Width="100%" 
                                        meta:resourcekey="dispTab1Resource1">
                                <asp:TableRow Height="15px" BorderWidth="0" 
                                    meta:resourcekey="TableRowResource1">
                                <asp:TableHeaderCell ColumnSpan="3" HorizontalAlign="left" 
                                        meta:resourcekey="TableHeaderCellResource2">
                                        <asp:Literal ID="ColVisitNo" runat="server" Text="Visit No:" 
                                        meta:resourcekey="ColVisitNoResource1"></asp:Literal>
                                        

                                        

                                        &nbsp;
                                        <asp:Literal ID="VisitNo" runat="server" 
                                        meta:resourcekey="VisitNoResource2"></asp:Literal>
                                    
</asp:TableHeaderCell>
                                
</asp:TableRow>
                                
<asp:TableRow Height="15px" BorderWidth="0" meta:resourcekey="TableRowResource2">
                                    <asp:TableHeaderCell HorizontalAlign="Left" 
        meta:resourcekey="TableHeaderCellResource3">
                                        <asp:Literal ID="ColPatientName" 
        runat="server" Text="Name:" meta:resourcekey="ColPatientNameResource1"></asp:Literal>
                                        

                                        

                                        &nbsp;<asp:Literal ID="PatientName" 
        runat="server" meta:resourcekey="PatientNameResource2"></asp:Literal>
                                    
</asp:TableHeaderCell>
                                    
<asp:TableHeaderCell HorizontalAlign="center" 
        meta:resourcekey="TableHeaderCellResource4">
                                        <asp:Literal ID="Literal1" runat="server" 
        Text="Age:" meta:resourcekey="Literal1Resource1"></asp:Literal>
                                        

                                        

                                        &nbsp;<asp:Literal ID="ltAge" 
        runat="server" meta:resourcekey="ltAgeResource1"></asp:Literal>
                                    
</asp:TableHeaderCell>
                                    
<asp:TableHeaderCell HorizontalAlign="left" 
        meta:resourcekey="TableHeaderCellResource5">
                                        <asp:Literal ID="Literal2" runat="server" 
        Text="Sex:" meta:resourcekey="Literal2Resource1"></asp:Literal>
                                        

                                        

                                        &nbsp;<asp:Literal ID="ltSex" 
        runat="server" meta:resourcekey="ltSexResource1"></asp:Literal>
                                    
</asp:TableHeaderCell>
                                    
                                
</asp:TableRow>
                            
</asp:Table>
                        
</asp:TableHeaderCell>
                    </asp:TableRow>
                             <asp:TableRow Height="15px" BorderWidth="0" meta:resourcekey="TableRowResource4">
                        <asp:TableHeaderCell ForeColor="#000" HorizontalAlign="left" 
                                     meta:resourcekey="TableHeaderCellResource6">
                            <asp:Literal ID="ColDrName" runat="server" Text="Dr. Name:" 
                                     meta:resourcekey="ColDrNameResource1"></asp:Literal>
                            

                            

                            &nbsp;
                            <asp:Literal ID="DrName"  runat="server" meta:resourcekey="DrNameResource2"></asp:Literal>
                        
</asp:TableHeaderCell>
                        </asp:TableRow>
                    <asp:TableRow Height="15px" BorderWidth="0" meta:resourcekey="TableRowResource5">
                        <asp:TableHeaderCell ForeColor="#000"  HorizontalAlign="left" 
                            meta:resourcekey="TableHeaderCellResource7">
                            <asp:Literal ID="Literal3" runat="server" Text="Hospital/Branch:" 
                            meta:resourcekey="Literal3Resource1"></asp:Literal>
                            

                            

                            &nbsp;
                            <asp:Literal ID="HospitalName" runat="server" 
                            meta:resourcekey="HospitalNameResource1"></asp:Literal>
                        
</asp:TableHeaderCell>
                    </asp:TableRow>
                    
                   <asp:TableRow ID="TableRow1" runat="server"  BorderWidth="0" 
                                    meta:resourcekey="TableRow1Resource1">
                        <asp:TableHeaderCell ColumnSpan="4" HorizontalAlign="left" 
                            meta:resourcekey="TableHeaderCellResource8">
                        
                        <asp:Table CellPadding="0"  CellSpacing="0" BorderWidth="0"
                    runat="server" ID="trCC" style="display:none;" Width="100%" 
                            meta:resourcekey="trCCResource1">
                     <asp:TableRow    Height="15px" BorderWidth="0" meta:resourcekey="TableRowResource6">
                        <asp:TableHeaderCell ForeColor="#000" ColumnSpan="2" HorizontalAlign="left" 
                             meta:resourcekey="TableHeaderCellResource9">
                            <asp:Literal ID="Literal4"  runat="server" Text="Collection Centre:" 
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
        <table cellpadding="4" cellspacing="0" border="0" width="50%">
            <tr style=" font-size:small; color:#000;height:15px;">
                <td>
                   <b><u><asp:Label ID="Rs_ListOfOrderedInvestigations" 
                        Text="List Of Ordered Investigations" runat="server" 
                        meta:resourcekey="Rs_ListOfOrderedInvestigationsResource1"></asp:Label></u></b>
                </td>    
            </tr>
        </table>
      
        <asp:DataList ID="dlInvName" runat="server"  Font-Size="Small"  
            ForeColor="#000000" Width="50%"  BorderWidth="0px" CellPadding="0" 
            RepeatColumns="2" ItemStyle-Wrap="true"  RepeatDirection="Horizontal" 
            meta:resourcekey="dlInvNameResource1">
<ItemStyle Wrap="True"></ItemStyle>
                    <HeaderTemplate>
                        <table border="0px" cellpadding="1px" width="100%" >
                            <tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <td valign="top" align="left"  style="height: 20px; width:50%;border-style:solid; color:#000; border-width:0px;border-collapse:collapse;">
                          
                            <%# DataBinder.Eval(Container.DataItem, "InvestigationName")%>
                        </td>
                        
                    </ItemTemplate>
                    <FooterTemplate>
                        </tr> 
                        </table>
                    </FooterTemplate>
                </asp:DataList>
        
         <table border="0" cellpadding="4"  cellspacing="0" width="70%">
              <tr style="font-size:small; color:#000;height:15px;">
                <td colspan="4">
                   <b><u><asp:Label ID="Rs_ListOfSamplesCollected" Text="List Of Samples Collected" 
                        runat="server" meta:resourcekey="Rs_ListOfSamplesCollectedResource1"></asp:Label></u></b>
                </td>    
            </tr>
                    <tr style="font-size:small; color:#000;">
                        <td style="font-weight: normal; height: 8px;  color: #000;
                            width: 25%;" align="left">
                           <b> <asp:Label ID="Rs_SampleName" Text="Sample Name" runat="server" 
                                meta:resourcekey="Rs_SampleNameResource1"></asp:Label></b>
                        </td>
                        <td style="font-weight: normal; height: 8px;  color: #000;
                            width: 15%;" align="left">
                           <b><asp:Label ID="Rs_Additive" Text="Additive" runat="server" 
                                meta:resourcekey="Rs_AdditiveResource1"></asp:Label></b>
                        </td>
                        <td style="font-weight: normal; height:8px; color: #000;
                            width: 15%;" align="left">
                            <b><asp:Label ID="Rs_Status" Text="Status" runat="server" 
                                meta:resourcekey="Rs_StatusResource1"></asp:Label></b>
                        </td>
                         <td style="font-weight: normal; height:8px; color: #000;
                            width: 15%;" align="left">
                            <b><asp:Label ID="Rs_Barcode" Text="Barcode" runat="server" 
                                 meta:resourcekey="Rs_BarcodeResource1"></asp:Label></b>
                        </td>
                        <td style="font-weight: normal; height: 8px; color: #000;
                            width: 15%;" align="left">
                              <b><asp:Label ID="Rs_DepartmentName" Text="Department Name" runat="server" 
                                  meta:resourcekey="Rs_DepartmentNameResource1"></asp:Label></b>
                        </td>
                        <td style="font-weight: normal; height: 8px;color: #000;
                            width: 15%;" align="left">
                             <b><asp:Label ID="Rs_CollectedTime" Text="Collected Time" runat="server" 
                                 meta:resourcekey="Rs_CollectedTimeResource1"></asp:Label></b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" style="font-weight: normal; height: 10px; font-size:small; color: #000;" align="left">
                            <asp:Label ID="lblStatus"  runat="server" Font-Size="12px" Font-Bold="False"  
                                Visible="False" meta:resourcekey="lblStatusResource1">
             &nbsp;<asp:Label ID="Rs_Info" Text="( No Samples collected for Current Visit )" runat="server" 
                                meta:resourcekey="Rs_InfoResource1"></asp:Label>
            
</asp:Label>
                            <asp:DataList ID="dtSample" runat="server" CellPadding="2" Width="100%" 
                                meta:resourcekey="dtSampleResource1">
                                <ItemTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td style="font-weight: normal; height: 5px; color: #000; width: 25%;" align="left">
                                                <%# DataBinder.Eval(Container.DataItem, "SampleDesc")%>
                                            </td>
                                             <td style="font-weight: normal; height: 5px; color: #000; width: 15%;" align="left">
                                                <%# DataBinder.Eval(Container.DataItem, "SampleContainerName")%>
                                            </td>
                                            <td style="font-weight: normal; height: 5px; color: #000; width: 15%;" align="left">
                                                <%# DataBinder.Eval(Container.DataItem, "InvSampleStatusDesc")%>
                                            </td>
                                            <td style="font-weight: normal; height: 5px; color: #000; width: 15%;" align="left">
                                                <%# DataBinder.Eval(Container.DataItem, "BarcodeNumber")%>
                                            </td>
                                            <td style="font-weight: normal; height: 5px; color: #000; width: 15%;" align="left">
                                                <%# DataBinder.Eval(Container.DataItem, "DeptName")%>
                                            </td>
                                            <td style="font-weight: normal; height: 5px; color: #000; width: 15%;" align="left">
                                                <%# DataBinder.Eval(Container.DataItem, "CreatedAt","{0:dd/MM/yyyy hh:mm tt}")%>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:DataList>
                        </td>
                    </tr>
                </table>
                <div id="deptBlock" runat="server" style="display:none;">
                 <table cellpadding="4" cellspacing="0" border="0" width="50%">
            <tr style=" font-size:small; color:#000;height:15px;">
                <td>
                   <b><u><asp:Label ID="Rs_Info1" 
                        Text="(Department for which the Samples has to be sent)" runat="server" 
                        meta:resourcekey="Rs_Info1Resource1"></asp:Label></u></b>
                </td>    
            </tr>
        </table>
        <asp:DataList ID="dlDeptName" runat="server"  Font-Size="Small"  ForeColor="#000000" 
                        Width="50%"  BorderWidth="0px" CellPadding="0" RepeatColumns="3" 
                        ItemStyle-Wrap="true"  RepeatDirection="Horizontal" 
                        meta:resourcekey="dlDeptNameResource1">
<ItemStyle Wrap="True"></ItemStyle>
                    <HeaderTemplate>
                        <table border="0px" cellpadding="1px" width="100%" >
                            <tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <td valign="top" align="left"  style="height: 20px; width:50%;border-style:solid; color:#000; border-width:0px;border-collapse:collapse;">
                          
                            <%# DataBinder.Eval(Container.DataItem, "DeptName")%>
                        </td>
                        
                    </ItemTemplate>
                    <FooterTemplate>
                        </tr> 
                        </table>
                    </FooterTemplate>
                </asp:DataList></div>
             
    </div>
    </form>
    <script language="javascript" type="text/javascript">
        window.print();
       
    </script>
</body>
</html>
