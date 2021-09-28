<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationOrgChange.aspx.cs"
    Inherits="Lab_InvestigationOrgChange" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>--%>
<%@ Register Src="../CommonControls/OrderedSamples.ascx" TagName="OrderedSamples"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Investigation Org Change</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <style type="text/css">
        .dataheaderPopup
        {
            background-image: url(../Images/whitebg.png);
            background-repeat: repeat;
            width: auto;
            margin-left: 0px;
            margin-top: 0px;
            margin-bottom: 10px;
            border-color: #f17215;
            border-style: solid;
            border-width: 5px;
            color: #000000;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function getFocus() {
            document.getElementById('txtPatientSearch').focus();
        }
        function txtBoxValidation() {
            /* Added By Venkatesh S */
            var vPatientName = SListForAppMsg.Get('Lab_InvestigationOrgChange_aspx_04') == null ? "Provide valid patient details" : SListForAppMsg.Get('Lab_InvestigationOrgChange_aspx_04');
 //           if (document.getElementById('txtPname').value != '') {
//                if (document.getElementById('hdnApprover').value == '') {
//                    //alert('Provide valid patient name');
//                    ValidationWindow(vPatientName, AlertType);
//                    return false;
//                }
            if (document.getElementById('txtPname').value != '' || document.getElementById('txtPatientSearch').value != '' || document.getElementById('txtvisitno').value != '') {
                return true;
            }
            else {
                ValidationWindow(vPatientName, AlertType);
                return false;
            }          
        }
        function checkboxchecked() {

            var sam = document.getElementById('lblInvestigation').value;
            document.getElementById('hdnInvestication').value = sam;
        }

        function Cleartxt() {
            /* Added By Venkatesh S */
            var vAuthorisedby = SListForAppMsg.Get('Lab_InvestigationOrgChange_aspx_05') == null ? "Enter Authorised by" : SListForAppMsg.Get('Lab_InvestigationOrgChange_aspx_05');
            var InvSelect = SListForAppMsg.Get('Lab_InvestigationOrgChange_aspx_06') == null ? "Please Select Atleast a Investigation" : SListForAppMsg.Get('Lab_InvestigationOrgChange_aspx_06');
            
            if (document.getElementById('txtAuthorised').value.trim() == '') {
                document.getElementById('txtAuthorised').focus();
                ValidationWindow(vAuthorisedby, AlertType);
                return false;
            }
            else if ($('#grdResult tr').find('input[type="checkbox"]:checked').length == 0) {
            ValidationWindow(InvSelect, AlertType);
                return false;
            }
            else {
                document.getElementById('txtPatientSearch').value = '';
                return true;
            }
        }

        function DropCheck(ddlLocID, chkSelID) {
            document.getElementById(chkSelID).checked = true;
        }
        function AuthSelected(source, eventArgs) {
            //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            document.getElementById('hdnApprover').value = eventArgs.get_value();
        }
        function AuthSelectedPatient(source, eventArgs) {
            //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
            document.getElementById('hdnApprover').value = eventArgs.get_value();
        }
    </script>

<script type="text/javascript">
//Added for Select/Deselect checkboxes based on header checkbox -START
    function SelectheaderCheckboxes(headerchk) {
        //debugger
        var gvcheck = document.getElementById('grdResult');
        var i;
        //Condition to check header checkbox selected or not if that is true checked all checkboxes
        if (headerchk.checked) {
            for (i = 0; i < gvcheck.rows.length; i++) {
                var inputs = gvcheck.rows[i].getElementsByTagName('input');                
                //changes by arun - disabled the check box if ReferralID is > 0 in orderedinv table
                var checkboxid = inputs[0].id;
                if (document.getElementById(checkboxid).hasAttribute('disabled')) {
                    inputs[0].checked = false;
                }
                else {
                    inputs[0].checked = true;
                }
                //
                //inputs[0].checked = true;
            }
        }
        //if condition fails uncheck all checkboxes in grdResult
        else {
            for (i = 0; i < gvcheck.rows.length; i++) {
                var inputs = gvcheck.rows[i].getElementsByTagName('input');
                inputs[0].checked = false;
            }
        }
    }
    //function to check header checkbox based on child checkboxes condition
    function Selectchildcheckboxes(header) {
        var ck = header;
        var count = 0;
        var gvcheck = document.getElementById('grdResult');
        var headerchk = document.getElementById(header);
        var rowcount = gvcheck.rows.length;
        //By using this for loop we will count how many checkboxes has checked
        for (i = 1; i < gvcheck.rows.length; i++) {
            var inputs = gvcheck.rows[i].getElementsByTagName('input');
            if (inputs[0].checked) {
                count++;
            }
        }
        //Condition to check all the checkboxes selected or not
        if (count == rowcount - 1) {
            headerchk.checked = true;
        }
        else {
            headerchk.checked = false;
        }
    }

    //Added for Select/Deselect checkboxes based on header checkbox -END
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
                        <asp:Label ID="lblPatient" runat="server" Text="Lab Number" ></asp:Label>
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
                        <asp:TextBox ID="txtPname" runat="server"  autocomplete="off" CssClass="small"
                            meta:resourcekey="txtPnameResource1"></asp:TextBox>
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
                    <td class="a-center" colspan="4">
                        <asp:Button ID="btnGo" runat="server" CssClass="btn" meta:resourcekey="btnGoResource1"
                            OnClick="btnGo_Click" OnClientClick="return txtBoxValidation()" Style="cursor: pointer;"
                            Text="Search" ToolTip="Click here to Collect the Sample" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" Text="No Matching Records Found!"
            meta:resourcekey="lblStatusResource1"></asp:Label>
        <div runat="server" id="dInves" style="display: none;">
            <asp:Table CssClass="font11 w-100p colorforcontentborder" runat="server" ID="dispTab"
                meta:resourcekey="dispTabResource1">
                <asp:TableRow ID="tblReferred" runat="server" CssClass="h-15" meta:resourcekey="tblReferredResource1">
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
                        <asp:Table runat="server" ID="trCC" CssClass="w-100p" Style="display: none;" meta:resourcekey="trCCResource1">
                            <asp:TableRow CssClass="h-15" meta:resourcekey="TableRowResource1">
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
            <asp:Panel ID="pnlptDetails" CssClass="dataheader2" runat="server" meta:resourcekey="pnlptDetailsResource1">
                <table class="w-100p searchPanel">
                    <tr class="h-15  colorforcontent paddingT5 paddingB5">
                        <td colspan="10">
                            <b>
                                <asp:Label ID="Rs_PatientDetails" Text="Patient Details" runat="server" meta:resourcekey="Rs_PatientDetailsResource1"></asp:Label></b>
                        </td>
                    </tr>
                    <tr class="h-20">
                        <td class="w-10p a-left h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="Rs_PatientNo" Text="Patient No:" runat="server" meta:resourcekey="Rs_PatientNoResource1"></asp:Label>
                        </td>
                        <td class="w-10p a-left h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblPatientNo" runat="server" meta:resourcekey="lblPatientNoResource1"></asp:Label>
                        </td>
                        <td class="w-13p a-left h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="Rs_PatientNo1" Text="Patient Name:" runat="server" meta:resourcekey="Rs_PatientNo1Resource1"></asp:Label>
                        </td>
                        <td class="a-left h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblPatientName" runat="server" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                        </td>
                        <td class="w-5p a-left h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="Rs_Gender" Text="Gender:" runat="server" meta:resourcekey="Rs_GenderResource1"></asp:Label>
                        </td>
                        <td class="w-8p a-left h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblGender" runat="server" meta:resourcekey="lblGenderResource1"></asp:Label>
                        </td>
                        <td class="w-5p a-left h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="Rs_Age" Text="Age" runat="server" meta:resourcekey="Rs_AgeResource1"></asp:Label>
                        </td>
                        <td class="w-10p a-left h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                        </td>
                        <td class="w-8p a-left h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="Rs_VisitNo" Text="Visit No:" runat="server" meta:resourcekey="Rs_VisitNoResource1"></asp:Label>
                        </td>
                        <td class="w-5p a-left h-20" style="font-weight: normal; color: #000;">
                            <asp:Label ID="lblVisitNo" runat="server" meta:resourcekey="lblVisitNoResource1"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <table class="w-100p">
                <tr>
                    <td class="a-center">
                        <asp:Label ID="lblText" runat="server" Text="Select a Alternative Location" Font-Bold="True"
                            Font-Size="Larger" meta:resourcekey="lblTextResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                    <div style="max-width: 100%; max-height: 400px; overflow: scroll">
                        <asp:HiddenField ID="hdn" runat="server" />
                        <asp:GridView ID="grdResult" runat="server" CssClass="gridView w-100p" 
                            AutoGenerateColumns="False"  PagerStyle-ForeColor="black" 
                            OnRowDataBound="grdResult_RowDataBound" meta:resourcekey="grdResultResource1">
                            <Columns>
                                <asp:TemplateField>
                               <HeaderTemplate>
                                <asp:CheckBox ID="chkheader" runat="server" onclick="javascript:SelectheaderCheckboxes(this)" />Select
                                </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" runat="server" />
                                      
                                        <asp:HiddenField ID="hdnvalue" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Ordered Date/Time" meta:resourcekey="TemplateFieldResource20">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCreated" runat="server" Text='<%# Bind("CreatedAt") %>' ></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="InvestigationName" meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <asp:Label ID="lblName" runat="server" Text='<%# Bind("Name") %>' ></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Ordered Status" meta:resourcekey="TemplateFieldResource15">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("Status") %>' ></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Location" meta:resourcekey="TemplateFieldResource3">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlLocation" onchange="javascript:DropCheck(ddlLocID, chkSelID);"
                                            runat="server" CssClass="ddlsmall" ToolTip="Select Location" meta:resourcekey="ddlLocationResource1">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ChangeStatus" meta:resourcekey="TemplateFieldResource4">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlstatus" runat="server" CssClass="ddlsmall" >
                                            <%-- <asp:ListItem meta:resourcekey="ListItemResource1">Paid</asp:ListItem>
                                                            <asp:ListItem meta:resourcekey="ListItemResource2">Completed</asp:ListItem>
                                                            <asp:ListItem meta:resourcekey="ListItemResource3">Reject</asp:ListItem>--%>
                                           <%-- <asp:ListItem meta:resourcekey="ListItemResource4">Pending</asp:ListItem>--%>
                                            <%-- <asp:ListItem meta:resourcekey="ListItemResource5">Approve</asp:ListItem>
                                                            <asp:ListItem meta:resourcekey="ListItemResource6">SampleReceived</asp:ListItem>
                                                            <asp:ListItem meta:resourcekey="ListItemResource7">SampleCollected</asp:ListItem>
                                                            <asp:ListItem meta:resourcekey="ListItemResource8">OutSource</asp:ListItem>
                                                            <asp:ListItem meta:resourcekey="ListItemResource9">Cancel</asp:ListItem>
                                                            <asp:ListItem>Recheck</asp:ListItem>
                                                            <asp:ListItem>Validate</asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Reason" meta:resourcekey="TemplateFieldResource5">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlReason" onchange="javascript:DropCheck(ddlLocID, chkSelID);"
                                            runat="server" CssClass="ddlsmall" ToolTip="Select Reason" >
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="InvestigationID" Visible="false" meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <asp:Label ID="lblInvestigation" runat="server" Text='<%# Bind("ID") %>' Visible="False"
                                            ></asp:Label>
                                        <asp:Label ID="lblVisitID" runat="server" Text='<%# Bind("VisitID") %>' Visible="False"
                                            ></asp:Label>
                                        <asp:Label ID="lblAccessionNumber" runat="server" Text='<%# Bind("AccessionNumber") %>'
                                            Visible="False" ></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Type" Visible="false" meta:resourcekey="TemplateFieldResource7">
                                    <ItemTemplate>
                                        <asp:Label ID="lblType" runat="server" Text='<%# Bind("Type") %>' Visible="False"
                                            ></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Type" Visible="false" meta:resourcekey="TemplateFieldResource8">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUID" runat="server" Text='<%# Bind("UID") %>' Visible="False" ></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        </div>
                    </td>
                </tr>
                <tr id="tdflag" runat="server">
                    <td>
                        <span id="span2" runat="server" class="font14" style="font-weight: 600; font-family: Trebuchet MS;
                            font-style: italic;">
                            <%=Resources.Lab_AppMsg.Lab_InvestigationOrgChange_aspx_01 %></span>
                        <asp:Label ID="lblNotes" runat="server" Text="Approval test can be deflaged  by Doctor's only."
                            Font-Italic="True" CssClass="font-14" meta:resourcekey="lblNotesResource1"></asp:Label>
                    </td>
                </tr>
                <tr id="trApprover" runat="server" style="display: table-row;">
                    <td class="bold h-20 w-5p" style="color: #000;">
                        <asp:Label ID="lblApprover" runat="server" Text="Approver" meta:resourcekey="lblApproverResource1"></asp:Label>
                        &nbsp;
                        <asp:TextBox ID="txtAuthorised" CssClass="small" autocomplete="off" runat="server"
                            meta:resourcekey="txtAuthorisedResource1" />
                        <asp:HiddenField ID="hdnApprover" runat="server" Value="0" />
                        <ajc:AutoCompleteExtender ID="AutoAuthorizer" runat="server" CompletionInterval="10"
                            CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                            CompletionListItemCssClass="wordWheel itemsMain"  EnableCaching="False"
                            Enabled="True" MinimumPrefixLength="1" FirstRowSelected="true" ServiceMethod="getUserNamesWithNameandLoginID"
                            ServicePath="~/WebService.asmx" TargetControlID="txtAuthorised" OnClientItemOver="SelectedTempAuth"
                            OnClientItemSelected="AuthSelected">
                        </ajc:AutoCompleteExtender>
                    </td>
                </tr>
                <tr>
                    <td class="a-center">
                        <asp:HiddenField ID="hdnInvestigation" runat="server" />
                        <asp:Button Text="Save" ID="btnSubmit" runat="server" ToolTip="Click here to Save the Details"
                            Style="cursor: pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" OnClick="btnSubmit_Click" OnClientClick="javascript:return Cleartxt();"
                            meta:resourcekey="btnSubmitResource1" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" ToolTip="Click here to Cancel, View the Home Page"
                            Style="cursor: pointer;" CssClass="btn" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />

    <script type="text/javascript" language="javascript">
        /* Common Alert Validation */
        var AlertType;
        $(document).ready(function() {
            AlertType = SListForAppMsg.Get('Lab_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Lab_Header_Alert');
        });
        function SelectedTempAuth() {
            /* Added By Venkatesh S */
            var vSelectApprover = SListForAppMsg.Get('Lab_InvestigationOrgChange_aspx_01') == null ? "Please select approver from the list" : SListForAppMsg.Get('Lab_InvestigationOrgChange_aspx_01');
            $find('AutoAuthorizer')._onMethodComplete = function(result, context) {
                //var Perphysicianname = document.getElementById('txtperphy').value;
                $find('AutoAuthorizer')._update(context, result, /* cacheResults */false);
                if (result == "") {
                    //alert('Please select approver from the list');
                    ValidationWindow(vSelectApprover, AlertType);
                    document.getElementById('txtAuthorised').value = '';
                }
            };
        }
    </script>

    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnOrgId" runat="server" />
    <asp:HiddenField ID="hdnPatientId" runat="server" />
    <asp:HiddenField ID="hdnUID" runat="server" />
    <asp:HiddenField ID="hdnLabNo" runat="server" />
    </form>
</body>
</html>
