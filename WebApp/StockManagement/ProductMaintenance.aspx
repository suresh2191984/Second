<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductMaintenance.aspx.cs"
    Inherits="StockManagement_ProductMaintenance" Culture="auto" meta:resourcekey="PageResource1"
    UICulture="auto" %>

<%@ Register Src="~/PlatFormControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/PlatFormControls/Department.ascx" TagName="Department" TagPrefix="uc2" %>
<%@ Register Src="~/InventoryCommon/Controls/ProductSearch.ascx" TagName="ProductSearch"
    TagPrefix="uc11" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Product Maintenance</title>
</head>
<body>
    <form id="RecHome" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <%--<ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>--%>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table class="w-100p">
                    <tr>
                        <td class="a-center">
                            <div>
                                <table class="w-100p searchPanel">
                                    <%--<tr class="tablerow" id="ACX2responsesOPPmt" runat="server" style="display: block;">
                                                        <td id="Td1" runat="server">
                                                            <uc11:ProductSearch ID="ProductSearch1" runat="server" />
                                                        </td>
                                                    </tr>--%>
                                    <caption>
                                        &nbsp;
                                        <tr>
                                            <td>
                                            </td>
                                            <td class="a-right">
                                                <asp:Label ID="Rs_Category" runat="server" Text="Select Category :" meta:resourcekey="Rs_CategoryResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="ddl" Width="140px" meta:resourcekey="ddlCategoryResource1">
                                                </asp:DropDownList>
                                            </td>
                                            <td class="a-right">
                                                <asp:Label ID="Rs_Search" runat="server" Text="Product Name" meta:resourcekey="Rs_SearchResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txtSearch" runat="server" CssClass="small" onkeypress="return ValidateMultiLangChar(this);"
                                                    meta:resourcekey="txtSearchResource1"></asp:TextBox>
                                                &nbsp;
                                                <asp:Button ID="Button1" runat="server" CssClass="btn" OnClick="Button1_Click" Text="Search"
                                                    ToolTip="Search" meta:resourcekey="Button1Resource1" />
                                            </td>
                                            <td class="a-left">
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </caption>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center">
                            <asp:GridView ID="gvProduct" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                EmptyDataText="No Matching Record Found" CssClass="gridView w-100p" DataKeyNames="ProductID"
                                OnPageIndexChanging="gvProduct_PageIndexChanging" OnRowCommand="gvProduct_RowCommand"
                                meta:resourcekey="gvProductResource1">
                                <Columns>
                                    <asp:BoundField DataField="ProductName" HeaderText="Product" meta:resourcekey="BoundFieldResource1" />
                                    <asp:BoundField DataField="Model" HeaderText="Product Model " meta:resourcekey="BoundFieldResource2" />
                                    <asp:BoundField DataField="Description" HeaderText="Description" meta:resourcekey="BoundFieldResource3" />
                                    <asp:BoundField DataField="HasBatchNo" HeaderText="SerialNumber" meta:resourcekey="BoundFieldResource4" />
                                    <%--   <asp:BoundField DataField="PLocation" HeaderText="Product Location" />--%>
                                    <%--<asp:BoundField DataField="NextMaintenanceDate" HeaderText="MaintenanceDate" DataFormatString="{0:dd/MM/yyyy}"
                                        meta:resourcekey="BoundFieldResource5" />--%>
                                    <asp:TemplateField HeaderText="MaintenanceDate" meta:resourcekey="BoundFieldResource5">
                                        <ItemTemplate>
                                            <span>
                                                <%#((DateTime)DataBinder.Eval(Container.DataItem, "NextMaintenanceDate")).ToString(DateTimeFormat)%></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Frequency" HeaderText="Maintenance Interval" meta:resourcekey="BoundFieldResource6" />
                                    <asp:BoundField DataField="AmcProvider" HeaderText="AMC Vendor Details" meta:resourcekey="BoundFieldResource7" />
                                    <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSourceID" Text='<%# Eval("StockReceivedDetailsId") %>' runat="server"
                                                Visible="False"></asp:Label>
                                            <asp:Label ID="lblPSerialNo" Text='<%# Eval("HasBatchNo") %>' runat="server" Visible="False"></asp:Label>
                                            <asp:Label ID="lblCategoryId" Text='<%# Eval("CategoryID") %>' runat="server" Visible="False"></asp:Label>
                                            <asp:Label ID="lbProductID" Text='<%# Eval("ProductID") %>' runat="server" Visible="False"></asp:Label>
                                            <asp:LinkButton ID="btnEdit" runat="server" CommandArgument="<%# Container.DataItemIndex %>"
                                                CommandName="productMaintenanceDetails" Font-Bold="True" Font-Size="12px" Font-Underline="True"
                                                ForeColor="Blue" Text="Complete" meta:resourcekey="btnEditResource1" />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" Width="10%" />
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                                <HeaderStyle CssClass="gridHeader" />
                            </asp:GridView>
                            <asp:HiddenField ID="hdnProductID" runat="server" />
                            <asp:HiddenField ID="hdnPType" runat="server" />
                            <asp:HiddenField ID="hdnPCategory" runat="server" />
                            <asp:HiddenField ID="hdnActualDOM" runat="server" />
                            <asp:HiddenField ID="hdnReminderTemplateID" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center">
                            <br />
                            <asp:Panel ID="pnlLocation" runat="server" CssClass="w-800 h-300 hide modalPopup dataheaderPopup">
                                <br />
                                <table class="a-center">
                                    <tr>
                                        <td class="a-center">
                                            <asp:GridView ID="gvPopUpProduct" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                EmptyDataText="No Matching Record Found" CssClass="gridView w-100p" DataKeyNames="ProductID"
                                                meta:resourcekey="gvPopUpProductResource1">
                                                <Columns>
                                                    <asp:BoundField DataField="ProductName" HeaderText="Product Name" meta:resourcekey="BoundFieldResource8" />
                                                    <asp:BoundField DataField="Model" HeaderText="Product Model " meta:resourcekey="BoundFieldResource9" />
                                                    <asp:BoundField DataField="Description" HeaderText="Description" meta:resourcekey="BoundFieldResource10" />
                                                    <asp:BoundField DataField="HasBatchNo" HeaderText="Serial Number" meta:resourcekey="BoundFieldResource11" />
                                                    <%--   <asp:BoundField DataField="PLocation" HeaderText="Product Location" />--%>
                                                    <asp:BoundField DataField="Frequency" HeaderText="Maintenance Interval" meta:resourcekey="BoundFieldResource12" />
                                                    <asp:BoundField DataField="AmcProvider" HeaderText="AMC Vendor Details" meta:resourcekey="BoundFieldResource13" />
                                                    <asp:BoundField DataField="NextMaintenanceDate" HeaderText="Maintenance Date" DataFormatString="{0:dd/MM/yyyy}"
                                                        meta:resourcekey="BoundFieldResource14" />
                                                </Columns>
                                                <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                                                <HeaderStyle CssClass="gridHeader" />
                                            </asp:GridView>
                                        </td>
                                        <td class="h-20">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <table class="a-center">
                                                <tr>
                                                    <td class="a-left">
                                                        <asp:Label ID="Rs_ProblemIdentify" Text="Problem Identified" runat="server" meta:resourcekey="Rs_ProblemIdentifyResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtProblemIdentify" Width="133px" runat="server" onkeypress="return ValidateMultiLangChar(this);"
                                                            CssClass="txtboxps" meta:resourcekey="txtProblemIdentifyResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="style2 a-left">
                                                        <asp:Label ID="Rs_CorrectiveActions" Text="Corrective Actions" runat="server" meta:resourcekey="Rs_CorrectiveActionsResource1"></asp:Label>
                                                    </td>
                                                    <td class="style1">
                                                        <asp:TextBox ID="txtCorrectiveActions" Width="133px" runat="server" onkeypress="return ValidateMultiLangChar(this);"
                                                            CssClass="txtboxps" meta:resourcekey="txtCorrectiveActionsResource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-left">
                                                        <asp:Label ID="Rs_ServiceCost" Text="Service Cost" runat="server" meta:resourcekey="Rs_ServiceCostResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtServiceCost" runat="server" CssClass="txtboxps w-133" MaxLength="20"
                                                            onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtServiceCostResource1"></asp:TextBox>
                                                    </td>
                                                    <td align="left" class="style2">
                                                        <asp:Label ID="Label4" Text="Service Type" runat="server" meta:resourcekey="Label4Resource1"></asp:Label>
                                                    </td>
                                                    <td class="style1" align="left">
                                                        <asp:DropDownList ID="ddlMaintenanceType" Width="133px" runat="server" meta:resourcekey="ddlMaintenanceTypeResource1">
                                                            <%--<asp:ListItem Text="---Select---" Value="0" Selected="True" 
                                                                                meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                            <asp:ListItem Text="Normal" Value="Normal" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                            <asp:ListItem Text="Repair" Value="Repair" meta:resourcekey="ListItemResource3"></asp:ListItem>--%>
                                                        </asp:DropDownList>
                                                        &nbsp;<img src="../Images/starbutton.png" alt="" class="a-center" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <asp:Button ID="btnContentSave" runat="server" Text="Save" CssClass="btn w-70" OnClick="btnSaveItems_Click"
                                                meta:resourcekey="btnContentSaveResource1" />
                                            &nbsp;&nbsp;
                                            <asp:Button ID="Button3" runat="server" Text="Cancel" CssClass="cancel-btn w-70"
                                                meta:resourcekey="Button3Resource1" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                            </asp:Panel>
                            <input type="button" id="btnDummy" runat="server" class="hide" />
                            <ajc:ModalPopupExtender ID="MPEShowPackageContent" runat="server" TargetControlID="btnDummy"
                                PopupControlID="pnlLocation" CancelControlID="btnCancel" DropShadow="false" Drag="false"
                                BackgroundCssClass="modalBackground" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="cancel-btn" OnClick="btnCancel_Click"
                                meta:resourcekey="btnCancelResource1" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script type="text/javascript" language="javascript">
        var errorMsg = SListForAppMsg.Get("StockManagement_Error") != null ? SListForAppMsg.Get("StockManagement_Error") : "Alert";
        var InformationMsg = SListForAppMsg.Get("StockManagement_Information") != null ? SListForAppMsg.Get("StockManagement_Information") : "Information";
        var okMsg = SListForAppMsg.Get("StockManagement_Ok") != null ? SListForAppMsg.Get("StockManagement_Ok") : "Ok";
        var CancelMsg = SListForAppMsg.Get("StockManagement_Cancel") != null ? SListForAppMsg.Get("StockManagement_Cancel") : "Cancel";
    </script>

    <script language="javascript" type="text/javascript">
        var userMsg;
        function checkDetails() {
            if (document.getElementById('ddlMaintenanceType').value == "0") {
                var userMsg = SListForAppMsg.Get("StockManagement_ProductMaintenance_aspx_01") == null ? "Select the Service Type" : SListForAppMsg.Get("StockManagement_ProductMaintenance_aspx_01");
                if (userMsg != null && errorMsg != null)
                    ValidationWindow(userMsg, errorMsg);
                document.getElementById('ddlMaintenanceType').focus();
                return false;
            }
        }
      

    </script>

</body>
</html>
