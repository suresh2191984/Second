<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OrgCreateUser.aspx.cs" Inherits="Admin_OrgCreateUser"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrderedSamples.ascx" TagName="OrderedSamples"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>
        <%--Investigation Result Template--%><%=Resources.Admin_AppMsg.Admin_OrgCreateUser_aspx_01%>
    </title>

    <script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function validationCheckBox() {
            var updateDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") : "Update";
            var DispAlrt = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert") != null ? SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert") : "Alert";
            var DispUsr = SListForAppMsg.Get("Admin_OrgCreateUser_aspx_Usr") != null ? SListForAppMsg.Get("Admin_OrgCreateUser_aspx_Usr") : "Provide User name";
            var DispUsr1 = SListForAppMsg.Get("Admin_OrgCreateUser_aspx_org") != null ? SListForAppMsg.Get("Admin_OrgCreateUser_aspx_org") : "Provide Org name";
            var DispUsr2 = SListForAppMsg.Get("Admin_OrgCreateUser_aspx_selatl") != null ? SListForAppMsg.Get("Admin_OrgCreateUser_aspx_selatl") : "Please select atleast ";
            var DispUsr3 = SListForAppMsg.Get("Admin_OrgCreateUser_aspx_role") != null ? SListForAppMsg.Get("Admin_OrgCreateUser_aspx_role") : "Role";
            //            if (document.getElementById('TabContainer1_tab1_chkUserType').value == '') {
            //                alert('Provide preferred Role name');
            //                document.getElementById('chkUserType').focus();
            //                return false;
            //            }Admin_OrgCreateUser_aspx_selatl

            if (document.getElementById('TabContainer1_tab1_ddlUsername').value == '0') {
                //alert('Provide User name');
                ValidationWindow(DispUsr, DispAlrt);

                document.getElementById('TabContainer1_tab1_ddlUsername').focus();
                return false;
            }
            if (document.getElementById('TabContainer1_tab1_ddlOrgname').value == '0') {
                //alert('Provide Org name');
                ValidationWindow(DispUsr1, DispAlrt);
                document.getElementById('TabContainer1_tab1_ddlOrgname').focus();
                return false;
            }

            var atLeast = 1

            var CHK = document.getElementById('TabContainer1_tab1_chkUserType');
            var checkbox = CHK.getElementsByTagName("input");
            var counter = 0;
            for (var i = 0; i < checkbox.length; i++) {
                if (checkbox[i].checked) {
                    counter++;
                }
            }
            if (atLeast > counter) {
                //alert("Please select atleast " + atLeast + " role");
                ValidationWindow(DispUsr2 + atLeast + DispUsr3, DispAlrt);
                return false;
            }

        }


        function validatePageNumber() {
            if (document.getElementById('TabContainer1_TabPanel1_txtpageNo').value == "") {
                return false;
            }
        }
    </script>

    <style type="text/css">
        .style1
        {
            width: 1%;
        }
        .delete
        {
            display:none;
        }
        .orgCreateGrid 
        {
            height:480px;
            overflow:auto;
        }
    </style>
</head>
<body>
    <form id="Form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                <asp:Panel ID="pnlenb" runat="server" BackColor="AliceBlue" meta:resourcekey="pnlenbResource1">
                                    <table width="100%">
                                        <tr>
                                            <td align="center">
                                <asp:Label ID="lblMsg" runat="server" ForeColor="Red" meta:resourcekey="lblMsgResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                    <ajc:TabContainer ID="TabContainer1" runat="server" AutoPostBack="True" ActiveTabIndex="0"
                        meta:resourcekey="TabContainer1Resource1">
                        <ajc:TabPanel ID="tab1" runat="server" ActiveTabIndex="0" meta:resourcekey="tab1Resource1">
                                            <HeaderTemplate>
                                <%--Manage user--%>
                                <%=Resources.Admin_AppMsg.Admin_OrgCreateUser_aspx_03%>
                                            </HeaderTemplate>
                                            <ContentTemplate>
                                                <table align="center">
                                                    <tr>
                                                        <td valign="top">
                                                            <table align="center">
                                                                <tr>
                                                                    <td>
                                                        <asp:Label ID="lblusername" runat="server" Text=" Select UserName:" meta:resourcekey="lblusernameResource1"></asp:Label>
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:DropDownList ID="ddlUsername" runat="server" Width="200px" AutoPostBack="True"
                                                            OnSelectedIndexChanged="ddlUsername_SelectedIndexChanged" meta:resourcekey="ddlUsernameResource1">
                                                                        </asp:DropDownList>
                                                                        <asp:Button ID="btnCreateNew" Style="display: none" runat="server" CssClass="btn"
                                                            Text="Create New Role" OnClick="btnCreateNew_Click" meta:resourcekey="btnCreateNewResource1" />
                                                                    </td>
                                                                    <tr>
                                                                      <td align="left">
                                                            <asp:Label ID="lblorganisation" runat="server" meta:resourcekey="lblorganisationResource1"></asp:Label>
                                                                        </td>
                                                                        <td align="left">
                                                                           
                                                                            <asp:DropDownList ID="ddlOrgname" runat="server" Width="200px" OnSelectedIndexChanged="ddlOrgname_SelectedIndexChanged"
                                                                                AutoPostBack="True">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                       
                                                                           <td>
                                                                            <asp:Panel ID="Panel4" runat="server" GroupingText="Type">
                                                                                <asp:RadioButton ID="rdbcro" runat="server" Text="CRO" OnCheckedChanged="rdbcro_CheckedChanged"
                                                                                    AutoPostBack="True" />
                                                                                <asp:RadioButton ID="rdbstudy" runat="server" Text="Study" AutoPostBack="True" OnCheckedChanged="rdbstudy_CheckedChanged" />
                                                                                <asp:RadioButton ID="rdball" runat="server" Text="All" Checked="True" OnCheckedChanged="rdball_CheckedChanged"
                                                                                    AutoPostBack="True" />
                                                                            </asp:Panel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trselectorg1" style="display: table-row">
                                                                        <td colspan="2">
                                                            <asp:Panel ID="Panel3" runat="server" GroupingText="Organization Role Name" meta:resourcekey="Panel3Resource1">
                                                                <asp:CheckBoxList ID="chkUserType" CssClass="b-grey bg-row padding5" runat="server"
                                                                    RepeatColumns="5" RepeatDirection="Horizontal">
                                                                                </asp:CheckBoxList>
                                                                            </asp:Panel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="center" colspan="2">
                                                                            <asp:Button ID="Save" runat="server" CssClass="btn" TabIndex="100" Text="Update"
                                                                OnClick="Save_Click" OnClientClick="return validationCheckBox();" meta:resourcekey="SaveResource1" />
                                                            &nbsp;<asp:Button ID="btnUpdate" runat="server" CssClass="btn delete" Text="Edit" meta:resourcekey="btnUpdateResource1"
                                                                OnClick="btnUpdate_Click" />
                                                            &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="btn" Text="Clear" OnClick="btnCancel_Click"   meta:resourcekey="btnCancelResource1" />
                                                                        </td>
                                                                    </tr>
                                                            </table>
                                                        </td>
                                                        <td valign="top">
                                                            <table align="center" style="display: block">
                                                                <tr>
                                                                    <td>
                                                                        <asp:CheckBoxList ID="ChkRoleUserType" runat="server" RepeatColumns="1" RepeatDirection="Horizontal"
                                                                            Visible="False">
                                                                        </asp:CheckBoxList>
                                                                    </td>
                                                                    <td>
                                                                    <div class="orgCreateGrid">
                                                                        <asp:GridView ID="gvAllUsers" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                            BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                                            CellPadding="3" Font-Names="Verdana" CssClass="gridView w-60p" Font-Size="9pt" GridLines="None">
                                                                            <RowStyle ForeColor="#000066" />
                                                                            <Columns>
                                                                                <asp:BoundField DataField="RoleID" HeaderText="RoleID" Visible="False" />
                                                                                <asp:BoundField DataField="RoleName" HeaderText="RoleName" />
                                                                                <asp:BoundField DataField="OrganisationName" HeaderText="OrganisationName" />
                                                                            </Columns>
                                                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                        </asp:GridView>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </ajc:TabPanel>
                                        <ajc:TabPanel ID="TabPanel1" runat="server" HeaderText="User for Organization" ActiveTabIndex="1">
                                            <HeaderTemplate>
                                                User Selection Detail
                                            </HeaderTemplate>
                                            <ContentTemplate>
                                                <table align="center">
                                                    <tr id="tr1" style="display: block">
                                                        <td align="center">
                                                            <asp:Panel ID="Panel2" runat="server" GroupingText="Type">
                                                                <asp:RadioButton ID="rdbuserCRO" runat="server" Text="CRO" OnCheckedChanged="rdbuserCRO_CheckedChanged"
                                                                    AutoPostBack="True" />
                                                                <asp:RadioButton ID="rdbuserStudy" runat="server" Text="Study" AutoPostBack="True"
                                                                    OnCheckedChanged="rdbuserStudy_CheckedChanged" />
                                                                <asp:RadioButton ID="rdbuserAll" runat="server" Text="All" Checked="True" OnCheckedChanged="rdbuserAll_CheckedChanged"
                                                                    AutoPostBack="True" />
                                                            </asp:Panel>
                                                        </td>
                                                        <td align="center">
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            <asp:Label ID="lbluserorgname" runat="server"></asp:Label>
                                                            <asp:DropDownList ID="ddluserorgname" runat="server" Width="200px" AutoPostBack="True"
                                                                OnSelectedIndexChanged="ddluserorgname_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr id="tr2" style="display: block">
                                                        <td colspan="2">
                                            <asp:Panel ID="Panel1" runat="server" GroupingText="Organization Role Name" meta:resourcekey="Panel1Resource1">
                                                                <%--<asp:CheckBoxList ID="chkuserorg" CssClass="bg-row b-grey padding5" runat="server" RepeatColumns="5" RepeatDirection="Horizontal"
                                                                    OnSelectedIndexChanged="chkuserorg_SelectedIndexChanged" AutoPostBack="true">
                                                                </asp:CheckBoxList>--%>
                                                                <asp:RadioButtonList runat="server" ID="chkuserorg" CssClass="bg-row b-grey padding5" RepeatColumns="5" RepeatDirection="Horizontal"
                                                                 OnSelectedIndexChanged="chkuserorg_SelectedIndexChanged" AutoPostBack="true">
                                                                </asp:RadioButtonList>
                                                                <asp:CheckBox ID="chkall" runat="server" Text="CheckAll" Style="display: none" />
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBoxList ID="chkuserroleorg" runat="server" RepeatColumns="1" RepeatDirection="Horizontal"
                                                                Visible="False">
                                                            </asp:CheckBoxList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:GridView ID="GridViewDetails" runat="server" AutoGenerateColumns="False" CellPadding="0"
                                                                ForeColor="#333333" GridLines="None" Width="100%" HeaderStyle-BorderWidth="0px"
                                                                OnRowDataBound="GridViewDetails_RowDataBound" OnPageIndexChanging="GridViewDetails_PageIndexChanging">
                                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <table cellpadding="0" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                                                                                cellspacing="0" border="1" width="100%">
                                                                                <tr>
                                                                                    <td>
                                                                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <table cellpadding="5" cellspacing="0" border="0" width="100%">
                                                                                                        <tr class="Duecolor">
                                                                                                            <td align="left" style="font-weight: bold;">
                                                                                                                <asp:Label Text="Role Name : " runat="server" ID="lblKitname"></asp:Label>
                                                                                                                <asp:Label ID="lblPhy" Text='<%# DataBinder.Eval(Container.DataItem,"RoleName") %>'
                                                                                                                    runat="server" meta:resourcekey="lblPhyResource1"></asp:Label>
                                                                                                            </td>
                                                                                                    </table>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <asp:GridView ID="grdChildResult" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                                                                        PageSize="100" ForeColor="Black" GridLines="Both" Width="100%">
                                                                                                        <HeaderStyle Font-Underline="True" />
                                                                                                        <RowStyle Font-Bold="False" />
                                                                                                        <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                                                                        <Columns>
                                                                                                            <asp:TemplateField HeaderText="UserName" meta:resourcekey="TemplateFieldResource1">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:Label ID="lblProducts" runat="server" Text='<%# Eval("Description") %>' Width="155px"></asp:Label>
                                                                                                                </ItemTemplate>
                                                                                                                <ItemStyle HorizontalAlign="left" Width="50%" />
                                                                                                                <HeaderStyle HorizontalAlign="center" />
                                                                                                            </asp:TemplateField>
                                                                                                            <asp:TemplateField HeaderText="Role" Visible="false">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:Label ID="lblproQty" runat="server" Text='<%# Eval("RoleName") %>' Width="100px"></asp:Label>
                                                                                                                </ItemTemplate>
                                                                                                                <FooterStyle CssClass="dataheader1"></FooterStyle>
                                                                                                            </asp:TemplateField>
                                                                                                            <asp:TemplateField HeaderText="Created By">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:Label ID="lblproQty" runat="server" Text='<%# Eval("LoginName") %>' Width="150px"></asp:Label>
                                                                                                                </ItemTemplate>
                                                                                                                <FooterStyle CssClass="dataheader1"></FooterStyle>
                                                                                                            </asp:TemplateField>
                                                                                                            <asp:TemplateField HeaderText="Created At">
                                                                                                                <ItemTemplate>
                                                                                                                    <asp:Label ID="lblproQty" runat="server" Text='<%# Eval("CreatedAt") %>' Width="155px"></asp:Label>
                                                                                                                </ItemTemplate>
                                                                                                                <FooterStyle CssClass="dataheader1"></FooterStyle>
                                                                                                            </asp:TemplateField>
                                                                                                        </Columns>
                                                                                                    </asp:GridView>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <HeaderStyle BorderWidth="0px"></HeaderStyle>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                    <tr id="GrdFooter" runat="server" style="display: none;" class="dataheaderInvCtrl">
                                                        <td align="center" class="defaultfontcolor">
                                                            <asp:Label ID="Label3" runat="server" Text="Page"></asp:Label>
                                                            <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                                            <asp:Label ID="Label4" runat="server" Text="Of"></asp:Label>
                                                            <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                                                            <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="btn" OnClick="btnPrevious_Click" />
                                                            <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn" OnClick="btnNext_Click" />
                                                            <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                            <asp:Label ID="Label5" runat="server" Text="Enter The Page To Go:"></asp:Label>
                                            <asp:TextBox ID="txtpageNo" runat="server" Width="30px" onkeydown="javascript:return validatenumber(event);"
                                                                AutoComplete="off"></asp:TextBox>
                                                            <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click"
                                                                OnClientClick="javascript:return validatePageNumber();" />
                                                            <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblResult" runat="server" Style="display: none" Font-Bold="true" ForeColor="Red"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </ajc:TabPanel>
                                    </ajc:TabContainer>
                                </asp:Panel>
                                <asp:HiddenField ID="hdnuser" runat="server" />
                                <asp:HiddenField ID="CtConfig" runat="server" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
       <Attune:Attunefooter ID="Attunefooter" runat="server" />            
        <input type="hidden" id="hdnRName" name="rName" runat="server" />
        <input type="hidden" id="HdnCtConfig" runat="server" />

    </form>
</body>
</html>
