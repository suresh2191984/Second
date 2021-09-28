<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SampleWorkFlow.aspx.cs" Inherits="Lab_SampleWorkFlow"
    meta:resourcekey="PageResource2" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Src="../CommonControls/SampleArchival.ascx" TagName="SampleArchival"
    TagPrefix="uc200" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../StyleSheets/DHEBAdder.css" rel="Stylesheet" type="text/css" />
    <title>Sample WorkFlow</title>
    <style type="text/css">
        .SearchDiv
        {
            visibility: hidden;
            z-index: 999;
            position: absolute;
            width: 180px;
            background-color: Teal;
            border-bottom-style: solid;
            border-bottom-width: medium;
            border-left-style: solid;
            border-left-width: medium;
            border-right-style: solid;
            border-right-width: medium;
            border-top-style: solid;
            border-top-width: medium;
            border-color: White;
        }
        .mdesampleselect
        {
            height: 200px;
            border: 1px solid #999999;
            width: 400px;
            background-color: Aqua;
        }
        .dropmenuScroll
        {
            max-height: 100px;
            overflow-y: scroll;
            position: absolute;
        }
        .okbtn
        {
            position: absolute;
            margin-left: -160px;
            left: 72%;
            width: 60px;
            bottom: 5px;
        }
        .Cancelbtn
        {
            position: absolute;
            margin-left: 190px;
            bottom: 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnSearch">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
        <div class="contentdata">
            <asp:UpdatePanel ID="up1" runat="server">
                <ContentTemplate>
                    <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="up1" runat="server">
                        <ProgressTemplate>
                                       <div id="progressBackgroundFilter" class="a-center">
                                       </div>
                                       <div id="processMessage" class="a-center w-20p">
                                           <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                       </div>
                                   </ProgressTemplate>

                    </asp:UpdateProgress>
                    <table id="tblContent" runat="server" class="a-center w-100p searchPanel">
                        <tr>
                            <td>
                                <asp:Panel ID="pnlSearch" CssClass="w-100p" runat="server" meta:resourcekey="pnlSearchResource1">
                                    <table id="totaltbl" runat="server" class="dataheaderInvCtrl w-100p a-center">
                                        <tr>
                                            <td>
                                                <table id="tblsearch" runat="server" class="w-100p a-center">
                                                    <tr>
                                                        <td class="w-10p a-right">
                                                            <asp:Label ID="lblManualArchive" runat="server" Text="Manual Archive" meta:resourcekey="lblManualArchiveResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:CheckBox ID="rbtnManualArchive" onclick="altercheck();" runat="server" 
                                                                meta:resourcekey="rbtnManualArchiveResource1" />
                                                        </td>
                                                        <td>
                                                            <div id="divmanualArchive" runat="server" style="display: none;">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblsampletype" runat="server" Text="Sample Type" meta:resourcekey="lblsampletypeResource1"></asp:Label>&nbsp
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddsampletype" CssClass="ddlsmall" runat="server" 
                                                                                meta:resourcekey="ddsampletypeResource1">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                        <td class="w-15p a-right">
                                                            <asp:Label ID="lblBarcode" runat="server" Text="BarcodeNumber" 
                                                                meta:resourcekey="lblBarcodeResource1"></asp:Label>
                                                        </td>
                                                        <td class="w-20p a-right">
                                                            <asp:TextBox ID="txtBarcode" runat="server" CssClass="small a-left" onblur="javascript:ShowSamples();"
                                                                meta:resourcekey="txtBarcodeResource1"></asp:TextBox>
                                                            <div id="divExtraSamples" runat="server" class="SearchDiv" style="margin-left: 300px;">
                                                            </div>
                                                        </td>
                                                        <td class="w-7p a-center">
                                                            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_OnClick"
                                                                OnClientClick="return ValidateBarCode();" CssClass="btn" Style="visibility: hidden"
                                                                meta:resourcekey="btnSearchResource1" />
                                                        </td>
                                                        <td>
                                                            <div id="divarchiveextrasample" style="display: none" runat="server">
                                                                <table id="tblarchiveextrasample" runat="server">
                                                                    <tr>
                                                                        <td class="w-20p a-right">
                                                                            <asp:Label ID="lblarchiveextrasample" runat="server" Text="Do you want to archive this sampe?"
                                                                                meta:resourcekey="lblarchiveextrasampleResource1"></asp:Label>
                                                                        </td>
                                                                        <td class="w-10p a-left">
                                                                            <asp:Button ID="btnyes" runat="server" Text=" Yes " CssClass="btn" OnClientClick="btnyesfn();"
                                                                                meta:resourcekey="btnyesResource1" />
                                                                            <asp:Button ID="btnno" runat="server" Text=" No " CssClass="btn" meta:resourcekey="btnnoResource1" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <div runat="server" id="divPatientDetails" style="display: none">
                                                    <ucPatientdet:PatientDetails ID="PatientDetail" runat="server" />
                                                </div>
                                                <table id="tblLegends" runat="server" class="a-right w-100p" style="display: none;">
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtCompleted" Enabled="false" BackColor="#90EE90" runat="server"
                                                                CssClass="w-10 h-10" meta:resourcekey="txtCompletedResource1"></asp:TextBox>
                                                            <asp:Label ID="lblCompleted" Text="Completed Samples" runat="server" meta:resourcekey="lblCompletedResource1"></asp:Label>
                                                            <asp:TextBox ID="txtPending" BackColor="#A9A9A9" Enabled="false" runat="server" CssClass="w-10 h-10"
                                                                meta:resourcekey="txtPendingResource1"></asp:TextBox>
                                                            <asp:Label ID="lblPending" runat="server" Text="Pending Samples" meta:resourcekey="lblPendingResource1"></asp:Label>
                                                            <asp:TextBox ID="txtNextstep" BackColor="#FFFF00" Enabled="false" runat="server"
                                                                CssClass="w-10 h-10" meta:resourcekey="txtNextstepResource1"></asp:TextBox>
                                                            <asp:Label ID="lblNextStep" runat="server" Text="Action to be taken" meta:resourcekey="lblNextStepResource1"></asp:Label>
                                                            <%--<asp:TextBox ID="txtExtraSamples" BackColor="#FFFF00" Enabled="false" runat="server"
                                                                                Width="10px" Height="10px"></asp:TextBox>
                                                                            <asp:Label ID="lblExtraSamples" runat="server" Text="Extra Samples"></asp:Label>--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table id="tblGridSampleDetails" runat="server" class="w-100p" style="display: none;">
                                                    <tr>
                                                        <td>
                                                            <asp:GridView ID="grdSampleDeatails" runat="server" CssClass="mytable1 w-100p"
                                                                AutoGenerateColumns="False" OnRowDataBound="grdSampleDeatails_OnRowDataBound"
                                                                OnRowCommand="grdSampleDeatails_OnRowCommand" meta:resourcekey="grdSampleDeatailsResource1">
                                                                <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                <HeaderStyle CssClass="dataheader1" />
                                                                <RowStyle BackColor="#FFFF00" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Select" Visible="False" meta:resourcekey="TemplateFieldResource1">
                                                                        <ItemTemplate>
                                                                            <asp:RadioButton ID="rdoSelect" runat="server" meta:resourcekey="rdoSelectResource1" />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Next Step" meta:resourcekey="TemplateFieldResource2">
                                                                        <ItemTemplate>
                                                                            <%#Container.DataItemIndex+1%>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Group Name" HeaderStyle-Width="15%" meta:resourcekey="TemplateFieldResource3">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblGroupName" runat="server" Text='<%# bind("Name") %>' meta:resourcekey="lblGroupNameResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="ID" Visible="false" meta:resourcekey="TemplateFieldResource4">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblID" runat="server" Text='<%# bind("ID") %>' meta:resourcekey="lblIDResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Accession Number" Visible="False" meta:resourcekey="TemplateFieldResource5">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAccessionNumber" runat="server" Text='<%# bind("AccessionNumber") %>'
                                                                                meta:resourcekey="lblAccessionNumberResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Investigation Name" meta:resourcekey="TemplateFieldResource6">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblInvestigationName" runat="server" Text='<%# bind("InvestigationName") %>'
                                                                                meta:resourcekey="lblInvestigationNameResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Group Sequence" Visible="False" meta:resourcekey="TemplateFieldResource7">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblGroupSequence" runat="server" Text='<%# bind("GroupSequence") %>'
                                                                                meta:resourcekey="lblGroupSequenceResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Analyser Sequence" Visible="False" meta:resourcekey="TemplateFieldResource8">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAnalyserSequence" runat="server" Text='<%# bind("AnalyserSequence") %>'
                                                                                meta:resourcekey="lblAnalyserSequenceResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Department Sequence" Visible="false" meta:resourcekey="TemplateFieldResource9">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDepartmentSequence" runat="server" Text='<%# bind("DeptSequence") %>'
                                                                                meta:resourcekey="lblDepartmentSequenceResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Department ID" Visible="false" meta:resourcekey="TemplateFieldResource10">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDepartmentID" runat="server" Text='<%# bind("DeptID") %>' meta:resourcekey="lblDepartmentIDResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Department Name" meta:resourcekey="TemplateFieldResource11">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDepartmentName" runat="server" Text='<%# bind("DeptName") %>' meta:resourcekey="lblDepartmentNameResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Instrument Name" meta:resourcekey="TemplateFieldResource12">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblInstrumentName" runat="server" Text='<%# bind("InstrumentName") %>'
                                                                                meta:resourcekey="lblInstrumentNameResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Status" meta:resourcekey="TemplateFieldResource13">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblStatus" runat="server" Text='<%# bind("Status") %>' meta:resourcekey="lblStatusResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Schedule DateTime" meta:resourcekey="TemplateFieldResource14">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblScheduleDateTime" runat="server" Text='<%# bind("ScheduleDateTime") %>'
                                                                                meta:resourcekey="lblScheduleDateTimeResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource15">
                                                                        <ItemTemplate>
                                                                            <%--<input id="btnShow" runat="server" value="show" class="btn" type="button" onclick="Show()" />--%>
                                                                            <asp:Button ID="btnShow" runat="server" Text="Check-In" CssClass="btn" Style="display: none;"
                                                                                CommandName="show" meta:resourcekey="btnShowResource1" />
                                                                            <asp:HiddenField ID="hdnValue" runat="server" Value='<%# bind("TrayIDs") %>' />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    <table id="tblGrdPendingSamples" runat="server" class="dataheaderInvCtrl w-100p"
                                        style="display: none;">
                                        <tr>
                                            <td>
                                                <asp:GridView ID="GrdPendingSamples" runat="server" CssClass="mytable1 w-100p" AutoGenerateColumns="False"
                                                    OnRowDataBound="GrdPendingSamples_OnRowDataBound" meta:resourcekey="GrdPendingSamplesResource1">
                                                    <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <RowStyle BackColor="#A9A9A9" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Select" Visible="False" meta:resourcekey="TemplateFieldResource16">
                                                            <ItemTemplate>
                                                                <asp:RadioButton ID="rdoSelect" runat="server" 
                                                                    meta:resourcekey="rdoSelectResource2" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Next Step" meta:resourcekey="TemplateFieldResource17">
                                                            <ItemTemplate>
                                                                <%#Container.DataItemIndex+1%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="GroupName" HeaderStyle-Width="15%" meta:resourcekey="TemplateFieldResource18">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblGroupName" runat="server" Text='<%# bind("Name") %>' meta:resourcekey="lblGroupNameResource2"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ID" Visible="False" meta:resourcekey="TemplateFieldResource19">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblID" runat="server" Text='<%# bind("ID") %>' meta:resourcekey="lblIDResource2"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="AccessionNumber" Visible="False" meta:resourcekey="TemplateFieldResource20">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAccessionNumber" runat="server" Text='<%# bind("AccessionNumber") %>'
                                                                    meta:resourcekey="lblAccessionNumberResource2"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="InvestigationName" meta:resourcekey="TemplateFieldResource21">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblInvestigationName" runat="server" Text='<%# bind("InvestigationName") %>'
                                                                    meta:resourcekey="lblInvestigationNameResource2"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="GroupSequence" Visible="False" meta:resourcekey="TemplateFieldResource22">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblGroupSequence" runat="server" Text='<%# bind("GroupSequence") %>'
                                                                    meta:resourcekey="lblGroupSequenceResource2"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="AnalyserSequence" Visible="False" meta:resourcekey="TemplateFieldResource23">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAnalyserSequence" runat="server" Text='<%# bind("AnalyserSequence") %>'
                                                                    meta:resourcekey="lblAnalyserSequenceResource2"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="DepartmentSequence" Visible="False" meta:resourcekey="TemplateFieldResource24">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDepartmentSequence" runat="server" Text='<%# bind("DeptSequence") %>'
                                                                    meta:resourcekey="lblDepartmentSequenceResource2"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="DepartmentID" Visible="False" meta:resourcekey="TemplateFieldResource25">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDepartmentID" runat="server" Text='<%# bind("DeptID") %>' meta:resourcekey="lblDepartmentIDResource2"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="DepartmentName" meta:resourcekey="TemplateFieldResource26">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDepartmentName" runat="server" Text='<%# bind("DeptName") %>' meta:resourcekey="lblDepartmentNameResource2"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="InstrumentName" meta:resourcekey="TemplateFieldResource27">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblInstrumentName" runat="server" Text='<%# bind("InstrumentName") %>'
                                                                    meta:resourcekey="lblInstrumentNameResource2"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Status" meta:resourcekey="TemplateFieldResource28">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblStatus" runat="server" Text='<%# bind("Status") %>' meta:resourcekey="lblStatusResource2"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Schedule DateTime" meta:resourcekey="TemplateFieldResource29">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblScheduleDateTime" runat="server" Text='<%# bind("ScheduleDateTime") %>'
                                                                    meta:resourcekey="lblScheduleDateTimeResource2"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                    <table id="tblGrdCompletedSamples" runat="server" class="dataheaderInvCtrl w-100p"
                                        style="display: none;">
                                        <tr>
                                            <td>
                                                <asp:GridView ID="GrdCompletedSamples" runat="server" CssClass="mytable1 gridView"
                                                    AutoGenerateColumns="False" OnRowDataBound="GrdCompletedSamples_OnRowDataBound"
                                                    meta:resourcekey="GrdCompletedSamplesResource1">
                                                    <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Select" Visible="False" meta:resourcekey="TemplateFieldResource30">
                                                            <ItemTemplate>
                                                                <asp:RadioButton ID="rdoSelect" runat="server" 
                                                                    meta:resourcekey="rdoSelectResource3" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Next Step" meta:resourcekey="TemplateFieldResource31">
                                                            <ItemTemplate>
                                                                <%#Container.DataItemIndex+1%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="GroupName" HeaderStyle-Width="15%" meta:resourcekey="TemplateFieldResource32">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblGroupName" runat="server" Text='<%# bind("Name") %>' meta:resourcekey="lblGroupNameResource3"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="ID" Visible="False" meta:resourcekey="TemplateFieldResource33">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblID" runat="server" Text='<%# bind("ID") %>' meta:resourcekey="lblIDResource3"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="AccessionNumber" Visible="False" meta:resourcekey="TemplateFieldResource34">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAccessionNumber" runat="server" Text='<%# bind("AccessionNumber") %>'
                                                                    meta:resourcekey="lblAccessionNumberResource3"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="InvestigationName" meta:resourcekey="TemplateFieldResource35">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblInvestigationName" runat="server" Text='<%# bind("InvestigationName") %>'
                                                                    meta:resourcekey="lblInvestigationNameResource3"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="GroupSequence" Visible="False" meta:resourcekey="TemplateFieldResource36">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblGroupSequence" runat="server" Text='<%# bind("GroupSequence") %>'
                                                                    meta:resourcekey="lblGroupSequenceResource3"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="AnalyserSequence" Visible="False" meta:resourcekey="TemplateFieldResource37">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAnalyserSequence" runat="server" Text='<%# bind("AnalyserSequence") %>'
                                                                    meta:resourcekey="lblAnalyserSequenceResource3"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="DepartmentSequence" Visible="False" meta:resourcekey="TemplateFieldResource38">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDepartmentSequence" runat="server" Text='<%# bind("DeptSequence") %>'
                                                                    meta:resourcekey="lblDepartmentSequenceResource3"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="DepartmentID" Visible="False" meta:resourcekey="TemplateFieldResource39">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDepartmentID" runat="server" Text='<%# bind("DeptID") %>' meta:resourcekey="lblDepartmentIDResource3"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="DepartmentName" meta:resourcekey="TemplateFieldResource40">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDepartmentName" runat="server" Text='<%# bind("DeptName") %>' meta:resourcekey="lblDepartmentNameResource3"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="InstrumentName" meta:resourcekey="TemplateFieldResource41">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblInstrumentName" runat="server" Text='<%# bind("InstrumentName") %>'
                                                                    meta:resourcekey="lblInstrumentNameResource3"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Status" meta:resourcekey="TemplateFieldResource42">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblStatus" runat="server" Text='<%# bind("Status") %>' meta:resourcekey="lblStatusResource3"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Schedule DateTime" meta:resourcekey="TemplateFieldResource43">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblScheduleDateTime" runat="server" Text='<%# bind("ScheduleDateTime") %>'
                                                                    meta:resourcekey="lblScheduleDateTimeResource3"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input id="btnDummy1" runat="server" style="display: none;" type="button" />
                                <ajc:ModalPopupExtender ID="mpexSampleArchival" runat="server" TargetControlID="btnDummy1"
                                    DynamicServicePath="" Enabled="True" PopupControlID="InvPanel" BackgroundCssClass="modalBackground">
                                </ajc:ModalPopupExtender>
                                <ajc:ModalPopupExtender ID="mpesampleselection" PopupControlID="pnlsampleselect"
                                    CancelControlID="btnClose" DynamicServicePath="" runat="server" BehaviorID="mpesampleselectionpopup"
                                    Enabled="true" TargetControlID="btnyes" BackgroundCssClass="modalBackground">
                                </ajc:ModalPopupExtender>
                                <asp:Panel ID="InvPanel" runat="server" Width="950px" Height="500px" ScrollBars="Vertical"
                                    Style="display: none;" CssClass="modalPopup dataheaderPopup" meta:resourcekey="InvPanelResource1">
                                    <table class="dataheader2" class="w-100p bold" style="font-family: verdana;">
                                        <tr>
                                            <td>
                                                <uc200:SampleArchival ID="ucSampleArchival" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="BtnFinish" runat="server" CssClass="btn" Text="Finish" meta:resourcekey="Rs_btnSaveSampleArchivalResource1"
                                    OnClick="BtnFinish_Click" Style="display: none;" />
                            </td>
                        </tr>
                    </table>
                    <asp:HiddenField ID="hdnExtraSampleID" runat="server" />
                    <div>
                        <asp:Panel ID="pnlsampleselect" Width="360px" Height="130px" runat="server" CssClass="modalPopup dataheaderPopup"
                            meta:resourcekey="pnlsampleselectResource2">
                            <table>
                                <tr class="a-right">
                                    <td class="w-98p">
                                    </td>
                                    <td class="a-right">
                                        <img id="imgmpesampleselectionClose" visible="false" onclick="$get('btnClose').click()"
                                            alt="Close" src="../Images/close_button.gif" style="cursor: pointer;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left">
                                        <asp:Label ID="lblselectsample" CssClass="font13" Text="Select Sample Type" Font-Bold="true"
                                            runat="server" meta:resourcekey="lblselectsampleResource2"></asp:Label>&nbsp&nbsp&nbsp
                                        <asp:DropDownList ID="ddSampletypelist" runat="server" Font-Bold="true" onmousedown="this.size=5;"
                                            onfocusout="this.size=1;" ondblclick="this.size=1;" class="" CssClass="dropmenuScroll ddlsmall"
                                            Style="position: absolute !important;" AppendDataBoundItems="True" 
                                            meta:resourcekey="ddSampletypelistResource3">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                            <asp:Button ID="btnokClose" runat="server" Text="Ok" CssClass="okbtn" OnClick="btnSearch_OnClick"
                                meta:resourcekey="btnokCloseResource2" />
                            <asp:Button ID="btnClose" runat="server" Text="Cancel" CssClass="Cancelbtn" meta:resourcekey="btnCloseResource2" />
                        </asp:Panel>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />

    <script type="text/javascript">

        function Show(hdnTryID, hdnBuldID, hdnFloorID, hdnStroageID, hdnStorgeUnit, hdnDeptID, hdnInstrumentID, hdnNewBarcode, hdnRowNo, hdnColNo) {
            $('#ucSampleArchival_hdnTryID').val(hdnTryID);
            $('#ucSampleArchival_hdnBuldID').val(hdnBuldID);
            $('#ucSampleArchival_hdnFloorID').val(hdnFloorID);
            $('#ucSampleArchival_hdnStroageID').val(hdnStroageID);
            $('#ucSampleArchival_hdnStorgeUnit').val(hdnStorgeUnit);
            $('#ucSampleArchival_hdnDeptID').val(hdnDeptID);
            $('#ucSampleArchival_hdnInstrumentID').val(hdnInstrumentID);
            $('#ucSampleArchival_hdnNewBarcode').val(hdnNewBarcode);
            $('#ucSampleArchival_hdnColNo').val(hdnColNo);
            $('#ucSampleArchival_hdnRowNo').val(hdnRowNo);
            // $find('mpexSampleArchival').show();
            var BtnFinish = document.getElementById('BtnFinish');
            BtnFinish.click();

        }

        function Close() {
            $find('mpexSampleArchival').hide();
            return false;
        }

        function ValidateBarCode() {
            var AlrtWinHdr = SListForAppMsg.Get("Lab_SampleWorkFlow_aspx_Alert") != null ? SListForAppMsg.Get("Lab_SampleWorkFlow_aspx_Alert") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Lab_SampleWorkFlow_aspx_01") != null ? SListForAppMsg.Get("Lab_SampleWorkFlow_aspx_01") : "Provide The Barcode";
            if (document.getElementById('txtBarcode').value == '') {
                //alert('Provide The Barcode');
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                return false;
            }
            return true;

        }
        function ShowSamples() {
            //  debugger;
            var AlrtWinHdr = SListForAppMsg.Get("Lab_SampleWorkFlow_aspx_Alert") != null ? SListForAppMsg.Get("Lab_SampleWorkFlow_aspx_Alert") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Lab_SampleWorkFlow_aspx_02") != null ? SListForAppMsg.Get("Lab_SampleWorkFlow_aspx_02") : "Error";
            var rdb = '';
            var Barcode = document.getElementById('txtBarcode').value;
            if (Barcode.length == 9) {
                $('#btnSearch').css('visibility', 'hidden');
                $('#divExtraSamples').empty();
                $('#divExtraSamples').css('visibility', 'hidden');
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../WebService.asmx/ShowSamplesforBarcode",
                    data: JSON.stringify({ BarcodeNumber: Barcode }),
                    dataType: "json",
                    async: false,
                    success: function(data) {
                        if (data.d.length >= 1) {
                            $('#divExtraSamples').css('visibility', 'visible');
                            var Items = data.d;
                            $.each(Items, function(index, Item) {
                                rdb = "<input id=RadioButton" + index + "  type=radio style='align:left' name=RadioforSamples value=" + Item.SampleCode + " onclick=SelectedSample(this); /><label for=RadioButton" + index + ">" + Item.SampleDesc + "</label></br>";
                                $('#divExtraSamples').append(rdb);

                            });
                        }
                    },
                    error: function(result) {
                    ValidationWindow(AlrtWinHdr, UsrAlrtMsg);  
                        //alert("Error");
                    }
                });
            }
            else {
                $('#btnSearch').css('visibility', 'visible');
            }

        }
        function SelectedSample(obj) {

            var ExtraSampleId = $(obj)[0].value;
            document.getElementById('hdnExtraSampleID').value = ExtraSampleId;
            // $('#divExtraSamples').css('visibility', 'hidden');
            $('#btnSearch').css('visibility', 'visible');
        }
        function altercheck() {
            if (document.getElementById('rbtnManualArchive').checked == false) {

                document.getElementById('divmanualArchive').style.display = 'none';
            }
            else if (document.getElementById('rbtnManualArchive').checked == true) {

                document.getElementById('divmanualArchive').style.display = 'block';
            }


        }
        function closepnlsampleselect() {
            $('mpesampleselection').hide();
        }
            
    </script>

    </form>
</body>
</html>
