<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BatchwiseWorksheet.aspx.cs"
    Inherits="Investigation_BatchwiseWorksheet" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Batchwise Result Entry</title>
    <link href="../StyleSheets/superTables.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>
    <style type="text/css">
        .searchBox
        {
            font-family: Arial, Helvetica, sans-serif;
            text-align: left;
            height: 15px;
            width: 150px;
            border: 1px solid #999999;
            font-size: 11px;
            margin-left: 0px;
            background-image: url('../Images/magnifying-glass.png');
            background-repeat: no-repeat;
            padding-left: 20px;
            background-color: #F3E2A9;
        }
        .listMain
        {
            width: 350px !important;
        }
    </style>
    <style type="text/css">
        table.gridtable
        {
            font-family: verdana,arial,sans-serif;
            font-size: 11px;
            color: #333333;
            border-width: 1px;
            border-color: #666666;
            border-collapse: collapse;
        }
        table.gridtable th
        {
            border-width: 1px;
            padding: 8px;
            border-style: solid;
            border-color: #666666;
            background-color: #dedede;
        }
        table.gridtable td
        {
            border-width: 1px;
            padding: 4px;
            border-style: solid;
            border-color: #666666;
            background-color: #d4e3e5;
        }
        .dataTables_processing
        {
            position: absolute;
            top: 50%;
            left: 50%;
            width: 250px;
            height: 30px;
            margin-left: -125px;
            margin-top: -15px;
            padding: 14px 0 2px 0;
            border: 1px solid #ddd;
            text-align: center;
            color: #999;
            font-size: 14px;
            background-color: white;
        }
    </style>
    <style type="text/css">
        .fixedColumn .fixedTable td
        {
            color: #FFFFFF;
            background-color: #187BAF;
            font-size: 12px;
            font-weight: normal;
            border-width: 1px;
            padding: 8px;
            border-style: solid;
            border-color: #666666;
            background-color: #dedede;
        }
        .fixedHead td, .fixedFoot td
        {
            color: #FFFFFF;
            background-color: #187BAF;
            font-size: 12px;
            font-weight: normal;
            padding: 10px;
            border: 1px solid #187BAF;
        }
        .fixedTable td
        {
            font-size: 8.5pt;
            background-color: #FFFFFF;
            padding: 5px;
            text-align: left;
            border: 1px solid #CEE7FF;
        }
    </style>
    <style type="text/css">
        .loading
        {
            font-family: Arial;
            font-size: 10pt;
            border: 5px solid #67CFF5;
            width: 150px;
            height: 70px;
            display: block;
            position: fixed;
            background-color: White;
            z-index: 999;
            text-align: center;
        }
        .modal
        {
            position: fixed;
            top: 0;
            left: 0;
            background-color: black;
            z-index: 99;
            opacity: 0.8;
            filter: alpha(opacity=80);
            -moz-opacity: 0.8;
            min-height: 100%;
            width: 100%;
        }
        .fakeContainer {
             border: none;
        }
    </style>
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server" enctype="multipart/form-data">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <asp:HiddenField ID="HDnInVID" runat="server" />
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:UpdateProgress ID="upProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="Image2" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                            
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <%--<asp:Panel ID="pnlFilter" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlFilterResource1">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="defaultfontcolor">
                                        <tr>
                                            <td>--%>
                                <asp:Panel ID="Panel1" runat="server">
                                    <div id="DivSearchArea" class="filterdataheader2" style="display: block;">
                                        <table class="w-100p searchPanel">
                                            <tr>
                                                <td class="a-left w-20p">
                                                </td>
                                                <td class="a-left w-10p">
                                                    <asp:Label ID="lblWorkLstID" class="style1" runat="server" Text="WorkList ID"></asp:Label>
                                                </td>
                                                <td class="a-left w-15p">
                                                    <asp:TextBox ID="txtWorkListID" CssClass="Txtboxsmall" Width="125px" runat="server"></asp:TextBox>
                                                </td>
                                                <td class="a-left w-15p">
                                                    <asp:Button ID="btnBatchSearch" Font-Bold="true" runat="server" Text="Search" OnClientClick="BatchValidation(); return false;"
                                                        CssClass="btn h-30" Width="120" />
                                                </td>
                                                <td class="a-left w-35p">
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>
                                <%-- </td>
                                        </tr>
                                    </table>
                                </asp:Panel>--%>
                                <asp:Label ID="lblResult" runat="server" ForeColor="#333" Visible="false">No Matching Records Found!</asp:Label>
                                <table id="ucSCTab" runat="server" style="display: table;" class="w-100p">
                                    <tr>
                                        <td>
                                            <div id="DInvest" runat="server" class="padding0" style="display: none;">
                                                <table id="captureTab" style="display: table;" class="w-100p searchPanel">
                                                    <tr id="trRangeColor" runat="server" style="display: table-row;">
                                                        <td class="v-top">
                                                            <table class="w-100p">
                                                                <tr>
                                                                    <td class="a-left w-70p">
                                                                        <asp:TextBox ID="txtAuto" ReadOnly="True" runat="server" CssClass="w-10 h-10"></asp:TextBox>
                                                                        <asp:Label ID="lblAutoColor" Text="Auto Authorization Range" runat="server"></asp:Label>
                                                                        <asp:TextBox ID="txtPanic" ReadOnly="True" runat="server" CssClass="w-10 h-10"></asp:TextBox>
                                                                        <asp:Label ID="lblPanicColor" runat="server" Text="Panic Range"></asp:Label>
                                                                        <asp:TextBox ID="txtReference" ReadOnly="True" runat="server" CssClass="w-10 h-10"></asp:TextBox>
                                                                        <asp:Label ID="lblreferencecolor" Text="Reference Range" runat="server"></asp:Label>
                                                                        <asp:TextBox ID="txtLower" ReadOnly="True" runat="server" CssClass="w-10 h-10"></asp:TextBox>
                                                                        <asp:Label ID="lblLower" Text="Lower Abnormal Range" runat="server"></asp:Label>
                                                                        <asp:TextBox ID="txtHigher" ReadOnly="True" runat="server" CssClass="w-10 h-10"></asp:TextBox>
                                                                        <asp:Label ID="lblHigher" Text="Higher Abnormal Range" runat="server"></asp:Label>
                                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                        <asp:Button ID="btnSave" runat="server" CssClass="btn w-100" OnClientClick="javascript:return fnSave();"
                                                                            OnClick="btnApproval_Click" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                                            Text="Save" />
                                                                        <asp:Button ID="btncancel" runat="server" CssClass="btn w-100" OnClick="Button1_Click"
                                                                            onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Cancel" />
                                                                    </td>
                                                                    <td class="a-left w-29p bold" id="tblWorklistId">
                                                                    </td>
                                                                    <td class="a-right">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div>
                                                                <div class="fakeContainer w-100p" class="" style="height: 400px;">
                                                                    <table id="tblUrinalysis">
                                                                        <%--<thead>
                                                                        </thead>--%>
                                                                        <tbody>
                                                                        </tbody>
                                                                    </table>
                                                                    <asp:Table ID="drawNewPattern" runat="server" CssClass="w-100p">
                                                                    </asp:Table>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="a-center">
                                                            <div id="divSave" runat="server">
                                                                <table class="defaultfontcolor w-30p">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Button ID="btnApproval" runat="server" CssClass="btn w-100" OnClientClick="javascript:return fnSave();"
                                                                                OnClick="btnApproval_Click" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                                                Text="Save" style="display:none;" />
                                                                            <asp:HiddenField ID="hdnDirectApproval" runat="server" Value="0" />
                                                                            <asp:Button ID="Button1" runat="server" CssClass="btn w-100" OnClick="Button1_Click" onmouseout="this.className='btn'"
                                                                                onmouseover="this.className='btn btnhov'" Text="Cancel" style="display:none;" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <ajc:ModalPopupExtender ID="mpeAttributeLocation" runat="server" BackgroundCssClass="modalBackground"
                                                Drag="false" DropShadow="false" PopupControlID="pnlLocation" TargetControlID="btnDummy" />
                                            <input id="btnDummy" runat="server" style="display: none;" type="button" />
                                            <asp:Panel ID="pnlLocation" runat="server" Style="display: none; max-height: 200px;"
                                                Width="300px">
                                                <asp:UpdatePanel ID="selectpnl" runat="server">
                                                    <ContentTemplate>
                                                        <div id="floatdiv" class="w-100p" runat="server" style="display: block; border-width: 1px; border-color: #000;
                                                           z-index: 100;">
                                                            <table class="w-100p" style="background-color: #333; border-color: #000; color: #fff;">
                                                                <tr class="colorforcontent h-20">
                                                                    <td>
                                                                        <table class="w-100p">
                                                                            <tr>
                                                                                <td>
                                                                                    Out Of Range
                                                                                </td>
                                                                                <td class="a-right">
                                                                                    <%--<img ID="img3" OnClick="javascript:hideConfirmpop();" 
                                                                                         src="../Images/Delete.jpg" style="cursor:pointer;" />--%>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-center">
                                                                        <font face="arial" size="2">The below test values are out of range !</font>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-left">
                                                                        <div id="divscrl" runat="server" style=" max-height: 190px;"  class="w-100p overflowAuto">
                                                                            <table class="w-90p marginL10">
                                                                                <font color="yellow" face="arial" size="2">
                                                                                    <asp:Label ID="ltrlTestName" runat="server" Text=""></asp:Label>
                                                                                </font>
                                                                            </table>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-center">
                                                                        <font face="arial" size="2">Do you wish to Continue ?</font>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-center">
                                                                        <table  class="w-20p">
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Button ID="btnSaveConfirm" runat="server" CssClass="btn" OnClick="btnSave_Click"
                                                                                        onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Yes" />
                                                                                </td>
                                                                                <td>
                                                                                    <asp:Button ID="btnCloseWarning" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                                                        onmouseover="this.className='btn btnhov'" Text="No" OnClientClick="return HideAbnormalPopup();" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </asp:Panel>
                                            <asp:HiddenField ID="hdnIds" runat="server" />
                                            <asp:HiddenField ID="hdnOutofrangeCount" runat="server" />
                                            <asp:HiddenField ID="hdnUnCheckedAbnormalControl" runat="server" Value="" />
                                            <asp:HiddenField ID="hdncountsofdata" runat="server" Value="0" />
                                            <asp:HiddenField ID="hdnActionName" runat="server" Value="EnterResult" />
                                            <asp:HiddenField ID="hdnDomainvalue" runat="server" Value="false" />
                                            <asp:HiddenField ID="hdnOutOfRangeDetails" runat="server" Value="" />
                                            <asp:HiddenField ID="hdnHighRangeDetails" runat="server" Value="" />
                                            <asp:HiddenField ID="hdnIsExcludeAutoApproval" runat="server" Value="" />
                                            <asp:HiddenField ID="hdnlstNotYetResolvedRRParams" runat="server" Value="" />
                                            <asp:HiddenField ID="hdnAutoMedicalComments" runat="server" />
                                            <input id="hdnabnormalchange" runat="server" type="hidden" />
                                            <input id="hdnJsonList" runat="server" type="hidden" />
                                        </td>
                                    </tr>
                                </table>
                                <div id="divProgress1" runat="server" class="dataTables_processing" style="display: none;">
                                    <div align="center" id="process">
                                        <img id="img1" src="~/Images/loader.gif" runat="server" alt="Processing....." />
                                    </div>
                                </div>
                                <%-- <div id="divProgress" runat="server" style="display: none; z-index: 9999;" align="center"
                                    class="dataTables_processing">
                                    <table align="center" class="loading">
                                        <tr>
                                            <td colspan="2" align="center">
                                                Loading...<br />
                                                <br />
                                                <img id="img3" src="~/Images/loader.gif" runat="server" alt="Processing....." />
                                            </td>
                                        </tr>
                                    </table>                                   
                                </div>--%>
                                <div id="divProgress" class="modal batchworkst" runat="server" style="display: none;">
                                   
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="Image1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                            
                                        </div>
                                    
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
         <Attune:Attunefooter ID="Attunefooter" runat="server" />         
    <input id="hdnVID" runat="server" type="hidden" value="0" />
    <input id="hdnHeaderName" runat="server" type="hidden" value="0" />
    <input id="hdnDept" runat="server" type="hidden" value="0" />
    <input id="hdnstatuschange" runat="server" type="hidden" value="0" />
    <input id="sourceSenderHDN" runat="server" type="hidden" />
    <input id="sourceNameHDN" runat="server" type="hidden" />
    <input id="testNameHDN1" runat="server" type="hidden" />
    <input id="sourceNameHDN1" runat="server" type="hidden" />
    <asp:HiddenField ID="hdnGenderAge" runat="server" />
    <asp:HiddenField ID="hdnValidateData" runat="server" />
    <asp:HiddenField ID="hdnErrorCount" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    <asp:HiddenField ID="hdnhigh" runat="server" Value="" />
    <asp:HiddenField ID="hdnIsCultureSensitivityV2" runat="server" Value="false" />
    <asp:HiddenField ID="hdnFishResulPattern" runat="server" Value="false" />
    <asp:HiddenField ID="hdnFishResulPattern1" runat="server" Value="false" />
    <asp:HiddenField ID="hdnEditableFormulaFields" runat="server" Value="" />
    <asp:HiddenField ID="hdnComputationFieldList" runat="server" Value="" />
    <asp:HiddenField ID="hdnPatientGender" runat="server" Value="" />
    <asp:HiddenField ID="hdnDDLValues" runat="server" Value="" />
    <asp:HiddenField ID="hdnMolbio" runat="server" Value="" />
    <asp:HiddenField runat="server" ID="hdnIsDeltaCheckWant" Value="false" />
    <asp:HiddenField runat="server" ID="hdnPatternID" />
    <asp:HiddenField runat="server" ID="hdnMappingPatternID" />
    <asp:HiddenField runat="server" ID="hdnPatientVisitID" />
    <asp:HiddenField runat="server" ID="hdnPatientInvID" />
    <asp:HiddenField ID="hdnDefaultDropDownStatus" runat="server" Value="" />
    <asp:HiddenField ID="hdnSensitiveRangeDetails" runat="server" Value="" />
    <asp:HiddenField ID="hdnLstPatientInvestigation" runat="server" Value="" />
    <asp:HiddenField ID="hdnLstInvestigationValues" runat="server" Value="" />
    <asp:HiddenField ID="hdnLstInvBulkData" runat="server" Value="" />
    <asp:HiddenField ID="hdnValidationText" runat="server" Value="" />
    </form>
</body>
</html>
<%--<script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>--%>
<%--<script src="../Scripts/jquery-1.6.1.min.js" type="text/javascript"></script>--%>

<script type="text/javascript" src="../Scripts/InvPattern.js"></script>

<script src="../Scripts/ResultCapture.js" type="text/javascript"></script>

<%--<script src="../Scripts/fxHeader.js" type="text/javascript"></script>--%>

<script src="../Scripts/superTables.js" type="text/javascript"></script>

<%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js" type="text/javascript"></script>--%>
<%-- <script src="../Scripts/jquery.fixedheadertable.js" type="text/javascript"></script>--%>



<script type="text/javascript">
    //<![CDATA[
    var mySt;
    function FixedHeader(FixedCols) {
        //debugger;
        mySt = new superTable("tblUrinalysis", {
            cssSkin: "sSky",    // Dont Change
            fixedCols: FixedCols,
            headerRows: 1,
            onStart: function() {
                this.start = new Date();
            },
            onFinish: function() {
                //document.getElementById("testDiv").innerHTML += "Finished...<br>" + ((new Date()) - this.start) + "ms.<br>";
            }
        });
    }

    //]]>

    //    // this "tableDiv" must be the table's class
    //    function FixedHeader() {
    //        $(".tableDiv").each(function() {
    //            debugger;
    //            var Id = $(this).get(0).id;
    //            var maintbheight = 555;
    //            var maintbwidth = 911;
    //            //debugger;
    //            $("#" + Id + " .FixedTables").fixedTable({
    //                width: maintbwidth,
    //                height: maintbheight,
    //                fixedColumns: 2,
    //                // header style
    //                classHeader: "fixedHead",
    //                // footer style        
    //                classFooter: "fixedFoot",
    //                // fixed column on the left        
    //                classColumn: "fixedColumn",
    //                // the width of fixed column on the left      
    //                fixedColumnWidth: 150,
    //                // table's parent div's id           
    //                outerId: Id,
    //                // tds' in content area default background color                     
    //                Contentbackcolor: "#FFFFFF",
    //                // tds' in content area background color while hover.     
    //                Contenthovercolor: "#99CCFF",
    //                // tds' in fixed column default background color   
    //                fixedColumnbackcolor: "#187BAF",
    //                // tds' in fixed column background color while hover. 
    //                fixedColumnhovercolor: "#99CCFF"
    //            });
    //        });
    //    }

</script>

<%--<script src="../Scripts/fxHeader.js" type="text/javascript"></script>--%>

<script type="text/javascript" language="javascript">

    function fnDisplayProgress() {
        try {
            //debugger;
            document.getElementById("divProgress").style.display = "block";
        }
        catch (e) {
        }
    }
    function fnHideProgress() {
        try {
            //debugger;
            document.getElementById("divProgress").style.display = "none";
        }
        catch (e) {
        }
    }
    function BatchValidation() {
        try {
            //debugger;
            if (document.getElementById("txtWorkListID").value.trim() == "" || document.getElementById("txtWorkListID").value.trim() == "0") {
                alert('Please Enter WorkSheetId');
                document.getElementById("txtWorkListID").focus();
                return false;
            }
            var WorklistId = document.getElementById("txtWorkListID").value.trim();
            document.getElementById("tblWorklistId").innerHTML = "WorklistId: " + WorklistId;
            //$("#divProgress").show();
            //document.getElementById("divProgress").style.display = "block";
            fnDisplayProgress();
            var VisitIDs = "0";
            var OrgID = '<%=Session["OrgID"]%>';
            var RoleID = '<%=Session["RoleID"]%>';
            var deptID = 0;
            var InvName = "";
            var InvType = "";
            var worklistid = document.getElementById("txtWorkListID").value.trim();
            var deviceid = 0;
            var isAbnormalResult = "0";
            var headerID = 0;
            var protocalID = 0;
            var ActionName = document.getElementById("hdnActionName").value.trim();
            var isMaster = "N";
            var workListType = "0";
            var LID = '<%=Session["LID"]%>';
            var lstInvPackageMapping = [];
            try {
                //document.getElementById("divProgress").style.display = "block";
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetBatchWiseInvestigationResultsCaptureFormat",
                    contentType: "application/json; charset=utf-8",
                    data: "{ 'VisitIDs': '" + VisitIDs + "','OrgID': '" + OrgID + "','RoleID': '" + RoleID + "','deptID': '" + deptID + "','InvName': '" + InvName + "','InvType': '" + InvType + "','worklistid': '" + worklistid + "','deviceid': '" + deviceid + "','isAbnormalResult': '" + isAbnormalResult + "','headerID': '" + headerID + "','protocalID': '" + protocalID + "','ActionName': '" + ActionName + "','isMaster': '" + isMaster + "','workListType': '" + workListType + "','LID': '" + LID + "'}",
                    dataType: "json",
                    async: true,
                    success: function fnAjaxGetBatchWiseInvestigationResultsCaptureFormat(data) {
                        //document.getElementById("divProgress").style.display = "block";
                        //$('#tblUrinalysis thead').children().remove();
                        $('#tblUrinalysis tbody').children().remove();
                        var table = $('#tblUrinalysis tbody');
                        var tr = $('<tr />');
                        var td = $('<td />');
                        var strtable = "";
                        var strtableHeader = "";
                        if (data.d.length > 0) {
                            var list = data.d;
                            if (list.length > 0) {
                                var strLst = JSON.stringify(list);
                                document.getElementById("hdnJsonList").value = strLst;
                                var PatientVisitID;
                                var hdnValidationText = document.getElementById("hdnValidationText");
                                hdnValidationText.value = "";
                                var dupes = {};
                                $.each(list, function(i, el) {
                                    //debugger;
                                    if (!dupes[el.InvestigationID]) {
                                        dupes[el.InvestigationID] = true;
                                        lstInvPackageMapping.push({
                                            ID: el.InvestigationID,
                                            PackageID: el.GroupID,
                                            Type: ""
                                        });
                                    }
                                });

                                if (list[0].ValidationText != null && list[0].ValidationText != "") {
                                    hdnValidationText.value = hdnValidationText.value + list[0].ValidationText;
                                }

                                var CountTotal = list.length;
                                var CountVisit = lstInvPackageMapping.length;
                                var CountInv = CountTotal / CountVisit;
                                strtable = strtable + "<tr>";
                                //strtable = strtable + "<th>S.No</th>";
                                strtable = strtable + "<th>Patient Name</th>";
                                strtable = strtable + "<th>Lab No</th>";
                                for (var r = 0; r < lstInvPackageMapping.length; r++) {
                                    strtable = strtable + "<th>" + list[r].Migrated_TestCode + "</th>";
                                }
                                strtable = strtable + "<th>Status</th>";
                                strtable = strtable + "</tr>";
                                fnLoadInvBulkdata(lstInvPackageMapping);
                                var lenList = list.length;
                                $('#tblUrinalysis').css('visibility', 'visible');
                                for (var i = 0; i < lenList; i++) {
                                    //debugger;
                                    if (i == 0) {
                                        //$('#tblUrinalysis tbody').append("<tr>");
                                        //$('#tblUrinalysis tbody').append("<td>" + list[i].Name + "</td>");
                                        //td.append(list[i].Name);
                                        var sno = i + 1;
                                        //strtable = strtable + "<tr>" + "<td><b>" + sno + "</b></td>";
                                        strtable = strtable + "<tr><td><b>" + list[i].Name + "</b></td>";
                                        strtable = strtable + "<td><b>" + list[i].VisitNumber + "</b></td>";
                                        PatientVisitID = list[i].PatientVisitID;
                                    }
                                    if (list[i].PatientVisitID == PatientVisitID) {
                                        //$('#tblUrinalysis tbody').append("<td>" + list[i].PatientVisitID + "</td>");
                                        //tr = td.clone().append(list[i].PatientVisitID);
                                        if (list[i].PatternID == 1) {
                                            strtable = strtable + BioPattern1(list[i]);
                                            //strtable = strtable + "<td><input type='text' id=tr_" + list[i].PatientVisitID + "_" + list[i].InvestigationID + " style='height:30px; width:120px;' /></td>";
                                        }
                                        else if (list[i].PatternID == 2) {
                                            strtable = strtable + BioPattern2(list[i]);
                                        }
                                        else if (list[i].PatternID == 3) {
                                            strtable = strtable + BioPattern3(list[i]);
                                        }
                                        else {
                                            //strtable = strtable + "<td>" + list[i].PatientVisitID + "</td>";
                                            strtable = strtable + "<td> -- </td>";
                                        }
                                        //strtable = strtable + "<td>" + list[i].PatientVisitID + "</td>";
                                    }
                                    else {
                                        //$('#tblUrinalysis tbody').append("</tr><tr>");
                                        //$('#tblUrinalysis tbody').append("<td>" + list[i].Name + "</td>");
                                        var sno = (i) / CountVisit + 1;
                                        //strtable = strtable + "</tr><tr>" + "<td><b>" + sno + "</b></td>";
                                        strtable = strtable + fnLoadStsDrpDwn();
                                        strtable = strtable + "</tr><tr><td><b>" + list[i].Name + "</b></td>";
                                        strtable = strtable + "<td><b>" + list[i].VisitNumber + "</b></td>";
                                        if (list[i].PatternID == 1) {
                                            var id = "tr_" + list[i].PatientVisitID + "_" + list[i].InvestigationID;
                                            strtable = strtable + BioPattern1(list[i]);
                                        }
                                        else if (list[i].PatternID == 2) {
                                            var id = "tr_" + list[i].PatientVisitID + "_" + list[i].InvestigationID;
                                            strtable = strtable + BioPattern2(list[i]);
                                        }
                                        else if (list[i].PatternID == 3) {
                                            var id = "tr_" + list[i].PatientVisitID + "_" + list[i].InvestigationID;
                                            strtable = strtable + BioPattern3(list[i]);
                                        }
                                        else {
                                            //strtable = strtable + "<td>" + list[i].PatientVisitID + "</td>";
                                            strtable = strtable + "<td> -- </td>";
                                        }
                                        PatientVisitID = list[i].PatientVisitID;
                                    }
                                }
                                strtable = strtable + fnLoadStsDrpDwn();
                                strtable = strtable + "</tr>";
                                //$('#tblUrinalysis thead').append(strtableHeader);
                                $('#tblUrinalysis tbody').append(strtable);
                            }
                            $('#DInvest').show();
                            $('#DivSearchArea').hide();
                            if (hdnValidationText.value != null && hdnValidationText.value != "") {
                                FixedHeader(0);
                            }
                            else {
                                FixedHeader(2);
                            }
                        }
                        else {
                            $('#DInvest').hide();
                            alert("No Matching Records Found");
                        }

                        //var j = jQuery.noConflict();
                        //$('#tblUrinalysis').fixedHeaderTable({ altClass: 'odd', footer: false, fixedColumns: 1 });
                        //                        fxheaderInit('tblUrinalysis', 400, 1, 2);
                        //                        fxheader();
                        //                        $('#tblUrinalysis').Scrollable({
                        //                            ScrollHeight: 300
                        //                        });
                        fnHideProgress();
                        return false;
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        fnHideProgress();
                        return false;
                    }
                });
            }
            catch (e) {
                $("#divProgress").hide();
            }
            //$("#divProgress").hide();
        }
        catch (e) {
            $("#divProgress").hide();
            return false;
        }
    }

    function fnLoadInvBulkdata(lstInvPackageMapping) {
        try {
            //debugger;
            var guid = '0';
            var InvestigationID = 0;
            var patientVisitID = 0;
            var orgID = '<%=Session["OrgID"]%>';
            var GroupID = 0;
            var strlstInvPackageMapping = JSON.stringify(lstInvPackageMapping);
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetInvBulkData",
                data: "{'guid':'" + guid + "','InvestigationID':'" + InvestigationID + "', 'patientVisitID': '" + patientVisitID + "','orgID': '" + orgID + "','GroupID': '" + GroupID + "','strlstInvPackageMapping':'" + strlstInvPackageMapping + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function(data) {
                    if (data.d != "[]" && data.d.length > 0) {
                        var list = data.d;
                        if (list.length > 0) {
                            var list1 = list[0];
                            $('#hdnLstInvBulkData').val(JSON.stringify(list1));
                            //return list1;
                        }
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    return false;
                }
            });
        }
        catch (e) {

        }
    }

    function BioPattern1(list) {
        try {
            //debugger;
            var id = "tdtxt_" + list.PatientVisitID + "_" + list.InvestigationID;
            var tdid = "td_" + list.PatientVisitID + "_" + list.InvestigationID;
            var hdnIsAbnormalId = "tdhdnIsAbnormal_" + list.PatientVisitID + "_" + list.InvestigationID;
            var hdnRefRangeId = "tdhdnRefRange_" + list.PatientVisitID + "_" + list.InvestigationID;
            var value = list.Value;
            var type = 'TXT';
            var backgroundcolor = "White";
            var IsAbnormal = list.IsAbnormal;
            var txtReadOnly = "''";
            var refrange = "''";
            var isFormulaField = "N";
            var hdnValidationRule = list.ValidationRule;
            //var ValRule = ValidationText.split("^");
            var ValRule = "";
            if (hdnValidationRule != "" && hdnValidationRule != null) {
                ValRule = hdnValidationRule.split("^");
            }

            for (i = 0; i < ValRule.length; i++) {
                var childInv = ValRule[i].split("=")[0];
                var childinvid = childInv.replace(/[\[\]\"']+/g, '');
                if (childinvid == list.InvestigationID) {
                    isFormulaField = "Y";
                    backgroundcolor = "#FABF8F";
                    break;
                }
            }

            if ((list.DeviceValue != null && list.DeviceValue != "")) {
                txtReadOnly = "disabled";
            }

            if (value == null || value == "") {
                value = "''";
            }
            if (list.IsAbnormal == "A") {
                backgroundcolor = "yellow";
            }
            else if (list.IsAbnormal == "L") {
                backgroundcolor = "LightPink";
            }
            else if (list.IsAbnormal == "P") {
                backgroundcolor = "red";
            }
            else {
                //backgroundcolor = "White";
                IsAbnormal = "''";
            }

            var ReferenceRange = list.ReferenceRange;
            var isXML = false;
            var $t = jQuery.noConflict();
            if (ReferenceRange != null && ReferenceRange != "") {
                try {
                    isXML = $t.parseXML(ReferenceRange).validateOnParse;
                } catch (err) {
                    isXML = false;
                }
            }
            if (isXML) {
                refrange = fnGetReferenceRange(list);
            } else if (list.ReferenceRange != null) {
                refrange = list.ReferenceRange;
            }

            //var strLst = JSON.stringify(list);
            //<input id='hdnRef' runat='server' type='hidden' value =" + strLst + "/>
            //return validatenumberOnly(event, 'txtdivupInvValue');
            //            var ResultValueType = list.ResultValueType;
            //            if (ResultValueType == "N") {
            //                var a = "<td style='width:100px;' id=" + tdid + "><input type='text' class ='txt' id=" + id + " " + txtReadOnly + " value =" + value + " onblur='javascript:fnvalidateResultValue(this,\"TXT\");' onkeydown ='javascript:return validatenumberOnly(event, this.id);' style='height:20px; width:70px; background-color:" + backgroundcolor + "'  /><input id=" + hdnIsAbnormalId + " value =" + IsAbnormal + " type='hidden'/></td>";
            //            }
            //            else {
            //                var a = "<td style='width:100px;' id=" + tdid + "><input type='text' class ='txt' id=" + id + " " + txtReadOnly + " value =" + value + " onblur='javascript:fnvalidateResultValue(this,\"TXT\");' style='height:20px; width:70px; background-color:" + backgroundcolor + "' /><input id=" + hdnIsAbnormalId + " value =" + IsAbnormal + " type='hidden'/></td>";
            //            }

            var a = "<td style='width:100px;' id=" + tdid + "><input type='text' class ='txt' id=" + id + " " + txtReadOnly + " value ='" + value + "' onblur='javascript:fnvalidateResultValue(this,\"TXT\");' style='height:20px; width:95px; background-color:" + backgroundcolor + "' /><input id=" + hdnIsAbnormalId + " value =" + IsAbnormal + " type='hidden'/><input id=" + hdnRefRangeId + " value ='" + refrange + "' type='hidden'/></td>";

            //" <img align='right' alt='Device Value' id='imgDeviceValue' style='cursor: pointer;' src = '../Images/report.gif' onclick = 'javascript:fnvalidateResultValue(" + tdid + "," + tdid + ");' title='Click to view Device Value' />";
            return a;
        }
        catch (e) {

        }
    }

    function BioPattern2(list) {
        try {
            //debugger;
            var drpid = "tddrp_" + list.PatientVisitID + "_" + list.InvestigationID;
            var txtid = "tdtxt_" + list.PatientVisitID + "_" + list.InvestigationID;
            var tdid = "td_" + list.PatientVisitID + "_" + list.InvestigationID;
            var hdnIsAbnormalId = "tdhdnIsAbnormal_" + list.PatientVisitID + "_" + list.InvestigationID;
            var hdnRefRangeId = "tdhdnRefRange_" + list.PatientVisitID + "_" + list.InvestigationID;
            var value = list.Value;
            var values;
            var drpValue = "''";
            var txtValue = "''";
            var strDropDown = "";
            var strTxtbox = "";
            var strTotal = "''";
            var strhdnRef = "''";
            var strhdn = "''";
            var refrange = "''";
            var InvestigationID = list.InvestigationID;
            var orgID = '<%=Session["OrgID"]%>';

            var txtReadOnly = "''";
            var drpDisabled = "''";
            if (list.DeviceValue != null && list.DeviceValue != "") {
                txtReadOnly = "disabled";
                drpDisabled = "disabled";
            }

            if (value == null || value == '') {
                value = "''";
                drpValue = "''";
                txtValue = "''";
            }
            else {
                values = value.split(",");
                if (values[0] != '') {
                    drpValue = values[0];
                }
                if (values[1] != undefined && value[1] != '') {
                    txtValue = values[1];
                }
            }
            var backgroundcolor = "White";
            var IsAbnormal = list.IsAbnormal;
            if (list.IsAbnormal == "A") {
                backgroundcolor = "yellow";
            }
            else if (list.IsAbnormal == "L") {
                backgroundcolor = "LightPink";
            }
            else if (list.IsAbnormal == "P") {
                backgroundcolor = "red";
            }
            else {
                backgroundcolor = "White";
                IsAbnormal = "''";
            }

            var ReferenceRange = list.ReferenceRange;
            var isXML = false;
            var $t = jQuery.noConflict();
            if (ReferenceRange != null && ReferenceRange != "") {
                try {
                    isXML = $t.parseXML(ReferenceRange).validateOnParse;
                } catch (err) {
                    isXML = false;
                }
            }
            if (isXML) {
                refrange = fnGetReferenceRange(list);
            }

            var lstInvBulkData = [];
            if ($('#hdnLstInvBulkData').val() != null && $('#hdnLstInvBulkData').val() != "") {
                lstInvBulkData = JSON.parse($('#hdnLstInvBulkData').val());
            }

            var lstInv = $.grep(lstInvBulkData, function(v) {
                return v.InvestigationID == InvestigationID;
            });
            //var list1 = list[0];
            strDropDown = "<td style='width:500px;white-space:nowrap' id =" + tdid + ">";
            strDropDown = strDropDown + "<select id=" + drpid + " " + drpDisabled + " class='drp' onchange='javascript:fnvalidateResultValue(this,\"DRP\");' style='background-color:" + backgroundcolor + "'>";
            strDropDown = strDropDown + "<option value=0>Select</option>";
            if (lstInv.length > 0) {
                for (l = 0; l < lstInv.length; l++) {
                    if (lstInv[l].Value == drpValue) {
                        strDropDown = strDropDown + "<option value='" + lstInv[l].Value + "' selected = 'selected' >" + lstInv[l].Value + "</option>";
                    }
                    else {
                        strDropDown = strDropDown + "<option value='" + lstInv[l].Value + "'>" + lstInv[l].Value + "</option>";
                    }
                }
            }
            strDropDown = strDropDown + "</select>";
            strTxtbox = "<input type='text' id=" + txtid + " value =" + txtValue + " " + txtReadOnly + " onblur='javascript:fnvalidateResultValue(this,\"TXT\");' style='height:20px; width:70px; background-color:" + backgroundcolor + "' />";
            strhdn = "<input id=" + hdnIsAbnormalId + " value=" + IsAbnormal + " type='hidden' />";
            strhdnRef = "<input id=" + hdnRefRangeId + " value='" + refrange + "' type='hidden' /></td>";
            strTotal = strDropDown + strTxtbox + strhdn + strhdnRef;
            return strTotal;
        }
        catch (e) {

        }
    }

    function BioPattern3(list) {
        try {
            //debugger;
            var id = "tddrp_" + list.PatientVisitID + "_" + list.InvestigationID;
            var tdid = "td_" + list.PatientVisitID + "_" + list.InvestigationID;
            var hdnIsAbnormalId = "tdhdnIsAbnormal_" + list.PatientVisitID + "_" + list.InvestigationID;
            var hdnRefRangeId = "tdhdnRefRange_" + list.PatientVisitID + "_" + list.InvestigationID;
            var value = list.Value;
            var type = 'DRP';
            var strDropDown = "";
            var InvestigationID = list.InvestigationID;
            var orgID = '<%=Session["OrgID"]%>';
            var refrange = "''";
            var drpDisabled = "''";
            if (list.DeviceValue != null && list.DeviceValue != "") {
                drpDisabled = "disabled";
            }

            if (value == null) {
                value = "''";
            }
            var backgroundcolor = "White";
            var IsAbnormal = list.IsAbnormal;
            if (list.IsAbnormal == "A") {
                backgroundcolor = "yellow";
            }
            else if (list.IsAbnormal == "L") {
                backgroundcolor = "LightPink";
            }
            else if (list.IsAbnormal == "P") {
                backgroundcolor = "red";
            }
            else {
                backgroundcolor = "White";
                IsAbnormal = "''";
            }

            var ReferenceRange = list.ReferenceRange;
            var isXML = false;
            var $t = jQuery.noConflict();
            if (ReferenceRange != null && ReferenceRange != "") {
                try {
                    isXML = $t.parseXML(ReferenceRange).validateOnParse;
                } catch (err) {
                    isXML = false;
                }
            }
            if (isXML) {
                refrange = fnGetReferenceRange(list);
            }

            var lstInvBulkData = [];
            if ($('#hdnLstInvBulkData').val() != null && $('#hdnLstInvBulkData').val() != "") {
                lstInvBulkData = JSON.parse($('#hdnLstInvBulkData').val());
            }

            var lstInv = $.grep(lstInvBulkData, function(v) {
                return v.InvestigationID == InvestigationID;
            });

            strDropDown = "<td  style='width:100px;' id =" + tdid + ">";
            strDropDown = strDropDown + "<select class='drp' id=" + id + " " + drpDisabled + " onchange='javascript:fnvalidateResultValue(this,\"DRP\");' style='background-color:" + backgroundcolor + "'>";
            strDropDown = strDropDown + "<option value=0>Select</option>";
            if (lstInv.length > 0) {
                //var list1 = list[0];               
                for (l = 0; l < lstInv.length; l++) {
                    if (lstInv[l].Value == value) {
                        strDropDown = strDropDown + "<option value='" + lstInv[l].Value + "' selected = 'selected' >" + lstInv[l].Value + "</option>";
                    }
                    else {
                        strDropDown = strDropDown + "<option value='" + lstInv[l].Value + "' >" + lstInv[l].Value + "</option>";
                    }
                }
            }
            strDropDown = strDropDown + '</select>';
            strhdnRef = "<input id=" + hdnRefRangeId + " value='" + refrange + "' type='hidden' /></td>";
            strDropDown = strDropDown + "<input id=" + hdnIsAbnormalId + " value=" + IsAbnormal + " type='hidden' />" + strhdnRef;
            return strDropDown;
        }
        catch (e) {

        }
    }

    function fnGetReferenceRange(list) {
        //debugger;
        try {
            //var uomCode = full["UOMCode"];
            //var xmlData = full["ReferenceRange"];

            var uomCode = list.UOMCode;
            var xmlData = list.ReferenceRange;
            var gender = list.Sex;
            var age = list.Age;
            var agedays = 0;
            var refrange;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/ConvertXmlToString",
                contentType: "application/json; charset=utf-8",
                data: "{ 'xmlData': '" + xmlData + "','uom': '" + uomCode + "','Gender': '" + gender + "','Age': '" + age + "','AgeDays': '" + agedays + "'}",
                dataType: "json",
                async: false,
                success: function(data) {
                    //debugger;
                    refrange = data.d;
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error");
                    return "";
                }
            });
            return refrange
        }
        catch (e) {

        }
    }

    function fnLoadStsDrpDwn() {
        try {
            //debugger;
            var id = "tddrp_StsDrpDwn";
            var tdid = "td_StsDrpDwn";
            var type = 'DRP';
            var strDropDown = "";


            //            var lstInvBulkData = [];
            //            if ($('#hdnLstInvBulkData').val() != null && $('#hdnLstInvBulkData').val() != "") {
            //                lstInvBulkData = JSON.parse($('#hdnLstInvBulkData').val());
            //            }

            //            var lstInv = $.grep(lstInvBulkData, function(v) {
            //                return v.InvestigationID == InvestigationID;
            //            });

            strDropDown = "<td  style='width:100px;' id =" + tdid + ">";
            //strDropDown = strDropDown + "<select class='drp' id=" + id + ">";
            strDropDown = strDropDown + "<select class='drp' id=" + id + "  onchange='javascript:CheckIfEmptyBatchSheet(this);'>";
            //            strDropDown = strDropDown + "<option value=0>Select</option>";
            strDropDown = strDropDown + "<option value=Pending>Pending</option>";
            strDropDown = strDropDown + "<option value=Completed>Completed</option>";
            strDropDown = strDropDown + "<option value=Next>Next</option>";

            //if (lstInv.length > 0) {
            //var list1 = list[0];               
            //                for (l = 0; l < lstInv.length; l++) {
            //                    strDropDown = strDropDown + "<option value='" + lstInv[l].Value + "' selected = 'selected' >" + lstInv[l].Value + "</option>";
            //                }
            //}
            strDropDown = strDropDown + '</select>';
            return strDropDown;
        }
        catch (e) {

        }
    }

    function fnvalidateResultValue(obj, type) {
        try {
            //debugger;
            id = obj.id;
            var idSplit = id.split("_");
            var PatientVisitID = idSplit[1];
            var InvestigationID = idSplit[2];
            var strLst = document.getElementById('hdnJsonList').value;
            var list = JSON.parse(strLst);

            var InvList = $.grep(list, function(v) {
                return v.PatientVisitID == PatientVisitID && v.InvestigationID == InvestigationID;
            });

            var xmlContent = InvList[0].IOMReferenceRange;
            //var rangeValue = document.getElementById(id).value;
            var rangeValue = $(obj).val();
            rangeValue = ConvertResultValue(rangeValue);

            if (xmlContent != null && xmlContent != "" && rangeValue != "" && rangeValue != "0") {

                //            if (type = "TXT") {
                //                rangeValue = document.getElementById(id).value;
                //            }
                //            else if ("DRP") {
                //                rangeValue = document.getElementById(id).value;
                //            }

                var ResultValueType = InvList[0].ResultValueType;
                if (ResultValueType == 'N') {
                    var DecimalPlaces = InvList[0].DecimalPlaces;
                    if (DecimalPlaces != null && DecimalPlaces != "" && !isNaN(DecimalPlaces)) {
                        var decimalPlace = parseInt(DecimalPlaces);
                        if (decimalPlace > 0) {
                            if (rangeValue.indexOf('<') >= 0) {
                                rangeValue = parseFloat(InvValue.replace('<', '')).toFixed(decimalPlace);
                                rangeValue = '<' + rangeValue;
                            }
                            else {
                                rangeValue = parseFloat(rangeValue).toFixed(decimalPlace);
                            }
                            //document.getElementById(id).value = rangeValue;
                            $(obj).val(rangeValue);
                        }
                    }
                }

                var pGender = InvList[0].Sex;
                var age = InvList[0].Age;
                var arr = age.split(' ');
                var pAge = arr[0];
                var pAgeType = arr[1];
                var txtid, panicxmlContent, txtIsAbnormalId, lblName, lblUnit = "";
                var agedays = 0;
                var AutoApproveLoginId = InvList[0].AutoApproveLoginID;
                var IsExcludeAutoApproval = document.getElementById('hdnIsExcludeAutoApproval').value;
                var hdnOrgID = document.getElementById('hdnOrgID').value;
                
                var isInterpretationRange = xmlContent.indexOf("resultsinterpretationrange") > -1 ? true : false;
                var interpretationResult = 0;
                if (type == "TXT" && isInterpretationRange) {
                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/ValidateInterpretationRange",
                        data: "{ReferenceRange: '" + xmlContent + "', Value:'" + rangeValue + "', Gender:'" + pGender + "', Age:'" + age + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function Success(data) {
                            var result = data.d;
                            if (result != "") {
                                var lstResult = result.split('~');
                                if (lstResult[0] == "Interpretation") {
                                    interpretationResult = lstResult[1];
                                }
                                else {
                                    interpretationResult = lstResult[1] + "," + rangeValue;
                                }
                            }
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            return false;
                        }
                    });
                    interpretationResult = interpretationResult == 0 ? rangeValue : interpretationResult;
                    //document.getElementById(id).value = interpretationResult;
                    $(obj).val(interpretationResult);
                }
                interpretationResult = interpretationResult == 0 ? rangeValue : interpretationResult;
                //var data = xmlContent + '|' + pGender + "~" + pAge + "~" + pAgeType + "|" + txtid + "|" + rangeValue + "|" + panicxmlContent + "|false|" + txtIsAbnormalId + "|" + "text" + "|" + AutoApproveLoginId + "|" + lblName + "|" + lblUnit + "|" + IsExcludeAutoApproval + "|" + hdnOrgID + "|" + agedays;
                var data = xmlContent + '|' + pGender + "~" + pAge + "~" + pAgeType + "|" + txtid + "|" + interpretationResult + "|" + panicxmlContent + "|false|" + txtIsAbnormalId + "|" + "text" + "|" + AutoApproveLoginId + "|" + lblName + "|" + lblUnit + "|" + IsExcludeAutoApproval + "|" + hdnOrgID + "|" + agedays;
                //ValidateToXml(data);
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/ValidateResultValue",
                    data: "{xmlData: '" + data + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function Success(data) {
                        //debugger;
                        if (data.d != '') {
                            var oDict = JSON.parse(data.d);
                            var txtColor = oDict["color"];
                            var rangeCode = oDict["rangeCode"];
                            var IsSensitive = oDict["IsSensitive"];
                            if (rangeCode != "A" && rangeCode != "L" && rangeCode != "P") {
                                rangeCode = "N";
                            }
                            //document.getElementById(id).style.backgroundColor = txtColor;
                            $(obj)[0].style.backgroundColor = txtColor;
                            //                            var $ParentRow = $(obj).parent();
                            //                            //$parentRow.find("td").each(function(j, m) {
                            //                            var $TextBoxes = $($ParentRow).find('input:text');
                            //                            var $dropdown = $($ParentRow).find('select');
                            //                            if ($TextBoxes.length > 0) {
                            //                                $TextBoxes.style.backgroundColor = txtColor;
                            //                            }
                            //                            else if ($dropdown.length > 0) {
                            //                                $dropdown[0].style.backgroundColor = txtColor;
                            //                            }
                            //});

                            //$(obj)[0].style.color = "yellow";
                            //$(obj)[0].style.backgroundColor = "yellow";

                            var hdnIsAbnormalId
                            if (type == "TXT") {
                                hdnIsAbnormalId = id.replace("tdtxt_", "tdhdnIsAbnormal_");
                            }
                            else {
                                hdnIsAbnormalId = id.replace("tddrp_", "tdhdnIsAbnormal_");
                            }
                            document.getElementById(hdnIsAbnormalId).value = rangeCode;
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        return false;
                    }
                });
            }
            else {
                //document.getElementById(id).style.backgroundColor = "White";
                //document.getElementById(hdnIsAbnormalId).value = "";
                $(obj)[0].style.backgroundColor = "White";
                //obj.style.backgroundColor = "White";
            }
            fnCalculateValue(obj);
        }
        catch (e) {

        }
    }

    function fnSave() {
        try {
            //debugger;
            //$('#btnApproval')
            document.getElementById("btnApproval").style.display = "none";
            //document.getElementById("btnSave").style.display = "none";
            fnDisplayProgress();
            var lstPatientInvestigation = [];
            var lstInvestigationValues = [];
            var lstTestName = "";
            var IfEmptyBatchSheet = false;
            $('#hdnLstInvestigationValues').val();
            $('#hdnLstPatientInvestigation').val();
            $("#hdnSaveToDispatch").val("1");
            var OrgID = document.getElementById('hdnOrgID').value;
            var LID = '<%=Session["LID"]%>';
            $(".sSky-Main tbody tr").each(function(i, n) {
                //debugger;
                var $row = $(n);
                var VisitStatus = "";
                //$row.find("td");
                //var stsDrp = $row.children('td:last')
                var $stsDrp = $(this).children('td:last').find('select');
                if ($stsDrp.length > 0) {
                    VisitStatus = $stsDrp.val();
                    if (VisitStatus == "Completed") {
                        if (!CheckIfEmptyBatchSheet($stsDrp[0]))
                           IfEmptyBatchSheet = true; 
                    }
                }

                $row.find("td:not(:last)").each(function(j, m) {
                    //debugger;
                    if (j != 0 && j != 1) {
                        var tdid = $(this).attr('id');
                        var PatientVisitID = tdid.split("_")[1];
                        var InvestigationID = tdid.split("_")[2];
                        var strLst = document.getElementById('hdnJsonList').value;
                        var list = JSON.parse(strLst);
                        var Status = "";
                        var hdnIsAbnormalId = "";
                        var hdnRefrangeId = "";
                        var IsAbnormal = "";
                        var Refrange = "";
                        var ConvValue = "0";
                        var Value = "-1";
                        var InvList = $.grep(list, function(v) {
                            return v.PatientVisitID == PatientVisitID && v.InvestigationID == InvestigationID;
                        });

                        var $TextBoxes = $(this).find('input:text');
                        var $dropdown = $(this).find('select');
                        var isOrdered = false;
                        if ($TextBoxes.length > 0 && $dropdown.length == 0) {   //BioPattern1
                            var txtid = tdid.replace("td", "tdtxt");
                            //Value = document.getElementById(txtid).value;
                            if ($TextBoxes.val().trim() != "")
                                Value = $TextBoxes.val();
                            //                            if (Value.trim() != "" || Status == "Completed") {  // For Urianalysis
                            //                                Status = "Completed";
                            //                            }
                            //                            else {
                            //                                Status = InvList[0].Status;
                            //                            }
                            Status = VisitStatus;
                            if (isNaN(Value) && isNaN(InvList[0].CONV_Factor) && isNaN(InvList[0].CONVFactorDecimalPt)) {
                                ConvValue = "0";
                            }
                            else {
                                ConvValue = (parseFloat(Value) * InvList[0].CONV_Factor).toFixed(InvList[0].CONVFactorDecimalPt);
                            }
                            isOrdered = true;
                        }
                        else if ($dropdown.length > 0 && $TextBoxes.length > 0) {     //BioPattern2
                            var drpid = tdid.replace("td", "tddrp");
                            //drpValue = document.getElementById(drpid).value;
                            drpValue = $dropdown.val();
                            var txtid = tdid.replace("td", "tdtxt");
                            //txtValue = document.getElementById(txtid).value.trim();
                            txtValue = $TextBoxes.val().trim();
                            //                            if (txtValue.trim() != "" || drpValue != "0") {
                            //                                Status = "Completed";
                            //                            }
                            //                            else {
                            //                                Status = InvList[0].Status;
                            //                            }
                            Status = VisitStatus;
                            if (txtValue != "" && drpValue != "0")
                                Value = drpValue + "," + txtValue;
                            ConvValue = "0";
                            isOrdered = true;
                        }
                        else if ($dropdown.length > 0 && $TextBoxes.length == 0) {     //BioPattern3
                            var drpid = tdid.replace("td", "tddrp");
                            //Value = document.getElementById(drpid).value;
                            if ($dropdown.val() != "0")
                                Value = $dropdown.val();
                            //                            if (Value.trim() != "0") {
                            //                                Status = "Completed";
                            //                            }
                            //                            else {
                            //                                Status = InvList[0].Status;
                            //                            }
                            Status = VisitStatus;
                            if (isNaN(Value) && isNaN(InvList[0].CONV_Factor) && isNaN(InvList[0].CONVFactorDecimalPt)) {
                                ConvValue = "0";
                            }
                            else {
                                ConvValue = (parseFloat(Value) * InvList[0].CONV_Factor).toFixed(InvList[0].CONVFactorDecimalPt);
                            }
                            isOrdered = true;
                        }
                        if (isOrdered) {
                            hdnIsAbnormalId = tdid.replace("td_", "tdhdnIsAbnormal_");
                            IsAbnormal = document.getElementById(hdnIsAbnormalId).value;
                            if (IsAbnormal == "null") {
                                IsAbnormal = "";
                            }

                        hdnRefrangeId = tdid.replace("td_", "tdhdnRefRange_");
                        if (hdnRefrangeId != undefined && hdnRefrangeId != null)
                            Refrange = document.getElementById(hdnRefrangeId).value;                        

                        lstPatientInvestigation.push({
                            InvestigationID: InvList[0].InvestigationID,
                            PatientVisitID: PatientVisitID,
                            Status: Status,
                            ReferenceRange: Refrange,
                            Reason: InvList[0].Reason,
                            MedicalRemarks: InvList[0].MedicalRemarks,
                            OrgID: OrgID,
                            AutoApproveLoginID: InvList[0].AutoApproveLoginID,
                            AccessionNumber: InvList[0].AccessionNumber,
                            UID: InvList[0].UID,
                            LabNo: InvList[0].LabNo,
                            LoginID: LID,
                            GroupID: InvList[0].GroupID,
                            IsAbnormal: IsAbnormal,
                            //RemarksID: rowData["ConvReferenceRange"],
                            GroupName: InvList[0].GroupName,
                            ConvReferenceRange: InvList[0].ConvReferenceRange,
                            //InvStatusReasonID: rowData["ConvReferenceRange"],
                            IsSensitive: InvList[0].IsSensitive,
                            ManualAbnormal: InvList[0].ManualAbnormal,
                            CONV_Factor: InvList[0].CONV_Factor,
                            CONVFactorDecimalPt: InvList[0].CONVFactorDecimalPt
                        });
                        if (Value != "-1" && VisitStatus != "Next") {
                            lstInvestigationValues.push({
                                InvestigationID: InvList[0].InvestigationID,
                                Name: InvList[0].InvestigationName,
                                PatientVisitID: PatientVisitID,
                                Value: Value,
                                UOMCode: InvList[0].UOMCode,
                                OrgID: OrgID,
                                UID: InvList[0].UID,
                                CreatedBy: LID,
                                GroupID: InvList[0].GroupID,
                                GroupName: InvList[0].GroupName,
                                //Orgid,
                                Status: Status,
                                PackageID: InvList[0].PackageID,
                                PackageName: InvList[0].PackageName,
                                //Dilution,
                                //UID,
                                DeviceID: InvList[0].DeviceID,
                                //DeviceID: "",
                                DeviceValue: InvList[0].DeviceValue,
                                DeviceActualValue: InvList[0].DeviceActualValue,
                                ConvUOMCode: InvList[0].CONV_UOMCode,
                                //ConvValue,
                                CONV_Factor: InvList[0].CONV_Factor,
                                CONVFactorDecimalPt: InvList[0].CONVFactorDecimalPt
                            });
                        }
                        if (IsAbnormal != "N" && IsAbnormal != null && IsAbnormal != "" && IsAbnormal != "null") {
                            lstTestName += InvList[0].Name + "-" + InvList[0].InvestigationName + ":" + Value + "</br>";
                        }
                    }
                    }
                });
            });
            if (IfEmptyBatchSheet) {
                fnHideProgress();
                return false;
            }
            $('#hdnLstPatientInvestigation').val(JSON.stringify(lstPatientInvestigation));
            $('#hdnLstInvestigationValues').val(JSON.stringify(lstInvestigationValues));
            $find('mpeAttributeLocation').hide();

            //            if (lstTestName != "") {
            //                //debugger;
            //                $('#hdnLstPatientInvestigation').val(JSON.stringify(lstPatientInvestigation));
            //                $('#hdnLstInvestigationValues').val(JSON.stringify(lstInvestigationValues));
            //                if (lstPatientInvestigation.length > 0 && lstInvestigationValues.length > 0) {
            //                    document.getElementById('ltrlTestName').innerHTML = lstTestName;
            //                    $find('mpeAttributeLocation').show();
            //                    return false;
            //                }
            //            }

            //            else {
            //                $('#hdnLstPatientInvestigation').val(JSON.stringify(lstPatientInvestigation));
            //                $('#hdnLstInvestigationValues').val(JSON.stringify(lstInvestigationValues));
            //                $find('mpeAttributeLocation').hide();
            //            }

        }
        catch (e) {
            fnHideProgress();
        }
    }
    function HideAbnormalPopup() {
        $find("mpeAttributeLocation").hide();
        return false;
    }

    function fnCalculateValue(obj) {
        try {
            //debugger;
            var $parentRow = $(obj).parent().parent();
            var hdnValidationText = document.getElementById("hdnValidationText");
            var hdnValidationTextTemp = "";
            hdnValidationTextTemp = hdnValidationText.value;
            $parentRow.find("td:not(:last)").each(function(j, m) {
                if (j != 0 && j != 1) {
                    var $TextBoxes = $(this).find('input:text');
                    if (hdnValidationText.value != null && hdnValidationText.value != "") {
                        var id = $TextBoxes[0].id;
                        var invId = id.split("_")[2];

                        var ValRule = "";
                        ValRule = hdnValidationText.value;
                        var Re = new RegExp("\\'\\[" + invId + "]'", "g");
                        ValRule = ValRule.replace(Re, "'" + id + "'");
//                        var Re = new RegExp("\\'\\[" + oData["InvestigationID"] + "]'", "g");
//                        ValRule = ValRule.replace(Re, "'" + id + "'");
                        var Re1 = new RegExp("\\" + "[" + invId + "]" + "", "g");
                        ValRule = ValRule.replace(Re1, "document.getElementById('" + id + "').value");
                        hdnValidationText.value = ValRule;
                    }
                }
            });


            s = ' function fnCalculateValue1() { ' + document.getElementById('hdnValidationText').value + '}';
            eval(s);
            fnCalculateValue1();
            document.getElementById('hdnValidationText').value = hdnValidationTextTemp;


//            var txtEditable1 = false;
//            if (document.getElementById('hdnEditableFormulaFields') != null) {
//                txtEditable1 = document.getElementById('hdnEditableFormulaFields').value.indexOf('tdtxt_43_7951') >= 0 ? true : false
//            }
//            if (!txtEditable1) {
//                document.getElementById('tdtxt_43_7951').value = '';
//                if (parseInt(document.getElementById('tdtxt_43_9404').value.trim()) > 0) {
//                    if (parseInt(document.getElementById('tdtxt_43_9405').value.trim()) > 0) {
//                        if (parseInt(document.getElementById('tdtxt_43_9406').value.trim()) > 0) {
//                            if ((parseInt(document.getElementById('tdtxt_43_9407').value.trim()) <= 0 && parseInt(document.getElementById('tdtxt_43_9408').value.trim()) <= 0 && parseInt(document.getElementById('tdtxt_43_9409').value.trim()) <= 0) || ((document.getElementById('tdtxt_43_9407').value.trim() == '--' && document.getElementById('tdtxt_43_9408').value.trim() == '--' && document.getElementById('tdtxt_43_9409').value.trim() == '--'))) {
//                                if (parseInt(document.getElementById('tdtxt_43_2040').value.trim()) > 0) {
//                                    document.getElementById('tdtxt_43_7951').value = 'AB Rh(D) Positive'
//                                } else if ((parseInt(document.getElementById('tdtxt_43_2040').value.trim()) <= 0) || (document.getElementById('tdtxt_43_2040').value.trim() == '--')) {
//                                    document.getElementById('tdtxt_43_7951').value = 'AB Rh(D) Negative'
//                                }
//                            }
//                        }
//                    } else if ((parseInt(document.getElementById('tdtxt_43_9405').value.trim()) <= 0) || (document.getElementById('tdtxt_43_9405').value.trim() == "--")) {
//                        if (parseInt(document.getElementById('tdtxt_43_9406').value.trim()) > 0) {
//                            if ((parseInt(document.getElementById('tdtxt_43_9407').value.trim()) <= 0 && parseInt(document.getElementById('tdtxt_43_9408').value.trim()) > 0 && parseInt(document.getElementById('tdtxt_43_9409').value.trim()) <= 0) || ((document.getElementById('tdtxt_43_9407').value.trim() == '--' && document.getElementById('tdtxt_43_9408').value.trim() == '--' && document.getElementById('tdtxt_43_9409').value.trim() == '--'))) {
//                                if (parseInt(document.getElementById('tdtxt_43_2040').value.trim()) > 0) {
//                                    document.getElementById('tdtxt_43_7951').value = 'A Rh(D) Positive'
//                                } else if ((parseInt(document.getElementById('tdtxt_43_2040').value.trim()) <= 0) || (document.getElementById('tdtxt_43_2040').value.trim() == '--')) {
//                                    document.getElementById('tdtxt_43_7951').value = 'A Rh(D) Negative'
//                                }
//                            }
//                        }
//                    }
//                } else if ((parseInt(document.getElementById('tdtxt_43_9404').value.trim()) <= 0) || (document.getElementById('tdtxt_43_9404').value.trim() == "--")) {
//                    if (parseInt(document.getElementById('tdtxt_43_9405').value.trim()) > 0) {
//                        if (parseInt(document.getElementById('tdtxt_43_9406').value.trim()) > 0) {
//                            if ((parseInt(document.getElementById('tdtxt_43_9407').value.trim()) > 0 && parseInt(document.getElementById('tdtxt_43_9408').value.trim()) <= 0 && parseInt(document.getElementById('tdtxt_43_9409').value.trim()) <= 0) || ((document.getElementById('tdtxt_43_9407').value.trim() == '--' && document.getElementById('tdtxt_43_9408').value.trim() == '--' && document.getElementById('tdtxt_43_9409').value.trim() == '--'))) {
//                                if (parseInt(document.getElementById('tdtxt_43_2040').value.trim()) > 0) {
//                                    document.getElementById('tdtxt_43_7951').value = 'B Rh(D) Positive'
//                                } else if ((parseInt(document.getElementById('tdtxt_43_2040').value.trim()) <= 0) || (document.getElementById('tdtxt_43_2040').value.trim() == '--')) {
//                                    document.getElementById('tdtxt_43_7951').value = 'B Rh(D) Negative'
//                                }
//                            }
//                        }
//                    } else if ((parseInt(document.getElementById('tdtxt_43_9405').value.trim()) <= 0) || (document.getElementById('tdtxt_43_9405').value.trim() == "--")) {
//                        if (parseInt(document.getElementById('tdtxt_43_9406').value.trim()) > 0) {
//                            document.getElementById('tdtxt_43_7951').value = ''
//                        } else if ((parseInt(document.getElementById('tdtxt_43_9406').value.trim()) <= 0) || (parseInt(document.getElementById('tdtxt_43_9406').value.trim()) <= 0) || (document.getElementById('tdtxt_43_9406').value.trim() == '--') || (document.getElementById('tdtxt_43_9406').value.trim() == '--')) {
//                            if ((parseInt(document.getElementById('tdtxt_43_9407').value.trim()) > 0 && parseInt(document.getElementById('tdtxt_43_9408').value.trim()) > 0 && parseInt(document.getElementById('tdtxt_43_9409').value.trim()) <= 0) || ((document.getElementById('tdtxt_43_9407').value.trim() == '--' && document.getElementById('tdtxt_43_9408').value.trim() == '--' && document.getElementById('tdtxt_43_9409').value.trim() == '--'))) {
//                                if (parseInt(document.getElementById('tdtxt_43_2040').value.trim()) > 0) {
//                                    document.getElementById('tdtxt_43_7951').value = '0 Rh(D) Positive'
//                                } else if ((parseInt(document.getElementById('tdtxt_43_2040').value.trim()) <= 0) || (document.getElementById('tdtxt_43_2040').value.trim() == '--')) {
//                                    document.getElementById('tdtxt_43_7951').value = '0 Rh(D) Negative'
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//         
            
           
        }
        catch (e) {

        }
    }

</script>
