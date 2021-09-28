<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BloodgroupCard.aspx.cs" Inherits="Reports_BloodgroupCard"
    EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/TRFUpload.ascx" TagName="ViewTRFImage" TagPrefix="TRF" %>
<%@ Register Src="../CommonControls/DateSelection.ascx" TagName="DateSelection" TagPrefix="uc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BloodGroupCard</title>
    <style type="text/css">
        /*To Set Vertical and Horzantal Scrollbars*/.scrollcss
        {
            overflow: auto;
            width: 350px;
            height: 150px;
        }
        /*To Set Only Vertical Scrollbar*/.verticalscroll
        {
            overflow-x: hidden;
            overflow-y: auto;
            width: 350px;
            height: 150px;
        }
        /*To Set only Horizontal Scrollbar*/.horizontalscroll
        {
            overflow-x: auto;
            overflow-y: hidden;
            width: 350px;
            height: 150px;
        }
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
            z-index: 1;
            text-align: center;
        }
        .modal
        {
            position: fixed;
            top: 0;
            left: 0;
            background-color: black;
            z-index: 100;
            opacity: 0.2;
            filter: alpha(opacity=80);
            -moz-opacity: 0.8;
            min-height: 100%;
            width: 100%;
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
    <%--  <script src="../Scripts/ScrollableGridPlugin_ASP.NetAJAX_2.0.js" type="text/javascript"></script>--%>

    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

   <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DataTable/demo_page.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DataTable/demo_table.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DataTable/demo_table_jui.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DataTable/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript">
        //        /***Added For Progress bar***/
        //        $(document).ready(function() {
        //            $('form').live("submit", function() {
        //                ShowProgress();
        //            });
        //        });
        //        /***Added For Progress bar***/
        function TempDate() {
            $j = jQuery.noConflict();
            $j("#txtFrom").datepicker({
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100'
            });
            $j("#txtTo").datepicker({
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100'
            })
        }
        function Validate() {
            if (document.getElementById("<%=txtFrom.ClientID %>").value == "") {
                alert('Select FromDate');
                return false;
            }
            else if (document.getElementById("<%=txtTo.ClientID %>").value == "") {
                alert('Select ToDate');
                return false;
            }
        }
        function GetBloodgroupcard() {
            //debugger;
            try {
                //var pop = $find("mdlPopup");
                $('#Modal1').show(); //pop.show();
                if (document.getElementById('txtFrom').value == '') {
                    alert('Select From Date!!!');
                    return false
                }
                if (document.getElementById('txtTo').value == '') {
                    alert('Select To Date!!!');
                    return false
                }
                var OrgID = document.getElementById('hdnOrgID').value;
                var RoleID = document.getElementById('hdnRoleID').value;
                var LID = document.getElementById('hdnLID').value;
                var frm = document.getElementById('txtFrom').value;
                var to = document.getElementById('txtTo').value;
                var RoundID = document.getElementById('hdnRoundID').value;
                //                alert($("#ddLocation option:selected").val());
                var Addressid = $("#ddLocation option:selected").val();
                var Addressidtext = $("#ddLocation option:selected").text();
                var RoundID = $("#ddRoundName option:selected").val();
           
                var RoundIDtext = $("#ddRoundName option:selected").text();
                var Addressid1 = $("#ddRoundName option:selected").val();
                if (Addressidtext == "-Select-") {
                    var Addressid = 0;
                }
                if (RoundIDtext == "-Select-") {
                    var RoundID = 0;
                }

                //                var Location = $("#ddLocation option:selected").val();
                var today = "";
                var today1 = "";
                var time = "";
                var time1 = "";
                if (frm.indexOf('-') > 0) {
                    today = document.getElementById('txtFrom').value.split(' ')[0].split('-');
                    time = document.getElementById('txtFrom').value.split(' ')[1].split(':');
                }
                else {
                    today = document.getElementById('txtFrom').value.split(' ')[0].split('/');
                    time = document.getElementById('txtFrom').value.split(' ')[1].split(':');
                }

                var dd = today[0];
                var mm = today[1];
                var yyyy = today[2];
                var HH = time[0];
                var min = time[1];
                var pFromDate = mm + '/' + dd + '/' + yyyy + ' ' + HH + ':' + min + ':00';
                //var pFromDate = mm + '/' + dd + '/' + yyyy;
                if (to.indexOf('-') > 0) {
                    today1 = document.getElementById('txtTo').value.split(' ')[0].split('-');
                    time1 = document.getElementById('txtTo').value.split(' ')[1].split(':');
                }
                else {
                    today1 = document.getElementById('txtTo').value.split(' ')[0].split('/');
                    time1 = document.getElementById('txtTo').value.split(' ')[1].split(':');
                }
                //var today1 = document.getElementById('txtTo').value.split(' ')[0].split('-');
                var dd1 = today1[0];
                var mm1 = today1[1];
                var yyyy1 = today1[2];
                var HH1 = time1[0];
                var min1 = time1[1];
                var pToDate = mm1 + '/' + dd1 + '/' + yyyy1 + ' ' + HH1 + ':' + min1 + ':00';
                //var pToDate = mm1 + '/' + dd1 + '/' + yyyy1;
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetBloodGrpCard",
                    contentType: "application/json; charset=utf-8",
                    data: "{ OrgID: " + OrgID + ",'fromdate' : '" + pFromDate + "','todate': '" + pToDate + "','Addressid': '" + Addressid + "','RoundID': '" + RoundID + "'}",
                    dataType: "json",
                    success: AjaxGetFieldDataSucceeded,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#tblBldGrp').hide();
                        //pop.hide();
                        $('#Modal1').hide();
                        return false;
                    }
                });

                // pop.hide();
            }
            catch (e) {
                //pop.hide();
                $('#Modal1').hide();
            }
        }
        function AjaxGetFieldDataSucceeded(result) {
            //debugger;
            //var pop = $find("mdlPopup");
            var oTable;
            if (result != "[]") {
                //                spanArray = [];
                //                spanArray.push(result);
                oTable = $('#tblBldGrp').dataTable({
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    //"serverSide": true,
                    "aaData": result.d,
                    "fnStandingRedraw": function() { pop.show(); },
                    "aoColumns": [
            { "mDataProp": "Patient_Name" },
            { "mDataProp": "Patient_ID" },
            { "mDataProp": "Result" },
            { "mDataProp": "Test_Date" },
            { "mDataProp": "Profiles" },
            { "mDataProp": "Orderer" },
            { "mDataProp": "Order_date_time" },
            { "mDataProp": "Visit" },
            { "mDataProp": "Analyte" },
            { "mDataProp": "Printed" },
            { "mDataProp": "Order_No"}],
                    "sPaginationType": "full_numbers",
                    "aaSorting": [],
                    "bJQueryUI": true,
                    "iDisplayLength": 20
                    //                    "sDom": '<"H"Tfr>t<"F"ip>',
                    //                    "oTableTools": {
                    //                        "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                    //                        "aButtons": [
                    //                            "copy", "csv", "xls", "pdf",
                    //                             {
                    //                                 "sExtends": "collection",
                    //                                 "sButtonText": "Save",
                    //                                 "aButtons": ["csv", "xls", "pdf"]
                    //                             }
                    //                          ]
                    //                    }
                });
                $('#tblBldGrp').show();
                $('#imgBtnXL').show();
                $('#lblExport').show();
                //document.getElementById('imgBtnXL').style.display = 'block';

                $('#Modal1').hide();
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
           <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       <table class="searchPanel">
                       <tr>
                       <td>
                         <table class="paddingL10">
                            <tr>
                                <td style="color: #000; width: 330px; font-weight: bolder; margin-top: 30px;" class="a-left colorforcontent">
                                    <div id="ACXplussmp" style="display: none;" runat="server">
                                        <img src="../Images/showBids.gif" alt="Show" class="pointer a-top h-15 w-15"
                                            onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',1); " />
                                        <span class="dataheader1txt pointer" style="color: #000;" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',1); ">
                                            <asp:Label ID="lblStaussearchshow" Text="Investigation Values Report" runat="server"></asp:Label></span>
                                    </div>
                                    <div id="ACXminussmp" style="display: block;" runat="server">
                                        <img src="../Images/hideBids.gif" alt="hide" class="pointer a-top h-15 w-15"
                                         onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',0); " />
                                        <span class="dataheader1txt pointer" style="color: #000;" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',0); ">
                                            &nbsp;
                                            <asp:Label ID="lblStaussearchhide" Text="Blood Group Card Details" runat="server"></asp:Label></span>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <asp:Panel ID="Panel1" runat="server" DefaultButton="btnsearch">
                            <div id="DivSearchArea" class="filterdataheader2" style="display: block;">
                                <cc1:ModalPopupExtender ID="mdlPopup" runat="server" BackgroundCssClass="blur" TargetControlID="pnlPopup"
                                    PopupControlID="pnlPopup" />
                                <asp:Panel ID="pnlPopup" runat="server" CssClass="progress" Style="display: none"
                                    BackImageUrl="~/Images/Loader.gif">
                                </asp:Panel>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <table class="w-85p" id="ACXresponsessmp1" style="display: block; height: 40px;">
                                            <tr>
                                                <td class="defaultfontcolor" style="padding-left: 20px;">
                                                    <asp:Label ID="lblFrom" Text="From Date" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFrom" runat="server" CssClass="Txtboxsmall" TabIndex="4"></asp:TextBox>
                                                    <a id="txtFromFormat" runat="server">
                                                        <img src="../images/Calendar_scheduleHS.png" id="img3" alt="Pick a date" align="middle"></a>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td class="defaultfontcolor paddingL10">
                                                    <asp:Label ID="lblTo" Text="To Date" runat="server" meta:resourcekey="lblToResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtTo" runat="server" TabIndex="5" CssClass="Txtboxsmall"></asp:TextBox>
                                                    <a id="txtToFormat" runat="server">
                                                        <img src="../images/Calendar_scheduleHS.png" id="img2" alt="Pick a date" align="middle"></a>
                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblLocation" Text="Location"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="ddLocation" AutoPostBack="false">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblRoundName" runat="server" Text="Round Name"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="ddRoundName" AutoPostBack="false">
                                                    </asp:DropDownList>
                                                </td>
                                                <%-- <td width="10%" style="padding-left: 10px;">
                                    <asp:Label ID="lblClientname" runat="server" Text="ClientName"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtClientName" runat="server" autocomplete="off" Width="130px" CssClass="AutoCompletesearchBox"
                                        TabIndex="6" onchange="SetClientID()"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                        MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientList"
                                        OnClientItemSelected="SetClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                        OnClientItemOver="SelectedOver" Enabled="True">
                                    </cc1:AutoCompleteExtender>
                                </td>--%>
                                                <td class="paddingL10" style="padding-right: 20px;">
                                                    <asp:Button ID="btnsearch" runat="server" Text="Search" CssClass="btn" OnClientClick="GetBloodgroupcard();" />
                                                    <%--<input id="btnSearch" font-bold="true" runat="server" value="Search" cssclass="btn"
                                        onclick="GetData();" width="60" height="30" type="button" onclick="return btnSearch_onclick()" />--%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <asp:UpdateProgress DynamicLayout="true" ID="UpdateProgress1" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter">
                                        </div>
                                        <div class="loading" style="position: fixed; top: 50%; left: 50%; margin-left: -32px;
                                            margin-top: -32px; display: block; z-index: 9999;" align="center">
                                            <asp:Image ID="img3" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <table class="w-60p">
                                    <tr>
                                        <td class="a-left paddingR10" style="color: #000000;">
                                          <asp:Label ID="lblExport" runat="server" Text="Export To Excel" Font-Bold="True"
                                            Font-Names="Verdana" Font-Size="9pt" Style="display: none;"> </asp:Label>
                                             &nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                Style="display: none;" ToolTip="Save As Excel" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                        <div class="scrollcss" style="width: 1300px; height: auto" id="divgrd" runat="server">
                            <table id="tblBldGrp" style="display: none;">
                                <thead>
                                    <tr>
                                        <th>
                                            <b>Patient name </b>
                                        </th>
                                        <th>
                                            <b>Patient ID </b>
                                        </th>
                                        <th>
                                            <b>Result </b>
                                        </th>
                                        <th>
                                            <b>Test date </b>
                                        </th>
                                        <th>
                                            <b>Profiles </b>
                                        </th>
                                        <th>
                                            <b>Orderer </b>
                                        </th>
                                        <th>
                                            <b>Order date/time </b>
                                        </th>
                                        <th>
                                            <b>Visit </b>
                                        </th>
                                        <th>
                                            <b>Analyte </b>
                                        </th>
                                        <th>
                                            <b>Printed </b>
                                        </th>
                                        <th>
                                            <b>Order No. </b>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        <div id="modal" class="modal" runat="server">
                            <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                             <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                            </div>
                        </div>
                       </td>
                       </tr>
                       </table>
                      
                   </div>
        <input type="hidden" id="hdnOrgID" runat="server" value="0" />
        <input type="hidden" id="hdnRoleID" runat="server" value="0" />
        <input type="hidden" id="hdnLID" runat="server" value="0" />
        <input type="hidden" id="hdnAddressid" runat="server" value="0" />
        <input type="hidden" id="hdnRoundID" runat="server" value="0" />
        <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
        
       <Attune:Attunefooter ID="Attunefooter" runat="server" /> 

    <%--<script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>--%>

    <script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <%--<script src="../Scripts/Loading.js" type="text/javascript"></script>--%>
    </form>
</body>
</html>
