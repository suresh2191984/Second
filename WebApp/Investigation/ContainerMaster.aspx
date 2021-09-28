<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContainerMaster.aspx.cs"
    Inherits="Investigation_ContainerMaster" meta:resourcekey="PageResource1" %>
    
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="uc31" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <script type="text/javascript" language="javascript">
        function ValidateSample() {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vSampleName = SListForAppMsg.Get('Investigation_ContainerMaster_ascx_01') == null ? "Provide Sample Name" : SListForAppMsg.Get('Investigation_ContainerMaster_ascx_01');
            var vValidationSampleName = SListForAppMsg.Get('Investigation_ContainerMaster_ascx_02') == null ? "Sample Name Already Exists!!!" : SListForAppMsg.Get('Investigation_ContainerMaster_ascx_02');
            if (document.getElementById('TabContainer1_Sequencetab_txtSampleName').value.trim() == "") {
                //alert('Provide Sample Name');
                ValidationWindow(vSampleName, AlertType);
                document.getElementById('TabContainer1_Sequencetab_txtSampleName').focus();
                return false;
            }
            var flag1 = 0;
            $('#TabContainer1_Sequencetab_grdSample tbody tr td span').each(function() {
                if ($(this).html() == $.trim($('#TabContainer1_Sequencetab_txtSampleName').val())) {
                    flag1++;
                }
            });
                if (flag1 >= 1) {
                $('#TabContainer1_Sequencetab_txtSampleName').val('');
                $('#TabContainer1_Sequencetab_txtSampleName').focus();
                //alert('Sample Name Already Exists!!!');
                ValidationWindow(vValidationSampleName, AlertType);
                return false;
                }
        }
        function ValidateContainer() {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vSampleName = SListForAppMsg.Get('Investigation_ContainerMaster_ascx_01') == null ? "Provide Sample Name" : SListForAppMsg.Get('Investigation_ContainerMaster_ascx_01');
            var vValidationSampleName = SListForAppMsg.Get('Investigation_ContainerMaster_ascx_02') == null ? "Sample Name Already Exists!!!" : SListForAppMsg.Get('Investigation_ContainerMaster_ascx_02');
            
            if (document.getElementById('TabContainer1_TabPanel2_txtContainer').value.trim() == "") {
                //alert('Provide Sample Name');
                ValidationWindow(vSampleName, AlertType);
                document.getElementById('TabContainer1_TabPanel2_txtContainer').focus();
                return false;
            }
            var flag = 0;
            $('#TabContainer1_TabPanel2_grdSampleContainer tbody tr td span').each(function() {
                if ($(this).html() == $.trim($('#TabContainer1_TabPanel2_txtContainer').val())) {
                    flag++;
                }
            });
                if (flag >= 1) {
                $('#TabContainer1_TabPanel2_txtContainer').val('');
                $('#TabContainer1_TabPanel2_txtContainer').focus();
                //alert('Container Name Already Exists!!!')
                ValidationWindow(vValidationSampleName, AlertType);
                flag = 'set';
                return false;
                }
        }
        function ClearValues(obj) {
            if (obj == "Sample") {
                document.getElementById('TabContainer1_Sequencetab_txtSampleName').value = "";
                document.getElementById('TabContainer1_Sequencetab_txtSampleCode').value = "";
                document.getElementById("TabContainer1_Sequencetab_chkBox2").checked  = "";
            }
            else {
                document.getElementById('TabContainer1_TabPanel2_txtContainer').value = "";
                document.getElementById('TabContainer1_TabPanel2_txtContainerDesc').value = "";
                document.getElementById('TabContainer1_TabPanel2_txtContainerCode').value = "";
            }
        }
        function ValidateCode(obj) {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vCodeAlreadyExists = SListForAppMsg.Get('Investigation_ContainerMaster_ascx_03') == null ? "Code already exists !!" : SListForAppMsg.Get('Investigation_ContainerMaster_ascx_03');
            if (obj == "SAMPLE") {
                if (document.getElementById('hdnSapmleCode').value != "") {
                    var SapmleCode = document.getElementById('hdnSapmleCode').value.split("^");
                    var txtCode = document.getElementById('TabContainer1_Sequencetab_txtSampleCode').value;
                    var txtID = document.getElementById('hdnSampleID').value;
                    for (var i = 0; i < SapmleCode.length; i++) {
                        if (SapmleCode[i].split('~')[0].toUpperCase() == txtCode.toUpperCase()) {
                            if (txtID != SapmleCode[i].split('~')[1]) {
                                //alert('Code already exists !!');
                                ValidationWindow(vCodeAlreadyExists, AlertType);
                                document.getElementById('TabContainer1_Sequencetab_txtSampleCode').value = "";
                                document.getElementById('TabContainer1_Sequencetab_txtSampleCode').focus();
                                return false;
                            }
                        }
                    }
                }
            }
            if (obj == "CONTAINER") {
                if (document.getElementById('hdnContainerCode').value != "") {
                    var ContainerCode = document.getElementById('hdnContainerCode').value.split("^");
                    var txtCode = document.getElementById('TabContainer1_TabPanel2_txtContainerCode').value;
                    var txtID = document.getElementById('hdnContainerID').value;
                    for (var i = 0; i < ContainerCode.length; i++) {
                        if (ContainerCode[i].split('~')[0].toUpperCase() == txtCode.toUpperCase()) {
                            if (txtID != ContainerCode[i].split('~')[1]) {
                                //alert('Code already exists !!');
                                ValidationWindow(vCodeAlreadyExists, AlertType);
                                document.getElementById('TabContainer1_TabPanel2_txtContainerCode').value = "";
                                document.getElementById('TabContainer1_TabPanel2_txtContainerCode').focus();
                                return false;
                            }
                        }
                    }
                }
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
                        <table cellpadding="0" cellspacing="0" border="0" class="searchPanel w-100p">
                            <tr>
                                <td>
                                    <asp:UpdatePanel ID="upd" runat="server">
                                        <ContentTemplate>
                    <ajc:TabContainer ID="TabContainer1" runat="server" AutoPostBack="True" Width="100%"
                        ActiveTabIndex="1" meta:resourcekey="TabContainer1Resource1">
                        <ajc:TabPanel ID="Sequencetab" runat="server" CssClass="dataheadergroup" HeaderText="SampleMaster"
                            meta:resourcekey="SequencetabResource1">
                                                    <HeaderTemplate>
                                                        Sample Master
                                                    </HeaderTemplate>
                                                    <ContentTemplate>
                                                        <asp:UpdatePanel ID="UpdatePanel" runat="server">
                                                            <ContentTemplate>
                                                                <table class="w-100p">
                                                                    <tr>
                                                                        <td>
                                            <asp:Label ID="lblSampleName" runat="server" Text="Sample Name" meta:resourcekey="lblSampleNameResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                            <asp:TextBox ID="txtSampleName" runat="server" CssClass="Txtboxmedium" Width="150px"
                                                meta:resourcekey="txtSampleNameResource1"></asp:TextBox>
                                                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                           <asp:CheckBox ID="chkBox2"  Text = "IsSpecialSample" runat="server" meta:resourcekey="chkBoxResource3" Font-Bold="true"  />                         
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                            <asp:Label ID="lblSampleCode" runat="server" Text="Sample Code" meta:resourcekey="lblSampleCodeResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                            <asp:TextBox ID="txtSampleCode" onchange="javascript:ValidateCode('SAMPLE');" runat="server"
                                                CssClass="Txtboxmedium w-50" meta:resourcekey="txtSampleCodeResource1"></asp:TextBox>
                                            <asp:Button ID="btnSaveSample" runat="server" Text="Save" onmouseout="this.className='btn1'"
                                                onmouseover="this.className='btn1 btnhov'" CssClass="btn1 w-50" OnClientClick="javascript:return ValidateSample();"
                                                OnClick="btnSaveSample_Click" meta:resourcekey="btnSaveSampleResource1" />
                                            <button name="btnClear" class="btn1" onmouseout="this.className='btn1'"
                                                onmouseover="this.className='btn1 btnhov'" id="btnClear"  onclick="ClearValues('Sample');" >
                                                <%=Resources.Investigation_ClientDisplay.Investigation_ContainerMaster_aspx_01 %></button>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <br />
                                                                <div id="divSample" runat="server" class="h-400" style="overflow: scroll;display: block">
                                                                    <asp:GridView ID="grdSample" EmptyDataText="No matching records found " runat="server"
                                                                        AutoGenerateColumns="False" ForeColor="#333333" CellPadding="3" OnRowCommand="grdSample_RowCommand"
                                                                        ShowFooter="True" OnRowEditing="grdSample_RowEditing" OnRowUpdating="grdSample_RowUpdating"
                                                                        OnRowCancelingEdit="grdSample_RowCancelingEdit" AutoGenerateEditButton="True" 
                                        CssClass="gridView w-90p" meta:resourcekey="grdSampleResource1">
                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                        <Columns>
                                            <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                                                                <ItemTemplate>
                                                    <asp:Label ID="lblNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>' meta:resourcekey="lblNoResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Sample ID" Visible="False" meta:resourcekey="TemplateFieldResource2">
                                                                                <ItemTemplate>
                                                    <asp:Label ID="lblSampleID" runat="server" Text='<%# Bind("SampleCode") %>' meta:resourcekey="lblSampleIDResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Sample Name" meta:resourcekey="TemplateFieldResource3">
                                                                                <ItemTemplate>
                                                    <asp:Label ID="lblSampleName" runat="server" Text='<%# Bind("SampleDesc") %>' meta:resourcekey="lblSampleNameResource2"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TxtSample" runat="server" Text='<%# Bind("SampleDesc") %>' meta:resourcekey="TxtSampleResource1"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Code" meta:resourcekey="TemplateFieldResource4">
                                                                                <ItemTemplate>
                                                    <asp:Label ID="lblSampleCode" runat="server" Text='<%# Bind("Code") %>' meta:resourcekey="lblSampleCodeResource2"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TxtCode" runat="server" Text='<%# Bind("Code") %>' meta:resourcekey="TxtCodeResource1"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Active" meta:resourcekey="TemplateFieldResource5">
                                                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblActive" Text='<%# System.Text.RegularExpressions.Regex.Split( Eval("Active").ToString(),",")[0] =="Y" ? "Active" : "InActive" %>'
                                                        meta:resourcekey="lblActiveResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                    <asp:CheckBox ID="chkBox" Checked='<%#System.Text.RegularExpressions.Regex.Split( Eval("Active").ToString(),",")[0]== "Y" ? true : false %>'
                                                        runat="server" meta:resourcekey="chkBoxResource1" />
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                           <asp:TemplateField HeaderText="SpecialSample" meta:resourcekey="TemplateFieldResource12">
                                                                                <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblspclsample" Text='<%# System.Text.RegularExpressions.Regex.Split( Eval("Active").ToString(),",")[1] =="Y" ? "Yes" : "No" %>'
                                                                meta:resourcekey="lblspclsample"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                            <asp:CheckBox ID="chkBox1" Checked='<%#System.Text.RegularExpressions.Regex.Split( Eval("Active").ToString(),",")[1] == "Y" ? true : false %>'
                                                                runat="server" meta:resourcekey="chkBoxResource2" />
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </div>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </ContentTemplate>
                                                </ajc:TabPanel>
                        <ajc:TabPanel ID="TabPanel2" runat="server" CssClass="dataheadergroup" HeaderText="InvestigationSampleContainer"
                            meta:resourcekey="TabPanel2Resource1">
                                                    <HeaderTemplate>
                                                        Investigation Sample Container
                                                    </HeaderTemplate>
                                                    <ContentTemplate>
                                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                            <ContentTemplate>
                                                                <table class="w-100p">
                                                                    <tr>
                                                                        <td>
                                                    <asp:Label ID="lblContainerName" runat="server" Text="Container Name" meta:resourcekey="lblContainerNameResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                    <asp:TextBox ID="txtContainer" runat="server" CssClass="Txtboxmedium" Width="150px"
                                                        meta:resourcekey="txtContainerResource1"></asp:TextBox>
                                                                            <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                    <asp:Label ID="lblContainerDesc" runat="server" Text="Container Description" meta:resourcekey="lblContainerDescResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                    <asp:TextBox ID="txtContainerDesc" runat="server" CssClass="Txtboxmedium" Width="150px"
                                                        meta:resourcekey="txtContainerDescResource1"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                    <asp:Label ID="lblContainerCode" runat="server" Text="Container Code" meta:resourcekey="lblContainerCodeResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                    <asp:TextBox ID="txtContainerCode" runat="server" onchange="javascript:ValidateCode('CONTAINER');"
                                                        CssClass="Txtboxmedium w-50" meta:resourcekey="txtContainerCodeResource1"></asp:TextBox>
                                                    <asp:Button ID="btnSaveContainer" runat="server" Text="Save" onmouseout="this.className='btn1'"
                                                        onmouseover="this.className='btn1 btnhov'" CssClass="btn w-50" OnClientClick="javascript:return ValidateContainer();"
                                                        OnClick="btnSaveContainer_Click" meta:resourcekey="btnSaveContainerResource1" />
                                                    <button name="btnClear" class="btn" onmouseout="this.className='btn1'"
                                                        onmouseover="this.className='btn1 btnhov'" id="btnClearContainer" 
                                                        onclick="ClearValues('Container');" ><%=Resources.Investigation_ClientDisplay.Investigation_ContainerMaster_aspx_01%></button>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <br />
                                                                <div id="div1" runat="server" class="h-400" style="overflow: scroll;display: block">
                                                                    <asp:GridView ID="grdSampleContainer" EmptyDataText="No matching records found "
                                                                        runat="server" AutoGenerateColumns="False" ForeColor="#333333" CellPadding="3"
                                                                        OnRowCommand="grdSampleContainer_RowCommand" ShowFooter="True" OnRowEditing="grdSampleContainer_RowEditing"
                                                                        OnRowUpdating="grdSampleContainer_RowUpdating" OnRowCancelingEdit="grdSampleContainer_RowCancelingEdit"
                                                AutoGenerateEditButton="True" CssClass="gridView w-90p" meta:resourcekey="grdSampleContainerResource1">
                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                        <Columns>
                                                    <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource6">
                                                                                <ItemTemplate>
                                                            <asp:Label ID="lblNo" runat="server" Text='<%# Container.DataItemIndex + 1 %>' meta:resourcekey="lblNoResource2"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField Visible="false" HeaderText="SampleContainerID" meta:resourcekey="TemplateFieldResource7">
                                                                                <ItemTemplate>
                                                            <asp:Label ID="lblContainerID" runat="server" Text='<%# Eval("SampleContainerID") %>'
                                                                meta:resourcekey="lblContainerIDResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Container Name" meta:resourcekey="TemplateFieldResource8">
                                                                                <ItemTemplate>
                                                            <asp:Label ID="lblContainerName" runat="server" Text='<%# Eval("ContainerName") %>'
                                                                meta:resourcekey="lblContainerNameResource2"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                            <asp:TextBox ID="txtContainerName" runat="server" Text='<%# Bind("ContainerName") %>'
                                                                meta:resourcekey="txtContainerNameResource1"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Container Code" meta:resourcekey="TemplateFieldResource9">
                                                                                <ItemTemplate>
                                                            <asp:Label ID="lblContainerCode" runat="server" Text='<%# Eval("Code").ToString()==""? "N/A" : Eval("Code") %>'
                                                                meta:resourcekey="lblContainerCodeResource2"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                            <asp:TextBox ID="txtContainerCode" runat="server" Text='<%# Bind("Code") %>' meta:resourcekey="txtContainerCodeResource2"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                                <ItemStyle CssClass="w-55"/>
                                                                            </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource10">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description").ToString()==""? "N/A" : Eval("Description") %>'
                                                                meta:resourcekey="lblDescriptionResource1"></asp:Label>
                                                        </ItemTemplate>
                                                                                <EditItemTemplate>
                                                            <asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("Description") %>'
                                                                meta:resourcekey="txtDescriptionResource1"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Active" meta:resourcekey="TemplateFieldResource11">
                                                                                <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblActive" Text='<%# Eval("Active").ToString() =="Y" ? "Active" : "InActive" %>'
                                                                meta:resourcekey="lblActiveResource2"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                            <asp:CheckBox ID="chkBox" Checked='<%# Eval("Active").ToString() == "Y" ? true : false %>'
                                                                runat="server" meta:resourcekey="chkBoxResource2" />
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </div>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </ContentTemplate>
                                                </ajc:TabPanel>
                                            </ajc:TabContainer>
                                            <asp:HiddenField ID="hdnSampleID" runat="server" Value="0" />
                                            <asp:HiddenField ID="hdnContainerID" runat="server" Value="0" />
                                            <asp:HiddenField ID="hdnSapmleCode" runat="server" Value="0" />
                                            <asp:HiddenField ID="hdnContainerCode" runat="server" Value="0" />
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </div>                
   <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
