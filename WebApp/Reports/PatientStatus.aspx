<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientStatus.aspx.cs" Inherits="Lab_PatientStatus" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Approval History</title>
    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />

    <script src="../Scripts/AdobeReaderDetection.js" type="text/javascript" language="javascript" />

   <%--  <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

     <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

  <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>--%>
<%--
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />--%>
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_page.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_table.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_table_jui.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
<%--    <link href="../StyleSheets/jquery-ui-1.8.4.custom.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/InvPattern.js"></script>

    <script src="../Scripts/ResultCapture.js" type="text/javascript"></script>

 <%--   <script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />--%>
    <style type="text/css">
        .blur
        {
            z-index: 10000;
            top: 0px;
            left: 0px;
            background-color: #000;
            filter: alpha(opacity=60);
            opacity: 0.60;
        }
        .progress
        {
            width: 75px;
            height: 5px;
            background-color: Black;
            color: #ccc;
            padding: 10px;
        }
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

    <script language="javascript" type="text/javascript">
        function changeLbl(id) {
            var pStatus = $("#ddlStatus :selected").val();
            document.getElementById('lblProcessedBy').innerHTML = pStatus + ' ' + 'By';
        }
        function WaterMark(txttext, evt, defaultText) {
            if (txttext.value.length == 0 && evt.type == "blur") {
                txttext.style.color = "gray";
                txttext.value = defaultText;
            }
            if (txttext.value == defaultText && evt.type == "focus") {
                txttext.style.color = "black";
                txttext.value = "";
            }
        }

        function GetData() {
            try {
                var pop = $find("mdlPopup1");
                pop.show();
                if (document.getElementById('txtFrom').value == '') {
                    alert('Select From Date!!!');
                    return false
                }
                if (document.getElementById('txtTo').value == '') {
                    alert('Select To Date!!!');
                    return false
                }
                var pLabNumber = document.getElementById('txtLabNumber').value;
                if (pLabNumber == "" || pLabNumber == "Lab Number") {
                    pLabNumber = 0;
                }
                var pProcessedBy = $("#ddlProcessedBy :selected").val();
                var pLocation = $("#ddlLocation :selected").val();
                var pStatus = $("#ddlStatus :selected").val();
                var frm = document.getElementById('txtFrom').value;
                var to = document.getElementById('txtTo').value;
                var today = "";
                var today1 = "";
                if (frm.indexOf('-') > 0) {
                    today = document.getElementById('txtFrom').value.split(' ')[0].split('-');
                }
                else {
                    today = document.getElementById('txtFrom').value.split(' ')[0].split('/');
                }
                var dd = today[0];
                var mm = today[1];
                var yyyy = today[2];
                var pFromDate = mm + '/' + dd + '/' + yyyy;
                if (to.indexOf('-') > 0) {
                    today1 = document.getElementById('txtTo').value.split(' ')[0].split('-');
                }
                else {
                    today1 = document.getElementById('txtTo').value.split(' ')[0].split('/');
                }
                //var today1 = document.getElementById('txtTo').value.split(' ')[0].split('-');
                var dd1 = today1[0];
                var mm1 = today1[1];
                var yyyy1 = today1[2];
                var pToDate = mm1 + '/' + dd1 + '/' + yyyy1;
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetPatientStatusDetails",
                    contentType: "application/json; charset=utf-8",
                    data: "{'pFromDate' : '" + pFromDate + "','pToDate': '" + pToDate + "',pUserId: " + pProcessedBy + ",pLocationId:" + pLocation + ",'pLabNumber':'" + pLabNumber + "','pStatus': '" + pStatus + "'}",
                    dataType: "json",
                    success: AjaxGetFieldDataSucceeded,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#example').hide();
                        pop.hide();
                        return false;
                    }
                });
            }
            catch (e) {
                pop.hide();
            }
        }

        function AjaxGetFieldDataSucceeded(result) {
            var pop = $find("mdlPopup1");
            var oTable;
            if (result != "[]") {
                // spanArray = [];
                //spanArray.push(result);
                oTable = $('#example').dataTable({
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    "aaData": result.d,
                    "fnStandingRedraw": function() { pop.show(); },
                    "aoColumns": [
                                { "mDataProp": "Name" },
                                { "mDataProp": "ExternalPatientNumber" },
                                { "mDataProp": "CompressedName" },
                                { "mDataProp": "Status" },
                                { "mDataProp": "AliasName" },
                                { "mDataProp": "RelationName",
}],
                    "sPaginationType": "full_numbers",
                    "aaSorting": [[0, "asc"]],
                    "bJQueryUI": true,
                    "iDisplayLength": 100,
                    "sDom": '<"H"Tfr>t<"F"ip>',
                    "oTableTools": {
                        "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                        "aButtons": [
                           "copy", "csv", "xls", "pdf",
                            {
                                "sExtends": "collection",
                                "sButtonText": "Save",
                                "aButtons": ["csv", "xls", "pdf"]
                            }
                        ]
                    }
                });
                $('#example').show();
                pop.hide();
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
<%--
                        <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

                        <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>

                        <div class="searchPanel">
                            <table class="">
                                <tr>
                                    <td style="color: #000;width: 330px; margin-top: 30px;" class="colorforcontent a-left h-30 bold">
                                        <div id="ACXplussmp" style="display: none;" runat="server">
                                            <img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top pointer"
                                                onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',1); " />
                                            <span class="dataheader1txt pointer" style="color: #000;" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',1); ">
                                                <asp:Label ID="lblStaussearchshow" Text="Approval History" runat="server"></asp:Label></span>
                                        </div>
                                        <div id="ACXminussmp" style="display: block;" runat="server">
                                            <img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top pointer" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',0); " />
                                            <span class="dataheader1txt pointer" style="color: #000;" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',0); ">
                                                &nbsp;
                                                <asp:Label ID="lblStaussearchhide" Text="Approval History" runat="server"></asp:Label></span>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch">
                                <div id="DivSearchArea" class="filterdataheader2" style="display: block;">
                                    <%--<asp:UpdateProgress ID="upProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                                        <ProgressTemplate>
                                            <div id="progressBackgroundFilter">
                                            </div>
                                            <div align="center" id="processMessage" style="width: 15%">
                                                <asp:Label ID="Rs_Pleasewait1" Text="Please wait... " runat="server" Font-Bold="true"
                                                    Font-Size="Larger" />
                                                <br />
                                                <br />
                                                <asp:Image ID="imgProgressbar1" runat="server" ImageUrl="~/Images/ProgressBar.gif" />
                                            </div>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>---%>
                                    <ajc:ModalPopupExtender ID="mdlPopup1" runat="server" BackgroundCssClass="blur" TargetControlID="pnlPopup1"
                                        PopupControlID="pnlPopup1" />
                                    <asp:Panel ID="pnlPopup1" runat="server">
                                        <ProgressTemplate>
                                            <div id="progressBackgroundFilter" class="a-center">
                                            </div>
                                            <div id="processMessage" class="a-center w-20p">
                                                <asp:Image ID="Image1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                            </div>
                                        </ProgressTemplate>
                                    </asp:Panel>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <%--<asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <div id="progressBackgroundFilter">
                                                    </div>
                                                    <div class="loading" style="position: fixed; top: 50%; left: 50%; margin-left: -32px; margin-top: -32px; display: block;
                                                        z-index: 9999;" align="center">
                                                        Loading...<br />
                                                        <br />
                                                        <img src="../Images/loader.gif" alt="" />
                                                    </div>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>--%>
                                            <table class="w-60p marginT10" id="ACXresponsessmp1" style="display: block; height: 110px;">
                                                <tr id="Tr1" class="tablerow" runat="server">
                                                    <td class="font12">
                                                        <asp:Label ID="lblLabNumber" class="style1" runat="server" Text="Lab Number"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtLabNumber" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td class="font12">
                                                        <asp:Label ID="lblLocation" class="style1" runat="server" Text="Location"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span class="richcombobox">
                                                            <asp:DropDownList ID="ddlLocation" CssClass="ddlsmall" runat="server">
                                                            </asp:DropDownList>
                                                        </span>
                                                    </td>
                                                    <td class="font12">
                                                        <asp:Label ID="lblStatus" class="style1" runat="server" Text="Status"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span class="richcombobox">
                                                            <asp:DropDownList ID="ddlStatus" CssClass="ddlsmall" runat="server" onchange="changeLbl()">
                                                            </asp:DropDownList>
                                                        </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="font12">
                                                        <asp:Label runat="server" ID="lblFromdate" Text="From Date" class="style1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" ID="txtFrom" CssClass="Txtboxsmall" MaxLength="23" size="25"></asp:TextBox>
                                                        <a id="txtFromFormat" runat="server">
                                                            <img src="../images/Calendar_scheduleHS.png" id="img3" alt="Pick a date" align="middle"></a>
                                                        <%--<a href="javascript:NewCssCal('<% =txtFrom.ClientID %>','ddmmyyyy','arrow',true,12,'Y','N')">
                                                            <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>--%>
                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                    <td class="font12">
                                                        <asp:Label runat="server" ID="lblToDate" Text="To Date" class="style1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" ID="txtTo" CssClass="Txtboxsmall" MaxLength="23" size="25"></asp:TextBox>
                                                        <a id="txtToFormat" runat="server">
                                                            <img src="../images/Calendar_scheduleHS.png" id="img1" alt="Pick a date" align="middle"></a>
                                                        <%--<a href="javascript:NewCssCal('<% =txtTo.ClientID %>','ddmmyyyy','arrow',true,12,'Y','N')">
                                                            <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>--%>
                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                    <td class="font12">
                                                        <asp:Label ID="lblProcessedBy" class="style1" runat="server"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span class="richcombobox">
                                                            <asp:DropDownList ID="ddlProcessedBy" CssClass="ddlsmall" runat="server">
                                                            </asp:DropDownList>
                                                        </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                    </td>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnSearch" Font-Bold="true" runat="server" Text="Search" OnClientClick="GetData();"
                                                            CssClass="btn" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </asp:Panel>
                        </div>
                        <div>
                            <div id="printDiv" runat="server">
                                <table id="example" style="display: none;">
                                    <thead>
                                        <tr>
                                            <th class="a-left">
                                                Patient Name
                                            </th>
                                            <th class="a-left">
                                                Lab Number
                                            </th>
                                            <th class="a-left">
                                                Investigation Name
                                            </th>
                                            <th class="a-left">
                                                Status
                                            </th>
                                            <th class="a-left">
                                                User Name
                                            </th>
                                            <th class="a-left">
                                                Date And Time
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
              
        <asp:HiddenField ID="hdnOrgID" runat="server" />
        <asp:HiddenField ID="hdnRoleID" runat="server" />
        <asp:HiddenField ID="hdnLID" runat="server" />
        <Attune:Attunefooter ID="Attunefooter" runat="server" />   
        <asp:HiddenField ID="hdnSelectedValue" runat="server" />
   
<%--
    <script src="../Scripts/JsonScript.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>
--%>
    </form>
<%--
    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>--%>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

</body>
</html>
<script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>