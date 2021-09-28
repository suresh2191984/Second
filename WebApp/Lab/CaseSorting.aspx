<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CaseSorting.aspx.cs" Inherits="Lab_CaseSorting" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <%--<script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>--%>

    <script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/ResultCapture.js" type="text/javascript"></script>

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <style type="text/css">
        .style2
        {
            width: 164px;
        }
        .style4
        {
            width: 153px;
        }
        .style5
        {
            width: 225px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
   <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:Panel ID="Panel1" runat="server" DefaultButton="btnBatchSearch" meta:resourcekey="Panel1Resource1">
                                    <%--<div id="DivSearchArea" class="filterdataheader2" style="display: block;">
                                        <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                            <tr>
                                                <td width="8%" align="right">
                                                    <asp:Label ID="lblDept" class="style1" runat="server" Text="Department"></asp:Label>
                                                </td>
                                                <td width="12%" align="left">
                                                    <span class="richcombobox" style="width: 130px;">
                                                        <asp:DropDownList ID="ddlDept" CssClass="ddl" runat="server" Width="130px">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td align="center">
                                                    <asp:Button ID="btnBatchSearch" Font-Bold="true" runat="server" Text="Search" OnClick="btnBatchSearch_Click"
                                                        CssClass="btn" Width="100" Height="30" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>--%>
                                    <div id="DivSearchArea" class="filterdataheader2" style="display: block;">
                                        <table class="w-100p searchPanel">
                                            <tr>
                                                <td class="a-right w-8p">
                                                    <asp:Label ID="lblDept" class="style1" runat="server" Text="Department" 
                                                        meta:resourcekey="lblDeptResource1"></asp:Label>
                                                </td>
                                                <td class="style4 a-left">
                                                    <span class="richcombobox" style="width: 130px;">
                                                        <asp:DropDownList ID="ddlDept" CssClass="ddl" runat="server" Width="130px" 
                                                        meta:resourcekey="ddlDeptResource1">
                                                        </asp:DropDownList>
                                                    </span>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td class="w-100 a-right">
                                                    <asp:Label ID="lblFrom" Text="From Date :" runat="server" 
                                                        meta:resourcekey="lblFromResource1"></asp:Label>
                                                </td>
                                                <td class="a-left style5">
                                                    <asp:TextBox Width="142px" ID="txtFrom" runat="server" CssClass="Txtboxsmall" 
                                                        meta:resourcekey="txtFromResource1"></asp:TextBox>
                                                    <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" /><br />
                                                    
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFrom"
                                                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                        Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFrom"
                                                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                                </td>
                                                
                                                <td class="a-left" colspan="2">
                                                     <asp:Label ID="lblTo" Text="ToDate" runat="server" 
                                                         meta:resourcekey="lblToResource1"></asp:Label>

                                                    <asp:TextBox ID="txtTo" Width="125px" runat="server" CssClass="Txtboxsmall" 
                                                         meta:resourcekey="txtToResource1"></asp:TextBox>
                                                    <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" /><br />
                                                    
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTo"
                                                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                        Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" 
                                                         meta:resourcekey="MaskedEditValidator1Resource1" />
                                                    <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtTo"
                                                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="a-right w-100">
                                                    <asp:Label ID="lblvisitNo" runat="server" Text="VisitNumber" 
                                                        meta:resourcekey="lblvisitNoResource1"></asp:Label>
                                                </td>
                                                <td class="a-left style4">
                                                    <asp:TextBox ID="txtvisitno" runat="server" CssClass="Txtboxsmall" 
                                                        meta:resourcekey="txtvisitnoResource1"></asp:TextBox>
                                                </td>
                                                <td class="a-right">
                                                    <asp:Label ID="lblInvestigationName" class="style1" runat="server" 
                                                        Text="Test Name" meta:resourcekey="lblInvestigationNameResource1"></asp:Label>
                                                </td>
                                                <td class="a-left style5">
                                                    <asp:TextBox ID="txtInvestigationName" CssClass="searchBox" runat="server" 
                                                        onfocus="javascript:ClearTestDetails();" 
                                                        meta:resourcekey="txtInvestigationNameResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoInvestigations" MinimumPrefixLength="2" runat="server"
                                                        TargetControlID="txtInvestigationName" ServiceMethod="FetchInvestigationNameForOrg"
                                                        ServicePath="~/WebService.asmx" EnableCaching="False" CompletionInterval="2"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" Enabled="True"
                                                        DelimiterCharacters=";,:" OnClientItemSelected="SelectedInvestigation" OnClientShown="TestPopulated">
                                                    </ajc:AutoCompleteExtender>
                                                    &nbsp;
                                                    <asp:HiddenField ID="hdnTestID" runat="server" Value="" />
                                                    <asp:HiddenField ID="hdnTestType" runat="server" Value="" />
                                                </td>
                                                <%-- <td width="12%" align="left" valign="top">
                                                                    <asp:CheckBox ID="chktasks" runat="server" Text="Allocated Tasks"
                                                                         />
                                                                </td>--%>
                                                 <td class="style2 a-left">
                                                    <asp:CheckBox ID="chkAssing" Text="Assigned Task" runat="server" 
                                                         oncheckedchanged="chkAssing_CheckedChanged" 
                                                         meta:resourcekey="chkAssingResource1" />
                                                 </td>
                                                <td class="style2 a-left">
                                                    
                                                    <asp:Button ID="btnBatchSearch" Font-Bold="true" runat="server" Text="Search" OnClick="btnBatchSearch_Click"
                                                        CssClass="btn" Width="120" Height="30" OnClientClick="return BatchValidation()" meta:resourcekey="btnBatchSearchResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>
                                <asp:Label runat="server" ID="lblMessage" Font-Bold="True" ForeColor="#000333" meta:resourcekey="lblMessageResource1"></asp:Label>
                                <asp:Panel runat="server">
                                    <div id="divgrdsample" runat="server">
                                        <table class="w-100p">
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="grdSample" runat="server" AutoGenerateColumns="False" Height="12%"
                                                         AllowPaging="True" class="mytable1 gridView w-100p" OnPageIndexChanging="grdSample_PageIndexChanging" meta:resourcekey="grdSampleResource1">
                                                        <HeaderStyle CssClass="dataheader1" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource1">
                                                                <HeaderTemplate>
                                                                    <asp:CheckBox ID="ChkbxHeaderSelect" runat="server" 
                                                                        meta:resourcekey="ChkbxHeaderSelectResource1" />
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="ChkbxSelect" runat="server" 
                                                                        meta:resourcekey="ChkbxSelectResource1" />
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Patient Name" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource2">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblPatientName" runat="server" 
                                                                        meta:resourcekey="lblPatientNameResource1" Text='<%# bind("Name") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="PatientNumber" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource3">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblPatientid" runat="server" Text='<%#bind("PatientNumber")%>' meta:resourcekey="lblPatientidResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            
                                                            <asp:TemplateField HeaderText="Visit Number" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource4">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblPatientNo" runat="server" Text='<%#bind("VisitNumber")%>' meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Age/Sex" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource5">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblage" runat="server" Text='<%#bind("age")%>' meta:resourcekey="lblageResource1" ></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            
                                                            <asp:TemplateField HeaderText="VisitID" Visible="false" ItemStyle-HorizontalAlign="Center"  meta:resourcekey="TemplateFieldResource6">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblVisitID" runat="server" Text='<%#bind("VisitID")%>'  meta:resourcekey="lblVisitIDResource1" ></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            
                                                            <asp:TemplateField HeaderText="InvestigationName"  ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource7">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblName" runat="server" Text='<%#bind("InvestigationName")%>' meta:resourcekey="lblNameResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="AccessionNo" Visible="false" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource8">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblacc" runat="server" meta:resourcekey="lblaccResource1" 
                                                                        Text='<%# bind("AccessionNumber") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Role/LoginName" ItemStyle-HorizontalAlign="Center" meta:resourcekey="TemplateFieldResource9">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblloginname" runat="server" Text='<%#bind("LoginName")%>' meta:resourcekey="lblloginnameResource1"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr id="GrdFooter" runat="server" class="dataheaderInvCtrl" visible="false">
                                                <td class="defaultfontcolor a-center">
                                                    <asp:Label ID="Label1" runat="server" Text="Page"></asp:Label>
                                                    <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                                    <asp:Label ID="Label2" runat="server" Text="Of"></asp:Label>
                                                    <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                                                    <asp:Button ID="Btn_Previous" runat="server" Text="Previous" CssClass="btn" OnClick="Btn_Previous_Click" />
                                                    <asp:Button ID="Btn_Next" runat="server" Text="Next" CssClass="btn" OnClick="Btn_Next_Click" />
                                                    <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                    <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:"></asp:Label>
                                                    <asp:TextBox ID="txtpageNo" runat="server" CssClass="Txtboxsmall" Width="30px" autocomplete="off"
                                                        onkeypress="return ValidateOnlyNumeric(this);"></asp:TextBox>
                                                    <asp:Button ID="btnGo1" runat="server" Text="Go" CssClass="btn" OnClick="btnGo1_Click"
                                                        onmouseover="this.className='btn btnhov'" OnClientClick="return checkForValues()" />
                                                    <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <br />
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:Panel ID="pnlddl" runat="server" 
                            meta:resourcekey="pnlddlResource1">
                                    <table class="w-100p">
                                        <tr id="ddlasignrole" runat="server" visible="false" class="a-left">
                                               <td class="w-10p">
                                               &nbsp;
                                               </td>
                                               <td class="w-10p">
                                               &nbsp;
                                               </td>
                                               
                                               <td class="w-18p">
                                                <asp:Label ID="lblrole" class="style1" runat="server" Text="Select&nbsp;Role:"></asp:Label>
                                                <asp:DropDownList ID="ddlrole" CssClass="ddl" runat="server" AutoPostBack="true"
                                                    OnSelectedIndexChanged="ddlrole_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                            <td class="w-3p">
                                            </td>
                                            <td class="w-18p a-left">
                                                <asp:Label ID="lbluser" class="style1" runat="server" Text="Select&nbsp;User:" Visible="false"></asp:Label>
                                                <asp:DropDownList ID="ddluser" CssClass="ddl" runat="server" Width="130px" Visible="false">
                                                </asp:DropDownList>
                                            </td>
                                            <td class="a-left w-12p">&nbsp;
                                                <asp:Button ID="btnadd" Font-Bold="true" runat="server" Text="Assign" OnClick="additems"
                                                    CssClass="btn" Visible="false" OnClientClick="return validate()" />
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table id="tbl1" class="w-100p">
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="900">
                                        <tr><td>&nbsp;</td></tr>
                                         <tr class="a-center">
                                         <td class="a-center">
                                         
                                                        <asp:GridView ID="grdrole" runat="server" AutoGenerateColumns="False" OnRowDeleting="grdrole_RowDeleting"
                                                            DataKeyNames="ID" class="mytable1 gridView w-100p" meta:resourcekey="grdroleResource1">
                                                            <HeaderStyle CssClass="dataheader1"  />
                                                            <Columns>
                                                             <asp:TemplateField HeaderText="ID" meta:resourcekey="TemplateFieldResource10">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblID" runat="server" meta:resourcekey="lblIDResource1" 
                                                                            Text='<%# Eval("ID") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Role" meta:resourcekey="TemplateFieldResource11">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblrole" runat="server" Text='<%#Eval("Role") %>' meta:resourcekey="lblroleResource1"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="User" meta:resourcekey="TemplateFieldResource12">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbluser" runat="server" meta:resourcekey="lbluserResource1" 
                                                                            Text='<%# Eval("User") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Roleid" 
                                                                    meta:resourcekey="TemplateFieldResource13">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblroleid" runat="server" meta:resourcekey="lblroleidResource1" 
                                                                            Text='<%# Eval("Roleid") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Userid" 
                                                                    meta:resourcekey="TemplateFieldResource14">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbluserid" runat="server" meta:resourcekey="lbluseridResource1" 
                                                                            Text='<%# Eval("Userid") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:CommandField HeaderText="Action" meta:resourcekey="CommandFieldResource1" 
                                                                    ShowDeleteButton="True">
                                                                    <ItemStyle ForeColor="Blue" />
                                                                </asp:CommandField>
                                                            </Columns>
                                                        </asp:GridView>
                                                        </td>
                                                    </tr>

                                        <tr class="a-center">
                                            <td class="a-center">
                                                <asp:Button ID="btnsave" Font-Bold="true" runat="server" Text="Save" OnClick="btnsave_Click"
                                                    CssClass="btn" Width="100" Height="30" Visible="false" OnClientClick="return onsave()" meta:resourcekey="btnsaveResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />            
        <input type="hidden" runat="server" id="hdnuserid" />

    </form>
</body>
</html>
<script language="javascript" type="text/javascript">
    jQuery(function($) {

        var allCkBoxSelector = '#<%=grdSample.ClientID%> input[id*="ChkbxHeaderSelect"]:checkbox';
        var checkBoxSelector = '#<%=grdSample.ClientID%> input[id*="ChkbxSelect"]:checkbox';
        function ToggleCheckUncheckAllOptionAsNeeded() {
            var totalCkboxes = $(checkBoxSelector),
        checkedCheckboxes = totalCkboxes.filter(":checked"),
        noCheckboxesAreChecked = (checkedCheckboxes.length === 0),
        allCkboxesAreChecked = (totalCkboxes.length === checkedCheckboxes.length);
            $(allCkBoxSelector).attr('checked', allCkboxesAreChecked);
        }

        $(allCkBoxSelector).live('click', function() {
            $(checkBoxSelector).attr('checked', $(this).is(':checked'));
            ToggleCheckUncheckAllOptionAsNeeded();
        });
        $(checkBoxSelector).live('click', ToggleCheckUncheckAllOptionAsNeeded);
        ToggleCheckUncheckAllOptionAsNeeded();

    });
    function ClearTestDetails() {
        if (document.getElementById('txtInvestigationName') != null) {
            document.getElementById('txtInvestigationName').value = '';
        }

        if (document.getElementById('hdnTestType') != null) {
            document.getElementById('hdnTestType').value = '';
        }
        if (document.getElementById('hdnTestID') != null) {
            document.getElementById('hdnTestID').value = '';
        }
    }
    function SelectedInvestigation(source, eventArgs) {

        var TestDetails = eventArgs.get_value();
        var lstTestDetails = TestDetails.split('~');

        var TestID = lstTestDetails[1];
        var TestType = lstTestDetails[2];

        $('#hdnTestID').val(TestID);
        $('#hdnTestType').val(TestType);
    }
    function BatchValidation() {
        var AlrtWinHdr = SListForAppMsg.Get("Lab_homecollection_aspx_02") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_02") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("Lab_CaseSorting_aspx_01") != null ? SListForAppMsg.Get("Lab_CaseSorting_aspx_01") : "Select Department";
        try {

            var ddlDept = $("#ddlDept :selected").val();
            if (ddlDept == '0') {
                //alert('Select Department');
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                return false;
            }

        }
        catch (e) {
            return false;
        }
    }
    function onsave() {
        //debugger;
        var AlrtWinHdr = SListForAppMsg.Get("Lab_homecollection_aspx_02") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_02") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("Lab_CaseSorting_aspx_02") != null ? SListForAppMsg.Get("Lab_CaseSorting_aspx_02") : "Select a Test";
        try {
            var checkBoxSelector = '#<%=grdSample.ClientID%> input[id*="ChkbxSelect"]:checkbox';
            var totalCkboxes = $(checkBoxSelector),
                checkedCheckboxes = totalCkboxes.filter(":checked")
            if (checkedCheckboxes.length == 0) {
                //alert("Select a Test");
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                return false;
            }
        }
        catch (e) {
            return false;
        }
    }
    function validate() {
        var AlrtWinHdr = SListForAppMsg.Get("Lab_homecollection_aspx_02") != null ? SListForAppMsg.Get("Lab_homecollection_aspx_02") : "Alert";
        var UsrAlrtMsg = SListForAppMsg.Get("Lab_CaseSorting_aspx_03") != null ? SListForAppMsg.Get("Lab_CaseSorting_aspx_03") : "Select User";
        var UsrAlrtMsg1 = SListForAppMsg.Get("Lab_CaseSorting_aspx_04") != null ? SListForAppMsg.Get("Lab_CaseSorting_aspx_04") : "Select Role";
	
        try {
            var ddlrole = $("#ddlrole :selected").val();
            var ddluser = $("#ddluser :selected").val();
            if (ddlrole != '0') {
                if (ddluser == '0') {
                    //alert('Select User');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
            }
            else
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
               // alert('Select Role');
        }
        catch (e) {
            return false;
        }
    }
    //        function LinkAssetDelete_OnClick(obj) {
    //            try {
    //                $(obj).closest('tr').remove();
    ////                 $('#div1').empty();
    //                
    //                
    //            }
    //            catch (e) {
    //                return false;
    //            }
    //            return false;
    //        }
       
    </script>