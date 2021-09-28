<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StockInHandUpdate.aspx.cs"
    Inherits="StockManagement_StockInHandUpdate" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/PlatFormControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Reorder level</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
</head>
<body oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <%--        <ul>
            <li>
                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
            </li>
        </ul>--%>
        <table class="w-100p searchPanel">
            <tr>
                <td class="a-right">
                    <asp:Label ID="lblSelectCategory" runat="server" Text="Select Category :" meta:resourcekey="lblSelectCategoryResource1"></asp:Label>
                </td>
                <td>
                    &nbsp;
                    <asp:DropDownList ID="ddlCategory" runat="server" Width="133px" AutoPostBack="True"
                        OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" meta:resourcekey="ddlCategoryResource1">
                    </asp:DropDownList>
                    &nbsp;<img src="../Images/starbutton.png" alt="" class="a-center" />
                </td>
            </tr>
            <tr>
                <td class="a-center h-15" colspan="2">
                    <asp:Label ID="lblmsg" runat="server" meta:resourcekey="lblmsgResource1"></asp:Label>
                    <hr />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:GridView ID="grdResult" EmptyDataText="No matching records found " runat="server"
                        AutoGenerateColumns="False" CssClass="gridView w-100p" AllowPaging="True" OnRowDataBound="grdResult_RowDataBound"
                        meta:resourcekey="grdResultResource1">
                        <Columns>
                            <asp:BoundField HeaderStyle-Width="120px" ItemStyle-Width="270px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Left" HeaderText="Product" DataField="ProductName"
                                meta:resourcekey="BoundFieldResource1">
                                <HeaderStyle HorizontalAlign="Center" Width="120px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Width="270px"></ItemStyle>
                            </asp:BoundField>
                            <asp:TemplateField HeaderStyle-Width="70px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Left" HeaderText="BatchNo" meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <asp:TextBox Text='<%# Eval("BatchNo") %>' Width="70px" ID="txtBatchNo" onkeypress="return ValidateMultiLangChar(this);"
                                        runat="server"></asp:TextBox>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Width="70px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Width="70px"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Width="100px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Left" HeaderText="MFT Date" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:TextBox Text='<%# Eval("Manufacture","{0:dd/MM/yyyy}") %>' Width="70px" ReadOnly="true"
                                        onkeypress="return ValidateSpecialAndNumeric(this);" CssClass="datePicker" ID="txtManufacture" runat="server"></asp:TextBox>
                                    <%--<ajc:CalendarExtender ID="ceManufacture" runat="server" TargetControlID="txtManufacture"
                                        Format="dd/MM/yyyy" />--%>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Width="70px"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Width="100px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Left" HeaderText="EXP Date" meta:resourcekey="TemplateFieldResource3">
                                <ItemTemplate>
                                    <asp:TextBox Text='<%# Eval("ExpiryDate","{0:dd/MM/yyyy}") %>' Width="70px" ReadOnly="true"
                                        onkeypress="return ValidateSpecialAndNumeric(this);" CssClass="datePicker" ID="txtExpiryDate" runat="server"></asp:TextBox>
                                    <%--<ajc:CalendarExtender ID="ceExpiryDate" runat="server" TargetControlID="txtExpiryDate"
                                        Format="dd/MM/yyyy" />--%>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Width="70px"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Width="100px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Left" HeaderText="Quantity" meta:resourcekey="TemplateFieldResource4">
                                <ItemTemplate>
                                    <asp:TextBox Text='<%# Eval("RECQuantity") %>' onkeypress="return ValidateSpecialAndNumeric(this);"
                                        Width="70px" ID="txtQuantity" runat="server"></asp:TextBox>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Width="70px"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Width="100px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Left" HeaderText="Units" meta:resourcekey="TemplateFieldResource5">
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlUnit" runat="server" Width="70px" meta:resourcekey="ddlUnitResource1">
                                    </asp:DropDownList>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Width="70px"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Width="100px" ItemStyle-Width="60px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Left" HeaderText="Unit Price" meta:resourcekey="TemplateFieldResource6">
                                <ItemTemplate>
                                    <asp:TextBox Text='<%# Eval("UnitPrice") %>' Width="60px" onkeypress="return ValidateSpecialAndNumeric(this);"
                                        ID="txtUnitPrice" runat="server"></asp:TextBox>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Width="60px"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Width="100px" ItemStyle-Width="70px" HeaderStyle-HorizontalAlign="Center"
                                ItemStyle-HorizontalAlign="Left" HeaderText="Selling Price" meta:resourcekey="TemplateFieldResource7">
                                <ItemTemplate>
                                    <asp:TextBox Text='<%# Eval("Rate") %>' Width="70px" onkeypress="return ValidateSpecialAndNumeric(this);"
                                        ID="txtSellingPrice" runat="server"></asp:TextBox>
                                    <asp:HiddenField ID="hdnRid" Value='<%# Eval("ID") %>' runat="server" />
                                    <asp:HiddenField ID="hdnCategoryId" Value='<%# Eval("CategoryId") %>' runat="server" />
                                    <asp:HiddenField ID="hdnProductId" Value='<%# Eval("ProductId") %>' runat="server" />
                                    <asp:HiddenField ID="hdnprovidedby" Value='<%# Eval("providedby") %>' runat="server" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Width="100px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Left" Width="70px"></ItemStyle>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataFormatString="{0:M-dd-yyyy}" HeaderStyle-Width="100px" ItemStyle-Width="100"
                                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderText="Created At"
                                                DataField="CreatedAt" />--%>
                        </Columns>
                        <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                        <HeaderStyle CssClass="gridHeader" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td class="a-center h-15" colspan="2">
                    <hr />
                </td>
            </tr>
            <tr>
                <td class="a-center" colspan="2">
                    <asp:Button ID="btnUpdate" Text="Update" runat="server" CssClass="btn" OnClick="btnUpdate_Click"
                        meta:resourcekey="btnUpdateResource1" />
                    &nbsp;
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="cancel-btn" OnClick="btnCancel_Click"
                        meta:resourcekey="btnCancelResource1" />
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
