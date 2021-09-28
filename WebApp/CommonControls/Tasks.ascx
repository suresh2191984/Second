<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Tasks.ascx.cs" Inherits="CommonControls_TasksNew" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<style type="text/css">
    .style1
    {
        height: 25px;
    }
    .createhide
    {
        display: none;
    }
    .grdResult td
    {
        padding: 5px;
    }
</style><%--<link rel="stylesheet" type="text/css" href="../Themes/IB/style.css" />
--%>
<%--<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>
<asp:UpdatePanel ID="ctlTaskUpdPnl" runat="server">
    <ContentTemplate>
        <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="ctlTaskUpdPnl" runat="server">
            <ProgressTemplate>
                <div id="progressBackgroundFilter" class="a-center">
                </div>
                <div id="processMessage" class="a-center w-20p">
                    <asp:Image ID="imgProgressbar" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                        meta:resourcekey="img1Resource1" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>

        <script type="text/javascript">
            function GetID(source, eventArgs) {
                // debugger;
                document.getElementById('<%= txtClientName.ClientID %>').value = eventArgs.get_text();
                var ClientName_Value = eventArgs.get_value();
                if (ClientName_Value != "") {
                    var ClientName_Split = ClientName_Value.split('|');
                    document.getElementById('<%= hdnSelectedClientID.ClientID %>').value = ClientName_Split[0];
                    document.getElementsByName('<%= hdnSelectedClientName.ClientID %>').item = ClientName_Split[1];
                }
            }
        </script>

        <script type="text/javascript" language="javascript">
            var AlertType;
            $(document).ready(function() {
                AlertType = SListForAppMsg.Get('Phlebotomist_Home_aspx_03') == null ? "Alert" : SListForAppMsg.Get('Phlebotomist_Home_aspx_03');
            });
            function WaterMark(txttext, evt, defaultText) {
                if (txttext.value.length == 0 && evt.type == "blur") {
                    txttext.style.color = "gray";
                    txttext.value = defaultText;
                }
                if (txttext.value == defaultText && evt.type == "focus") {
                    txttext.style.color = "black";
                    txttext.value = "";
                }
            }
            function ShowAlertMsg(key) {
                /* Added By Venkatesh S */
                var vPrescriptionExp = SListForAppMsg.Get('CommonControls_Task_ascx_01') == null ? "This Prescription is expired,the task will be deleted !!!" : SListForAppMsg.Get('CommonControls_Task_ascx_01');
                var vAnotherUser = SListForAppMsg.Get('CommonControls_Task_ascx_02') == null ? "This task has already been picked by another user !!!" : SListForAppMsg.Get('CommonControls_Task_ascx_02');
                var vTaskPicked = SListForAppMsg.Get('CommonControls_Task_ascx_03') == null ? "This task has already been picked by" : SListForAppMsg.Get('CommonControls_Task_ascx_03');

                var userMsg = SListForApplicationMessages.Get(key);
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else if (key == "CommonControls\\Tasks.ascx.cs_1") {
                    ValidationWindow(vPrescriptionExp, AlertType);
                    return false;
                }
                else if (key == "CommonControls\\Tasks.ascx.cs_2") {
                ValidationWindow(vAnotherUser, AlertType);
                document.getElementById('<%=lblCurrent.ClientID %>').innerHTML = "1";
                document.getElementById('<%=hdnCurrent.ClientID %>').value = "1";
                document.getElementById('<%=txtpageNo.ClientID %>').value = "1";
                document.getElementById('<%= btnGo.ClientID %>').click();            
                return false;
                    
                }
                else if (key == "CommonControls\\Tasks.ascx.cs_3") {
                    ValidationWindow(vTaskPicked, AlertType);
                    return false;
                }
                return true;
            }
            function getPatientName() {
                if (document.getElementById('<%= hdntxttext.ClientID %>').value.trim() != "") {
                    document.getElementById('<%= hdntxttext.ClientID %>').value = document.getElementById('txttext').value;
                }
                else {
                    document.getElementById('<%= hdntxttext.ClientID %>').value = "";
                }
            }

            function alertMesage() {
                /* Added By Venkatesh S */
                var vConfirm = SListForAppMsg.Get('CommonControls_Task_ascx_04') == null ? "This Task will be deleted. Continue?" : SListForAppMsg.Get('CommonControls_Task_ascx_04');

                if (confirm(vConfirm)) {
                    return true;
                }
                else {
                    //alert('No');
                    return false;
                }
            }
            function Click() {

                //$("[id$='grdTasks'] tr").children('td').length > 0
                javascript: __doPostBack('uctlTaskList$grdTasks', 'Select$0');
                //$('#uctlTaskList_grdTasks_ctl02_ctl00').click();

                //var J = $('#uctlTaskList_grdTasks_ctl02_ctl00');
            }
            function checkForValues() {
                /* Added By Venkatesh S */
                var vPageNo = SListForAppMsg.Get('Phlebotomist_Home_aspx_01') == null ? "Provide page number" : SListForAppMsg.Get('Phlebotomist_Home_aspx_01');
                var vCorrectPageNo = SListForAppMsg.Get('Phlebotomist_Home_aspx_02') == null ? "Provide correct page number" : SListForAppMsg.Get('Phlebotomist_Home_aspx_02');

                if (document.getElementById('<%= txtpageNo.ClientID %>').value == "") {
                    ValidationWindow(vPageNo, AlertType);
                    return false;
                }

                if (Number(document.getElementById('<%= txtpageNo.ClientID %>').value) < Number(1)) {
                    ValidationWindow(vCorrectPageNo, AlertType);
                    return false;
                }

                if (Number(document.getElementById('<%= txtpageNo.ClientID %>').value) > Number(document.getElementById('<%= lblTotal.ClientID %>').innerText)) {
                    ValidationWindow(vCorrectPageNo, AlertType);
                    return false;
                }


            }
        </script>

        <script type="text/javascript">

            var datadiv_tooltip = false;
            var datadiv_tooltipShadow = false;
            var datadiv_shadowSize = 4;
            var datadiv_tooltipMaxWidth = 2000;
            var datadiv_tooltipMinWidth = 100;
            var datadiv_iframe = false;
            var tooltip_is_msie = (navigator.userAgent.indexOf('MSIE') >= 0 && navigator.userAgent.indexOf('opera') == -1 && document.all) ? true : false;
            function showTooltip(e, tooltipTxt) {

                var bodyWidth = Math.max(document.body.clientWidth, document.documentElement.clientWidth) - 20;

                var position = [0, 0];
                if (typeof window.pageYOffset != 'undefined') {
                    position = [window.pageXOffset, window.pageYOffset];
                }
                else if (typeof document.documentElement.scrollTop != 'undefined' && document.documentElement.scrollTop > 0) {
                    position = [document.documentElement.scrollLeft, document.documentElement.scrollTop];
                }
                else if (typeof document.body.scrollTop != 'undefined') {
                    position = [document.body.scrollLeft, document.body.scrollTop];
                }

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
                var divh = datadiv_tooltip.clientHeight;
                var pageX = e.clientX + position[0];
                var pageY = e.clientY + position[1];

                if (pageY < 300) {
                    datadiv_tooltip.style.left = leftPos + 'px';
                    datadiv_tooltip.style.top = pageY + 'px';
                }
                else {
                    datadiv_tooltip.style.left = leftPos + 'px';
                    datadiv_tooltip.style.top = pageY - divh + 'px';
                }

                if (pageY < 300) {
                    datadiv_tooltipShadow.style.left = leftPos + datadiv_shadowSize + 'px';
                    datadiv_tooltipShadow.style.top = pageY + datadiv_shadowSize + 'px';
                }
                else {
                    datadiv_tooltipShadow.style.left = leftPos + datadiv_shadowSize + 'px';
                    datadiv_tooltipShadow.style.top = pageY - divh + datadiv_shadowSize + 'px';
                }

                //                datadiv_tooltipShadow.style.left = leftPos + datadiv_shadowSize + 'px';
                //                datadiv_tooltipShadow.style.top = e.clientY + 10 + st + datadiv_shadowSize + 'px';

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

            function hideTooltip24() {
                datadiv_tooltip.style.display = 'none';
                datadiv_tooltipShadow.style.display = 'none';
                if (tooltip_is_msie) datadiv_iframe.style.display = 'none';
            }

        </script>

        <table class="w-100p">
            <tr>
                <td>
                    <asp:Panel ID="pnlFilter" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlFilterResource1">
                        <table class="defaultfontcolor w-100p searchPanel">
                            <tr class="colorforcontent">
                                <td class="w-30p h-23 a-left">
                                    <div id="ACX2plus1" style="display: none;">
                                        &nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top" style="cursor: pointer"
                                            onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);" />
                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);">
                                            &nbsp;<asp:Label ID="Rs_FilterResult1" runat="server" Text="Filter Result" meta:resourcekey="Rs_FilterResult1Resource1"></asp:Label></span>
                                    </div>
                                    <div id="ACX2minus1" style="display: block;">
                                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top" style="cursor: pointer"
                                            onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);" />
                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);">
                                            &nbsp<asp:Label ID="Rs_FilterResult2" runat="server" Text="Filter Result" meta:resourcekey="Rs_FilterResult2Resource1"></asp:Label></span>
                                    </div>
                                </td>
                                <td class="h-23 a-right">
                                    <asp:Panel ID="Panel1" runat="server" DefaultButton="btn_Go" meta:resourcekey="Panel1Resource4">
                                        <asp:Label ID="lblpatientNameNO" Text="Patient Name / Number" runat="server" meta:resourcekey="lblpatientNameNOResource1" />
                                        <asp:TextBox ID="txttext" CssClass="small" runat="server" meta:resourcekey="txttextResource1" />
                                        <asp:Button runat="server" ID="btn_Go" Text="Go" CssClass="btn1 h-20" onmouseover="this.className='btn1 btnhov1'"
                                            onmouseout="this.className='btn1'" OnClick="btn_Go_Click" meta:resourcekey="btn_GoResource1" />
                                        <asp:CheckBox ID="rdnLabNo" Text="Lab Number" runat="server" Visible="False" meta:resourcekey="rdnLabNoResource1" />
                                        <asp:CheckBox ID="ChkBoxServiceNum" Text="Sevice Number" runat="server" Style="display: none;"
                                            meta:resourcekey="ChkBoxServiceNumResource1" />
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr class="tablerow" id="ACX2responses1" style="display: table-row;">
                                <td colspan="2">
                                    <div class="filterdataheader2">
                                        <table class="defaultfontcolor w-100p" style="margin: 6px">
                                            <tr>
                                                <td colspan="5">
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Rs_Location" runat="server" Text="Location" meta:resourcekey="Rs_LocationResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList CssClass="ddlsmall" runat="server" ID="ddLO" OnSelectedIndexChanged="ddLO_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_SpecialityDepartment" runat="server" Text="Speciality" meta:resourcekey="Rs_SpecialityDepartmentResource4"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList CssClass="ddlsmall" runat="server" ID="ddSPE" OnSelectedIndexChanged="ddSPE_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_Department" runat="server" Text="Department" meta:resourcekey="Rs_DepartmentResource3"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="ddlDept" CssClass="ddlsmall" OnSelectedIndexChanged="ddlDept_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Rs_Category" runat="server" Text="Category" meta:resourcekey="Rs_CategoryResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList CssClass="ddlsmall" runat="server" ID="ddCat" OnSelectedIndexChanged="ddCat_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_TaskDate" runat="server" Text="TaskDate" meta:resourcekey="Rs_TaskDateResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList CssClass="ddlsmall" runat="server" ID="ddTD" OnSelectedIndexChanged="ddTD_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPreference" Text="Preference" runat="server" meta:resourcekey="lblPreferenceResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <span class="richcombobox w-100p">
                                                        <asp:DropDownList ID="ddlPriority" CssClass="ddlsmall" runat="server">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td colspan="2">
                                                    <table class="w-100p" id="trTimedSamples" runat="server" style="display: none;">
                                                        <tr>
                                                            <td>
                                                                <%--<input style="background-color: blanchedAlmond; color: blue;" name="foo2" type="checkbox">--%><br>
                                                                <asp:CheckBox ID="chkTimedSamples" Text="Timed Samples" runat="server" Style="background-color: #ffebcd;"
                                                                    OnCheckedChanged="Check_Clicked" AutoPostBack="True" meta:resourcekey="chkTimedSamplesResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    &nbsp;
                                                </td>
                                                <%--<td>
                                                    &nbsp;
                                                </td>--%>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblpendingDays" Text="PendingDays" runat="server" meta:resourcekey="lblpendingDaysResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtpendingDays" CssClass="small" runat="server" meta:resourcekey="txtpendingDaysResource1"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblClientName" Text="ClientName" runat="server" meta:resourcekey="lblClientNameResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtClientName" runat="server" TabIndex="8" CssClass="AutoCompletesearchBox"
                                                        onBlur="return ClearFields();" meta:resourcekey="txtClientNameResource1"></asp:TextBox>
                                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtenderClientTask" runat="server" CompletionInterval="1"
                                                        BehaviorID="AutoClientName" CompletionListCssClass="wordWheel listMain .box"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListItemCssClass="wordWheel itemsMain"
                                                        DelimiterCharacters="" EnableCaching="False" Enabled="True" FirstRowSelected="True"
                                                        MinimumPrefixLength="1" UseContextKey="true" OnClientItemSelected="GetID" ServiceMethod="GetClientList"
                                                        ServicePath="~/WebService.asmx" TargetControlID="txtClientName">
                                                    </cc1:AutoCompleteExtender>
                                                </td>
                                                <td runat="server" id="td_lblprotocalgroup">
                                                    <asp:Label ID="lblProtocal" runat="server" Text="Protocal Group" meta:resourcekey="lblProtocalResource1"></asp:Label>
                                                </td>
                                                <td class="a-left" id="td_drpProtocal" runat="server">
                                                    <asp:DropDownList runat="server" ID="ddlprotocalgroup" CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr id="trht" runat="server" visible="false">
                                            <td style="height:10px;"></td>
                                            </tr>
                                            <tr>
											<td>
                                                    <asp:Label ID="lblBarcode" runat="server" Text="BarCode Number" meta:resourcekey="lblBarcodeResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtBarcode" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                </td>
                                            <td runat="server" id="tdVisitType">
                                            <asp:Label ID="lblVisitType" runat="server" Text="VisitType" meta:resourcekey="lblVisitType1"></asp:Label>
                                            </td>
                                            <td class="a-left" id="tdddlVisitType" runat="server">
                                            <asp:DropDownList ID="ddlVisitType" runat="server" meta:resourcekey="ddlVisitTypeResource1"
                                                                CssClass="ddlsmall">
                                                            </asp:DropDownList>
                                                            <asp:HiddenField ID="hdnVisitType" runat="server" />
                                            </td>
                                                <td >
                                                    <asp:CheckBox ID="chkSetDefault" runat="server" Text="Set Default" meta:resourcekey="chkSetDefaultResource1" />&nbsp;&nbsp;&nbsp;
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chktasks" runat="server" Text="Allocated Tasks" meta:resourcekey="chktasksResource1" />
                                                </td>
                                                <td colspan="3" class="a-left">
                                                    <asp:LinkButton ID="lnkSetDefault" Text=" Show Task" CssClass="btn w-72 h-15" runat="server"
                                                        OnClick="lnkSetDefault_Click" meta:resourcekey="lnkSetDefaultResource4" />
                                                </td>
                                                <td class="a-left">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td class="v-middle">
                                <asp:Label ID="lblResult1" runat="server" CssClass="defaultfontcolor" meta:resourcekey="lblResult1Resource1"></asp:Label>
                            </td>
                            <td class="v-middle">
                                <asp:LinkButton ID="btnRefresh" CssClass="refrshbtn w-60" ToolTip="Click here to refresh task list"
                                    runat="server" OnClick="btnRefresh_Click" meta:resourcekey="btnRefreshResource4" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td class="v-middle">
                                <asp:Label ID="lblResult" runat="server" CssClass="defaultfontcolor" meta:resourcekey="lblResultResource1">
                                    <asp:Label ID="Rs_Re" runat="server" Text="Re" meta:resourcekey="Rs_ReResource1"></asp:Label>
                                </asp:Label>
                            </td>
                            <td class="v-middle">
                                <asp:LinkButton ID="btnRefresh1" Text="Refresh" CssClass="refrshbtn" runat="server"
                                    ToolTip="Click here to refresh task list" OnClick="btnRefresh1_Click" meta:resourcekey="btnRefresh1Resource4" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="grdTasks" class="gridView" CssClass="grdResult w-100p" runat="server"
                        AllowPaging="True" CellPadding="4" AutoGenerateColumns="False" DataKeyNames="PatientID,TaskID,RedirectURL,PatientVisitID,RoleName,Category,HighlightColor,CreatedName,OrgID,RefernceID,IsTimedTask"
                        OnRowDataBound="grdTasks_RowDataBound" OnRowCommand="grdTasks_RowCommand" ForeColor="#333333"
                        OnPageIndexChanging="grdTasks_PageIndexChanging" meta:resourcekey="grdTasksResource1">
                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <HeaderStyle CssClass="dataheader1" />
                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                            PageButtonCount="5" PreviousPageText="" />
                        <Columns>
                            <asp:BoundField Visible="False" DataField="RoleName" HeaderText="Role Name" meta:resourcekey="BoundFieldResource1" />
                            <asp:BoundField Visible="False" DataField="PatientID" HeaderText="PatientID" meta:resourcekey="BoundFieldResource2" />
                            <asp:BoundField Visible="False" DataField="TaskID" HeaderText="Task ID" meta:resourcekey="BoundFieldResource3" />
                            <asp:BoundField Visible="False" DataField="RedirectURL" HeaderText="URL" meta:resourcekey="BoundFieldResource4" />
                            <asp:BoundField Visible="False" DataField="PatientVisitID" HeaderText="VisitID" meta:resourcekey="BoundFieldResource5" />
                            <asp:BoundField DataField="TaskDescription" HeaderText="Task Details" meta:resourcekey="BoundFieldResource6">
                                <ControlStyle Width="660px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TaskDate" HeaderText="Task Date" DataFormatString="{0:dd MMM yyyy hh:mm}"
                                meta:resourcekey="BoundFieldResource7">
                                <ControlStyle CssClass="w-50" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Category" HeaderText="Category" meta:resourcekey="BoundFieldResource8">
                                <ControlStyle CssClass="w-50" />
                            </asp:BoundField>
                            <%--<asp:TemplateField HeaderText="Close" meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgDelete" runat="server" CommandArgument='<%# Eval("TaskID") %>'
                                        OnClientClick="return alertMesage();" CommandName="Delete" 
                                        ImageUrl="~/Images/Delete.jpg" meta:resourcekey="imgDeleteResource1" />
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Quick" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgQuickDiagnosis" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                        CommandName="QuickDiagnosis" ImageUrl="~/Images/QuickDiagnosis.gif" meta:resourcekey="imgQuickDiagnosisResource1" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Location" HeaderText="Location" meta:resourceskey="BoundFieldResource9"
                                meta:resourcekey="BoundFieldResource9">
                                <ControlStyle CssClass="w-50" />
                            </asp:BoundField>
                            <%--<asp:BoundField DataField="CreatedName" HeaderText="Created By" meta:resourcekey="BoundFieldResource17" />--%>
                            <asp:BoundField DataField="CreatedName" HeaderText="Created By" meta:resourcekey="BoundFieldResource17">
                                <ItemStyle CssClass="createhide" />
                                <HeaderStyle CssClass="createhide" />
                            </asp:BoundField>
                            <asp:BoundField DataField="HighlightColor" HeaderText="Picked By" meta:resourcekey="BoundFieldResource10">
                                <ControlStyle CssClass="w-50" />
                            </asp:BoundField>
                            <asp:BoundField DataField="InvestigationName" HeaderText="InvestigationName" Visible="False"
                                meta:resourcekey="BoundFieldResource18" />
                            <asp:BoundField DataField="RefernceID" HeaderText="Lab No" Visible="false" meta:resourcekey="BoundFieldResource19" />
                            <asp:TemplateField HeaderText="Close" meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgDelete" runat="server" CommandArgument='<%# Eval("TaskID") %>'
                                        OnClientClick="return alertMesage();" CommandName="Delete" ImageUrl="~/Images/Delete.jpg"
                                        meta:resourcekey="imgDeleteResource1" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="OrgName" HeaderText="Org Name" Visible="false" meta:resourcekey="BoundFieldResource11" />
                            <asp:BoundField DataField="OrgID" HeaderText="Org Id" Visible="false" meta:resourcekey="BoundFieldResource18" />
                            <asp:TemplateField HeaderText="Old Approval" meta:resourcekey="TemplateFieldResource3">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkUrlStatus" runat="server" Text="Old Approval" CommandName="Redirect"
                                        CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' ForeColor="Black"
                                        meta:resourcekey="lnkUrlStatusResource1"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Report Date" ItemStyle-HorizontalAlign="center" meta:resourcekey="TemplateFieldResource4">
                                <ItemTemplate>
                                    <asp:Label ID="lbldate" runat="server" Text='<%# bind("ReportTatDate","{0:dd MMM yyyy hh:mm tt}") %>'
                                        meta:resourcekey="lbldateResource1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <%--<asp:Timer ID="tmrPostback" runat="server" OnTick="tmrPostback_Tick">
                    </asp:Timer>--%>
                </td>
            </tr>
            <tr class="dataheaderInvCtrl">
                <td class="a-center defaultfontcolor" colspan="2">
                    <div id="divFooterNav" runat="server">
                        <asp:Label ID="Label1" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                        <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                        <asp:Label ID="Label2" runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label>
                        <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                        <asp:Button ID="Btn_Previous" runat="server" Text="Previous" OnClick="Btn_Previous_Click"
                            CssClass="btn w-71" meta:resourcekey="Btn_PreviousResource1" />
                        <asp:Button ID="Btn_Next" runat="server" Text="Next" OnClick="Btn_Next_Click" CssClass="btn"
                            meta:resourcekey="Btn_NextResource1" />
                        <asp:HiddenField ID="hdnCurrent" runat="server" />
                        <asp:HiddenField ID="hdnPostBack" runat="server" />
                        <asp:HiddenField ID="hdnOrgID" runat="server" />
                        <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                        <asp:TextBox ID="txtpageNo" runat="server" CssClass="w-30" maxlength='4'    onkeypress="return ValidateOnlyNumeric(this);"  
                            meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                        <asp:Button ID="btnGo" runat="server" Text="Go" OnClientClick="javascript:return checkForValues();"
                            OnClick="btnGo_Click" CssClass="btn" meta:resourcekey="btnGoResource1" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <table id="tblApprovalTask" class="bg-row" border="1" style="display: none; border-collapse: collapse;
                        empty-cells: show; white-space: nowrap; text-align: left;">
                        <thead>
                            <tr>
                                <th>
                                    <%=Resources.Phlebotomist_ClientDisplay.CommonControls_Task_ascx_19 %>
                                </th>
                                <th>
                                    <%=Resources.Phlebotomist_ClientDisplay.CommonControls_Task_ascx_20 %>
                                </th>
                                <th>
                                    <%=Resources.Phlebotomist_ClientDisplay.CommonControls_Task_ascx_21 %>
                                </th>
                                <th>
                                    <%=Resources.Phlebotomist_ClientDisplay.CommonControls_Task_ascx_22 %>
                                </th>
                                <th>
                                    <%=Resources.Phlebotomist_ClientDisplay.CommonControls_Task_ascx_23 %>
                                </th>
                                <th>
                                    <%=Resources.Phlebotomist_ClientDisplay.CommonControls_Task_ascx_24 %>
                                </th>
                                <th>
                                    <%=Resources.Phlebotomist_ClientDisplay.CommonControls_Task_ascx_25 %>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnTStatus" runat="server" />
        <asp:HiddenField ID="hdntotrows" Value="0" runat="server" />
        <asp:HiddenField ID="hdntxttext" runat="server" />
        <asp:HiddenField ID="hdnActionCount" runat="server" />
        <input id="hdnSelectedClientName" type="hidden" value="-1" runat="server" />
        <input id="hdnSelectedClientID" type="hidden" value="0" runat="server" />
        <asp:HiddenField ID="hdnReportdateconfig1" runat="server" />
    </ContentTemplate>
</asp:UpdatePanel>

<script type="text/javascript">
    function CheckValidationForAutocomplete(codeType, TxtID) {
        var txtValue = document.getElementById(TxtID).value.trim();

        if (codeType == 'Zone') {

        }
        else if (codeType == 'Client') {
            if (txtValue != '') {

            }

        }
        else {

        }
    }
    
</script>

