<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="BatchWiseWorkList.aspx.cs"
    Inherits="Investigation_BatchWiseWorkList" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Src="MicroPattern.ascx" TagName="MicroPattern" TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" /><%--
    <link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="Stylesheet" type="text/css" />
<link href="https://cdn.datatables.net/buttons/1.5.6/css/buttons.dataTables.min.css" rel="Stylesheet" type="text/css" />--%>
<link href="../StyleSheets/1.10.19.datatable.min.css" rel="Stylesheet" type="text/css" />
    <link href="../StyleSheets/1.5.6-buttons.datatable.min.css" rel="Stylesheet" type="text/css" />

 

    <script language="javascript" type="text/javascript">
   
 function SelectedInvestigation(source, eventArgs) {
            var InvestigationID = eventArgs.get_value();
            $('#hdnInvestigationID').val(InvestigationID);
        }
        function SelectedGroup(source, eventArgs) {
            var GrpID = eventArgs.get_value();
            $('#hdnGrpID').val(GrpID);
        }
        function ValidateSearch() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vSelectWorkList = SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_01') == null ? "Please Select Work List Type" : SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_01');
            var vInvestigationName = SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_02') == null ? "Please Choose Investigation Name From Auto Search" : SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_02');
            var vWorkListFormat = SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_03') == null ? "Not Associated for this WorkListFormat Type" : SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_03');
            var vAutoSearch = SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_04') == null ? "Please Choose WorkListID From Auto Search" : SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_04');
            var vFromAutoSearch = SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_05') == null ? "Not Associated for this WorkListFormat Type" : SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_05');
            var vVisitNo = SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_06') == null ? "Please Choose Group Name From Auto Search" : SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_06');
            var vVisttNoAutoSearch = SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_07') == null ? "Please Enter From Visit No For Auto Search" : SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_07');
            var vVisttNoForAutoSearch = SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_08') == null ? "Please Enter To Vistt No For Auto Search" : SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_08');
            var vWorkListFormatType = SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_09') == null ? "Not Associated for this WorkListFormat Type" : SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_09');
            var vFromDate = SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_10') == null ? "Please Enter From Date" : SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_10');
            var vPendingDays = SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_11') == null ? "Please select the Pending Days" : SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_11');
            var vTestStatus = SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_12') == null ? "Please select the test status" : SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_12');
            var vPendingDaysEntPendingDays = SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_13') == null ? "Please select the Pending Days or enter the Pending Days " : SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_13');
            var vToDate = SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_14') == null ? "Please Enter To Date" : SListForAppMsg.Get('Investigation_BatchWiseWorkList_aspx_14');
            //debugger;
            var ddlval = $("#ddlWorkListType :selected").val();
            if (ddlval == '0') {
                //alert('Please Select Work List Type');
               ValidationWindow(vSelectWorkList, AlertType);
                return false;
            }
            else if (ddlval == 'Investigation_Based') {
                if ($("#hdnInvestigationID").val() == '0') {
                    //alert('Please Choose Investigation Name From Auto Search');
                    ValidationWindow(vInvestigationName, AlertType);
                    return false;
                }
                if ($("#ddlWLFormatType").val() != "Portrait Format" && $("#ddlWLFormatType").val() != "--Select--") {
                  //  alert('Not Associated for this WorkListFormat Type');
                    ValidationWindow(vWorkListFormat, AlertType);
                    return false;
                }
            }
            else if (ddlval == 'WorkListID_Based') {
                if ($("#txtWorkListID").val() == '' || $("#txtWorkListID").val() == null) {
                    //alert('Please Choose WorkListID From Auto Search');
                    ValidationWindow(vWorkListFormat, AlertType);
                    return false;
                }
                if ($("#ddlWLFormatType").val() != "Portrait Format" && $("#ddlWLFormatType").val() != "--Select--") {
                   // alert('Not Associated for this WorkListFormat Type');
                  ValidationWindow(vWorkListFormat, AlertType);
                    return false;
                }
            }
            else if (ddlval == 'Group_Based') {
                if ($("#hdnGrpID").val() == '0') {
                   // alert('Please Choose Group Name From Auto Search');
                   ValidationWindow(vAutoSearch, AlertType);
                    return false;
                }
            }
            else if (ddlval == 'Interface_value') {
                if ($("#hdnGrpID").val() == '0') {
                    // alert('Please Choose Group Name From Auto Search');
                    ValidationWindow(vVisitNo, AlertType);
                    return false;
                }
            }
            else if (ddlval == 'Visit_Level') {
                if ($("#txtFromVist").val() == '' || $("#txtFromVist").val() == null) {
                   // alert('Please Enter From Visit No For Auto Search');
                    ValidationWindow(vVisttNoAutoSearch, AlertType);
                    return false;
                }
                if ($("#txtTovist").val() == '' || $("#txtTovist").val() == null) {
                  // alert('Please Enter To Vistt No For Auto Search');
                    ValidationWindow(vVisttNoAutoSearch, AlertType);
                    return false;
                }
                if ($("#ddlWLFormatType").val() != "Portrait Format" && $("#ddlWLFormatType").val() != "--Select--") {
                   // alert('Not Associated for this WorkListFormat Type');
                    ValidationWindow(vWorkListFormatType, AlertType);
                    return false;
                }
            }
            else if (ddlval == 'Analyzer_Based') {
            if ($("#ddlWLFormatType").val() != "Portrait Format" && $("#ddlWLFormatType").val() != "--Select--") {
                   // alert('Not Associated for this WorkListFormat Type');
                    ValidationWindow(vWorkListFormatType, AlertType);
                    return false;
                }
            }
            else if (ddlval == 'Dept_Based') {
            if ($("#ddlWLFormatType").val() != "Portrait Format" && $("#ddlWLFormatType").val() != "DefaultFormat" && $("#ddlWLFormatType").val() != "--Select--") {
                    // alert('Not Associated for this WorkListFormat Type');
                                        ValidationWindow(vWorkListFormatType, AlertType);
                                        return false;
                }
            }
            else if (ddlval == 'ProtocalGroup_Based') {
            if ($("#ddlWLFormatType").val() != "Portrait Format" && $("#ddlWLFormatType").val() != "--Select--") {
                    //alert('Not Associated for this WorkListFormat Type');
                   ValidationWindow(vWorkListFormatType, AlertType);
                    return false;
                }
            }
            else if (ddlval == 'Date_Based') {
            if ($("#ddlWLFormatType").val() != "Portrait Format" && $("#ddlWLFormatType").val() != "--Select--") {
                   // alert('Not Associated for this WorkListFormat Type');
                    ValidationWindow(vWorkListFormatType, AlertType);
                    return false;
                }
            }
            else if (ddlval == 'Special_Based') {
            if ($("#hdnGrpID").val() == '0' && $("#hdnHistoFormat").val() != 'Y' && $('#ddlWLFormatType').val()=="Special Format") {
                    // alert('Please Choose Group Name From Auto Search');
                    ValidationWindow(vVisitNo, AlertType);
                    return false;
                }
                if ($("#ddlWLFormatType").val() != "Special Format" && $("#ddlWLFormatType").val() != "--Select--") {
                    // alert('Not Associated for this WorkListFormat Type');
                    ValidationWindow(vWorkListFormatType, AlertType);
                    return false;
                }
            }
            //else if (ddlval == 'Date_Based') {
            if ($("#txtFrom").val() == '' || $("#txtFrom").val() == null) {
              //  alert('Please Enter From Date');
                ValidationWindow(vFromDate, AlertType);
                return false;
            }
            if ($("#txtTo").val() == '' || $("#txtTo").val() == null) {
               // alert('Please Enter To Date');
               ValidationWindow(vToDate, AlertType);
                return false;
            }
            var chks = $("#<%= Chkpendingdays.ClientID %> input:checkbox");
            var hasChecked = false;
            for (var i = 0; i < chks.length; i++) {
                if (chks[i].checked) {
                    hasChecked = true;
                    break;
                }
            }
            if (hasChecked == false && document.getElementById("chkAll").checked == true && document.getElementById("chkPending").checked == true && document.getElementById("chkPartiallyApproved").checked == true) {
                if (document.getElementById("chkdelay").checked == true) {
                    $('#Divday').show();
                  //  alert("Please select the Pending Days");
                    ValidationWindow(vPendingDays, AlertType);
                    return false;
                }
            }
            else if (hasChecked == true && document.getElementById("chkAll").checked == false && document.getElementById("chkPending").checked == false && document.getElementById("chkPartiallyApproved").checked == false) {

                $('#Divday').show();
               // alert("Please select the test status");
                ValidationWindow(vTestStatus, AlertType);
                return false;
            }
            else if (document.getElementById("chkdelay").checked == true && hasChecked == false && document.getElementById("txtPendingDays").value == "") {
                $('#Divday').show();
               // alert("Please select the Pending Days or enter the Pending Days");
                ValidationWindow(vPendingDaysEntPendingDays, AlertType);
                return false;
            }
            //            else if (hasChecked == true && document.getElementById("chkPending").checked == true && document.getElementById("chkPartiallyApproved").checked == true) {
            //            $('#Divday').show();
            //            alert("Please select the Pending Days or enter the Pending Days");
            //            return false;
            //            }
            else if (hasChecked == true && document.getElementById("chkPending").checked == true && document.getElementById("chkPartiallyApproved").checked == true) {
                $('#Divday').show();
                return true;
            }

            //}
        }

        function ShowDiv() {
            var ddlvalue = $("#ddlWLFormatType").val();
            if (ddlvalue == "Special Format" && $('#hdnHistoFormat').val()!="Y") {
                $('#divGrps').show();
            } else {
            $('#divGrps').hide();
            }
        }

        function ShowCorresDiv() {
            var ddlval = $("#ddlWorkListType :selected").val();
            $('#hdnIsGrpBased').val('N');
            switch (ddlval) {
                case 'Analyzer_Based':
                    $('#divAnalyzer').show();
                    $('#divInves').hide();
                    $('#divDept').hide();
                    $('#divWorkListID').hide();
                    $('#divGrps').hide();
                    $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#DivDate').show();
                    $('#divSample').hide();
                    $('#DivVist').hide();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    $('#divproGrp').hide();
                    $('#divspec').hide();
                    // $('#Divday').hide(); 
                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                case 'Investigation_Based':
                    $('#divInves').show(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divAnalyzer').hide();
                    $('#divDept').hide();
                    $('#divGrps').hide();
                    $('#divWorkListID').hide();
                    $('#DivDate').show();
                    $('#divSample').hide();
                    $('#DivVist').hide();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    $('#txtInvestigationName').val('');
                    $('#divproGrp').hide();
                    $('#divspec').hide();
                    //$('#Divday').show();
                    funcheckboxlist();
                    //                    var objSel = document.getElementById("ddlWLFormatType");
                    //                    objSel.removeAttri
                    //                                     for (i = objSel.length - 1; i >= 0; i--) {
                    //                                        {
                    //                                          objSel.remove(i);
                    //                                        }
                    //                                   }

                    //                    objSel.options[0] = new Option("---Select---", "---Select---");
                    //                    objSel.options[1] = new Option("Portrait Format", "Portrait Format");

                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                case 'Dept_Based':
                    $('#divAnalyzer').hide();
                    $('#divInves').hide();
                    $('#divDept').show(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divWorkListID').hide();
                    $('#divGrps').hide();
                    $('#DivDate').show();
                    $('#divSample').hide();
                    $('#DivVist').hide();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    $('#divproGrp').hide();
                    $('#divspec').hide();
                    //$('#Divday').hide();
                    //                    var objSel = document.getElementById("ddlWLFormatType");
                    //                    objSel.removeAttri
                    //                    for (i = objSel.length - 1; i >= 0; i--) {
                    //                        {
                    //                            objSel.remove(i);
                    //                        }
                    //                    }

                    //                    objSel.options[0] = new Option("---Select---", "---Select---");
                    //                    objSel.options[1] = new Option("Portrait Format", "Portrait Format");
                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                case 'WorkListID_Based':
                    $('#divAnalyzer').hide();
                    $('#divInves').hide();
                    $('#divDept').hide(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divWorkListID').show();
                    $('#chkIncludeGeneratedWL').attr('checked', 'checked');
                    $('#divGrps').hide();
                    $('#DivDate').show();
                    $('#divSample').hide();
                    $('#DivVist').hide();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    $('txtWorkListID').val('');
                    //$('#Divday').hide();
                    $('#divproGrp').hide();
                    $('#divspec').hide();
                    //                    var objSel = document.getElementById("ddlWLFormatType");
                    //                    objSel.removeAttri
                    //                    for (i = objSel.length - 1; i >= 0; i--) {
                    //                        {
                    //                            objSel.remove(i);
                    //                        }
                    //                    }

                    //                    objSel.options[0] = new Option("---Select---", "---Select---");
                    //                    objSel.options[1] = new Option("Portrait Format", "Portrait Format");
                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                case 'Group_Based':
                    $('#divAnalyzer').hide();
                    $('#divInves').hide();
                    $('#divDept').hide(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divWorkListID').hide();
                    $('#divGrps').show();
                    $('#hdnIsGrpBased').val('Y');
                    $('#DivDate').show();
                    $('#divSample').hide();
                    $('#DivVist').hide();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    $('#txtGrps').val('');
                    //$('#Divday').show();
                    $('#divproGrp').hide();
                    funcheckboxlist();
                    $('#divspec').hide();
                    //                    funcheckboxlist();
                    //                    var objSel = document.getElementById("ddlWLFormatType");
                    ////                    for (i = objSel.length - 1; i >= 0; i--) {
                    ////                        if (objSel.options[i].selected) {
                    ////                            objSel.remove(i);
                    ////                        }
                    ////                    }

                    //                    objSel.options[0] = new Option("---Select---", "---Select---");
                    //                    objSel.options[1] = new Option("Portrait Format", "Portrait Format");
                    //                    objSel.options[2] = new Option("Group Contents in Column", "Group Contents in Column");
                    //                    objSel.options[3] = new Option("3 Column Group Contents", "3 Column Group Contents");
                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                case 'ProtocalGroup_Based':
                    $('#divAnalyzer').hide();
                    $('#divInves').hide();
                    $('#divDept').hide();
                    $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divWorkListID').hide();
                    $('#divGrps').hide();
                    $('#hdnIsGrpBased').val('N');
                    $('#DivDate').show();
                    $('#divSample').hide();
                    $('#DivVist').hide();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    //$('#Divday').hide();                    
                    $('#divproGrp').show();
                    // $('#Divday').show();
                    $('#divspec').hide();
                    funcheckboxlist();
                    //                    funcheckboxlist();
                    //                    var objSel = document.getElementById("ddlWLFormatType");
                    //                    objSel.removeAttri
                    //                    for (i = objSel.length - 1; i >= 0; i--) {
                    //                        {
                    //                            objSel.remove(i);
                    //                        }
                    //                    }

                    //                    objSel.options[0] = new Option("---Select---", "---Select---");
                    //                    objSel.options[1] = new Option("Portrait Format", "Portrait Format");
                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                case 'Date_Based':
                    $('#divAnalyzer').hide();
                    $('#divInves').hide();
                    $('#divDept').hide(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divWorkListID').hide();
                    $('#divGrps').hide();
                    $('#hdnIsGrpBased').val('Y');
                    $('#DivDate').show();
                    $('#divSample').hide();
                    $('#DivVist').hide();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    $('#divproGrp').hide();
                    $('#divspec').hide();
                    //$('#Divday').hide();
                    //                    var objSel = document.getElementById("ddlWLFormatType");
                    //                    objSel.removeAttri
                    //                    for (i = objSel.length - 1; i >= 0; i--) {
                    //                        {
                    //                            objSel.remove(i);
                    //                        }
                    //                    }

                    //                    objSel.options[0] = new Option("---Select---", "---Select---");
                    //                    objSel.options[1] = new Option("Portrait Format", "Portrait Format");
                    //                    $('#txtFrom').val('');
                    //                    $('#txtTo').val('');
                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                case 'Visit_Level':
                    $('#divAnalyzer').hide();
                    $('#divInves').hide();
                    $('#divDept').hide();
                    $('#divWorkListID').hide();
                    $('#divGrps').hide();
                    $('#hdnIsGrpBased').val('Y');
                    $('#DivDate').show();
                    $('#divSample').hide();
                    $('#DivVist').show(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    //$('#Divday').hide();
                    $('#divproGrp').hide();
                    $('#divspec').hide();
                    //                    var objSel = document.getElementById("ddlWLFormatType");
                    //                    objSel.removeAttri
                    //                    for (i = objSel.length - 1; i >= 0; i--) {
                    //                        {
                    //                            objSel.remove(i);
                    //                        }
                    //                    }

                    //                    objSel.options[0] = new Option("---Select---", "---Select---");
                    //                    objSel.options[1] = new Option("Portrait Format", "Portrait Format");
                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                case 'Sample_Based':
                    $('#divAnalyzer').hide();
                    $('#divInves').hide();
                    $('#divDept').hide(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divWorkListID').hide();
                    $('#divGrps').hide();
                    $('#DivDate').show();
                    $('#divSample').show();
                    $('#DivVist').hide();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    //$('#Divday').hide();
                    $('#divproGrp').hide();
                    $('#divspec').hide();
                    //                    var objSel = document.getElementById("ddlWLFormatType");
                    //                    objSel.removeAttri
                    //                    for (i = objSel.length - 1; i >= 0; i--) {
                    //                        {
                    //                            objSel.remove(i);
                    //                        }
                    //                    }

                    //                    objSel.options[0] = new Option("---Select---", "---Select---");
                    //                    objSel.options[1] = new Option("Portrait Format", "Portrait Format");
                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                case 'Special_Based':
                    $('#divAnalyzer').hide(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divVIP').hide(); //show();
                    $('#DivVisit').hide();
                    $('#divspec').hide();
                    $('#divDept').show();
                    if ($("#hdnHistoFormat").val() == 'Y') {
                        $('#divGrps').hide();
                    } else {
                    $('#divGrps').show();
                    }
                    $('#divWorkListID').hide();
                    $('#dvgrdGroupResultWL11').hide();
                    $('#dvgrdGroupResultWL111').hide();
                    $('#tbGrdResult').hide();
                    $('#dvMicroSF').hide();
                    break;
                case '0':
                    $('#divAnalyzer').hide();
                    $('#divInves').hide();
                    $('#divDept').hide();
                    $('#btnSearch').hide();
                    $('#divWorkListID').hide();
                    $('#divGrps').hide();
                    $('#DivDate').show();
                    $('#divSample').hide();
                    // $('#tdChildSearch').hide();
                    $('#DivVist').hide();
                    $('#divVIP').show();
                    $('#DivVisit').hide();
                    $('#divproGrp').hide();
                    $('#divspec').hide();
                    //$('#Divday').show();
                    //                    var objSel = document.getElementById("ddlWLFormatType");
                    //                    objSel.removeAttri
                    //                    for (i = objSel.length - 1; i >= 0; i--) {
                    //                        {
                    //                            objSel.remove(i);
                    //                        }
                    //                    }

                    //                    objSel.options[0] = new Option("---Select---", "---Select---");
                    //                    objSel.options[1] = new Option("Portrait Format", "Portrait Format");
                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                default:
                    $('#divAnalyzer').show(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    $('#divspec').hide();
                    // $('#Divday').show(); 
            }
        }
        function funcheckdelay() {
            if (document.getElementById("chkdelay").checked) {
                $('#txtPendingDays').hide();
            }
            else {
                $('#txtPendingDays').show();
            }
        }
        //        $(document).ready(function() {

        //        $('input[name=chkdelay]').change(function() {
        //        if ($('input[name=chkdelay]').is(':checked')) {
        //                alert('Checked');
        //            } else {
        //                alert('Not checked');
        //            }
        //        });
        //        });
        function funcheckboxlist() {

            var checkBoxList = document.getElementById("<%=Chkpendingdays.ClientID %>");
            var checkboxes = checkBoxList.getElementsByTagName("input");
            var isValid = false;
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    checkboxes[i].checked = false;
                }
            }
            document.getElementById("txtPendingDays").value = ""; //chkdelay
            document.getElementById("chkdelay").checked = false;
        }

        function funcheckStatus() {
            if (document.getElementById("chkAll").checked == true) {
                //                document.getElementById("chkSampleReceived").checked = true;
                document.getElementById("chkPending").checked = true;
                document.getElementById("chkPartiallyApproved").checked = true;
            }
            else {
                //                document.getElementById("chkSampleReceived").checked = false;
                document.getElementById("chkPending").checked = false;
                document.getElementById("chkPartiallyApproved").checked = false;
            }

        }
        function ViewPendingDays() {
            $('#Divday').slideToggle("fast");
        }
        function CallPrint() {

            var prtContent = document.getElementById('PrintArea');
            var WinPrint = window.open('', '', 'left=0,top=0,width=1000,height=1000,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
          //  WinPrint.print();
            WinPrint.print();
            WinPrint.close();
        }
        function CallSpecPrint() {

            var prtContent = document.getElementById('divspec');
            document.getElementById('btnspecprint').style.visibility = 'hidden';
            var WinPrint = window.open('', '', 'left=0,top=0,width=1000,height=1000,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.print();
            WinPrint.close();
            document.getElementById('btnspecprint').style.visibility = 'visible';
        }
        function PrintWorkList() {
            var prtContent = document.getElementById('PrintArea');
            document.getElementById('hdnPDFContent').value = prtContent.innerHTML;
            var Hwidth = $(window).width();
            var Vwidth = $(window).height();
            var WinPrint = window.open('', '', 'width=' + Hwidth + ',height=' + Vwidth + ',scrollbars=1,status=1,resizable=1');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            return false;
        }
        function inputOnlyNumbers(evt) {
            var e = window.event || evt;
            var charCode = e.which || e.keyCode;
            if ((charCode > 47 && charCode < 58) || charCode == 8 || charCode == 9 || charCode == 46 || charCode == 37 || charCode == 39 || (charCode > 95 && charCode < 106)) {
                return true;
            }
            return false;
        }
        
       
   
    </script>

    <style type="text/css">
        .searchBox
        {
            font-family: Arial, Helvetica, sans-serif;
            text-align: left;
            height: 15px;
            width: 300px;
            border: 1px solid #999999;
            font-size: 11px;
            margin-left: 0px;
            background-image: url('../Images/magnifying-glass.png');
            background-repeat: no-repeat;
            padding-left: 20px;
            background-color: #F8F8F8;
        }
        .grdresult td
        {
            border: 10px solid #ff0000;
        }
    </style>
    <title>
        <%=Resources.Investigation_AppMsg.Investigation_BatchWiseWorkList_aspx_hdr %>
    </title>
    <link href="../PMS/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../PMS/css/bootstrap-theme.min.css" rel="stylesheet" />
    <link href="../PMS/css/dashboard.css" rel="stylesheet" />
    <link href="../PMS/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <link href="../PMS/css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="../PMS/css/dataTables.bootstrap.css" rel="stylesheet" />
    <link href="../PMS/css/dataTables.tableTools.min.css" rel="stylesheet" />
    <link href="../PMS/css/dataTables.responsive.css" rel="stylesheet" />
    <link href="../PMS/css/jquery-ui.min.css" rel="stylesheet" />
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:Panel ID="pnlFilter" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlFilterResource1">
            <table class="defaultfontcolor w-100p">
                <tr>
                    <td>
                        <table class="w-100p">
                            <tr>
                                <td class="colorforcontent">
                                    <div class="dataheader1txt" id="ACX2plus3" style="display: none;" onclick="showResponses('ACX2plus3','ACX2minus3','DivSearchArea',1);">
                                        &nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top pointer"
                                            onclick="showResponses('ACX2plus3','ACX2minus3','DivSearchArea',1);" />
                                        <span class="dataheader1txt pointer" onclick="showResponses('ACX2plus3','ACX2minus3','DivSearchArea',1);">
                                            &nbsp;<asp:Label ID="Label9" runat="server" Text="Batch Wise WorkList" meta:resourcekey="Label9Resource1"></asp:Label></span>
                                    </div>
                                    <div class="dataheader1txt" id="ACX2minus3" style="display: block;" onclick="showResponses('ACX2plus3','ACX2minus3','DivSearchArea',0);">
                                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top pointer"
                                            onclick="showResponses('ACX2plus3','ACX2minus3','DivSearchArea',0);" />
                                        <span class="dataheader1txt pointer" onclick="showResponses('ACX2plus3','ACX2minus3','DivSearchArea',0);">
                                            &nbsp;<asp:Label ID="Label10" runat="server" Text="Batch Wise WorkList" meta:resourcekey="Label10Resource1"></asp:Label></span>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch" meta:resourcekey="Panel1Resource1">
                                    <div id="DivSearchArea" class="filterdataheader2 bg-row" style="display: block;">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="a-left w-25p v-top">
                                                    <asp:CheckBox ID="chkIncludeGeneratedWL" runat="server" Text="Reprint Past Worklist"
                                                        meta:resourcekey="chkIncludeGeneratedWLResource1" />
                                                </td>
                                                <td class="a-left w-8p v-top" style="display: none">
                                                    <asp:Label ID="lblClientName" runat="server" Text="Client Name" meta:resourcekey="lblClientNameResource1"></asp:Label>
                                                </td>
                                                <td class="a-left w-5p v-top" style="display: none">
                                                    <asp:DropDownList ID="ddlClients" CssClass="ddl" runat="server" meta:resourcekey="ddlClientsResource1">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                        <table>
                                            <tr>
                                                <td class="v-top">
                                                    <asp:Label ID="lblWorkListType" runat="server" Text="WorkList Type" meta:resourcekey="lblWorkListTypeResource1"></asp:Label>
                                                </td>
                                                <td class="v-top a-left">
                                                    <asp:DropDownList ID="ddlWorkListType" onchange="javascript:ShowCorresDiv();" CssClass="ddl"
                                                        runat="server" meta:resourcekey="ddlWorkListTypeResource1">
                                                    </asp:DropDownList>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td class="a-left v-top w-10p">
                                                    <asp:Label ID="Worklistdesign" runat="server" Text="Worklist design" meta:resourcekey="WorklistdesignResource1"></asp:Label>
                                                </td>
                                                <td class="v-top">
                                                    <div id="div1" runat="server">
                                                        <asp:DropDownList ID="ddlWLFormatType" CssClass="ddlsmall" onchange="javascript:ShowDiv()" runat="server">
                                                            <%-- <asp:ListItem Text="--select--" Value="--select--" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                            <asp:ListItem Text="Portrait Format" Value="Portrait Format" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                            <asp:ListItem Text="Group Contents in Column" Value="Group Contents in Column" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                            <asp:ListItem Text="3 Column Group Contents" Value="3 Column Group Contents" meta:resourcekey="ListItemResource4"></asp:ListItem>--%>
                                                        </asp:DropDownList>
                                                        <%-- <asp:CheckBox ID="chkbxVIP" runat="server" Text="VIP" />--%>
                                                    </div>
                                                </td>
                                                <td class=" w-20p a-left v-top">
                                                    <div id="divAnalyzer" style="display: none" runat="server">
                                                        <asp:DropDownList ID="ddlInstrument" CssClass="ddl" runat="server" meta:resourcekey="ddlInstrumentResource1">
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div id="divInves" style="display: none" runat="server">
                                                        <asp:TextBox ID="txtInvestigationName" CssClass="searchBox" runat="server" meta:resourcekey="txtInvestigationNameResource1"></asp:TextBox>&nbsp;<img
                                                            src="../Images/starbutton.png" alt="" align="middle" />
                                                        <ajc:AutoCompleteExtender ID="AutoInvestigations" MinimumPrefixLength="2" runat="server"
                                                            TargetControlID="txtInvestigationName" ServiceMethod="FetchOrderedPatientInvestigations"
                                                            ServicePath="~/OPIPBilling.asmx" EnableCaching="False" CompletionInterval="2"
                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" Enabled="True"
                                                            OnClientItemSelected="SelectedInvestigation" DelimiterCharacters="">
                                                        </ajc:AutoCompleteExtender>
                                                        <asp:HiddenField ID="hdnInvestigationID" runat="server" Value="0" />
                                                        <%-- <asp:DropDownList ID="ddlTestType" CssClass="ddl" runat="server">
                                                                            <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                                                            <asp:ListItem Text="Retest" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="STAT" Value="ALL"></asp:ListItem>
                                                                        </asp:DropDownList>--%>
                                                    </div>
                                                    <div id="divDept" style="display: none" runat="server">
                                                        <asp:DropDownList ID="drpdepartment" CssClass="ddl" Width="155px" runat="server"
                                                            meta:resourcekey="drpdepartmentResource1">
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div id="divWorkListID" style="display: none" runat="server">
                                                        <asp:TextBox ID="txtWorkListID" runat="server" CssClass="AutoCompletesearchBox11"
                                                            meta:resourcekey="txtWorkListIDResource1"></asp:TextBox>&nbsp;<img src="../Images/starbutton.png"
                                                                alt="" align="middle" />
                                                        <ajc:AutoCompleteExtender ID="AutoWorkListID" MinimumPrefixLength="1" runat="server"
                                                            TargetControlID="txtWorkListID" ServiceMethod="GetWorkListID" ServicePath="~/WebService.asmx"
                                                            EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                            Enabled="True" DelimiterCharacters="">
                                                        </ajc:AutoCompleteExtender>
                                                    </div>
                                                    <div id="divGrps" style="display: none" runat="server">
                                                        <asp:TextBox ID="txtGrps" CssClass="searchBox" runat="server" meta:resourcekey="txtGrpsResource1"></asp:TextBox>&nbsp;<img
                                                            src="../Images/starbutton.png" alt="" align="middle" />
                                                        <ajc:AutoCompleteExtender ID="AutoOrgGroups" MinimumPrefixLength="2" runat="server"
                                                            TargetControlID="txtGrps" ServiceMethod="FetchOrgGroups" ServicePath="~/OPIPBilling.asmx"
                                                            EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                            Enabled="True" OnClientItemSelected="SelectedGroup" DelimiterCharacters="">
                                                        </ajc:AutoCompleteExtender>
                                                        <asp:HiddenField ID="hdnGrpID" runat="server" Value="0" />
                                                    </div>
                                                    <div id="divproGrp" style="display: none" runat="server">
                                                        <asp:DropDownList ID="ddlProGrp" CssClass="ddl" runat="server" meta:resourcekey="ddlProGrpResource1">
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div id="DivVist" style="display: none" runat="server">
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td class="w-10p">
                                                                    <asp:Label runat="server" ID="lblFromvist" Text="From Visit No" meta:resourcekey="lblFromvistResource1"></asp:Label>
                                                                </td>
                                                                <td class="w-10p">
                                                                    <asp:TextBox runat="server" ID="txtFromVist" CssClass="Txtboxsmall" MaxLength="25"
                                                                        size="25"  onkeypress="return ValidateOnlyNumeric(this);"  AutoCompleteType="Disabled"
                                                                        meta:resourcekey="txtFromVistResource1"></asp:TextBox>&nbsp;<img src="../Images/starbutton.png"
                                                                            alt="" align="middle" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="w-10p">
                                                                    <asp:Label runat="server" ID="lbltovist" Text="To Visit No" meta:resourcekey="lbltovistResource1"></asp:Label>
                                                                </td>
                                                                <td class="w-10p">
                                                                    <asp:TextBox runat="server" ID="txtTovist" CssClass="Txtboxsmall" MaxLength="25"
                                                                        size="25"  onkeypress="return ValidateOnlyNumeric(this);"  AutoCompleteType="Disabled"
                                                                        meta:resourcekey="txtTovistResource1"></asp:TextBox><img src="../Images/starbutton.png"
                                                                            alt="" align="middle" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <div id="divSample" style="display: none" runat="server">
                                                        <asp:DropDownList ID="ddlSample" CssClass="ddlsmall" runat="server" meta:resourcekey="drpdepartmentResource1">
                                                        </asp:DropDownList>
                                                    </div>
                                                </td>
                                                <td class="w-5p a-left v-top">
                                                    <div id="divVIP" runat="server">
                                                        <asp:DropDownList ID="ddlTestType" CssClass="ddlsmall" runat="server">
                                                            <%--<asp:ListItem Text="All" Value="All" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                            <asp:ListItem Text="Retest" Value="1" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                                            <asp:ListItem Text="STAT" Value="STAT" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                                            <asp:ListItem Text="VIP" Value="VIP" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                            <asp:ListItem Text="Recheck" Value="Recheck" meta:resourcekey="ListItemResource9"></asp:ListItem>
                                                            <asp:ListItem Text="Reflex" Value="ReflexTest" meta:resourcekey="ListItemResource10"></asp:ListItem>--%>
                                                        </asp:DropDownList>
                                                        <%-- <asp:CheckBox ID="chkbxVIP" runat="server" Text="VIP" />--%>
                                                    </div>
                                                </td>
                                                <td class="a-left w-5p">
                                                    <asp:Button ID="btnSearch" Style="display: none" runat="server" CssClass="btn" Text="Go"
                                                        OnClientClick="return ValidateSearch()" OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                                                </td>
                                                <td id="trPrint" runat="server" style="display: none" class="a-right w-8p v-top">
                                                    <table>
                                                        <tr class="v-top">
                                                            <td>
                                                                <asp:ImageButton ID="btnPDF" ImageUrl="~/Images/pdf_viewer.png" ToolTip="Export To PDF"
                                                                    runat="server" OnClick="btnPDF_Click" meta:resourcekey="btnPDFResource1" />
                                                                <asp:ImageButton ID="btnGrpPDF" ImageUrl="~/Images/pdf_viewer.png" ToolTip="Export to  Group"
                                                                    runat="server" OnClick="btnGrpPDF_Click" meta:resourcekey="btnGrpPDFResource1" />
                                                                <asp:HiddenField ID="hdnTable" runat="server" />
                                                            </td>
                                                            <td>
                                                                <asp:ImageButton ID="btnPrint" Visible="false" ImageUrl="~/Images/printer_1.png" ToolTip="Print"
                                                                    runat="server" OnClick="Print" meta:resourcekey="btnPrintResource1" />
                                                                    <input type="button" value="Print" id="btnPrintAll" class="details_label_age" onclick="CallPrint();"
                                     />
                                                            </td>
                                                            <td>
                                                                <asp:ImageButton ID="lnkExportXL" OnClick="imgExportToExcel_Click" runat="server"
                                                                    ImageUrl="../Images/ExcelImage.GIF" ToolTip="Save As Excel" meta:resourcekey="lnkExportXLResource1" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                        <table class="w-100p">
                                            <tr>
                                                <td class="w-27p">
                                                    <div id="DivVisit" style="display: none" runat="server">
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td class="w-17p">
                                                                    <asp:Label runat="server" ID="lblVisitumber" Text="Visit Number" meta:resourcekey="lblVisitumberResource1"></asp:Label>
                                                                </td>
                                                                <td class="a-left w-10p">
                                                                    <asp:TextBox runat="server" ID="txtVisitNumber" CssClass="Txtboxsmall" MaxLength="25"
                                                                        size="25" meta:resourcekey="txtVisitNumberResource1"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div id="DivDate" style="display: none" runat="server">
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td class="w-10p">
                                                                    <asp:Label runat="server" ID="lblFromdate" Text="From Received DateTime" meta:resourcekey="lblFromdateResource1"></asp:Label>
                                                                </td>
                                                                <td class="w-10p">
                                                                    <asp:TextBox runat="server" ID="txtFrom" CssClass="Txtboxsmall" MaxLength="25" size="25"
                                                                        meta:resourcekey="txtFromResource1"></asp:TextBox>
                                                                    <a href="javascript:NewCssCal('<% =txtFrom.ClientID %>','ddmmyyyy','arrow',true,12,'Y','Y')">
                                                                        <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                                <td class="w-8p">
                                                                </td>
                                                                <td class="w-10p">
                                                                    <asp:Label runat="server" ID="lblToDate" Text="To Received DateTime" meta:resourcekey="lblToDateResource1"></asp:Label>
                                                                </td>
                                                                <td class="w-10p">
                                                                    <asp:TextBox runat="server" ID="txtTo" CssClass="Txtboxsmall" MaxLength="25" size="25"
                                                                        meta:resourcekey="txtToResource1"></asp:TextBox>
                                                                    <a href="javascript:NewCssCal('<% =txtTo.ClientID %>','ddmmyyyy','arrow',true,12,'Y','N')">
                                                                        <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                                
                                                           <td id="tdprintinter" runat="server" class="w-8p" style="display:none">
                                                                <asp:LinkButton ID="lnkPrint" runat="server" Font-Bold="True" OnClientClick="return CallPrintInterfaced();"
                                                                 Font-Size="12px" ForeColor="Black" ToolTip="Click Here To Print Stock Details" BackColor="Yellow" 
                                                                            meta:resourcekey="lnkPrintResource1" Text="&lt;u&gt;Print&lt;/u&gt;"></asp:LinkButton> &nbsp;&nbsp;&nbsp;
                                                                  <asp:ImageButton ID="btnConverttoXL" OnClientClick="return ExportToExcel()"  runat="server" ImageUrl="~/Images/ExcelImage.GIF"/>
                                                                           
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div style="font-size: larger; font-weight: bold; font-style: italic; cursor: pointer;
                                                        text-align: left; color: #2c88b1" id="dvMicroSF" onclick="javascript:ViewPendingDays();">
                                                        <%=Resources.Investigation_AppMsg.Investigation_BatchWiseWorkList_aspx_filter %></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">
                                                    <div id="Divday" style="display: none;">
                                                        <asp:Panel ID="pnlpendingdays" CssClass="searchPanel" runat="server" BorderColor="Gray"
                                                            BorderStyle="Solid" BorderWidth="1px" meta:resourcekey="pnlpendingdaysResource1">
                                                            <table>
                                                                <tr>
                                                                    <td class="w-8p">
                                                                        <div class="bold">
                                                                            <%=Resources.Investigation_AppMsg.Investigation_BatchWiseWorkList_aspx_pendingdays %></div>
                                                                    </td>
                                                                    <%--<td style="width: 7%">
                                                                                    <asp:Label runat="server" ID="lblPendingDays" Text="PendingDays"></asp:Label>
                                                                                </td>--%>
                                                                    <td>
                                                                        <asp:CheckBox ID="chkdelay" runat="server" Text="Delay" onclick="funcheckdelay()"
                                                                            meta:resourcekey="chkdelayResource1" />
                                                                    </td>
                                                                    <td style="width: 5%" class="w-5p a-left">
                                                                        <asp:TextBox runat="server" ID="txtPendingDays" CssClass="Txtboxsmall" MaxLength="25"
                                                                            size="25" Width="50px" meta:resourcekey="txtPendingDaysResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td colspan="4">
                                                                        <asp:CheckBoxList ID="Chkpendingdays" RepeatDirection="Horizontal" runat="server"
                                                                            RepeatColumns="15" Font-Size="10px" Font-Bold="True" meta:resourcekey="ChkpendingdaysResource1">
                                                                            <%--<asp:ListItem Text="0" Value="0" meta:resourcekey="ListItemResource11"></asp:ListItem>
                                                                            <asp:ListItem Text="1" Value="1" meta:resourcekey="ListItemResource12"></asp:ListItem>
                                                                            <asp:ListItem Text="3" Value="3" meta:resourcekey="ListItemResource13"></asp:ListItem>
                                                                            <asp:ListItem Text="5" Value="5" meta:resourcekey="ListItemResource14"></asp:ListItem>
                                                                            <asp:ListItem Text="7" Value="7" meta:resourcekey="ListItemResource15"></asp:ListItem>
                                                                            <asp:ListItem Text="10" Value="10" meta:resourcekey="ListItemResource16"></asp:ListItem>
                                                                            <asp:ListItem Text="21" Value="21" meta:resourcekey="ListItemResource17"></asp:ListItem>
                                                                            <asp:ListItem Text="42" Value="42" meta:resourcekey="ListItemResource18"></asp:ListItem>--%>
                                                                        </asp:CheckBoxList>
                                                                    </td>
                                                                    <td>
                                                                        <div class="bold">
                                                                               <%=Resources.Investigation_AppMsg.Investigation_BatchWiseWorkList_aspx_status %></div>
                                                                    </td>
                                                                    <td class="w-70p">
                                                                        <asp:CheckBox ID="chkAll" runat="server" Text="Check All" onclick="funcheckStatus()" meta:resourcekey="chkAllResource1" />&nbsp;&nbsp;&nbsp;
                                                                        <asp:CheckBox ID="chkPending" runat="server" Text="Pending" Checked="false" class="chkStatus"
                                                                            meta:resourcekey="chkPendingResource1" />&nbsp;&nbsp;&nbsp;
                                                                        <asp:CheckBox ID="chkPartiallyApproved" runat="server" Text="PartiallyApproved" Checked="false"
                                                                            class="chkStatus" meta:resourcekey="chkPartiallyApprovedResource1" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:Panel>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>
                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="btnPDF" />
                                <asp:PostBackTrigger ControlID="btnPrint" />
                                <asp:PostBackTrigger ControlID="lnkExportXL" />
                            </Triggers>
                        </asp:UpdatePanel>
                        <asp:UpdateProgress DynamicLayout="False" ID="UpdateProgress1" runat="server">
                                <ProgressTemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>

                            </asp:UpdateProgress>
                    </td>
                </tr>
                <tr>
                    <td class="a-center">
                        <div id="PrintArea" class="filterdataheader2 w-100p" runat="server">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <table>
                                        <tr>
                                            <td class="a-center">
                                                <%-- <ProgressTemplate>
                                                                    <div id="progressBackgroundFilter" class="a-center">
                                                                    </div>
                                                                    <div id="processMessage" class="a-center w-20p">
                                                                        <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                                                    </div>
                                                                </ProgressTemplate>--%>
                                            </td>
                                        </tr>
                                    </table>
                                    <div id="dvgrdGroupResultWL11" runat="server">
                                        <table id="tbResultWL1" runat="server" class="w-100p" style="display: none;">
                                            <tr id="Tr3" runat="server">
                                                <td id="Td4" class="a-center" runat="server">
                                                    <asp:Label ID="lblHeader" Font-Bold="True" Font-Size="14px" runat="server" Font-Underline="True"
                                                        Text="WorkList" meta:resourcekey="lblHeaderResource1"></asp:Label>
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr id="Tr4" runat="server">
                                                <td id="Td7" class="dataheader1 a-left" runat="server">
                                                    <table class="w-100p font10 bold a-left" style="font-family: Verdana;">
                                                        <tr>
                                                            <td>
                                                            </td>
                                                            <td class="a-left" nowrap="nowrap">
                                                                <asp:Label ID="Label1" Font-Size="10px" Visible="false" runat="server" Text="Protocol / Type :"
                                                                    meta:resourcekey="Label1Resource1">
																
                                                                </asp:Label>
                                                            </td>
                                                            <td class="a-left" nowrap="nowrap">
                                                                <asp:Label ID="lblWorkListBasedOn1" Visible="false" Font-Size="12px" runat="server"
                                                                    meta:resourcekey="lblWorkListBasedOn1Resource1"></asp:Label>
                                                            </td>
                                                            <td class="a-right" nowrap="nowrap">
                                                                <asp:Label ID="lblWLOntxt1" Visible="false" Font-Size="10px" runat="server" Text="Generated On :"
                                                                    meta:resourcekey="lblWLOntxt1Resource1"></asp:Label>
                                                            </td>
                                                            <td class="a-center" nowrap="nowrap">
                                                                <asp:Label ID="lblWLOn1" Font-Size="12px" runat="server" Text="--" meta:resourcekey="lblWLOn1Resource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-right" nowrap="nowrap">
                                                                <asp:Label ID="Label2" Font-Size="10px" runat="server" Text="Grouped By:" meta:resourcekey="Label2Resource1"></asp:Label>
                                                            </td>
                                                            <td class="a-left" nowrap="nowrap">
                                                                <asp:Label ID="lblProtocolNo" Font-Size="10px" runat="server"></asp:Label>
                                                            </td>
                                                            <td class="a-right" nowrap="nowrap">
                                                                <asp:Label ID="lblGroupingWorkListtxt1" Font-Size="12px" runat="server"></asp:Label>
                                                            </td>
                                                            <td class="a-right" nowrap="nowrap">
                                                                <asp:Label ID="Label3" Font-Size="10px" runat="server" Text="GeneratedBy:"></asp:Label>
                                                            </td>
                                                            <td class="a-center" nowrap="nowrap">
                                                                <asp:Label ID="lblWLUser" Font-Size="12px" runat="server"></asp:Label>
                                                            </td>
                                                            <td id="tdWLIDSummery" colspan="2" class="a-center" runat="server" style="display: none">
                                                                <table>
                                                                    <tr>
                                                                        <td class="a-right" nowrap="nowrap">
                                                                            <asp:Label ID="lblWLID1" Visible="false" Font-Size="10px" runat="server" Text="WorkList ID :"></asp:Label>
                                                                        </td>
                                                                        <td class="a-left v-bottom" nowrap="nowrap">
                                                                            <asp:Literal ID="lblWLIDtxt1" Visible="false" runat="server" Text="--" meta:resourcekey="lblWLIDtxt1Resource1"></asp:Literal>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr style="display: none">
                                                            <td class="a-right" nowrap="nowrap">
                                                                <asp:Label ID="lblCenterCode1" Font-Size="10px" runat="server" Text="Center Code :"></asp:Label>
                                                            </td>
                                                            <td class="a-left" nowrap="nowrap">
                                                                <asp:Label ID="lblcentercodetext1" Font-Size="12px" Text="1113" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <%--<td>
                                                        <asp:Table ID="InvTable" runat="server" BorderWidth="1"
                                                                    Width="100%" ForeColor="#000">
                                                                </asp:Table>
                                                        </td>--%>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="dvgrdGroupResultWL111" runat="server">
                                        <table id="tbResult" runat="server" class="w-100p" style="display: none;">
                                            <tr id="Tr1" runat="server">
                                                <td id="Td2" class="a-center" runat="server">
                                                    <asp:Label ID="Label4" Font-Bold="True" Font-Size="14px" runat="server" Font-Underline="True"
                                                        Text="WorkList" meta:resourcekey="Label4Resource1"></asp:Label>
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr id="Tr2" runat="server">
                                                <td id="Td3" class="dataheader1 a-left" runat="server">
                                                    <table border="0" class="w-100p font10 bold a-left" style="font-family: Verdana;">
                                                        <tr>
                                                            <td class="a-right" nowrap="nowrap">
                                                                <asp:Label ID="Label5" Font-Size="10px" runat="server" Text="Protocol / Type :" meta:resourcekey="Label5Resource1"></asp:Label>
                                                            </td>
                                                            <td class="a-left" nowrap="nowrap">
                                                                <asp:Label ID="lblWorkListBasedOn" Font-Size="12px" runat="server" meta:resourcekey="lblWorkListBasedOnResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-right" nowrap="nowrap">
                                                                <asp:Label ID="lblWLOntxt" Font-Size="10px" runat="server" Text="Generated On :" meta:resourcekey="lblWLOntxtResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-left" nowrap="nowrap">
                                                                <asp:Label ID="lblWLOn" Font-Size="12px" runat="server" Text="--" meta:resourcekey="lblWLOnResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-right" nowrap="nowrap">
                                                                <asp:Label ID="Label11" Font-Size="10px" runat="server" Text="Grouped By :" meta:resourcekey="Label11Resource1"></asp:Label>
                                                            </td>
                                                            <td class="a-left" nowrap="nowrap">
                                                                <asp:Label ID="lblGroupingWorkListtxt" Font-Size="12px" runat="server" meta:resourcekey="lblGroupingWorkListtxtResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-right" nowrap="nowrap">
                                                                <asp:Label ID="Label6" Font-Size="10px" runat="server" Text="GeneratedBy:" meta:resourcekey="Label6Resource1"></asp:Label>
                                                            </td>
                                                            <td class="a-left" nowrap="nowrap">
                                                                <asp:Label ID="lblWLUser1" Font-Size="12px" runat="server" Text="Admin" meta:resourcekey="Label6Resource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-right" nowrap="nowrap">
                                                                <asp:Label ID="lblCenterCode" Font-Size="10px" runat="server" Text="Center Code :"
                                                                    Visible="false" meta:resourcekey="lblCenterCodeResource1"></asp:Label>
                                                            </td>
                                                            <td class="a-left" nowrap="nowrap">
                                                                <asp:Label ID="lblcentercodetext" Font-Size="12px" Text="1113" runat="server" Visible="false"
                                                                    meta:resourcekey="lblcentercodetextResource1"></asp:Label>
                                                            </td>
                                                            <%--<td id="td4" colspan="2" align="center" runat="server">
                                                                            <table>
                                                                                <tr>--%>
                                                            <td class="a-right" nowrap="nowrap">
                                                                <asp:Label ID="lblWLID" Font-Size="10px" runat="server" Text="WorkList ID :"></asp:Label>
                                                            </td>
                                                            <td class="a-left" nowrap="nowrap" valign="bottom">
                                                                <asp:Label ID="lblWLIDtxt" runat="server" Text="--" meta:resourcekey="lblWLIDtxtResource1"></asp:Label>
                                                            </td>
                                                            <%--</tr>
                                                                            </table>
                                                                        </td> --%>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <table id="tbGrdResult" runat="server" class="w-100p" style="display: none;">
                                        <tr id="Tr" runat="server">
                                            <td id="tdIsDataChanged" runat="server">
                                                <asp:Label ID="lblIsDataChanged" runat="server" Text=" * - Data(s) Changed. Need Retest."
                                                    meta:resourcekey="lblIsDataChangedResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <div id="divLegend" runat="server">
                                                    <asp:TextBox ID="txtReflexNotification" Width="10px" Height="10px" runat="server"
                                                        meta:resourcekey="txtReflexNotificationResource1"></asp:TextBox>
                                                    <asp:Label ID="lblReflexNotification" Text="Reflex" runat="server" meta:resourcekey="lblReflexNotificationResource1"></asp:Label>
                                                    <asp:TextBox ID="txtRecheckNotification" Width="10px" Height="10px" runat="server"
                                                        meta:resourcekey="txtRecheckNotificationResource1"></asp:TextBox>
                                                    <asp:Label ID="lblRecheckNotification" Text="Rerun" runat="server" meta:resourcekey="lblRecheckNotificationResource1"></asp:Label>
                                                    <asp:TextBox ID="txtVIPNotification" Width="10px" Height="10px" runat="server" meta:resourcekey="txtVIPNotificationResource1"></asp:TextBox>
                                                    <asp:Label ID="lblVIPNotification" Text="VIP" runat="server" meta:resourcekey="lblVIPNotificationResource1"></asp:Label>
                                                    <asp:TextBox ID="txtRetestNotification" Width="10px" Height="10px" runat="server"
                                                        meta:resourcekey="txtRetestNotificationResource1"></asp:TextBox>
                                                    <asp:Label ID="lblRetestNotification" Text="Recollect" runat="server" meta:resourcekey="lblRetestNotificationResource1"></asp:Label>
                                                    <asp:TextBox ID="txtSTATNotification" Width="10px" Height="10px" runat="server" meta:resourcekey="txtSTATNotificationResource1"></asp:TextBox>
                                                    <asp:Label ID="lblSTATNotification" Text="STAT Investigation" runat="server" meta:resourcekey="lblSTATNotificationResource1"></asp:Label>
                                                </div>
                                            </td>
                                            <td id="tdStat" runat="server" style="display: none">
                                            </td>
                                        </tr>
                                        <tr id="trInvBased1" runat="server" style="display: none">
                                            <td id="Td1" runat="server" colspan="2">
                                                <div align="center" id="dvgrdresult" runat="server">
                                                    <asp:GridView ID="grdresult" runat="server" ForeColor="Black" CellPadding="1" AutoGenerateColumns="False"
                                                        CssClass="w-100p gridView" Style="margin-top: 0px" EmptyDataText="No Matching Records Found"
                                                        OnRowDataBound="grdresult_RowDataBound" OnPreRender="grdresult_PreRender" GridLines="Both"
                                                        DataKeyNames="MedicalRemarks,QCData,Status,RefSuffixText,Migrated_TestCode" meta:resourcekey="grdresultResource1">
                                                        <HeaderStyle Font-Bold="True" CssClass="dataheader1" />
                                                        <Columns>
                                                            <%--<asp:TemplateField>
                                                                            <HeaderTemplate>
                                                                                S.No
                                                                            </HeaderTemplate>
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblSNo" runat="server" Text='<%# Eval("Sno")%>' Style="float: left;
                                                                                    margin-left: 20px;"></asp:Label>
                                                                                <asp:Label ID="lblIsDataChanged" runat="server" Text="*" Style="float: left; margin-left: 5px;"></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle Width="5%" HorizontalAlign="Center" />
                                                                            <ItemStyle Width="5%" HorizontalAlign="Center" />
                                                                             </asp:TemplateField>--%>
                                                            <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="4%" HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="WorkListID" HeaderText="WL.ID" meta:resourcekey="BoundFieldResource1">
                                                                <ItemStyle Width="4%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="CONV_UOMCode" HeaderText="Reg.Location" meta:resourcekey="BoundFieldResource2">
                                                                <ItemStyle HorizontalAlign="left" Width="8%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="DeviceID" HeaderText="Registered.on" meta:resourcekey="BoundFieldResource3">
                                                                <ItemStyle Width="8%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="IsAutoAuthorize" HeaderText="Received.on" meta:resourcekey="BoundFieldResource4">
                                                                <ItemStyle Width="8%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Migrated_Visit_Number" HeaderText="Visit No." meta:resourcekey="BoundFieldResource5">
                                                                <ItemStyle Width="9%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" Visible="false"
                                                                meta:resourcekey="BoundFieldResource6">
                                                                <ItemStyle Width="1%" />
                                                            </asp:BoundField>
                                                            <%-- <asp:TemplateField HeaderText="Barcode No" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="3%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblSNo" runat="server" Text='<%# Eval("InvestigationValue")%>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        </asp:TemplateField>--%>
                                                            <asp:BoundField DataField="InvestigationValue" HeaderText="Barcode No" ItemStyle-HorizontalAlign="Center"
                                                                ItemStyle-Width="3%" meta:resourcekey="BoundFieldResource7">
                                                                <ItemStyle Width="8%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Name" HeaderText="Name" meta:resourcekey="BoundFieldResource8">
                                                                <ItemStyle HorizontalAlign="left" Width="13%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Age" HeaderText="Age/Sex" meta:resourcekey="BoundFieldResource9">
                                                                <ItemStyle Width="8%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Investigationname" HeaderText="Test Name" meta:resourcekey="BoundFieldResource10">
                                                                <ItemStyle Width="12%" HorizontalAlign="Left" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="IsSTAT" HeaderText="IsSTAT" meta:resourcekey="BoundFieldResource11">
                                                                <ItemStyle Width="1%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="DeptName" HeaderText="Dept.Name" Visible="false" meta:resourcekey="BoundFieldResource12">
                                                                <ItemStyle Width="1%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Migrated_TestType" HeaderText="TAT DateTime" meta:resourcekey="BoundFieldResource13">
                                                                <ItemStyle Width="8%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="ManualAbnormal" HeaderText="ClientName" meta:resourcekey="BoundFieldResource14">
                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Bottom" Width="12%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="ConvReferenceRange" HeaderText="Ref.DR" meta:resourcekey="BoundFieldResource15">
                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Bottom" Width="10%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Value" HeaderText="Result" meta:resourcekey="BoundFieldResource16">
                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Bottom" Width="10%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="PatientVisitID" HeaderText="VisitID" Visible="false" meta:resourcekey="BoundFieldResource17">
                                                                <ItemStyle Width="4%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="InstrumentName" HeaderText="PendingDays" meta:resourcekey="BoundFieldResource18">
                                                                <ItemStyle Width="20%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <%--<asp:BoundField DataField="WorklistCreatedby" HeaderText="GeneratedBy">
                                                                            <ItemStyle Width="1%" />
                                                                        </asp:BoundField>--%>
                                                        </Columns>
                                                        <EmptyDataRowStyle CssClass="dataheader1"></EmptyDataRowStyle>
                                                    </asp:GridView>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr id="trInvBased" runat="server" style="display: none">
                                            <td id="Td14" runat="server" colspan="2">
                                                <div align="center" id="dvgrdGroupResultWL1" runat="server">
                                                    <asp:GridView ID="grdGroupResultWL1" runat="server" ForeColor="Black" Width="100%"
                                                        CellPadding="1" AutoGenerateColumns="False" Style="margin-top: 0px" EmptyDataText="No Matching Records Found"
                                                        GridLines="Both" meta:resourcekey="grdGroupResultWL1Resource1">
                                                        <HeaderStyle Font-Bold="True" CssClass="dataheader1" />
                                                        <Columns>
                                                            <%--<asp:TemplateField>
                                                                            <HeaderTemplate>
                                                                                S.No
                                                                            </HeaderTemplate>
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblSNo" runat="server" Text='<%# Eval("Sno")%>' Style="float: left;
                                                                                    margin-left: 20px;"></asp:Label>
                                                                                <asp:Label ID="lblIsDataChanged" runat="server" Text="*" Style="float: left; margin-left: 5px;"></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle Width="5%" HorizontalAlign="Center" />
                                                                            <ItemStyle Width="5%" HorizontalAlign="Center" />
                                                                             </asp:TemplateField>--%>
                                                            <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource2">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="4%" HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="Migrated_Visit_Number" HeaderText="Visit.No" meta:resourcekey="BoundFieldResource19">
                                                                <ItemStyle Width="6%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="InvestigationValue" HeaderText="Barcode No" meta:resourcekey="BoundFieldResource20">
                                                                <ItemStyle Width="5%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Name" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource21">
                                                                <ItemStyle HorizontalAlign="Center" Width="8%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="DeviceID" DataFormatString="{0:dd-MM-yyyy hh:mm tt}" HeaderText="Registered.on"
                                                                meta:resourcekey="BoundFieldResource22">
                                                                <ItemStyle Width="7%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="WorkListID" HeaderText="WorkList ID" meta:resourcekey="BoundFieldResource23">
                                                                <ItemStyle Width="6%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Age" HeaderText="Age/Sex" meta:resourcekey="BoundFieldResource24">
                                                                <ItemStyle Width="7%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" Visible="false"
                                                                meta:resourcekey="BoundFieldResource25">
                                                                <ItemStyle Width="1%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="ManualAbnormal" HeaderText="ClientName">
                                                                            <ItemStyle HorizontalAlign="Left" Width="12%" />
                                                                        </asp:BoundField>
                                                            <asp:BoundField DataField="InvestigationName" HeaderText="Test Name">
                                                                <ItemStyle Width="12%" HorizontalAlign="Left" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="GroupName" HeaderText="Group Name">
                                                                <ItemStyle Width="12%" HorizontalAlign="Left" />
                                                            </asp:BoundField>
                                                            <%--<asp:TemplateField HeaderText="Barcode No" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="3%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblSNo" runat="server" Text='<%# Eval("InvestigationValue")%>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        </asp:TemplateField>--%>
                                                            <%--<asp:BoundField DataField="InvestigationValue"  HeaderText="Barcode No" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="3%">
                                                                            <ItemStyle Width="8%" />
                                                                        </asp:BoundField> 
                                                                        <asp:BoundField DataField="Name" HeaderText="Name">
                                                                            <ItemStyle HorizontalAlign="left" Width="13%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Age" HeaderText="Age /Sex">
                                                                            <ItemStyle Width="8%" />
                                                                        </asp:BoundField>
                                                                        
                                                                        <asp:BoundField DataField="Investigationname" HeaderText="Test Name">
                                                                            <ItemStyle Width="12%" HorizontalAlign="Left" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="IsSTAT" HeaderText="IsSTAT">
                                                                            <ItemStyle Width="1%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="DeptName" HeaderText="Dept.Name" Visible="false">
                                                                            <ItemStyle Width="1%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Migrated_TestType" HeaderText="TAT DateTime">
                                                                            <ItemStyle Width="8%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="ManualAbnormal" HeaderText="ClientName">
                                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Bottom" Width="12%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="ConvReferenceRange" HeaderText="Ref.DR">
                                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Bottom" Width="10%" />
                                                                        </asp:BoundField>--%>
                                                            <asp:BoundField DataField="" HeaderText="Result" meta:resourcekey="BoundFieldResource26">
                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Bottom" Width="10%" />
                                                            </asp:BoundField>
                                                            <%--<asp:BoundField DataField="WorklistCreatedby" HeaderText="GeneratedBy" >
                                                                            <ItemStyle Width="1%" />
                                                                        </asp:BoundField>--%>
                                                            <%-- <asp:BoundField DataField="PatientVisitID" HeaderText="VisitID" Visible="false">
                                                                            <ItemStyle Width="4%" HorizontalAlign="Center" />
                                                                        </asp:BoundField>--%>
                                                        </Columns>
                                                        <EmptyDataRowStyle CssClass="dataheader1"></EmptyDataRowStyle>
                                                    </asp:GridView>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr id="trInVBasedF2" runat="server">
                                            <td id="Td5" runat="server" colspan="2">
                                                <%--<table 
                                                                <asp:GridView ID="grdGroupResultWL2" runat="server" ForeColor="Black" Width="100%" CellPadding="1"
                                                                OnRowDataBound="grdGroupResultWL2_RowDataBound"
                                                                    AutoGenerateColumns="False" Style="margin-top: 0px" EmptyDataText="No Matching Records Found"
                                                                      GridLines="Both"
                                                                    >
                                                                    <HeaderStyle Font-Bold="True" CssClass="dataheader1" />
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="S.No">
                                                                            <ItemTemplate> 
                                                                                <%# Container.DataItemIndex + 1 %>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="4%" HorizontalAlign="Center" />
                                                                        </asp:TemplateField>--%><%--<asp:BoundField DataField="Migrated_Visit_Number" HeaderText="Visit No.">
                                                                            <ItemStyle Width="9%" />
                                                                        </asp:BoundField>--%><%--<asp:BoundField DataField="Name" HeaderText="Patient Name">
                                                                            <ItemStyle HorizontalAlign="left" Width="13%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="" HeaderText="H-PT">
                                                                            <ItemStyle Width="4%" />
                                                                        </asp:BoundField>--%>
                                                <%--<asp:BoundField DataField="" HeaderText="C-CONT">
                                                                            <ItemStyle HorizontalAlign="Center" Width="8%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="" DataFormatString="{0:dd-MM-yyyy hh:mm tt}" HeaderText="I-RATIO">
                                                                            <ItemStyle Width="8%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField=""  HeaderText="C-INDEX">
                                                                            <ItemStyle Width="8%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="" HeaderText="H_INR">
                                                                            <ItemStyle Width="9%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="" HeaderText="">
                                                                            <ItemStyle Width="1%" />
                                                                        </asp:BoundField>  
                                                                       <%-- <asp:BoundField DataField="PatientVisitID" HeaderText="VisitID" Visible="false">
                                                                            <ItemStyle Width="4%" HorizontalAlign="Center" />
                                                                        </asp:BoundField>--%>
                                                <%--</Columns>
                                                                    <EmptyDataRowStyle CssClass="dataheader1"></EmptyDataRowStyle>
                                                                </asp:GridView>--%>
                                            </td>
                                        </tr>
                                        <tr id="trGrpBased" runat="server" style="display: none">
                                            <td>
                                                <div align="center" id="dvgrdGroupResult" runat="server">
                                                    <asp:GridView ID="grdGroupResult" runat="server" ForeColor="Black" CssClass="w-100p gridView"
                                                        CellPadding="1" AutoGenerateColumns="False" Style="margin-top: 0px" EmptyDataText="No Matching Records Found"
                                                        OnRowDataBound="grdGroupResult_RowDataBound" GridLines="Both" DataKeyNames="QCData">
                                                        <HeaderStyle Font-Bold="True" CssClass="dataheader1" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="S.No" HeaderStyle-Width="4%">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                    <asp:Label ID="lblIsDataChanged" Width="4%" runat="server" Text="*" Style="float: left;
                                                                        margin-left: 5px;"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="PatientVisitID" HeaderText="VisitID" Visible="false">
                                                                <ItemStyle Width="4%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Migrated_Visit_Number" HeaderText="VisitNumber">
                                                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="DeviceID" HeaderText="Registered.on">
                                                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="IsAutoAuthorize" HeaderText="Received.on">
                                                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="CONV_UOMCode" HeaderText="Reg.Location">
                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Bottom" Width="8%" />
                                                            </asp:BoundField>
                                                            <%-- <asp:TemplateField HeaderText="Barcode No" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="3%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblSNo" runat="server" Text='<%# Eval("InvestigationValue")%>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        </asp:TemplateField>--%>
                                                            <asp:BoundField DataField="InvestigationValue" HeaderText="Barcode No" ItemStyle-HorizontalAlign="Center"
                                                                ItemStyle-Width="3%">
                                                                <ItemStyle Width="8%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Name" HeaderText="Name">
                                                                <ItemStyle Width="15%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Age" HeaderText="Age-Sex">
                                                                <ItemStyle Width="8%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="WorkListID" HeaderText="WL.ID">
                                                                <ItemStyle Width="5%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="InvestigationName" HeaderText="Test Name">
                                                                <ItemStyle Width="12%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <%--<asp:TemplateField HeaderText="Test Name" Visible="false">
                                                                            <ItemTemplate>
                                                                                <asp:Literal ID="invDetails" runat="server" Text='<%#bind("Investigationname")%>'></asp:Literal>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Left" Width="1%" />
                                                                        </asp:TemplateField>--%>
                                                            <asp:BoundField DataField="Migrated_TestType" HeaderText="TAT DateTime">
                                                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="ManualAbnormal" HeaderText="ClientName">
                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Bottom" Width="10%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="ConvReferenceRange" HeaderText="Ref.DR">
                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Bottom" Width="10%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="IsCompleted" HeaderText="Result">
                                                                <ItemStyle Width="20%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="InstrumentName" HeaderText="PendingDays">
                                                                <ItemStyle Width="20%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <%--<asp:BoundField DataField="WorklistCreatedby" HeaderText="GeneratedBy" >
                                                                            <ItemStyle Width="1%" />
                                                                        </asp:BoundField>--%>
                                                        </Columns>
                                                        <EmptyDataRowStyle CssClass="dataheader1"></EmptyDataRowStyle>
                                                    </asp:GridView>
                                                </div>
                                            </td>
                                            <td id="tdGrpTable" runat="server" style="display: none">
                                                <asp:Table ID="InvTable" runat="server" class="w-100p" BorderColor="#000" ForeColor="#000">
                                                </asp:Table>
                                            </td>
                                            <td id="tdGrpTable1" runat="server" style="display: none">
                                                <asp:Table ID="GroupTable" runat="server" class="w-100p" BorderColor="#000" ForeColor="#000">
                                                </asp:Table>
                                            </td>
                                        </tr>
                                        <tr id="trGrpBased1" runat="server" style="display: none">
                                            <td id="Td6" runat="server" colspan="2">
                                                <div align="center" id="dvgrdGroupResultWL2" runat="server">
                                                    <asp:GridView ID="grdGroupResultWL2" runat="server" ForeColor="Black" CssClass="w-100p gridView"
                                                        CellPadding="1" AutoGenerateColumns="False" Style="margin-top: 0px" EmptyDataText="No Matching Records Found"
                                                        GridLines="Both">
                                                        <HeaderStyle Font-Bold="True" CssClass="dataheader1" />
                                                        <Columns>
                                                            <%--<asp:TemplateField>
                                                                            <HeaderTemplate>
                                                                                S.No
                                                                            </HeaderTemplate>
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblSNo" runat="server" Text='<%# Eval("Sno")%>' Style="float: left;
                                                                                    margin-left: 20px;"></asp:Label>
                                                                                <asp:Label ID="lblIsDataChanged" runat="server" Text="*" Style="float: left; margin-left: 5px;"></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle Width="5%" HorizontalAlign="Center" />
                                                                            <ItemStyle Width="5%" HorizontalAlign="Center" />
                                                                             </asp:TemplateField>--%>
                                                            <asp:TemplateField HeaderText="S.No">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="4%" HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="Migrated_Visit_Number" HeaderText="Visit.No">
                                                                <ItemStyle Width="8%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="InvestigationValue" HeaderText="Barcode No">
                                                                <ItemStyle Width="7%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Name" HeaderText="Patient Name">
                                                                <ItemStyle HorizontalAlign="Center" Width="8%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="DeviceID" DataFormatString="{0:dd-MM-yyyy hh:mm tt}" HeaderText="Registered.on">
                                                                <ItemStyle Width="9%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="WorkListID" HeaderText="WorkListID">
                                                                <ItemStyle Width="6%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="ManualAbnormal" HeaderText="ClientName">
                                                                <ItemStyle HorizontalAlign="Center" Width="12%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="InvestigationName" HeaderText="Test Name">
                                                                <ItemStyle Width="12%" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Age" HeaderText="Age/Sex">
                                                                <ItemStyle Width="9%" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" Visible="false">
                                                                <ItemStyle Width="1%" />
                                                            </asp:BoundField>
                                                            <%--<asp:TemplateField HeaderText="Barcode No" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="3%">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblSNo" runat="server" Text='<%# Eval("InvestigationValue")%>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        </asp:TemplateField>--%>
                                                            <%--<asp:BoundField DataField="InvestigationValue"  HeaderText="Barcode No" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="3%">
                                                                            <ItemStyle Width="8%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Name" HeaderText="Name">
                                                                            <ItemStyle HorizontalAlign="left" Width="13%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Age" HeaderText="Age /Sex">
                                                                            <ItemStyle Width="8%" />
                                                                        </asp:BoundField>
                                                                        
                                                                        <asp:BoundField DataField="Investigationname" HeaderText="Test Name">
                                                                            <ItemStyle Width="12%" HorizontalAlign="Left" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="IsSTAT" HeaderText="IsSTAT">
                                                                            <ItemStyle Width="1%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="DeptName" HeaderText="Dept.Name" Visible="false">
                                                                            <ItemStyle Width="1%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Migrated_TestType" HeaderText="TAT DateTime">
                                                                            <ItemStyle Width="8%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="ManualAbnormal" HeaderText="ClientName">
                                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Bottom" Width="12%" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="ConvReferenceRange" HeaderText="Ref.DR">
                                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Bottom" Width="10%" />
                                                                        </asp:BoundField>--%>
                                                            <asp:BoundField DataField="" HeaderText="Result">
                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Bottom" Width="10%" />
                                                            </asp:BoundField>
                                                            <%--<asp:BoundField DataField="WorklistCreatedby" HeaderText="GeneratedBy" >
                                                                            <ItemStyle Width="1%" />
                                                                        </asp:BoundField>--%>
                                                            <%-- <asp:BoundField DataField="PatientVisitID" HeaderText="VisitID" Visible="false">
                                                                            <ItemStyle Width="4%" HorizontalAlign="Center" />
                                                                        </asp:BoundField>--%>
                                                        </Columns>
                                                        <EmptyDataRowStyle CssClass="dataheader1"></EmptyDataRowStyle>
                                                    </asp:GridView>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="w-100p">
                                        <tr id="Dummy"  runat="server">
                                            <td id="Td8" runat="server">
                                                <asp:Table ID="listTab" runat="server" CssClass="w-100p searchPanel lh30" BorderColor="#000"
                                                    ForeColor="#000">
                                                    <%--<asp:TableRow>
                                                        <asp:TableCell>Name</asp:TableCell>
                                                        <asp:TableCell>Task</asp:TableCell>
                                                        <asp:TableCell>Hours</asp:TableCell>
                                                    </asp:TableRow>--%>
                                                </asp:Table>
                                            </td>
                                        </tr>
                                    </table>
                                    <div style="display: none;" id="divspec" align="left" runat="server">
                                        <input type="button" value="Print" id="btnspecprint" runat="server" class="details_label_age"
                                            onclick="CallSpecPrint();" />
                                        <table class="w-100p">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblResult" Style="width: 70%; margin: 0; display: block;" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <table id="DynamicTable" class="table  tableHover table-bordered table-condensed table-responsive tableHeaderBG" style="width:100%">
        </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </td>
                </tr>
            </table>
            <div id="divWaters" runat="server" style="Display: none">
            <asp:GridView ID="WatersDefault" runat="server" ForeColor="Black" CssClass="w-100p"
                CellPadding="1" AutoGenerateColumns="False" Style="margin-top: 0px" GridLines="None" EmptyDataText="No Matching Records Found" >
                <HeaderStyle Font-Bold="True" CssClass="dataheader1" />
                <Columns>
                <asp:BoundField DataField="AccessionNumber" HeaderText="name" Visible="false" >
                        <ItemStyle Width="4%" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Name" HeaderText="Client Name" >
                        <ItemStyle Width="4%" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="PrincipleName" HeaderText="Quotation Number" >
                        <ItemStyle Width="4%" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Test" HeaderText="Sample ID" >
                        <ItemStyle Width="4%" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="InvestigationName" HeaderText="Test Names">
                        <ItemStyle Width="10%" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Value" HeaderText="Values" Visible="false">
                        <ItemStyle Width="4%" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Values" HeaderStyle-Width="4%">
                        <ItemTemplate>
                            <asp:Label ID="lblWatersValues" Width="4%" runat="server" Text="_____________________________________________________________________"
                                Style="float: left; margin-left: 5px;"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataRowStyle CssClass="dataheader1"></EmptyDataRowStyle>
            </asp:GridView>
            </div> 
        </asp:Panel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    <asp:HiddenField ID="hdnIsGrpBased" runat="server" Value="N" />
    <asp:HiddenField ID="hdnPDFContent" runat="server" Value="N" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnIsWaters" runat="server" Value="" />
    <asp:HiddenField ID="hdnHistoFormat" runat="server" Value="" />
    </form>
     <script src="../Scripts/jquery-1.10.2.min.js" type="text/javascript"></script>
     <script src="../js/jquery-ui.min.js" language="javascript" type="text/javascript"></script>
     
<script src="../Scripts/jquery.table2excel.js" type="text/javascript"></script>
    <%--
    <script type="text/javascript" src="../Scripts/jquery.min.js"></script>

    <script type="text/javascript" src="../Scripts/jquery-ui.min.js"></script>--%>
<%--
    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>--%>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>
    
   <%-- <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>--%>
<%--<script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.print.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.flash.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.print.min.js"></script>--%>

<%--<script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.print.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.6/js/buttons.html5.min.js"></script>--%>


<script type="text/javascript" src="../Scripts/Jquery-1.10.19.datatable.min.js"></script>
<script type="text/javascript" src="../Scripts/1.5.6.buttons.min.js"></script>
<script type="text/javascript" src="../Scripts/1.5.6.buttons.print.min.js"></script>
<script type="text/javascript" src="../Scripts/3.1.3-JSZip.min.js"></script>
<script type="text/javascript" src="../Scripts/0.1.53.pdfmake.min.js"></script>
<script type="text/javascript" src="../Scripts/0.1.53.vfs_fonts.js"></script>
<script type="text/javascript" src="../Scripts/1.5.6.buttonHtml5.min.js"></script>
    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

<%--    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>--%>
  <%--
    <script src="../js/jquery-1.11.3.min.js" language="javascript" type="text/javascript"></script>--<%--%>
    <script src="../js/bootstrap.min.js" language="javascript" type="text/javascript"></script>--%>

    
    <%--<script src="../js/moment.min.js" language="javascript" type="text/javascript"></script>

    <script src="../js/bootstrap-datetimepicker.min.js" language="javascript" type="text/javascript"></script>--%>

    <script src="../js/jquery.dataTables.min.js" language="javascript" type="text/javascript"></script>

    <script src="../js/dataTables.tableTools.min.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

    <script src="../js/dataTables.responsive.min.js" language="javascript" type="text/javascript"></script>

    <script src="../js/dataTables.bootstrap.js" language="javascript" type="text/javascript"></script>

    


    <script language="javascript" type="text/javascript">
        $(document).ready(function() {
            loadintial();
        });
        function loadintial() {
            $("#txtInvestigationName").change(function() {
                if ($("#txtInvestigationName").val() == "") {
                    $("#hdnInvestigationID").val('0');
                }
            });




            $("#ddlWorkListType").change(function() {
                var ddlval = $("#ddlWorkListType :selected").val();
                $('#hdnIsGrpBased').val('N');
                switch (ddlval) {
                    case 'Analyzer_Based':
                        //$('#tdChildSearch').show(); 
                        $('#divAnalyzer').show(); $('#btnSearch').show();
                        $('#divInves').hide();
                        $('#divDept').hide();
                        $('#divWorkListID').hide();
                        $('#divGrps').hide();
                        $('#DivDate').show();
                        $('#divSample').hide();
                        $('#DivVist').hide();
                        $('#divVIP').show();
                        $('#DivVisit').show();
                        $('#Divday').hide();
                        $('#divproGrp').hide();
                        $('#divspec').hide();

                        $('#tdprintinter').hide(); 
                        break;
                    case 'Investigation_Based':
                        //$('#tdChildSearch').show(); 
                        $('#divInves').show(); $('#btnSearch').show();
                        $('#divAnalyzer').hide();
                        $('#divDept').hide();
                        $('#divGrps').hide();
                        $('#divWorkListID').hide();
                        $('#DivDate').show();
                        $('#divSample').hide();
                        $('#DivVist').hide();
                        $('#divVIP').show();
                        $('#DivVisit').show();
                        // $('#Divday').show();
                        $('#txtInvestigationName').val('');
                        $('#divproGrp').hide();
                        $('#divspec').hide();

                        $('#tdprintinter').hide(); 
                        break;
                    case 'Dept_Based':
                        $('#divAnalyzer').hide();
                        $('#divInves').hide();
                        //$('#tdChildSearch').show(); 
                        $('#divDept').show(); $('#btnSearch').show();
                        $('#divWorkListID').hide();
                        $('#divGrps').hide();
                        $('#DivDate').show();
                        $('#divSample').hide();
                        $('#DivVist').hide();
                        $('#divVIP').show();
                        $('#DivVisit').show();
                        // $('#Divday').hide();
                        $('#divproGrp').hide();
                        $('#divspec').hide();

                        $('#tdprintinter').hide(); 
                        break;
                    case 'WorkListID_Based':
                        $('#divAnalyzer').hide();
                        $('#divInves').hide();
                        $('#divDept').hide();
                        //$('#tdChildSearch').show(); 
                        $('#divWorkListID').show(); $('#btnSearch').show();
                        $('#txtWorkListID').val('');
                        $('#DivDate').show();
                        $('#divSample').hide();
                        $('#DivVist').hide();
                        $('#divVIP').show();
                        $('#DivVisit').show();
                        // $('#Divday').hide();
                        $('#txtWorkListID').val('');
                        $('#divproGrp').hide();
                        $('#divspec').hide();

                        $('#tdprintinter').hide(); 
                        break;
                    case 'Group_Based':
                        $('#divAnalyzer').hide();
                        $('#divInves').hide();
                        $('#divDept').hide();
                        $('#divWorkListID').hide();
                        // $('#tdChildSearch').show(); 
                        $('#divGrps').show(); $('#btnSearch').show();
                        $('#hdnIsGrpBased').val('Y');
                        $('#DivDate').show();
                        $('#divSample').hide();
                        $('#DivVist').hide();
                        $('#divVIP').show();
                        // $('#Divday').show();
                        $('#DivVisit').show();
                        $('#txtGrps').val('');
                        $('#divproGrp').hide();
                        $('#divspec').hide();

                        $('#tdprintinter').hide(); 
                        break;

                    case 'ProtocalGroup_Based':
                        $('#divAnalyzer').hide();
                        $('#divInves').hide();
                        $('#divDept').hide();
                        $('#divWorkListID').hide();
                        // $('#tdChildSearch').show();
                        $('#divGrps').hide();
                        $('#btnSearch').show();
                        $('#hdnIsGrpBased').val('N');
                        $('#DivDate').show();
                        $('#divSample').hide();
                        $('#DivVist').hide();
                        $('#divVIP').show();
                        // $('#Divday').show();
                        $('#DivVisit').show();
                        $('#divproGrp').show();
                        $('#divspec').hide();

                        $('#tdprintinter').hide(); 

                        break;
                    case 'Date_Based':
                        $('#divAnalyzer').hide();
                        $('#divInves').hide();
                        $('#divDept').hide();
                        $('#divWorkListID').hide();
                        $('#divGrps').hide();
                        $('#hdnIsGrpBased').val('Y');
                        //$('#tdChildSearch').show(); 
                        $('#DivDate').show(); $('#btnSearch').show();
                        $('#divSample').hide();
                        $('#DivVist').hide();
                        $('#divVIP').show();
                        $('#DivVisit').show();
                        //$('#Divday').hide();
                        $('#divproGrp').hide();
                        $('#divspec').hide();

                        $('#tdprintinter').hide(); 

                        //                        $('#txtFrom').val('');
                        //                        $('#txtTo').val('');
                        break;
                    case 'Special_Based':
                        $('#divAnalyzer').hide();
                        $('#divInves').hide();
                        $('#divDept').hide();
                        $('#divWorkListID').hide();
                        $('#divGrps').hide();
                        $('#hdnIsGrpBased').val('Y');
                        //$('#tdChildSearch').show();
                        $('#DivDate').show();
                        $('#btnSearch').show();
                        $('#divSample').hide();
                        $('#DivVist').hide();
                        $('#divVIP').hide();
                        $('#DivVisit').hide();
                        //$('#Divday').hide();
                        $('#divproGrp').hide();
                        $('#divDept').show();
                        $('#dvgrdGroupResultWL11').hide();
                        $('#dvgrdGroupResultWL111').hide();
                        $('#tbGrdResult').hide();
                        $('#dvMicroSF').hide();
                        $('#trPrint').hide();

                        $('#tdprintinter').hide(); 

                        //                        $('#txtFrom').val('');
                        //                        $('#txtTo').val('');
                        break;
                    case 'Visit_Level':
                        $('#divAnalyzer').hide();
                        $('#divInves').hide();
                        $('#divDept').hide();
                        $('#divWorkListID').hide();
                        $('#divGrps').hide();
                        $('#hdnIsGrpBased').val('Y');
                        //$('#tdChildSearch').show(); 
                        $('#DivVist').show(); $('#btnSearch').show();
                        $('#divSample').hide();
                        $('#DivDate').show();
                        $('#divVIP').show();
                        $('#DivVisit').show();
                        // $('#Divday').hide();
                        $('#divproGrp').hide();
                        $('#divspec').hide();

                        $('#tdprintinter').hide(); 

                        break;
                    case 'Sample_Based':
                        $('#divAnalyzer').hide();
                        $('#divInves').hide();
                        $('#divDept').hide();
                        $('#divWorkListID').hide();
                        $('#divGrps').hide();
                        $('#DivDate').show();
                        //$('#tdChildSearch').show(); 
                        $('#divSample').hide();
                        $('#divSample').show(); $('#btnSearch').show();
                        $('#DivVist').hide();
                        $('#divVIP').hide();
                        //$('#Divday').hide();
                        $('#DivVisit').show();
                        $('#divproGrp').hide();
                        $('#divspec').hide();
                        $('#tdprintinter').hide(); 

                        break;
                    case 'Interface_value':
                        $('#divAnalyzer').hide();
                        $('#divInves').hide();
                        $('#divDept').hide();
                        $('#divWorkListID').hide();
                        // $('#tdChildSearch').show(); 
                        $('#divGrps').show(); $('#btnSearch').show();
                        $('#hdnIsGrpBased').val('Y');

                        $('#DivDate').show();
                        $('#divSample').hide();
                        $('#DivVist').hide();
                        $('#divVIP').hide();
                        // $('#Divday').show();
                        $('#DivVisit').show();
                        $('#txtGrps').val('');
                        $('#divproGrp').hide();
                        $('#divspec').hide();
                        $('#tdprintinter').hide(); 

                        break;
                    case '0':
                        $('#divAnalyzer').hide();
                        $('#divInves').hide();
                        $('#divDept').hide();
                        $('#btnSearch').hide();
                        $('#divWorkListID').hide();
                        $('#divGrps').hide();
                        $('#DivDate').show();
                        $('#divSample').hide();
                        //$('#tdChildSearch').hide();
                        $('#DivVist').hide();
                        // $('#Divday').hide();
                        $('#divVIP').hide();
                        $('#DivVisit').hide();
                        $('#divproGrp').hide();
                        $('#divspec').hide();

                        $('#tdprintinter').hide(); 
                        break;
                    default:
                        $('#divAnalyzer').show(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                        $('#divVIP').show();
                        $('#DivVisit').show();
                        
                        // $('#Divday').hide();

                }
            });
        }
        //On Updatepanel refresh
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm != null) {
            prm.add_endRequest(function(sender, e) {
                if (sender._postBackSettings.panelID == 'UpdatePanel1|btnSearch') {
                    loadintial();
                }
            });
        };
            
        function getInstruments() {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetInstruments",
                data: "{OrgID: " + $('[id$="hdnOrgID"]').val() + ",WorkListType: '" + $('[id$="ddlWorkListType"]').val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) {
                    var models = (typeof response.d) == 'string' ? eval('(' + response.d + ')') : response.d;
                    for (var i = 0; i < models.length; i++) {
                        var val = models[i].InstrumentID;
                        var text = models[i].InstrumentName;
                        $("#ddlInstrument").append("<option value=" + val + ">" + text + "</option>");
                    }
                }
            });
        }
       
       


        function ShowCorresDiv() {
            var ddlval = $("#ddlWorkListType :selected").val();
            $('#hdnIsGrpBased').val('N');
            switch (ddlval) {
                case 'Analyzer_Based':
                    $('#divAnalyzer').show();
                    $('#divInves').hide();
                    $('#divDept').hide();
                    $('#divWorkListID').hide();
                    $('#divGrps').hide();
                    $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#DivDate').show();
                    $('#divSample').hide();
                    $('#DivVist').hide();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    $('#divproGrp').hide();
                    $('#divspec').hide();
                    // $('#Divday').hide(); 
                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                case 'Investigation_Based':
                    $('#divInves').show(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divAnalyzer').hide();
                    $('#divDept').hide();
                    $('#divGrps').hide();
                    $('#divWorkListID').hide();
                    $('#DivDate').show();
                    $('#divSample').hide();
                    $('#DivVist').hide();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    $('#txtInvestigationName').val('');
                    $('#divproGrp').hide();
                    $('#divspec').hide();
                    //$('#Divday').show();
                    funcheckboxlist();
                    //                    var objSel = document.getElementById("ddlWLFormatType");
                    //                    objSel.removeAttri
                    //                                     for (i = objSel.length - 1; i >= 0; i--) {
                    //                                        {
                    //                                          objSel.remove(i);
                    //                                        }
                    //                                   }

                    //                    objSel.options[0] = new Option("---Select---", "---Select---");
                    //                    objSel.options[1] = new Option("Portrait Format", "Portrait Format");

                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                case 'Dept_Based':
                    $('#divAnalyzer').hide();
                    $('#divInves').hide();
                    $('#divDept').show(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divWorkListID').hide();
                    $('#divGrps').hide();
                    $('#DivDate').show();
                    $('#divSample').hide();
                    $('#DivVist').hide();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    $('#divproGrp').hide();
                    $('#divspec').hide();
                    //$('#Divday').hide();
                    //                    var objSel = document.getElementById("ddlWLFormatType");
                    //                    objSel.removeAttri
                    //                    for (i = objSel.length - 1; i >= 0; i--) {
                    //                        {
                    //                            objSel.remove(i);
                    //                        }
                    //                    }

                    //                    objSel.options[0] = new Option("---Select---", "---Select---");
                    //                    objSel.options[1] = new Option("Portrait Format", "Portrait Format");
                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                case 'WorkListID_Based':
                    $('#divAnalyzer').hide();
                    $('#divInves').hide();
                    $('#divDept').hide(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divWorkListID').show();
                    $('#chkIncludeGeneratedWL').attr('checked', 'checked');
                    $('#divGrps').hide();
                    $('#DivDate').show();
                    $('#divSample').hide();
                    $('#DivVist').hide();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    $('txtWorkListID').val('');
                    //$('#Divday').hide();
                    $('#divproGrp').hide();
                    $('#divspec').hide();
                    //                    var objSel = document.getElementById("ddlWLFormatType");
                    //                    objSel.removeAttri
                    //                    for (i = objSel.length - 1; i >= 0; i--) {
                    //                        {
                    //                            objSel.remove(i);
                    //                        }
                    //                    }

                    //                    objSel.options[0] = new Option("---Select---", "---Select---");
                    //                    objSel.options[1] = new Option("Portrait Format", "Portrait Format");
                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                case 'Group_Based':
                    $('#divAnalyzer').hide();
                    $('#divInves').hide();
                    $('#divDept').hide(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divWorkListID').hide();
                    $('#divGrps').show();
                    $('#hdnIsGrpBased').val('Y');
                    $('#DivDate').show();
                    $('#divSample').hide();
                    $('#DivVist').hide();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    $('#txtGrps').val('');
                    //$('#Divday').show();
                    $('#divproGrp').hide();
                    funcheckboxlist();
                    $('#divspec').hide();
                    //                    funcheckboxlist();
                    //                    var objSel = document.getElementById("ddlWLFormatType");
                    ////                    for (i = objSel.length - 1; i >= 0; i--) {
                    ////                        if (objSel.options[i].selected) {
                    ////                            objSel.remove(i);
                    ////                        }
                    ////                    }

                    //                    objSel.options[0] = new Option("---Select---", "---Select---");
                    //                    objSel.options[1] = new Option("Portrait Format", "Portrait Format");
                    //                    objSel.options[2] = new Option("Group Contents in Column", "Group Contents in Column");
                    //                    objSel.options[3] = new Option("3 Column Group Contents", "3 Column Group Contents");
                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                case 'ProtocalGroup_Based':
                    $('#divAnalyzer').hide();
                    $('#divInves').hide();
                    $('#divDept').hide();
                    $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divWorkListID').hide();
                    $('#divGrps').hide();
                    $('#hdnIsGrpBased').val('N');
                    $('#DivDate').show();
                    $('#divSample').hide();
                    $('#DivVist').hide();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    //$('#Divday').hide();                    
                    $('#divproGrp').show();
                    // $('#Divday').show();
                    $('#divspec').hide();
                    funcheckboxlist();
                    //                    funcheckboxlist();
                    //                    var objSel = document.getElementById("ddlWLFormatType");
                    //                    objSel.removeAttri
                    //                    for (i = objSel.length - 1; i >= 0; i--) {
                    //                        {
                    //                            objSel.remove(i);
                    //                        }
                    //                    }

                    //                    objSel.options[0] = new Option("---Select---", "---Select---");
                    //                    objSel.options[1] = new Option("Portrait Format", "Portrait Format");
                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                case 'Date_Based':
                    $('#divAnalyzer').hide();
                    $('#divInves').hide();
                    $('#divDept').hide(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divWorkListID').hide();
                    $('#divGrps').hide();
                    $('#hdnIsGrpBased').val('Y');
                    $('#DivDate').show();
                    $('#divSample').hide();
                    $('#DivVist').hide();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    $('#divproGrp').hide();
                    $('#divspec').hide();
                    //$('#Divday').hide();
                    //                    var objSel = document.getElementById("ddlWLFormatType");
                    //                    objSel.removeAttri
                    //                    for (i = objSel.length - 1; i >= 0; i--) {
                    //                        {
                    //                            objSel.remove(i);
                    //                        }
                    //                    }

                    //                    objSel.options[0] = new Option("---Select---", "---Select---");
                    //                    objSel.options[1] = new Option("Portrait Format", "Portrait Format");
                    //                    $('#txtFrom').val('');
                    //                    $('#txtTo').val('');
                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                case 'Visit_Level':
                    $('#divAnalyzer').hide();
                    $('#divInves').hide();
                    $('#divDept').hide();
                    $('#divWorkListID').hide();
                    $('#divGrps').hide();
                    $('#hdnIsGrpBased').val('Y');
                    $('#DivDate').show();
                    $('#divSample').hide();
                    $('#DivVist').show(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    //$('#Divday').hide();
                    $('#divproGrp').hide();
                    $('#divspec').hide();
                    //                    var objSel = document.getElementById("ddlWLFormatType");
                    //                    objSel.removeAttri
                    //                    for (i = objSel.length - 1; i >= 0; i--) {
                    //                        {
                    //                            objSel.remove(i);
                    //                        }
                    //                    }

                    //                    objSel.options[0] = new Option("---Select---", "---Select---");
                    //                    objSel.options[1] = new Option("Portrait Format", "Portrait Format");
                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                case 'Sample_Based':
                    $('#divAnalyzer').hide();
                    $('#divInves').hide();
                    $('#divDept').hide(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divWorkListID').hide();
                    $('#divGrps').hide();
                    $('#DivDate').show();
                    $('#divSample').show();
                    $('#DivVist').hide();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    //$('#Divday').hide();
                    $('#divproGrp').hide();
                    $('#divspec').hide();
                    //                    var objSel = document.getElementById("ddlWLFormatType");
                    //                    objSel.removeAttri
                    //                    for (i = objSel.length - 1; i >= 0; i--) {
                    //                        {
                    //                            objSel.remove(i);
                    //                        }
                    //                    }

                    //                    objSel.options[0] = new Option("---Select---", "---Select---");
                    //                    objSel.options[1] = new Option("Portrait Format", "Portrait Format");
                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                case 'Special_Based':
                    $('#divAnalyzer').hide(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divVIP').hide(); //show();
                    $('#DivVisit').hide();
                    $('#divspec').hide();
                    $('#divDept').show();
                    $('#divGrps').hide();
                    $('#divWorkListID').hide();
                    $('#dvgrdGroupResultWL11').hide();
                    $('#dvgrdGroupResultWL111').hide();
                    $('#tbGrdResult').hide();
                    $('#dvMicroSF').hide();
                    break;
                case '0':
                    $('#divAnalyzer').hide();
                    $('#divInves').hide();
                    $('#divDept').hide();
                    $('#btnSearch').hide();
                    $('#divWorkListID').hide();
                    $('#divGrps').hide();
                    $('#DivDate').show();
                    $('#divSample').hide();
                    // $('#tdChildSearch').hide();
                    $('#DivVist').hide();
                    $('#divVIP').show();
                    $('#DivVisit').hide();
                    $('#divproGrp').hide();
                    $('#divspec').hide();
                    //$('#Divday').show();
                    //                    var objSel = document.getElementById("ddlWLFormatType");
                    //                    objSel.removeAttri
                    //                    for (i = objSel.length - 1; i >= 0; i--) {
                    //                        {
                    //                            objSel.remove(i);
                    //                        }
                    //                    }

                    //                    objSel.options[0] = new Option("---Select---", "---Select---");
                    //                    objSel.options[1] = new Option("Portrait Format", "Portrait Format");
                    //                    document.getElementById('txtFromVist').value = "";
                    //                    document.getElementById('txtTovist').value = "";
                    break;
                default:
                    $('#divAnalyzer').show(); $('#btnSearch').show(); //$('#tdChildSearch').show();
                    $('#divVIP').show();
                    $('#DivVisit').show();
                    $('#divspec').hide();
                    // $('#Divday').show(); 
            }
        }
        function funcheckdelay() {
            if (document.getElementById("chkdelay").checked) {
                $('#txtPendingDays').hide();
            }
            else {
                $('#txtPendingDays').show();
            }
        }
        //        $(document).ready(function() {

        //        $('input[name=chkdelay]').change(function() {
        //        if ($('input[name=chkdelay]').is(':checked')) {
        //                alert('Checked');
        //            } else {
        //                alert('Not checked');
        //            }
        //        });
        //        });
        function funcheckboxlist() {

            var checkBoxList = document.getElementById("<%=Chkpendingdays.ClientID %>");
            var checkboxes = checkBoxList.getElementsByTagName("input");
            var isValid = false;
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    checkboxes[i].checked = false;
                }
            }
            document.getElementById("txtPendingDays").value = ""; //chkdelay
            document.getElementById("chkdelay").checked = false;
        }

        function funcheckStatus() {
            if (document.getElementById("chkAll").checked == true) {
                //                document.getElementById("chkSampleReceived").checked = true;
                document.getElementById("chkPending").checked = true;
                document.getElementById("chkPartiallyApproved").checked = true;
            }
            else {
                //                document.getElementById("chkSampleReceived").checked = false;
                document.getElementById("chkPending").checked = false;
                document.getElementById("chkPartiallyApproved").checked = false;
            }

        }
        function ViewPendingDays() {
            $('#Divday').slideToggle("fast");
        }
        function CallPrint() {

            var prtContent = document.getElementById('PrintArea');
            var WinPrint = window.open('', '', 'left=0,top=0,width=1000,height=1000,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            //  WinPrint.print();
            WinPrint.print();
            WinPrint.close();
        }
        function CallPrintInterfaced() {

           document.getElementById('DynamicTable').setAttribute("style", "border:1px solid #000;border-collapse: collapse;width:100%;table-layout:fixed;");
            //            document.getElementsByTagName("td")[0].removeAttribute("style");
//<style type="text/css">' +
//        'table th, table td {' +
//        'border:1px solid #000;' +
//         'border-collapse: collapse;' +
//        '}' +
//        '</style>
            var divToPrint = document.getElementById('DynamicTable');
            var htmlToPrint = ''+
            '<html>'+
'<head >'+
    ''+
    '<link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="Stylesheet" type="text/css" />' +
'<link href="https://cdn.datatables.net/buttons/1.5.6/css/buttons.dataTables.min.css" rel="Stylesheet" type="text/css" />'+

       '</head><body>'
            htmlToPrint += divToPrint.outerHTML.replace("table-bordered","").replace("collapsed","");
            htmlToPrint += htmlToPrint+'</body></html>'
            newWin = window.open("");
            newWin.document.write(htmlToPrint);
            newWin.print();
            newWin.close();
        }

        function ExportToExcel() {
           
           $("#DynamicTable").table2excel({

    exclude: ".noExl",

    name: "Interface Worklist",

    filename: "InterfaceWorklist", //do not include extension

    fileext: ".xls" // file extension

             });

           
             
        }
        function CallSpecPrint() {

            var prtContent = document.getElementById('divspec');
            document.getElementById('btnspecprint').style.visibility = 'hidden';
            var WinPrint = window.open('', '', 'left=0,top=0,width=1000,height=1000,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.print();
            WinPrint.close();
            document.getElementById('btnspecprint').style.visibility = 'visible';
        }
        function PrintWorkList() {
            var prtContent = document.getElementById('PrintArea');
            document.getElementById('hdnPDFContent').value = prtContent.innerHTML;
            var Hwidth = $(window).width();
            var Vwidth = $(window).height();
            var WinPrint = window.open('', '', 'width=' + Hwidth + ',height=' + Vwidth + ',scrollbars=1,status=1,resizable=1');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            return false;
        }
        function inputOnlyNumbers(evt) {
            var e = window.event || evt;
            var charCode = e.which || e.keyCode;
            if ((charCode > 47 && charCode < 58) || charCode == 8 || charCode == 9 || charCode == 46 || charCode == 37 || charCode == 39 || (charCode > 95 && charCode < 106)) {
                return true;
            }
            return false;
        }

        function LoadInterfacedValue(worklisttype, SearchId, TestType, OrgID, WLMode, fromdate, todate, minVid, Maxvid, visitnumber) {
            $('#tdprintinter').hide();

            $('#tbResult').show();

            if (WLMode == "All") {
                $('#tbResult').attr('width', 50);
            }
            
           
            if (chkIncludeGeneratedWL.checked == true) {
                $('#lblWLID').hide();
                $('#lblWLOntxt').hide();
                $('#Label6').hide();
                $('#lblWLOn').hide();
                $('#lblWLUser1').hide(); 

              //$('#lblWLIDtxt').val('');
            }
           
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/InterfacedWorklist",
                data: JSON.stringify({ worklistType: worklisttype, SearchID: SearchId, Testtype: TestType, orgid: OrgID, WLMode: WLMode, fromdate: fromdate, todate: todate, minvid: minVid, maxvid: Maxvid, visitnumber: visitnumber }),
                dataType: "json",
                async: false,
                success: AjaxGetFieldDataSucceeded,
                error: function(result) {
                    alert("Error in Json Method");
                }
            });
        }
        function AjaxGetFieldDataSucceeded(result) {
            debugger;
            try {
                CreateDynamicGrid(result)
            }
            catch (e) {
                alert("Error in AjaxGetFieldDataSucceeded Method");
            }
        }
        var rowDataSet = [];
        var resultColumns = [];
        function CreateDynamicGrid(result) {

            if (result.d.length > 0) {
                var list = result.d;
                if (list[0].length > 0) {
                    var tabledata = list[0];
                    var parseJSONResult = JSON.parse(tabledata)
                    var i = 0;
                    $.each(parseJSONResult[0], function(key, value) {
                        var obj = { sTitle: key };
                        resultColumns[i] = obj;
                        i++;
                    });
                    var i = 0;
                    $.each(parseJSONResult, function(key, value) {
                        var rowData = [];
                        var j = 0;
                        $.each(parseJSONResult[i], function(key, value) {
                            rowData[j] = value;
                            j++;
                        });
                        rowDataSet[i] = rowData;
                        i++;
                    });

                    if (chkIncludeGeneratedWL.checked == false) {
                        $('#lblWLUser1').html(JSON.parse(result.d[1])[0].LoginName);
                        $('#lblWLIDtxt').html(JSON.parse(result.d[1])[0].WorkListID);
                    }
                    BindValues(true);
                }
            }
            else {
                alert('No records found !!!');
                $('#tbResult').hide();
                
            }

        }

        function BindValues(PageIng) {
            if (rowDataSet != null && resultColumns.length >= 0) {
                                    var tables = $.fn.dataTable.fnTables(true);

                //                    $(tables).each(function() {
                //                        $(this).dataTable().fnClearTable();
                //                        $(this).dataTable().fnDestroy();
                //                    });
                                    $('#DynamicTable').DataTable({
                                        "paging": false,
                                        "searching": false,
                                        "responsive": false,
                                        "bProcessing": true,
                                        "bserverside": true,
                                        "bPaginate": false,
                                        "bSortable": false,
                                        "aaData": rowDataSet,
                                        'bSort': false,
                                        "bFilter": true,
                                        "sZeroRecords": "No records found",
                                        "iDisplayLength": 100,
                                        "aoColumns": resultColumns,

                                        "aoColumnDefs": [{ "sDefaultContent": null,
                                            "aTargets": [0]}],
                                            "dom": 'Bfrtip',
                                            "buttons": ['print', { text: 'Excel',
                                                action: function(e, dt, node, config) {

                                                    $('#DynamicTable').find('th').attr('style', '');
                                                    $('#DynamicTable').find('th').attr('rowspan', '');
                                                    $('#DynamicTable').find('th').attr('colspan', '');
                                                        
          
                                                      
                                                  
                                                      $('#DynamicTable').find('td').attr('style', '');
                                                       $('#DynamicTable').find('td').attr('rowspan', '');
                                                        $('#DynamicTable').find('td').attr('colspan', '');


                                                       
                                                  
                                                   // exportTableToExcel('DynamicTable', 'InvestigationResults');
                                                    fnExcelReport();
                                               //     location.reload();


                                                } }]


                                            });
                                       $('#DynamicTable').show();
                                      
                //                    // $('#DynamicTable_info').hide();.addClass('compact')
                //                    //$('#DynamicTable_filter').hide();
                ////                    $(win.document.body).find('table')
                ////                    .addClass('compact')
                //                    //                        .css('font-size', 'inherit').css('width', '100%');
                // //extend: 'print','excel',
                ////                customize: function(win) {
                ////                    $(win.document.body)
                ////                        .css('font-size', '10pt');


                ////                    
                ////                }
                                    rowDataSet = [];
                                   resultColumns = [];
                                   return false;
                               }
                //                $('<button>Excel</button>')
                //        .prependTo('#DynamicTable')
                //        .on('click', function() {
                //            alert('Column sum is: ' + table.column(3).data().sum());
                //        });


                           }
                          



                        
          function exportTableToExcel(tableID, filename ){
    var downloadLink;
    var dataType = 'application/vnd.ms-excel';
//    document.getElementById(tableID).setAttribute("style", "border:1px solid #000;border-collapse: collapse;width:100%;table-layout:fixed;");
//    var divToPrint = document.getElementById('DynamicTable');
//    var htmlToPrint = '' +
//            '<html>' +
//'<head >' +
//    '' +

//       '</head><body>'
//    htmlToPrint += divToPrint.outerHTML.replace("table-bordered", "").replace("collapsed", "");
//    htmlToPrint += htmlToPrint + '</body></html>'
    var tableSelect = document.getElementById(tableID);
    var tableHTML =  tableSelect.outerHTML.replace(/ /g, '%20');
    
    // Specify file name
    filename = filename?filename+'.xls':'excel_data.xls';
    
    // Create download link element
    downloadLink = document.createElement("a");
    
    document.body.appendChild(downloadLink);
    
    if(navigator.msSaveOrOpenBlob){
        var blob = new Blob(['\ufeff', tableHTML], {
            type: dataType
        });
        navigator.msSaveOrOpenBlob( blob, filename);
    }else{
        // Create a link to the file
    downloadLink.href = 'data:' + dataType + ', ' + encodeURIComponent(tableHTML);
    
        // Setting the file name
        downloadLink.download = filename;
        
        //triggering the function
        downloadLink.click();
    }
}
function fnExcelReport() {
    var tab_text = "<table border='2px' > <col width='50px' /><tr bgcolor='#87AFC6'>";
    var textRange; var j = 0;
    tab = document.getElementById('DynamicTable'); // id of table

    for (j = 0; j < tab.rows.length; j++) {
        tab_text = tab_text + tab.rows[j].innerHTML.replace('style','').replace('rowspan','').replace('colspan','') + "</tr>";
        //tab_text=tab_text+"</tr>";
    }

    tab_text = tab_text + "</table>";


    var ua = window.navigator.userAgent;
    var msie = ua.indexOf("MSIE ");

    if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))      // If Internet Explorer
    {
        txtArea1.document.open("txt/html", "replace");
        txtArea1.document.write(tab_text);
        txtArea1.document.close();
        txtArea1.focus();
        sa = txtArea1.document.execCommand("Save", true, "InvestigationValues.xls");
    }
    else //other browser not tested on IE 11
        sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));
    return (sa);
}


    </script>
</body>
</html>
