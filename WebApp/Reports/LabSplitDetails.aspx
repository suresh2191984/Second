<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LabSplitDetails.aspx.cs" Inherits="Reports_LabSplitDetails" 
 EnableEventValidation ="false" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title><link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    
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
    <div>
        <table align="center" width="100%">
            <tr valign="middle" align="center">
                <td align="center">
                  <div id="divPrint" style="display: none;" runat="server">
                                <table cellpadding="0" cellspacing="0" border="0" width="550px">
                                    <tr>
                                        <td align="right" style="padding-right: 10px; color: #000000;">
                                            <b id="printText" runat="server"><asp:Label ID="Rs_PrintReport" 
                                                Text ="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label> </b>&nbsp;&nbsp;
                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                        </td>
                                          <td align="right"  >
                                                <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                    ToolTip="Save As Excel" />
                                                <asp:LinkButton ID="lnkExportXL" OnClick="imgBtnXL_Click" runat="server" Font-Bold="true"
                                                    Visible="true" ForeColor="#000000" ToolTip="Save As Excel"><u><b>Export To XL</b></u></asp:LinkButton>
                                            </td>
                                    </tr>
                                </table>
                            </div>
                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                <ProgressTemplate>
                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" 
                                        meta:resourcekey="imgProgressbarResource1" />
                                   <asp:Label ID="Rs_Pleasewait" Text ="Please wait...." runat="server" 
                                        meta:resourcekey="Rs_PleasewaitResource1" ></asp:Label> 
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                          <%--  <div style="height: 500px; width: 600px; overflow: auto;">--%>
                          
                            <div id="divOPDWCR" runat="server" style="display: none;">
                                <div id="prnReport" runat ="server" >
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:GridView ID="gvCollReport" runat="server" AutoGenerateColumns="False" Visible="False"
                                                    Width="97%" OnRowDataBound="gvCollReport_RowDataBound" 
                                                    meta:resourcekey="gvCollReportResource1">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Collection Report" 
                                                            meta:resourcekey="TemplateFieldResource2">
                                                            <ItemTemplate>
                                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                    <tr>
                                                                        <td align="left" style="height: 25px;">
                                                                            <b><asp:Label ID="Rs_Department" Text ="Department :" runat="server" 
                                                                                meta:resourcekey="Rs_DepartmentResource1" ></asp:Label></b>
                                                                            <%# DataBinder.Eval(Container.DataItem, "DeptName")%>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:GridView ID="gvCollIndDept" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                                ForeColor="#333333" 
                                                                                OnRowDataBound="gvCollIndDept_RowDataBound" 
                                                                                meta:resourcekey="gvCollIndDeptResource1">
                                                                                <Columns>
                                                                                
                                                                                      <asp:BoundField DataField="PatientNumber" HeaderText="Patient NO" 
                                                                                       meta:resourcekey="BoundFieldResource1" >
                                                                                        <ItemStyle Width="170px" Wrap="false" />
                                                                                    </asp:BoundField>
                                                                                  
                                                                                    <asp:BoundField DataField="IPNumber" HeaderText="IP No" 
                                                                                          >
                                                                                        <ItemStyle Width="90px"  Wrap="false"  />
                                                                                    </asp:BoundField>
                                                                                      <asp:BoundField DataField="BillNumber" HeaderText="Bill No" 
                                                                                         >
                                                                                        <ItemStyle Width="90px"  Wrap="false"  />
                                                                                    </asp:BoundField>
                                                                                   
                                                                                    <asp:BoundField DataField="PatientName" HeaderText="Name" 
                                                                                        meta:resourcekey="BoundFieldResource3">
                                                                                        <ItemStyle HorizontalAlign="Left" Wrap="False" Width="100px" ></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="Age" HeaderText="Age" 
                                                                                        meta:resourcekey="BoundFieldResource4">
                                                                                        <ItemStyle HorizontalAlign="Left" Wrap="False" Width="120px"></ItemStyle>
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="Description"
                                                                                        HeaderText="Description" meta:resourcekey="BoundFieldResource5" >
                                                                                        <ItemStyle Width="290px" HorizontalAlign="Left"   Wrap="false" />
                                                                                    </asp:BoundField>
                                                                                    <%--<asp:BoundField DataField="PhysicianName"
                                                                                        HeaderText="Physician Name" meta:resourcekey="BoundFieldResource6" >
                                                                                        <ItemStyle Width="150px" />
                                                                                    </asp:BoundField>--%>
                                                                                    <asp:BoundField DataField="NoOfTests"
                                                                                        HeaderText="Qty" >
                                                                                        <ItemStyle Width="80px" HorizontalAlign="Right" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="BilledAmount"
                                                                                        HeaderText="BilledAmount"  >
                                                                                        <ItemStyle Width="130px" HorizontalAlign="Right" />
                                                                                    </asp:BoundField>
                                                                                    <asp:TemplateField HeaderText="Date" meta:resourcekey="TemplateFieldResource1">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblDate" runat="server" 
                                                                                                Text='<%# Bind("VisitDate", "{0:dd/MM/yyyy}") %>' 
                                                                                                meta:resourcekey="lblDateResource1"></asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle Width="30px"  Wrap="false" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:BoundField DataField="ReferredBy"
                                                                                        HeaderText="ReferingPhysicianName"  >
                                                                                        <ItemStyle Width="130px" HorizontalAlign="Right" />
                                                                                    </asp:BoundField>
                                                                                     <asp:BoundField DataField="CollectedName"
                                                                                        HeaderText="Ref.OrgName"  >
                                                                                        <ItemStyle Width="130px" HorizontalAlign="Right" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField Visible="false" DataField="NetValue"
                                                                                        HeaderText="NetValue"  >
                                                                                        <ItemStyle Width="130px" HorizontalAlign="Right" />
                                                                                    </asp:BoundField>
                                                                                </Columns>
                                                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True"  />
                                                                            </asp:GridView>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                           <%-- </div>--%>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
