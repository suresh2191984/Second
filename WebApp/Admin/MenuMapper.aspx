<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MenuMapper.aspx.cs" Inherits="Admin_MenuMapper"
    meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/MenuItemList.ascx" TagName="MenuItemList" TagPrefix="mil" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Menu Map Master</title>
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/actb.js" type="text/javascript"></script>

   <script src="../Scripts/actbcommon.js" type="text/javascript"></script>

</head>
<body>
<style>
#divFilter #pnlFilter fieldset legend{ display:none;}
</style>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <table class="searchPanel w-100p">
                        <tr>
                        <td>
                         <asp:UpdatePanel ID="uplMenuItems" runat="server">
                                <ContentTemplate>
                                    <div id="divFilter" style="width: 590px">
                                        <asp:Panel ID="pnlFilter" GroupingText=" " runat="server" meta:resourcekey="pnlFilterResource1">
                                            <table>
                                                <tr style="display: none">
                                                    <td colspan="2">
                                                        <asp:Label ID="lblMessage" runat="server" 
                                                            meta:resourcekey="lblMessageResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-left">
                                                        <asp:Label ID="Rs_SelectanOrganisation" Text="Select an Organisation" 
                                                            runat="server" meta:resourcekey="Rs_SelectanOrganisationResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:DropDownList ID="ddlOrganisation" runat="server" CssClass="ddlsmall" AutoPostBack="True"
                                                            OnSelectedIndexChanged="ddlOrganisation_SelectedIndexChanged" 
                                                            meta:resourcekey="ddlOrganisationResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:CheckBox ID="chkAddNew" runat="server" onclick="javascript:chkAdd()" 
                                                            Text="Add New Role" meta:resourcekey="chkAddNewResource1" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-left">
                                                        <asp:Label ID="Rs_SelectaRole" Text="Select a Role" runat="server" 
                                                            meta:resourcekey="Rs_SelectaRoleResource1"></asp:Label>
                                                        <asp:Label ID="lblAddRole" runat="server" Text="Role Name" 
                                                            meta:resourcekey="lblAddRoleResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="ddlsmall" OnSelectedIndexChanged="ddlRole_SelectedIndexChanged"
                                                            AutoPostBack="True" meta:resourcekey="ddlRoleResource1">
                                                        </asp:DropDownList>
                                                        <asp:TextBox ID="txtAddNewRole" runat="server" CssClass="Txtboxsmall" 
                                                            meta:resourcekey="txtAddNewRoleResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:Label ID="lblDescription" runat="server" Width="120px" Text="Description" 
                                                            meta:resourcekey="lblDescriptionResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:TextBox ID="txtRoleDescription" runat="server" CssClass="Txtboxsmall"
                                                            meta:resourcekey="txtRoleDescriptionResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="a-left"><asp:Image ID="astric" runat="server" ImageUrl="../Images/starbutton.png" /></td>
                                                    <td class="a-left">
                                                        <asp:Button ID="btnAddRole" runat="server" Text="Add Role" CssClass="btn" OnClientClick="return checkRole();"
                                                            OnClick="btnAddRole_Click" Width="65px" 
                                                            meta:resourcekey="btnAddRoleResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                    <table id="tblMenu">
                                        <tr>
                                            <td class="a-center">
                                            </td>
                                        </tr>
                                        <tr class="a-left">
                                            <td>
                                                <br />
                                                <asp:Label ID="lblSetHomePage" runat="server" Text="Select HomePage" 
                                                    Width="120px" meta:resourcekey="lblSetHomePageResource1"></asp:Label>
                                                <asp:DropDownList ID="drpPageUrl" runat="server" CssClass="ddlsmall"
                                                    meta:resourcekey="drpPageUrlResource1">
                                                </asp:DropDownList>
                                                <asp:HiddenField ID="hdnPageUrl" runat="server" />
                                            </td>
                                        </tr>
                                        <tr class="a-center">
                                            <td class="a-left">
                                                <div id="divMenuItems" style="width: 500px">
                                                    <br />
                                                    <div id="divHolder" runat="server">
                                                        <mil:MenuItemList ID="ucMenuItems" runat="server" />
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-center">
                                                <div id="divSubmit" runat="server" visible="False">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Button ID="btnSave" CssClass="btn" runat="server" Text="Save" OnClientClick="javascript:return doValidation();"
                                                                    OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" Width="45px" />
                                                            </td>
                                                            <td>
                                                                <asp:Button ID="btnCancelOne" CssClass="btn" runat="server" Text="Cancel" OnClick="btnCancelOne_Click"
                                                                    meta:resourcekey="btnCancelOneResource1" Width="67px" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                        </tr>
                        </table>
                           
                      
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />             
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">
        var objAlert = "";
        $(document).ready(function() {
         objAlert = SListForAppMsg.Get("Admin_MenuMapper_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_MenuMapper_aspx_Alert");
        });

        function doValidation() {
            var objVar01 = SListForAppMsg.Get("Admin_MenuMapper_aspx_01") == null ? "Select an organization to proceed" : SListForAppMsg.Get("Admin_MenuMapper_aspx_01");
            if (document.getElementById('ddlOrganisation').value == "--Select An Organization--") {

                var userMsg = SListForApplicationMessages.Get("Admin\\MenuMapper.aspx_1");
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    //alert('Select an organization to proceed');
                    ValidationWindow(objVar01, objAlert);
                    return false;
                }
                //return false;
            }
            if (document.getElementById('ddlRole').value == "----Select Role----") {

                var objVar02 = SListForAppMsg.Get("Admin_MenuMapper_aspx_02") == null ? "Select a role to proceed" : SListForAppMsg.Get("Admin_MenuMapper_aspx_02");
                var userMsg = SListForApplicationMessages.Get("Admin\\MenuMapper.aspx_2");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    //alert('Select a role to proceed');
                    ValidationWindow(objVar02, objAlert);
                    return false;
                }
                //return false;
            }
            if (document.getElementById('hdnPageUrl').value == "") {
                if (document.getElementById('drpPageUrl').selectedIndex == 0) {
                    var objVar03 = SListForAppMsg.Get("Admin_MenuMapper_aspx_03") == null ? "Select StartPage to proceed" : SListForAppMsg.Get("Admin_MenuMapper_aspx_03");

                    var userMsg = SListForApplicationMessages.Get("Admin\\MenuMapper.aspx_5");
                    if (userMsg != null) {
                        // alert(userMsg);
                        ValidationWindow(userMsg, objAlert);
                        return false;
                    }
                    else {
                        //alert('Select StartPage to proceed');
                        ValidationWindow(objVar03, objAlert);

                        return false;
                    }
                   // return false;
                }
            }
            return true;
        }
        function chkAdd() {
            if (document.getElementById('ddlOrganisation').selectedIndex != 0) {

                if (document.getElementById('chkAddNew').checked == true) {
                    document.getElementById('ddlRole').selectedIndex = 0;
                    document.getElementById('ddlRole').style.display = "none";
                    document.getElementById('lblAddRole').style.display = "block";
                    document.getElementById('lblDescription').style.display = "block";
                    document.getElementById('txtAddNewRole').style.display = "block";
                    document.getElementById('lblDescription').style.display = "block";
                    document.getElementById('txtAddNewRole').value = "";
                    document.getElementById('btnAddRole').style.display = "block";
                    document.getElementById('txtRoleDescription').style.display = "block";
                    /*Ajit Add*/
                    document.getElementById('astric').style.display = "block";
                    /**/
                    document.getElementById('txtRoleDescription').value = "";
                    document.getElementById('Rs_SelectaRole').style.display = "none";
                    document.getElementById('tblMenu').style.display = "none";
                    document.getElementById('ddlOrganisation').disabled = true;
                }
                if (document.getElementById('chkAddNew').checked == false) {
                    document.getElementById('ddlOrganisation').disabled = false;
                    document.getElementById('ddlRole').style.display = "block";
                    document.getElementById('Rs_SelectaRole').style.display = "block";
                    document.getElementById('tblMenu').style.display = "block";
                    document.getElementById('btnAddRole').style.display = "none";
                    document.getElementById('lblAddRole').style.display = "none";
                    document.getElementById('lblDescription').style.display = "none";
                    document.getElementById('txtAddNewRole').value = "";
                    document.getElementById('txtAddNewRole').style.display = "none";
                    document.getElementById('txtRoleDescription').style.display = "none";
                    /*Ajit Add*/
                    document.getElementById('astric').style.display = "none";
                    /**/
                }
            }
            if (document.getElementById('ddlOrganisation').selectedIndex == 0) {
                var objVar04 = SListForAppMsg.Get("Admin_MenuMapper_aspx_04") == null ? "Select An Organisation" : SListForAppMsg.Get("Admin_MenuMapper_aspx_04");

                var userMsg = SListForApplicationMessages.Get("Admin\\MenuMapper.aspx_6");
                if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    // alert('Select An Organisation');
                    ValidationWindow(objVar04, objAlert);
                    return false;
                }

               
                document.getElementById('chkAddNew').checked = false;
                return false;
            }
            return true;
        }
        function checkRole() {
            if (document.getElementById('ddlOrganisation').selectedIndex == 0) {
                var objVar04 = SListForAppMsg.Get("Admin_MenuMapper_aspx_04") == null ? "Select An Organisation" : SListForAppMsg.Get("Admin_MenuMapper_aspx_04");

                var userMsg = SListForApplicationMessages.Get("Admin\\MenuMapper.aspx_6");
                if (userMsg != null) {
                    //  alert(userMsg);
                    ValidationWindow(objvar16, objAlert);
                    return false;
                }
                else {
                    // alert('Select An Organisation');
                    ValidationWindow(objVar04, objAlert);
                    return false;
                }
               //return false;
            }
            if (document.getElementById('txtAddNewRole').value.trim() == "") {
                var objVar05 = SListForAppMsg.Get("Admin_MenuMapper_aspx_05") == null ? "Provide Role Name" : SListForAppMsg.Get("Admin_MenuMapper_aspx_05");

                var userMsg = SListForApplicationMessages.Get("Admin\\MenuMapper.aspx_7");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                    //alert('Provide Role Name');
                    ValidationWindow(objVar05, objAlert);
                    return false;
                }
               
            }
            /*Ajit Added*/
            if (document.getElementById('txtRoleDescription').value.trim() == "") {
                alert('Please Enter Role Description');
                return false;
            }
            /**/
            return true;
        }
            
    </script>

</body>
</html>
