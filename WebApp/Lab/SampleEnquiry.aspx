<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SampleEnquiry.aspx.cs" EnableEventValidation="false"
    Inherits="Lab_SampleEnquiry" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Sample Enquiry</title>

    <script src="../Scripts/jquery-1.11.3.min.js" type="text/javascript"></script>

    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .testclass
        {
            display: none;
        }
        td
        {
            cursor: pointer;
        }
        .selected_row
        {
            background-color: #A1DCF2;
        }
    </style>
    </style>
</head>
<body>
    <form id="form1" defaultbutton="btnSubmit" defaultfocus="txtBarcodeSample" runat="server">
    <asp:ScriptManager ID="ScriptManager1" ScriptMode="Release" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="updatePanel1" UpdateMode="Conditional" runat="server">
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
            </Triggers>
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="updatePanel1" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter" class="a-center">
                        </div>
                        <div id="processMessage" class="a-center w-20p">
                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <div class="w-100p">
                    <div class="w-100p">
                        <table class="w-100p lh30">
                            <tr>
                                <td class="w-25p">
                                    <asp:Label runat="server" CssClass="marginR15" ID="lblBarcodeSample" Text="Lab Number/Barcode"></asp:Label>
                                    <asp:TextBox ID="txtBarcodeSample" runat="server" Width="100px" MaxLength="12"></asp:TextBox>
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                    <asp:Button ID="btnSubmit" runat="server" ToolTip="Submit" CssClass="btn pointer"
                                        Text="Submit" OnClientClick="return submitbutton();" OnClick="btnSubmit_Click" />
                                </td>
                                <td class="w-20p">
                                    <asp:Label runat="server" ID="Label1" CssClass="marginR15" Text="Printer"></asp:Label>
                                    <asp:DropDownList ID="ddlPrinters" runat="server" Style="max-width: 100px !important;"
                                        CssClass="ddlsmall">
                                    </asp:DropDownList>
                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                    <asp:Button ID="btnPrint" runat="server" CssClass="btn pointer" Text="Print" OnClientClick="return ValidatePrinter();"
                                        OnClick="btnPrint_Click" />
                                </td>
                                <td> <%--class="w-17p"--%>
                                    <asp:Label ID="dept" runat="server" CssClass="marginR15" Text="Team"></asp:Label>
                                    <asp:DropDownList ID="ddlDepartment" runat="server" Style="max-width: 200px !important;"
                                        CssClass="ddl" AutoPostBack="true" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td class="w-15p">
                                    <asp:Label ID="Label3" runat="server" CssClass="marginR15" Text="Barcode Type"></asp:Label>
                                    <asp:DropDownList ID="ddlBarcodeType" CssClass="ddl" runat="server" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlBarcodeType_SelectedIndexChanged">
                                        <asp:ListItem Selected="True" Value="-1">--Both--</asp:ListItem>
                                        <asp:ListItem Value="0">Primary</asp:ListItem>
                                        <asp:ListItem Value="1">Secondary</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <div runat="server" id="divAction" style="display: none">
                                        <table id="tblaction" runat="server">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label2" Text="Action" runat="server"></asp:Label>
                                                    <asp:DropDownList ID="ddlAction" AutoPostBack="true" CssClass="ddl" runat="server"
                                                        OnSelectedIndexChanged="ddlAction_SelectedIndexChanged">
                                                        <%--onchange="ShowReason();" --%>
                                                        <asp:ListItem Selected="True" Value="-1">--Select--</asp:ListItem>
                                                        <asp:ListItem Value="Reject_Sample_SampleSearch">Reject Sample</asp:ListItem>
                                                        <asp:ListItem Value="Not_Given_Sample_Enquiery">Not Given</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td id="dReason" runat="server" style="display: none;">
                                                    <asp:DropDownList ID="ddlReason" runat="server" Width="100px" normalWidth="100px"
                                                        CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                </td>
                                                <%--onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);" --%>
                                                <td>
                                                    <asp:Button ID="btnOk" runat="server" Text="Ok" CssClass="btn pointer" OnClientClick="return Validate();"
                                                        OnClick="btnOK_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <%--<asp:DropDownList ID="ddlBarcodeType" runat="server" CssClass="ddl" OnSelectedIndexChanged="ddlBarcodeType_SelectedIndexChanged">
                            <asp:ListItem Selected="True" Value="-1">--Select--</asp:ListItem>
                            <asp:ListItem Value="1">Primary</asp:ListItem>
                            <asp:ListItem Value="2">Secondary</asp:ListItem>
                        </asp:DropDownList>--%>
                        <asp:Button ID="btnFilter" runat="server" Visible="false" CssClass="btn pointer"
                            Text="Filter" OnClientClick="return hidegrid();" />
                    </div>
                    <div align="left">
                    </div>
                </div>
                <div>
                    <asp:Panel ID="pnl1" runat="server" style="overflow-y: scroll !Important;">
                        <div runat="server" style="height: 280px !important" id="gv">
                            <asp:GridView ID="GridView1" runat="server" CssClass="mytable1 w-100p gridView" PagerStyle-Font-Bold="true"
                                ForeColor="#333333" AutoGenerateColumns="False" OnRowDataBound="GridView1_RowDataBound"
                                OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                                <%--AllowPaging="True" PageSize="10" OnPageIndexChanging="GridView1_PageIndexChanging" PagerSettings-Mode="NumericFirstLast"--%>
                                <%--<PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast"
                                    PageButtonCount="10" />--%>
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="chkAll" CssClass="Parent" runat="server" Text=" " onclick="SelectAllSampleEnquiry(this.id);" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkPrint" CssClass="Child" runat="server" Text=" " onclick="checkUncheckHeaderCheckBox(this.id);" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" HeaderText="Sl.No"
                                        ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                            <asp:HiddenField ID="hdIsSecondaryBarcode" runat="server" Value='<%# bind("IsSecBarCode") %>' />
                                            <asp:HiddenField ID="hfBarcodenumber" Value='<%# Eval("BarcodeNumber") %>' runat="server" />
                                            <%--<asp:HiddenField ID="hfDepartmentId" Value='<%# Eval("DeptId") %>' runat="server" />--%>
                                            <asp:HiddenField ID="hdnLabNumber" runat="server" Value='<%# bind("LabNumber") %>' />
                                            <asp:HiddenField ID="hdnBarcodeNumber" runat="server" Value='<%# bind("BarcodeNumber") %>' />
                                            <asp:HiddenField ID="hdnDeptName" runat="server" Value='<%# bind("DeptName") %>' />
                                            <asp:HiddenField ID="hdnPatientRegisterdType" runat="server" Value='<%# bind("PatientRegisterdType") %>' />
                                            <asp:HiddenField ID="hdnScanCount" runat="server" Value='<%# bind("ScanCount") %>' />
                                            <asp:HiddenField ID="hdnReceivedTime" runat="server" Value='<%# bind("ReceivedTime") %>' />
                                            <asp:HiddenField ID="hdnSampleStatus" runat="server" Value='<%# bind("SampleStatus") %>' />
                                            <asp:HiddenField ID="hdnCollectionCenter" runat="server" Value='<%# bind("CollectionCenter") %>' />
                                            <asp:HiddenField ID="hdnReportDateTime" runat="server" Value='<%# bind("ReportDateTime") %>' />
                                            <asp:HiddenField ID="hdnVisitid" runat="server" Value='<%# bind("VisitID") %>' />
                                            <asp:HiddenField ID="hdnORDStatus" runat="server" Value='<%# bind("Status") %>' />
                                            <asp:HiddenField ID="hfSampleStatusId" runat="server" Value='<%# bind("SampleStatusId") %>' />
                                            <%--<asp:HiddenField ID="hdnAccessionNo" runat="server" Value='<%# bind("AccessionNo") %>' />--%>
                                            <asp:HiddenField ID="hdnSampleid" runat="server" Value='<%# bind("SampleId") %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" Width="5%" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Lab No" ItemStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkLabNumber" runat="server" Style="color: Blue" Text='<%# Eval("LabNumber") %>' />
                                        </ItemTemplate>
                                        <ItemStyle Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Barcode" ItemStyle-Width="10%">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkBarcode" runat="server" Style="color: Blue" Text='<%# Eval("BarcodeNumber") %>' />
                                        </ItemTemplate>
                                        <ItemStyle Width="10%" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="SampleType" HeaderText="Sample Type" />
                                    <asp:BoundField DataField="Container" HeaderText="Container" />
                                    <asp:BoundField DataField="TeamName" HeaderText="Team Custody" />
                                    <%--<asp:BoundField DataField="DeptName" HeaderText="Department" />--%>
                                    <asp:BoundField DataField="PatientRegisterdType" HeaderText="Patient Registered Type" />
                                    <asp:BoundField DataField="ScanCount" HeaderText="Scan Count" />
                                    <asp:BoundField DataField="ReceivedTime" HeaderText="Received Time" />
                                    <asp:BoundField DataField="SampleStatus" HeaderText="Sample Status" />
                                    <asp:BoundField DataField="CollectionCenter" HeaderText="Collection Center" />
                                    <asp:TemplateField HeaderText="Report Due Date" ItemStyle-Width="10%">
                                        <ItemTemplate>
                                            <asp:Label ID="tatDate" runat="server" Text='<%#Eval("ReportDateTime").ToString()=="01/01/1753 00:00:00" || Eval("ReportDateTime").ToString()=="01/01/0001 00:00:00" ? " ":Eval("ReportDateTime") %>' />
                                        </ItemTemplate>
                                        <ItemStyle Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Print">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkSecondaryBarcode" Enabled="False" runat="server" Text=" " />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <%--<PagerStyle Font-Bold="True" />--%>
                            </asp:GridView>
                        </div>
                    </asp:Panel>
                    <br />
                    <asp:Panel ID="Panel2" runat="server" Style="height: 210px !important; overflow-y: scroll !Important;">
                        <div id="SampleDetail" style="height: 200px !important" runat="server">
                            <ajc:TabContainer ID="grouptab" runat="server" ActiveTabIndex="0">
                                <ajc:TabPanel ID="SampleDetails" runat="server" HeaderText="Sample Details">
                                    <HeaderTemplate>
                                        Sample Details
                                    </HeaderTemplate>
                                    <ContentTemplate>
                                        <div class="contentdata">
                                            <asp:GridView ID="GridView2" runat="server" Font-Size="Smaller" AllowPaging="false"
                                                CssClass="mytable1 w-100p gridView" AutoGenerateColumns="False" ForeColor="#333333"
                                                OnRowDataBound="GridView2_RowDataBound" OnPageIndexChanging="GridView2_PageIndexChanging">
                                                <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Report Due Date" ItemStyle-Width="10%">
                                                        <ItemTemplate>
                                                            <asp:Label ID="tatDate" runat="server" Text='<%#Eval("ReportDateTime").ToString()=="01/01/1753 00:00:00" || Eval("ReportDateTime").ToString()=="01/01/0001 00:00:00"? " ":Eval("ReportDateTime") %>' />
                                                        </ItemTemplate>
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="RegisteredLocation" HeaderText="Registered Location" />
                                                    <asp:BoundField DataField="ProcessingLocation" HeaderText="Processing Location" />
                                                    <asp:BoundField DataField="LocationName" HeaderText="Out Source Location" />
                                                    <asp:BoundField DataField="DeptName" HeaderText="Department" />
                                                    <asp:BoundField DataField="InvestigationName" HeaderText="Test Name" />
                                                    <asp:BoundField DataField="InvestigationCode" HeaderText="Test Code" />
                                                    <asp:BoundField DataField="Status" HeaderText="Test Status" />
                                                </Columns>
                                                <PagerStyle Font-Bold="True" />
                                            </asp:GridView>
                                        </div>
                                    </ContentTemplate>
                                </ajc:TabPanel>
                                <ajc:TabPanel ID="TabPanel1" runat="server" HeaderText="Sample Details">
                                    <HeaderTemplate>
                                        Tracking
                                    </HeaderTemplate>
                                    <ContentTemplate>
                                        <div class="contentdata">
                                            <asp:GridView ID="GridView3" runat="server" PageSize="10" AllowPaging="false" CssClass="mytable1 w-100p gridView "
                                                AutoGenerateColumns="False" ForeColor="#333333" OnPageIndexChanging="GridView3_PageIndexChanging"
                                                PagerStyle-Font-Bold="true" PagerSettings-Mode="NumericFirstLast">
                                                <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast"
                                                    PageButtonCount="10" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="S.No">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Status" HeaderText="Event Type" />
                                                    <asp:BoundField DataField="TeamName" HeaderText="Team" />
                                                    <asp:BoundField DataField="CreatedAt" HeaderText="Event Date" />
                                                    <asp:BoundField DataField="Location" HeaderText="Location" />
                                                    <%--<asp:BoundField DataField="DeptName" HeaderText="Department" />--%>
                                                    <asp:BoundField DataField="LoginName" HeaderText="User Name" />
                                                </Columns>
                                                <%--<PagerStyle CssClass="PagerStyle" />--%>
                                            </asp:GridView>
                                        </div>
                                    </ContentTemplate>
                                </ajc:TabPanel>
                            </ajc:TabContainer>
                        </div>
                    </asp:Panel>
                </div>
                <asp:HiddenField ID="hdnBarcode" runat="server" />
                <asp:HiddenField ID="hdnActionName" runat="server" />
                <asp:HiddenField ID="hdnPatientVisitID" runat="server" />
                <asp:HiddenField ID="HdnSampleEnquiryCheckBoxId" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <%--<div>
        <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
            <div style="height: auto" runat="server" id="Div1">
                <asp:GridView ID="GridView4" runat="server" CssClass="mytable1 w-100p gridView" PagerStyle-Font-Bold="true"
                    ForeColor="#333333" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="False"
                    AllowPaging="True" PageSize="10" OnPageIndexChanging="GridView1_PageIndexChanging"
                    OnRowDataBound="GridView1_RowDataBound" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                    <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast"
                        PageButtonCount="10" />
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkAll" CssClass="Parent" runat="server" Text=" " onclick="SelectAllSampleEnquiry(this.id);" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkPrint" CssClass="Child" runat="server" Text=" " onclick="checkUncheckHeaderCheckBox(this.id);" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" HeaderText="Sl.No"
                            ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                                <asp:HiddenField ID="hdIsSecondaryBarcode" runat="server" Value='<%# bind("IsSecBarCode") %>' />
                                <asp:HiddenField ID="hfBarcodenumber" Value='<%# Eval("BarcodeNumber") %>' runat="server" />
                                <%--<asp:HiddenField ID="hfDepartmentId" Value='<%# Eval("DeptId") %>' runat="server" />
                                <asp:HiddenField ID="hdnLabNumber" runat="server" Value='<%# bind("LabNumber") %>' />
                                <asp:HiddenField ID="hdnBarcodeNumber" runat="server" Value='<%# bind("BarcodeNumber") %>' />
                                <asp:HiddenField ID="hdnDeptName" runat="server" Value='<%# bind("DeptName") %>' />
                                <asp:HiddenField ID="hdnPatientRegisterdType" runat="server" Value='<%# bind("PatientRegisterdType") %>' />
                                <asp:HiddenField ID="hdnScanCount" runat="server" Value='<%# bind("ScanCount") %>' />
                                <asp:HiddenField ID="hdnReceivedTime" runat="server" Value='<%# bind("ReceivedTime") %>' />
                                <asp:HiddenField ID="hdnSampleStatus" runat="server" Value='<%# bind("SampleStatus") %>' />
                                <asp:HiddenField ID="hdnCollectionCenter" runat="server" Value='<%# bind("CollectionCenter") %>' />
                                <asp:HiddenField ID="hdnReportDateTime" runat="server" Value='<%# bind("ReportDateTime") %>' />
                                <asp:HiddenField ID="hdnVisitid" runat="server" Value='<%# bind("VisitID") %>' />
                                <asp:HiddenField ID="hdnORDStatus" runat="server" Value='<%# bind("Status") %>' />
                                <asp:HiddenField ID="hfSampleStatusId" runat="server" Value='<%# bind("SampleStatusId") %>' />
                                <%--<asp:HiddenField ID="hdnAccessionNo" runat="server" Value='<%# bind("AccessionNo") %>' />
                                <asp:HiddenField ID="hdnSampleid" runat="server" Value='<%# bind("SampleId") %>' />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" Width="5%" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Lab No" ItemStyle-Width="5%">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkLabNumber" runat="server" Style="color: Blue" Text='<%# Eval("LabNumber") %>' />
                            </ItemTemplate>
                            <ItemStyle Width="5%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Barcode" ItemStyle-Width="10%">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkBarcode" runat="server" Style="color: Blue" Text='<%# Eval("BarcodeNumber") %>' />
                            </ItemTemplate>
                            <ItemStyle Width="10%" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="SampleType" HeaderText="Sample Type" />
                        <asp:BoundField DataField="Container" HeaderText="Container" />
                        <asp:BoundField DataField="TeamName" HeaderText="Team Custody" />
                        <%--<asp:BoundField DataField="DeptName" HeaderText="Department" />
                        <asp:BoundField DataField="PatientRegisterdType" HeaderText="Patient Registered Type" />
                        <asp:BoundField DataField="ScanCount" HeaderText="Scan Count" />
                        <asp:BoundField DataField="ReceivedTime" HeaderText="Received Time" />
                        <asp:BoundField DataField="SampleStatus" HeaderText="Sample Status" />
                        <asp:BoundField DataField="CollectionCenter" HeaderText="Collection Center" />
                        <asp:BoundField DataField="ReportDateTime" HeaderText="Report Due Date" />
                        <asp:TemplateField HeaderText="Print">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSecondaryBarcode" Enabled="False" runat="server" Text=" " />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle Font-Bold="True" />
                </asp:GridView>
            </div>
        </asp:Panel>
        <br />
        <asp:Panel ID="Panel3" runat="server" ScrollBars="Auto">
            <div id="Div2" runat="server">
                <ajc:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0">
                    <ajc:TabPanel ID="TabPanel2" runat="server" HeaderText="Sample Details">
                        <HeaderTemplate>
                            Sample Details
                        </HeaderTemplate>
                        <ContentTemplate>
                            <div class="contentdata">
                                <asp:GridView ID="GridView5" runat="server" Font-Size="Smaller" AllowPaging="True"
                                    CssClass="mytable1 w-100p gridView" AutoGenerateColumns="False" ForeColor="#333333"
                                    OnRowDataBound="GridView2_RowDataBound" OnPageIndexChanging="GridView2_PageIndexChanging">
                                    <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="ReportDateTime" HeaderText="Internal Due Date" />
                                        <asp:BoundField DataField="RegisteredLocation" HeaderText="Registered Location" />
                                        <asp:BoundField DataField="ProcessingLocation" HeaderText="Processing Location" />
                                        <asp:BoundField DataField="LocationName" HeaderText="Out Source Location" />
                                        <asp:BoundField DataField="DeptName" HeaderText="Department" />
                                        <asp:BoundField DataField="InvestigationName" HeaderText="Test Name" />
                                        <asp:BoundField DataField="InvestigationCode" HeaderText="Test Code" />
                                        <asp:BoundField DataField="Status" HeaderText="Test Status" />
                                    </Columns>
                                    <PagerStyle Font-Bold="True" />
                                </asp:GridView>
                            </div>
                        </ContentTemplate>
                    </ajc:TabPanel>
                    <ajc:TabPanel ID="TabPanel3" runat="server" HeaderText="Sample Details">
                        <HeaderTemplate>
                            Tracking
                        </HeaderTemplate>
                        <ContentTemplate>
                            <div class="contentdata">
                                <asp:GridView ID="GridView6" runat="server" PageSize="10" AllowPaging="True" CssClass="mytable1 w-100p gridView "
                                    AutoGenerateColumns="False" ForeColor="#333333" OnPageIndexChanging="GridView3_PageIndexChanging"
                                    PagerStyle-Font-Bold="true" PagerSettings-Mode="NumericFirstLast">
                                    <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast"
                                        PageButtonCount="10" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Status" HeaderText="Event Type" />
                                        <asp:BoundField DataField="CreatedAt" HeaderText="Event Date" />
                                        <asp:BoundField DataField="Location" HeaderText="Location" />
                                        <asp:BoundField DataField="DeptName" HeaderText="Department" />
                                        <asp:BoundField DataField="LoginName" HeaderText="User Name" />
                                    </Columns>
                                    <PagerStyle CssClass="PagerStyle" />
                                </asp:GridView>
                            </div>
                        </ContentTemplate>
                    </ajc:TabPanel>
                </ajc:TabContainer>
            </div>
        </asp:Panel>
    </div>--%>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            $('#SampleDetail').css("display", "none");

        });
        function submitbutton() {
            var s = true;
            $('#dReason').css("display", "none");
            if ($('#txtBarcodeSample').val() == '') {
                alert('Please enter Lab Number/Barcode.');
                s = false;
            }
            return s;
        }

        function blurd() {

            submitbutton();
        }
        function hidegrid() {
            if ($('#GridView1:visible') == true) {
                $('#SampleDetail').css("display", "block");
                return true;
            }
            else {
                $('#SampleDetail').css("display", "none");
                $('#wrapper').addClass("contentdata");
                return false;
            }
        }

        function highlite(m) {
            debugger;
            var tr = null;
            var gv = document.getElementById("<%= GridView1.ClientID %>");
            var items = $('#GridView1 input[name$="chkPrint"]');
            var count = 0;
            if (items.length > 0) {
                for (var i = 0; i < items.length; i++) {
                    count = 1 + i;
                    if (items[i].checked) {
                        $('#GridView1 tr').eq(count).removeAttr("style");
                        $('#GridView1 tr').eq(count).css("cssText", "background-color:#99E5E5 !important;");
                    }
                    else {
                        var c = 1 + parseInt(m);
                        $('#GridView1 tr').eq(c).removeAttr("style");
                        $('#GridView1 tr').eq(c).css("cssText", "background-color:yellow !important;");
                    }
                }
            }


        }

        function ValidatePrinter() {
            debugger;
            $('#SampleDetail').css("display", "none");
            if ($('#ddlPrinters').val() == '-1') {
                alert('Please select printer', 'Alert');
                return false;
            }
            else if ($('#GridView1:visible').length == 0) {
                alert('Record is not available to print.', 'Alert');
                return false;
            }
            else if ($('#GridView1 input[name$="chkPrint"]:checked').length == 0) {
                alert('Record is not selcted for print.', 'Alert');
                return false;
            }
            else if ($('#GridView1').length > 0 && $('#GridView1 input[name$="chkPrint"]:checked').length > 0) {
                return true;
            }
        }

        function Validate() {
            hidegrid();
            var SampleStatus;
            var row;
            var SelectedValue;
            var istrue = true;
            var checkBoxSelector = '#<%=GridView1.ClientID%> input[id*="chkPrint"]:checkbox';
            var totalCkboxes = $(checkBoxSelector),
                checkedCheckboxes = totalCkboxes.filter(":checked")
            document.getElementById('hdnActionName').value = $('#ddlAction :selected').val();
            SampleStatus = validateSampleStatus();
            if ($('#ddlAction :selected').val() == '-1') {
                alert("Select Action", "Alert");
                istrue = false;
            }
            else if (($('#ddlAction :selected').val() == 'Reject_Sample_SampleSearch') && ($('#ddlReason :selected').val() == '-1')) {
                alert("Select Reason", "Alert");
                istrue = false;
            }
            else if (($('#ddlAction :selected').val() == 'Not_Given_Sample_Enquiery') && ($('#ddlReason :selected').val() == '-1')) {
                alert("Select Reason", "Alert");
                istrue = false;
            }
            else if ($('#GridView1 input[name$="chkPrint"]:checked').length == 0) {
                alert("Select Sample", "Alert");
                istrue = false;
            }
            else if (checkedCheckboxes.length > 1) {

                if (($('#ddlAction :selected').val() == 'Reject_Sample_SampleSearch') || ($('#ddlAction :selected').val() == 'Not_Given_Sample_Enquiery')) {
                    alert("Dont Select more than one sample");
                    istrue = false;
                }
            }
            else if (!validateUnregistered()) {
                istrue = false;
            }
            else if (istrue && ($('#ddlAction :selected').val() == 'Reject_Sample_SampleSearch') && SampleStatus == "Rejected") {
                alert("Sample is already Rejected.");
                $('#ddlAction').val(-1);
                $('#dReason').val(-1);
                $('#dReason').css("display", "none");
                $('input[id$=chkPrint]').removeAttr("checked");
                $('#GridView1_ctl01_chkAll').removeAttr("checked");
                $('#GridView1 tr').removeAttr("style");
                istrue = false;
            }
            else if (istrue && ($('#ddlAction :selected').val() == 'Reject_Sample_SampleSearch') && (SampleStatus == "Collected" || SampleStatus == "Received")) {
                return confirm('Are you sure to Reject the sample?');
            }
            else if (istrue && ($('#ddlAction :selected').val() == 'Not_Given_Sample_Enquiery') && SampleStatus == "Not given") {
                alert("Sample is already in Not Given status.");
                $('#ddlAction').val(-1);
                $('#dReason').val(-1);
                $('#dReason').css("display", "none");
                $('input[id$=chkPrint]').removeAttr("checked");
                $('#GridView1_ctl01_chkAll').removeAttr("checked");
                $('#GridView1 tr').removeAttr("style");
                istrue = false;
            }
            else if (istrue && ($('#ddlAction :selected').val() == 'Not_Given_Sample_Enquiery') && (SampleStatus == "Collected" || SampleStatus == "Received")) {
                return confirm('Are you sure to change the sample status to Not given?');
            }
            return istrue;
        }

        function ShowReason() {
            debugger;
            if (($('#ddlAction :selected').val() == 'Reject_Sample_SampleSearch') || ($('#ddlAction :selected').val() == 'Not_Given_Sample_Enquiery')) {
                //                $('#ddlReason').css("float", "right");
                document.getElementById('hdnActionName').value = $('#ddlAction :selected').val();
                $('#dReason').css("display", "table-cell");
                $('#dReason').val(-1);
            }
            else {
                $('#dReason').css("display", "none");
                document.getElementById('hdnActionName').value = "";

            }
        }
        
    </script>

    <script type="text/javascript">
        function SelectAllSampleEnquiry(sender) {
            var chkArrayMain = new Array();

            chkArrayMain = document.getElementById('HdnSampleEnquiryCheckBoxId').value.split('~');


            if (document.getElementById(sender).checked) {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    if (document.getElementById(chkArrayMain[i]) != null)
                        document.getElementById(chkArrayMain[i]).checked = true;
                    $(document.getElementById(chkArrayMain[i])).closest('tr').css("cssText", "background-color:#99E5E5 !important;");
                    $('#ddlAction').val(-1);
                    $('#dReason').val(-1);
                    $('#dReason').css("display", "none");
                    $('#SampleDetail').css("display", "none");
                }
            }
            else {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    if (document.getElementById(chkArrayMain[i]) != null)
                        document.getElementById(chkArrayMain[i]).checked = false;
                    $(document.getElementById(chkArrayMain[i])).closest('tr').removeAttr("style");
                    $('#ddlAction').val(-1);
                    $('#dReason').val(-1);
                    $('#dReason').css("display", "none");
                    $('#SampleDetail').css("display", "none");
                }
            }

        }




        function checkUncheckHeaderCheckBox(obj) {
            hidegrid();
            if (obj.checked) {
                $(obj).parent().parent().css("cssText", "background-color:#99E5E5 !important;");
            }
            else {
                $(obj).parent().parent().css("cssText", "background-color:#FFFFFF !important;");
            }


            if ($("input[id$=chkPrint]").length == $("input[id$=chkPrint]:checked").length) {

                $('#GridView1_ctl01_chkAll').attr("checked", true);
            } else {
                $('#GridView1_ctl01_chkAll').removeAttr("checked");
            }
        }


        function ShowPopUp(visitnumber, Type) {
            if (Type == "LabNo") {
                var ReturnValue = window.open("..\\Reception\\PatientTrackingDetails.aspx?IsPopup=Y&LabNumber=" + visitnumber, "", "height=800,width=1000,scrollbars=Yes");
            }
            else if (Type == "BarCode") {
                var ReturnValue = window.open("..\\Reception\\PatientTrackingDetails.aspx?IsPopup=Y&BarcodeNumber=" + visitnumber, "", "height=800,width=1000,scrollbars=Yes");
            }
        }

        function validateUnregistered() {
            var istrue = true;
            var patientregistertype;
            var items = $('#GridView1 input[name$="chkPrint"]');
            for (var i = 0; i < items.length; i++) {
                count = 1 + i;
                if (items[i].checked) {
                    patientregistertype = $('#GridView1 tr').eq(count).find('td:eq(7)').text();
                    if (patientregistertype == 'Un-Registered') {
                        alert('You can not change the sample status for the un-registered patient.');
                        $('#GridView1 tr').eq(count).removeAttr("style");
                        items[i].checked = false;
                        $('#ddlAction').val(-1);
                        $('#dReason').val(-1);
                        $('#dReason').css("display", "none");
                        istrue = false;
                        break;
                    }
                    else {
                        istrue = true;
                    }
                }
            }
            return istrue;
        }

        function validateSampleStatus() {
            var istrue = true;
            var status;
            var items = $('#GridView1 input[name$="chkPrint"]');
            for (var i = 0; i < items.length; i++) {
                count = 1 + i;
                if (items[i].checked) {
                    status = $('#GridView1 tr').eq(count).find('td:eq(10)').text();
                }
            }
            return status;
        }

        $(document).on('change', '#ddlAction', function() {
            debugger;
            var items = $('#GridView1 input[name$="chkPrint"]:checked').length;
            if (items <= 0) {
                alert('Please select the sample.');
                $('#ddlAction').val(-1);
                $('#dReason').val(-1);
                //$('#hdnActionName').val($('#ddlAction').val(-1));
                //$('#dReason').css("display", "block");
                highlite();
                hidegrid();
            }
            else {
                $('#dReason').val(-1);
                ShowReason();
            }

        });
    </script>

</body>
</html>
