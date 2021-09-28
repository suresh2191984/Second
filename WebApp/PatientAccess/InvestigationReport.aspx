<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationReport.aspx.cs"
    Inherits="Investigation_InvestigationReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/PatientAccessHeader.ascx" TagName="AdminHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientOrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

  <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript" src="../Scripts/Common.js"></script>

    <script type="text/javascript">

        function SelectVisit(id, vid, pid, PName, patOrgID) {
            chosen = "";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(id).checked = true;
            document.getElementById("hdnVID").value = vid;
            document.getElementById("hdnPID").value = pid;
            document.getElementById("hdnPNAME").value = PName;
            document.getElementById("patOrgID").value = patOrgID;
        }

        function CheckVisitID() {
            if (document.getElementById('hdnVID').value == '') {

                alert('Select visit detail');
                return false;
            }
            else {
                //alert(document.getElementById('ddlVisitActionName').options[document.getElementById('ddlVisitActionName').selectedIndex].value);
                if (document.getElementById('ddlVisitActionName').options[document.getElementById('ddlVisitActionName').selectedIndex].value != "0") {
                    document.getElementById('hdnVisitDetail').value = document.getElementById('ddlVisitActionName').options[document.getElementById('ddlVisitActionName').selectedIndex].innerHTML;
                    return true;
                }
                else {
                alert('Select any one of the action to proceed');
                    return false;
                }
            }
        }

        function ChechVisitDate() {

            if (document.getElementById('txtPatientNo').value != '' || document.getElementById('txtFrom').value != '' || document.getElementById('txtTo').value != '') {
                alert('Provide visit date');
                document.form1.txtFrom.focus();
                return false;
            }
            return true;
        }

        function ChechVisit() {

            //            if (document.getElementById('txtPatientNo').value == '') {
            //                alert('Please Enter Patient No');
            //                document.form1.txtPatientNo.focus();
            //                return false;
            //            }

            //            if (document.getElementById('txtPatientNo').value != '' || document.getElementById('txtFrom').value == '' && document.getElementById('txtTo').value == '') {

            //                alert('Please Enter Atlease One Search option');
            //                document.form1.txtPatientNo.focus();
            //                return false;
            //            }
            return true;

        }
        function ShowReportDiv() {

            // alert(document.getElementById('dReport'));
            document.getElementById('dReport').style.display = 'block';
            return false;
        }
        function HideDiv() {
            document.getElementById('dReport').style.display = 'none';
            document.getElementById('imgClick').style.display = 'block';
            document.getElementById('lblHead').style.display = 'block';
            return true;
        }

        function ChkIfSelected(obj) {
            // alert(obj);
            if (document.getElementById(obj).checked) {
                document.getElementById('ChkID').value = obj + '^';
            }
            else {
                //alert('else');
                document.getElementById('grdResultTemp_ctl00_chkSelectAll').checked = false;
                var x = document.getElementById('ChkID').value.split('^');
                document.getElementById('ChkID').value = '';
                for (i = 0; i < x.length; i++) {
                    if (x[i] != '') {
                        if (x[i] != obj) {
                            document.getElementById('ChkID').value = x[i] + '^';
                        }
                    }

                }
            }
        }
        function IsSelected() {
            if (document.getElementById('ChkID').value != '') {
                HideDiv();
                return true;
            }
            else {
                alert('Select an investigation to display  report');
            }
            return false;
        }
        function launchSessionUrl(launchurl) {
            //alert('hello : ' + launchurl);
            window.location.href = launchurl;

        }
        function SelectAll(IsChecked) {
            var chkArrayMain = new Array();
            chkArrayMain = document.getElementById('HdnCheckBoxId').value.split('~');
            if (document.getElementById(IsChecked).checked) {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    document.getElementById(chkArrayMain[i]).checked = true;
                }
            } else {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    document.getElementById(chkArrayMain[i]).checked = false;
                }
            }

        }
        function ValidateCheckBox() {

            var chkArrayMain = new Array();
            var count = 0;
            chkArrayMain = document.getElementById('HdnCheckBoxId').value.split('~');
            for (var i = 0; i < chkArrayMain.length; i++) {
                if (document.getElementById(chkArrayMain[i]).checked == true) {
                    count++;
                }
            }
            if (count > 0)
            { return true; } else {
                alert('Select an investigation');
                return false;

            }

        }



        function launchexe(ExeName, Path) {
            //            alert('a');
            //            var cmdline1 = "notepad.exe \"c:\\1.txt\"";
            //           var cmdline2 = "taskmgr.exe";
            //            document.apltLaunchExe.launch(cmdline1);
            document.apltLaunchExe.launch(cmdline2);
        }

        function launchexe_mv(patid, studyid, modality, imageserveripaddress, portnumber, loggedinusername) {
            //            alert('ts');
            var exename = 'launch_viewer_mv.exe';
            var args = patid + ' ' + studyid + ' ' + modality + ' ' + imageserveripaddress + ' ' + portnumber + ' ' + loggedinusername;
            var cmdline = exename + ' ' + args;
            document.apltLaunchExe.launch(cmdline);
            //            alert('ts1');
            return false;
            //            alert('ts');
        }
    </script>

</head>
<body id="oneColLayout">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc2:Header ID="Header2" runat="server" />
                <uc7:AdminHeader ID="AdminHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
         <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
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
                                <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                    
                        <table id="tblPatient" runat="server" width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="center" colspan="7">
                                    <div style="display: block" class="dataheader2">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td colspan="6">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 100px; text-align: right">
                                                    <asp:Label ID="lblFrom" Text="From" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox Width="125px" ID="txtFrom" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                    <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" />
                                                    <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFrom"
                                                        Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                        OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" />
                                                    <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" />
                                                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFrom"
                                                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" />
                                                </td>
                                                <td style="width: 100px; text-align: right">
                                                    <asp:Label ID="lblTo" Text="To" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtTo" Width="125px" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                    <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" />
                                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTo"
                                                        Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                        OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" />
                                                    <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" />
                                                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtTo"
                                                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" />
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                <%--<asp:UpdatePanel ID="updatePanel1" runat="server">
                                                <ContentTemplate>--%>
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClientClick="return ChechVisit()"
                                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnSearch_Click" />
                                                    <%--</ContentTemplate>
                                                </asp:UpdatePanel>--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%">
                            <tr style="width: 100%">
                                <td>
                                    &nbsp;
                                    <asp:GridView ID="grdResult" runat="server" AllowPaging="True" CellPadding="1" AutoGenerateColumns="False"
                                        DataKeyNames="PatientVisitID,Name" Width="100%" OnRowDataBound="grdResult_RowDataBound"
                                        ForeColor="#333333" CssClass="mytable1" OnItemCommand="grdResult_ItemCommand"
                                        ItemStyle-VerticalAlign="Top" RepeatDirection="Horizontal" PageSize="10" OnPageIndexChanging="grdResult_PageIndexChanging">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                            PageButtonCount="5" PreviousPageText="" />
                                        <Columns>
                                            <asp:BoundField Visible="false" DataField="PatientVisitID" HeaderText="PatientVisitID" />
                                            <asp:TemplateField HeaderText="Select">
                                                <ItemTemplate>
                                                    <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="VisitSelect" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="PatientName" HeaderText="Name" />
                                            <asp:BoundField DataField="PatientAge" Visible="true" HeaderText="Age" />
                                            <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd MMM yyyy}" HeaderText="Visit Date" />
                                            <asp:BoundField DataField="VisitPurposeName" HeaderText="Visit Purpose" />
                                            <asp:TemplateField HeaderText="Physician Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPhysicianName" runat='server' Text='<%#Bind("PhysicianName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Location" HeaderText="Location" />
                                            <asp:BoundField DataField="OrgID" Visible="false" HeaderText="OrgID" />
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr id="trSelectVisit" runat="server" visible="false">
                                <td class="defaultfontcolor">
                                    Select a patient visit
                                    <asp:DropDownList ID="ddlVisitActionName" AutoPostBack="false" runat="server" Visible="false" CssClass="ddlsmall">
                                    </asp:DropDownList>
                                    <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        OnClientClick="return CheckVisitID()" onmouseout="this.className='btn'" OnClick="btnGo_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                    <asp:Label ID="lblMessage1" runat="server"></asp:Label>
                                    <asp:Label ID="lblResult" runat="server" CssClass="casesheettext"></asp:Label>
                                </td>
                            </tr>
                            <%--   <tr id="aRow" runat="server" visible="false">
                                <td class="defaultfontcolor">
                                    Select a patient and one of the following  
                                    <asp:DropDownList ID="dList" runat="server" CssClass="ddlTheme" onselectedindexchanged="dList_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:Button ID="bGo" runat="server" Text="Go" OnClick="bGo_Click" CssClass="btn"
                                        OnClientClick="return pValidation()" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" />
                                </td>
                            </tr>--%>
                        </table>
                        <br />
                        <table width="100%" id="tblResults" runat="server" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td style="width: 5%">
                                                <img src="../Images/collapse_blue.jpg" id="imgClick" title="Show Report Template"
                                                    style="display: none;" runat="server" onclick="javascript:return ShowReportDiv();" />
                                            </td>
                                            <td style="width: 95%">
                                                <asp:Label runat="server" ID="lblHead" Text="Show Report Template" Style="display: none;"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="dReport" runat="server">
                                        <asp:DataList ID="grdResultTemp" runat="server" CellPadding="4" RepeatLayout="Table"
                                            ForeColor="#333333" RepeatColumns="2" OnItemDataBound="grdResultTemp_ItemDataBound"
                                            ItemStyle-VerticalAlign="Top" RepeatDirection="Horizontal" OnItemCommand="grdResultTemp_ItemCommand">
                                            <ItemStyle VerticalAlign="Top"></ItemStyle>
                                            <ItemTemplate>
                                                <table cellpadding="0" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                                                    cellspacing="0" border="0">
                                                    <tr>
                                                        <td valign="top">
                                                            <table cellpadding="5" class="colorforcontentborder" style="border-collapse: collapse;"
                                                                cellspacing="0" border="0" width="100%">
                                                                <tr>
                                                                    <td style="height: 20px;" class="Duecolor">
                                                                        <table width="100%">
                                                                            <tr>
                                                                                <td align="left">
                                                                                    Report
                                                                                </td>
                                                                                <td align="right">
                                                                                    &nbsp<asp:CheckBox ID="chkSelectAll" runat="server" Checked="false" />Select all<asp:Label
                                                                                        runat="server" ID="lblReportID" Visible="false" Text='<%#Eval("TemplateID") %>'>
                                                                                    </asp:Label>
                                                                                    <asp:Label runat="server" ID="lblReportname" Visible="false" Text='<%#Eval("ReportTemplateName") %>'>
                                                                                    </asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table cellpadding="5" class="colorforcontentborder" style="border-collapse: collapse;"
                                                                cellspacing="0" border="0" width="100%">
                                                                <tr>
                                                                    <td style="font-weight: normal;">
                                                                        <asp:DataList ID="grdResultDate" runat="server" CellPadding="4" RepeatLayout="Table"
                                                                            ForeColor="#333333" OnItemDataBound="grdResultDate_ItemDataBound" ItemStyle-VerticalAlign="Top"
                                                                            OnItemCommand="grdResultDate_ItemCommand" RepeatColumns="2" RepeatDirection="Horizontal">
                                                                            <ItemStyle VerticalAlign="Top" />
                                                                            <ItemTemplate>
                                                                                <table>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:Label runat="server" Font-Bold="true" ID="Label1" Text=' <%#Eval("CreatedAt") %>'>
                                                                                            </asp:Label>
                                                                                            <asp:Label runat="server" ID="lblDtReportID" Visible="false" Text='<%#Eval("TemplateID") %>'>
                                                                                            </asp:Label>
                                                                                            <asp:Label runat="server" ID="lbldtReportname" Visible="false" Text='<%#Eval("ReportTemplateName") %>'>
                                                                                            </asp:Label>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td style="font-weight: normal;">
                                                                                            <asp:DataList ID="dlChildInvName" RepeatColumns="1" RepeatDirection="Vertical" RepeatLayout="Table"
                                                                                                runat="server" OnItemCommand="dlChildInvName_ItemCommand" ItemStyle-VerticalAlign="Top"
                                                                                                Width="100%">
                                                                                                <ItemStyle VerticalAlign="Top" />
                                                                                                <ItemTemplate>
                                                                                                    <table>
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <asp:CheckBox ID="ChkBox" onclick="javascript:return ChkIfSelected(this.id);" runat="server"
                                                                                                                    Checked="false" />
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:Label runat="server" ID="lblInvname" Text='<%#Eval("InvestigationName") %>'>
                                                                                                                </asp:Label>
                                                                                                                <asp:Label runat="server" Visible="false" ID="lblInvID" Text='<%#Eval("InvestigationID") %>'>
                                                                                                                </asp:Label>
                                                                                                                <asp:Label runat="server" ID="lblReportID" Visible="false" Text='<%#Eval("TemplateID") %>'>
                                                                                                                </asp:Label>
                                                                                                                <asp:Label runat="server" ID="lblReportname" Visible="false" Text='<%#Eval("ReportTemplateName") %>'>
                                                                                                                </asp:Label>
                                                                                                                <asp:Label runat="server" ID="lblAccessionNo" Visible="false" Text='<%#Eval("AccessionNumber") %>'>
                                                                                                                </asp:Label>
                                                                                                                <asp:Label runat="server" ID="lblPatientID" Visible="false" Text='<%#Eval("PatientID") %>'>
                                                                                                                </asp:Label>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:LinkButton ID="lnkShow" ForeColor="Black" Font-Bold="true" Font-Underline="true"
                                                                                                                    runat="server" Visible="false" Text="Show" CommandName="ShowReport">
                                                                                                                </asp:LinkButton>
                                                                                                                <%--<a href="#" id="IdImg" runat="server" >View Image</a>--%>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </ItemTemplate>
                                                                                            </asp:DataList>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </ItemTemplate>
                                                                        </asp:DataList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="color: #000000; height: 20px;" align="center">
                                                                        <asp:LinkButton ID="lnkShowReport" OnClientClick="javascript:return ValidateCheckBox();"
                                                                            ForeColor="Black" runat="server" Text="ShowReport" CommandName="ShowReport" Font-Underline="true"></asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </div>
                                </td>
                                <td>
                                    <table runat="server" border="0" visible="false" style="background-color: #fcecb6"
                                        id="tblcontent">
                                        <tr>
                                            <td class="alterimg">
                                            </td>
                                            <td>
                                                <b>If you are viewing the images for the first time, please install the viewer.</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <img src="../Images/box_menu_bullet.png" runat="server" id="imgInstallExe" alt="error" visible="true" /><asp:HyperLink Font-Bold="true"
                                                                ForeColor="Black" runat="server" ID="lnkInstall" Text="Click to download & install Viewer"></asp:HyperLink>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <img src="../Images/box_menu_bullet.png" alt="error" runat="server" id="imgInsGuide" visible="true" />
                                                            <asp:LinkButton runat="server" Font-Bold="true" OnClick="lnkInsguide_Click" ForeColor="Black"
                                                                ID="lnkInsguide" Text="Click to view the Installation Guide"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <img src="../Images/box_menu_bullet.png" alt="error" runat="server" id="imgUserGuide" visible="true" />
                                                            <asp:LinkButton runat="server" OnClick="lnkUserGuide_Click" Font-Bold="true" ForeColor="Black"
                                                                ID="lnkUserGuide" Text="Click to view the Viewer User Guide"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <asp:HiddenField runat="server" ID="hdnInstallationGuidePath" />
                                    <asp:HiddenField runat="server" ID="hnUserGuidePath" />
                                    <asp:HiddenField runat="server" ID="hdnIpaddress" />
                                    <asp:HiddenField runat="server" ID="hdnPortNumber" />
                                    <asp:HiddenField runat="server" ID="hdnPath" />
                                    
                                </td>
                            </tr>
                        </table>
                        <table width="100%" id="tblPayments" visible="false" runat="server" border="0" cellpadding="0"
                            cellspacing="0">
                            <tr>
                                <td>
                                    This Bill has pending payments kindly make payment to view report
                                    <asp:Button ID="btnPayNow" runat="server" Text="Pay Now" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        OnClick="btnPayNow_Click" onmouseout="this.className='btn'" />
                                </td>
                            </tr>
                        </table>
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                            <ContentTemplate>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none" />
                                            <cc1:ModalPopupExtender ID="rptMdlPopup" runat="server" PopupControlID="pnlAttrib"
                                                TargetControlID="hiddenTargetControlForModalPopup" BackgroundCssClass="modalBackground"
                                                CancelControlID="btnCnl">
                                            </cc1:ModalPopupExtender>
                                            <asp:Panel ID="pnlAttrib" BorderWidth="1px" Height="95%" Width="90%" CssClass="modalPopup dataheaderPopup"
                                                runat="server">
                                                <table width="100%" style="height: 100%">
                                                    <tr>
                                                        <td valign="top">
                                                            <rsweb:ReportViewer ID="rReportViewer" runat="server"
                                                                ProcessingMode="Remote">
                                                                <ServerReport ReportServerUrl="" />
                                                            </rsweb:ReportViewer>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Button ID="btnCnl" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                
                <input type="hidden" id="hdnPNAME" name="PName" runat="server" />
                <input type="hidden" id="hdnPID" name="pid" runat="server" />
                <input type="hidden" id="hdnVID" name="vid" runat="server" />
                <input type="hidden" id="hdnVisitDetail" runat="server" />
                <input type="hidden" id="patOrgID" runat="server" name="patOrgID" />
                <input type="hidden" id="ChkID" runat="server" />
                <asp:HiddenField ID="HdnCheckBoxId" runat="server" />
           </td>
            </tr>
        </table>
        <applet archive="launchexe_signed.jar" code="launchexe.class" id="apltLaunchExe"
            name="apltLaunchExe" width="1" height="1">
        </applet>                
        <uc4:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
