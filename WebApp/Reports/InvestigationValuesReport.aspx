<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="InvestigationValuesReport.aspx.cs"
    Inherits="Lab_InvestigationValuesReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/TRFUpload.ascx" TagName="ViewTRFImage" TagPrefix="TRF" %>
<%@ Register Src="../CommonControls/DateSelection.ascx" TagName="DateSelection" TagPrefix="uc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Investigation Values Report</title>

<%--
    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>--%>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_page.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_table.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_table_jui.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery-ui-1.8.4.custom.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript">
        function GetData() {
     
            try {
                var pFromDate = document.getElementById("txtFrom").value;
                var pToDate = document.getElementById("txtTo").value;
                var pClientID = document.getElementById("hdnClientID").value;
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetInvestigationValuesReport",
                    contentType: "application/json; charset=utf-8",
                    data: "{'FromDate':'" + pFromDate + "','ToDate':'" + pToDate + "',ClientID:" + pClientID + "}",
                    dataType: "json",
                    success: AjaxGetFieldDataSucceeded,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#example').hide();
                        return false;
                    }
                });
            }
            catch (e) {

            }
        }

        function AjaxGetFieldDataSucceeded(result) {
            var oTable;
            if (result != "[]") {
                oTable = $('#example').dataTable({
                oLanguage: {
                    "sUrl": getLanguage()
                },
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "aaData": result.d,
                    "aoColumns": [
                    { "mDataProp": "ClientName" },
                    { "mDataProp": "CreatedAt"},
             
                    { "mDataProp": "PatientName" },
                    { "mDataProp": "ExternalVisitID" },
                    { "mDataProp": "GroupName" },
                    { "mDataProp": "InvestigationName" },
                    { "mDataProp": "Value" }
                     ],
                    "sPaginationType": "full_numbers",
                    "aaSorting": [[9, "asc"]],
                    "bJQueryUI": true,
                    "iDisplayLength": 15,
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
            }
        }

        function SelectedOver(source, eventArgs) {
            $find('AutoCompleteExtender1')._onMethodComplete = function(result, context) {
                //var Perphysicianname = document.getElementById('txtperphy').value;
                $find('AutoCompleteExtender1')._update(context, result, /* cacheResults */false);
                if (result == "") {
                    alert('Please select from the list');
                    document.getElementById('txtClientName').value = '';

                }
            };
        }
        function SetClientID(source, eventArgs) {
            var ClientID = 0;
            if (eventArgs != undefined) {
                ClientID = eventArgs.get_value();
                document.getElementById('<%=hdnClientID.ClientID %>').value = ClientID.split('|')[0];
            }
            else {
                document.getElementById('<%=hdnClientID.ClientID %>').value = ClientID;
            }
        }
    </script>

    <style type="text/css">
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
        .loading
        {
            font-family: Arial;
            font-size: 10pt;
            border: 5px solid #67CFF5;
            width: 150px;
            height: 70px;
            display: none;
            position: fixed;
            background-color: White;
            z-index: 999;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                      
                        <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" Text="No Matching Records Found!"
                            meta:resourcekey="lblStatusResource1"></asp:Label>
                        <table class="paddingL10">
                            <tr>
                                <td class="h-23 bold a-left colorforcontent" style="color: #000; width: 330px; margin-top: 30px;">
                                    <div id="ACXplussmp" style="display: none;" runat="server">
                                        <img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top pointer"
                                            onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',1); " />
                                        <span class="dataheader1txt pointer" style="color: #000;" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',1); ">
                                            <asp:Label ID="lblStaussearchshow" Text="Investigation Values Report" 
                                            runat="server" meta:resourcekey="lblStaussearchshowResource1"></asp:Label></span>
                                    </div>
                                    <div id="ACXminussmp" style="display: block;" runat="server">
                                        <img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top pointer" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',0); " />
                                        <span class="dataheader1txt pointer" style="color: #000;" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',0); ">
                                            &nbsp;
                                            <asp:Label ID="lblStaussearchhide" Text="Investigation Values Report" 
                                            runat="server" meta:resourcekey="lblStaussearchhideResource1"></asp:Label></span>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table id="ACXresponsessmp1" class="filterdataheader2 w-100p searchPanel">
                            <tr>
                                <td class="defaultfontcolor" style="padding-left:20px;">
                                    <asp:Label ID="lblFrom" Text="From" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtFrom" MaxLength="25" size="20" TabIndex="4" 
                                        CssClass="Txtboxsmall" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                   <a href="javascript:NewCssCal('<% =txtFrom.ClientID %>','ddmmyyyy','arrow',true,24,'N','Y')">
                                        <img src="../images/Calendar_scheduleHS.png" id="imgCalc" alt="Pick a date" align="middle" ></a>
                                 
                                </td>
                                <td class="defaultfontcolor paddingL10">
                                    <asp:Label ID="lblTo" Text="To" runat="server" meta:resourcekey="lblToResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtTo" runat="server" TabIndex="5" CssClass="Txtboxsmall" 
                                        meta:resourcekey="txtToResource1"></asp:TextBox>
                                    <a href="javascript:NewCssCal('txtTo','ddmmyyyy','arrow',true,12)">
                                        <img src="../images/Calendar_scheduleHS.png" id="img1" alt="Pick a date" align="middle"></a>
                                </td>
                                <td class="w-10p paddingL10">
                                    <asp:Label ID="lblClientname" runat="server" Text="ClientName" 
                                        meta:resourcekey="lblClientnameResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtClientName" runat="server" autocomplete="off" Width="130px" CssClass="AutoCompletesearchBox"
                                        TabIndex="6" onchange="SetClientID()" 
                                        meta:resourcekey="txtClientNameResource1"></asp:TextBox>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                        MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientList"
                                        OnClientItemSelected="SetClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                        OnClientItemOver="SelectedOver" Enabled="True">
                                    </cc1:AutoCompleteExtender>
                                </td>
                                <td class="paddingL10" style="padding-right:20px;">
                            <input id="btnSearch" font-bold="true" class="btn" runat="server" value="<%$ Resources:Investigation_AppMsg,Investigation_InvestigationStatusReport_aspx_17 %>" CssClass="btn" 
                                        onclick="GetData();" width="60" height="30" type="button" />
                              <%-- <asp:Button ID="btnSearch"   runat="server" Text="Search" CssClass="btn" 
                                   OnClientClick="javascript:GetData();"  />--%>
       
  
                                   
                                </td>
                            </tr>
                        </table>
                        <div id="printDiv" runat="server">
                            <table id="example" style="display: none">
                                <thead>
                                    <tr>
                                        <th class="a-left">
                                          <%=Resources.Reports_ClientDisplay.InvestigationValuesReport_aspx_01%>
                                         </th>
                                        <th class="a-left">
                                          <%=Resources.Reports_ClientDisplay.InvestigationValuesReport_aspx_02%>
                                        </th>
                                        <th class="a-left">
                                          <%=Resources.Reports_ClientDisplay.InvestigationValuesReport_aspx_03%>
                                        </th>
                                        <th class="a-left">
                                         <%=Resources.Reports_ClientDisplay.InvestigationValuesReport_aspx_04%>
                                        </th>
                                        <th align="left">
                                         <%=Resources.Reports_ClientDisplay.InvestigationValuesReport_aspx_05%>
                                        </th>
                                        <th class="a-left">
                                          <%=Resources.Reports_ClientDisplay.InvestigationValuesReport_aspx_06%>
                                        </th>
                                        <th class="a-left">
                                          <%=Resources.Reports_ClientDisplay.InvestigationValuesReport_aspx_07%>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />          
        <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
       
<%--    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>
--%>
    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    </form>
</body>
</html>
