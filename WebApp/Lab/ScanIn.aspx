<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ScanIn.aspx.cs" EnableEventValidation="false"
    Inherits="Lab_ScanIn" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Scan In</title>

    <script src="../Scripts/jquery-1.11.3.min.js" type="text/javascript"></script>

    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .testclass
        {
            display: none;
        }
        .row-highlight
        {
            background-color: Yellow;
        }
        .row-select
        {
            background-color: red;
        }
        
        .ddl
        {
            max-width: 200px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnSubmit" defaultfocus="txtBarcodeSample">
    <asp:ScriptManager ID="ctlTaskScriptMgr" ScriptMode="Release" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div id='wrapper' class="contentdata">
        <asp:UpdatePanel ID="updatePanel1" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar1" AssociatedUpdatePanelID="updatePanel1" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter" class="a-center">
                        </div>
                        <div id="processMessage" class="a-center w-20p">
                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <table border="0" class="searchPanel w-100p">
                    <tr style="width: 100%">
                        <td style="width: 10%; padding-top: 1%; padding-bottom: 1%;">
                            <table class="searchPanel w-100p">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblBarcodeSample" runat="server" Text="Lab Number/Barcode"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtBarcodeSample" CssClass="textfield" runat="server" MaxLength="12"></asp:TextBox>
                                        <img align="middle" alt="" src="../Images/starbutton.png" />
                                    </td>
                                    <%--</tr>
                                <tr>--%>
                                    <td>
                                        <asp:Label ID="dept" runat="server" Text="Team"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="ddl">
                                        </asp:DropDownList>
                                        <img align="middle" alt="" src="../Images/starbutton.png" />
                                    </td>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" Text="Sample Type"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlSampleType" runat="server" CssClass="ddl">
                                        </asp:DropDownList>
                                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn pointer" OnClick="btnSubmit_Click"
                                            OnClientClick="return submitbutton();" Text="Submit" ToolTip="Submit" />
                                    </td>
                                    <%--</tr>--%>
                                    <%-- <tr>--%>
                                    <td>
                                        <asp:Label ID="Label3" runat="server" Text="Barcode Type"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlBarcodeType" runat="server" AutoPostBack="true" CssClass="ddl"
                                            OnSelectedIndexChanged="ddlBarcodeType_SelectedIndexChanged1">
                                            <asp:ListItem Selected="True" Value="-1">--Both--</asp:ListItem>
                                            <asp:ListItem Value="1">Primary</asp:ListItem>
                                            <asp:ListItem Value="2">Secondary</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text="Printer"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlPrinters" runat="server" CssClass="ddl" Style="width: 30%;">
                                        </asp:DropDownList>
                                        <img align="middle" alt="" src="../Images/starbutton.png" />
                                        <asp:Button ID="btnPrint" runat="server" CssClass="btn pointer" OnClientClick="return ValidatePrinter();"
                                            Text="Print" OnClick="btnPrint_Click" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table id="divAction" style="display: none" runat="server">
                                <tr>
                                    <td>
                                        <asp:Label ID="Label4" Text="Action" runat="server"></asp:Label>
                                        <asp:DropDownList ID="ddlAction" CssClass="ddl" runat="server" onchange="ShowReason();">
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
                                            OnClick="btnOk_Click" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <div style="display: block; color: #333333; border-collapse: collapse; overflow-y: scroll;
                    height: 250px !important;" runat="server" id="gv">
                    <asp:GridView ID="GridView1" runat="server" Style="overflow-y: auto;" CssClass="mytable1 w-100p gridView"
                        PagerStyle-Font-Bold="true" ForeColor="#333333" PagerSettings-Mode="NumericFirstLast"
                        AutoGenerateColumns="False" OnRowDataBound="GridView1_RowDataBound" OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
                        OnPageIndexChanging="GridView1_PageIndexChanging" AllowSorting="True" EnableSortingAndPagingCallbacks="True">
                        <%--                        <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast"
                            PageButtonCount="5" />--%>
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:CheckBox ID="chkAll" runat="server" Text=" " />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkPrint" runat="server" Text=" " onclick="checkUncheckHeaderCheckBox(this.id);"
                                        OnCheckedChanged="chkPrint_CheckedChanged" />
                                    <asp:HiddenField ID="hfBarcodenumber" Value='<%# Eval("BarcodeNumber") %>' runat="server" />
                                    <asp:HiddenField ID="hfDepartmentId" Value='<%# Eval("DeptId") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5%" HeaderText="Sl.No"
                                ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                    <asp:HiddenField ID="hfOrderId" Value='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Width="5%" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="LabNumber" HeaderText="Lab Number" />
                            <asp:BoundField DataField="BarcodeNumber" HeaderText="Barcode" />
                            <asp:BoundField DataField="SampleType" HeaderText="Sample Type" />
                            <asp:BoundField DataField="Container" HeaderText="Container" />
                            <asp:BoundField DataField="TeamName" HeaderText="Team Custody" />
                            <%--<asp:BoundField DataField="DeptName" HeaderText="Department" />--%>
                            <asp:BoundField DataField="PatientRegisterdType" HeaderText="Patient Registered Type" />
                            <asp:BoundField DataField="ReceivedTime" HeaderText="Received Time" />
                            <asp:BoundField DataField="ScanCount" HeaderText="Scan Count" />
                            <asp:BoundField DataField="SampleStatus" HeaderText="Sample Status" />
                            <asp:BoundField DataField="CollectionCenter" HeaderText="Collection Center" />
                            <asp:TemplateField HeaderText="Report Due Date" ItemStyle-Width="10%">
                                <ItemTemplate>
                                    <asp:Label ID="tatDate" runat="server" Text='<%#Eval("ReportDateTime").ToString()=="01/01/1753 00:00:00" || Eval("ReportDateTime").ToString()=="01/01/0001 00:00:00"? " ":Eval("ReportDateTime") %>' />
                                </ItemTemplate>
                                <ItemStyle Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Print">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdIsSecondaryBarcode" runat="server" Value='<%# bind("IsSecBarCode") %>' />
                                    <asp:CheckBox ID="chkSecondaryBarcode" Enabled="false" runat="server" Text=" " />
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
                                    <asp:HiddenField ID="hdnSampleid" runat="server" Value='<%# bind("SampleId") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <%--<PagerStyle Font-Bold="True" CssClass="pagerTable" />--%>
                    </asp:GridView>
                </div>
                <div id="SampleDetail" runat="server" ScrollBars="Auto">
                    <ajc:TabContainer ID="grouptab" runat="server" ActiveTabIndex="0">
                        <ajc:TabPanel ID="SampleDetails" runat="server" HeaderText="Sample Details">
                            <HeaderTemplate>
                                Sample Details
                            </HeaderTemplate>
                            <ContentTemplate>
                                <div class="contentdata">
                                    <asp:GridView ID="GridView2" runat="server" PageSize="5" Font-Size="Smaller" AllowPaging="True"
                                        CssClass="mytable1 w-100p gridView" AutoGenerateColumns="False" ForeColor="#333333"
                                        OnPageIndexChanging="GridView2_PageIndexChanging" OnRowDataBound="GridView2_RowDataBound">
                                        <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast"
                                            PageButtonCount="5" />
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
                                    <asp:GridView ID="GridView3" runat="server" PageSize="5" AllowPaging="True" CssClass="mytable1 w-100p gridView "
                                        AutoGenerateColumns="False" ForeColor="#333333" PagerStyle-Font-Bold="true" PagerSettings-Mode="NumericFirstLast"
                                        OnPageIndexChanging="GridView3_PageIndexChanging">
                                        <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast"
                                            PageButtonCount="5" />
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
                                            <asp:BoundField DataField="LoginName" HeaderText="User Name" />
                                        </Columns>
                                        <%--<PagerStyle CssClass="PagerStyle" />--%>
                                    </asp:GridView>
                                </div>
                            </ContentTemplate>
                        </ajc:TabPanel>
                    </ajc:TabContainer>
                </div>
                <asp:HiddenField ID="hdnPatientVisitID" runat="server" />
                <asp:HiddenField ID="hdnActionName" runat="server" />
                <Attune:Attunefooter ID="Attunefooter" runat="server" />
                <asp:HiddenField ID="HdnSampleEnquiryCheckBoxId" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <%--<script src="../Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>--%>

    <script type="text/javascript">

        $(document).ready(function() {
            $('#SampleDetail').css("display", "none");
            $('#wrapper').addClass("contentdata");
            document.addEventListener('contextmenu', event => event.preventDefault());
            $('#CheckBox1').change(function() {
                $('tbody tr td input[class="chk1"]').prop('checked', $(this).prop('checked'));
                return true;
            });
            if ($('#GridView1:visible') == true) {
                $('#SampleDetail').css("display", "block");
            }
            else {
                $('#SampleDetail').css("display", "none");
                $('#wrapper').addClass("contentdata");
            }
        });

        function highlite(m) {
            $('#dReason').css("cssText", "display:none !Important");
            var tr = null;
            var gv = document.getElementById("<%= GridView1.ClientID %>");
            var items = $('#GridView1 input[name$="chkPrint"]');
            var count = 0;
            for (var i = 0; i < items.length; i++) {
                count = 1 + i;
                if (items[i].checked) {
                    $('#GridView1 tr').eq(count).removeAttr("style");
                    $('#GridView1 tr').eq(count).css("cssText", "background-color:#99E5E5 !important;");
                }
                else {
                    $('#ddlAction').val(-1);
                    var c = 1 + parseInt(m);
                    $('#GridView1 tr').eq(c).removeAttr("style");
                    $('#GridView1 tr').eq(c).css("cssText", "background-color:yellow !important;");
                }
            }


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

        function submitbutton() {
            debugger;
            var row = $('#ddlDepartment').val().split('~');
            $('#dReason').css("display", "none");
            var s = true;
            if ($('#txtBarcodeSample').val() == '') {
                ValidationWindow('Please enter Lab Number/Barcode', 'Alert');
                s = false;
            }
            else if ($('#ddlDepartment').val() == '-1') {
                ValidationWindow('Please select Team Name', 'Alert');
                s = false;
            }
            else if (row[1] == 0) {
                $('#txtBarcodeSample').val('');
                ValidationWindow(" Auto Scan In enabled for this Team.</br> Manual Scan In is not allowed", "Alert");
                s = false;
            }

            if ($('#GridView1:visible') == true) {
                $('#SampleDetail').css("display", "block");
            }
            else {
                $('#SampleDetail').css("display", "none");
                $('#wrapper').addClass("contentdata");
            }
            return s;
        }

        //        function blurs() {
        //            if ($('#txtBarcodeSample').val() != '') {
        //                
        //                
        //                else
        //                    submitbutton();
        //            }
        //            else {
        //                ValidationWindow('Please enter Lab Number/Barcode', 'Alert');
        //            }
        //        }

        function ValidatePrinter() {
            if ($('#ddlPrinters').val() == '-1') {
                ValidationWindow('Please select printer', 'Alert');
                return false;
            }
            else if ($('#GridView1:visible').length == 0) {
                ValidationWindow('Record is not available to print.', 'Alert');
                return false;
            }
            else if ($('#GridView1 input[name$="chkPrint"]:checked').length == 0) {
                ValidationWindow('Record is not selcted for print.', 'Alert');
                return false;
            }
            else if (!validateUnregisteredForPrint()) {
                istrue = false;
            }
            else if ($('#GridView1').length > 0 && $('#GridView1 input[name$="chkPrint"]:checked').length > 0) {
                return true;
            }
        }

        function ValidateSampleType() {
            if ($('#ddlSampleType').val() == '-1') {
                ValidationWindow('Please select Sample Type', 'Alert');
                return false;
            }
            else if ($('#GridView1:visible').length == 0) {
                ValidationWindow('Record is not available to print.', 'Alert');
                return false;
            }
            return hidegrid();
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

        $(document).on('change', '#GridView1_ctl01_chkAll', function() {
            var tableControl = document.getElementById('mytable');
            if (this.checked) {
                $('#GridView1 input[name$="chkPrint"]').prop('checked', true);
                $('#GridView1 input[name$="chkPrint"]:checked', tableControl).each(function() {
                    $(this).closest('tr').removeAttr("style");
                    $(this).closest('tr').css("cssText", "background-color:#99E5E5 !important;");
                });

                $('#SampleDetail').css("display", "none");
            }
            else {
                $('#GridView1 input[name$="chkPrint"]').prop('checked', false);
                $('#SampleDetail').css("display", "none");
                $('#GridView1 input[name$="chkPrint"]', tableControl).each(function() {
                    $(this).closest('tr').removeAttr("style");
                });
            }
        });

        $(document).on('change', '#GridView1 input[name$="chkPrint"]', function() {
            $('#SampleDetail').css("display", "none");
        });

        function ShowReason() {
            if (($('#ddlAction :selected').val() == 'Reject_Sample_SampleSearch') || ($('#ddlAction :selected').val() == 'Not_Given_Sample_Enquiery')) {
                document.getElementById('hdnActionName').value = $('#ddlAction :selected').val();
                $('#dReason').css("display", "block");
                $('#dReason').val(-1);
            }
            else {
                $('#dReason').css("display", "none");
                document.getElementById('hdnActionName').value = $('#ddlAction :selected').val();

            }
        }

        function Validate() {
            hidegrid();
            var SelectedValue;
            var istrue = true;
            var SampleStatus;
            var checkBoxSelector = '#<%=GridView1.ClientID%> input[id*="chkPrint"]:checkbox';
            var totalCkboxes = $(checkBoxSelector),
                checkedCheckboxes = totalCkboxes.filter(":checked")
            document.getElementById('hdnActionName').value = $('#ddlAction :selected').val();
            SampleStatus = validateSampleStatus();
            if ($('#ddlAction :selected').val() == '-1') {
                alert("Select Action", "Alert");
                istrue = false;
            }
            else if (($('#ddlAction :selected').val() == 'Reject_Sample_SampleSearch') && ($('#ddlReason :selected').val() == '0')) {
                alert("Select Reason", "Alert");
                istrue = false;
            }
            else if (($('#ddlAction :selected').val() == 'Not_Given_Sample_Enquiery') && ($('#ddlReason :selected').val() == '0')) {
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
            $('#SampleDetail').css("display", "none");
            return istrue;
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
                        $('#GridView1_ctl01_chkAll').attr('checked', false);
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
        
        function validateUnregisteredForPrint() {
            var istrue = true;
            var patientregistertype;
            var items = $('#GridView1 input[name$="chkPrint"]');
            for (var i = 0; i < items.length; i++) {
                count = 1 + i;
                if (items[i].checked) {
                    patientregistertype = $('#GridView1 tr').eq(count).find('td:eq(7)').text();
                    if (patientregistertype == 'Un-Registered') {
                        alert('You can not take print out for the un-registered patient.');
                        $('#GridView1 tr').eq(count).removeAttr("style");
                        $('#GridView1_ctl01_chkAll').attr('checked', false);
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
