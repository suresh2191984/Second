<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OrderSurgeryPkgItems.ascx.cs"
    Inherits="CommonControls_OrderSurgeryPkgItems" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asd" %>

<script type="text/javascript">
function ShowAlertMsg(key) {
       var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false ;
            }
            else if(key=="CommonControls\\OrderSurgeryPkgItems.ascx.cs_1")
            {
            alert('Enter the From and To date');
            return false ;
            }
             else if(key=="CommonControls\\OrderSurgeryPkgItems.ascx.cs_2")
            {
            alert('Value must be greater than zero');
            return false ;
            }
          else if(key=="CommonControls\\OrderSurgeryPkgItems.ascx.cs_3")
            {
            alert('Enter The Quantity to be updated');
            return false ;
            }
             else if(key=="CommonControls\\OrderSurgeryPkgItems.ascx.cs_4")
            {
            alert('Value is greater than package quantity');
            return false ;
            }
             else if(key=="CommonControls\\OrderSurgeryPkgItems.ascx.cs_5")
            {
            alert('Enter The Quantity to be reduced');
            return false ;
            }
             else if(key=="CommonControls\\OrderSurgeryPkgItems.ascx.cs_6")
            {
            alert('Quantity provided Is greater than Used Quantity');
            return false ;
            }
             else if(key=="CommonControls\\OrderSurgeryPkgItems.ascx.cs_7")
            {
            alert('This package day is {0}. enter correct from and to date');
            return false ;
            }
           return true;
        }
    function showdiv() {

        if (document.getElementById('OSPI_trgvOrderedSurgeryPkg').style.display == "none") {
            document.getElementById('OSPI_trgvOrderedSurgeryPkg').style.display = "block";
        }
        else {
            document.getElementById('OSPI_trgvOrderedSurgeryPkg').style.display = "none";
        }

    }
</script>

<table border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <table>
                <tr>
                    <td class="colorforcontent" style="width: 15%;" height="23" align="left">
                        <img id="img1" src="../images/showbids.gif" alt="show" width="15" height="15" align="top"
                            runat="server" style="cursor: pointer" onclick="javascript:showdiv()" />
                        <span class="dataheader1txt" style="cursor: pointer" onclick="javascript:showdiv()">
                            &nbsp;<asp:Label ID="Rs_ordered" runat="server" Text="ordered surgeory packages"
                                meta:resourcekey="Rs_orderedResource1"></asp:Label></span>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id="trgvOrderedSurgeryPkg" style="display: none;" runat="server">
        <td>
            <asp:GridView ID="gvOrderedSurgeryPkg" runat="server" Width="100%" CellPadding="4"
                CssClass="mytable1" AutoGenerateColumns="False" DataKeyNames="PackageID,PackageDays,FromDate,ToDate"
                ForeColor="#333333" HorizontalAlign="Left" OnRowCommand="gvOrderedSurgeryPkg_RowCommand"
                OnRowDataBound="gvOrderedSurgeryPkg_RowDataBound" meta:resourcekey="gvOrderedSurgeryPkgResource1">
                <Columns>
                    <asp:TemplateField HeaderText="Package Name" meta:resourcekey="TemplateFieldResource1">
                        <ItemTemplate>
                            <asp:Label ID="lblPackageName" Text='<%# Eval("PackageName") %>' runat="server" Width="74px"><%--meta:resourcekey="lblPackageNameResource1"--%></asp:Label>
                            <asp:Label ID="lblPackageID" runat="server" Visible="False" Text='<%# Eval("PackageID") %>'
                                meta:resourcekey="lblPackageIDResource1"></asp:Label>
                            <asp:Label ID="lblAmount" Text='<%# Eval("Amount") %>' runat="server" Visible="False"><%--meta:resourcekey="lblAmountResource1"--%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Package Days" meta:resourcekey="TemplateFieldResource2">
                        <ItemTemplate>
                            <asp:Label ID="lblPkgDays" Text='<%# Eval("PackageDays") %>' runat="server"><%--meta:resourcekey="lblPkgDaysResource1"--%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="From Date" meta:resourcekey="TemplateFieldResource3">
                        <ItemTemplate>
                            <asp:TextBox runat="server" ID="txtFromDate" MaxLength="25" Width="120px" Text='<%# Eval("FromDate") %>'><%--meta:resourcekey="txtFromDateResource1"--%></asp:TextBox>
                            <asp:LinkButton ID="lbtnFromDate" runat="server"><%--meta:resourcekey="lbtnFromDateResource1"--%><img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a><img src="../Images/starbutton.png"  alt=""  align="middle" /></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="To date" meta:resourcekey="TemplateFieldResource4">
                        <ItemTemplate>
                            <asp:TextBox runat="server" ID="txtToDate" MaxLength="25" Width="120px" Text='<%# Eval("ToDate") %>'><%--meta:resourcekey="txtToDateResource1"--%></asp:TextBox>
                            <asp:LinkButton ID="lbtnToDate" runat="server"><%--meta:resourcekey="lbtnToDateResource1"--%><img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a><img src="../Images/starbutton.png"  alt=""  align="middle" /></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField Visible="false" meta:resourcekey="TemplateFieldResource5">
                        <ItemTemplate>
                            <asp:Label ID="lblPkgDays1" Text='<%# Eval("PackageDays") %>' runat="server" Width="74px"><%--meta:resourcekey="lblPkgDays1Resource1"--%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource6">
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                CommandName="OEdit" Text="Edit" CssClass="btn" /><%--meta:resourcekey="btnEditResource1"--%>
                            <asp:Button ID="btnUpdate" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                CommandName="OUpdate" Text="Update" CssClass="btn" /><%--meta:resourcekey="btnUpdateResource1" --%>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
            </asp:GridView>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
        </td>
    </tr>
    <tr id="trSPID" runat="server" style="display: none;">
        <td>
            <asp:GridView ID="gvSPID" runat="server" Width="100%" CellPadding="4" CssClass="mytable1"
                AutoGenerateColumns="False" DataKeyNames="DetailsID,PackageID,PkgQuantity,Feetype,FeeID,ItemName"
                ForeColor="#333333" HorizontalAlign="Left" OnRowCommand="gvSPID_RowCommand" OnRowDataBound="gvSPID_RowDataBound"
                meta:resourcekey="gvSPIDResource1">
                <Columns>
                    <asp:TemplateField HeaderText="Item Name" meta:resourcekey="TemplateFieldResource7">
                        <ItemTemplate>
                            <asp:Label ID="lblPackageName" Text='<%# Eval("ItemName") %>' runat="server" Width="74px"><%--meta:resourcekey="lblPackageNameResource2"--%></asp:Label>
                            <asp:Label ID="lblPackageID" runat="server" Visible="False" Text='<%# Eval("PackageID") %>'><%--meta:resourcekey="lblPackageIDResource2"--%></asp:Label>
                            <asp:Label ID="lblDetailID" runat="server" Visible="False" Text='<%# Eval("DetailsID") %>'><%--meta:resourcekey="lblDetailIDResource1"--%></asp:Label>
                            <asp:Label ID="lblFeeType" runat="server" Visible="False" Text='<%# Eval("Feetype") %>'><%--meta:resourcekey="lblFeeTypeResource1"--%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Package Qty" meta:resourcekey="TemplateFieldResource8">
                        <ItemTemplate>
                            <asp:TextBox runat="server" ID="txtPkgQuantity" MaxLength="25" Width="40px" Text='<%# Eval("PkgQuantity") %>'
                                Enabled="False"><%--meta:resourcekey="txtPkgQuantityResource1"--%></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Used Qty" meta:resourcekey="TemplateFieldResource9">
                        <ItemTemplate>
                            <asp:TextBox runat="server" ID="txtUsedQty" MaxLength="25" Width="40px" Enabled="False"><%--meta:resourcekey="txtUsedQtyResource1"--%></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Update Qty" meta:resourcekey="TemplateFieldResource10">
                        <ItemTemplate>
                            <asp:TextBox runat="server" ID="txtUpdateQty" MaxLength="25" Width="40px"    onkeypress="return ValidateOnlyNumeric(this);"  ><%--meta:resourcekey="txtUpdateQtyResource1"--%></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Date" meta:resourcekey="TemplateFieldResource11">
                        <ItemTemplate>
                            <asp:TextBox runat="server" ID="txtOrderedDate" MaxLength="25" Width="120px"><%-- meta:resourcekey="txtOrderedDateResource1"--%></asp:TextBox>
                            <asp:LinkButton ID="lbtnOrderedDate" runat="server" meta:resourcekey="lbtnOrderedDateResource1"><img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a><img src="../Images/starbutton.png"  alt=""  align="middle" /></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource12">
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                CommandName="OADD" Text="Add" CssClass="btn" /><%--meta:resourcekey="btnEditResource2"--%>
                            <asp:Button ID="btnReduce" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                CommandName="Change" Text="Reduce" CssClass="btn" /><%--meta:resourcekey="btnReduceResource1"--%>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
            </asp:GridView>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Panel ID="pnlPkgDetailR" runat="server" CssClass="modalPopup dataheaderPopup"
                Width="50%" Style="display: none" meta:resourcekey="pnlPkgDetailRResource1">
                <div style="overflow: auto;">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <asp:GridView ID="gvItemDetails" runat="server" Width="100%" CellPadding="4" CssClass="mytable1"
                                    AutoGenerateColumns="False" DataKeyNames="TrackerID,PackageDetailsID,UsedQuantity,Feetype,FeeID,ItemName,OrderedDate,PackageID"
                                    ForeColor="#333333" HorizontalAlign="Left" OnRowCommand="gvItemDetails_RowCommand"
                                    OnRowDataBound="gvItemDetails_RowDataBound" meta:resourcekey="gvItemDetailsResource1">
                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Item Name" meta:resourcekey="TemplateFieldResource13">
                                            <ItemTemplate>
                                                <asp:Label ID="lblItemNameR" runat="server" Text='<%# Eval("ItemName") %>' Width="74px"><%--meta:resourcekey="lblItemNameRResource1"--%></asp:Label>
                                                <asp:Label ID="lblDetailIDR" runat="server" Text='<%# Eval("DetailsID") %>' Visible="False"><%--meta:resourcekey="lblDetailIDRResource1" --%></asp:Label>
                                                <asp:Label ID="lblFeeTypeR" runat="server" Text='<%# Eval("Feetype") %>' Visible="False"><%--meta:resourcekey="lblFeeTypeRResource1"--%></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Used Qty" meta:resourcekey="TemplateFieldResource14">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtUsedQtyR" runat="server" Enabled="False" MaxLength="25" Text='<%# Eval("UsedQuantity") %>'
                                                    Width="40px"><%--meta:resourcekey="txtUsedQtyRResource1"--%></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Update Qty" meta:resourcekey="TemplateFieldResource15">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtUpdateQtyR" runat="server" MaxLength="25"    onkeypress="return ValidateOnlyNumeric(this);"  
                                                    Width="40px"><%--meta:resourcekey="txtUpdateQtyRResource1" --%></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date" meta:resourcekey="TemplateFieldResource16">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtOrderedDateR" runat="server" Enabled="False" MaxLength="25" Text='<%# Eval("OrderedDate") %>'
                                                    Width="120px"><%--meta:resourcekey="txtOrderedDateRResource1" --%></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource17">
                                            <ItemTemplate>
                                                <asp:Button ID="btnReduce" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                    CommandName="OReduce" CssClass="btn" Text="Reduce" /><%--meta:resourcekey="btnReduceResource2" --%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Button ID="BtnClosePkgItemDetail" runat="server" Text="Close" CssClass="btn"
                                    meta:resourcekey="BtnClosePkgItemDetailResource1" />
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
            <asd:ModalPopupExtender ID="ModelPopUpPkgDetail" runat="server" TargetControlID="btnR"
                PopupControlID="pnlPkgDetailR" BackgroundCssClass="modalBackground" OkControlID="BtnClosePkgItemDetail"
                DynamicServicePath="" Enabled="True" />
            <input type="button" id="btnR" runat="server" style="display: none;" />
        </td>
    </tr>
</table>
