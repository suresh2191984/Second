<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangeCollectSampleDate.aspx.cs"
    Inherits="Admin_ChangeCollectSampleDate" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">


<head id="Head1" runat="server">
    <title>ChangeCollectSampleDate</title>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>
   <script type="text/jscript">

       function SelectedVisitNumber(source, eventArgs) {
           debugger;
           var isVisitNumber = "";
           isVisitNumber = eventArgs.get_value().split('~');

           if (isVisitNumber[0] == "-1") {
               $("#txtVisitNumber").val('');
               $("#txtVisitNumber").focus();
               DisabledControl(isVisitNumber);
               return false;
           }
           $("#hdnVisitNumber").val(eventArgs._text);
           $("#hdnVisitID").val(isVisitNumber[0]);
           $('#hdnSampleReceivedDate').val(isVisitNumber[1]);
           $('#hdnCollectedDate').val(isVisitNumber[2]);
           $('#hdnApprovedDate').val(isVisitNumber[3]);
           isVisitNumber[1] != "N" ? $("#txtSampleReceivedDate").val(isVisitNumber[1]) : $("#txtSampleReceivedDate").val('');
           isVisitNumber[2] != "N" ? $("#txtCollectSampleDate").val(isVisitNumber[2]) : $("#txtCollectSampleDate").val('');
           isVisitNumber[3] != "N" ? $("#txtApprovedDate").val(isVisitNumber[3]) : $("#txtApprovedDate").val('');
           DisabledControl(isVisitNumber);
       }
       function DisabledControl(isVisitNumber) {
           var displaybtnsave = false;
           if (isVisitNumber[1] == "N") {
               $('#trSampleReceivedDate').css({ 'display': 'none' });
           } else {
               $('#trSampleReceivedDate').css({ 'display': 'table-row' });
               displaybtnsave = true;
           }
           if (isVisitNumber[2] == "N") {
               $('#trCollectSampleDate').css({ 'display': 'none' });
           } else {
               $('#trCollectSampleDate').css({ 'display': 'table-row' });
               displaybtnsave = true;
           }

           if (isVisitNumber[3] == "N") {
               $('#trApprovedDate').css({ 'display': 'none' });

           } else {
               $('#trApprovedDate').css({ 'display': 'table-row' });
               displaybtnsave = true;
           }

           if (displaybtnsave == true) {
               $('#trBtnSave').css({ 'display': 'table-row' });
           }
           else {
               $('#trBtnSave').css({ 'display': 'none' });
           }
       }

       function onkeypressClear() {
           debugger;
           $("#hdnVisitID").val('');
       }

       function onChangeVisitNumber() {
           debugger;
           if ($.trim($("#hdnVisitID").val()) == '' && $.trim($("#txtVisitNumber").val()) != '') {
               ClearALL();
               $("#txtVisitNumber").focus();
               alert("Please select valid Visitnumber !");
               return false;
           }
       }
       function ClearALL() {
           $("#hdnVisitID").val('');
           $("#txtVisitNumber").val('');
           $("#txtSampleReceivedDate").val('');
           $("#txtCollectSampleDate").val('');
           $("#txtApprovedDate").val('');

       }
       function SaveVisitNumber() {

           var boolCollect = true;
           var boolReceived = true;
           var boolApproved = true;

           if ($.trim($("#hdnVisitID").val()) == '') {
               ClearALL();
               $("#txtVisitNumber").focus();
               alert("Please select valid Visitnumber !");
               return false;
           }

           if ($.trim($("#hdnVisitNumber").val()) == '' || ($.trim($("#hdnVisitNumber").val()) != $.trim($("#txtVisitNumber").val()))) {
               ClearALL();
               $("#txtVisitNumber").focus();
               alert("Please select valid Visitnumber !");
               return false;
           }


           if ($.trim($('#txtCollectSampleDate').val()) == "N") {
               $('#txtCollectSampleDate').val('');
           }

           if ($.trim($('#hdnSampleReceivedDate').val()) == "N") {
               $('#hdnSampleReceivedDate').val('');
           }

           if ($.trim($('#hdnApprovedDate').val()) == "N") {
               $('#hdnApprovedDate').val('');
           }

           //$('#hdnSampleReceivedDate').val($.trim($('#hdnSampleReceivedDate').val()) == "N" ? $('#hdnSampleReceivedDate').val('') : $('#hdnSampleReceivedDate').val());
           //$('#hdnApprovedDate').val($.trim($('#hdnApprovedDate').val()) == "N" ? $('#hdnApprovedDate').val('') : $('#hdnApprovedDate').val());

           boolCollect = $.trim($("#txtCollectSampleDate").val()) == $.trim($('#hdnCollectedDate').val()) ? false : true;
           boolReceived = $.trim($("#txtSampleReceivedDate").val()) == $.trim($('#hdnSampleReceivedDate').val()) ? false : true;
           boolApproved = $.trim($("#txtApprovedDate").val()) == $.trim($('#hdnApprovedDate').val()) ? false : true;

           if (boolCollect == false && boolReceived == false && boolApproved == false) {
               alert("Please Change any one date value !");
               return false;
           }

       }
           
           
   </script>
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
                        <table width="40%">
                            <tr>
                                <td>
                                    <asp:Label ID="lblVisitNumber" runat="server" Text="VisitNumber"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtVisitNumber" runat="server" onkeypress="onkeypressClear();" ></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="ACEVisitNumber" runat="server" TargetControlID="txtVisitNumber"
                                        ServiceMethod="GetVisitNumber_ColletApproveAndReceivedDate" ServicePath="~/WebService.asmx"   EnableCaching="False"
                                        CompletionInterval="1"   Enabled="True"  CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"                                   
                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" OnClientItemSelected="SelectedVisitNumber" >
                                    </ajc:AutoCompleteExtender>                                    
                               
                                </td>
                            </tr>
                            <tr id="trCollectSampleDate" style="display:none">
                                <td>
                                    <asp:Label ID="lblCollectSampleDate" runat="server" Text="CollectSampleDate"></asp:Label>
                                </td>
                                <td >
                                    <asp:TextBox ID="txtCollectSampleDate" runat="server"></asp:TextBox>
                                    <a href="javascript:NewCssCal('txtCollectSampleDate','ddmmyyyy','arrow',true,12);document.getElementById('txtCollectSampleDate').focus();">
                                        <img src="../images/Calendar_scheduleHS.png" id="imgCalc" alt="Pick a date"></a>
                                </td>
                            </tr>
                            <tr id="trSampleReceivedDate" style="display:none">
                                <td>
                                    <asp:Label ID="lblSampleReceivedDate" runat="server" Text="SampleReceivedDate"></asp:Label>
                                </td>
                                <td >
                                    <asp:TextBox ID="txtSampleReceivedDate" runat="server"></asp:TextBox>
                                    <a href="javascript:NewCssCal('txtSampleReceivedDate','ddmmyyyy','arrow',true,12);document.getElementById('txtSampleReceivedDate').focus();">
                                        <img src="../images/Calendar_scheduleHS.png" id="img1" alt="Pick a date"></a>
                                </td>
                            </tr>
                            <tr id="trApprovedDate" style="display:none">
                                <td>
                                    <asp:Label ID="lblApprovedDate" runat="server" Text="ApprovedDate"></asp:Label>
                                </td>
                                <td >
                                    <asp:TextBox ID="txtApprovedDate" runat="server"></asp:TextBox>
                                    <a href="javascript:NewCssCal('txtApprovedDate','ddmmyyyy','arrow',true,12);document.getElementById('txtApprovedDate').focus();">
                                        <img src="../images/Calendar_scheduleHS.png" id="img2" alt="Pick a date"></a>
                                </td>
                            </tr>
                            <tr id="trBtnSave" style="display:none">
                                <td colspan="2" style="padding-left: 275px">
                                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" OnClick="btnSave_Click" OnClientClick="return SaveVisitNumber();" />
                                    
                                </td>
                            </tr>
                        </table>
                    </div>
               
       <Attune:Attunefooter ID="Attunefooter" runat="server" />
        <input id="hdnSampleReceivedDate" type="hidden" />
        <input id="hdnCollectedDate" type="hidden" />
        <input id="hdnApprovedDate" type="hidden" />
        <input id="hdnVisitNumber" type="hidden" />
        
      
    <asp:HiddenField ID="hdnVisitID" runat="server" />
    <asp:HiddenField ID="hdnPID" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
