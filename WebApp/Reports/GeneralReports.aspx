<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GeneralReports.aspx.cs"
    Inherits="Reports_GeneralReports" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="~/CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc10" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

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

        //        function extractRow(src) {
        //            var eRow = src.parentElement.parentElement;
        //            var RI = eRow.rowIndex;
        //            var GRTbl = document.getElementById("grdResult");
        //            document.getElementById('HdnitemOID').value = src.OrgID;
        //            document.getElementById('HdnitemOAID').value = src.orgaddressid;
        //            //  document.getElementById('txtTstName').value = GRTbl.rows[RI].cells[1].innerHTML;
        //        }

        function togglePannelStatus(content) {
            var expand = (content.style.display == "none");
            content.style.display = (expand ? "block" : "none");
            toggleChevronIcon(content);
        }

        var currentContent = null;

        function togglePannelAnimatedStatus(content, interval, step) {

            if (currentContent == null) {
                currentContent = content;
                var expand = (content.style.display == "none");
                if (expand)
                    content.style.display = "block";
                var max_height = content.offsetHeight;

                var step_height = step + (expand ? 0 : -max_height);
                toggleChevronIcon(content);


                content.style.height = Math.abs(step_height) + "px";
                setTimeout("togglePannelAnimatingStatus("
            + interval + "," + step
            + "," + max_height + "," + step_height + ")", interval);
            }
        }

        function toggleChevronIcon(content) {
            var chevron = content.parentNode.firstChild.childNodes[1].childNodes[0];
            var expand = (chevron.src.indexOf("expand.jpg") < 0);
            chevron.src = chevron.src
                .split(expand ? "expand.jpg" : "collapse.jpg")
                .join(expand ? "collapse.jpg" : "expand.jpg");
        }
        function togglePannelAnimatingStatus(interval, step, max_height, step_height) {
            var step_height_abs = Math.abs(step_height);

            // schedule next animated collapse/expand event
            if (step_height_abs >= step && step_height_abs <= (max_height - step)) {
                step_height += step;
                currentContent.style.height = Math.abs(step_height) + "px";
                setTimeout("togglePannelAnimatingStatus("
			+ interval + "," + step + "," + max_height + "," + step_height + ")", interval);
            }
            // animated expand/collapse done
            else {
                if (step_height_abs < step)
                    currentContent.style.display = "none";
                currentContent.style.height = "";
                currentContent = null;
            }
        }
             
    </script>

    <%--text-align: center;--%>
    <style type="text/css">
        .style1
        {
            width: 102px;
            height: 8px;
        }
        .style2
        {
            width: 737px;
        }
        .Grid
        {
            border: solid 1px #FFFFFF;
        }
        .Grid td
        {
            border: solid 1px #FFFFFF;
            margin: 1px 1px 1px 1px;
            padding: 1px 1px 1px 1px;
        }
        .GridHeader
        {
            font-weight: bold;
            font-size: larger;
            color: White;
            background-color: #3093cf;
        }
        .GridItem
        {
            background-color: #e6e6e6;
        }
        .GridAltItem
        {
            background-color: #3093cf;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc7:DocHeader ID="docHeader" runat="server" />
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
                        <div id="divInv" runat="server">
                            <asp:HiddenField ID="HdnID" runat="server" />
                            <asp:HiddenField ID="HdnitemOID" runat="server" />
                            <asp:HiddenField ID="HdnitemOAID" runat="server" />
                            <table class="dataheader2 defaultfontcolor" width="100%" id="casip">
                                <tr>
                                    <td class="style2" style="width: 350px;">
                                        <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                        <asp:TextBox ID="txtFDate" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                        <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgFDate"
                                            TargetControlID="txtFDate" Enabled="True" />
                                        <asp:ImageButton ID="ImgFDate" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            meta:resourcekey="ImgFDateResource1" />
                                        <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" ErrorTooltipEnabled="True"
                                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtFDate" CultureAMPMPlaceholder=""
                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                            Enabled="True" />
                                        <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                            ControlToValidate="txtFDate" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                            InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                    </td>
                                    <td class="style2">
                                        <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                        <asp:TextBox ID="txtTDate" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                        <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgTDate"
                                            TargetControlID="txtTDate" Enabled="True" />
                                        <asp:ImageButton ID="ImgTDate" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            meta:resourcekey="ImgTDateResource1" />
                                        <ajc:MaskedEditExtender ID="MaskedEditExtender6" runat="server" ErrorTooltipEnabled="True"
                                            Mask="99/99/9999" MaskType="Date" TargetControlID="txtTDate" CultureAMPMPlaceholder=""
                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                            Enabled="True" />
                                        <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender6"
                                            ControlToValidate="txtTDate" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                            InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style2" align="right">
                                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn" OnClick="btnSubmit_Click"
                                            OnClientClick="javascript:return validateToDate();" onmouseout="this.className='btn'"
                                            onmouseover="this.className='btn btnhov'" Text="Get Report" meta:resourcekey="btnSubmitResource1" />
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td>
                                    </td>
                                </tr>--%>
                            </table>
                            <table class="dataheader2 defaultfontcolor" width="100%" id="grdtbl">
                                <tr>
                                    <td style="width: 1300px;">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td colspan="4">
                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td colspan="4">
                                                                <table border="0" width="100%">
                                                                    <tr>
                                                                        <td colspan="5">
                                                                            <div id="DivParent">
                                                                                <asp:GridView ID="grdResult" Width="100%" runat="server" AutoGenerateColumns="False"
                                                                                    DataKeyNames="OrgID,OrgAddressID" ForeColor="#333333" CssClass="Grid"
                                                                                    OnSelectedIndexChanged="grdResult_SelectedIndexChanged" OnRowCommand="grdResult_RowCommand"
                                                                                    OnRowDataBound="grdResult_RowDataBound" class="evenforsurg" meta:resourcekey="grdResultResource1">
                                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="GridHeader" />
                                                                                    <Columns>
                                                                                        <asp:BoundField Visible="false" DataField="OrgID" meta:resourcekey="BoundFieldResource1" />
                                                                                        <asp:BoundField ItemStyle-VerticalAlign="Top" DataField="orgName" HeaderText=" Org Name"
                                                                                            meta:resourcekey="BoundFieldResource2">
                                                                                            <ItemStyle VerticalAlign="Top"></ItemStyle>
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField Visible="false" DataField="OrgAddressID" meta:resourcekey="BoundFieldResource3" />
                                                                                        <asp:BoundField ItemStyle-VerticalAlign="Top" DataField="orgLocName" HeaderText=" Location Name"
                                                                                            meta:resourcekey="BoundFieldResource4">
                                                                                            <ItemStyle VerticalAlign="Top"></ItemStyle>
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField ItemStyle-VerticalAlign="Top" DataField="totvisit" HeaderText="totvisit"
                                                                                            meta:resourcekey="BoundFieldResource5">
                                                                                            <ItemStyle VerticalAlign="Top"></ItemStyle>
                                                                                        </asp:BoundField>
                                                                                        <asp:TemplateField ItemStyle-VerticalAlign="Top" HeaderText="OP Visit" HeaderStyle-HorizontalAlign="Center"
                                                                                            meta:resourcekey="TemplateFieldResource1">
                                                                                            <ItemTemplate>
                                                                                                <div style="width: 230px;">
                                                                                                    <div style="height: 20px; cursor: pointer;" onclick="togglePannelStatus(this.nextSibling)">
                                                                                                        <div style="vertical-align: top;">
                                                                                                            <table border="0" align="left">
                                                                                                                <tr>
                                                                                                                    <td id="Td2" align="center" style="width: 60px;" nowrap="nowrap" valign="top">
                                                                                                                        <%# DataBinder.Eval(Container.DataItem, "oPvisit")%>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </div>
                                                                                                        <div style="float: right; vertical-align: top;">
                                                                                                            <img src="../Images/expand.jpg" width="13" height="14" border="0" alt="Show/Hide"
                                                                                                                title="Show/Hide" />
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <div id="Divop" style="width: auto; height: auto; display: none;">
                                                                                                        <asp:GridView ID="ChildGridOP" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                                                            CssClass="Grid" meta:resourcekey="ChildGridOPResource1">
                                                                                                            <Columns>
                                                                                                                <asp:BoundField DataField="visitpurposeName" HeaderText="visit purpose Name" meta:resourcekey="BoundFieldResource6">
                                                                                                                    <FooterStyle Font-Bold="True" />
                                                                                                                </asp:BoundField>
                                                                                                                <asp:BoundField DataField="visitCount" HeaderText="Visit Count" meta:resourcekey="BoundFieldResource7">
                                                                                                                    <ControlStyle Width="1px" />
                                                                                                                    <FooterStyle Font-Bold="True" />
                                                                                                                </asp:BoundField>
                                                                                                            </Columns>
                                                                                                            <RowStyle HorizontalAlign="Left" />
                                                                                                            <HeaderStyle CssClass="dataheader1" />
                                                                                                        </asp:GridView>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </ItemTemplate>
                                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                            <ItemStyle VerticalAlign="Top"></ItemStyle>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField ItemStyle-VerticalAlign="Top" HeaderText="IP Visit" HeaderStyle-HorizontalAlign="Center"
                                                                                            meta:resourcekey="TemplateFieldResource2">
                                                                                            <ItemTemplate>
                                                                                                <div style="width: 230px;">
                                                                                                    <div>
                                                                                                        <div style="height: 20px; cursor: pointer;" onclick="togglePannelStatus(this.nextSibling)">
                                                                                                            <div style="float: left; vertical-align: top;">
                                                                                                                <table>
                                                                                                                    <tr>
                                                                                                                        <td id="Td2" align="center" style="width: 60px;" nowrap="nowrap" valign="top">
                                                                                                                            <%# DataBinder.Eval(Container.DataItem, "iPvisit")%>
                                                                                                                        </td>
                                                                                                                    </tr>
                                                                                                                </table>
                                                                                                            </div>
                                                                                                            <div style="float: right; vertical-align: top">
                                                                                                                <img src="../Images/expand.jpg" width="13" height="14" border="0" alt="Show/Hide"
                                                                                                                    title="Show/Hide" />
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div style="display: none; height: auto; width: auto;">
                                                                                                            <asp:GridView ID="ChildGridIP" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                                                                CssClass="Grid" meta:resourcekey="ChildGridIPResource1">
                                                                                                                <Columns>
                                                                                                                    <asp:BoundField DataField="visitpurposeName" HeaderText="visit purpose Name" meta:resourcekey="BoundFieldResource8">
                                                                                                                        <FooterStyle Font-Bold="True" />
                                                                                                                    </asp:BoundField>
                                                                                                                    <asp:BoundField DataField="visitCount" HeaderText="Visit Count" meta:resourcekey="BoundFieldResource9">
                                                                                                                        <FooterStyle Font-Bold="True" />
                                                                                                                    </asp:BoundField>
                                                                                                                </Columns>
                                                                                                                <RowStyle HorizontalAlign="Left" />
                                                                                                                <HeaderStyle CssClass="dataheader1" />
                                                                                                            </asp:GridView>
                                                                                                            <asp:GridView ID="ChildGridDS" runat="server" Width="100%" AutoGenerateColumns="False"
                                                                                                                CssClass="Grid" meta:resourcekey="ChildGridDSResource1">
                                                                                                                <Columns>
                                                                                                                    <asp:BoundField DataField="DischargeSummaryCount" HeaderText="Discharge Summaries created"
                                                                                                                        meta:resourcekey="BoundFieldResource10">
                                                                                                                        <FooterStyle Font-Bold="True" />
                                                                                                                    </asp:BoundField>
                                                                                                                    <asp:BoundField DataField="PatientsDischarged" HeaderText="Patients Discharged" meta:resourcekey="BoundFieldResource11">
                                                                                                                        <FooterStyle Font-Bold="True" />
                                                                                                                    </asp:BoundField>
                                                                                                                </Columns>
                                                                                                                <RowStyle HorizontalAlign="Left" />
                                                                                                                <HeaderStyle CssClass="dataheader1" />
                                                                                                            </asp:GridView>
                                                                                                        </div>
                                                                                            </ItemTemplate>
                                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                            <ItemStyle VerticalAlign="Top"></ItemStyle>
                                                                                        </asp:TemplateField>
                                                                                    </Columns>
                                                                                </asp:GridView>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <%--<tr id="GrdFooter" runat="server" style="display:none" class="dataheaderInvCtrl">
                                <td align="center"  colspan="10" class="defaultfontcolor" >
                                 <asp:Label ID="Label1" runat="server"  Text="Page" ></asp:Label>
                                    <asp:Label ID="lblCurrent" runat="server" Font-Bold="true" ForeColor="Red"></asp:Label>
                                      <asp:Label ID="Label2" runat="server" Text="Of"></asp:Label>
                                    <asp:Label ID="lblTotal" runat="server" Font-Bold="true" ></asp:Label>
                                    <asp:Button ID="Btn_Previous" runat="server" Text="Previous" 
                                         CssClass="btn" onclick="Btn_Previous_Click"/>
                                    <asp:Button ID="Btn_Next" runat="server" Text="Next" CssClass="btn" 
                                        onclick="Btn_Next_Click"/>
                                    
                                    <asp:HiddenField ID="hdnCurrent" runat="server" />
                                     <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:"></asp:Label>
                                     <asp:TextBox ID="txtpageNo" runat="server" Width="30px"   onkeypress="return ValidateOnlyNumeric(this);"  ></asp:TextBox>
                                     <asp:Button ID="btnGo1" runat="server" Text="Go" 
                                         CssClass="btn" 
                                        onclick="btnGo_Click1"/>
                                </td>
                                </tr>--%>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td>
                                        <asp:GridView ID="grdOPdetails" Width="50%" runat="server" AllowPaging="false" CellSpacing="1"
                                            CellPadding="1" AutoGenerateColumns="False" ForeColor="#333333" CssClass="mytable1"
                                            OnSelectedIndexChanged="grdResult_SelectedIndexChanged">
                                            <Columns>
                                                <asp:BoundField DataField="visitpurposeName" HeaderText="VisitPurpose Name" FooterStyle-Font-Bold="True"
                                                    ControlStyle-Width="100" />
                                                <asp:BoundField DataField="visitCount" HeaderText="Visit Count" FooterStyle-Font-Bold="True" />
                                            </Columns>
                                            <RowStyle HorizontalAlign="Left" />
                                            <PagerStyle HorizontalAlign="Center" />
                                            <HeaderStyle CssClass="dataheader1" />
                                        </asp:GridView>
                                    </td>
                                    <td>
                                        <asp:GridView ID="grdIPdetails" Width="95%" runat="server" AllowPaging="false" CellSpacing="1"
                                            CellPadding="1" AutoGenerateColumns="False" ForeColor="#333333" CssClass="mytable1"
                                            OnSelectedIndexChanged="grdResult_SelectedIndexChanged">
                                            <Columns>
                                                <asp:BoundField DataField="visitpurposeName" HeaderText="VisitPurpose Name" FooterStyle-Font-Bold="True" />
                                                <asp:BoundField DataField="visitCount" HeaderText="Visit Count" FooterStyle-Font-Bold="True" />
                                            </Columns>
                                            <RowStyle HorizontalAlign="Left" />
                                            <PagerStyle HorizontalAlign="Center" />
                                        <headerstyle cssclass="dataheader1" />
                                        </asp:GridView>
                                    </td>
                                </tr>--%>
                            </table>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
