<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DepartmentWiseDetailReportPopUp.aspx.cs" Inherits="Reports_DepartmentWiseDetailReportPopUp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
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
        function openViewBill(obj, ftype) {
            if (ftype == "PRM") {
                var skey = "../Inventory/PrintBill.aspx"
                           + obj
                           + "&IsPopup=" + "Y"
                           + "&CCPage=Y"
                           + "";

                window.open(skey, 'ViewBill', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');
            }
            else {
                var skey = "../Reception/ViewPrintPage.aspx"
                           + obj
                           + "&IsPopup=" + "Y"
                           + "&CCPage=Y"
                           + "";

                window.open(skey, 'ViewBill', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <div>
        <table align="center" width="700px">
            <tr valign="middle" align="center">
                <td align="center">
                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                <ProgressTemplate>
                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                    <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <div style="height: 600px; overflow: auto;">
                                <div id="divPrint" style="display: none;" runat="server">
                                    <table cellpadding="0" cellspacing="0" border="0" width="600px">
                                        <tr>
                                            <td align="right" style="padding-right: 10px; color: #000000;">
                                                <b id="printText" runat="server">
                                                    <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                                <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                    ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="divOPDWCR" runat="server" style="display: none;">
                                    <div id="prnReport" width="600px">
                                        <table width="600px">
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="gvCollReport" runat="server" AutoGenerateColumns="False" Visible="False"
                                                        Width="100%" OnRowDataBound="gvCollReport_RowDataBound" meta:resourcekey="gvCollReportResource1">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Collection Report" meta:resourcekey="TemplateFieldResource2">
                                                                <ItemTemplate>
                                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                        <tr>
                                                                            <td align="left" style="height: 25px;">
                                                                                <b>
                                                                                    <asp:Label ID="Rs_Department" Text="Department:" runat="server" meta:resourcekey="Rs_DepartmentResource1"></asp:Label></b>
                                                                                <%# DataBinder.Eval(Container.DataItem, "FeeType")%>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:GridView ID="gvCollIndDept" runat="server" AutoGenerateColumns="False" Width="650px"
                                                                                    ForeColor="#333333" CssClass="mytable1" OnRowDataBound="gvCollIndDept_RowDataBound"
                                                                                    meta:resourcekey="gvCollIndDeptResource1">
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="PatientNumber" HeaderText="Patient Number" meta:resourcekey="BoundFieldResource1">
                                                                                            <ItemStyle Width="25px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="PatientName" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                                                                            <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="Age" HeaderText="Age" meta:resourcekey="BoundFieldResource3">
                                                                                            <ItemStyle HorizontalAlign="Right" Wrap="False"></ItemStyle>
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="ConsultantName" HeaderText="Description" meta:resourcekey="BoundFieldResource4">
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                        <asp:TemplateField HeaderText="Date" meta:resourcekey="TemplateFieldResource1">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblDate" runat="server" Text='<%# Bind("VisitDate", "{0:dd/MM/yyyy}") %>'
                                                                                                    meta:resourcekey="lblDateResource1"></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="50px" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:BoundField DataField="ItemQuantity" HeaderText="Quantity" meta:resourcekey="BoundFieldResource5">
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="BilledAmount" HeaderText="BilledAmount" meta:resourcekey="BoundFieldResource6">
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="AmountReceived" HeaderText="AmountReceived" meta:resourcekey="BoundFieldResource7">
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                    </Columns>
                                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                                </asp:GridView>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <table id="tblgvCollIndDeptS" runat="server" visible="False" cellpadding="0" cellspacing="0"
                                                        border="0" width="100%">
                                                        <tr id="Tr1" runat="server">
                                                            <td id="Td1" align="left" style="height: 25px;" runat="server">
                                                                <b>
                                                                    <asp:Label ID="Rs_Department1" Text="Department:" runat="server"></asp:Label></b>
                                                                <asp:Label ID="lblFeeType" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr id="Tr2" runat="server">
                                                            <td id="Td2" runat="server">
                                                                <asp:GridView ID="gvCollIndDeptS" runat="server" AutoGenerateColumns="False" Width="400px"
                                                                    ForeColor="#333333" CssClass="mytable1" OnRowDataBound="gvCollIndDeptS_RowDataBound">
                                                                    <Columns>
                                                                        <asp:BoundField DataField="BillNumber" HeaderText="Bill No">
                                                                            <ItemStyle Width="25px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="PatientNumber" HeaderText="Patient Number">
                                                                            <ItemStyle Width="25px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="PatientName" HeaderText="Name">
                                                                            <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Age" HeaderText="Age">
                                                                            <ItemStyle HorizontalAlign="Right" Wrap="False"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="VisitType" HeaderText="Visit Type">
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="False"></ItemStyle>
                                                                        </asp:BoundField>
                                                                        <asp:TemplateField HeaderText="Description">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblDescription" Text='<%#Eval("ConsultantName") %>' runat="server"></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Date">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblDate" runat="server" Text='<%# Bind("VisitDate", "{0:dd/MM/yyyy}")%>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="ItemQuantity" DataFormatString="{0:N0}" HeaderText="Quantity">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="BilledAmount" HeaderText="BilledAmount">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataFormatString="{0:0.00}" DataField="AmountReceived" HeaderText="AmountReceived">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                    </Columns>
                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <table>
                                                        <tr>
                                                            <td width="85%" align="right">
                                                                <b>
                                                                    <asp:Label runat="server" ID="lblGrdTot" meta:resourcekey="lblGrdTotResource1"></asp:Label>
                                                                </b>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
