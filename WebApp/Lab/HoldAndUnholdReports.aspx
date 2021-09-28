<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HoldAndUnholdReports.aspx.cs"
    Inherits="Lab_HoldAndUnholdReports" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Investigation Org Change</title>
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery.min.js"></script>
    <style type="text/css">
    .grdResult td
    {
        padding: 5px;
    }
    </style>

    <script type="text/javascript">
        var AlertType;
        $(document).ready(function() {
            AlertType = SListForAppMsg.Get('Phlebotomist_Home_aspx_03') == null ? "Alert" : SListForAppMsg.Get('Phlebotomist_Home_aspx_03');
        });
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

</head>
<body oncontextmenu="return false;" onload="javascript:getFocus();">
    <form id="form1" runat="server" defaultbutton="btnGo">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:Panel ID="panSearch" CssClass="searchPanel" runat="server" meta:resourcekey="panSearchResource1">
            <table>
                <caption>
                </caption>
            </table>
            <table class="w-100p dataheader3">
                <tr>
                    <td class="a-left">
                        <asp:Label ID="lblPatient" runat="server" Text="Lab Number"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPatientSearch" CssClass="small" runat="server" meta:resourcekey="txtPatientSearchResource1" />
                    </td>
                    <td>
                        <asp:Label ID="lblvisit" runat="server" Text="Patient Visit No" meta:resourcekey="lblvisitResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtvisitno" CssClass="small" runat="server" meta:resourcekey="txtvisitnoResource1" />
                    </td>
                    <td class="defaultfontcolor">
                        <asp:Label runat="server" ID="Label1" Text="Patient Name" meta:resourcekey="Label1Resource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPname" runat="server" autocomplete="off" CssClass="small" meta:resourcekey="txtPnameResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="Autosearch" runat="server" CompletionInterval="10"
                            FirstRowSelected="true" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                            CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                            Enabled="True" MinimumPrefixLength="1" ServiceMethod="Getpatientsearch" ServicePath="~/OPIPBilling.asmx"
                            OnClientItemSelected="AuthSelectedPatient" TargetControlID="txtPname">
                        </ajc:AutoCompleteExtender>
                    </td>
                </tr>
                <tr style="display: none">
                    <td class="defaultfontcolor">
                        <asp:Label runat="server" ID="lblFrom" Text="From Date" meta:resourcekey="lblFromResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtFromDate" runat="server" CssClass="small" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                        <a href="javascript:NewCssCal('txtFromDate','ddmmyyyy','arrow',true,12)">
                            <img src="../images/Calendar_scheduleHS.png" id="imgCalc">
                        </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td class="defaultfontcolor">
                        <asp:Label runat="server" ID="Lblto" Text="To Date" meta:resourcekey="LbltoResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TxtToDate" runat="server" CssClass="small" meta:resourcekey="TxtToDateResource1"></asp:TextBox>
                        <a href="javascript:NewCssCal('TxtToDate','ddmmyyyy','arrow',true,12)">
                            <img src="../images/Calendar_scheduleHS.png" id="img1">
                        </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <asp:CheckBox ID="ChkUnHoldbtn" runat="server" Text="Hold" />
                    </td>
                    <td class="a-center" colspan="3">
                        <asp:Button ID="btnGo" runat="server" CssClass="btn" meta:resourcekey="btnGoResource1"
                            OnClick="btnGo_Click" OnClientClick="return txtBoxValidation()" Style="cursor: pointer;"
                            Text="Search" ToolTip="Click here to Collect the Sample" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" Text="No Matching Records Found!"
            meta:resourcekey="lblStatusResource1"></asp:Label>
        <table id="TblUnholdTasks">
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
                            <%--<asp:TemplateField HeaderText="Quick" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgQuickDiagnosis" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                        CommandName="QuickDiagnosis" ImageUrl="~/Images/QuickDiagnosis.gif" meta:resourcekey="imgQuickDiagnosisResource1" />
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:BoundField DataField="Location" HeaderText="Location" meta:resourceskey="BoundFieldResource9"
                                meta:resourcekey="BoundFieldResource9">
                                <ControlStyle CssClass="w-50" />
                            </asp:BoundField>
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
                            <%--<asp:TemplateField HeaderText="Close" meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgDelete" runat="server" CommandArgument='<%# Eval("TaskID") %>'
                                        OnClientClick="return alertMesage();" CommandName="Delete" ImageUrl="~/Images/Delete.jpg"
                                        meta:resourcekey="imgDeleteResource1" />
                                </ItemTemplate>
                            </asp:TemplateField>--%>
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
                        <asp:Label ID="Label2" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                        <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                        <asp:Label ID="Label3" runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label>
                        <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                        <asp:Button ID="Btn_Previous" runat="server" Text="Previous" OnClick="Btn_Previous_Click"
                            CssClass="btn w-71" meta:resourcekey="Btn_PreviousResource1" />
                        <asp:Button ID="Btn_Next" runat="server" Text="Next" OnClick="Btn_Next_Click" CssClass="btn"
                            meta:resourcekey="Btn_NextResource1" />
                        <asp:HiddenField ID="hdnCurrent" runat="server" />
                        <asp:HiddenField ID="hdnPostBack" runat="server" />
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                        <asp:Label ID="Label4" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                        <asp:TextBox ID="txtpageNo" runat="server" CssClass="w-30" MaxLength='4' onkeypress="return ValidateOnlyNumeric(this);"
                            meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                        <asp:Button ID="Button1" runat="server" Text="Go" OnClientClick="javascript:return checkForValues();"
                            OnClick="btnPageGo_Click" CssClass="btn" meta:resourcekey="btnGoResource1" />
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnOrgId" runat="server" />
    </form>
</body>
</html>
