<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Tasks.ascx.cs" Inherits="PlatFormControls_Tasks" %>
<style type="text/css">
    .style1
    {
        height: 25px;
    }
    .Pointer
    {cursor: pointer;
    }
</style>

<asp:UpdatePanel ID="ctlTaskUpdPnl" runat="server">
    <ContentTemplate>
        <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="ctlTaskUpdPnl" runat="server">
            <ProgressTemplate>
                <div id="progressBackgroundFilter">
                </div>
                <div class="a-center" id="processMessage" width="60%">
                    <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server"  meta:resourcekey="Rs_PleasewaitResource1"/>
                    <br />
                    <br />
                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/PlatForm/Images/working.gif" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>

        <script type="text/javascript" language="javascript">
            var userName = '';
            
            function getPatientName() {
                if (document.getElementById('<%= hdntxttext.ClientID %>').value.trim() != "") {
                    document.getElementById('<%= hdntxttext.ClientID %>').value = document.getElementById('txttext').value;
                }
                else {
                    document.getElementById('<%= hdntxttext.ClientID %>').value = "";
                }
            }

            function alertMesage() {
                var userMsg = SListForAppMsg.Get('PlatFormControls_Tasks_ascx_01');
                if (userMsg == null) {
                    userMsg = 'This Task will be deleted. Continue?';
                }
                var Confirm = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_02');
                if (Confirm == null) {
                    Confirm = 'Confirm';
                }
                var OkMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_03');
                if (OkMsg == null) {
                    OkMsg = 'Ok';
                }
                var CancelMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_04');
                if (CancelMsg == null) {
                    CancelMsg = 'Cancel';
                }
                if (ConfirmWindow(userMsg,Confirm,OkMsg,CancelMsg)) {                   
                    return true;
                }
                else {                  
                    return false;
                }
            }
            function ShowSMSAlert(flag) {
                if (flag == 0) {
                    var userMsg = SListForAppMsg.Get('PlatFormControls_Tasks_ascx_02') == null ? "SMS Send to the Patient Successfully." : SListForAppMsg.Get('PlatFormControls_Tasks_ascx_02');

                    ValidationWindow(userMsg, informMsg);

                }
                else {
                    var userMsg = SListForAppMsg.Get('PlatFormControls_Tasks_ascx_04') == null ? "There was problem in Sending SMS." : SListForAppMsg.Get('PlatFormControls_Tasks_ascx_04');
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }

            }
            function Click() {              
                javascript: __doPostBack('uctlTaskList$grdTasks', 'Select$0');
               
            }
            function checkForValues() {

                if (document.getElementById('<%= txtpageNo.ClientID %>').value == "") {
                    var userMsg = SListForAppMsg.Get('PlatFormControls_Tasks_ascx_05') == null ? "Provide page number" : SListForAppMsg.Get('PlatFormControls_Tasks_ascx_05');

                    ValidationWindow(userMsg, errorMsg);

                    return false;
                }

                if (Number(document.getElementById('<%= txtpageNo.ClientID %>').value) < Number(1)) {
                    var userMsg = SListForAppMsg.Get('PlatFormControls_Tasks_ascx_06') == null ? "Provide correct page number" : SListForAppMsg.Get('PlatFormControls_Tasks_ascx_06');
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }

                if (Number(document.getElementById('<%= txtpageNo.ClientID %>').value) > Number(document.getElementById('<%= lblTotal.ClientID %>').innerText)) {
                    var userMsg = SListForAppMsg.Get('PlatFormControls_Tasks_ascx_06') == null ? "Provide correct page number" : SListForAppMsg.Get('PlatFormControls_Tasks_ascx_06');

                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }

            }
            function fnConfirm(url, hdnTID) {
                $('#<%= hdnModalTaskID.ClientID %>').val(hdnTID);
                var userMsg = SListForAppMsg.Get('PlatFormControls_Tasks_ascx_19') == null ? "Do you want to proceed for referral booking?" : SListForAppMsg.Get('PlatFormControls_Tasks_ascx_19');
                var i = confirm(userMsg);
                if (i == true) {
                    window.location = url;
                    return false;
                }
                else {
                    var mPopup = $find('<%= mdlApprovalpop.ClientID %>');
                    mPopup.show();
                    return false;
                }
            }
            function fnchkReason() {
                var userMsg = SListForAppMsg.Get('PlatFormControls_Tasks_ascx_20') == null ? "Enter the reason for cancel" : SListForAppMsg.Get('PlatFormControls_Tasks_ascx_20');
                var errorMsg = SListForAppMsg.Get('PlatFormControls_Error') == null ? "Alert" : SListForAppMsg.Get('PlatFormControls_Error');
                var reason = $('#<%= txtReason.ClientID %>').val();
                if (reason == null || reason == undefined || reason == "") {
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
                return true;
            }
        </script>

        <script type="text/javascript">

            var datadiv_tooltip = false;
            var datadiv_tooltipShadow = false;
            var datadiv_shadowSize = 4;
            var datadiv_tooltipMaxWidth = 200;
            var datadiv_tooltipMinWidth = 100;
            var datadiv_iframe = false;
            var tooltip_is_msie = (navigator.userAgent.indexOf('MSIE') >= 0 && navigator.userAgent.indexOf('opera') == -1 && document.all) ? true : false;
            function showTooltip(e, tooltipTxt) {

                var bodyWidth = Math.max(document.body.clientWidth, document.documentElement.clientWidth) - 20;

                if (!datadiv_tooltip) {
                    datadiv_tooltip = document.createElement('DIV');
                    datadiv_tooltip.id = 'datadiv_tooltip';
                    datadiv_tooltipShadow = document.createElement('DIV');
                    datadiv_tooltipShadow.id = 'datadiv_tooltipShadow';

                    document.body.appendChild(datadiv_tooltip);
                    document.body.appendChild(datadiv_tooltipShadow);

                    if (tooltip_is_msie) {
                        datadiv_iframe = document.createElement('IFRAME');
                        datadiv_iframe.frameborder = '5';
                        datadiv_iframe.style.backgroundColor = '#FFFFFF';
                        datadiv_iframe.src = '#';
                        datadiv_iframe.style.zIndex = 100;
                        datadiv_iframe.style.position = 'absolute';
                        document.body.appendChild(datadiv_iframe);
                    }

                }

                datadiv_tooltip.style.display = 'block';
                datadiv_tooltipShadow.style.display = 'block';
                if (tooltip_is_msie) datadiv_iframe.style.display = 'block';

                var st = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
                if (navigator.userAgent.toLowerCase().indexOf('safari') >= 0) st = 0;
                var leftPos = e.clientX + 10;

                datadiv_tooltip.style.width = null; // Reset style width if it's set 
                datadiv_tooltip.innerHTML = tooltipTxt;
                datadiv_tooltip.style.left = leftPos + 'px';
                datadiv_tooltip.style.top = e.clientY + 10 + st + 'px';


                datadiv_tooltipShadow.style.left = leftPos + datadiv_shadowSize + 'px';
                datadiv_tooltipShadow.style.top = e.clientY + 10 + st + datadiv_shadowSize + 'px';

                if (datadiv_tooltip.offsetWidth > datadiv_tooltipMaxWidth) {	/* Exceeding max width of tooltip ? */
                    datadiv_tooltip.style.width = datadiv_tooltipMaxWidth + 'px';
                }

                var tooltipWidth = datadiv_tooltip.offsetWidth;
                if (tooltipWidth < datadiv_tooltipMinWidth) tooltipWidth = datadiv_tooltipMinWidth;


                datadiv_tooltip.style.width = tooltipWidth + 'px';
                datadiv_tooltipShadow.style.width = datadiv_tooltip.offsetWidth + 'px';
                datadiv_tooltipShadow.style.height = datadiv_tooltip.offsetHeight + 'px';

                if ((leftPos + tooltipWidth) > bodyWidth) {
                    datadiv_tooltip.style.left = (datadiv_tooltipShadow.style.left.replace('px', '') - ((leftPos + tooltipWidth) - bodyWidth)) + 'px';
                    datadiv_tooltipShadow.style.left = (datadiv_tooltipShadow.style.left.replace('px', '') - ((leftPos + tooltipWidth) - bodyWidth) + datadiv_shadowSize) + 'px';
                }

                if (tooltip_is_msie) {
                    datadiv_iframe.style.left = datadiv_tooltip.style.left;
                    datadiv_iframe.style.top = datadiv_tooltip.style.top;
                    datadiv_iframe.style.width = datadiv_tooltip.offsetWidth + 'px';
                    datadiv_iframe.style.height = datadiv_tooltip.offsetHeight + 'px';

                }

            }

            function hideTooltip() {
                datadiv_tooltip.style.display = 'none';
                datadiv_tooltipShadow.style.display = 'none';
                if (tooltip_is_msie) datadiv_iframe.style.display = 'none';
            }
            function SelectPatientList(source, eventArgs) {
                var txtValue = eventArgs.get_text().split('-')[0];
                document.getElementById('<%= txttext.ClientID %>').value = txtValue;
            }
        </script>

        <table class="w-100p">
            <tr>
                <td>
                    <asp:Panel ID="pnlFilter" runat="server" CssClass="w-100p" meta:resourcekey="pnlFilterResource1">
                        <div class="w-97p marginauto card-md card-md-default padding10 ">
                            <table class="w-100p ">
                                <tr class="">
                                    <td class="">
                                        <table class="w-100p">
                                            <tr>
                                                <td nowrap="nowrap" class="w-75p">
                                                        <table class="w-100p">
                                                        <tr>
                                                            <td class="w-16p">
                                                                <asp:Label ID="lblpatientNameNO" Text="Patient Name / UHID" runat="server" CssClass="bold marginR30" meta:resourcekey="lblpatientNameNOResource1" />
                                                        
                                                                <asp:TextBox ID="txttext" CssClass="medium"  runat="server" onkeypress="return ValidateMultiLangChar(this);" meta:resourcekey="txttextResource1" />
                                                                <ajc:AutoCompleteExtender ID="AutoCompletePatientName" runat="server" TargetControlID="txttext"
                                                                    EnableCaching="False" FirstRowSelected="True" MinimumPrefixLength="2" CompletionListCssClass="wordWheel listMain box"
                                                                    CompletionListItemCssClass="listitemtwo" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                    OnClientItemSelected="SelectPatientList" ServiceMethod="GetPatientListWithDetails"
                                                                    ServicePath="~/PlatForm/CommonWebServices/CommonServices.asmx" DelimiterCharacters="" Enabled="True">
                                                                </ajc:AutoCompleteExtender>
                                                            </td>
                                                            <td class="hide">
                                                                <asp:Label ID="lblLabNumer" Text="Lab Number" runat="server" meta:resourcekey="lblLabNumer" />
                                                            </td>
                                                            <td class="hide">
                                                                <asp:TextBox ID="txtLabNumer" CssClass="small" runat="server" onKeyPress="return ValidateMultiLangCharacter(this) && return ValidateOnlyNumeric(this)" />
                                                            </td>
                                                            <td>
                                                                <asp:Button runat="server" ID="btn_Go" Text="Go" CssClass="btn marginL30" OnClick="btn_Go_Click"
                                                                    meta:resourcekey="btn_GoResource1" />
                                                            </td>
                                                            <td>
                                                                <asp:CheckBox ID="rdnLabNo" Text="Lab Number" runat="server" Visible="False" meta:resourcekey="rdnLabNoResource1" />
                                                                <asp:CheckBox ID="ChkBoxServiceNum" Text="Sevice Number" runat="server" class="hide" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <%-- </asp:Panel>--%>
                                                </td>
                                                <td class="a-right w-25p">
                                                    <div id="ACX2plus1" class="show filterText">
                                                        <span class="dataheader1txt" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);">
                                                            <asp:Label ID="Rs_FilterResult1" CssClass="bold" runat="server" Text="Filter Result" meta:resourcekey="Rs_FilterResult1Resource1"></asp:Label></span>
                                                        <img src="../PlatForm/Images/showBids.gif" alt="Show" class="v-top cursor" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);" />
                                                    </div>
                                                    <div id="ACX2minus1" class="hide filterText">
                                                        <span class="dataheader1txt" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);">
                                                            <asp:Label ID="Rs_FilterResult2" CssClass="bold" runat="server" Text="Filter Result" meta:resourcekey="Rs_FilterResult1Resource1"></asp:Label></span>
                                                        <img src="../PlatForm/Images/hideBids.gif" alt="hide" class="v-top cursor" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);" />
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr class="tablerow panelContent hide" id="ACX2responses1">
                                    <td>
                                        <div class="filterdataheader2">
                                            <table class=" lh25 w-100p">
                                            
                                                <tr class="">
                                                    <td>
                                                        <asp:Label ID="Rs_SpecialityDepartment" CssClass="bold" runat="server" Text="Speciality" meta:resourcekey="Rs_SpecialityDepartmentResource4"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList CssClass="small" runat="server" ID="ddSPE" OnSelectedIndexChanged="ddSPE_SelectedIndexChanged"
                                                            meta:resourcekey="ddSPEResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_Department" runat="server" CssClass="bold" Text="Department" meta:resourcekey="Rs_DepartmentResource3"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlDept" CssClass="small" OnSelectedIndexChanged="ddlDept_SelectedIndexChanged"
                                                            meta:resourcekey="ddlDeptResource3">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_Category" runat="server" CssClass="bold" Text="Category" meta:resourcekey="Rs_CategoryResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList CssClass="small" runat="server" ID="ddCat" OnSelectedIndexChanged="ddCat_SelectedIndexChanged"
                                                            meta:resourcekey="ddCatResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td  class="a-left lh35">
                                                        <asp:CheckBox ID="chkSetDefault" runat="server" CssClass="bold" Text="Set Default" OnCheckedChanged="Check_Clicked"  meta:resourcekey="chkSetDefaultResource1" />&nbsp;&nbsp;&nbsp;
                                                    </td>
                                                    <td >
                                                        <table class="hide w-100p" id="trTimedSamples" runat="server">
                                                            <tr>
                                                                <td>
                                                                    <asp:CheckBox ID="chkTimedSamples" Text="Timed Samples" runat="server" Style="background-color: blanchedAlmond;"
                                                                        OnCheckedChanged="Check_Clicked" AutoPostBack="True" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>  
                                                    <td>
                                                        <asp:Label ID="Rs_Location" runat="server" CssClass="bold" Text="Location" meta:resourcekey="Rs_LocationResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList CssClass="small" runat="server" ID="ddLO" OnSelectedIndexChanged="ddLO_SelectedIndexChanged"
                                                            meta:resourcekey="ddLOResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_TaskDate" runat="server" CssClass="bold" Text="TaskDate" meta:resourcekey="Rs_TaskDateResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList CssClass="small" runat="server" ID="ddTD" OnSelectedIndexChanged="ddTD_SelectedIndexChanged"
                                                            meta:resourcekey="ddTDResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_PatientType" runat="server" CssClass="bold" Text="PatientType" meta:resourcekey="Rs_PatientTypeResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList CssClass="small" runat="server" ID="ddlpatienttype" meta:resourcekey="ddlpatienttypeResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td  class="a-left">
                                                        <asp:LinkButton ID="lnkSetDefault" Text=" Show Task" CssClass="btn" Width="72px"
                                                             runat="server" OnClick="lnkSetDefault_Click" meta:resourcekey="lnkSetDefaultResource1" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                
                                                     <td class="hide">
                                                        <asp:Label ID="lblPreference" Text="Preference" runat="server" CssClass="bold" meta:resourcekey="lblPreference"></asp:Label>
                                                    </td>
                                                    <td class="hide">
                                                        <asp:DropDownList ID="ddlPriority" CssClass="small" runat="server">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </asp:Panel>
                </td>
            </tr>
            <tr class="hide">
                <td>
                    <table class="w-100p">
                        <tr>
                            <td class="v-middle">
                                <asp:Label ID="lblResult1" runat="server" meta:resourcekey="lblResult1Resource1"></asp:Label>
                            </td>
                            <td class="v-middle">
                                <asp:LinkButton ID="btnRefresh" CssClass="refreshbtn" ToolTip="Click here to refresh task list"
                                    runat="server" OnClick="btnRefresh_Click" meta:resourcekey="btnRefreshResource4" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="hide">
                <td>
                    <table border="0" class="w-100p">
                        <tr>
                            <td class="v-middle displaytd">
                                <div class="ui-state-highlight ui-corner-all padding5" runat="server" style="display: inline-block;">
                                    <asp:Label CssClass="ui-icon ui-icon-alert pull-left" runat="server" Style="margin-right: .3em;"></asp:Label>
                                    <asp:Label ID="lblResult" runat="server" CssClass=" pull-left" meta:resourcekey="lblResultResource1">
                                        <asp:Label ID="Rs_Re" runat="server" Text="Re" meta:resourcekey="Rs_ReResource1"></asp:Label>
                                    </asp:Label>
                                </div>
                            </td>
                            <td class="v-middle">
                                <asp:LinkButton ID="btnRefresh1" Text="Refresh" CssClass="ui-icon ui-icon-refresh pointer"
                                    runat="server" ToolTip="Click here to refresh task list" OnClick="btnRefresh1_Click"
                                    meta:resourcekey="btnRefresh1Resource4" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="marginauto w-99p">
                        <asp:GridView ID="grdTasks" CssClass="w-100p gridView marginT10" runat="server" AllowPaging="True"
                        RowStyle-CssClass="Pointer" AutoGenerateColumns="False" DataKeyNames="PatientID,TaskID,RedirectURL,PatientVisitID,RoleName,Category,HighlightColor,CreatedName,OrgID,RefernceID,CategoryText,TaskType,TaskStatusID,SpecialityID,AssignedTo,VisitConsID,TaskActionID"
                        OnRowDataBound="grdTasks_RowDataBound" OnRowCommand="grdTasks_RowCommand" ForeColor="#333333"
                        OnPageIndexChanging="grdTasks_PageIndexChanging" meta:resourcekey="grdTasksResource1">
                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <HeaderStyle CssClass="dataheader1" />
                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                            PageButtonCount="5" PreviousPageText="" />
                        <Columns>
                            <asp:BoundField Visible="False" DataField="RoleName" HeaderText="RoleName" meta:resourcekey="BoundFieldResource1" />
                            <asp:BoundField Visible="False" DataField="PatientID" HeaderText="PatientID" meta:resourcekey="BoundFieldResource2" />
                            <asp:BoundField Visible="False" DataField="TaskID" HeaderText="TaskID" meta:resourcekey="BoundFieldResource3" />
                            <asp:BoundField Visible="False" DataField="RedirectURL" HeaderText="URL" meta:resourcekey="BoundFieldResource4" />
                            <asp:BoundField Visible="False" DataField="PatientVisitID" HeaderText="VisitID" meta:resourcekey="BoundFieldResource5" />
                             
                            <asp:BoundField DataField="TaskDescription" HeaderText="Task Details" meta:resourcekey="BoundFieldResource6">
                                <ControlStyle Width="660px" />
                            </asp:BoundField>
                             <asp:TemplateField HeaderText="Task Date"  meta:resourcekey="BoundFieldResource7">
                                  <ItemTemplate>
                                    <asp:Label ID="lblTaskDate" runat="server"  Text='<%# DateTimeConvert(Eval("TaskDate")) %>'
                                        meta:resourcekey="txtEligibleAmountResource1" />                                                
                                 </ItemTemplate>
                              </asp:TemplateField>
                                        
                           <%-- <asp:BoundField DataField="TaskDate" HeaderText="Task Date" DataFormatString="{0:dd MMM yyyy hh:mm}"
                                meta:resourcekey="BoundFieldResource7">
                                <ControlStyle Width="50px" />
                            </asp:BoundField>--%>
                            <asp:BoundField DataField="CategoryText" HeaderText="Category" meta:resourcekey="BoundFieldResource8">
                                <ControlStyle Width="50px" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Quick" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgQuickDiagnosis" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                        CommandName="QuickDiagnosis" ImageUrl="~/PlatForm/Images/QuickDiagnosis.gif" meta:resourcekey="imgQuickDiagnosisResource1" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Location" HeaderText="Location" meta:resourcekey="BoundFieldResource9">
                                <ControlStyle Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CreatedName" HeaderText="Created By" meta:resourcekey="BoundFieldResource17" />
                            <asp:BoundField DataField="HighlightColor" HeaderText="Picked By" meta:resourcekey="BoundFieldResource10">
                                <ControlStyle Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="InvestigationName" HeaderText="InvestigationName" Visible="False"
                                meta:resourcekey="BoundFieldResource18" />
                            <asp:BoundField DataField="RefernceID" HeaderText="LabNo" Visible="false" meta:resourcekey="BoundFieldResource19" />
                            <asp:TemplateField HeaderText="Close" meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgDelete" runat="server" CommandArgument='<%# Eval("TaskID") %>'
                                        OnClientClick="return alertMesage();" CommandName="Delete" CssClass="ui-icon ui-icon-trash b-none pointer"
                                        meta:resourcekey="imgDeleteResource1" />
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:BoundField DataField="OrgName" HeaderText="Organisation Name" Visible="false" meta:resourcekey="OrgNameBoundFieldResource18" />
                            <asp:BoundField DataField="organizationId" HeaderText="Org Id" Visible="false" meta:resourcekey="BoundFieldResource18" />
                            <asp:BoundField DataField="ClientName" HeaderText="Client Name" meta:resourcekey="TempClientName" />
                            <asp:BoundField DataField="SpecialityName" HeaderText="Speciality Name" meta:resourcekey="TempSpecitName" />
                            <asp:TemplateField HeaderText="Action" Visible="false" meta:resourcekey="TemplAction">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgProcess" runat="server" CommandArgument='<%# Eval("TaskID") %>'
                                        CommandName="Process" ImageUrl="~/PlatForm/Images/cal_fastforward.gif" />
                                    <asp:HiddenField ID="hdnPatientID" runat="server" Value='<%# Eval("PatientID") %>' />
                                    <asp:HiddenField ID="hdnPatientVisitID" runat="server" Value='<%# Eval("PatientVisitID") %>' />
                                    <asp:HiddenField ID="hdnTaskID" runat="server" Value='<%# Eval("TaskID") %>' />
                                    <asp:HiddenField ID="hdnActionName" runat="server" Value='<%# Eval("ActionName") %>' />
                                    <asp:HiddenField ID="hdnRedirectURL" runat="server" Value='<%# Eval("RedirectURL") %>' />
                                    <asp:HiddenField ID="hdnClientname" runat="server" Value='<%# Eval("ClientName") %>' />
                                    <asp:HiddenField ID="hdnSkipTaskValue" runat="server" Value='<%# Eval("SkipTaskValue") %>' />
                                      <asp:HiddenField ID="hdnType" runat="server" Value='<%# Eval("TaskType") %>' />
                                    <asp:HiddenField ID="hdnTaskStatusID" runat="server" Value='<%# Eval("TaskStatusID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField Visible="false" DataField="Category" HeaderText="Category" meta:resourcekey="BoundFieldResource8">
                                <ControlStyle Width="50px" />
                            </asp:BoundField>
							<asp:TemplateField HeaderText="SMS" Visible="false" meta:resourcekey="SMSresouce1">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgSendSMS" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                        CommandName="SendSMS" ImageUrl="../PlatForm/Images/sms_1.png" ToolTip="SendSMS" />
                                </ItemTemplate> 
                            </asp:TemplateField>
							<asp:BoundField Visible="False" DataField="VisitConsID" HeaderText="VisitConsID" meta:resourcekey="BoundFieldResource6" />
                        </Columns>
                    </asp:GridView>
                    </div>
                    <asp:Timer ID="tmrPostback" runat="server" OnTick="tmrPostback_Tick">
                    </asp:Timer>
                </td>
            </tr>
            <tr class="dataheaderInvCtrl">
                <td colspan="2" class="defaultfontcolor a-center">
                    <div id="divFooterNav" runat="server">
                        <asp:Label ID="Label1" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                        <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                        <asp:Label ID="Label2" runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label>
                        <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                        <asp:Button ID="Btn_Previous" runat="server" Text="Previous" OnClick="Btn_Previous_Click"
                            CssClass="btn" meta:resourcekey="Btn_PreviousResource1" Style="width: 71px" />
                        <asp:Button ID="Btn_Next" runat="server" Text="Next" OnClick="Btn_Next_Click" CssClass="btn"
                            meta:resourcekey="Btn_NextResource1" />
                        <asp:HiddenField ID="hdnCurrent" runat="server" />
                        <asp:HiddenField ID="hdnPostBack" runat="server" />
                        <asp:HiddenField ID="hdnOrgID" runat="server" />
                        <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                        <asp:TextBox ID="txtpageNo" runat="server" CssClass="small" onkeypress="return ValidateOnlyNumeric(this);"
                            meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                        <asp:Button ID="btnGo" runat="server" Text="Go" OnClientClick="javascript:return checkForValues();"
                            OnClick="btnGo_Click" CssClass="btn" meta:resourcekey="btnGoResource1" />
                    </div>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnModalTaskID" runat="server" Value="0" />
        <ajc:ModalPopupExtender ID="mdlApprovalpop" runat="server" TargetControlID="btntarget"
            PopupControlID="mdlApprovalPanel" CancelControlID="btnclosetarget" BackgroundCssClass="modalBackground"
            Enabled="True" DropShadow="True" DynamicServicePath="" />
        <asp:Panel ID="mdlApprovalPanel" runat="server" CssClass="modalPopup dataheaderPopup"
            Style="display: none; width: 600px; height: 300px;" meta:resourcekey="mdlApprovalPanelResource1">
            <table class="w-100p">
                <tr>
                    <td>
                        <asp:Label ID="lblReason" Text="Enter Reason for Cancel" runat="server" meta:resourcekey="lblReasonResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtReason" runat="server" CssClass="larger" meta:resourcekey="txtReasonResource1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button runat="server" ID="btnPopOk" CssClass="btn" Text="Ok" OnClick="btnPopOk_Click"
                         OnClientClick="javascript:return fnchkReason();" meta:resourcekey="btnPopOkResource1" />
                        <asp:Button runat="server" ID="btnpopCancel" CssClass="cancel-btn" OnClick="btnPopCancel_Click"
                            meta:resourcekey="btnpopCancelResource1" />
                            <asp:Button runat="server" ID="btntarget" CssClass="hide"  />
                            <asp:Button runat="server" ID="btnclosetarget" CssClass="hide"  />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <ajc:ModalPopupExtender ID="mdlNotification" runat="server" TargetControlID="btntarget"
            PopupControlID="pnlNotification" BackgroundCssClass="modalBackground"
            Enabled="True" DropShadow="True" DynamicServicePath="" />
        <asp:Panel ID="pnlNotification" runat="server" CssClass="modalPopup dataheaderPopup"
            Style="display: none; width: 600px; height: 300px;" >
            <table class="w-100p">
                <tr>
                    <td>
                        <asp:Label ID="Label4" Text="Ordered surgeries"></asp:Label>
                    </td>
                    <td>
                        <div id="dvOrderedSurgeries"></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button runat="server" ID="btnNotifyOK" CssClass="btn" Text="Ok" OnClick="btnPopOk_Click"
                        meta:resourcekey="btnPopOkResource1" />
                        <asp:Button runat="server" ID="btnClose" CssClass="btn" Text="Close" OnClientClick="HidePopup();" />
                    </td>
                </tr>
            </table>
        </asp:Panel>


        <asp:HiddenField ID="hdnTStatus" runat="server" />
        <asp:HiddenField ID="hdntxttext" runat="server" />
        <asp:HiddenField ID="hdnActionCount" runat="server" />
    </ContentTemplate>
</asp:UpdatePanel>

<script type="text/javascript">
    function HidePopup() {
        mdlNotification.hide();
    }
    function ShowNotification(msgString, hdnTID)
    {
        $('#<%= hdnModalTaskID.ClientID %>').val(hdnTID);
        $('#dvOrderedSurgeries').html(msgString);
        var mpNotification = $find('<%= mdlNotification.ClientID %>');
        mpNotification.show();
    }
    function SelectRow(hdnPatientID, hdnPatientVisitID, hdnTaskID, hdnActionName, hdnRedirectURL,lnkProcess) {
        var PatientID = document.getElementById(hdnPatientID).value;
        var VisitID = document.getElementById(hdnPatientVisitID).value;
        var TaskID = document.getElementById(hdnTaskID).value;
        var ActionName = document.getElementById(hdnActionName).value;
        var RedirectURL = document.getElementById(hdnRedirectURL).value;
        var FinalBillID = 0;
        var GUID = '';
        var Usermsg = '';
        var userMsg = '';
        var Msg1 = SListForAppDisplay.Get('PlatFormControls_Tasks_ascx_01');
        if (Msg1 == null) {
            Msg1 = "PatientPrescription";
        }
        var Msg2 = SListForAppDisplay.Get('PlatFormControls_Tasks_ascx_02');
        if (Msg2 == null) {
            Msg2 = "CaptureSymptom";
        }
        var Msg3 = SListForAppDisplay.Get('PlatFormControls_Tasks_ascx_03');
        if (Msg3 == null) {
            Msg3 = "PerformDiagnosis";
        }
        var Msg4 = SListForAppDisplay.Get('PlatFormControls_Tasks_ascx_04');
        if (Msg4 == null) {
            Msg4 = "RadiologyPayment";
        }
        var Msg5 = SListForAppDisplay.Get('PlatFormControls_Tasks_ascx_05');
        if (Msg5 == null) {
            Msg5 = "InvestigationPayment";
        }
        var Msg6 = SListForAppDisplay.Get('PlatFormControls_Tasks_ascx_06');
        if (Msg6 == null) {
            Msg6 = "CollectPayment";
        }
        var Msg7 = SListForAppDisplay.Get('PlatFormControls_Tasks_ascx_07');
        if (Msg7 == null) {
            Msg7 = "InvestigationCollectPayment";
        }
        var Msg8 = SListForAppDisplay.Get('PlatFormControls_Tasks_ascx_08');
        if (Msg8 == null) {
            Msg8 = "RadiologyCollectPayment";
        }
        if (ActionName == Msg1) {

            userMsg = SListForAppMsg.Get('PlatFormControls_Tasks_ascx_08');
            if (userMsg == null) {
                userMsg = "Do you wish to skip the Drug processing step? This action cannot be undone";
            }            
        }
        else if (ActionName == Msg2 || ActionName == Msg3) {
        userMsg = SListForAppMsg.Get('PlatFormControls_Tasks_ascx_09');
            if (userMsg == null) {
                userMsg = "Do you wish to skip the Consultation processing step? This action cannot be undone";
            }    
        }
        else {
            userMsg = SListForAppMsg.Get('PlatFormControls_Tasks_ascx_10');
            if (userMsg == null) {
                userMsg = "Do you wish to skip the payment processing step? This action cannot be undone";
            }
        }
        var lblFlag = confirm(userMsg);
        if (lblFlag == true) {
            $('#'+lnkProcess).removeClass().addClass('hide');
            if (ActionName == Msg4 || ActionName == Msg5) {
                var str = RedirectURL.split('&');
                for (var i = 0; i < str.length; i++) {
                    var n = str[i].search("gUID");
                    if (n == 0) {
                        GUID = str[i].substring(5, 255);
                        break;
                    }
                }
            }
            else if (ActionName == Msg6 || ActionName == Msg7
            || ActionName == Msg8) {
                var str = RedirectURL.split('&');
                for (var i = 0; i < str.length; i++) {
                    var n = str[i].search("bid");
                    if (n == 0) {
                        FinalBillID = str[i].substring(4, 255);
                    }
                    n = 0;
                    n = str[i].search("gUID");
                    if (n == 0) {
                        GUID = str[i].substring(5, 255);
                    }
                }
            }
            if (ActionName == Msg1) {
                Attune.Kernel.Shared.CommonServices.UpdateTaskCloseForPayment('SingleCashier', PatientID, VisitID, ActionName, TaskID, FinalBillID, GUID, RelaodTasks);

            }
            else if (ActionName == Msg2 || ActionName == Msg3) {
                  Attune.Kernel.Shared.CommonServices.UpdateTaskCloseForPayment('Consultation', PatientID, VisitID, ActionName, TaskID, FinalBillID, GUID, RelaodTasks);

            }
            else {
                Attune.Kernel.Shared.CommonServices.UpdateTaskCloseForPayment('', PatientID, VisitID, ActionName, TaskID, FinalBillID, GUID, RelaodTasks);
            } 
        }
        else {
            return false;
        }
    }

    function RelaodTasks(temp) {
      if(temp=="5") {
          var userMsg = SListForAppMsg.Get('PlatFormControls_Tasks_ascx_07') == null ? "This task has already been picked by another user." : SListForAppMsg.Get('PlatFormControls_Tasks_ascx_07');
        

          ValidationWindow(userMsg, informMsg);
          
        document.getElementById('<%= btn_Go.ClientID %>').click();
        return true;
      }
      else 
      {
        document.getElementById('<%= btn_Go.ClientID %>').click();
        return true;
      }
        
    }
	 function PerformBaseLineConfirm(Mes, RowID) {
  
      var r = confirm(Mes);
      if (r == true) {
          __doPostBack('TaskNew1$grdTasks', RowID)
      }
	 }
	 function fnAdmitTask()
	 {
	     window.location.href = '../PlatForm/Home.aspx';
	     return false;
	 }
	  
</script>
<script type="text/javascript" language="javascript">
var errorMsg;
var cancelMsg;
var informMsg;
var okMsg;
$(document).ready(function() {

    errorMsg = SListForAppMsg.Get("PlatFormControls_Error") == null ? "Alert" : SListForAppMsg.Get("PlatFormControls_Error");
    cancelMsg = SListForAppMsg.Get("PlatFormControls_Cancel") == null ? "Cancel" : SListForAppMsg.Get("PlatFormControls_Cancel");
    informMsg = SListForAppMsg.Get("PlatFormControls_Informtion") == null ? "Information" : SListForAppMsg.Get("PlatFormControls_Informtion");
    okMsg = SListForAppMsg.Get("PlatFormControls_Ok") == null ? "Ok" : SListForAppMsg.Get("PlatFormControls_Ok");
});
</script>