<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EquipmentMaintenanceMaster.aspx.cs"
    Inherits="InventoryMaster_EquipmentMaintenanceMaster" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<%@ Register Src="~/PlatFormControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/PlatFormControls/Department.ascx" TagName="Department" TagPrefix="uc2" %>
<%@ Register Src="~/InventoryCommon/Controls/ProductSearch.ascx" TagName="ProductSearch"
    TagPrefix="uc11" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script language="javascript" type="text/javascript">
        var userMsg;
        function checkDetails() {

        }
        function PopUpcheckDetails() {
            if (document.getElementById('txtFrom').value == "") {
                userMsg = SListForAppDisplay.Get("InventoryMaster_EquipmentMaintenanceMaster_aspx_01") == null ? "Select Maintenance Start Date" : SListForAppDisplay.Get("InventoryMaster_EquipmentMaintenanceMaster_aspx_01");
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtFrom').focus();
                    return false;
                } 
            }
            if (document.getElementById('txtTo').value == "") {
                userMsg = SListForAppDisplay.Get("InventoryMaster_EquipmentMaintenanceMaster_aspx_02") == null ? "Select Maintenance End Date" : SListForAppDisplay.Get("InventoryMaster_EquipmentMaintenanceMaster_aspx_02");
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtTo').focus();
                    return false;
                }
            }
            if (document.getElementById('ddlMaintenanceFrequency').value == "0") {
                userMsg = SListForAppDisplay.Get("InventoryMaster_EquipmentMaintenanceMaster_aspx_03") == null ? "Select the Maintenance Frequency" : SListForAppDisplay.Get("InventoryMaster_EquipmentMaintenanceMaster_aspx_03");
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('ddlMaintenanceFrequency').focus();
                    return false;
                }
            }

        }
          

    </script>

</head>
<body>
    <form id="RecHome" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <attune:attuneheader ID="Attuneheader" runat="server" />
        <script type="text/javascript" language="javascript">
            var errorMsg = SListForAppMsg.Get("InventoryMaster_Error") != null ? SListForAppMsg.Get("InventoryMaster_Error") : "Alert";
            var InformationMsg = SListForAppMsg.Get("InventoryMaster_Information") != null ? SListForAppMsg.Get("InventoryMaster_Information") : "Information";
            var okMsg = SListForAppMsg.Get("InventoryMaster_Ok") != null ? SListForAppMsg.Get("InventoryMaster_Ok") : "Ok";
            var CancelMsg = SListForAppMsg.Get("InventoryMaster_Cancel") != null ? SListForAppMsg.Get("InventoryMaster_Cancel") : "Cancel";
   </script>

    <div class="contentdata">
<%--        <ul>
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
                                <table class="w-100p">
                                    <caption>
                                        &nbsp;
                                        <tr class="a-center">
                                            <td class="a-center">
                                                <div class="dataheaderWider w-100p">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="a-left">
                                                             <asp:Label ID="lblProductcategory" runat="server" Text="Product Category" meta:resourcekey="lblProductcategoryResource1" 
                                                                   ></asp:Label>
                                                                
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:DropDownList ID="ddlCategory" CssClass="ddl" runat="server" Width="130px" 
                                                                    TabIndex="3" meta:resourcekey="ddlCategoryResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:Label ID="Rs_Search" runat="server" Text="Product Name" 
                                                                    meta:resourcekey="Rs_SearchResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtSearch" CssClass="small" runat="server" 
                                                                    meta:resourcekey="txtSearchResource1"></asp:TextBox>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="Rs_BatchNo" runat="server" Text="Batch No:" 
                                                                    meta:resourcekey="Rs_BatchNoResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtBatchNo" CssClass="small" runat="server" 
                                                                    meta:resourcekey="txtBatchNoResource1"></asp:TextBox>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:Label ID="Rs_Model" runat="server" Text="Product Model" 
                                                                    meta:resourcekey="Rs_ModelResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtModel" CssClass="small" runat="server" 
                                                                    meta:resourcekey="txtModelResource1"></asp:TextBox>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left">
                                                            <asp:Label ID="lblSearchType" runat="server" Text="Search Type" meta:resourcekey="lblSearchTypeResource1" 
                                                                  ></asp:Label>
                                                                
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:RadioButtonList ID="rdotypes" runat="server" RepeatDirection="Horizontal" 
                                                                    meta:resourcekey="rdotypesResource1">
                                                                    <asp:ListItem Text="New Schudule" Value="0" Selected="True" 
                                                                        meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                    <asp:ListItem Text="Edit Schedule" Value="1" 
                                                                        meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                    <%--  <asp:ListItem Text="Both" Value="2"></asp:ListItem>--%>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                            <td class="a-left" colspan="2">
                                                                <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                                                    OnClientClick="javascript:return checkDetails();" 
                                                                    OnClick="btnSearch_Click" TabIndex="4" meta:resourcekey="btnSearchResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class ="a-center">
                                                <asp:GridView ID="gvProduct" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                    EmptyDataText="No Matching Record Found" CssClass="gridView w-100p" DataKeyNames="ProductID"
                                                    OnPageIndexChanging="gvProduct_PageIndexChanging" OnRowCommand="gvProduct_RowCommand"
                                                    OnRowDataBound="gvProduct_RowDataBound" 
                                                    meta:resourcekey="gvProductResource1">
                                                    <Columns>
                                                        <asp:BoundField DataField="ProductName" HeaderText="Product Name" 
                                                            meta:resourcekey="BoundFieldResource1" />
                                                        <asp:BoundField DataField="Model" HeaderText="Product Model " 
                                                            meta:resourcekey="BoundFieldResource2" />
                                                        <asp:BoundField DataField="Description" HeaderText="Description" 
                                                            meta:resourcekey="BoundFieldResource3" />
                                                        <asp:BoundField DataField="HasBatchNo" HeaderText="SerialNumber/BatchNo" 
                                                            meta:resourcekey="BoundFieldResource4" />
                                                        <asp:BoundField DataField="isLabAnalyzer" HeaderText="Nos-Unit" 
                                                            meta:resourcekey="BoundFieldResource5" />
                                                        <%--<asp:BoundField DataField="PLocation" HeaderText="Product Location" />--%>
                                                        <%-- <asp:BoundField DataField="NextMaintenanceDate" HeaderText="MaintenanceDate" DataFormatString="{0:dd/MM/yyyy}" />--%>
                                                        <%-- <asp:BoundField DataField="Specification1" HeaderText="Maintenance Interval" />--%>
                                                        <%-- <asp:BoundField DataField="ServicerDetails" HeaderText="Servicer Details" />--%>
                                                        <asp:TemplateField HeaderText="Action" 
                                                            meta:resourcekey="TemplateFieldResource1">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblSourceID" Text='<%# Eval("StockReceivedDetailsId") %>' runat="server"
                                                                    Visible="False"></asp:Label>
                                                                <asp:Label ID="lblPSerialNo" Text='<%# Eval("HasBatchNo") %>' runat="server" 
                                                                    Visible="False"></asp:Label>
                                                                <asp:Label ID="lblCategoryId" Text='<%# Eval("CategoryID") %>' runat="server" 
                                                                    Visible="False"></asp:Label>
                                                                <asp:Label ID="lbProductID" Text='<%# Eval("ProductID") %>' runat="server" 
                                                                    Visible="False"></asp:Label>
                                                                <asp:LinkButton ID="btnEdit" runat="server" CommandArgument="<%# Container.DataItemIndex %>"
                                                                    CommandName="productMaintenanceProcess" Font-Bold="True" Font-Size="12px" Font-Underline="True"
                                                                    ForeColor="Blue" Text="Create" meta:resourcekey="btnEditResource1" />
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Left" />
                                                            <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                                                    <HeaderStyle CssClass="gridHeader" />
                                                </asp:GridView>
                                                <asp:HiddenField ID="hdnProductID" runat="server" />
                                                <asp:HiddenField ID="hdnPSerialNo" runat="server" />
                                                <asp:HiddenField ID="hdnStockReceivedDetailsId" runat="server" />
                                                <asp:HiddenField ID="hdnSearchType" runat="server" />
                                                <asp:HiddenField ID="hdnReminderTemplateID" runat="server" />
                                            </td>
                                        </tr>
                                    </caption>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class ="a-center">
                            <br />
                            <asp:Panel ID="pnlLocation" runat="server" CssClass="modalPopup dataheaderPopup w-800 h-300 hide"
                                meta:resourcekey="pnlLocationResource1">
                                <br />
                                <table class ="a-center">
                                    <tr>
                                        <td class ="a-center">
                                            <asp:GridView ID="gvPopUpProduct" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                EmptyDataText="No Matching Record Found" CssClass="gridView w-100p" DataKeyNames="ProductID"
                                                meta:resourcekey="gvPopUpProductResource1">
                                                <Columns>
                                                    <asp:BoundField DataField="ProductName" HeaderText="Product Name" 
                                                        meta:resourcekey="BoundFieldResource6" />
                                                    <asp:BoundField DataField="Model" HeaderText="Product Model " 
                                                        meta:resourcekey="BoundFieldResource7" />
                                                    <asp:BoundField DataField="Description" HeaderText="Description" 
                                                        meta:resourcekey="BoundFieldResource8" />
                                                    <asp:BoundField DataField="HasBatchNo" HeaderText="SerialNumber/BatchNo" 
                                                        meta:resourcekey="BoundFieldResource9" />
                                                </Columns>
                                                <HeaderStyle CssClass="gridHeader" />
                                                <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class ="a-center">
                                            <table class ="a-center" border="1">
                                                <tr>
                                                    <td class="a-left">
                                                     <asp:Label ID="lblMaintaenanceStartdate" Text="Maintenance Start Date" 
                                                            runat="server" meta:resourcekey="lblMaintaenanceStartdateResource1"></asp:Label>
                                                        
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtFrom" runat="server" CssClass="datePicker" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                                       
&nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                    </td>
                                                    <td class="a-left">
                                                     <asp:Label ID="lblMaintaenanceEnddate" Text="Maintenance End Date" 
                                                            runat="server" meta:resourcekey="lblMaintaenanceEnddateResource1" ></asp:Label>
                                                        
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtTo" runat="server" meta:resourcekey="txtToResource1"></asp:TextBox>
                                                        <%--<asp:ImageButton ID="ImgTDate" runat="server" CausesValidation="False" 
                                                            ImageUrl="~/images/Calendar_scheduleHS.png" 
                                                            meta:resourcekey="ImgTDateResource1" />--%>
&nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-left style2">
                                                        <asp:Label ID="RS_MaintenanceFrequency" Text="Maintenance Frequency" 
                                                            runat="server" meta:resourcekey="RS_MaintenanceFrequencyResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlMaintenanceFrequency" runat="server" Width="133px" runat="server">
                                                          
                                                        </asp:DropDownList>
                                                        &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:Label ID="Rs_MaintenanceNotes" Text="Reminder Notes" runat="server" 
                                                            meta:resourcekey="Rs_MaintenanceNotesResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtMaintenanceNotes" Width="133px" runat="server" CssClass="txtboxps"
                                                            TextMode="MultiLine" meta:resourcekey="txtMaintenanceNotesResource1"></asp:TextBox>
                                                        &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-left style2">
                                                        <asp:Label ID="RS_AMCProvider" Text="AMC Vendor Details" runat="server" 
                                                            meta:resourcekey="RS_AMCProviderResource1"></asp:Label>
                                                    </td>
                                                    <td class="style1">
                                                        <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtAmcProvider" Width="133px" runat="server" TextMode="MultiLine"
                                                            CssClass="txtboxps" meta:resourcekey="txtAmcProviderResource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class ="a-center">
                                            <asp:Button ID="btnContentSave" runat="server" Text="Save" CssClass="btn" Width="70px" 
                                                OnClick="btnSaveItems_Click" 
                                                OnClientClick="javascript:return PopUpcheckDetails();" 
                                                meta:resourcekey="btnContentSaveResource1" />
                                            &nbsp;&nbsp;
                                            <asp:Button ID="Button3" runat="server" Text="Cancel" CssClass="cancel-btn" Width="70px" 
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
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="cancel-btn hide" OnClick="btnCancel_Click" 
                                meta:resourcekey="btnCancelResource1" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <attune:attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
