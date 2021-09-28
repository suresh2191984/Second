<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PhysicianWiseWardVisitReport.aspx.cs"
    Inherits="Reports_PhysicianWiseWardVisitReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Physician Wise Ward Visit Report</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
        <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript">
        var ddlText, ddlValue, ddl, lblMesg;
        function CacheItems() {
            ddlText = new Array();
            ddlValue = new Array();
            ddl = document.getElementById('ddlDrName');
            for (var i = 0; i < ddl.options.length; i++) {
                ddlText[ddlText.length] = ddl.options[i].text;
                ddlValue[ddlValue.length] = ddl.options[i].value;
            }
        }

        window.onload = CacheItems;


        function FilterItems(value) {
            value = value.toLowerCase();
            ddl.options.length = 0;
            for (var i = 0; i < ddlText.length; i++) {
                if (ddlText[i].toLowerCase().indexOf(value) != -1) {
                    AddItem(ddlText[i], ddlValue[i]);
                }
            }

            if (ddl.options.length == 0) {
                AddItem("No Physician Found", "");
            }
        }

        function AddItem(text, value) {
            var opt = document.createElement("option");
            opt.text = text;
            opt.value = value;
            ddl.options.add(opt);
        }
        function AddPhysician() {

            var ddlPhy = document.getElementById('ddlDrName');
            var ddlPhyLength = ddlPhy.options.length;
            for (var i = 0; i < ddlPhyLength; i++) {
                if (ddlPhy.options[i].selected) {


                    if (ddlPhy.options[i].text != '-----Show All-----') {

                        document.getElementById('txtNew').value = ddlPhy.options[i].text;

                    }

                }

            }
        }
    </script>

</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="AdminHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:Panel runat="server" CssClass="dataheader2" ID="pnlDate" Width="99%" meta:resourcekey="pnlDateResource1">
                            <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="height: 5px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table border="0" width="100%" cellpadding="4" cellspacing="0">
                                            <tr>
                                                <td align="right" style="width: 15%">
                                                    <asp:Label runat="server" ID="fromDate" Text="From Date" CssClass="label_title" meta:resourcekey="fromDateResource1"></asp:Label>
                                                </td>
                                                <td style="width: 35%;">
                                                    <asp:TextBox ID="txtFrom" runat="server" CssClass ="Txtboxsmall" Width ="120px" TabIndex="4" MaxLength="1"
                                                        Style="text-align: justify" ValidationGroup="MKE" meta:resourcekey="txtFromResource1" />
                                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImageButton1Resource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFrom"
                                                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                        Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                    <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFrom"
                                                        PopupButtonID="ImageButton1" Format="dd/MM/yyyy" Enabled="True" />
                                                </td>
                                                <td align="right" style="width: 15%;">
                                                    <asp:Label runat="server" ID="toDate" Text="To Date" CssClass="label_title" meta:resourcekey="toDateResource1"></asp:Label>
                                                </td>
                                                <td style="width: 35%">
                                                    <asp:TextBox ID="txtTo" runat="server" CssClass ="Txtboxsmall" Width ="120px" TabIndex="5" MaxLength="1" Style="text-align: justify"
                                                        ValidationGroup="MKE" meta:resourcekey="txtToResource1" />
                                                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImageButton2Resource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtTo"
                                                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                        Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                        ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourcekey="MaskedEditValidator2Resource1" />
                                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtTo"
                                                        PopupButtonID="ImageButton2" Format="dd/MM/yyyy" Enabled="True" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <table cellpadding="4" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="width: 15%;" align="right">
                                                    <asp:Label ID="Rs_SelectPhysician" Text="Select Physician" runat="server" meta:resourcekey="Rs_SelectPhysicianResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtNew" runat="server" ToolTip="Enter Text Here" onkeyup="FilterItems(this.value)" CssClass ="Txtboxsmall" Width ="120px"
                                                        onblur="AddPhysician()" meta:resourcekey="txtNewResource1" />
                                                    <asp:DropDownList runat="server" ID="ddlDrName" TabIndex="1"  CssClass ="ddlsmall"
                                                        meta:resourcekey="ddlDrNameResource1">
                                                    </asp:DropDownList>
                                                    <ajc:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtNew"
                                                        WatermarkText="Type Physician Name" Enabled="True" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Button runat="server" ID="btnGo" Text=" Go " CssClass="btn" TabIndex="6" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClick="btnGo_Click" meta:resourcekey="btnGoResource1" />
                                        &nbsp;
                                        <asp:Button ID="btnCancel" runat="server" Text="Reset" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                            onmouseout="this.className='btn1'" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />&nbsp;
                                        <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " 
                                            CssClass="details_label_age"  OnClick="lnkBack_Click" 
                                            meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 5px;">
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Label ID="lblResult" Font-Bold="True" ForeColor="#000333" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
                        <table id="excelTab" runat="server" cellpadding="5" style="display: none; color: #333;"
                            cellspacing="0" border="0" width="100%">
                            <tr>
                                <td align="right">
                                    <b>
                                        <asp:Label ID="Rs_ExportToExcel" Text="Export To Excel" runat="server" meta:resourcekey="Rs_ExportToExcelResource1"></asp:Label></b>&nbsp;&nbsp;&nbsp;
                                    <asp:ImageButton ID="btnXL" OnClick="btnXL_Click" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                        ToolTip="Save As Excel" meta:resourcekey="btnXLResource1" />
                                </td>
                            </tr>
                        </table>
                        <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                            CellPadding="4" CssClass="mytable1" OnPageIndexChanging="grdResult_PageIndexChanging"
                            PagerSettings-Mode="NextPrevious" Width="100%" meta:resourcekey="grdResultResource1">
                            <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <%-- <PagerTemplate>
                                <tr>
                                    <td align="center" colspan="6">
                                        <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="false" CommandArgument="Prev"
                                            CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" Width="18px" />
                                        <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="false" CommandArgument="Next"
                                            CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" Width="18px" />
                                    </td>
                                </tr>
                            </PagerTemplate>--%>
                            <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                PageButtonCount="5" PreviousPageText="" />
                            <HeaderStyle CssClass="dataheader1" />
                            <RowStyle Font-Bold="false" />
                            <%--<PagerSettings Mode="NextPrevious"></PagerSettings>--%>
                            <Columns>
                                <asp:BoundField DataField="Name" HeaderStyle-HorizontalAlign="Left" HeaderText="Physician Name"
                                    ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="35%" meta:resourcekey="BoundFieldResource1">
                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="DOB" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" HeaderStyle-HorizontalAlign="Left"
                                    HeaderText="Visit Date" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="14%"
                                    meta:resourcekey="BoundFieldResource2">
                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="25%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="CreatedBy" HeaderStyle-HorizontalAlign="Left" HeaderText="Quantity"
                                    ItemStyle-HorizontalAlign="Center" Visible="true" ItemStyle-Width="15%" meta:resourcekey="BoundFieldResource3">
                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="Comments" HeaderStyle-HorizontalAlign="Left" HeaderText="Ward / Room / Bed"
                                    ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="25%" meta:resourcekey="BoundFieldResource4">
                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
