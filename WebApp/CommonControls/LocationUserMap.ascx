<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LocationUserMap.ascx.cs"
    Inherits="CommonControls_LocationUserMap" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<script type="text/javascript" language="javascript">
    function checkValues() {
        var Information = SListForAppMsg.Get("Scripts_datetimepicker_js_02") != null ? SListForAppMsg.Get("Scripts_datetimepicker_js_02") : "Information";
        var UserMsg = SListForAppMsg.Get("CommonControls_LocationUserMap_ascx_01") != null ? SListForAppMsg.Get("CommonControls_LocationUserMap_ascx_01") : "Selected Date Must Be Greater than CurrentDate or CurrentDate ";
        var UserMsg1 = SListForAppMsg.Get("CommonControls_LocationUserMap_ascx_02") != null ? SListForAppMsg.Get("CommonControls_LocationUserMap_ascx_02") : "Select Role";
        
        var textUser = document.getElementById('<%= lblUser.ClientID %>').value;
        var rol = document.getElementById('<%= drpRole.ClientID %>');

        var rolID = rol.options[rol.selectedIndex].value;
        var rolName = rol.options[rol.selectedIndex].text;

        if (rolID == "0") {
            //var userMsg = SListForApplicationMessages.Get('CommonControls\\ClientSchedule.ascx_1');
            if (userMsg != null) {
                // alert(userMsg);
                ValidationWindow(UserMsg, Information);
            } else {
            //alert('Select Role');
            ValidationWindow(UserMsg1, Information);
            }
            return false;
        }
    }
    function SelectLocations() {
        var strObj = "0";
        var obj = document.getElementById('<%= chkLocations.ClientID %>');
        for (var i = 0; i < obj.cells.length - 1; i++) {
            if (obj.cells[i] != null && obj.cells[i].childNodes[0].type == "checkbox" && obj.cells[i].childNodes[0].checked == false) {
                strObj = "1";
            }
        }
        document.getElementById('<%= chkAllLocations.ClientID %>').checked = strObj == "1" ? false : true;
    }
    function SelectDept() {
        var strObj = "0";
        var obj = document.getElementById('<%= chkDepartment.ClientID %>');
        for (var i = 0; i < obj.cells.length - 1; i++) {
            if (obj.cells[i] != null && obj.cells[i].childNodes[0].type == "checkbox" && obj.cells[i].childNodes[0].checked == false) {
                strObj = "1";
            }
        }
        document.getElementById('<%= chkAllDepartments.ClientID %>').checked = strObj == "1" ? false : true;
    }
    function ChkAllDept(obj) {
//        var obj = document.getElementById('<%= chkDepartment.ClientID %>');
//        var chkAll = document.getElementById('<%= chkAllDepartments.ClientID %>');
//        if (obj != null) {
//            for (var i = 0; i < obj.cells.length - 1; i++) {
//                if (obj.cells[i] != null && obj.cells[i].childNodes[0].type == "checkbox") {
//                    if (chkAll != null) {
//                        obj.cells[i].childNodes[0].checked = chkAll.checked == true ? true : false;
//                    }
//                }
//            }
        //        }

        if ($("#" + obj.id).prop("checked")) { // check select status        
            $("#LocationUserMap_chkDepartment").find("input[type='checkbox']").prop("checked", true);
        } else {
            $("#LocationUserMap_chkDepartment").find("input[type='checkbox']").prop("checked", false);
        }
     
    }
    function ChkAllLocations(obj) {
//        var obj = document.getElementById('<%= chkLocations.ClientID %>');
//        var chkAll = document.getElementById('<%= chkAllLocations.ClientID %>');
//        if (obj != null) {
//            for (var i = 0; i < obj.cells.length - 1; i++) {
//                if (obj.cells[i] != null && obj.cells[i].childNodes[0].type == "checkbox") {
//                    if (chkAll != null) {
//                        obj.cells[i].childNodes[0].checked = chkAll.checked == true ? true : false;
//                    }
//                }
//            }
        //        }
        if ($("#" + obj.id).prop("checked")) { // check select status
            $("#LocationUserMap_chkLocations").find("input[type='checkbox']").prop("checked", true);
        } else {
        $("#LocationUserMap_chkLocations").find("input[type='checkbox']").prop("checked", false);
        }
    }
    function closePopUp() {
        var mPopup = $find('ModelPopLocationMap');
        mPopup.hide();
        return false;
    } 
</script>

<asp:UpdatePanel ID="updPanel" runat="server">
    <ContentTemplate>
        <table class="w-100p">
            <tr>
                <td class="a-left" colspan="2">
                    <asp:Label ID="lblHeader" runat="server" Font-Bold="True" 
                        Text="Department Location Map" meta:resourcekey="lblHeaderResource1"></asp:Label>
                    <br />
                    <br />
                </td>
                <td id="tdMsg" runat="server" style="display: none;">
                    <asp:Label ID="lblMsg" runat="server" meta:resourcekey="lblMsgResource1"></asp:Label>
                </td>
            </tr>
            <tr id="trLocationUserMap" runat="server">
                <td class="a-left w-20p">
                    <asp:Label ID="lblName" runat="server" Text="User Name :" 
                        meta:resourcekey="lblNameResource1"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="lblUser" runat="server" Font-Bold="True" 
                        meta:resourcekey="lblUserResource1"></asp:Label>
                </td>
                <td class="a-left w-27p">
                    <asp:Label ID="lblRole" runat="server" Text="Role Name :" 
                        meta:resourcekey="lblRoleResource1"></asp:Label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:DropDownList ID="drpRole" Width="150px" runat="server" AutoPostBack="True" 
                        OnSelectedIndexChanged="drpRole_SelectedIndexChanged" 
                        meta:resourcekey="drpRoleResource1">
                    </asp:DropDownList>
                </td>
                <td class="a-left w-28p">
                </td>
                <td class="a-left w-25p">
                </td>
            </tr>
            <tr>
                <asp:Panel ID="pnlDeptLocation" runat="server" 
                    meta:resourcekey="pnlDeptLocationResource1">
                    <td colspan="3" id="pnlDepts" runat="server" style="display: none;" class="a-left w-100p v-top">
                        <asp:Panel runat="server" GroupingText="Select Department" Font-Bold="True" 
                            meta:resourcekey="PanelResource1">
                            <asp:CheckBox ID="chkAllDepartments" runat="server" Text="Select All" 
                                Font-Bold="True" OnClick="ChkAllDept(this);" 
                                meta:resourcekey="chkAllDepartmentsResource1" /><br />
                            <br />
                            <asp:CheckBoxList CellPadding="4" ID="chkDepartment" runat="server" 
                                Font-Bold="False" RepeatColumns="4" meta:resourcekey="chkDepartmentResource1">
                            </asp:CheckBoxList>
                        </asp:Panel>
                    </td>
                    <td class="v-top a-left" runat="server" id="pnlLocations" style="display: none;">
                        <asp:Panel Width="90%" runat="server" GroupingText="Select Location" 
                            Font-Bold="True" meta:resourcekey="PanelResource2">
                            <asp:CheckBox ID="chkAllLocations" runat="server" Text="Select All" 
                                Font-Bold="True" OnClick="ChkAllLocations(this);" 
                                meta:resourcekey="chkAllLocationsResource1" /><br />
                            <br />
                            <asp:CheckBoxList ID="chkLocations" runat="server" RepeatColumns="3"
                                Font-Bold="False" meta:resourcekey="chkLocationsResource1">
                            </asp:CheckBoxList>
                        </asp:Panel>
                    </td>
                </asp:Panel>
            </tr>
            <tr>
                <td class="a-center" colspan="3">
                    <asp:Button ID="btnSaveLocations" Enabled="False" runat="server" Text="Save" CssClass="btn1"
                        OnClientClick="javascript:return checkValues();" 
                        OnClick="btnSaveLocations_Click" meta:resourcekey="btnSaveLocationsResource1" />
                    &nbsp;
                    <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn1" OnClientClick="javascript:return closePopUp();"
                        Style="margin-left: 0px" meta:resourcekey="btnCloseResource1" />
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnLoginName" runat="server" />
        <asp:HiddenField ID="hdnRoleName" Value="0" runat="server" />
    </ContentTemplate>
</asp:UpdatePanel>
