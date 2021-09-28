<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dispatch.aspx.cs" Inherits="Reception_Dispatch"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/OrderedSamples.ascx" TagName="OrderedSamples"
    TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Dispatch Details</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>
<script src="../Scripts/MessageHandler.js" type="text/javascript"></script>


    <script language="javascript" type="text/javascript">
        function getFocus() {
            document.getElementById('txtSearchTxt').focus();
        }
        function txtBoxValidation() {
            if (document.getElementById('txtSearchTxt').value == '') {

                var userMsg = SListForApplicationMessages.Get('Reception\Dispatch.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Provide patient visit number to search');
                    return false;
                }
                document.getElementById('txtSearchTxt').focus();
            }
            return true;
        }
    </script>

</head>
<body oncontextmenu="return false;" onload="javascript:getFocus();">
    <form id="form1" runat="server" defaultbutton="btnGo">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <%--<uc3:PatientHeader ID="patientHeader" runat="server" />--%>
                <uc6:UserHeader ID="UserHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:Panel ID="pnlSerch" CssClass="dataheader2" BorderWidth="1px" Width="85%" runat="server"
                            meta:resourcekey="pnlSerchResource1">
                            <table border="0" id="searchTab" runat="server" cellpadding="4" cellspacing="0" width="100%">
                                <tr runat="server">
                                    <td style="font-weight: normal; height: 20px; color: #000; width: 40%;" align="left"
                                        runat="server">
                                        <asp:Label ID="lblSearch" Text="Enter Lab Bill No / Visit No to Search" runat="server"></asp:Label>
                                    </td>
                                    <td style="font-weight: normal; height: 20px; color: #000; width: 20%;" align="left"
                                        runat="server">
                                        <asp:TextBox ID="txtSearchTxt" ToolTip="Lab Bill No / Visit No" runat="server"></asp:TextBox>
                                        <ajc:FilteredTextBoxExtender ID="txtSearch" FilterType="Numbers" TargetControlID="txtSearchTxt"
                                            runat="server" Enabled="True">
                                        </ajc:FilteredTextBoxExtender>
                                    </td>
                                    <td style="font-weight: normal; height: 20px; color: #000;" align="center" runat="server">
                                        <asp:Label ID="Rs_Selectyear" Text="Select year" runat="server"></asp:Label>
                                    </td>
                                    <td runat="server">
                                        <asp:DropDownList runat="server" ID="ddlSearchYear" ToolTip="Year">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 10%;" align="left" runat="server">
                                        <asp:Button ID="btnGo" runat="server" ToolTip="Click here to Dispatch the Result"
                                            Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                            OnClick="btnGo_Click" Style="cursor: pointer;" OnClientClick="return txtBoxValidation()" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" Text="No Matching Records Found!"
                            meta:resourcekey="lblStatusResource1"></asp:Label>
                        <div runat="server" id="dInves" style="display: none;">
                            <asp:Table CellPadding="2" CssClass="colorforcontentborder" CellSpacing="0" Font-Size="11px"
                                BorderWidth="0px" runat="server" ID="dispTab" Width="100%" meta:resourcekey="dispTabResource1">
                                <asp:TableRow Height="15px" BorderWidth="0" meta:resourcekey="TableRowResource1">
                                    <asp:TableHeaderCell ForeColor="#000" HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource1">
                                        <asp:Literal ID="ColDrName" runat="server" Text="Dr. Name:" meta:resourcekey="ColDrNameResource1"></asp:Literal>
                                        &nbsp;
                                        <asp:Literal ID="DrName" runat="server" meta:resourcekey="DrNameResource2"></asp:Literal>
                                    </asp:TableHeaderCell>
                                    <asp:TableHeaderCell ForeColor="#000" HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource2">
                                        <asp:Literal ID="Literal3" runat="server" Text="Hospital/Branch:" meta:resourcekey="Literal3Resource1"></asp:Literal>
                                        &nbsp;
                                        <asp:Literal ID="HospitalName" runat="server" meta:resourcekey="HospitalNameResource1"></asp:Literal>
                                    </asp:TableHeaderCell>
                                </asp:TableRow>
                                <asp:TableRow ID="TableRow1" runat="server" BorderWidth="0" meta:resourcekey="TableRow1Resource1">
                                    <asp:TableHeaderCell ColumnSpan="4" HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource3">
                                        <asp:Table CellPadding="0" CellSpacing="0" BorderWidth="0" runat="server" ID="trCC"
                                            Style="display: none;" Width="100%" meta:resourcekey="trCCResource1">
                                            <asp:TableRow Height="15px" BorderWidth="0" meta:resourcekey="TableRowResource2">
                                                <asp:TableHeaderCell ForeColor="#000" ColumnSpan="2" HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource4">
                                                    <asp:Literal ID="Literal4" runat="server" Text="Collection Centre:" meta:resourcekey="Literal4Resource1"></asp:Literal>
                                                    &nbsp;
                                                    <asp:Literal ID="CollectionCentre" runat="server" meta:resourcekey="CollectionCentreResource1"></asp:Literal>
                                                </asp:TableHeaderCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableHeaderCell>
                                </asp:TableRow>
                            </asp:Table>
                            <asp:Panel ID="pnlptDetails" CssClass="dataheader2" BorderWidth="1px" runat="server"
                                meta:resourcekey="pnlptDetailsResource1">
                                <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                    <tr style="height: 15px;" class="Duecolor">
                                        <td colspan="10">
                                            <b>
                                                <asp:Label ID="Rs_PatientDetails" Text="Patient Details" runat="server" meta:resourcekey="Rs_PatientDetailsResource1"></asp:Label></b>
                                        </td>
                                    </tr>
                                    <tr style="height: 20px;">
                                        <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                            <asp:Label ID="Rs_PatientNo" Text="Patient No:" runat="server" meta:resourcekey="Rs_PatientNoResource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                            <asp:Label ID="lblPatientNo" runat="server" meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: normal; height: 20px; color: #000; width: 13%;" align="left">
                                            <asp:Label ID="Rs_PatientName" Text="Patient Name:" runat="server" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: normal; height: 20px; color: #000;" align="left">
                                            <asp:Label ID="lblPatientName" runat="server" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                            <asp:Label ID="Rs_Gender" Text="Gender:" runat="server" meta:resourcekey="Rs_GenderResource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                            <asp:Label ID="lblGender" runat="server" meta:resourcekey="lblGenderResource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                            <asp:Label ID="Rs_Age" Text="Age:" runat="server" meta:resourcekey="Rs_AgeResource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                            <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                            <asp:Label ID="Rs_VisitNo" Text="Visit No:" runat="server" meta:resourcekey="Rs_VisitNoResource1"></asp:Label>
                                        </td>
                                        <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                            <asp:Label ID="lblVisitNo" runat="server" meta:resourcekey="lblVisitNoResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <table id="tabResultPublishingDetails" class="dataheaderInvCtrl" cellpadding="4"
                                cellspacing="0" border="0" runat="server" width="97%">
                                <tr>
                                    <td id="tdPatientAddress" runat="server" style="font-weight: normal; color: #000;"
                                        valign="top">
                                    </td>
                                    <td>
                                        &nbsp; &nbsp; &nbsp;
                                    </td>
                                    <td id="tdPublishingAddress" runat="server" style="font-weight: normal; color: #000;"
                                        valign="top">
                                    </td>
                                </tr>
                            </table>
                            <table id="tabOrderedInvs" cellpadding="0" cellspacing="0" border="0" runat="server">
                                <tr>
                                    <td>
                                        <div id="ACX2plus1" style="display: none;">
                                            <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);">
                                                <asp:Label ID="Rs_InvestigationsOrderedForCurrentVisit" Text="Investigations Ordered For Current Visit"
                                                    runat="server" meta:resourcekey="Rs_InvestigationsOrderedForCurrentVisitResource1"></asp:Label></span>
                                        </div>
                                        <div id="ACX2minus1" style="display: block;">
                                            <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);">
                                                &nbsp;<asp:Label ID="Rs_InvestigationsOrderedForCurrentVisit1" Text="Investigations Ordered For Current Visit"
                                                    runat="server" meta:resourcekey="Rs_InvestigationsOrderedForCurrentVisit1Resource1"></asp:Label></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responses1" style="display: block;">
                                    <td colspan="2">
                                        <asp:Label ID="lblInvStatus" runat="server" Font-Size="Medium" Font-Bold="True" Text="No Investigations Ordered for Current Visit"
                                            Visible="False" meta:resourcekey="lblInvStatusResource1"></asp:Label>
                                        <div class="dataheader2">
                                            <asp:DataList ID="dlInvName" runat="server" Width="100%" BorderWidth="0px" CellPadding="0"
                                                RepeatColumns="3" ItemStyle-Wrap="true" RepeatDirection="Horizontal" meta:resourcekey="dlInvNameResource1">
                                                <ItemStyle Wrap="True"></ItemStyle>
                                                <HeaderTemplate>
                                                    <table border="0px" cellpadding="1px" width="100%">
                                                        <tr>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <td valign="top" align="left" style="height: 20px; width: 30%; border-style: solid;
                                                        border-width: 0px; border-collapse: collapse;">
                                                        <img src="../Images/bullet.png" alt="" align="middle" />
                                                        &nbsp;
                                                        <%# DataBinder.Eval(Container.DataItem, "InvestigationName")%>
                                                    </td>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </tr> </table>
                                                </FooterTemplate>
                                            </asp:DataList>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="height: 23px;" align="left">
                                        <div id="ACX2plus3" style="display: none;">
                                            <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                onclick="showResponses('ACX2plus3','ACX2minus4','ACX2responsess4',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus3','ACX2minus4','ACX2responsess4',1);">
                                                <asp:Label ID="Rs_SamplesCollectedForCurrentVisit" Text="Samples Collected For Current Visit"
                                                    runat="server" meta:resourcekey="Rs_SamplesCollectedForCurrentVisitResource1"></asp:Label></span>
                                        </div>
                                        <div id="ACX2minus4" style="display: block;">
                                            <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus4','ACX2responsess4',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus3','ACX2minus4','ACX2responsess4',0);">
                                                &nbsp;<asp:Label ID="Rs_SamplesCollectedForCurrentVisit1" Text="Samples Collected For Current Visit"
                                                    runat="server" meta:resourcekey="Rs_SamplesCollectedForCurrentVisit1Resource1"></asp:Label></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responsess4" style="display: block;">
                                    <td style="width: 100%;">
                                        <asp:Panel ID="pnlSampleListlbl" CssClass="dataheader2" BorderWidth="1px" runat="server"
                                            meta:resourcekey="pnlSampleListlblResource1">
                                            <table border="0" cellpadding="5" cellspacing="0" width="100%">
                                                <tr>
                                                    <td style="width: 100%;">
                                                        <asp:Label ID="Label1" runat="server" Font-Size="12px" Font-Bold="False" Visible="False"
                                                            meta:resourcekey="Label1Resource1">&nbsp;<asp:Label ID="Rs_NoSamplescollectedforCurrentVisit"
                                                                Text="( No Samples collected for Current Visit )" runat="server" meta:resourcekey="Rs_NoSamplescollectedforCurrentVisitResource1"></asp:Label>
                                                        </asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                        <asp:Panel ID="pnlSampleList" CssClass="dataheader2" BorderWidth="1px" Visible="False"
                                            runat="server" meta:resourcekey="pnlSampleListResource1">
                                            <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                <tr style="font-weight: bold;" class="Duecolor">
                                                    <td style="font-weight: normal; height: 8px; color: #fff; width: 30%;" align="left">
                                                        <b>
                                                            <asp:Label ID="Rs_SampleName" Text="SampleName" runat="server" meta:resourcekey="Rs_SampleNameResource1"></asp:Label></b>
                                                    </td>
                                                    <td style="font-weight: normal; height: 8px; color: #fff; width: 15%;" align="left">
                                                        <b>
                                                            <asp:Label ID="Rs_Status" Text="Status" runat="server" meta:resourcekey="Rs_StatusResource1"></asp:Label></b>
                                                    </td>
                                                    <td style="font-weight: normal; height: 8px; color: #fff; width: 15%;" align="left">
                                                        <b>
                                                            <asp:Label ID="Rs_Barcode" Text="Barcode" runat="server" meta:resourcekey="Rs_BarcodeResource1"></asp:Label></b>
                                                    </td>
                                                    <td style="font-weight: normal; height: 8px; color: #fff; width: 20%;" align="left">
                                                        <b>
                                                            <asp:Label ID="Rs_DepartmentName" Text="Department Name" runat="server" meta:resourcekey="Rs_DepartmentNameResource1"></asp:Label></b>
                                                    </td>
                                                    <td style="font-weight: normal; height: 8px; color: #fff; width: 20%;" align="left">
                                                        <b>
                                                            <asp:Label ID="Rs_CollectedTime" Text="Collected Time" runat="server" meta:resourcekey="Rs_CollectedTimeResource1"></asp:Label></b>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="5" style="font-weight: normal; height: 10px; color: #000;" align="left">
                                                        <asp:DataList ID="dtSample" runat="server" CellPadding="2" Width="100%" meta:resourcekey="dtSampleResource1">
                                                            <ItemTemplate>
                                                                <table width="100%">
                                                                    <tr>
                                                                        <td style="font-weight: normal; height: 5px; color: #000; width: 30%;" align="left">
                                                                            <%# DataBinder.Eval(Container.DataItem, "SampleDesc")%>
                                                                        </td>
                                                                        <td style="font-weight: normal; height: 5px; color: #000; width: 15%;" align="left">
                                                                            <%# DataBinder.Eval(Container.DataItem, "InvSampleStatusDesc")%>
                                                                        </td>
                                                                        <td style="font-weight: normal; height: 5px; color: #000; width: 15%;" align="left">
                                                                            <%# DataBinder.Eval(Container.DataItem, "BarcodeNumber")%>
                                                                        </td>
                                                                        <td style="font-weight: normal; height: 5px; color: #000; width: 20%;" align="left">
                                                                            <%# DataBinder.Eval(Container.DataItem, "DeptName")%>
                                                                        </td>
                                                                        <td style="font-weight: normal; height: 5px; color: #000; width: 20%;" align="left">
                                                                            <%# DataBinder.Eval(Container.DataItem, "CreatedAt","{0:dd/MM/yyyy hh:mm tt}")%>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </asp:DataList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <table id="tabResult" cellpadding="0" cellspacing="0" border="0" runat="server" width="50%">
                                <tr>
                                    <td>
                                        <div id="Div1" style="display: none;">
                                            <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                onclick="showResponses('Div1','Div2','trgrdResult',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('Div1','Div2','trgrdResult',1);">
                                                <asp:Label ID="Rs_LabResultStatus" Text="Lab Result Status" runat="server" meta:resourcekey="Rs_LabResultStatusResource1"></asp:Label></span>
                                        </div>
                                        <div id="Div2" style="display: block;">
                                            <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                style="cursor: pointer" onclick="showResponses('Div1','Div2','trgrdResult',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('Div1','Div2','trgrdResult',0);">
                                                &nbsp;<asp:Label ID="Rs_LabResultStatus1" Text="Lab Result Status" runat="server"></asp:Label></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr id="trPendingDept" runat="server" style="display: none; color: #000;">
                                    <td style="color: #000000;">
                                        <asp:Label ID="Rs_NoPendingDepartments" Text="( No Pending Departments! )" runat="server"
                                            meta:resourcekey="Rs_NoPendingDepartmentsResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trgrdResult" runat="server" style="display: block;">
                                    <td>
                                        <asp:GridView ID="grdResult" CssClass="dataheaderInvCtrl" runat="server" Visible="False"
                                            AutoGenerateColumns="False" CellPadding="4" PageSize="100" ForeColor="Black"
                                            GridLines="None" PagerSettings-Mode="NextPrevious" Width="99%" meta:resourcekey="grdResultResource1">
                                            <PagerTemplate>
                                                <tr>
                                                    <td align="center" colspan="6">
                                                        <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                            CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" Width="18px"
                                                            meta:resourcekey="lnkPrevResource1" />
                                                        <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                            CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" Width="18px"
                                                            meta:resourcekey="lnkNextResource1" />
                                                    </td>
                                                </tr>
                                            </PagerTemplate>
                                            <HeaderStyle Font-Underline="true" />
                                            <RowStyle Font-Bold="false" />
                                            <PagerSettings Mode="NextPrevious"></PagerSettings>
                                            <Columns>
                                                <asp:BoundField DataField="DeptName" HeaderStyle-HorizontalAlign="Left" HeaderText="Department"
                                                    ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="20%" meta:resourcekey="BoundFieldResource1">
                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                    <ItemStyle HorizontalAlign="Left" Width="18%"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Status" HeaderStyle-HorizontalAlign="right" HeaderText="Status"
                                                    ItemStyle-HorizontalAlign="Left" Visible="true" meta:resourcekey="BoundFieldResource2">
                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                    <ItemStyle HorizontalAlign="Left" Width="12%"></ItemStyle>
                                                </asp:BoundField>
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <table width="100%" id="buttonTab" runat="server" style="display: none;">
                                <tr>
                                    <td align="left">
                                        <asp:Button ID="btnFinish" runat="server" ToolTip="Click here to Dispatch Result"
                                            Style="cursor: pointer;" CssClass="btn" OnClick="btnFinish_Click" onmouseout="this.className='btn'"
                                            onmouseover="this.className='btn btnhov'" Text="Dispatch Result" meta:resourcekey="btnFinishResource1" />
                                        <asp:Button ID="btnCancel" runat="server" ToolTip="Click here to Cancel, View the Home Page"
                                            Style="cursor: pointer;" CssClass="btn" OnClick="btnCancel_Click" onmouseout="this.className='btn'"
                                            onmouseover="this.className='btn btnhov'" Text="Cancel" meta:resourcekey="btnCancelResource1" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
	<asp:HiddenField ID="hdnMessages" runat="server" />
   
    </form>
</body>
</html>
