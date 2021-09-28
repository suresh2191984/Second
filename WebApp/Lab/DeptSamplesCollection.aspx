<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="DeptSamplesCollection.aspx.cs"
    Inherits="Lab_DeptSamplesCollection" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>--%>
<%--<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>--%>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader"
    TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/OrderedSamples.ascx" TagName="OrderedSamples"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/SampleCollectedVisit.ascx" TagName="SampleCollectedVisit"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Src="../CommonControls/CollectSample.ascx" TagName="CollectSample"
    TagPrefix="CollectSample" %>
<%@ Register Src="~/CommonControls/ExpectantSampleQueue.ascx" TagName="ExpSampleQ"
    TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Department Sample Collection</title>

<%--    <script src="../Scripts_New/bid.js" type="text/javascript"></script>

    <script src="../Scripts_New/Common.js" type="text/javascript"></script>--%>

    <script src="../Scripts/CollectSample.js" type="text/javascript"></script>
    <%-- <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />--%>
    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

</head>
<body oncontextmenu="return false;" onload="javascript:getFocus();">
    <form id="form1" runat="server" defaultbutton="btnFinish">
    <asp:ScriptManager ID="ScriptManager1" runat="server" ScriptMode="Release">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <%--<ul>
            <li>
                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
            </li>
        </ul>--%>
        <table class="w-100p a-left">
            <tr>
                <td>
                    <table cellpadding="2" class="dataheaderInvCtrl w-100p searchPanel" cellspacing="2">
                        <tr>
                            <td class="a-right">
                                <asp:Label ID="Rs_From" Text="From Date" runat="server" meta:resourcekey="Rs_FromResource1"></asp:Label>
                            </td>
                            <td>
                                <table cellpadding="1" class="w-100p">
                                    <tr class="defaultfontcolor">
                                        <td>
                                            <asp:TextBox runat="server" ID="txtFrom" MaxLength="25" size="20" CssClass="small"
                                                meta:resourcekey="txtFromResource1"></asp:TextBox>
                                            <a href="javascript:NewCssCal('txtFrom','ddmmyyyy','arrow',true,12)">
                                                <img src="../images/Calendar_scheduleHS.png" id="imgCalc" alt="Pick a date"></a>
                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                        </td>
                                        <td class="a-left" id="datecheck" runat="server">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="a-right">
                                <asp:Label ID="Rs_To" Text="To Date" runat="server" meta:resourcekey="Rs_ToResource1"></asp:Label>
                            </td>
                            <td>
                                <table cellpadding="1" class="w-100p">
                                    <tr class="defaultfontcolor">
                                        <td>
                                            <asp:TextBox runat="server" ID="txtTo" MaxLength="25" size="20" CssClass="small"
                                                meta:resourcekey="txtToResource1"></asp:TextBox>
                                            <a href="javascript:NewCssCal('txtTo','ddmmyyyy','arrow',true,12)">
                                                <img src="../images/Calendar_scheduleHS.png" id="img1" alt="Pick a date"></a>
                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="a-right">
                                <asp:Label ID="Label2" Text="Priority" runat="server" meta:resourcekey="Label2Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlPriority" runat="server" CssClass="ddlsmall">
<%--                                    <asp:ListItem Text="Select" Value="-1" Selected="True" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                    <asp:ListItem Text="STAT" Value="1" meta:resourcekey="ListItemResource4"></asp:ListItem>--%>
                                </asp:DropDownList>
                            </td>
                            <td class="a-right">
                                <asp:Label ID="Label3" Text="Test Name" runat="server" meta:resourcekey="Label3Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtTestName" class="tb1" runat="server" Width="150" onfocus="javascript:ClearTestDetails();"
                                    CssClass="small" meta:resourcekey="txtTestNameResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                    TargetControlID="txtTestName" ServiceMethod="FetchInvestigationNameForOrg" ServicePath="~/WebService.asmx"
                                    EnableCaching="False" BehaviorID="AutoCompleteExLstGrp11" CompletionInterval="2"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                    Enabled="True" OnClientItemSelected="SelectedTest">
                                </ajc:AutoCompleteExtender>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-right">
                                <asp:Label ID="Label7" Text="Location" runat="server" meta:resourcekey="Label7Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddlsmall"
                                     onmousedown="expandDropDownList1(this);" onblur="collapseDropDownList(this);" meta:resourcekey="ddlLocationResource1">
                                </asp:DropDownList>
                            </td>
                            <td class="a-right">
                                <asp:Label ID="Label8" Text="Source Name" runat="server" meta:resourcekey="Label8Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddClientName" runat="server" CssClass="ddlsmall" meta:resourcekey="ddClientNameResource1">
                                </asp:DropDownList>
                            </td>
                            <td class="a-right">
                                <asp:Label ID="Label9" Text="Visit Type" runat="server" meta:resourcekey="Label9Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddVisitType" runat="server" CssClass="ddlsmall">
            <%--                        <asp:ListItem Text="Select" Value="-1" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                    <asp:ListItem Text="OP" Value="0" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                    <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource7"></asp:ListItem>--%>
                                </asp:DropDownList>
                            </td>
                            <td class="a-right">
                                <asp:Label ID="Label10" Text="Ref. Doctor Name" runat="server" meta:resourcekey="Label10Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtRefDrName" runat="server" CssClass="small" onfocus="javascript:ClearRefPhyDetails();"
                                    meta:resourcekey="txtRefDrNameResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                                    TargetControlID="txtRefDrName" ServiceMethod="FetchRefPhysicianNameForOrg" ServicePath="~/WebService.asmx"
                                    EnableCaching="False" BehaviorID="AutoCompleteExLstGrp12" CompletionInterval="2"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                    Enabled="True" OnClientItemSelected="SelectedRefPhy">
                                </ajc:AutoCompleteExtender>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-right">
                                <asp:Label ID="Rs_FromVisitNo" Text="Number" runat="server" meta:resourcekey="Rss_FromVisitNoResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtVisitID" runat="server" meta:resourcekey="txtFromVisitResource1"
                                    CssClass="small"></asp:TextBox>
                            </td>
                            <td class="a-right">
                                <asp:Label ID="Rs_ToVisitNo" Text="Patient Name" runat="server" meta:resourcekey="Rs_ToVisitNoResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPatientName" runat="server" meta:resourcekey="txtToVisitResource1"
                                    CssClass="small"></asp:TextBox>
                            </td>
                            <td class="a-right">
                                <asp:Label ID="lblBarcodeNo" runat="server" Text="Barcode No" meta:resourcekey="lblBarcodeNoResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="txtbarcodeno" MaxLength="25" size="20" CssClass="small"
                                    meta:resourcekey="txtbarcodenoResource1"></asp:TextBox>
                            </td>
                            <%--/* BEGIN | NA | Sabari | 20190515 | Created | MRNNumberSearch */ --%>
					        <td class="w-10p" align="left">
                                <asp:Label ID="Rs_PatientNumber" Text="Patient Number" runat="server" 
					meta:resourcekey="Rs_PatientNumberResource1"></asp:Label>
                            </td>
                            <td class="w-20p">
                                <asp:TextBox ID="txtPatientNumber" runat="server" CssClass="Txtboxsmall"
					meta:resourcekey="txtPatientNumberResource1"></asp:TextBox>
                            </td>
                            <%--/* END | NA | Sabari | 20190515 | Created | MRNNumberSearch */--%>
                            <td colspan="2" class="a-left">
                                <asp:Button ID="btnFinish" runat="server" ToolTip="Click here to Search" Style="cursor: pointer;"
                                    CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                    Text="Search" OnClick="btnGo_Click" meta:resourcekey="btnFinishResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td class="w-100p a-right" colspan="8">
                                <table cellpadding="2" cellspacing="1" class="w-100p">
                                    <tr id="tdAberrant" runat="server">
                                        <td class="w-100p a-right">
                                            <%--  <uc11:ExpSampleQ ID="ExpectantSampleQueue" runat="server" />--%>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="v-top">
                    <asp:Panel ID="pnlSerch" CssClass="dataheader2 w-85p" BorderWidth="1px" runat="server"
                        Visible="false" meta:resourcekey="pnlSerchResource1">
                        <table id="searchTab" runat="server" cellpadding="4" class="w-100p">
                            <tr id="Tr1" runat="server">
                                <td id="Td1" class="h-20 w-40p a-left" style="font-weight: normal; color: #000;"
                                    runat="server">
                                    <asp:Label ID="lblSearch" Text="Enter The Visit No to Search" runat="server"></asp:Label>
                                </td>
                                <td id="Td2" class="a-left h-20 w-20p" style="font-weight: normal; color: #000;"
                                    runat="server">
                                    <asp:TextBox ID="txtSearchTxt" ToolTip="Lab Visit No" CssClass="small" runat="server"></asp:TextBox>
                                    <ajc:FilteredTextBoxExtender ID="txtSearch" FilterType="Numbers" TargetControlID="txtSearchTxt"
                                        runat="server" Enabled="True">
                                    </ajc:FilteredTextBoxExtender>
                                </td>
                                <td id="Td3" class="h-20 a-center" style="font-weight: normal; color: #000;" runat="server">
                                    <asp:Label ID="Rs_Selectyear" Text="Select year" Visible="false" runat="server"></asp:Label>
                                </td>
                                <td id="Td4" runat="server">
                                    <asp:DropDownList runat="server" ID="ddlSearchYear" Visible="false" ToolTip="Year"
                                        CssClass="ddlsmall">
                                    </asp:DropDownList>
                                </td>
                                <td id="Td5" class="w-10p a-left" runat="server">
                                    <asp:Button ID="btnGo" runat="server" ToolTip="Click here to Receive the Sample"
                                        Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                        OnClick="btnGo_Click" Style="cursor: pointer;" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" Text="No Matching Records Found!"
                        meta:resourcekey="lblStatusResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <%--      <asp:Panel ID="pnlSampleList" CssClass="dataheader2" BorderWidth="1px" Visible="false"
                                        runat="server">
                                        <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 14%;" align="left">
                                                    SampleName
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 14%;" align="left">
                                                    Status
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 14%;" align="left">
                                                    DepartmentName
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 14%;" align="left">
                                                    Collected Time
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" style="font-weight: normal; height: 20px; color: #000;" align="left">
                                                    <asp:DataList ID="dtSample" runat="server" CellPadding="4" Width="100%">
                                                        <ItemTemplate>
                                                            <table width="100%">
                                                                <tr>
                                                                    <td style="font-weight: normal; height: 20px; color: #000; width: 26%;" align="left">
                                                                        <%# DataBinder.Eval(Container.DataItem, "SampleDesc")%>
                                                                    </td>
                                                                    <td style="font-weight: normal; height: 20px; color: #000; width: 26%;" align="left">
                                                                        <%# DataBinder.Eval(Container.DataItem, "InvSampleStatusDesc")%>
                                                                    </td>
                                                                    <td style="font-weight: normal; height: 20px; color: #000; width: 26%;" align="left">
                                                                        <%# DataBinder.Eval(Container.DataItem, "DeptName")%>
                                                                    </td>
                                                                    <td style="font-weight: normal; height: 20px; color: #000; width: 26%;" align="left">
                                                                        <%# DataBinder.Eval(Container.DataItem, "CreatedAt","{0:dd/MM/yyyy hh:mm tt}")%>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>--%>
                    <table class="w-100p">
                        <tr>
                            <td class="h-23 a-left" style="color: #000;">
                                <div id="ACXplussmp" style="display: none;">
                                    <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                        onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',1); showFooter('1');" />
                                    <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',1); showFooter('1');">
                                        <asp:Label ID="Rs_ReceiveSampleList" Text="Receive Sample List" runat="server" meta:resourcekey="Rs_ReceiveSampleListResource1"></asp:Label></span>
                                </div>
                                <div id="ACXminussmp" style="display: block;">
                                    <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                        style="cursor: pointer" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',0); showFooter('0');" />
                                    <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',0); showFooter('0');">
                                        &nbsp;
                                        <asp:Label ID="Rs_ReceiveSampleList1" Text="Receive Sample List" runat="server" meta:resourcekey="Rs_ReceiveSampleList1Resource1"></asp:Label></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td id="tdbutsave2" runat="server" style="display: none">
                                <asp:Button Text="Save" ID="btnsave" runat="server" ToolTip="Click here to Save the Details"
                                    Style="cursor: pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    OnClientClick="return ValidateReason()" onmouseout="this.className='btn'" OnClick="btnSubmit_Click"
                                    meta:resourcekey="btnsaveResource1" />
                            </td>
                        </tr>
                        <tr class="tablerow" runat="server" id="ACXresponsessmp1" style="display: table-row;">
                            <td>
                                <asp:GridView ID="grdRecSampleList" runat="server" ForeColor="Black" CssClass="gridView w-100p"
                                    OnRowDataBound="grdRecSampleList_RowDataBound" CellPadding="4" AutoGenerateColumns="False"
                                    Font-Size="12px" OnRowCommand="grdRecSampleList_RowCommand" meta:resourcekey="grdRecSampleListResource1"
                                    OnPageIndexChanging="grdRecSampleList_PageIndexChanging" PageSize="10">
                                    <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <HeaderStyle CssClass="dataheader1" />
                                    <HeaderStyle CssClass="colorforcontent" ForeColor="White" />
                                    <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Red" />
                                    <EmptyDataTemplate>
                                        <center>
                                            <asp:Label ID="Rs_NoMatchingPatientRecordsFound" Text="No Matching Patient Records Found."
                                                runat="server" meta:resourcekey="Rs_NoMatchingPatientRecordsFoundResource1"></asp:Label></center>
                                    </EmptyDataTemplate>
                                    <Columns>
                                        <asp:TemplateField ItemStyle-Wrap="false" HeaderText="Receive Sample Patient List"
                                            ItemStyle-Width="60%" ControlStyle-Width="250px" meta:resourcekey="TemplateFieldResource1">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Visible="False" ID="lblpvID" Text='<%# Bind("PatientVisitId") %>'
                                                    meta:resourcekey="lblpvIDResource1"></asp:Label>
                                                <asp:LinkButton ID="LinkButton1" ForeColor="Black" runat="server" CommandArgument='<%# DataBinder.Eval(Container,"RowIndex") %>'
                                                    CommandName="LoadPatientList" Text='<%# Eval("AccompaniedBy") %>' meta:resourcekey="LinkButton1Resource1"></asp:LinkButton>
                                            </ItemTemplate>
                                            <ControlStyle Width="250px"></ControlStyle>
                                            <ItemStyle Wrap="False" Width="60%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="PatientVisitType" HeaderText="Collected Location" meta:resourcekey="BoundFieldResource1" />
                                        <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Collected Date"
                                            meta:resourcekey="BoundFieldResource2" />
                                        <asp:BoundField DataField="PhysicianName" HeaderText="Picked by" meta:resourcekey="BoundFieldResource3" />
                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblPnumber" Text='<%# Bind("PatientNumber") %>' Visible="False"
                                                    meta:resourcekey="lblPnumberResource1"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource3">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblPID" Text='<%# Bind("PatientID") %>' Visible="False"
                                                    meta:resourcekey="lblPIDResource1"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerStyle CssClass="dataheader1 w-14p v-middle a-center"/>
                                    <HeaderStyle CssClass="dataheader1 w-14p"/>
                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                        PageButtonCount="5" PreviousPageText="" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr id="GrdFooter" runat="server" style="display: none;" class="dataheaderInvCtrl">
                            <td class="defaultfontcolor a-center">
                                <asp:Label ID="Label4" runat="server" Text="Page"  meta:resourcekey="Label4Resource1"></asp:Label><asp:Label ID="lblCurrent"
                                    runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label><asp:Label ID="Label5"
                                        runat="server" Text="Of" meta:resourcekey="Label5Resource1"></asp:Label><asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label><asp:Button
                                            ID="btnPrevious" runat="server" Text="Previous" CssClass="btn" OnClick="btnPrevious_Click" meta:resourcekey="btnPreviousResource1" />
                                <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn" OnClick="btnNext_Click"
                                    meta:resourcekey="btnNextResource1" />
                                <asp:HiddenField ID="hdnCurrent" runat="server" />
                                <asp:HiddenField ID="hdnMessages" runat="server" />
                                <asp:Label ID="Label6" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label6Resource1"></asp:Label><asp:TextBox
                                    ID="txtpageNo" runat="server" Width="30px"   onkeypress="return ValidateOnlyNumeric(this);"  
                                    AutoComplete="off" meta:resourcekey="txtpageNoResource1"></asp:TextBox><asp:Button ID="Button1" runat="server" Text="Go"
                                        CssClass="btn" OnClick="btnGo1_Click" OnClientClick="javascript:return validatePageNumber();" meta:resourcekey="Button1Resource2" />
                                <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                            </td>
                        </tr>
                        <tr>
                            <td class="a-right" colspan="6">
                                <div runat="server" id="divPatientDetails" style="display: none">
                                    <ucPatientdet:PatientDetails ID="PatientDetail" runat="server" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="a-left v-middle">
                <td>
                    <div runat="server" id="dInves" style="display: none;">
                        <table>
                            <tr>
                                <td class="bold h-20 w-14p" style="color: #000;" colspan="2">
                                    <asp:Label ID="Rs_Info" Text="Please select one or more Samples and their Status from the following"
                                        runat="server" meta:resourcekey="Rs_InfoResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left" colspan="6">
                                    <table class="dataheaderInvCtrl w-100p searchPanel" cellpadding="2">
                                        <tr>
                                            <td>
                                                <table border="1" class="w-100p">
                                                    <tr class="Duecolor h-20 bold">
                                                        <td class="a-center w-4p">
                                                            <asp:CheckBox ID="chkSelectAll" ToolTip="Click here to Select/Deselect all" onclick="SelectAllSamples(this.id);"
                                                                runat="server" meta:resourcekey="chkSelectAllResource1" />
                                                        </td>
                                                       <%-- <td class="a-left w-13p">
                                                        <asp:Label ID="Rs_InvName" Text="Tests" runat="server" ></asp:Label>
                                                        </td>--%>
                                                       
                                                        <td class="a-left w-8p">
                                                            <asp:Label ID="Rs_Sample" Text="Sample" runat="server" meta:resourcekey="Rs_SampleResource1"></asp:Label>
                                                        </td>
                                                        
                                                        <td class="a-left w-10p">
                                                            <asp:Label ID="Rs_Additive" Text="Additive" runat="server" meta:resourcekey="Rs_AdditiveResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-left w-10p">
                                                            <asp:Label ID="Rs_BarcodeLabel" Text="Barcode / Label" runat="server" meta:resourcekey="Rs_BarcodeLabelResource1"></asp:Label>
                                                        </td>
                                                         <td class="a-left w-7p">
                                                        <asp:Label ID="Rs_processtype" runat="server" Text="Processing Type"
								meta:resourcekey="Rs_processtypeResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-left w-12p">
                                                            <asp:Label ID="Rs_Status" Text="Status" runat="server" meta:resourcekey="Rs_StatusResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-center w-13p">
                                                            <asp:Label ID="Rs_Reason" Text="Reason" runat="server" meta:resourcekey="Rs_ReasonResource1"></asp:Label>
                                                        </td>
                                                         <td class="a-center w-10p">
                                                            <asp:Label ID="lblSRFID" Text="SRF ID" runat="server" meta:resourcekey="Rs_SRFIDResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-center w-15p">
                                                            <asp:Label ID="Label1" Text="ParentOrg" runat="server" meta:resourcekey="Label1Resource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-right" colspan="6">
                                                <input type="hidden" runat="server" id="hDept" />
                                                <asp:Repeater ID="repSampleCollect" runat="server" OnItemDataBound="repSampleCollect_ItemDataBound">
                                                    <HeaderTemplate>
                                                        <table class="w-100p">
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td class="a-center w-5p">
                                                                <asp:CheckBox ID="chkSampleCollect" runat="server" meta:resourcekey="chkSampleCollectResource1" />
                                                            </td>
                                                            <td class="a-left w-10p">
                                                                <asp:Label ID="lsid" runat="server" Visible="False" Text='<%# DataBinder.Eval(Container.DataItem, "SampleID") %>'
                                                                    meta:resourcekey="lsidResource1"></asp:Label>
                                                                <asp:Label ID="lblSampleID" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SampleCode") %>'
                                                                    Visible="False" meta:resourcekey="lblSampleIDResource1"></asp:Label>
                                                                <asp:Label ID="lblSampleCollect" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SampleDesc") %>'
                                                                    meta:resourcekey="lblSampleCollectResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-left w-14p">
                                                                <asp:Label ID="lblSampleContainerID" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SampleContainerID") %>'
                                                                    Visible="False" meta:resourcekey="lblSampleContainerIDResource1"></asp:Label>
                                                                <asp:Label ID="lblSampleContainerName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SampleContainerName") %>'
                                                                    meta:resourcekey="lblSampleContainerNameResource1"></asp:Label>
                                                            </td>
                                                           
                                                            <%--<td class="a-left w-8p">--%>
                                                            <td class="a-left w-12p" style="color: #000000; font-weight: normal;">
                                                                <asp:Label ID="lblBarcodeNumber" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BarcodeNumber") %>'
                                                                    meta:resourcekey="lblBarcodeNumberResource1"></asp:Label>
                                                            </td>
                                                             <td class="a-left w-9p">
                                                            <asp:Label ID="lblprocesstype" runat="server" 
									Text='<%#DataBinder.Eval(Container.DataItem,"Locationtype") %>'
									meta:resourcekey="lblprocesstypeResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-left w-12p" style="color: #000000; font-weight: normal;">
                                                                <asp:DropDownList CssClass="selectoption4 ddlsmall" ToolTip="Select the Sample Status(Received/Rejected)"
                                                                    onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);"
                                                                    ID="ddlSampleStatus" runat="server" meta:resourcekey="ddlSampleStatusResource1">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td class="a-left w-16p" style="color: #000000; font-weight: normal;">
                                                                <%--<asp:TextBox ID="txtSampleCollect" ToolTip="Reason for Sample Rejection" runat="server"
                                                                                    meta:resourcekey="txtSampleCollectResource1" Visible="false"></asp:TextBox>--%>
                                                                <asp:DropDownList ID="ddlReason" runat="server" CssClass="ddlsmall" onmousedown="expandDropDownList(this);"
                                                                    onblur="collapseDropDownList(this);" Style="display: none" meta:resourcekey="ddlReasonResource1">
                                                                </asp:DropDownList>
                                                                <asp:HiddenField ID="hdnSelectedReason" runat="server" />
                                                            </td>
                                                            <td class="a-center" style="color: #000000; font-weight: normal;">
                                                            <asp:TextBox ID="txtSrfId" runat="server" Width="110" Text='<%# DataBinder.Eval(Container.DataItem, "CaseNumber") %>'
                                                             CssClass="small" meta:resourcekey="txtsrfidResource1"></asp:TextBox>
                                                              <asp:Label ID="hdnIsSrf" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "IsShareAble") %>'
                                                                    CssClass="hide" meta:resourcekey="lblSampleContainerIDResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-center w-14p" style="color: #000000; font-weight: normal;">
                                                                <asp:Label ID="Label4" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "LocationName") %>'
                                                                    meta:resourcekey="Label4Resource2"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        </table>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Table CellPadding="2" CssClass="colorforcontentborder w-100p" Font-Size="11px"
                                        runat="server" ID="dispTab" meta:resourcekey="dispTabResource1">
                                        <asp:TableRow class="h-15" meta:resourcekey="TableRowResource1">
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
                                        <asp:TableRow ID="TableRow1" runat="server" meta:resourcekey="TableRow1Resource1">
                                            <asp:TableHeaderCell ColumnSpan="4" HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource3">
                                                <asp:Table runat="server" ID="trCC" class="w-100p" Style="display: none;" meta:resourcekey="trCCResource1">
                                                    <asp:TableRow Height="15px" meta:resourcekey="TableRowResource2">
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
                                    <%--  <asp:Panel ID="pnlptDetails" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                                        <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                            <tr style="height: 15px;" class="Duecolor">
                                                                <td colspan="14">
                                                                    <b>
                                                                        <asp:Label ID="Rs_PatientDetails" Text="Patient Details" runat="server" meta:resourcekey="Rs_PatientDetailsResource1"></asp:Label></b>
                                                                </td>
                                                            </tr>
                                                            <tr style="height: 20px;">
                                                                <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="Right">
                                                                    <asp:Label ID="Rs_VisitNo" Text="Visit No:" runat="server" meta:resourcekey="Rs_VisitNoResource1"></asp:Label>
                                                                </td>
                                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                                    <asp:Label ID="lblVisitNo" runat="server" meta:resourcekey="lblVisitNoResource1"
                                                                        nowrap="nowrap"></asp:Label>
                                                                </td>
                                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="right">
                                                                    <asp:Label ID="Rs_PatientNo" Text="Patient No:" runat="server" nowrap="nowrap"></asp:Label>
                                                                </td>
                                                                <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                                    <asp:Label ID="lblPatientNo" runat="server" nowrap="nowrap"></asp:Label>
                                                                </td>
                                                                <td style="font-weight: normal; color: #000; width: 8%;" align="right">
                                                                    <asp:Label ID="Label2" runat="server" Text="VisitDate:" nowrap="nowrap" />
                                                                </td>
                                                                <td style="font-weight: normal; color: #000; width: 11%;" align="left">
                                                                    <asp:Label ID="lblDate" runat="server" nowrap="nowrap"></asp:Label>
                                                                </td>
                                                                <td style="font-weight: normal; height: 20px; color: #000; width: 1%; display: none"
                                                                    align="left">
                                                                    <asp:Label ID="Rs_PatientName" Text="Patient Name:" runat="server" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                                                </td>
                                                                <td style="font-weight: normal; height: 20px; color: #000; width: 14%;" align="left">
                                                                    <asp:Label ID="lblPatientName" runat="server" meta:resourcekey="lblPatientNameResource1"
                                                                        nowrap="nowrap"></asp:Label>
                                                                </td>
                                                                <td style="font-weight: normal; height: 20px; color: #000; width: 1%; display: none"
                                                                    align="left">
                                                                    <asp:Label ID="Rs_Gender" Text="Gender:" runat="server"></asp:Label>
                                                                </td>
                                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                                    <asp:Label ID="lblGender" runat="server" nowrap="nowrap"></asp:Label>
                                                                </td>
                                                                <td style="font-weight: normal; height: 20px; color: #000; width: 1%; display: none"
                                                                    align="left">
                                                                    <asp:Label ID="Rs_Age" Text="Age:" runat="server"></asp:Label>
                                                                </td>
                                                                <td style="font-weight: normal; height: 20px; color: #000; width: 1%; display: none"
                                                                    align="left">
                                                                    <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1" nowrap="nowrap"></asp:Label>
                                                                </td>
                                                                <td style="font-weight: normal; height: 20px; color: #000; width: 6%;" align="Right">
                                                                    <asp:Label ID="Label3" runat="server" Text="Ref By:" nowrap="nowrap"></asp:Label>
                                                                </td>
                                                                <td style="font-weight: normal; height: 20px; color: #000; width: 14%;" align="left">
                                                                    <asp:Label ID="lblReferingPhysician" runat="server" nowrap="nowrap"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>--%>
                                    <br />
                                </td>
                            </tr>
                            <%--<tr>
                                                <td style="font-weight: bold; height: 20px; color: #000; width: 14%;">
                                                    List of Investigations Ordered
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                        <ContentTemplate>
                                                            <asp:DataList CellPadding="0" ID="dlInvName" RepeatColumns="5" runat="server" RepeatDirection="Horizontal">
                                                                <ItemTemplate>
                                                                    <table border="0" class="dataheader2">
                                                                        <tr>
                                                                            <td style="font-weight: normal; height: 20px; color: #000; width: 14%;">
                                                                                <%# DataBinder.Eval(Container.DataItem, "InvestigationName")%>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </asp:DataList>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </td>
                                            </tr>--%>
                            <tr>
                                <td class="a-left" colspan="6">
                                    <uc5:OrderedSamples ID="OrderedSamples1" runat="server" />
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td class="a-right" colspan="6">
                                    <uc8:SampleCollectedVisit ID="SampleCollectedVisit1" runat="server" />
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td class="a-center" colspan="6">
                                    <asp:Button Text="Save" ID="btnSubmit" runat="server" ToolTip="Click here to Save the Details"
                                        Style="cursor: pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        OnClientClick="return ValidateReason()" onmouseout="this.className='btn'" OnClick="btnSubmit_Click"
                                        meta:resourcekey="btnSubmitResource1" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" ToolTip="Click here to Cancel, View the Home Page"
                                        Style="cursor: pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                </td>
                               
                            </tr>
                            <tr>
                                <td style="display: none">
                                    <CollectSample:CollectSample ID="ctlCollectSample" runat="server" />
                                </td>
                            </tr>
                            <tr>
                            <td>&nbsp;</td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>
                                    <asp:HiddenField runat="server" ID="hdnVisit" />
                                    <asp:HiddenField runat="server" ID="hdnPatientNumber" />
                                    <asp:HiddenField runat="server" ID="hdnPatID" />
                                    <asp:HiddenField ID="hdnReasonList" runat="server" />
                                    <asp:HiddenField ID="hdnReasonCtls" runat="server" />
                                    <asp:HiddenField ID="hdnStatusCtls" runat="server" />
                                    <asp:HiddenField ID="hdnTestName" runat="server" />
                                    <asp:HiddenField ID="hdnTestID" Value="0" runat="server" />
                                    <asp:HiddenField ID="hdnTestType" runat="server" />
                                    <asp:HiddenField ID="hdnRefPhyName" runat="server" />
                                    <asp:HiddenField ID="hdnRefPhyID" Value="0" runat="server" />
                                    <asp:HiddenField ID="hdnRefPhyOrg" runat="server" />
                                    <asp:HiddenField ID="hdnClickEvent" Value="No" runat="server" />
                                    <asp:HiddenField ID="hdnTestCheckBoxId" runat="server" />
                                    <input type="hidden" id="HdnBtnClicked" runat="server" />
                                    <asp:HiddenField ID="hdnAlertflag" runat="server" Value="false" />
    
    <Attune:Attunefooter ID="Attunefooter" runat="server" />

    <script type="text/javascript">
        function datePick(objDate) {

            NewCal(objDate, 'ddmmyyyy', true, 12)

        }
    </script>

    <style type="text/css">
        .style1
        {
            height: 20px;
            width: 7%;
        }
        .style2
        {
            height: 20px;
            width: 9%;
        }
        .style3
        {
            height: 20px;
            width: 119px;
        }
        .style4
        {
            width: 73px;
        }
        .style5
        {
            height: 20px;
            width: 6%;
        }
        .style6
        {
            width: 46px;
        }
        table.gridView tr.enterresultstatcolor
{
    background-color: #EEB4B4!important;
    }
    
    </style>

    <script type="text/javascript" language="javascript">

        var AlertType = "";
        $(document).ready(function() {
            AlertType = SListForAppMsg.Get('Lab_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Lab_Header_Alert');
        });

        function expandDropDownList1(elementRef) {
            elementRef.style.width = '420px';
        }

        function WaterMark(txtbox, evt, defaultText) {
            if (txtbox.value.length == 0 && evt.type == "blur") {
                txtbox.style.color = "gray";
                txtbox.value = defaultText;
            }
            if (txtbox.value == defaultText && evt.type == "focus") {
                txtbox.style.color = "black";
                txtbox.value = "";
            }
        }

        function ShowAlertMsg(key) {
            /* Added By Venkatesh S */
            var vTaskAlerdyExists = SListForAppMsg.Get('Lab_DeptSamplesCollection_aspx_01') == null ? "This task has already been picked by another user!!!" : SListForAppMsg.Get('Lab_DeptSamplesCollection_aspx_01');
            //alert('This task has already been picked by another user!!!');
            ValidationWindow(vTaskAlerdyExists, AlertType);
            return false;
        }
        function SelectAllSamples(sender) {

            var chkArrayMain = new Array();
            chkArrayMain = document.getElementById('hdnTestCheckBoxId').value.split('~');
            if (document.getElementById(sender).checked) {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    document.getElementById(chkArrayMain[i]).checked = true;
                }
            }
            else {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    document.getElementById(chkArrayMain[i]).checked = false;
                }
            }
        }

        function ValidateReason() {
            /* Added By Venkatesh S */
            var vSelectReason = SListForAppMsg.Get('Lab_DeptSamplesCollection_aspx_02') == null ? "Select Reason" : SListForAppMsg.Get('Lab_DeptSamplesCollection_aspx_02');
            var vSelect = SListForAppDisplay.Get('Lab_DeptSamplesCollection_aspx_01') == null ? "-----Select-----" : SListForAppDisplay.Get('Lab_DeptSamplesCollection_aspx_01');

            var chkArrayStatus = new Array();
            chkArrayStatus = document.getElementById('hdnStatusCtls').value.split('~');
            var chkArrayReason = new Array();
            chkArrayReason = document.getElementById('hdnReasonCtls').value.split('~');

            for (var i = 0; i < chkArrayStatus.length; i++) {
                   var srfid= chkArrayStatus[i].replace('ddlSampleStatus','hdnIsSrf'); 
                   var txtsrf= chkArrayStatus[i].replace('ddlSampleStatus','txtSrfId');  
              if(document.getElementById(srfid).innerHTML == 'True' && document.getElementById('hdnAlertflag').value=='false')
              {
               if(document.getElementById(txtsrf).value =='')
               {
                  ValidationWindow('Please Enter SRF ID for SampleId '+barno, AlertType);
                  document.getElementById('hdnAlertflag').value ='true';
                     document.getElementById(txtsrf).focus();
                      $('#btnSubmit').show();
                     return false;
               }
              }
                var statusVal = document.getElementById(chkArrayStatus[i]).value;
                //SampleRejected - 4,SampleCancelled - 8,SampleNotCollected - 7,SampleNotGiven - 6
                if (statusVal == '4' || statusVal == '6' || statusVal == '7' || statusVal == '8' || statusVal == '13') {
                    var reasonVal = document.getElementById(chkArrayReason[i]).value;
                    if (reasonVal == '0' || reasonVal == vSelect) {
                        //alert('Select Reason');
                        ValidationWindow(vSelectReason, AlertType);
                        document.getElementById(chkArrayReason[i]).focus();
                        return false;
                    }
                }
            }
        }

        function fnSetSelectedReason(objReasonID, objHiddenID) {
            document.getElementById(objHiddenID).value = document.getElementById(objReasonID).options[document.getElementById(objReasonID).selectedIndex].text;
        }

        function fnLoadReasons(objReasonID, objStatusID) {
            var vSelect = SListForAppDisplay.Get('Lab_DeptSamplesCollection_aspx_01') == null ? "-----Select-----" : SListForAppDisplay.Get('Lab_DeptSamplesCollection_aspx_01');
            var newListItem;
            var objReasonID1 = document.getElementById(objReasonID);
            objReasonID1.options.length = 0;
            strSelStatusID = document.getElementById(objStatusID).value;
            var strReasons = document.getElementById('<%= hdnReasonList.ClientID %>').value.split('^');
            if (strSelStatusID == 3) {
                document.getElementById(objReasonID).style.display = "none";
            }
            else {
                document.getElementById(objReasonID).style.display = "block";
            }
            var strReasons = document.getElementById('<%= hdnReasonList.ClientID %>').value.split('^');
            if (strReasons.length > 0) {
                newListItem = document.createElement("option");
                objReasonID1.options.add(newListItem);
                newListItem.text = vSelect;
                newListItem.value = "0";
            }
            for (var i = 0; i < strReasons.length; i++) {
                var item1 = strReasons[i].split('~');
                for (var m = 0; m < item1.length; m++) {
                    var item2 = item1[m].split('-');
                    if (item2[0] == "4" || item2[0] == "6") {
                        newListItem = document.createElement("option");
                        objReasonID1.options.add(newListItem);
                        newListItem.text = item1[1];
                        newListItem.value = item2[1];
                    }
                }
            }
            if (objReasonID1.options.length == 0) {
                newListItem = document.createElement("option");
                objReasonID1.options.add(newListItem);
                newListItem.text = vSelect;
                newListItem.value = "0";
            }
        }

        function expandDropDownList(elementRef) {
            elementRef.style.width = '200px';
        }

        function collapseDropDownList(elementRef) {
            elementRef.style.width = elementRef.normalWidth;
        }

        function getFocus() {
            //            document.getElementById('txtSearchTxt').focus();
        }
        function txtBoxValidation() {
            /* Added By Venkatesh S */
            var vPatientVisitSearch = SListForAppMsg.Get('Lab_DeptSamplesCollection_aspx_03') == null ? "Provide patient visit number to search" : SListForAppMsg.Get('Lab_DeptSamplesCollection_aspx_03');
            if (document.getElementById('txtSearchTxt').value == '') {
                // alert('Provide patient visit number to search');
                ValidationWindow(vPatientVisitSearch, AlertType);
                return false;
            }
            return true;
        }

        function SelectedTest(source, eventArgs) {
            TestDetails = eventArgs.get_value();

            var TestName1 = TestDetails.split('~')[0];
            var TestName = TestName1.split(':')[0];
            var TestID = TestDetails.split('~')[1];
            var TestType = TestDetails.split('~')[2];
            document.getElementById('hdnTestName').value = TestName;
            document.getElementById('hdnTestID').value = TestID;
            document.getElementById('hdnTestType').value = TestType;
        }
        function ClearTestDetails() {
            document.getElementById('txtTestName').value = '';
            document.getElementById('hdnTestName').value = '';
            document.getElementById('hdnTestID').value = '0';
            document.getElementById('hdnTestType').value = '';

        }

        function SelectedRefPhy(source, eventArgs) {
            RefPhyDetails = eventArgs.get_value();

            var RefPhyName = RefPhyDetails.split('~')[0];
            var RefPhyID = RefPhyDetails.split('~')[1];
            var RefPhyOrg = RefPhyDetails.split('~')[2];
            document.getElementById('hdnRefPhyName').value = RefPhyName;
            document.getElementById('hdnRefPhyID').value = RefPhyID;
            document.getElementById('hdnRefPhyOrg').value = RefPhyOrg;

        }


        function ClearRefPhyDetails() {
            document.getElementById('txtRefDrName').value = '';
            document.getElementById('hdnRefPhyName').value = '';
            document.getElementById('hdnRefPhyID').value = '0';
            document.getElementById('hdnRefPhyOrg').value = '';

        }

        function validatePageNumber() {
            if (document.getElementById('txtpageNo').value == "") {
                return false;
            }
        }
        window.onbeforeunload = LeavePage;
        function LeavePage(e) {
            ValidateUserExit("User");
        }
        function TaskOpenJs(arg) {
            //LockReleased
            //alert(arg);
        }
        function ProcessCallBackError(arg) {
            //Error in UnLocking
            //alert('Error In Unlocking');
        }

        function showFooter(status) {
            if (status == 1) {
                document.getElementById('GrdFooter').style.display = "table-row";
            }
            else {
                document.getElementById('GrdFooter').style.display = "none";
            }
        }
        
    </script>
 
    </form>
    <script type="text/javascript">
        function datePick(objDate) {

            NewCal(objDate, 'ddmmyyyy', true, 12)

        }
    </script>
   
</body>
</html>
<script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>
