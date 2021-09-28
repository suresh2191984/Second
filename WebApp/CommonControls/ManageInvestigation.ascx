<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ManageInvestigation.ascx.cs"
    Inherits="CommonControls_ManageInvestigation" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>
<script type="text/javascript" language="javascript">
function ShowAlertMsg(key) {
        var Error = SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_01") != null ? SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_01") : "Information";
        var InformationMsg = SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_02") != null ? SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_02") : "select an item to remove";
        var InformationMsg1 = SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_03") != null ? SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_03") : "select an item to add";
            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
            // alert(userMsg);
            ValidationWindow(userMsg , Error);
                return false ;
            }
        //else if (key == 'CommonControls\\ManageInvestigation.ascx.cs_1')
        else if (key == InformationMsg) {
            //alert('select an item to remove');
            ValidationWindow(InformationMsg , Error);
            return false ;
            }
        // else if (key == 'CommonControls\\ManageInvestigation.ascx.cs_2')
        else if (key == InformationMsg1) {
            //alert('Select an item to add');
            ValidationWindow(InformationMsg1, Error);
             return false ;
             }
           return true;
        }
    function chkonsearch1() {
        var Error = SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_01") != null ? SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_01") : "Information";
        var InformationMsg2 = SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_04") != null ? SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_04") : "Enter minimum 2 letters";
        //var InformationMsg3 = SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_05") != null ? SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_05") : "Enter minimum 3 letters";
        var text = document.getElementById('<%=txt_search.ClientID %>').value;
        var i = text.length;
        if (i < 2) {
            //var userMsg = SListForApplicationMessages.Get('CommonControls\\ManageInvestigation.ascx_1');
            if (InformationMsg2 != null) {
                ValidationWindow(InformationMsg2, Error);
                //alert(userMsg);
            }
            else {
                //    alert('Enter minimum 3 letters');
                ValidationWindow(InformationMsg2, Error);

            }
            return false;
        }
        else {
            return true;
        }
    }
    function chkonsearch2() {
        var Error = SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_01") != null ? SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_01") : "Information";
        var InformationMsg2 = SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_04") != null ? SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_04") : "Enter minimum 2 letters";
        var text = document.getElementById('<%=txt_searchmap.ClientID %>').value;
        var i = text.length;
        if (i < 2) {
            //var userMsg = SListForApplicationMessages.Get('CommonControls\\ManageInvestigation.ascx_1');
            if (InformationMsg2 != null) {
                // alert(userMsg);
                ValidationWindow(InformationMsg2, Error);
            } else {
                // alert('Enter minimum 2 letters');
                ValidationWindow(InformationMsg2 , Error);
            }
            return false;
        }
        else {
            return true;
        }
    }
    function chkonchange() {
        var Error = SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_01") != null ? SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_01") : "Information";
        var InformationMsg4 = SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_06") != null ? SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_06") : "Select the items in investigation master";
        var tableBody = document.getElementById('<%=chklstGrp.ClientID %>').childNodes[1];
        var j = 0;
        for (var i = 0; i < tableBody.childNodes.length; i++) {
            var currentTd = tableBody.childNodes[i].childNodes[0];
            var listControl = currentTd.childNodes[0];
            if (listControl.checked == true) {
                j = j + 1;
            }
        }
        if (j == 0) {
            // var userMsg = SListForApplicationMessages.Get('CommonControls\\ManageInvestigation.ascx_2');
            if (InformationMsg4 != null) {
                //alert(InformationMsg4);
                ValidationWindow(InformationMsg4 , Error);
                //alert(userMsg);
            } else {
                ValidationWindow(InformationMsg4 , Error);

                //alert('Select the items in investigation master');
            }
            return false;
        }
    }
    function chklstGrponchange() {
        var Error = SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_01") != null ? SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_01") : "Information";
        var InformationMsg5 = SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_07") != null ? SListForAppMsg.Get("CommonControls_ManageInvestigation_ascx_07") : "Select the items in group mapping";
        var table = document.getElementById('<%=chkGrpMap.ClientID %>').childNodes[0];
        var k = 0;
        for (var i = 0; i < table.childNodes.length; i++) {
            var currentTd = table.childNodes[i].childNodes[0];
            var listControl = currentTd.childNodes[1];  
            if (listControl.checked == true) {
                k = k + 1;
            }
        }
        if (k == 0) {
            //var userMsg = SListForApplicationMessages.Get('CommonControls\\ManageInvestigation.ascx_3');
            if (InformationMsg5 != null) {
                //alert(userMsg);
                ValidationWindow(InformationMsg5, Error);
            } else {
                //alert('Select the items in group mapping');
                ValidationWindow(InformationMsg4 , Error);
            }
            return false;
        }
    }
</script>

<asp:Panel ID="pnlInvestigation" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlInvestigationResource1">
    <table>
        <tr>
            <td>
                <asp:HiddenField ID="HiddenField1" runat="server" />
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                            <asp:TextBox ID="txt_search" runat="server" CssClass="small" meta:resourcekey="txt_searchResource1"></asp:TextBox>
                            <asp:Button ID="btnmassearch" Class="btn" runat="server" Text="Search" OnClientClick="javascript:return chkonsearch1();"
                                OnClick="btnmassearch_Click" meta:resourcekey="btnmassearchResource1" />
                            <asp:CheckBox ID="chkmasshow" runat="server" Text="Show All" OnCheckedChanged="chkmasshow_CheckedChanged"
                                AutoPostBack="True" meta:resourcekey="chkmasshowResource1" Style="display: none" />
                            <asp:RadioButton ID="rdoInvestigation" runat="server" Text="Investigations" GroupName="radioselect"
                                OnCheckedChanged="rdoInvestigation_CheckedChanged" AutoPostBack="True" meta:resourcekey="rdoInvestigationResource1" />
                            <asp:RadioButton ID="rdoGroup" runat="server" Text="Groups" GroupName="radioselect"
                                OnCheckedChanged="rdoGroup_CheckedChanged" AutoPostBack="True" meta:resourcekey="rdoGroupResource1" />
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="Label2" runat="server" meta:resourcekey="Label2Resource1"></asp:Label>
                            <asp:TextBox ID="txt_searchmap" runat="server" CssClass="small" meta:resourcekey="txt_searchmapResource1"></asp:TextBox>
                            <asp:TextBox ID="txt_gid" runat="server" Visible="False" CssClass="small" meta:resourcekey="txt_gidResource1"></asp:TextBox>
                            <asp:Button ID="btnmapsearch" CssClass="btn" runat="server" Text="Search" OnClientClick="javascript:return chkonsearch2();"
                                OnClick="btnmapsearch_Click" meta:resourcekey="btnmapsearchResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="ancCSbg">
                            <asp:Label ID="lblmastinves" runat="server" Text=" Master Investigation" meta:resourcekey="lblmastinvesResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:HiddenField ID="HdnCntHeader" runat="server" />
                            <asp:HiddenField ID="HdnLoaddata" runat="server" />
                            <asp:HiddenField ID="HdnDept" runat="server" />
                            <asp:HiddenField ID="Hdnheader" runat="server" />
                            <asp:HiddenField ID="HdnCntDept" runat="server" />
                            <asp:HiddenField ID="HdntempDept" runat="server" />
                            <asp:HiddenField ID="HdntempHead" runat="server" />
                            <asp:HiddenField ID="hidID" runat="server" />
                            <asp:HiddenField ID="hidMapID" runat="server" />
                        </td>
                        <td class="ancCSbg">
                            <asp:Label ID="lblinvesmapto" runat="server" Text="Investigation Mapped to" meta:resourcekey="lblinvesmaptoResource1"></asp:Label>
                            <asp:Label ID="Label3" runat="server" meta:resourcekey="Label3Resource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="h-51 bg-row">
                            <div style="overflow: scroll; border: 2px; border-color: #fff; height: 400px; width: 450px"
                                class="ancCSviolet">
                                <asp:CheckBoxList ID="chklstGrp" runat="server" Font-Size="X-Small" Height="100px"
                                    Width="320px" meta:resourcekey="chklstGrpResource1">
                                </asp:CheckBoxList>
                            </div>
                            <asp:HiddenField ID="hdnvaluemapping" runat="server" />
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:HiddenField ID="hdnvalue" runat="server" />
                                        <asp:Button ID="btnInvAdd" runat="server" CssClass="btn w-57" Text="Add" OnClick="btnInvAdd_Click"
                                             meta:resourcekey="btnInvAddResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-center h-15" align="center">
                                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                            <ProgressTemplate>
                                                <div id="progressBackgroundFilter" class="a-center">
                                                </div>
                                                <div id="processMessage" class="a-center w-20p">
                                                    <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                                        meta:resourcekey="img1Resource1" />
                                                </div>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:HiddenField ID="hdn" runat="server"></asp:HiddenField>
                                        <asp:Button ID="btnInvRemove" runat="server" CssClass="btn" Text="Remove" OnClick="btnInvRemove_Click"
                                            meta:resourcekey="btnInvRemoveResource1" />
                                    </td>
                                </tr>
                            </table>
                            <asp:HiddenField ID="hdnmapping" runat="server" />
                            <asp:HiddenField ID="Hdngid" runat="server" />
                        </td>
                        <td class="v-top bg-row">
                            <div style="overflow: scroll; height: 400px; width: 450px" class="ancCSviolet">
                                <asp:CheckBoxList ID="chkGrpMap" runat="server" Font-Size="X-Small" Width="320px"
                                    meta:resourcekey="chkGrpMapResource1">
                                </asp:CheckBoxList>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Panel>
