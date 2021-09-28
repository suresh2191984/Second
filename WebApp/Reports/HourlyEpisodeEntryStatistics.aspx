<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HourlyEpisodeEntryStatistics.aspx.cs" Inherits="Reports_HourlyBasedStatsReport"
EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/TRFUpload.ascx" TagName="ViewTRFImage" TagPrefix="TRF" %>
<%@ Register Src="../CommonControls/DateSelection.ascx" TagName="DateSelection" TagPrefix="uc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hourly Episode Entry Statistics </title>
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


        function Validate() {

            if (document.getElementById("<%=txtFrom.ClientID %>").value == "") {
                alert('Select FromDate');
                return false;
            }
            else if (document.getElementById("<%=txtTo.ClientID %>").value == "") {
                alert('Select ToDate');
                return false;
            }
            
            var FromDate = document.getElementById('<%= txtFrom.ClientID %>').value;
            var ToDate = document.getElementById('<%= txtTo.ClientID %>').value;
            var D1 = new Date(FromDate);
            var D2 = new Date(ToDate);
            var today = new Date();
            var tempBookFromDate = FromDate.split('/');
            var Rearranged_Fromdate = tempBookFromDate[1] + '/' + tempBookFromDate[0] + '/' + tempBookFromDate[2];
            var Rearranged_D1 = new Date(Rearranged_Fromdate);
            var CurMinitue = today.getMinutes();
            difference_in_minitue = today - Rearranged_D1;
            difference_in_milliseconds = D2 - D1;

            if (difference_in_milliseconds < 60000 && difference_in_milliseconds != 0) {
                alert("Kindly Choose Future Date !");
                return false;

            }
        }
            
//            var tempBookToDate = ToDate.split('/');
//            var Rearranged_Fromdate1 = tempBookToDate[1] + '/' + tempBookToDate[0] + '/' + tempBookToDate[2];
//            var Rearranged_D2 = new Date(Rearranged_Fromdate1);

//            else if (Rearranged_D2 > today) {
//                alert('Invalid');
//            }         
       
          
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                        <table class="paddingL10">
                            <tr>
                                <td class="h-23 bold a-left colorforcontent" style="color: #000; width: 330px; margin-top: 30px;">
                                    <div id="ACXplussmp" style="display: none;" runat="server">
                                        <img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top pointer"
                                            onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',1); " />
                                        <span class="dataheader1txt pointer" style="color: #000;" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',1); ">
                                            <asp:Label ID="lblStaussearchshow" Text="Investigation Values Report" runat="server"></asp:Label></span>
                                    </div>
                                    <div id="ACXminussmp" style="display: block;" runat="server">
                                        <img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top pointer" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',0); " />
                                        <span class="dataheader1txt pointer" style="color: #000;" onclick="showResponses('ACXplussmp','ACXminussmp','ACXresponsessmp1',0); ">
                                            &nbsp;
                                            <asp:Label ID="lblStaussearchhide" Text="Hourly Episode Entry Statistics " runat="server"></asp:Label></span>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table id="ACXresponsessmp1" class="filterdataheader2 searchPanel">
                            <tr>
                                <td class="defaultfontcolor" style="padding-left: 20px;">
                                    <asp:Label ID="lblFrom" Text="From" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFrom" runat="server" CssClass="Txtboxsmall" TabIndex="4"></asp:TextBox>
                                    <a href="javascript:NewCssCal('txtFrom','ddmmyyyy','arrow')">
                                    
                                        <img src="../images/Calendar_scheduleHS.png" id="img3" alt="Pick a date" align="middle"></a>
                                </td>
                                <td class="defaultfontcolor paddingL10">
                                    <asp:Label ID="lblTo" Text="To" runat="server" meta:resourcekey="lblToResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtTo" runat="server" TabIndex="5" CssClass="Txtboxsmall"></asp:TextBox>
                                    <a href="javascript:NewCssCal('txtTo','ddmmyyyy','arrow')">
                                        <img src="../images/Calendar_scheduleHS.png" id="img1" alt="Pick a date" align="middle" ></a>
                                </td>
                                
                               
                                <td class="paddingL10" style="padding-right: 20px;">
                                 
                               <%--  <asp:LinkButton Text='<%#Eval("ReportDisplayText")%>' CommandName='<%#Eval("ReportID")%>'
                                   ID="btnExportXL" runat="server" OnClick="btnExportXL_Click" ></asp:LinkButton>--%>
                               
                                    <%--<asp:LinkButton ID="btnExportXL" runat="server" Text="Export TO Excel" ForeColor="#000333" 
                                        OnClientClick="return Validate()" onclick="btnExportXL_Click" />--%>
                                        <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF" 
                                        OnClientClick="return Validate()"
                                        Visible="True" ToolTip="Save As Excel" OnClick="btnExportXL_Click" 
                                        meta:resourcekey="imgBtnXLResource1" style="width: 16px" />
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
                                    
                                </td>
                            </tr>
                        </table>
                       <%-- <div class="scrollcss" style="width: 1300px; height: auto" id="divgrd" runat="server">
                            <asp:GridView ID="grdReport" runat="server" AllowPaging="true" CellSpacing="1" class="mytable1" 
                                CellPadding="1" AutoGenerateColumns="true">
                                <HeaderStyle CssClass="dataheader1" />
                            </asp:GridView>
                            <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" Text="No Matching Records Found!"></asp:Label>
                        </div>--%>
              
       
    </div>
     <input type="hidden" id="hdnOrgID" runat="server" value="0" />
        <Attune:Attunefooter ID="Attunefooter" runat="server" />

<%--    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>--%>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    </form>
</body>
</html>
