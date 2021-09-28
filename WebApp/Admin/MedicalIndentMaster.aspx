<%@ Page Language="C#"   AutoEventWireup="true" CodeFile="MedicalIndentMaster.aspx.cs"
    Inherits="Admin_MedicalIndentMaster" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%-- <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css"/>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function pcheckitem() {
            if (document.getElementById('txtName').value == '') {

                var userMsg = SListForApplicationMessages.Get("Admin\\MedicalIndentMaster.aspx_1");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Provide the name');
                    return false;
                }

                
                document.getElementById('txtName').focus();
                return false;
            }
            //            if (document.getElementById('ddlRateName').value == '') {
            //                alert('Provide the RateName');
            //                document.getElementById('ddlRateName').focus();
            //            }
        }
        function pChekUserName() {
            var i;
            var userMsg = SListForApplicationMessages.Get("Admin\\MedicalIndentMaster.aspx_3");
            if (userMsg != null) {
                i=confirm(userMsg);
                //return false;
            }
            else {
                i = confirm('Are you sure you wish to delete this user?');  
            }

            //i = confirm('Are you sure you wish to delete this user?');
            if (i == true) {
                return;
            }
            else {
                return false;
            }

        }

        function pUpdateItem(MedicalIndentID, pName) {
            document.getElementById('<%= btnID.ClientID %>').value = MedicalIndentID;
            document.getElementById('<%= txtName.ClientID %>').value = pName;
            document.getElementById('<%= btnsave.ClientID %>').value = 'Update';
            document.getElementById('hdnbtnsave').value = document.getElementById('<%= btnsave.ClientID %>').value;
        }
        function fClear() {
            document.getElementById('<%= btnID.ClientID %>').value = 0;
            document.getElementById('<%= txtName.ClientID %>').value = "";
            document.getElementById('<%= btnsave.ClientID %>').value = 'Save';
            return false;
        }
        
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc7:DocHeader ID="docHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <ul>
                                    <li>
                                        <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                    </li>
                                </ul>
                                <table cssclass="dataheader2" width="100%">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Rs_EnterName" Text="Enter Name" runat="server" meta:resourcekey="Rs_EnterNameResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtName" runat="server"  meta:resourcekey="txtNameResource1" CssClass="Txtboxsmall"></asp:TextBox>
                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <asp:Button ID="btnsave" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                onmouseover="this.className='btn btnhov'" TabIndex="4" Text="Save" OnClientClick="javascript:return pcheckitem();"
                                                OnClick="btnsave_Click" meta:resourcekey="btnsaveResource1" />
                                            <asp:Button ID="btn" runat="server" Text="Clear" CssClass="btn" OnClientClick="return fClear()"/>
                                            <%--<input type="reset" id="btn" value="Clear" class="btn" onclick="fClear()" />--%>
                                            <asp:HiddenField ID="Hdnupdate" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                                <asp:GridView ID="gvMedicalIndent" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvMedicalIndent_RowDataBound"
                                    Width="100%" CssClass="mytable1" OnRowDeleting="gvMedicalIndent_RowDeleting"
                                    meta:resourcekey="gvMedicalIndentResource1">
                                    <Columns>
                                        <asp:BoundField DataField="ItemName" HeaderText="Item Name" meta:resourcekey="BoundFieldResource1" />
                                        <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource1">
                                            <ItemTemplate>
                                                <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass=btn style='background-color: Transparent;
                                                    color: Red; border-style: none; cursor: pointer'/>
                                                <%--<input id="btnEdit" runat="server" value="Edit" type="button" style='background-color: Transparent;
                                                    color: Red; border-style: none; cursor: pointer' />--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="dataheader1" />
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <br />
                        <input id="btnID" runat="server" value="0" type="hidden" />
                        <input id="hdnbtnsave" runat="server" type="hidden" />
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
