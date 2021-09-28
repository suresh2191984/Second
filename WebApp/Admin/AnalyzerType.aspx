<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AnalyzerType.aspx.cs" Inherits="Admin_AnalyzerType" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>AnalyzerType</title>
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <%--<link href="../StyleSheets/style.css" validateRequest="false" enableEventValidation="false"  rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />
    <%--
    <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>--%>

    <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <%--<link rel="stylesheet" type="text/css" href="../PlatForm/StyleSheets/dist/bootstrap-3.3.6-dist/css/bootstrap.css" />--%>
    <%--
//        function Validate() {
//            var ProductName = document.getElementById('txtproductname').value;

//            if (txtproductname.value !== '') {
//                alert("Please Enter the Product Name");
//                return false;
//            }

//        }--%>

    <script type="text/javascript">
        function Validate() {

            var ProductName = document.getElementById('txtproductname').value;

            if (ProductName == "") {
                alert('Enter the Mandatory Field');
                return false;
            }
            else {
                return true;
            }

        }   
    
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter" class="a-center">
                        </div>
                        <div id="processMessage" class="a-center w-20p">
                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                meta:resourcekey="img1Resource1" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <table class="w-60p searchPanel b-tab">
                    <tr>
                        <td>
                            <asp:Label ID="lblproductname" runat="server" Text="Product Name"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtproductname" class="small" runat="server" TabIndex="1"></asp:TextBox>
                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                        </td>
                        <td>
                            <asp:Label ID="lblproductdes" runat="server" Text="Product Description"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtproductdes" class="small" runat="server" TabIndex="2"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkActive1" runat="server" Text="IsActive" TextAlign="Left" TabIndex="3"
                                Checked="true" meta:resourcekey="chkActive1Resource1" />
                        </td>
                        <td>
                            <asp:Button ID="btnSaveproduct" runat="server" Text="Save" meta:Resourcekey="btnSaveResource1"
                                OnClick="btnSaveproduct_Click" OnClientClick="javascript:return Validate()" />
                        </td>
                    </tr>
                </table>
                <asp:UpdatePanel ID="updatePanel2" runat="server">
                    <ContentTemplate>
                        <table style="margin-left: 10%">
                            <tr>
                                <td>
                                    <asp:GridView ID="gvAnalyzerType" runat="server" AutoGenerateColumns="false" PageSize="10"
                                        AllowPaging="true" OnPageIndexChanging="gvAnalyzerType_PageIndexChanging" CssClass="gridView w-100p"
                                        HeaderStyle-CssClass="dataheader1" Width="100%">
                                        <Columns>
                                            <asp:BoundField DataField="Productid" HeaderText="Product ID" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField DataField="productname" HeaderText="Product Name" />
                                            <asp:BoundField DataField="productdescription" HeaderText="Product Description" />
                                            <asp:BoundField DataField="IsActive" HeaderText="IsActive" ItemStyle-HorizontalAlign="Center" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%-- <asp:Button ID="btnEdit" Text="Edit" runat="server"   />--%>
                                                    <asp:Button ID="btneditproduct" runat="server" Text="Edit" meta:Resourcekey="btnEditResource1"
                                                        OnClick="btneditproduct_Click" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <HeaderStyle CssClass="colorforcontent" ForeColor="White" />
                                        <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Black" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
