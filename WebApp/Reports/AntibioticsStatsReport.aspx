<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AntibioticsStatsReport.aspx.cs"
    Inherits="Reports_AntibioticsStatsReport" EnableEventValidation="false" %>

<%--<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="~/CommonControls/TRFUpload.ascx" TagName="ViewTRFImage" TagPrefix="TRF" %>
<%@ Register Src="../CommonControls/DateSelection.ascx" TagName="DateSelection" TagPrefix="uc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Antibiotics STATS Report</title>
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
    </style>
    <%--  <script src="../Scripts/ScrollableGridPlugin_ASP.NetAJAX_2.0.js" type="text/javascript"></script>--%>
    <%--    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>--%>
    <%--    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>--%>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_page.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_table.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_table_jui.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery-ui-1.8.4.custom.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript">
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
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <table class="w-100p">
        <tr>
            <td>
                <div id="ViewTRF" runat="server" style="display: none">
                    <TRF:ViewTRFImage ID="TRFUC" runat="server" />
                </div>
            </td>
        </tr>
    </table>
    <div class="contentdata">
    <table class="searchPanel w-100p">
    <tr>
    <td>
        <table class="paddingL10">
            <tr>
                <td class="h-23 a-left colorforcontent" style="color: #000; width: 330px;
                    font-weight: bolder; margin-top: 30px;">
                    <div id="ACXplussmp" style="display: none;" runat="server">
                        <img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top" style="cursor: pointer"
                            onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',1); " />
                        <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',1); ">
                            <asp:Label ID="lblStaussearchshow" Text="Investigation Values Report" runat="server"></asp:Label></span>
                    </div>
                    <div id="ACXminussmp" style="display: block;" runat="server">
                        <img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top" style="cursor: pointer"
                            onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',0); " />
                        <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',0); ">
                            &nbsp;
                            <asp:Label ID="lblStaussearchhide" Text="Antibiotics Stats Report" runat="server"></asp:Label></span>
                    </div>
                </td>
            </tr>
        </table>
        <table id="ACXresponsessmp1" class="filterdataheader2 marginL10">
            <tr>
                <td class="defaultfontcolor"style="padding-left: 20px;">
                    <asp:Label ID="lblFrom" Text="From" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtFrom" MaxLength="25" TabIndex="4" size="20" CssClass="small"></asp:TextBox>
                    <a href="javascript:NewCssCal('<% =txtFrom.ClientID %>','ddmmyyyy','arrow',true,24,'N','Y')">
                        <img src="../images/Calendar_scheduleHS.png" id="imgCalc" alt="Pick a date" class="v-middle"></a>
                </td>
                <td class="defaultfontcolor paddingL10">
                    <asp:Label ID="lblTo" Text="To" runat="server" meta:resourcekey="lblToResource1"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtTo" runat="server" TabIndex="5" CssClass="small"></asp:TextBox>
                    <a href="javascript:NewCssCal('txtTo','ddmmyyyy','arrow',true,24)">
                        <img src="../images/Calendar_scheduleHS.png" id="img1" alt="Pick a date" class="v-middle"></a>
                </td>
                <td class="w-10p paddingL10">
                    <asp:Label ID="lblClientname" runat="server" Text="ClientName"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtClientName" runat="server" autocomplete="off" CssClass="AutoCompletesearchBox small"
                        TabIndex="6" onchange="SetClientID()"></asp:TextBox>
                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                        MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientList"
                        OnClientItemSelected="SetClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                        OnClientItemOver="SelectedOver" Enabled="True">
                    </cc1:AutoCompleteExtender>
                </td>
                <td class="paddingL10" style="padding-right: 20px;">
                    <asp:Button ID="btnsearch" runat="server" Text="Search" CssClass="btn" OnClick="btnsearch_Click"
                        OnClientClick="return Validate()" />
                    <%--<input id="btnSearch" font-bold="true" runat="server" value="Search" cssclass="btn"
                                        onclick="GetData();" width="60" height="30" type="button" onclick="return btnSearch_onclick()" />--%>
                </td>
            </tr>
        </table>
        <table class="w-60p">
            <tr>
                <td class="a-left paddingR10" style="color: #000000;">
                    <%-- <b id="printText" runat="server">
                                                        <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label>
                                                    </b>&nbsp;&nbsp;
                                                    <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint('prnReport');"
                                                        ToolTip="Print" meta:resourcekey="btnPrintResource1" />--%>
                    <asp:Label ID="lblExport" runat="server" Text="Export To Excel" Font-Bold="True"
                     Font-Names="Verdana" Font-Size="9pt" Visible="false"> </asp:Label>
                     &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                        Visible="false" ToolTip="Save As Excel" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                </td>
            </tr>
        </table>
        <div class="scrollcss" style="width: 1300px; height: auto" id="divgrd" runat="server">
            <asp:GridView ID="grdReport" runat="server" AllowPaging="true" CellSpacing="1" class="mytable1 gridView"
                OnPageIndexChanging="grdReport_PageIndexChanging" CellPadding="1" AutoGenerateColumns="true">
                <HeaderStyle CssClass="dataheader1" />
            </asp:GridView>
            <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" Text="No Matching Records Found!"></asp:Label>
        </div>
        </td>
        </tr>
        </table>
    </div>
    <input type="hidden" id="hdnOrgID" runat="server" value="0" />
    <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <%--
    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>--%>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>


    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    </form>
</body>
</html>
