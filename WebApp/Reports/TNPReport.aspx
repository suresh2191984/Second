<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TNPReport.aspx.cs" Inherits="Reports_TNPReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register src="../CommonControls/ErrorDisplay.ascx" tagname="ErrorDisplay" tagprefix="uc7" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">

    <script src="../Scripts/AdobeReaderDetection.js" type="text/javascript" language="javascript" />

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_page.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_table.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_table_jui.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery-ui-1.8.4.custom.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
    <title></title>
    <style type="text/css">
        .progress
        {
            width: 75px;
            height: 5px;
            background-color: Black;
            color: #ccc;
            padding: 10px;
        }
    </style>

    <script language="javascript" type="text/javascript">

        //        function GetData() {
        //            
        //            try {
        //                var pop = $find("mdlPopup");
        //                pop.show();
        //                if (document.getElementById('txtFromDate').value == '') {
        //                    alert('Select From Date!!!');
        //                    return false
        //                }
        //                if (document.getElementById('txtToDate').value == '') {
        //                    alert('Select To Date!!!');
        //                    return false
        //                }              
        //                
        //                var pFromDate = document.getElementById('txtFromDate').value;
        //                var pToDate = document.getElementById('txtToDate').value;
        //                var OrgID = document.getElementById('HdnOrgID').value;
        //                debugger;
        //                $.ajax({
        //                
        //                    type: "POST",
        //                    url: "../WebService.asmx/GetTNPReport",
        //                    contentType: "application/json; charset=utf-8",
        //                    data: "{ 'FromDate': '" + pFromDate + "','ToDate': '" + pToDate + "','orgid':'" + OrgID + "'}",
        //                    dataType: "json",
        //                    success: AjaxGetFieldDataSucceeded,
        //                    error: function(xhr, ajaxOptions, thrownError) {
        //                        alert("Error");
        //                        $('#example').hide();
        //                        pop.hide();
        //                        return false;
        //                    }
        //                });
        //                return false;
        //            }
        //            catch (e) {
        //                pop.hide();
        //            }

        //        }


        function validateToDate() {

            if (document.getElementById('txtFromDate').value == '') {
                alert('First You have Click and Get the Report');
                document.getElementById('txtFromDate').focus();
                return false;
            }
            if (document.getElementById('txtToDate').value == '') {
                alert('First You have Click and Get the Report');
                document.getElementById('txtToDate').focus();
                return false;
            }
        }
        function GetData() {

            try {

                if (document.getElementById('txtFromDate').value == '') {
                    alert('Select From Date!!!');
                    document.getElementById('txtFromDate').focus();
                    return false
                }
                if (document.getElementById('txtToDate').value == '') {
                    alert('Select To Date!!!');
                    document.getElementById('txtToDate').focus();
                    return false
                }

                var pop = $find("mdlPopup");
                pop.show();
                var pFromDate = document.getElementById('txtFromDate').value;
                var pToDate = document.getElementById('txtToDate').value;
                var OrgID = document.getElementById('HdnOrgID').value;
                //  debugger;
                $.ajax({

                    type: "POST",
                    url: "../WebService.asmx/GetTNPReport",
                    contentType: "application/json; charset=utf-8",
                    data: "{ 'FromDate': '" + pFromDate + "','ToDate': '" + pToDate + "','orgid':'" + OrgID + "'}",
                    dataType: "json",
                    success: AjaxGetFieldDataSucceeded,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#example').hide();
                        pop.hide();
                        return false;
                    }
                });
                return false;
            }
            catch (e) {
                pop.hide();
            }

        }


        function AjaxGetFieldDataSucceeded(result) {

            var pop = $find("mdlPopup");
            var oTable;

            if (result != "[]") {
                spanArray = [];
                spanArray.push(result);
                //alert(result);
                oTable = $('#example').dataTable({
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    "aaData": result.d,
                    "fnStandingRedraw": function() { pop.show(); },
                    "aoColumns": [
            { "mDataProp": "Patientvisitid" },
            { "mDataProp": "Name" },
            { "mDataProp": "VisitNumber" },
            { "mDataProp": "ID" },
            { "mDataProp": "TestName" },
            { "mDataProp": "SampleName" },
            { "mDataProp": "InvestigationValues" },
            // { "mDataProp": "ClientName" },  //ClientNam.... changed by nicho
            //  {"mDataProp": "Status" },       //Status... changed by nicho
                           {"mDataProp": "AmountReceived"} //

            ],
                    "sPaginationType": "full_numbers",
                    "aaSorting": [[0, "asc"]],
                    "bJQueryUI": true,
                    "iDisplayLength": 30,
                    //"sDom": 'T<"clear">lfrtip',
                    "sDom": '<"H"Tfr>t<"F"ip>',
                    "oTableTools": {
                        "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                        "aButtons": [
                        //    "copy", "csv", "xls", "pdf",

                              "xls", "pdf",
                             {
                                 "sExtends": "collection",
                                 "sButtonText": "",
                                 "aButtons": ["xls", "pdf"]
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
                </asp:ScriptManager>
                 <Attune:Attuneheader ID="Attuneheader" runat="server" />
                            <div class="contentdata TNPReport">
                                <ajc:ModalPopupExtender ID="mdlPopup" runat="server" BackgroundCssClass="blur" TargetControlID="pnlPopup"
                                    PopupControlID="pnlPopup" />
                                <asp:Panel ID="pnlPopup" runat="server" CssClass="progress" Style="display: none"
                                    BackImageUrl="~/Images/Loader.gif">
                                </asp:Panel>
                                <asp:UpdatePanel ID="up1" runat="server">
                                    <ContentTemplate>
                                        <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="up1" runat="server">
                                            <ProgressTemplate>
                                                <div id="progressBackgroundFilter">
                                                </div>
                                                <div align="center" id="processMessage">
                                                    <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" />
                                                    <br />
                                                    <br />
                                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                                                </div>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                        <div class="contentdata3">
                                         
                                            <asp:Panel ID="pnlsearch" runat="server" Width="100%">
                                                <table id="tblsearch" runat="server" width="100%" class="dataheaderInvCtrl searchPanel" cellpadding="5"
                                                    border="0">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="fromDate" runat="server" Text="TNP FromDate"></asp:Label>
                                                        </td>
                                                        <td style="z-index: 1000;">
                                                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                            <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" />
                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromDate"
                                                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                CultureTimePlaceholder="" Enabled="True" />
                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                ControlToValidate="txtFromDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" />
                                                            <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromDate"
                                                                Format="MM/dd/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="toDate" runat="server" Text="TNP ToDate"></asp:Label>
                                                        </td>
                                                        <td style="z-index: 1000;">
                                                            <asp:TextBox ID="txtToDate" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                            <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" />
                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender6" runat="server" TargetControlID="txtToDate"
                                                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                CultureTimePlaceholder="" Enabled="True" />
                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator6" runat="server" ControlExtender="MaskedEditExtender6"
                                                                ControlToValidate="txtToDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator6" />
                                                            <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToDate"
                                                                Format="MM/dd/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnSearch" runat="server" CssClass="btn" Text="Search" OnClientClick="javascript:return GetData()"
                                                                OnClick="btnSearch_Click" />
                                                            <%--   <asp:Label ID="Label3" Text="Export To Excel" Font-Bold="True" ForeColor="#000333"
                                                                    runat="server" Style="z-index: 1; left: 1176px; top: 144px; position: absolute"></asp:Label>--%>
                                                            <asp:ImageButton ID="ImageButton2" runat="server" OnClick="btnConverttoXL_Click"
                                                                Visible="false" OnClientClick="javascript:return validateToDate();" ImageUrl="~/Images/ExcelImage.GIF"
                                                                Style="z-index: 1; left: 1190px; top: 162px; position: absolute; width: 16px;" />
                                                        </td>
                                                        <%-- <td>
                                                            <div id="Export_XL" runat="server">
                                                                <asp:Label ID="Label3" Text="Export To Excel" Font-Bold="True" ForeColor="#000333"
                                                                    runat="server" Style="z-index: 1; left: 1176px; top: 144px; position: absolute"></asp:Label>
                                                                <asp:ImageButton ID="ImageButton2" runat="server" Visible="true" ImageUrl="~/Images/ExcelImage.GIF"
                                                                    Style="z-index: 1; left: 1284px; top: 146px; position: absolute" OnClick="btnConverttoXL_Click" />
                                                            </div>
                                                        </td>--%>
                                                        <td>
                                                            <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click">Back&nbsp;&nbsp;&nbsp;</asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <%--<tr>
                                                        <td width="80%">--%>
                                                <div id="divExamples" runat="server" width="80%">
                                                    <table id="example" width="80%" style="display: none;">
                                                        <thead>
                                                            <tr>
                                                                <th>
                                                                    visitid
                                                                </th>
                                                                <th>
                                                                    Name
                                                                </th>
                                                                <th>
                                                                    VisitNumber
                                                                </th>
                                                                <th>
                                                                    ID
                                                                </th>
                                                                <th>
                                                                    TestName
                                                                </th>
                                                                <th>
                                                                    SampleName
                                                                </th>
                                                                <th>
                                                                    InvestigationValues
                                                                </th>
                                                                <%-- <th>
                                                                    ClientName
                                                                </th>
                                                                <th>
                                                                    Status
                                                                </th>--%>
                                                                <th>
                                                                    AmountReceived
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                </td> </tr> </table>
                                            </asp:Panel>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        
                    <asp:HiddenField ID="HdnOrgID" runat="server" /> 
               <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>

<%--    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>--%>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

</body>
</html>
