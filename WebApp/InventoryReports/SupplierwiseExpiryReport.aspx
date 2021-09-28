<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SupplierwiseExpiryReport.aspx.cs" Inherits="InventoryReports_SupplierwiseExpiryReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Supplierwise Expiry Report</title>
    <script type="text/javascript">
      function popupprint() {
            var prtContent = document.getElementById('tblgrdDynamic');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write($('head').html() + prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" AsyncPostBackTimeout="10" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table id="casip" class="w-100p marginT15">
            <tr id="trTrustedOrg" runat="server">
                <td class="w-30p">
                    <asp:Label ID="lblOrgs" runat="server" CssClass="marginR20" Text="Select an Organization" 
                        meta:resourcekey="lblOrgsResource1"></asp:Label>
                    <asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" AutoPostBack="True"
                        runat="server" CssClass="medium ddlTheme" 
                        OnSelectedIndexChanged="ddlTrustedOrg_SelectedIndexChanged" 
                        meta:resourcekey="ddlTrustedOrgResource1">
                    </asp:DropDownList>
                </td>
                <td class="a-left">
                    <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                </td>
                <td>
                    <asp:TextBox OnKeyPress="return ValidateSpecialAndNumeric(event);" ID="txtFDate" CssClass="small datePickerPres" runat="server" 
                        meta:resourcekey="txtFDateResource1"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                </td>
                <td>
                    <asp:TextBox OnKeyPress="return ValidateSpecialAndNumeric(event);" ID="txtTDate" CssClass="small datePickerPres" runat="server" 
                        meta:resourcekey="txtTDateResource1"></asp:TextBox>
                </td>
                <td class="a-right">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn" Text="Get Report" OnClick="btnSubmit_Click"
                        meta:resourcekey="btnSubmitResource1" />
                </td>
                <td class="a-right">
                    <asp:LinkButton ID="lnkBack" Text="Back" runat="server" CssClass="cancel-btn" OnClick="lnkBack_Click"
                        meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                </td>
                <td class="a-center">
                    <asp:ImageButton ID="imgBtnXL" OnClientClick="return validate();" runat="server"
                        ImageUrl="../PlatForm/Images/ExcelImage.GIF" ToolTip="Save As Excel" OnClick="imgBtnXL_Click"
                        meta:resourcekey="imgBtnXLResource1" />
                    <asp:LinkButton ID="lnkExportXL" Text="Export To XL" CssClass="hide" Font-Underline="True" OnClientClick="return validate();"
                        runat="server" ToolTip="Save As Excel" OnClick="lnkExportXL_Click" meta:resourcekey="lnkExportXLResource1"></asp:LinkButton>
                    <input type="hidden" runat="server" value="0" id="hdnXLFlag" />
                </td>
                <td>
                    <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/PlatForm/Images/printer.gif" OnClientClick="return popupprint();"
                        ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                    <b id="printText" runat="server">
                        <asp:LinkButton ID="lnkPrint" Text="Print Report" CssClass="hide" OnClientClick="return popupprint();"
                            runat="server" meta:resourcekey="lnkExportXLResource2"></asp:LinkButton></b>
                </td>
            </tr>
        </table>
        <table class="w-100p  marginT15" id="tblgrdDynamic" runat="server">
            <tr class="">
             <td>
            <asp:GridView ID="grdsupplier" CssClass="w-100p responstable" runat="server" AutoGenerateColumns="false"  EmptyDataText="No Records Found">
              <PagerStyle CssClass="gridPager a-center" />
               <HeaderStyle CssClass="responstableHeader" />
               <Columns>
               <asp:BoundField HeaderText ="S.No" DataField="Sno" />
               <asp:BoundField HeaderText="Supplier Name"  DataField="SupplierName" />
               <asp:BoundField HeaderText="Manufacturer Name" DataField="ManufacturerName" />
               <asp:BoundField HeaderText="Drug Name" DataField="DrugName" />
               <asp:BoundField HeaderText="Quantity" DataField="Quantity" />
               <asp:BoundField HeaderText="BatchNo" DataField="BatchNo" />
               <asp:BoundField HeaderText="ExpiryDate" DataField="ExpiryDate" DataFormatString="{0:MMM-yyyy}" />
               <asp:BoundField HeaderText="GRNNo" DataField="GRNNo" />
               </Columns>
            </asp:GridView>
            </td> 
                <%--<td>
                    <asp:Label ID="Label1" Text="S.No" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                </td>   
                <td>
                    <asp:Label ID="Label2" Text="Supplier Name" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                </td>                
                               <td>
                    <asp:Label ID="Label4" Text="Drug Name" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                </td>  
                <td>
                    <asp:Label ID="Label5" Text="Quantity" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                </td>     
                <td>
                    <asp:Label ID="Label6" Text="Batch No" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                </td>   
                <td>
                    <asp:Label ID="Label7" Text="Expiry Date" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                </td>   
                <td>
                    <asp:Label ID="Label8" Text="GRN No" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                </td>         
            </tr>
            <tr>
                <td>1</td>
                <td>ECO CARE SOLUTIONS</td>
                <td>STRIPS</td>
                <td>967</td>
                <td>652</td>
                <td>01/07/2017 00:00:00</td>
                <td>SRD1147</td>--%>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
