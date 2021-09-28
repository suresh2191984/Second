<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DeviceIntegrationMapping.aspx.cs" Inherits="Admin_DeviceIntegrationMapping" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%--DeviceIntegration Mapping--%><%=Resources.Admin_AppMsg.Admin_DeviceIntegrationMapping_aspx_01%> 
</title>
   
 <script type="text/javascript">
        function Drpchange() {
            if (document.getElementById('DrpFormula').options[document.getElementById('DrpFormula').selectedIndex].innerHTML != '') {
               
                var e = document.getElementById('DrpFormula');
                var hdnInvID = document.getElementById('hdnTestID').value;
                var formula = e.options[e.selectedIndex].value;
                if (hdnInvID != 0) {
                    var finalformula = formula.replace("InvID", hdnInvID)
                    document.getElementById('txtFormula').value = finalformula;
                }
                else {
                    alert("Please choose investigation name");
                    document.getElementById('DrpFormula').selectedIndex = 0;
                    
                }
            }
        }
    
function SelectedTest(source, eventArgs) {
    document.getElementById('TxtInvName').value = eventArgs.get_text();
            TestDetails = eventArgs.get_value();
            var TestName = TestDetails.split('~')[0];
            var TestID = TestDetails.split('~')[1];           
            document.getElementById('hdnTestID').value = TestID;
           // document.getElementById('hdnTestType').value = TestType;
        }
        function setAceWidth(source, eventArgs) {
            document.getElementById('aceDiv').style.width = 'auto';
        }


        function isSpclChar(e) {
            var key;
            var isCtrl = false;

            if (window.event) // IE8 and earlier
            {
                key = e.keyCode;
            }
            else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
            {
                key = e.which;
            }

            if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32)) {
                isCtrl = true;
            }

            return isCtrl;
        }

        


        function ChkValidation() {
            //debugger;
            var userMsg = SListForAppMsg.Get("Admin_DeviceIntegrationMapping_aspx_02") != null ? SListForAppMsg.Get("Admin_DeviceIntegrationMapping_aspx_02") : "Select Instrument Name";
            var Information = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg1 = SListForAppMsg.Get("Admin_DeviceIntegrationMapping_aspx_03") != null ? SListForAppMsg.Get("Admin_DeviceIntegrationMapping_aspx_03") : "Enter Device Code";
            var userMsg2 = SListForAppMsg.Get("Admin_DeviceIntegrationMapping_aspx_04") != null ? SListForAppMsg.Get("Admin_DeviceIntegrationMapping_aspx_04") : "Enter Test Code";
            var userMsg3 = SListForAppMsg.Get("Admin_DeviceIntegrationMapping_aspx_05") != null ? SListForAppMsg.Get("Admin_DeviceIntegrationMapping_aspx_05") : "Enter Investigation Name";
            if (document.getElementById('DrpInstrumentName').options[document.getElementById('DrpInstrumentName').selectedIndex].value == 'Select') {
                //alert('Select Instrument Name');
                ValidationWindow(userMsg, Information);
                document.getElementById('DrpInstrumentName').focus();
                return false;
            }
            var TxtDeviceId = document.getElementById('TxtDeviceId').value;
            if (TxtDeviceId == '') {
                //alert('Enter Device Code');
                ValidationWindow(userMsg1, Information);
                document.getElementById('TxtDeviceId').focus();
                return false;
            }

            var TxtTestCode = document.getElementById('TxtTestCode').value;
            if (TxtTestCode == '') {
                // alert('Enter Test Code');
                ValidationWindow(userMsg2, Information);
                document.getElementById('TxtTestCode').focus();
                return false;
            }

            var TxtInvName = document.getElementById('TxtInvName').value;
            if (TxtInvName == '') {
                //alert('Enter Investigation Name');
                ValidationWindow(userMsg3, Information);
                document.getElementById('TxtInvName').focus();
                return false;
            }
            var dispalrt = SListForAppMsg.Get("Admin_DeviceIntegrationMapping_aspx_001") != null ? SListForAppMsg.Get("Admin_DeviceIntegrationMapping_aspx_001") : "Select Investigation From The list";
            var testid = document.getElementById('hdnTestID').value;
            if (testid == null || testid == '' || testid == 0) {
                // alert('Select Investigation From The list');
                ValidationWindow(dispalrt, Information);
                document.getElementById('<%= TxtInvName.ClientID %>').value = "";


                document.getElementById('TxtInvName').focus();
                return false;
            }
           
            
            return true; 
            
        }

        function Clearcode() {
            document.getElementById('TxtDeviceId').value = "";
        }
  
    </script>
   <style> 
   #TabsMenu.deviceTabs {float:none; overflow:hidden; }
   </style> 
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
                                            <div id="progressBackgroundFilter">
                                            </div>
                                            <div align="center" id="processMessage" width="60%">
                                                <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" 
                                                    meta:resourcekey="Rs_PleasewaitResource1" />
                                                <br />
                                                <br />
                                                <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" 
                                                    meta:resourcekey="imgProgressbarResource1" />
                                            </div>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                <div id="TabsMenu" class="TabsMenu deviceTabs">
                                    <ul id="ulTabsMenu">
                                        <li id="tabDeviceMapping">
                                            <a href="../Admin/DeviceIntegrationMapping.aspx">
                                                <asp:Label ID="lblDeviceMappingtab" runat="server" Text="Device Mapping" 
                                                meta:resourcekey="lblDeviceMappingtabResource1" /></a></li>
                                    </ul>
                                </div>
                                <asp:UpdatePanel ID="updatePanel2" runat="server">
                                    <ContentTemplate>
                                        
                                        <table class="w-50p searchPanel b-tab" cellpadding="3" cellspacing="3" border="1">
                                            <tr>
                                                <td colspan="3">
                                                    <table class="w-100p SearchPanel" border="0" cellpadding="2" cellspacing="2" id="tableDeviceMapping">
                                                        <tr>
                                                            <td class="a-left">
                                                                <asp:Label ID="lblInstrumentName" runat="server" Text="Instrument Name" 
                                                                    meta:resourcekey="lblInstrumentNameResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:DropDownList ID="DrpInstrumentName" class="ddlsmall" 
                                                                    onChange="Clearcode();" runat="server" 
                                                                    TabIndex="1" meta:resourcekey="DrpInstrumentNameResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td> 
                                                            <asp:Button ID="btnSearch" runat="server" Text="Search" class="btn" TabIndex="2" 
                                                                    onclick="btnSearch_Click" meta:resourcekey="btnSearchResource1"  />
                                                            </td>
                                                           
                                                        </tr>
                                                        <tr>
                                                         <td class="a-left">
                                                            <asp:Label ID="lblDevice" runat="server" Text="Device Code" 
                                                                 meta:resourcekey="lblDeviceResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" colspan="2">
                                                            <asp:TextBox ID="TxtDeviceId" class="small" runat="server" 
                                                                     TabIndex="3" meta:resourcekey="TxtDeviceIdResource1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        
                                                        <tr>
                                                         <td align="left">
                                                            <asp:Label ID="lblTestcode" runat="server" Text="Test Code" 
                                                                 meta:resourcekey="lblTestcodeResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" colspan="2">
                                                            <asp:TextBox ID="TxtTestCode" class="small" runat="server"
                                                                    TabIndex="4" meta:resourcekey="TxtTestCodeResource1"></asp:TextBox>
                                                             <img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                        </tr>
                                                        
                                                        <tr>
                                                         <td align="left" width="31%">
                                                            <asp:Label ID="lblInvName" runat="server" Text="Investigation Name" 
                                                                 meta:resourcekey="lblInvNameResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" colspan="2">
                                                            <asp:TextBox ID="TxtInvName" class="small" runat="server"  
                                                                      OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  TabIndex="5" 
                                                                    meta:resourcekey="TxtInvNameResource1"></asp:TextBox>
                                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                    <div id="aceDiv" style="z-index:99999">
                                                                    </div>                                                                     
                                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtenderTestName"  MinimumPrefixLength="2"
                                                                    runat="server" TargetControlID="TxtInvName" ServiceMethod="GetInvestigationNameFromOrgMapping"
                                                                    ServicePath="~/WebService.asmx" EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" Enabled="True"
                                                                    OnClientItemSelected="SelectedTest" DelimiterCharacters="" CompletionListElementID="aceDiv" OnClientShown="setAceWidth">
                                                                </cc1:AutoCompleteExtender>
                                                                 <asp:HiddenField ID="hdnTestID" Value="0" runat="server"></asp:HiddenField>
                                                                
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                        <td align="left" width="31%">
                                                            <asp:Label ID="lblFormula" runat="server" Text="Formula" 
                                                                meta:resourcekey="lblFormulaResource1"></asp:Label>
                                                            </td>
                                                            <td align="left" colspan="2">
                                                <asp:DropDownList ID="DrpFormula" onchange="Drpchange()" class="ddlsmall" runat="server">
                                                </asp:DropDownList>
                                                <asp:TextBox ID="txtFormula" class="small" runat="server" 
                                                    TabIndex="5" meta:resourcekey="txtFormulaResource1" Enabled="true"></asp:TextBox>
                                                                   
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                        <td>
                                                         <asp:CheckBox ID="chkActive" runat="server" Text="IsActive" TabIndex="6"  
                                                                TextAlign="Left" meta:resourcekey="chkActiveResource1"
                                                                            />
                                                        </td>
                                                        <td colspan="2">
                                                         <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                                            ToolTip="Save As Excel" OnClick="imgBtnXL_Click" TabIndex="7" 
                                                                            Visible="False" Height="16px" 
                                                                meta:resourcekey="imgBtnXLResource1" />&nbsp;
                                                                               <asp:Label ID="lnkExportXL" Text="Export To XL" 
                                                                TabIndex="8" Visible="False" 
                                        runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel" meta:resourcekey="lnkExportXLResource1"
                                        ></asp:Label>
                                                        </td>
                                                        </tr>
                                                        <tr>
                                                        <td colspan="3"></td>
                                                        </tr>
                                                        <tr>
                                                        <td colspan="3"></td>
                                                        </tr>
                                                        <tr>
                                                        <td colspan="3" align="center">
                                                        <table width="30%">
                                                        <tr>
                                                        <td colspan="1">
                                                        <asp:Button ID="btnAdd" runat="server" class="btn" Text="Save" 
                                                                onclick="btnAdd_Click" OnClientClick="return ChkValidation()" 
                                                                TabIndex="9" meta:resourcekey="btnAddResource1" />
                                                        </td>
                                                      
                                                         <td align="left">
                                                        <asp:Button ID="btnCancel" runat="server" class="btn" Text="Cancel" 
                                                                 onclick="btnCancel_Click" TabIndex="10" 
                                                                 meta:resourcekey="btnCancelResource1" />
                                                        
                                                        </td>
                                                        </tr>
                                                        </table>
                                                         <asp:HiddenField ID="hdnValueID" Value="0" runat="server"></asp:HiddenField>
                                                           <asp:HiddenField ID="hdnDeviceMappingID" Value="0" runat="server"></asp:HiddenField>
                                                        </td>
                                                        
                                                        </tr>
                                                        
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                        
                                           <table class="w-100p" cellpadding="3" cellspacing="3">
                                                        <tr>
                                                            <td>
                                                                <div id="divGrid" runat="server" style="display: block">
                                                                    <asp:GridView ID="grdDevice" runat="server" CssClass="gridView w-100p" 
                                                                        ForeColor="Black"  CellPadding="4" 
                                                                        AutoGenerateColumns="false"                                                                       
                                                                        AllowPaging="True" onpageindexchanging="grdDevice_PageIndexChanging" 
                                                                        PageSize="25" onrowcommand="grdDevice_RowCommand" 
                                                                        DataKeyNames="InstrumentName,DeviceID,TestCode,InvestigationName,InvestigationID,DeviceMappingID,IsActive" 
                                                                        onrowdatabound="grdDevice_RowDataBound" 
                                                                        meta:resourcekey="grdDeviceResource1">
                                                                        <Columns>                                                                        
                                                                              
                                                                              <asp:TemplateField HeaderText="Device Name" SortExpression="DeviceName" 
                                                                                  Visible="true" meta:resourcekey="TemplateFieldResource1">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblDeviceName" runat="server" 
                                                                                        Text='<%# Bind("InstrumentName") %>' meta:resourcekey="lblDeviceNameResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtDeviceName" runat="server" 
                                                                                        Text='<%# Bind("InstrumentName") %>' meta:resourcekey="txtDeviceNameResource1"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            
                                                                            <asp:TemplateField HeaderText="InstrumentID" SortExpression="InstrumentID" 
                                                                                  Visible="false" meta:resourcekey="TemplateFieldResource2">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblInstrumentID" runat="server" 
                                                                                        Text='<%# Bind("InstrumentID") %>' meta:resourcekey="lblInstrumentIDResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtInstrumentID" runat="server" 
                                                                                        Text='<%# Bind("InstrumentID") %>' meta:resourcekey="txtInstrumentIDResource1"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            
                                                                            <asp:TemplateField HeaderText="DeviceMappingID" SortExpression="DeviceMappingID" 
                                                                                  Visible="false" meta:resourcekey="TemplateFieldResource3">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblDeviceMappingID" runat="server" 
                                                                                        Text='<%# Bind("DeviceMappingID") %>' 
                                                                                        meta:resourcekey="lblDeviceMappingIDResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtDeviceMappingID" runat="server" 
                                                                                        Text='<%# Bind("DeviceMappingID") %>' 
                                                                                        meta:resourcekey="txtDeviceMappingIDResource1"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                              
                                                                              <asp:TemplateField HeaderText="Device Code" SortExpression="DeviceCode" 
                                                                                  Visible="true" meta:resourcekey="TemplateFieldResource4">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblDeviceID" runat="server" Text='<%# Bind("DeviceID") %>' 
                                                                                        meta:resourcekey="lblDeviceIDResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtDeviceID" runat="server" Text='<%# Bind("DeviceID") %>' 
                                                                                        meta:resourcekey="txtDeviceIDResource2"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            
                                                                              <asp:TemplateField HeaderText="Test Code" SortExpression="TestCode" 
                                                                                  Visible="true" meta:resourcekey="TemplateFieldResource5">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblTestCode" runat="server" Text='<%# Bind("TestCode") %>' 
                                                                                        meta:resourcekey="lblTestCodeResource2"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtTestCode" runat="server" Text='<%# Bind("TestCode") %>' 
                                                                                        meta:resourcekey="txtTestCodeResource2"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            
                                                                            <asp:TemplateField HeaderText="Investigation Name" 
                                                                                  SortExpression="InvestigationName" Visible="true" 
                                                                                  meta:resourcekey="TemplateFieldResource6">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblInvestigationName" runat="server" 
                                                                                        Text='<%# Bind("InvestigationName") %>' 
                                                                                        meta:resourcekey="lblInvestigationNameResource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="txtInvestigationName" runat="server" 
                                                                                        Text='<%# Bind("InvestigationName") %>' 
                                                                                        meta:resourcekey="txtInvestigationNameResource1"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                                            
                                                                             <asp:TemplateField HeaderText="InvestigationID" SortExpression="InvestigationID" 
                                                                                  Visible="true" meta:resourcekey="TemplateFieldResource7">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblInvestigationID" runat="server" 
                                                                                        Text='<%# Bind("InvestigationID") %>' 
                                                                                        meta:resourcekey="lblInvestigationIDResource2"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="lblInvestigationID" runat="server" 
                                                                                        Text='<%# Bind("InvestigationID") %>' 
                                                                                        meta:resourcekey="lblInvestigationIDResource1"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>                                                                            
                                                                            <asp:TemplateField HeaderText="IsActive" SortExpression="IsActive" 
                                                                                  meta:resourcekey="TemplateFieldResource8">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("IsActive") %>' 
                                                                                        meta:resourcekey="Label7Resource1"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <EditItemTemplate>
                                                                                    <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("IsActive") %>' 
                                                                                        meta:resourcekey="TextBox7Resource1"></asp:TextBox>
                                                                                </EditItemTemplate>
                                                                            </asp:TemplateField>
                                                 <asp:TemplateField HeaderText="Formula" SortExpression="Formula" meta:resourcekey="TemplateFieldResource11">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDeviceFormula" runat="server" Text='<%# Bind("Formula") %>' meta:resourcekey="Label7Resource2"></asp:Label>
                                                    </ItemTemplate>
                                                    
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtDeviceFormula" runat="server" Text='<%# Bind("Formula") %>' meta:resourcekey="TextBox7Resource2"></asp:TextBox>
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource9">
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="btnEdit" CommandName="DeviceEdit" CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                                                                                        runat="server" Text="Edit" ForeColor="Blue" Font-Underline="True" Font-Size="12px"
                                                                                        Font-Bold="True" meta:resourcekey="btnEditResource1"/>                                                                                    
                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                                <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                        <HeaderStyle CssClass="colorforcontent" ForeColor="White" />
                                                                        <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Black" />
                                                                    </asp:GridView>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                    </ContentTemplate> 
                                    <Triggers>
                                            <asp:PostBackTrigger ControlID="imgBtnXL" />
                                        </Triggers>                                 
                                </asp:UpdatePanel>
                                
                                
                                
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
           <Attune:Attunefooter ID="Attunefooter" runat="server" />     
    </form>
</body>
</html>
