<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TriSampleCollection.aspx.cs"
    Inherits="Lab_TriSampleCollection" EnableEventValidation="true" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>--%>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Transfer Sample</title>
    <%--<script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>--%>
    <%--<script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>--%>
    <%--<script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>--%>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <%--
    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>--%>
    <%--    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>
    <%--  <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />--%>
    <style type="text/css">
        .style18
        {
            width: 89px;
        }
    </style>

    <script type="text/javascript" language="javascript">

//        $(function() {
//            ChangeDDLItemListWidth();
//            $("#ddlAction").change(function() {
//                if ($('#ddlAction :selected').val() == 'Aliquot_SampleSearch') {
//                    $('#TxtAliquot').show();
//                }
//                else
//                    $('#TxtAliquot').hide();
//                if ($('#ddlAction :selected').val() == 'Reject_Sample_SampleSearch') {
//                    $('#ddlReason').show();
//                }
//                else
//                    $('#ddlReason').hide();

//            });
//        });
    </script>

    <script type="text/javascript" language="javascript">

        function expandDropDownList1(elementRef) {
            elementRef.style.width = '210px';
        }

//        function collapseDropDownList(elementRef) {
//            elementRef.style.width = elementRef.normalWidth;
//        }
        
    </script>

    
</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnGo">
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
                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                meta:resourcekey="img1Resource1" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <table class="w-100p">
                    <tr>
                        <td>
                            <asp:Panel ID="pnlSerch" CssClass="w-100p searchPanel" runat="server">
                                <table cellpadding="2" class="dataheaderInvCtrl w-100p" cellspacing="2">
                                    <tr>
                                        <td class="w-10p a-right">
                                            <span class="richcombobox" class="w-75">
                                                <asp:DropDownList CssClass="ddlsmall w-75" ID="ddlType" runat="server" BackColor="AliceBlue"
                                                    meta:resourcekey="ddlTypeResource1">
                                                    <%--<asp:ListItem Text="Visit No." Value="1"></asp:ListItem>
                                                                        <asp:ListItem Text="Sample ID" Value="2"></asp:ListItem>--%>
                                                </asp:DropDownList>
                                            </span>
                                            <%--                                    <asp:Label ID="Rs_FromVisitNo"  Text="Visit No" runat="server" 
                                                                                            meta:resourcekey="Rs_FromVisitNoResource1"></asp:Label>--%>
                                        </td>
                                        <td class="w-20p">
                                            <asp:TextBox ID="txtVisitID" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtFromVisitResource1"></asp:TextBox>
                                        </td>
                                        <td class="w-8p a-left">
                                            <asp:Label ID="Rs_ToVisitNo" Text="Patient Name" runat="server" meta:resourcekey="Rs_ToVisitNoResource1"></asp:Label>
                                        </td>
                                        <td class="w-17p">
                                            <asp:TextBox ID="txtPatientName" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtToVisitResource1"></asp:TextBox>
                                        </td>
                                        <td class="a-left w-8p">
                                            <asp:Label ID="Rs_VisitType" Text=" Visit Type" runat="server" meta:resourcekey="Rs_VisitTypeResource1"></asp:Label>
                                        </td>
                                        <td class="w-20p">
                                            <span class="richcombobox">
                                                <asp:DropDownList CssClass="ddlsmall" ID="ddVisitType" runat="server" meta:resourcekey="ddVisitTypeResource1">
                                                    <%--  <asp:ListItem Text="Select" Value="-1"></asp:ListItem>
                                                                        <asp:ListItem Text="OP" Value="0"></asp:ListItem>
                                                                        <asp:ListItem Text="IP" Value="1"></asp:ListItem>--%>
                                                </asp:DropDownList>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="lbllocation" runat="server" Text="Processed At" meta:resourcekey="lbllocationResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <span class="richcombobox">
                                                <%-- <asp:DropDownList CssClass="ddlsmall" ID="ddlLocation"  onmousedown="expandDropDownList1(this);"
                                                    onblur="collapseDropDownList(this);" runat="server" onChange="javascript:return SetSampleStatus();">
                                                </asp:DropDownList>--%>
                                                <asp:DropDownList CssClass="ddlsmall" ID="ddlLocation" onmousedown="GetTextLen();"
                                                    runat="server" onChange="javascript:return SetSampleStatus();" meta:resourcekey="ddlLocationResource1">
                                                </asp:DropDownList>
                                            </span>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="lblsourcename" runat="server" Text="Client Name" meta:resourcekey="lblsourcenameResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtClientName" runat="server" CssClass="Txtboxsmall" onfocus="javascript:ClearClientDetails();"
                                                meta:resourcekey="txtClientNameResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender5" MinimumPrefixLength="2" runat="server"
                                                TargetControlID="txtClientName" ServiceMethod="FetchClientNameForOrg" ServicePath="~/WebService.asmx"
                                                EnableCaching="False" BehaviorID="AutoGrp122" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="ClientNameSelected">
                                            </ajc:AutoCompleteExtender>
                                            <asp:DropDownList CssClass="ddlsmall" ID="ddClientName" runat="server" Style="display: none"
                                                meta:resourcekey="ddClientNameResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="lblrefdocname" runat="server" Text="Ref. Doctor Name" meta:resourcekey="lblrefdocnameResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRefDrName" runat="server" CssClass="Txtboxsmall" onfocus="javascript:ClearRefPhyDetails();"
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
                                        <td class="a-left">
                                            <asp:Label ID="lbltestname" runat="server" Text="Test Name" meta:resourcekey="lbltestnameResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtTestName" runat="server" CssClass="Txtboxsmall" onfocus="javascript:ClearTestDetails();"
                                                meta:resourcekey="txtTestNameResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                                TargetControlID="txtTestName" ServiceMethod="FetchInvestigationNameForOrg" ServicePath="~/WebService.asmx"
                                                EnableCaching="False" BehaviorID="AutoCompleteExLstGrp11" CompletionInterval="2"
                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                Enabled="True" OnClientItemSelected="SelectedTest">
                                            </ajc:AutoCompleteExtender>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="Label3" runat="server" Text="Sample" meta:resourcekey="Label3Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TxtSampleName" runat="server" CssClass="Txtboxsmall" onfocus="javascript:ClearSampleDetails();"
                                                meta:resourcekey="TxtSampleNameResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" MinimumPrefixLength="2" runat="server"
                                                TargetControlID="TxtSampleName" ServiceMethod="FetchSampleNameForOrg" ServicePath="~/WebService.asmx"
                                                EnableCaching="False" BehaviorID="AutoGrp12" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedSample">
                                            </ajc:AutoCompleteExtender>
                                            <asp:DropDownList CssClass="ddlsmall" ID="ddlSample" runat="server" Style="display: none"
                                                meta:resourcekey="ddlSampleResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="lblpriority" runat="server" Text="Priority" meta:resourcekey="lblpriorityResource1"></asp:Label>
                                        </td>
                                        <td class="w-20p">
                                            <span class="richcombobox" class="w-80">
                                                <asp:DropDownList CssClass="ddlsmall" ID="ddlPriority" runat="server">
                                                    <%--      <asp:ListItem Text="Select" Value="-1" Selected="True" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                    <asp:ListItem Text="VIP" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                    <asp:ListItem Text="Emergency" Value="1" meta:resourcekey="ListItemResource3"></asp:ListItem>--%>
                                                </asp:DropDownList>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="Rs_From" Text="From Date" runat="server" meta:resourcekey="Rs_FromResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <table class="w-100p" cellpadding="2" cellspacing="1">
                                                <tr class="defaultfontcolor">
                                                    <td>
                                                        <asp:TextBox runat="server" ID="txtFrom" CssClass="Txtboxsmall" MaxLength="25" size="20"
                                                            meta:resourcekey="txtFromResource1"></asp:TextBox>&nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="Rs_To" Text="To Date" runat="server" meta:resourcekey="Rs_ToResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <table class="w-100p" cellpadding="2" cellspacing="1">
                                                <tr class="defaultfontcolor">
                                                    <td>
                                                        <asp:TextBox runat="server" ID="txtTo" MaxLength="25" CssClass="Txtboxsmall" size="20"
                                                            meta:resourcekey="txtToResource1"></asp:TextBox>&nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="lblSampleStatus1" runat="server" Text="Investigation Status" meta:resourcekey="lblSampleStatus1Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <span class="richcombobox" class="w-90">
                                                <asp:DropDownList CssClass="ddlsmall" ID="ddlSampleStatus" runat="server" onChange="javascript:return ShowProcessedLoc();"
                                                    meta:resourcekey="ddlSampleStatusResource1">
                                                </asp:DropDownList>
                                            </span>&nbsp;
                                            <img align="middle" alt="" src="../Images/starbutton.png" style="display: none" /><span
                                                class="richcombobox" style="width: 130px;"><asp:DropDownList ID="ddlprocessedlocation"
                                                    Style="display: none" onmousedown="expandDropDownList1(this);" runat="server"
                                                    CssClass="ddlsmall" meta:resourcekey="ddlprocessedlocationResource1">
                                                    <%--   onblur="collapseDropDownList(this);">--%>
                                                </asp:DropDownList>
                                                <asp:DropDownList runat="server" ID="ddloutsource" CssClass="ddlsmall" Style="display: none"
                                                    meta:resourcekey="ddloutsourceResource1">
                                                </asp:DropDownList>
                                            </span>&nbsp;<asp:HiddenField ID="hdnSampleStatus" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="lblbarcodeno" runat="server" Text="Barcode Number" meta:resourcekey="lblbarcodenoResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtbarcodeno" runat="server" CssClass="Txtboxsmall" MaxLength="25"
                                                size="20" meta:resourcekey="txtbarcodenoResource1"></asp:TextBox>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="lblContName" runat="server" Text="Container Name" meta:resourcekey="lblContNameResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtcontname" runat="server" CssClass="Txtboxsmall" MaxLength="25"
                                                onfocus="javascript:ClearContainerDetails();" meta:resourcekey="txtcontnameResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtendercon" runat="server" BehaviorID="AutoGrp150"
                                                CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                Enabled="True" MinimumPrefixLength="2" OnClientItemSelected="ContainerName" ServiceMethod="FetchSampleContainerForOrg"
                                                ServicePath="~/WebService.asmx" TargetControlID="txtcontname">
                                            </ajc:AutoCompleteExtender>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="lblpriority1" runat="server" Text="StatPriority" meta:resourcekey="lblpriority1Resource1"></asp:Label>
                                        </td>
                                        <td>
                                            <span class="richcombobox" class="w-90">
                                                <asp:DropDownList ID="ddlstat" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlstatResource1">
                                                </asp:DropDownList>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" class="a-center">
                                            <asp:Button ID="btnGo" runat="server" ToolTip="Click here to Generate Work Order"
                                                Style="cursor: pointer;" CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                Text="Search" OnClick="btnGo_Click" OnClientClick="return ValidateSearch();"
                                                meta:resourcekey="btnFinishResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" Text="No Matching Records Found!"
                                meta:resourcekey="lblStatusResource1"></asp:Label>
                            <div runat="server" id="dInves" style="display: block;">
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <asp:Panel ID="pnlSampleList" CssClass="dataheader2" BorderWidth="1px" runat="server"
                                                meta:resourcekey="pnlSampleListResource1">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td>
                                                            <asp:GridView ID="grdSample" runat="server" AutoGenerateColumns="False" Height="12%"
                                                                CssClass="gridView w-100p" PagerStyle-ForeColor="Black" DataKeyNames="PatientVisitID,SampleID,gUID,InvestigationID"
                                                                OnPageIndexChanging="grdSample_PageIndexChanging" OnRowDataBound="grdSample_RowDataBound"
                                                                meta:resourcekey="grdSampleResource1">
                                                                <Columns>
                                                                    <asp:TemplateField ItemStyle-Width="3%" meta:resourcekey="TemplateFieldResource1">
                                                                        <HeaderTemplate>
                                                                            <asp:CheckBox ID="chkHeader" runat="server" ToolTip="Select Row" Text="Select" onclick="SelectAllTest(this.id);"
                                                                                meta:resourcekey="chkHeaderResource1"></asp:CheckBox></HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <%-- <asp:RadioButton ID="rbSelect" GroupName="grpSelect" runat="server" OnClick="javascript:CheckOnOff(this.id,'grdSample');"/>--%>
                                                                            <asp:CheckBox ID="chkselect" runat="server" OnClick="javascript:CheckOnOff(this.id,'grdSample');"
                                                                                meta:resourcekey="chkselectResource1" />
                                                                            <asp:HiddenField ID="hdnVisitId" runat="server" Value='<%# bind("PatientVisitID") %>' />
                                                                            <asp:HiddenField ID="hdnSampleId" runat="server" Value='<%# bind("SampleID") %>' />
                                                                            <asp:HiddenField ID="hdnGuid" runat="server" Value='<%# bind("gUID") %>' />
                                                                            <asp:HiddenField ID="hdnSampleTrackerID" runat="server" Value='<%# bind("SampleTrackerID") %>' />
                                                                            <asp:HiddenField ID="hdnOutSourcedOrgName" runat="server" Value='<%# bind("OutSourcedOrgName") %>' />
                                                                            <asp:HiddenField ID="hdnTaskID" runat="server" Value='<%# bind("TaskID") %>' />
                                                                            <asp:HiddenField ID="hdnCollocationID" runat="server" Value='<%# bind("CollectedLocID") %>' />
                                                                            <asp:HiddenField ID="hdninvID" runat="server" Value='<%# bind("INVID") %>' />
                                                                            <asp:HiddenField ID="hdntype" runat="server" Value='<%# bind("Type") %>' />
                                                                            <asp:HiddenField ID="hdnSamplecollDate" runat="server" Value='<%# bind("Type") %>' />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Visit No" ItemStyle-Width="5%" ItemStyle-HorizontalAlign="left"
                                                                        meta:resourcekey="TemplateFieldResource2">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblptvisID" runat="server" Text='<%#bind("VisitNumber")%>' meta:resourcekey="lblptvisIDResource1"></asp:Label></ItemTemplate>
                                                                    </asp:TemplateField>
                                                                     <asp:TemplateField HeaderText="Lab No" ItemStyle-Width="5%" ItemStyle-HorizontalAlign="left"
                                                                        meta:resourcekey="TemplateFieldResource15">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblptextID" runat="server" Text='<%#bind("ExternalVisitID")%>'></asp:Label></ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Patient No" ItemStyle-Width="6%" ItemStyle-HorizontalAlign="left"
                                                                        meta:resourcekey="TemplateFieldResource3">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblpatno" runat="server" Text='<%# bind("PatientNumber") %>' meta:resourcekey="lblpatnoResource1"></asp:Label></ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Barcode No" ItemStyle-Width="6%" ItemStyle-HorizontalAlign="left"
                                                                        meta:resourcekey="TemplateFieldResource4">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblsampID" runat="server" Text='<%#bind("BarcodeNumber") %>' meta:resourcekey="lblsampIDResource1"></asp:Label></ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Patient Name" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="left"
                                                                        meta:resourcekey="TemplateFieldResource5">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblPatientName" runat="server" Text='<%#bind("PatientName")%>' meta:resourcekey="lblPatientNameResource1"></asp:Label></ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Investigations" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Left"
                                                                        meta:resourcekey="TemplateFieldResource6">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblTestName" runat="server" Text='<%# bind("InvestigationName") %>'
                                                                                meta:resourcekey="lblTestNameResource2"></asp:Label></ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Sample Name" ItemStyle-Width="9%" ItemStyle-HorizontalAlign="Left"
                                                                        meta:resourcekey="TemplateFieldResource7">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblSample" runat="server" Text='<%# bind("SampleDesc") %>' meta:resourcekey="lblSampleResource1"></asp:Label></ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Container" ItemStyle-Width="6%" ItemStyle-HorizontalAlign="Left"
                                                                        meta:resourcekey="TemplateFieldResource8">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblcontainer" runat="server" Text='<%# bind("SampleContainerName") %>'
                                                                                meta:resourcekey="lblcontainerResource1"></asp:Label></ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Sample Status" ItemStyle-Width="7%" ItemStyle-HorizontalAlign="Left"
                                                                        meta:resourcekey="TemplateFieldResource9">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblSampleStatus" runat="server" Text='<%#bind("InvSampleStatusDesc")%>'
                                                                                meta:resourcekey="lblSampleStatusResource1"></asp:Label><asp:HiddenField ID="hdnInvSampleStatusID"
                                                                                    runat="server" Value='<%#bind("InvSampleStatusID")%>' />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <%--  <asp:TemplateField HeaderText="Status" ItemStyle-Width="8%" ItemStyle-HorizontalAlign="Left">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblinvstatus" runat="server" Text='<%#bind("TestStatus")%>'></asp:Label></ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                     <asp:BoundField DataField="CreatedAt" HeaderText="Sample Reg.Date" ItemStyle-Width="10%"
                                                                                        ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" />--%>
                                                                    <asp:BoundField DataField="SamplePickupDate" HeaderText="Sample Collected Date And Time"
                                                                        ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                                        meta:resourcekey="BoundFieldResource1" />
                                                                    <asp:TemplateField HeaderText="Sample Collected At" ItemStyle-Width="8%" ItemStyle-HorizontalAlign="Left"
                                                                        meta:resourcekey="TemplateFieldResource10">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblsamprocat" runat="server" Text='<%#bind("LocationName") %>' meta:resourcekey="lblsamprocatResource1"></asp:Label></ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Sample Processed At" ItemStyle-Width="8%" ItemStyle-HorizontalAlign="Left"
                                                                        Visible="false" meta:resourcekey="TemplateFieldResource11">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblscollat" runat="server" Text='<%#bind("ProcessedAT")%>' meta:resourcekey="lblscollatResource1"></asp:Label></ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Sample Processed At" ItemStyle-Width="8%" ItemStyle-HorizontalAlign="Left"
                                                                        meta:resourcekey="TemplateFieldResource12">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblscollat1" runat="server" Text='<%#bind("ProcessedAT")%>' meta:resourcekey="lblscollat1Resource1"></asp:Label></ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Sample Address ID" Visible="False" meta:resourcekey="TemplateFieldResource13">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="sampleAddressID" runat="server" Text='<%# bind("AddressID") %>' meta:resourcekey="sampleAddressIDResource1"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <%--<asp:TemplateField HeaderText="Client Name" ItemStyle-Width="8%" ItemStyle-HorizontalAlign="Left">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblclname" runat="server" Text='<%#bind("ClientName") %>'>'></asp:Label></ItemTemplate>
                                                                                    </asp:TemplateField>--%>
                                                                    <asp:TemplateField HeaderText="Out Source Centre" ItemStyle-Width="12%" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource78">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbloutsrcename" runat="server" Text='<%#bind("OutSourcedOrgName") %>'
                                                                                meta:resourcekey="lbloutsrcenameResource1"></asp:Label></ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" VerticalAlign="Middle"
                                                                    Width="14" />
                                                                <HeaderStyle CssClass="dataheader1" Width="14" />
                                                                <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                                    PageButtonCount="5" PreviousPageText="" />
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                    <tr id="GrdFooter" runat="server" style="display: none;" class="dataheaderInvCtrl">
                                                        <td align="center" class="defaultfontcolor">
                                                            <asp:Label ID="Label4" runat="server" Text="Page" meta:resourcekey="Label4Resource1"></asp:Label><asp:Label ID="lblCurrent"
                                                                runat="server" Font-Bold="True" ForeColor="Red"></asp:Label><asp:Label ID="Label5"
                                                                    runat="server" Text="Of" meta:resourcekey="Label5Resource1"></asp:Label><asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label><asp:Button
                                                                        ID="btnPrevious" runat="server" Text="Previous" CssClass="btn" OnClick="btnPrevious_Click" meta:resourcekey="btnPreviousResource1" />
                                                            <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn" OnClick="btnNext_Click" meta:resourcekey="btnNextResource1" />
                                                            <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                            <asp:Label ID="Label6" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label6Resource1"></asp:Label><asp:TextBox
                                                                ID="txtpageNo" CssClass="w-30" runat="server"    onkeypress="return ValidateOnlyNumeric(this);"  
                                                                AutoComplete="off"></asp:TextBox><asp:Button ID="Button1" runat="server" Text="Go" meta:resourcekey="Button1Resource1"
                                                                    CssClass="btn" OnClick="btnGo1_Click" OnClientClick="javascript:return validatePageNumber();" />
                                                            <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:Panel ID="pnlFooter" CssClass="dataheader2 bg-row padding10" BorderWidth="1px"
                                                runat="server" meta:resourcekey="pnlFooterResource1">
                                                <table>
                                                    <%-- //added by sudhakar--%>
                                                    <tr id="action" runat="server">
                                                        <td id="Td2" style="color: #000;" runat="server" class="style18 a-right">
                                                            <asp:Label ID="lblReAssign" runat="server" Text="Action" meta:resourcekey="lblReAssignResource1"></asp:Label>
                                                        </td>
                                                        <td class="a-left" id="Td3" runat="server" style="color: #000;">
                                                            <span class="richcombobox">
                                                                <asp:DropDownList ID="ddlAction" runat="server" CssClass="ddlsmall" onclick="return Showhideloc()"
                                                                    Style="display: block">
                                                                </asp:DropDownList>
                                                            </span>
                                                        </td>
                                                    </tr>
                                                    <tr id="trtransloc" runat="server" style="display: table-row">
                                                        <td id="Td1" class="a-right" runat="server">
                                                            <%--<table width="80%">--%>
                                                            <%--</table>--%>
                                                            <asp:Label ID="Label1" runat="server" Text="Transferd&nbsp;Location" meta:resourcekey="Label1Resource1"></asp:Label>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:DropDownList ID="ddltransferloc" CssClass="ddlsmall" runat="server" onmousedown="expandDropDownList1(this);">
                                                               <%-- onblur="collapseDropDownList(this);">--%>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr id="trtransdate" runat="server" style="display: table-row">
                                                        <td id="Td10" runat="server" class="a-right">
                                                            <asp:Label ID="Label2" runat="server" Text="Transfer&nbsp;Date" meta:resourcekey="Label2Resource1"></asp:Label>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:TextBox ID="txttranDate" runat="server" CssClass="small"></asp:TextBox>
                                                            <a href="javascript:NewCssCal('txttranDate','ddmmyyyy','arrow',true,12)">
                                                                <img src="../images/Calendar_scheduleHS.png" id="img1" alt="Pick a date"></a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" class="a-center">
                                                            <asp:Button ID="btnOK" runat="server" CssClass="btn" OnClick="btnOK_Click" OnClientClick="return TransferValidation()"
                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Style="cursor: pointer;"
                                                                Text="Transfer Sample" meta:resourcekey="btnOKResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td id="Td4" class="a-right" runat="server" colspan="3">
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
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                                <input id="btnDummy1" runat="server" style="display: none;" type="button"></input>
                            </div>
                            <asp:HiddenField ID="HdnCheckBoxId" runat="server" />
                            <asp:HiddenField ID="hdnsampleID" runat="server" />
                            <asp:HiddenField ID="hdnMessages" runat="server" />
                            <asp:HiddenField ID="hdnSampleName" runat="server" />
                            <asp:HiddenField ID="hdnSmpleID" runat="server" />
                            <asp:HiddenField ID="hdncontname" runat="server" />
                            <asp:HiddenField ID="hdncontID" runat="server" />
                            <asp:HiddenField ID="hdnClientName" runat="server" />
                            <asp:HiddenField ID="hdnDate" runat="server" />
                                            <asp:HiddenField ID="hdnClientID" runat="server" />
                                            <asp:HiddenField ID="hdnLocationID" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
<%--<script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

<script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>

<script type="text/javascript">
    function DatePickUP() {
        $(function() {

        $("#txtFrom").datepicker({
            dateFormat: 'dd/mm/yy',
            defaultDate: "+1w",
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '1900:2100',
            onClose: function(selectedDate) {
                $("#txtTo").datepicker("option", "minDate", selectedDate);

                var date = $("#txtFrom").datepicker('getDate');
                //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                // $("#txtTo").datepicker("option", "maxDate", d);

            }
        });
        $("#txtTo").datepicker({
            dateFormat: 'dd/mm/yy',
            defaultDate: "+1w",
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '1900:2100',
            onClose: function(selectedDate) {
                $("#txtFrom").datepicker("option", "maxDate", selectedDate);
            }
        });
        });
    }
    $(function() {
        $("#txtFrom").datepicker({
            dateFormat: 'dd/mm/yy',
            defaultDate: "+1w",
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '1900:2100',
            onClose: function(selectedDate) {
                $("#txtTo").datepicker("option", "minDate", selectedDate);

                var date = $("#txtFrom").datepicker('getDate');
                //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                // $("#txtTo").datepicker("option", "maxDate", d);

            }
        });
        $("#txtTo").datepicker({
            dateFormat: 'dd/mm/yy',
            defaultDate: "+1w",
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: '1900:2100',
            onClose: function(selectedDate) {
                $("#txtFrom").datepicker("option", "maxDate", selectedDate);
            }
        });
    });
</script>

<script type="text/javascript">
    if (typeof DatePickUP == 'function')
        Sys.Application.add_load(DatePickUP);  </script>
        <script language="javascript" type="text/javascript">
            /* Common Alert Validation */
            var AlertType;

            $(document).ready(function() {
                AlertType = SListForAppMsg.Get('Lab_Pendinglist_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Lab_Pendinglist_aspx_01');
            });

            function CheckOnOff(chkselectID, gridName) {
                var rdo = document.getElementById(chkselectID);
                var all = document.getElementsByTagName("input");
                for (i = 0; i < all.length; i++) {
                    if (all[i].type == "radio" && all[i].id != rdo.id) {
                        var count = all[i].id.indexOf(gridName);
                        if (count != -1) {
                            all[i].checked = false;
                        }
                    }
                }
                chkselectID.checked = true;
            }

            function ValidateSearch() {
                /* Added By Venkatesh S */
                var vFromDate = SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_01') == null ? "Select From date" : SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_01');
                var vToDate = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_03') == null ? "Select To date" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_03');
                AlertType = SListForAppMsg.Get('Lab_Pendinglist_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Lab_Pendinglist_aspx_01');

                var bolSelected = 'false';

                if (document.getElementById('txtFrom').value == '') {
                    userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_1');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;

                    }
                    else {
                        ValidationWindow(vFromDate, AlertType);
                        return false;

                    }
                    document.getElementById('txtFrom').focus();
                    return false;
                }

                if (document.getElementById('txtTo').value == '') {
                    userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;

                    }
                    else {
                        ValidationWindow(vToDate, AlertType);
                        return false;

                    }
                    document.getElementById('txtTo').focus();
                    return false;
                }
            }

            function validateAliquot() {
                /* Added By Venkatesh S */
                var vSampleAliquot = SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_09') == null ? "Select a Sample for Aliquot" : SListForAppMsg.Get('Lab_PendingSampleCollection_aspx_09');
                AlertType = SListForAppMsg.Get('Lab_Pendinglist_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Lab_Pendinglist_aspx_01');

                var bolSelected = 'false';

                var radios = document.getElementsByTagName('input');
                var value;
                for (var i = 0; i < radios.length; i++) {
                    if (radios[i].type === 'radio' && radios[i].checked) {
                        bolSelected = 'true';
                    }
                }

                if (bolSelected == 'false') {
                    userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_4');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;

                    }
                    else {
                        ValidationWindow(vSampleAliquot, AlertType);
                        return false;

                    }
                    document.getElementById('TxtAliquot').value = 0;
                    return false;
                }

            }

            function ValidateSelect() {
                /* Added By Venkatesh S */
                var vActionPerform = SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_03') == null ? "This Action is only Performed for Outsourcing Sample.So Please Choose Outsourcing Sample for Capture OutSourcing Details" : SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_03');
                var vSampleNotSuitable = SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_04') == null ? "This Action is not Suitable For Outsourcing Sample." : SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_04');
                var vReason = SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_05') == null ? "Select Reason" : SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_05');
                var vSelectSample = SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_06') == null ? "Select a Sample" : SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_06');
                var vSelectAction = SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_07') == null ? "Select Action" : SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_07');
                var vAliquotValue = SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_08') == null ? "Aliquot Value not Equal to Zero" : SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_08');
                var vAliquot = SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_09') == null ? "Enter Aliquot Value" : SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_09');
                AlertType = SListForAppMsg.Get('Lab_Pendinglist_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Lab_Pendinglist_aspx_01');

                var bolSelected = 'false';
                var Outsourceselected = 'true';
                $("#grdSample tr:not(:first)").each(function(i, n) {
                    var $row = $(n);
                    var rbSelect = $row.find("input[id$='rbSelect']").is(":checked");
                    if (rbSelect) {
                        var lblSampleStatus = $row.find("span[id$='lblSampleStatus']").html();
                        if (lblSampleStatus != 'OutSource' && $('#ddlAction :selected').val() == 'Capture_OutSourcing_Details') {
                            userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_5');
                            if (userMsg != null) {
                                alert(userMsg);
                                return false;

                            }
                            else {
                                ValidationWindow(vActionPerform, AlertType);
                                return false;
                            }
                            Outsourceselected = 'false';
                        }
                        if (lblSampleStatus == 'OutSource' && $('#ddlAction :selected').val() != 'Capture_OutSourcing_Details') {
                            userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_6');
                            if (userMsg != null) {
                                alert(userMsg);
                                return false;

                            }
                            else {
                                ValidationWindow(vSampleNotSuitable, AlertType);
                                return false;
                            }
                            Outsourceselected = 'false';
                        }
                    }
                });
                if (Outsourceselected == 'false') {
                    return false;
                }
                var radios = document.getElementsByTagName('input');
                var value;
                for (var i = 0; i < radios.length; i++) {
                    if (radios[i].type === 'radio' && radios[i].checked) {
                        bolSelected = 'true';


                    }
                }

                if (($('#ddlAction :selected').val() == 'Reject_Sample_SampleSearch') && ($('#ddlReason :selected').val() == '0')) {
                    userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_7');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;

                    }
                    else {
                        ValidationWindow(vReason, AlertType);
                        return false;
                    }
                }

                if (bolSelected == 'false') {
                    userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_8');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;

                    }
                    else {
                        ValidationWindow(vSelectSample, AlertType);
                        return false;
                    }
                }

                if ($('#ddlAction :selected').val() == '0') {
                    userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_9');
                    if (userMsg != null) {
                        alert(userMsg);
                        return false;

                    }
                    else {
                        ValidationWindow(vSelectAction, AlertType);
                        return false;
                    }
                }
                if ($('#ddlAction :selected').val() == 'Aliquot_SampleSearch') {
                    if ($('#TxtAliquot').val() == '0') {
                        userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_10');
                        if (userMsg != null) {
                            alert(userMsg);
                            return false;

                        }
                        else {
                            ValidationWindow(vAliquotValue, AlertType);
                            return false;
                        }
                    }
                }
                if ($('#ddlAction :selected').val() == 'Aliquot_SampleSearch') {
                    if ($('#TxtAliquot').val() == '') {
                        userMsg = SListForApplicationMessages.Get('Lab\\PendingSampleCollection.aspx_11');
                        if (userMsg != null) {
                            alert(userMsg);
                            return false;

                        }
                        else {
                            ValidationWindow(vAliquot, AlertType);
                            return false;
                        }
                    }
                }
            }

            function SelectedTest(source, eventArgs) {
                TestDetails = eventArgs.get_value();

                var TestName1 = TestDetails.split('~')[0];
                var TestName = TestName1.split(':')[0];
                var TestID = TestDetails.split('~')[1];
                var TestType = TestDetails.split('~')[2];
                if (document.getElementById('hdnTestName') != null) {
                    document.getElementById('hdnTestName').value = TestName;
                }
                if (document.getElementById('hdnTestID') != null) {
                    document.getElementById('hdnTestID').value = TestID;
                }
                if (document.getElementById('hdnTestType') != null) {
                    document.getElementById('hdnTestType').value = TestType;
                }
            }

            function ClearTestDetails() {
                if (document.getElementById('txtTestName') != null) {
                    document.getElementById('txtTestName').value = '';
                }
                if (document.getElementById('hdnTestName') != null) {
                    document.getElementById('hdnTestName').value = '';
                }
                if (document.getElementById('hdnTestID') != null) {
                    document.getElementById('hdnTestID').value = '0';
                }
                if (document.getElementById('hdnTestType') != null) {
                    document.getElementById('hdnTestType').value = '';
                }
            }

            function SelectedRefPhy(source, eventArgs) {
                RefPhyDetails = eventArgs.get_value();

                var RefPhyName = RefPhyDetails.split('~')[0];
                var RefPhyID = RefPhyDetails.split('~')[1];
                var RefPhyOrg = RefPhyDetails.split('~')[2];
                if (document.getElementById('hdnRefPhyName') != null) {
                    document.getElementById('hdnRefPhyName').value = RefPhyName;
                }
                if (document.getElementById('hdnRefPhyID') != null) {
                    document.getElementById('hdnRefPhyID').value = RefPhyID;
                }
                if (document.getElementById('hdnRefPhyOrg') != null) {
                    document.getElementById('hdnRefPhyOrg').value = RefPhyOrg;
                }
            }

            function ClearRefPhyDetails() {
                if (document.getElementById('txtRefDrName') != null) {
                    document.getElementById('txtRefDrName').value = '';
                }
                if (document.getElementById('hdnRefPhyName') != null) {
                    document.getElementById('hdnRefPhyName').value = '';
                }
                if (document.getElementById('hdnRefPhyID') != null) {
                    document.getElementById('hdnRefPhyID').value = '0';
                }
                if (document.getElementById('hdnRefPhyOrg') != null) {
                    document.getElementById('hdnRefPhyOrg').value = '';
                }
            }


            function TempDate() {
                $("#txtFrom").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    maxDate: 100,
                    yearRange: '1900:2100'
                });
                $("#txtTo").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    maxDate: 0,
                    yearRange: '1900:2100'
                })

            }

            function Showhideloc() {
                var ActionID;
                var ActionName;

                var ddlAction = $('select[id$="ddlAction"] :selected');

                if (ddlAction != null) {

                    ActionID = $(ddlAction).val();

                    ActionName = $(ddlAction).text();

                }
                if (ActionName == "TriSample") {
                    document.getElementById('trtransloc').style.display = 'table-row';
                    document.getElementById('trtransdate').style.display = 'table-row';
                }
                else {
                    document.getElementById('trtransloc').style.display = 'none';
                    document.getElementById('trtransdate').style.display = 'none';
                }
            }
            function SetSampleStatus() {
                var LocationCode;
                var TextLen;
                var ddlProcessedAt = $('select[id$="ddlLocation"] :selected');
                if (ddlProcessedAt != null) {
                    LocationCode = $(ddlProcessedAt).val();
                    TextLen = ddlProcessedAt[0].text;
                    SetDDlWidh(TextLen);
                    if (LocationCode != undefined) {
                        if (LocationCode > 0) {
                            $("#ddlSampleStatus option[value='-1']").attr("selected", "selected");
                        }
                        else {
                            $("#ddlSampleStatus option[value='7']").attr("selected", "selected");
                        }
                    }
                }
            }
            function GetTextLen() {
                var TextLen;
                var ddlProcessedAt = $('select[id$="ddlLocation"] :selected');
                TextLen = ddlProcessedAt[0].text;
                SetDDlWidh(TextLen);
            }
            function SetDDlWidh(obj) {
                var Len = obj.length * 6; // + 'px';
                if (Len > 166) {
                    Len = obj.length * 6 + 'px';
                    document.getElementById('ddlLocation').style.width = Len;
                }
                else { document.getElementById('ddlLocation').style.width = '167px'; }
            }
            function ShowProcessedLoc() {
                var SampleStatusCode;
                var SampleStatusName;

                var ddlSampleStatus = $('select[id$="ddlSampleStatus"] :selected');

                if (ddlSampleStatus != null) {

                    SampleStatusCode = $(ddlSampleStatus).val();

                    SampleStatusName = $(ddlSampleStatus).text();

                }
                //if (SampleStatusCode == "6") {
                //   document.getElementById('ddlprocessedlocation').style.display = 'block';
                //  }
                // else {
                //  document.getElementById('ddlprocessedlocation').style.display = 'none';
                //}
                if (SampleStatusCode == "8") {
                    document.getElementById('ddloutsource').style.display = 'block';
                }
                else {
                    document.getElementById('ddloutsource').style.display = 'none';
                }
            }
            function validatePageNumber() {
                var EnterPg = SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_132') == null ? "Enter Page No." : SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_132');
                var InvalidPg = SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_133') == null ? "Invalid Page No." : SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_133');
                AlertType = SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_alert') == null ? "Alert" : SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_alert');
                if (document.getElementById('txtpageNo').value == "") {
                    ValidationWindow(EnterPg, AlertType);
                    return false;
                }
                if ( parseInt(document.getElementById('txtpageNo').value) >   parseInt(document.getElementById('lblTotal').textContent)) {
                    
                    ValidationWindow(InvalidPg, AlertType);
                    return false;
                }
                return true;
            }

            function TransferValidation() {
                /* Added By Venkatesh S */
                var vSelectCorrectDate = SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_10') == null ? "Select a Correct Date And Time" : SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_10');
                var vLocationTransfer = SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_11') == null ? "Select a Location to Transfer" : SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_11');
                var vDifferentProcessing = SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_12') == null ? "Select a Different Processing Location to Transfer" : SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_12');
                var vSampleTransfer = SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_13') == null ? "Select a Sample to Transfer" : SListForAppMsg.Get('Lab_TransferSampleCollection_aspx_13');
                AlertType = SListForAppMsg.Get('Lab_Pendinglist_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Lab_Pendinglist_aspx_01');

                var isValid = false;
                var trnsferlocId;
                var trnsferlocName;
                var CurrLocationId;
                var Todaydate = document.getElementById('hdnDate').value;
                var transferDate = document.getElementById('txttranDate').value;
                if (transferDate > Todaydate) {
                    ValidationWindow(vSelectCorrectDate, AlertType);
                    return false;

                }
                else {
                    var ddltransferloc = $('select[id$="ddltransferloc"] :selected');

                    if (ddltransferloc != null) {

                        trnsferlocId = $(ddltransferloc).val();

                        trnsferlocName = $(ddltransferloc).text();
                        CurrLocationId = document.getElementById('hdnLocationID').value;

                    }
                    var gridView = document.getElementById('<%= grdSample.ClientID %>');
                    for (var i = 1; i < gridView.rows.length; i++) {
                        var inputs = gridView.rows[i].getElementsByTagName('input');
                        if (inputs != null) {
                            if (inputs[0].type == "checkbox") {
                                if (inputs[0].checked) {
                                    if (trnsferlocId == "-1") {
                                        ValidationWindow(vLocationTransfer, AlertType);
                                        document.getElementById('ddltransferloc').Value = -1
                                        return false

                                    }
                                    else {
                                        if (trnsferlocId == CurrLocationId) {
                                            ValidationWindow(vDifferentProcessing, AlertType);
                                            document.getElementById('ddltransferloc').value = -1;
                                            return false;
                                        }
                                    }

                                    isValid = true;
                                    return true;
                                }
                            }
                        }
                    }
                    ValidationWindow(vSampleTransfer, AlertType);
                    return false;
                }
            }
            function SelectedSample(source, eventArgs) {
                SampleDetails = eventArgs.get_value();

                var TestName = SampleDetails.split('~')[0];
                var TestID = SampleDetails.split('~')[1];
                if (document.getElementById('hdnSampleName') != null) {
                    document.getElementById('hdnSampleName').value = TestName;
                }
                if (document.getElementById('hdnSmpleID') != null) {
                    document.getElementById('hdnSmpleID').value = TestID;
                }
            }
            function ClearSampleDetails() {
                if (document.getElementById('txtSampleName') != null) {
                    document.getElementById('txtSampleName').value = '';
                }
                if (document.getElementById('hdnSampleName') != null) {
                    document.getElementById('hdnSampleName').value = '';
                }
                if (document.getElementById('hdnSmpleID') != null) {
                    document.getElementById('hdnSmpleID').value = '0';
                }
            }
            //        function ClearSampleDetails() {
            //            if (document.getElementById('TxtSampleName') != null) {
            //                document.getElementById('TxtSampleName').value = '';
            //            }
            //            if (document.getElementById('hdnSampleName') != null) {
            //                document.getElementById('hdnSampleName').value = '';
            //            }
            //            if (document.getElementById('hdnSmpleID') != null) {
            //                document.getElementById('hdnSmpleID').value = '0';
            //            }
            //        }
            function SelectAllTest(sender) {

                var chkArrayMain = new Array();
                chkArrayMain = document.getElementById('HdnCheckBoxId').value.split('~');
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


            function ClientNameSelected(source, eventArgs) {
                ClientDetails = eventArgs.get_value();
                var ClientName = ClientDetails.split('~')[0];
                var ClientID = ClientDetails.split('~')[1];
                if (document.getElementById('hdnClientName') != null) {
                    document.getElementById('hdnClientName').value = ClientName;
                }
                if (document.getElementById('hdnClientID') != null) {
                    document.getElementById('hdnClientID').value = ClientID;
                }
            }

            function ClearClientDetails() {
                if (document.getElementById('txtClientName') != null) {
                    document.getElementById('txtClientName').value = '';
                }
                if (document.getElementById('hdnClientName') != null) {
                    document.getElementById('hdnClientName').value = '';
                }
                if (document.getElementById('hdnClientID') != null) {
                    document.getElementById('hdnClientID').value = '0';
                }
            }

            function ContainerName(source, eventArgs) {
                ContainerDetais = eventArgs.get_value();

                var ContName = ContainerDetais.split('~')[0];
                var ContID = ContainerDetais.split('~')[1];
                if (document.getElementById('hdncontname') != null) {
                    document.getElementById('hdncontname').value = ContName;
                }
                if (document.getElementById('hdncontID') != null) {
                    document.getElementById('hdncontID').value = ContID;
                }
            }

            function ClearContainerDetails() {
                if (document.getElementById('txtcontname') != null) {
                    document.getElementById('txtcontname').value = '';
                }
                if (document.getElementById('hdncontname') != null) {
                    document.getElementById('hdncontname').value = '';
                }
                if (document.getElementById('hdncontID') != null) {
                    document.getElementById('hdncontID').value = '0';
                }
            }
    </script>
</html>
<script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>