<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillWiseDeptWiseCollectionSummary.aspx.cs"
    Inherits="Reports_BillWiseDeptWiseCollectionSummary" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>BillWise DeptWise CollectionSummary Report : OP / IP</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
       <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function validateToDate() {

            if (document.getElementById('txtFDate').value == '') {
                alert('Provide / select value for From date');
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                alert('Provide / select value for To date');
                document.getElementById('txtTDate').focus();
                return false;
            }
        }
        function popupprint() {
            var prtContent = document.getElementById('prnReport');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }

        function ShowColumns(obj) {
            $("#pnlColumns").slideToggle("slow");
            $("#lnkBtnSaveTemplate").slideToggle("slow");
            if (obj.value != "Hide") {
                obj.value = "Hide";
            }
            else {
                obj.value = "Show";
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnSubmit">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="RHead" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="" valign="top" id="menu" style="display: block;">
                    <div id="navigation" style="display: none;">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="100%" valign="top" class="tdspace">
                    <span>&nbsp;</span>
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                            <Triggers>
                                <asp:PostBackTrigger ControlID="lnkExportXL" />
                                <asp:PostBackTrigger ControlID="imgBtnXL" />
                            </Triggers>
                            <ContentTemplate>
                                <table id="tblCollectionOPIP" align="" cellpadding="0" cellspacing="0" border="0"
                                    width="99%">
                                    <tr>
                                        <td>
                                            <div class="dataheaderWider">
                                                <table id="tbl" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td align="left">
                                                            <asp:Label ID="Rs_From" Text="From :" runat="server" 
                                                                meta:resourcekey="Rs_FromResource1"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txtFDate" runat="server"  CssClass ="Txtboxsmall" Width="120px" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                            <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                                PopupButtonID="ImgFDate" Enabled="True" />
                                                            <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                                Mask="99/99/9999" MaskType="Date"
                                                                ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" 
                                                                meta:resourcekey="MaskedEditValidator5Resource1" />
                                                        </td>
                                                        <td align="left">
                                                            <asp:Label ID="Rs_To" Text="To :" runat="server" 
                                                                meta:resourcekey="Rs_ToResource1"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txtTDate" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                            <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                                PopupButtonID="ImgTDate" Enabled="True" />
                                                            <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgTDateResource1" />
                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                                Mask="99/99/9999" MaskType="Date"
                                                                ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                                ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" 
                                                                meta:resourcekey="MaskedEditValidator1Resource1" />
                                                        </td>
                                                        <td align="left">
                                                            <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" 
                                                                runat="server" meta:resourcekey="rblVisitTypeResource1">
                                                                <asp:ListItem Text="OP" Selected="True" Value="0" 
                                                                    meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                <asp:ListItem Text="OP&IP" Value="-1" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                        <td>
                                                            <asp:ImageButton ID="imgBtnXL" OnClientClick="if(getElementById('hdnXLFlag').value!='1' || getElementById('gvIPReport')== undefined ) { alert('No Records to Export');return false;} return true;"
                                                                runat="server" ImageUrl="../Images/ExcelImage.GIF" ToolTip="Save As Excel" OnClick="lnkExportXL_Click"
                                                                Style="width: 16px" meta:resourcekey="imgBtnXLResource1" />
                                                            <asp:LinkButton ID="lnkExportXL" Text="Export To XL" Font-Underline="True" OnClientClick="if(getElementById('hdnXLFlag').value!='1' || getElementById('gvIPReport')== undefined ) { alert('No Records to Export');return false;} return true;"
                                                                runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black"
                                                                ToolTip="Save As Excel" OnClick="lnkExportXL_Click" 
                                                                meta:resourcekey="lnkExportXLResource1"></asp:LinkButton>
                                                            <input type="hidden" runat="server" value="0" id="hdnXLFlag" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                                OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                        </td>
                                                        <td align="left">
                                                            <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                                OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6" align="left">
                                                            <asp:Panel ID="pnlColumns" Style="display: none;" Font-Bold="True" runat="server"
                                                                GroupingText="Column" Width="600px" meta:resourcekey="pnlColumnsResource1">
                                                                <asp:CheckBoxList ID="chkColumns" runat="server" RepeatColumns="7" 
                                                                    CellSpacing="5" meta:resourcekey="chkColumnsResource1">
                                                                </asp:CheckBoxList>
                                                            </asp:Panel>
                                                        </td>
                                                        <td align="right">
                                                            <table>
                                                                <tr>
                                                                    <td runat="server" id="tdShow" style="border-color: Green; border-width: medium;"
                                                                        align="right">
                                                                        <input type="button" onclick="javascript:ShowColumns(this);" value="Show" style="color: #006600;
                                                                            width: 90px; border-width: 1px; border-color: #006600; background-color: Transparent;" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="border-color: Green; border-width: medium;" align="center">
                                                                        <asp:LinkButton Width="90px" BorderColor="#006600" ForeColor="#006600" BorderWidth="1px"
                                                                            ID="lnkBtnRefresh" runat="server" Text="Print" OnClick="lnkBtnRefresh_Click"
                                                                            
                                                                            OnClientClick="if(getElementById('hdnXLFlag').value!='1' || getElementById('gvIPReport')== undefined ) { alert('No Records to Print');return false;} return true;" 
                                                                            meta:resourcekey="lnkBtnRefreshResource1"></asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="border-color: Green; border-width: medium;" align="right">
                                                                        <asp:Button Style="color: #006600; width: 90px; display: none; border-width: 1px;
                                                                            border-color: #006600; background-color: Transparent;" ID="lnkBtnSaveTemplate"
                                                                            runat="server" Text="Set As Default" OnClick="lnkBtnSaveTemplate_Click" 
                                                                            meta:resourcekey="lnkBtnSaveTemplateResource1" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <asp:UpdateProgress ID="Progressbar" runat="server">
                                    <ProgressTemplate>
                                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" 
                                            meta:resourcekey="imgProgressbarResource1" />
                                        <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" 
                                            meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <div id="divPrint" style="display: none;" runat="server">
                                    <table cellpadding="0" cellspacing="0" border="0" width="80%">
                                        <tr>
                                            <td align="right" style="padding-right: 10px; color: #000000;">
                                                <b id="printText" runat="server"><asp:Label ID="Rs_PrintReport" 
                                                    Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                                <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                    ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                               
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td>
                                                <asp:GridView ID="gvIPReport" runat="server" Visible="False" AllowPaging="True" PageSize="30"
                                                    OnPageIndexChanging="gvIPReport_PageIndexChanging" CellPadding="1" EmptyDataText="Collection Details Not Available"
                                                    OnRowDataBound="gvIPReport_RowDataBound" Font-Names="verdana" Font-Size="11px"
                                                    ShowFooter="True" Width="100%" meta:resourcekey="gvIPReportResource1">
                                                    <FooterStyle CssClass="dataheader1" HorizontalAlign="Right" Height="25px" />
                                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                    <HeaderStyle CssClass="dataheader1" Height="25px" />
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                <div id="divPrintNew" runat="server" style="display: none; background-color: White;
                                    width: 600px; height: 400px; overflow-y: auto; overflow-x: auto">
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>

<script language="javascript" type="text/javascript">
    function printPopUp(DivPrintID) {
        var objDivPrint = document.getElementById(DivPrintID);
        var testwindow = window.open("", "mywindow", "location=no, directories=no, status=no, menubar=no, scrollbars=1, resizable=no, copyhistory=no,width=" + screen.width.toString() + ",height=" + screen.height + "");
        testwindow.document.write(objDivPrint.innerHTML);
        testwindow.document.close();
        testwindow.moveTo(0, 0);
        testwindow.focus();
        testwindow.print();
        //testwindow.close();


    }

    function ConvertToTable(attXML) {
        var divAttribute = document.getElementById(id);
        // var lblAction = document.getElementById(actionID);

        if (document.getElementById(actionID).value != "[-]") {
            if (window.DOMParser) {
                parser = new DOMParser();
                xmlDoc = parser.parseFromString(attXML, "text/xml");
            }
            else {
                xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                xmlDoc.async = "false";
                xmlDoc.loadXML(attXML);
            }
            var str = "<table border='1px' class='dataheaderInvCtrl'>";
            var x = xmlDoc.getElementsByTagName("AttributeValues");
            str += "<thead><th>ProductNo</th><th>SerialNo</th><th>OtherValue</th><th style='width:75px'>Usage</th><th>UsedSoFor</th></thead>";
            for (i = 0; i < x.length; i++) {
                for (j = 0; j < x[i].childNodes.length; j++) {

                    str += "<tr><td>" + x[i].getElementsByTagName("Units")[j].getAttribute("ProductNo") + "</td>";
                    str += "<td>" + x[i].getElementsByTagName("Units")[j].getAttribute("SerialNo") + "</td>";
                    str += "<td>" + x[i].getElementsByTagName("Units")[j].getAttribute("OtherValue") + "</td>";
                    if (x[i].getElementsByTagName("Units")[j].getAttribute("IsIssued") == 'Y') {
                        str += "<td style='width:100px'>" + "EXCEEDED" + "</td>";
                    } else {
                        str += "<td style='width:100px'>" + "NOTEXCEEDED" + "</td>";
                    }
                    str += "<td>" + x[i].getElementsByTagName("Units")[j].getAttribute("UsedSoFor") + "</td></tr>";
                }
            }
            str += "</table>";
            divAttribute.innerHTML = str;
            document.getElementById(actionID).value = "[-]";
            document.getElementById(actionID).innerText = "[-]";
            document.getElementById(id).style.display = "block";
        }
        else {
            document.getElementById(id).style.display = "none";
            document.getElementById(actionID).value = "[+]";
            document.getElementById(actionID).innerText = "[+]";
        }
    }
    function doToggle(id, actionID) {
        var divAttribute = document.getElementById(id);
        if (document.getElementById(actionID).value != "[-]") {
            document.getElementById(actionID).value = "[-]";
            document.getElementById(actionID).innerText = "[-]";
            document.getElementById(id).style.display = "block";
        }
        else {
            document.getElementById(id).style.display = "none";
            document.getElementById(actionID).value = "[+]";
            document.getElementById(actionID).innerText = "[+]";
        }
    }
</script>

</html>
