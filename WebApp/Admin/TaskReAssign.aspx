<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TaskReAssign.aspx.cs" Inherits="Admin_TaskReAssign"
    meta:resourcekey="PageResource1" %>

<%--<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="PhyHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>--%>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Task Re Assign</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <%--    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css"/>
    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>--%>

    <script language="javascript" type="text/javascript">
        function ShowAlertMsg(key) {
            var objApp01 = SListForAppMsg.Get("Admin_TaskReassign_aspx_01") == null ? "Please Filter the Task(s) by Role before reassigining" : SListForAppMsg.Get("Admin_TaskReassign_aspx_01");
            var objAlert = SListForAppMsg.Get("Admin_TaskReassign_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_TaskReassign_aspx_Alert");
            var objApp02 = SListForAppMsg.Get("Admin_TaskReassign_aspx_02") == null ? "Select alteast one task to Re Assign" : SListForAppMsg.Get("Admin_TaskReassign_aspx_02");

        
            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                //alert(userMsg);
                ValidationWindow(userMsg, objAlert);

            }
            else if (key == "Admin\\TaskReAssign.aspx.cs_8") {
            ValidationWindow(objApp01, objAlert);
               // alert('Please Filter the Task(s) by Role before reassigining');
            }
            else if (key == "Admin\\TaskReAssign.aspx.cs_11") {
            //alert('Select alteast one task to Re Assign');
            ValidationWindow(objApp02, objAlert);
            }
            return true;
        }

        function ddlChange() {
        
            //            alert('sa');
            var usersName = document.getElementById('ddlUsers').options[document.getElementById('ddlUsers').selectedIndex].innerHTML;
            if (usersName != '--Select--') {

                document.getElementById('chkAssignToRole').disabled = true;

            }
            else {
                document.getElementById('chkAssignToRole').disabled = false;
            }
            return false;
        }
        function Validate() {
            var isTrue = document.getElementById('chkAssignToRole');
            if (isTrue.checked == true) {
                document.getElementById('ddlRoleName').disabled = true;
                document.getElementById('ddlUsers').disabled = true;
            }
            if (isTrue.checked == false) {
                document.getElementById('ddlRoleName').disabled = false;
                document.getElementById('ddlUsers').disabled = false;
            }
            return true;
        }
        function funcShowButtons() {
            var roleName = document.getElementById('ddlRoleName').options[document.getElementById('ddlRoleName').selectedIndex].innerHTML;
            if (roleName == 'Select') {
                alert(roleName);
                divButton.style.display = 'none';
                divSpeciality.style.display = 'none';
                divUsers.style.display = 'none';
            }
            else if (roleName == 'Physician') {
                alert(roleName);
                divButton.style.display = 'block';
                divSpeciality.style.display = 'block';
                divUsers.style.display = 'block';
            }
            else {
                alert(roleName);
                divButton.style.display = 'block';
                divUsers.style.display = 'block';
            }
        }

        function CheckSelectedUsers() {
            var objAlert = SListForAppMsg.Get("Admin_TaskReassign_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_TaskReassign_aspx_Alert");
            var objApp03 = SListForAppMsg.Get("Admin_TaskReassign_aspx_03") == null ? "Select user name" : SListForAppMsg.Get("Admin_TaskReassign_aspx_03");
            var roleName = document.getElementById('ddlRoleName').options[document.getElementById('ddlRoleName').selectedIndex].innerHTML;
            if (roleName == 'Physician') {
                var speciality = document.getElementById('ddlspeciality').options[document.getElementById('ddlspeciality').selectedIndex].innerHTML;
                var usersName = document.getElementById('ddlUsers').options[document.getElementById('ddlUsers').selectedIndex].innerHTML;
                if (usersName == '--Select--') {
                    var userMsg = SListForApplicationMessages.Get("Admin\\TaskReAssign.aspx_2");
                    if (userMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg, objAlert);
                        //return false;
                    }
                    else {
                        //alert('Select user name');
                        ValidationWindow(objApp03, objAlert);
                        //return false;
                    }
                    document.getElementById('ddlUsers').focus();
                    return false;
                }
                return true;
            }
            else {
                var objApp03 = SListForAppMsg.Get("Admin_TaskReassign_aspx_03") == null ? "Select user name" : SListForAppMsg.Get("Admin_TaskReassign_aspx_03");
                var objAlert = SListForAppMsg.Get("Admin_TaskReassign_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_TaskReassign_aspx_Alert");
                var usersName = document.getElementById('ddlUsers').options[document.getElementById('ddlUsers').selectedIndex].innerHTML;
                var isTrue = document.getElementById('chkAssignToRole');

                if ((usersName == '--Select--') && (isTrue.checked == false)) {
                    var userMsg = SListForApplicationMessages.Get("Admin\\TaskReAssign.aspx_2");
                    if (userMsg != null) {

                        //alert(userMsg);
                        ValidationWindow(userMsg, objAlert);
                        //return false;
                    }
                    else {
                        //alert('Select user name');
                        ValidationWindow(objApp03, objAlert);
                        //return false;
                    }
                    document.getElementById('ddlUsers').focus();
                    return false;
                }
                return true;
            }
        }

        function ValidateTask() {
        
            var objAlert = SListForAppMsg.Get("Admin_TaskReassign_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_TaskReassign_aspx_Alert");
            var objApp04 = SListForAppMsg.Get("Admin_TaskReassign_aspx_04") == null ? "Provide task date" : SListForAppMsg.Get("Admin_TaskReassign_aspx_04");
            var objApp05= SListForAppMsg.Get("Admin_TaskReassign_aspx_05") == null ? "Select a role for filtering the task" : SListForAppMsg.Get("Admin_TaskReassign_aspx_05");
            var roleName = document.getElementById('ddlRoleName').options[document.getElementById('ddlRoleName').selectedIndex].innerHTML;

            if (document.getElementById('txtTaskDate').value == '') {
                var userMsg = SListForApplicationMessages.Get("Admin\\TaskReAssign.aspx_3");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, objAlert);
                    //return false;
                }
                else {
                    ValidationWindow(objApp04, objAlert);
                   // alert('Provide task date');
                    //return false;
                }
                document.getElementById('txtTaskDate').focus();
                return false;
            }

            if (roleName == 'Select') {
                var userMsg = SListForApplicationMessages.Get("Admin\\TaskReAssign.aspx_4");
                if (userMsg != null) {
                    ValidationWindow(userMsg, objAlert);
                    //alert(userMsg);
                    //return false;
                }
                else {
                    ValidationWindow(objApp05, objAlert);
                    //alert('Select a role for filtering the task');
                    //return false;
                }
                document.getElementById('ddlRoleName').focus();
                return false;
            }
            return true;
        }

        function SelectTaskReAssign(rid) {
            chosen = "";

            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnSearch">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table class="w-100p searchPanel">
                    <tr>
                        <td class="w-30p">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" Text="Patient Name" meta:resourcekey="Label2Resource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPatientName" runat="server" CssClass="small" meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="w-25p">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label3" runat="server" Text="Task Date" meta:resourcekey="Label3Resource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtTaskDate" runat="server" CssClass="Txtboxverysmall" meta:resourcekey="txtTaskDateResource1"></asp:TextBox>
                                        <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                        <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtTaskDate"
                                            Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                            Enabled="True" />
                                        <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                            ControlToValidate="txtTaskDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                        <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtTaskDate"
                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="w-27p">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text="Role Name" meta:resourcekey="Label1Resource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlRoleName" Visible="False" runat="server" CssClass="ddlsmall"
                                            meta:resourcekey="ddlRoleNameResource1">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="w-18p a-left">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search"
                                            CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                            OnClientClick="return ValidateTask()" meta:resourcekey="btnSearchResource1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr class="a-left">
                        <td colspan="4">
                            <div class="errorbox">
                                <asp:Label ID="lblWarning" runat="server" Text="Please ensure the task is not used by any of the users before ReAssigning, Otherwise ReAssign may Collapse the Task."
                                    Style="font-weight: bold" meta:resourcekey="lblWarningResource1"></asp:Label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <asp:GridView ID="grdTasks" Visible="False" CellPadding="4" AutoGenerateColumns="False"
                                DataKeyNames="TaskID" ForeColor="#333333" CssClass="mytable1 gridView w-100p"
                                runat="server" OnRowDataBound="grdTasks_RowDataBound" meta:resourcekey="grdTasksResource1">
                                <HeaderStyle CssClass="dataheader1" />
                                <Columns>
                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkTasks" Visible="False" runat="server" meta:resourcekey="chkTasksResource1" /><asp:RadioButton
                                                ID="rdTasks" runat="server" ToolTip="Select Row" GroupName="PatientSelect" meta:resourcekey="rdTasksResource2" />
                                        </ItemTemplate>
                                        <ItemStyle CssClass="w-5p" />
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="False" HeaderText="Task ID" meta:resourcekey="TemplateFieldResource2">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTaskID" runat="server" Text='<%# Bind("TaskID") %>' meta:resourcekey="lblTaskIDResource1"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="w-5p" />
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="False" HeaderText="Task Action ID" meta:resourcekey="TemplateFieldResource3">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTaskActionID" runat="server" Text='<%# Bind("TaskActionID") %>'
                                                meta:resourcekey="lblTaskActionIDResource1"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="w-5p" />
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="False" HeaderText="Role ID" meta:resourcekey="TemplateFieldResource4">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRoleID" runat="server" Text='<%# Bind("RoleID") %>' meta:resourcekey="lblRoleIDResource1"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="w-5p" />
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="False" HeaderText="Assigned To" meta:resourcekey="TemplateFieldResource5">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAssignedTo" runat="server" Text='<%# Bind("AssignedTo") %>' meta:resourcekey="lblAssignedToResource1"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="w-5p" />
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="False" HeaderText="Patient VistID" meta:resourcekey="TemplateFieldResource6">
                                        <ItemTemplate>
                                            <asp:Label ID="lblVisitD" runat="server" Text='<%# Bind("PatientVisitID") %>' meta:resourcekey="lblVisitDResource1"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="w-5p" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource7">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTaskDescription" runat="server" Text='<%# Bind("TaskDescription") %>'
                                                meta:resourcekey="lblTaskDescriptionResource1"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="w-25p" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Category" HeaderText="Category" meta:resourcekey="BoundFieldResource1">
                                        <ItemStyle CssClass="a-left w-20p" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="RoleName" HeaderText="Assigned To" meta:resourcekey="BoundFieldResource2">
                                        <ItemStyle CssClass="a-left w-15p" />
                                    </asp:BoundField>
                                    <%-- <asp:BoundField DataField="AssignedToName" HeaderText="RoleName" meta:resourcekey="BoundFieldResource10">
                                                        <ItemStyle HorizontalAlign="Left" Width="15%" />
                                                        </asp:BoundField>--%>
                                    <asp:BoundField DataField="StatusName" HeaderText="Status" meta:resourcekey="BoundFieldResource3">
                                        <ItemStyle CssClass="a-left w-15p" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ParentID" HeaderText="ParentID" Visible="False" meta:resourcekey="BoundFieldResource4">
                                        <ItemStyle CssClass="a-left w-2p" />
                                    </asp:BoundField>
                                    <asp:TemplateField Visible="False" HeaderText="PatientID" meta:resourcekey="TemplateFieldResource8">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPatientID" runat="server" Text='<%# Bind("PatientID") %>' meta:resourcekey="lblPatientIDResource1"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="w-2p" />
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="False" HeaderText="SpecialityID" meta:resourcekey="TemplateFieldResource9">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSpecialityID" runat="server" Text='<%# Bind("SpecialityID") %>'
                                                meta:resourcekey="lblSpecialityIDResource1"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="w-2p" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:Label ID="lblMessage" runat="server" Visible="False" CssClass="defaultfontcolor"
                                meta:resourcekey="lblMessageResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="btnSelect" runat="server" Text="Select All Tasks" CssClass="btn"
                                onmouseover="this.className='btn btnhov'" Visible="False" onmouseout="this.className='btn'"
                                OnClick="btnSelect_Click" meta:resourcekey="btnSelectResource1" />
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" align="center" valign="middle">
                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                <ProgressTemplate>
                                    <div id="progressBackgroundFilter" class="a-center">
                                    </div>
                                    <div id="processMessage" class="a-center w-20p">
                                        <asp:Image ID="img1" CssClass="w-40 h-40" runat="server" ImageUrl="../Images/loading.GIF"
                                            meta:resourcekey="img1Resource1" />
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <div id="divSpeciality" runat="server" style="display: block">
                                <table class="w-100p">
                                    <tr>
                                        <td class="w-100">
                                            <asp:Label ID="Rs_Speciality" Text="Speciality" runat="server" meta:resourcekey="Rs_SpecialityResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlspeciality" runat="server" AutoPostBack="True" CssClass="ddlsmall"
                                                OnSelectedIndexChanged="ddlspeciality_SelectedIndexChanged" meta:resourcekey="ddlspecialityResource1">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="divUsers" runat="server" style="display: block">
                                <table class="w-40p">
                                    <tr>
                                        <td class="w-10">
                                            <asp:Label ID="Rs_Users" Text="SelectUserName" runat="server" meta:resourcekey="Rs_UsersResource1"></asp:Label>
                                        </td>
                                        <td class="w-10">
                                            <asp:DropDownList ID="ddlUsers" onchange="javascript:return ddlChange();" CssClass="ddlsmall"
                                                runat="server" meta:resourcekey="ddlUsersResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td class="w-20">
                                            <asp:CheckBox ID="chkAssignToRole" runat="server" Text="AssignToRole" 
                                                OnClick="Validate();" meta:resourcekey="chkAssignToRoleResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <div id="divButton" runat="server" style="display: block;">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    OnClientClick="return CheckSelectedUsers()" onmouseout="this.className='btn'"
                                    OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                            </div>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
