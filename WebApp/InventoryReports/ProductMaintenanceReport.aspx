<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductMaintenanceReport.aspx.cs"
    Inherits="InventoryReports_ProductMaintenanceReport" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/InventoryCommon/Controls/ProductSearch.ascx" TagName="ProductSearch"
    TagPrefix="uc11" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Product Maintenance</title>

    <script language="javascript" type="text/javascript">
        function checkDetails() {
            if (document.getElementById('ddlCategory').value == "0") {
            }
        }
        function CallPrint() {
            var prtContent = document.getElementById('printdiv');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false;
        }
      

    </script>

</head>
<body>
    <form id="RecHome" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table width="100%">
                    <tr>
                        <td align="center">
                            <div>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <caption>
                                        &nbsp;
                                        <tr align="center">
                                            <td align="center">
                                                <div class="dataheaderWider" style="width: 100%">
                                                    <table width="100%">
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Label ID=lblFrooo runat="server" meta:resourcekey="lblFroooResource1">From Date</asp:Label>
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txtFrom" runat="server" CssClass="small datePicker"
                                                                    onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                                            </td>
                                                            <td align="left">
                                                                <asp:Label ID=lblToo runat="server" meta:resourcekey="lblTooResource1">To Date</asp:Label>           
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txtTo" runat="server" CssClass="small datePicker"
                                                                    onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtToResource1"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                            <td align="right">
                                                                <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1">Back&nbsp;&nbsp;&nbsp;</asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Label ID=lblProductt runat="server" 
                                                                    meta:resourcekey="lblProducttResource1">Product Category</asp:Label>
                                                            </td>
                                                            <td align="left">
                                                                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="ddl" Width="130px" 
                                                                    TabIndex="3" meta:resourcekey="ddlCategoryResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td align="left">
                                                                <asp:Label ID="Rs_Search" runat="server" Text="Product Name" meta:resourcekey="Rs_SearchResource1"></asp:Label>
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txtSearch" runat="server" OnkeyPress="return ValidateMultiLangChar(this)"
                                                                    CssClass="Txtboxsmall" meta:resourcekey="txtSearchResource1"></asp:TextBox>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Label ID=lblSearchtty runat="server" 
                                                                    meta:resourcekey="lblSearchttyResource1">Search Type</asp:Label>
                                                            </td>
                                                            <td align="left">
                                                                <asp:RadioButtonList ID="rdotypes" runat="server" RepeatDirection="Horizontal" meta:resourcekey="rdotypesResource1">
                                                                    <asp:ListItem Text="Pending" Value="0" Selected="True" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                    <asp:ListItem Text="Completed" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                            <td align="left">
                                                                <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                                                    OnClientClick="javascript:return checkDetails();" OnClick="btnSearch_Click" TabIndex="4" meta:resourcekey="btnSearchResource1"  />
                                                            </td>
                                                          
                                                            <td id="tdPrint" align="left" style="display: none;" runat="server">
                                                                <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="../Images/printer.GIF"
                                                                    ToolTip="Click Here To Print Supplier Details" OnClientClick="return CallPrint();"  meta:resourcekey="imgBtnPrintResource1" />
                                                                <asp:LinkButton ID="lnkPrint" runat="server" Font-Bold="True" 
                                                                    OnClientClick="return CallPrint();" Font-Size="12px" ForeColor="Black" 
                                                                    ToolTip="Click Here To Print Stock Details" 
                                                                    meta:resourcekey="lnkPrintResource1"><u>Print</u></asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </caption>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <div id="printdiv" runat="server">
                                <asp:GridView ID="gvProduct" runat="server" AutoGenerateColumns="False"
                                    EmptyDataText="No Matching Record Found" CssClass="mytable1" DataKeyNames="ProductID"
                                    OnPageIndexChanging="gvProduct_PageIndexChanging" OnRowCommand="gvProduct_RowCommand"
                                    Width="100%" OnRowDataBound="gvProduct_RowDataBound" 
                                    meta:resourcekey="gvProductResource1">
                                    <Columns>
                                        <asp:BoundField DataField="ProductName" HeaderText="Product" 
                                            meta:resourcekey="BoundFieldResource1" />
                                        <asp:BoundField DataField="Model" HeaderText="Product Model " 
                                            meta:resourcekey="BoundFieldResource2" />
                                        <asp:BoundField DataField="Description" HeaderText="Description" 
                                            meta:resourcekey="BoundFieldResource3" />
                                        <asp:BoundField DataField="HasSerialNo" HeaderText="Serial Number" 
                                            meta:resourcekey="BoundFieldResource4" />
                                        <asp:BoundField DataField="Frequency" HeaderText="Maintenance Frequency" 
                                            meta:resourcekey="BoundFieldResource5" />
                                        <asp:BoundField DataField="NextMaintenanceDate" HeaderText="Maintenance Date" 
                                            DataFormatString="{0:dd/MM/yyyy}" meta:resourcekey="BoundFieldResource6" />
                                        <asp:BoundField DataField="DateOfMaintenance" HeaderText="Date Of Maintenance" 
                                            DataFormatString="{0:dd/MM/yyyy}" meta:resourcekey="BoundFieldResource7" />
                                        <asp:BoundField DataField="CorrectiveAction" HeaderText="Corrective Action" 
                                            meta:resourcekey="BoundFieldResource8" />
                                        <asp:BoundField DataField="MaintenanceCost" HeaderText="Maintenance Cost" 
                                            meta:resourcekey="BoundFieldResource9" />
                                        <asp:BoundField DataField="MaintenanceType" HeaderText="Maintenance Type" 
                                            meta:resourcekey="BoundFieldResource10" />
                                        <asp:BoundField DataField="ProbDetails" HeaderText="Problem Details" 
                                            meta:resourcekey="BoundFieldResource11" />
                                        <asp:BoundField DataField="AmcProvider" HeaderText="Servicer Details" 
                                            meta:resourcekey="BoundFieldResource12" />
                                    </Columns>
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="dataheader1" />
                                </asp:GridView>
                            </div>
                            <asp:HiddenField ID="hdnProductID" runat="server" />
                            <asp:HiddenField ID="hdnPType" runat="server" />
                            <asp:HiddenField ID="hdnPCategory" runat="server" />
                            <asp:HiddenField ID="hdnActualDOM" runat="server" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    </form>
</body>
</html>


