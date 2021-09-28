<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TaskEscalation.ascx.cs"
    Inherits="CommonControls_TaskEscalation" %>

<script language="javascript" type="text/javascript">
    function CallDeleteMessage(sender) {
        var UserMsg = SListForAppMsg.Get("CommonControls_TaskEscalation_ascx_01") != null ? SListForAppMsg.Get("CommonControls_TaskEscalation_ascx_01") : "Are You Sure To Delete? This Action Will Delete The Task Also";
        if (confirm(UserMsg)) {

            return true;
        }
        else {

            return false;
        }
    }   
</script>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table class="w-100p">
            <tr>
                <td>
                    <asp:Label CssClass="tdHeaderBGColor" ID="lblTaskEscalation" runat="server" Text="Task Escalation Details"
                        meta:resourcekey="lblTaskEscalationResource1"></asp:Label>
                    <input type="hidden" id="hdnStartIndex" runat="server" />
                    <input type="hidden" id="hdnEndIndex" runat="server" />
                    <input type="hidden" id="hdnTotalCount" runat="server" />
                </td>
            </tr>
            <tr id="Inves" class="a-center" runat="server">
                <td>
                    <asp:Button ID="btnPreviousTop" ToolTip="Click here to move Previous" Style="cursor: pointer;"
                        runat="server" Text="Previous" class="btn" onmouseout="this.className='btn'"
                        onmouseover="this.className='btn btnhov'" OnClick="btnPreviousTop_Click" meta:resourcekey="btnPreviousTopResource1" />&nbsp;
                    <asp:Button ID="btnNextTop" ToolTip="Click here to move Next" Style="cursor: pointer;"
                        runat="server" Text="Next" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                        OnClick="btnNextTop_Click" meta:resourcekey="btnNextTopResource1" />&nbsp;
                </td>
            </tr>
            <tr>
                <td class="defaultfontcolor">
                    <asp:GridView ID="gvTaskEscalation" runat="server" AutoGenerateColumns="false" GridLines="Both"
                        CssClass="gridView w-96p m-auto" OnRowCommand="gvTaskEscalation_RowCommand" AllowSorting="true"
                        OnSorting="gvTaskEscalation_Sorting" meta:resourcekey="gvTaskEscalationResource1">
                        <HeaderStyle CssClass="dataheader1" />
                        <Columns>
                            <%--<asp:BoundField DataField="ActionName" SortExpression="ActionName"   HeaderText="Task" />--%>
                            <%--                            
--%>
                            <%--<asp:BoundField DataField="TaskDate" SortExpression="TaskDate" HeaderText="Task date" />--%>
                            <%-- <asp:BoundField DataField="RoleName" HeaderText="Role / Name" SortExpression="RoleName"/>--%>
                            <%-- <asp:BoundField DataField="PatientName" HeaderText="PatientName" SortExpression="PatientName"/>--%>
                            <asp:TemplateField HeaderText="<span title='Click Here To sort by Task '>Task</span>"
                                SortExpression="ActionName" meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <asp:Label ID="lblActionName" runat="server" Text='<%# Eval("ActionName") %>' meta:resourcekey="lblActionNameResource1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="<span title='Click Here To sort by TaskDate '>Task Date</span>"
                                SortExpression="TaskDate" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:Label ID="lblTaskDate" runat="server" Text='<%# Eval("TaskDate") %>' meta:resourcekey="lblTaskDateResource1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="<span title='Click Here To sort by RoleName '>Role / Name</span>"
                                SortExpression="RoleName" meta:resourcekey="TemplateFieldResource3">
                                <ItemTemplate>
                                    <asp:Label ID="lblRoleName" runat="server" Text='<%# Eval("RoleName") %>' meta:resourcekey="lblRoleNameResource1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="<span title='Click Here To sort by PatientName '>PatientName</span>"
                                SortExpression="PatientName" meta:resourcekey="TemplateFieldResource4">
                                <ItemTemplate>
                                    <asp:Label ID="lblPatientName" runat="server" Text='<%# Eval("PatientName") %>' meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="<span title='Click Here To sort by Elapsed Time '>Elapsed Time</span>"
                                SortExpression="ElapsedDays" meta:resourcekey="TemplateFieldResource5">
                                <ItemTemplate>
                                    <asp:Label ID="lblElapsedTime" runat="server" Text='<%# Eval("ElapsedDays") %>' meta:resourcekey="lblElapsedTimeResource1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Close" meta:resourcekey="TemplateFieldResource6">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" OnClientClick="javascript:if(!CallDeleteMessage(this)) return false;"
                                        CommandName="Del" Text="Delete" CssClass="w-45" ForeColor="Blue" runat="server"
                                        CommandArgument='<%# Bind("TaskID") %>' meta:resourcekey="LinkButton1Resource1" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField Visible="false" meta:resourcekey="TemplateFieldResource7">
                                <ItemTemplate>
                                    <asp:Label ID="lblTaskId" runat="server" Text='<%# Bind("TaskID") %>' Visible="False"
                                        meta:resourcekey="lblTaskIdResource1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <%--                   <asp:Timer ID="tmrPostback" runat="server" Interval="10000" OnTick="tmrPostback_Tick">
                    </asp:Timer>--%>
                </td>
            </tr>
            <tr id="Inv" runat="server" align="center">
                <td>
                    <asp:Button ID="btnPrevious" ToolTip="Click here to move Previous" Style="cursor: pointer;"
                        runat="server" Text="Previous" class="btn" onmouseout="this.className='btn'"
                        onmouseover="this.className='btn btnhov'" OnClick="btnPrevious_Click" meta:resourcekey="btnPreviousResource1" />&nbsp;
                    <asp:Button ID="btnNext" ToolTip="Click here to move Next" Style="cursor: pointer;"
                        runat="server" Text="Next" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                        OnClick="btnNext_Click" meta:resourcekey="btnNextResource1" />&nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
