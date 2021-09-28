<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ConfigMaster.aspx.cs" Inherits="ConfigSetting_ConfigMaster" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Config Master</title>
    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">


        function ShowAlertMsg(key) {
            var objAlert = SListForAppMsg.Get("ConfigSetting_ConfigMaster_aspx") == null ? "Alert" : SListForAppMsg.Get("ConfigSetting_ConfigMaster_aspx");
            var objApp01 = SListForAppMsg.Get("ConfigSetting_ConfigMaster_aspx_01") == null ? "Changes saved successfully" : SListForAppMsg.Get("ConfigSetting_ConfigMaster_aspx_01");
            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                ValidationWindow(userMsg, objAlert);
                //alert(userMsg);
                return false;
            }
            else {
                ValidationWindow(objAlert, objApp01);
               // alert('Changes saved successfully.');
                return false;
            }

            return true;
        }      
    
    
         function GetModifiedValue(cntlID, configID, configKeyID, cntrlType, configType, configKey, orgAddID) {
             var configValue = '';
             if (cntrlType == "RDO") {
                 var radioBtn = document.getElementById(cntlID).getElementsByTagName("input");
                 var labelval = document.getElementById(cntlID).getElementsByTagName("label");
                 for (var i = 0; i < radioBtn.length; i++) {
                     if (radioBtn[i].type.toString().toLowerCase() == "radio") {
                         if (radioBtn[i].checked == true) {
                             configValue = labelval[i].innerHTML;
                         }
                     }
                 }
             }
             else if (cntrlType == "TEXT") {
                 configValue = document.getElementById(cntlID).value;
             }
             else if (cntrlType == "DDL") {
                 var drplst = document.getElementById(cntlID);
                 configValue = drplst.options[drplst.selectedIndex].value;
             }
             else if (cntrlType == "CHB") {
                 var chkBxlst = document.getElementById(cntlID);
                 if (chkBxlst.type.toString().toLowerCase() == "checkbox") {
                     if (chkBxlst.checked == true) {
                         configValue = "Y";
                     }
                     else {
                         configValue = "N";
                     }
                 }
             }

             var existsItems = document.getElementById('hdnModifiedValues').value.split('^');
             if (existsItems != '') {
                 var newItems = '';
                 for (var k = 0; k < existsItems.length; k++) {
                     if (existsItems[k] != '') {
                         if (existsItems[k].split('~')[1] != configKeyID) {
                             newItems += existsItems[k] + '^';
                         }
                     }
                 }
                 document.getElementById('hdnModifiedValues').value = '';
                 document.getElementById('hdnModifiedValues').value = newItems + configID + '~' + configKeyID + '~' + configValue + '~' + configType + '~' + configKey + '~' + orgAddID + '^';
             }
             else {
                 document.getElementById('hdnModifiedValues').value = configID + '~' + configKeyID + '~' + configValue + '~' + configType + '~' + configKey + '~' + orgAddID + '^';
             }
         }
    </script>

</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
                <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <asp:UpdatePanel ID="updateConfigDetails" runat="server">
                        <ContentTemplate>
                            <div class="contentdata">
                             
                                <table class="w-100p searchPanel" runat="server">
                                    <tr class="dataheader2" >
                                        <td class="w-15p">
                                            <asp:Label ID="lblDepartment" Text="Select the Department" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList Width="150px" ID="ddlConfigType" runat="server" AutoPostBack="True"
                                                OnSelectedIndexChanged="ddlConfigType_SelectedIndexChanged" CssClass="ddlsmall">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr id="trConfig1" runat="server">
                                        <td colspan="2">
                                            <asp:GridView ID="gvConfig" EmptyDataText="No ConfigKey Found!" runat="server" OnRowDataBound="gvConfig_RowDataBound"
                                                AutoGenerateColumns="False" CssClass="mytable1 w-100p gridView">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No.">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %>
                                                            <asp:HiddenField ID="hdnConfigKeyID" Value='<%# Eval("ConfigKeyID") %>' runat="server" />
                                                            <asp:HiddenField ID="hdnControlType" Value='<%# Eval("ControlType") %>' runat="server" />
                                                            <asp:HiddenField ID="hdnConfigID" runat="server" />
                                                            <asp:HiddenField ID="hdnConfigType" Value='<%# Eval("ConfigType") %>' runat="server" />
                                                            <asp:HiddenField ID="hdnConfigValue" runat="server" Value='<%#Eval("ConfigValue")%>' />
                                                            <asp:HiddenField ID="hdnConfigKey" runat="server" Value='<%#Eval("ConfigKey")%>' />
                                                            <asp:HiddenField ID="hdnSubAddressId" Value='' runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="DisplayText" HeaderText="Key" />
                                                    <asp:TemplateField HeaderText="Value">
                                                        <ItemTemplate>
                                                            <asp:DropDownList Width="180px" Visible="false" ID="ddlConfigValue" runat="server">
                                                            </asp:DropDownList>
                                                            <asp:TextBox ID="txtConfigValue" Width="180px" Visible="false" runat="server"></asp:TextBox>
                                                            <asp:RadioButtonList ID="rdoConfigValue" Width="180px" Visible="false" RepeatDirection="Horizontal"
                                                                runat="server" />
                                                            <asp:CheckBox ID="chkConfigValue" Text="YES" Visible="false" runat="server" meta:resourcekey="chkConfigValueResource1"/>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr id="trConfig2" runat="server">
                                        <td colspan="2">
                                            <strong>
                                                <asp:Label ID="lblOrgTitle" runat="server" Text="Organization Address Based Config" meta:resourcekey="lblOrgTitleResource1" ></asp:Label></strong>
                                            <asp:GridView ID="gvSubConfig" EmptyDataText="No ConfigKey Found!" runat="server"
                                                OnRowDataBound="gvSubConfig_RowDataBound" AutoGenerateColumns="False" CssClass="gridView w-100p">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <table class="w-100p">
                                                                <tr>
                                                                    <td class="a-center">
                                                                        <strong>
                                                                            <asp:Label ID="lblOrganizationAddressName" runat="server" Text="Organization Address Name :" meta:resourcekey="lblOrganizationAddressNameResource1"></asp:Label>
                                                                        
                                                                            <asp:Label ID="lblLocation" Text='<%# Eval("Location")%>' runat="server"></asp:Label></strong>
                                                                        <asp:HiddenField ID="hdnAddressId" Value='<%# Eval("AddressID") %>' runat="server" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:GridView ID="grdInner" EmptyDataText="No ConfigKey Found!" AutoGenerateColumns="false"
                                                                            runat="server" OnRowDataBound="gvConfig_RowDataBound" CssClass="mytable1 gridView w-100p" GridLines="Both">
                                                                            <Columns>
                                                                                <asp:TemplateField>
                                                                                    <HeaderTemplate>
                                                                                        <asp:Label ID="lblSubSno" Text="S.No" runat="server" meta:resourcekey="lblSubSnoResource1"></asp:Label>
                                                                                    </HeaderTemplate>
                                                                                    <ItemTemplate>
                                                                                        <%#Container.DataItemIndex+1 %>
                                                                                        <asp:HiddenField ID="hdnConfigKeyID" Value='<%# Eval("ConfigKeyID") %>' runat="server" />
                                                                                        <asp:HiddenField ID="hdnControlType" Value='<%# Eval("ControlType") %>' runat="server" />
                                                                                        <asp:HiddenField ID="hdnConfigID" runat="server" />
                                                                                        <asp:HiddenField ID="hdnConfigType" Value='<%# Eval("ConfigType") %>' runat="server" />
                                                                                        <asp:HiddenField ID="hdnConfigValue" runat="server" Value='<%#Eval("ConfigValue")%>' />
                                                                                        <asp:HiddenField ID="hdnConfigKey" runat="server" Value='<%#Eval("ConfigKey")%>' />
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:BoundField DataField="DisplayText" HeaderText="Key" />
                                                                                <asp:TemplateField HeaderText="Value">
                                                                                    <ItemTemplate>
                                                                                        <asp:DropDownList Width="180px" Visible="false" ID="ddlConfigValue" runat="server">
                                                                                        </asp:DropDownList>
                                                                                        <asp:TextBox ID="txtConfigValue" Width="180px" Visible="false" runat="server"></asp:TextBox>
                                                                                        <asp:RadioButtonList ID="rdoConfigValue" Width="180px" Visible="false" RepeatDirection="Horizontal"
                                                                                            runat="server" />
                                                                                        <asp:CheckBox ID="chkConfigValue1" Text="YES" Visible="false" runat="server" meta:resourcekey="chkConfigValue1Resource1"/>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr id="trBtnSave" runat="server">
                                        <td  colspan="2" class="a-center" id="tdBtns" runat="server" style="display: none;">
                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1"/>
                                            &nbsp;&nbsp;
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1"/>
                                        </td>
                                    </tr>
                                </table>
                                <input id="hdnStatus" runat="server" value="N" visible="False" type="text" class="Txtboxsmall"/>
                                <asp:HiddenField ID="hdnAddId" Value="0" runat="server" />
                                <asp:HiddenField ID="hdnchangesstat" runat="server" />
                                <asp:HiddenField ID="hdnModifiedValues" runat="server" />
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
               <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
