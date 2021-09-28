<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PhysioReport.aspx.cs" Inherits="Reports_PhysioReport"
    EnableEventValidation="false" meta:resourcekey="PageResource1" %>

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
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
            <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function CheckDates(splitChar) {
            var today = new Date();
            var now = today.getDate() + splitChar + (today.getMonth() + 1) + splitChar + today.getFullYear();
            if (document.getElementById('txtFrom').value == '') {
                alert('Select From Date!');
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {
                alert('Select To Date!');
                return false;
            }
            else {
                //Assign From And To Date from Controls 
                DateFrom = document.getElementById('txtFrom').value.split(splitChar);
                DateTo = document.getElementById('txtTo').value.split(splitChar);
                DateNow = now.split(splitChar);
                //Argument Value 0 for validating Current Date And To Date 
                //Argument Value 1 for validating Current From And To Date 
                if (doDateValidation(DateTo, DateNow, 0)) {
                    if (doDateValidation(DateFrom, DateTo, 1)) {
                        //alert("Validation Succeeded");

                        return true;
                    }
                    else {
                        return false;
                    }
                }
                else {
                    return false;
                }
            }
        }
        function doDateValidation(from, to, bit) {
            var dayFlag = true;
            var monthFlag = true;
            var i = from.length - 1;
            if (Number(to[i]) >= Number(from[i])) {
                if (Number(to[i]) == Number(from[i])) {
                    monthFlag = false;
                }
                i--;
                if (Number(to[i]) >= Number(from[i])) {
                    if (Number(to[i]) == Number(from[i])) {
                        dayFlag = false;
                    }
                    i--;
                    if (Number(to[i]) >= Number(from[i])) {
                        i--;
                        return true;
                    }
                    else {
                        if (dayFlag) {
                            return true;
                        }
                        else {
                            if (bit == 0) {
                                alert('Mismatch Day Between Current & To Date');
                            }
                            else {
                                alert('Mismatch Day Between From & To Date');
                            }
                            return false;
                        }
                    }
                }
                else if (monthFlag) {
                    return true;
                }
                else {
                    if (bit == 0) {
                        alert('Mismatch Month Between Current & To Date');
                    }
                    else {
                        alert('Mismatch Month Between From & To Date');
                    }
                    return false;
                }
            }
            else {
                if (bit == 0) {
                    alert('Mismatch Year Between Current & To Date');
                }
                else {
                    alert('Mismatch Year Between From & To Date');
                }
                return false;
            }
        }

        function popupprint() {

            document.getElementById('tblprnReportp').style.display = "block";
            var prtContent = document.getElementById('prnPhysioreportp');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            document.getElementById('tblprnReportp').style.display = "none";
        }

        function popupprintPC() {

            document.getElementById('tblPC').style.display = "block";
            var prtContent = document.getElementById('divPrintPhysioC');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            document.getElementById('tblPC').style.display = "none";
        }


        function GetRadioButtonValue(id) {

            var radio = document.getElementsByName(id);
            for (var i = 0; i < radio.length; i++) {

                if (radio[i].checked) {

                    if (radio[i].value == 0) {

                        document.getElementById('tdddlcPhysio').style.display = "none"
                        document.getElementById('tdddlPhysio').style.display = "block"



                    }
                    else {


                        document.getElementById('tdddlcPhysio').style.display = "block"
                        document.getElementById('tdddlPhysio').style.display = "none"

                    }


                }
            }
        }
        
        
    </script>

</head>
<body>
    <form id="form1" runat="server">
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
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table id="tblCollectionOPIP" align="center">
                            <tr align="center">
                                <td align="center">
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <Triggers>
                                            <asp:PostBackTrigger ControlID="imgBtnXL" />
                                            <asp:PostBackTrigger ControlID="imgBtnXLPC" />
                                        </Triggers>
                                        <ContentTemplate>
                                            <div class="dataheaderWider">
                                                <table id="tbl">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                            <asp:TextBox ID="txtFrom" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtFromResource1" />
                                                            <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFrom"
                                                                PopupButtonID="txtFrom" Enabled="True" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                            <asp:TextBox ID="txtTo" runat="server" CssClass ="Txtboxsmall" Width ="120px" meta:resourcekey="txtToResource1" />
                                                            <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTo"
                                                                PopupButtonID="txtTo" Enabled="True" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClientClick="javascript:return CheckDates('/');"
                                                                OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " 
                                                                CssClass="details_label_age"  OnClick="lnkBack_Click" 
                                                                meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:RadioButtonList ID="rblReportType" RepeatDirection="Horizontal" runat="server"
                                                                onclick="javascript:GetRadioButtonValue(this.id);" meta:resourcekey="rblReportTypeResource1">
                                                                <asp:ListItem Text="Physio Wise" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                <asp:ListItem Text="Diagnose Wise" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                        <td style="display: block" runat="server" id="tdddlPhysio">
                                                            <asp:Label ID="Rs_Select" Text="Select:" runat="server" meta:resourcekey="Rs_SelectResource1"></asp:Label>
                                                            <asp:DropDownList ID="ddlPhysio"  CssClass="ddlsmall" Width="120px" runat="server" meta:resourcekey="ddlPhysioResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="display: none" runat="server" id="tdddlcPhysio">
                                                            <asp:Label ID="Rs_SelectP" Text="Select:" runat="server" meta:resourcekey="Rs_SelectPResource1"></asp:Label>
                                                            <asp:DropDownList ID="ddlcPhysio"   CssClass="ddlsmall" Width ="120px" runat="server" meta:resourcekey="ddlcPhysioResource1">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                   
                                                </table>
                                                <table id="Table1">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblErrorMsg" runat="server" Text="No Matching Records Found" Font-Bold="True"
                                                                Visible="False" meta:resourcekey="lblErrorMsgResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                    <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                            <div id="divPrintPhysioreport" style="display: none;" runat="server">
                                                <table cellpadding="0" cellspacing="0" border="0" width="95%">
                                                    <tr>
                                                        <td align="right" style="padding-right: 10px; color: #000000;">
                                                            <b id="printText" runat="server">
                                                                <asp:Label ID="Rs_PrintReport1" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReport1Resource1"></asp:Label></b>&nbsp;&nbsp;
                                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                                ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                            <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                                ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <table cellpadding="0" cellspacing="0" border="0" width="100%" id="tblPhysioreport"
                                                style="display: block;" runat="server">
                                                <tr id="Tr1" runat="server">
                                                    <td id="Td1" runat="server">
                                                        <asp:GridView ID="gvPhysioreport" runat="server" Width="100%" CellPadding="4" CssClass="mytable1"
                                                            AutoGenerateColumns="False" ForeColor="#333333" HorizontalAlign="Left" AllowPaging="True"
                                                            AllowSorting="True" PageSize="25" OnPageIndexChanging="gvPhysioreport_PageIndexChanging"
                                                            DataKeyNames="ProcedureName" OnRowCommand="gvPhysioreport_RowCommand">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Physiotheraphy">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblProcedureName" Text='<%#Eval("ProcedureName") %>' runat="server"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="No Of Patient">
                                                                    <ItemTemplate>
                                                                        <%--  <asp:Label ID="lblVisitCount" Text='<%#Eval("VisitCount") %>' runat="server"></asp:Label>--%>
                                                                        <asp:LinkButton ID="btnView" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                            CommandName="OView" Text='<%#Eval("VisitCount")%>' Font-Underline="true" ToolTip="Click Here To View The Patient"></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="No Of Sittings">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblProcedureCount" Text='<%#Eval("ProcedureCount") %>' runat="server"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </table>
                                            <div id="prnPhysioreportp">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%" id="tblprnReportp"
                                                    style="display: none;" runat="server">
                                                    <tr id="Tr2" runat="server">
                                                        <td id="Td2" runat="server">
                                                            <asp:GridView ID="gvPhysioreportp" runat="server" Width="100%" CellPadding="4" CssClass="mytable1"
                                                                AutoGenerateColumns="False" ForeColor="#333333" HorizontalAlign="Left" AllowSorting="True">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Physiotheraphy">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblProcedureNamep" Text='<%#Eval("ProcedureName") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="No Of Patient">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblVisitCountp" Text='<%#Eval("VisitCount") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="No Of Sittings">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblProcedureCountp" Text='<%#Eval("ProcedureCount") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                <PagerStyle CssClass="dataheaderInvCtrl" HorizontalAlign="Left" />
                                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divPrintPC" style="display: none;" runat="server">
                                                <table cellpadding="0" cellspacing="0" border="0" width="95%">
                                                    <tr>
                                                        <td align="right" style="padding-right: 10px; color: #000000;">
                                                            <b id="B1" runat="server">
                                                                <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>&nbsp;&nbsp;
                                                            <asp:ImageButton ID="btnPrintPC" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprintPC();"
                                                                ToolTip="Print" meta:resourcekey="btnPrintPCResource1" />
                                                            <asp:ImageButton ID="imgBtnXLPC" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                                ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXLPC_Click" meta:resourcekey="imgBtnXLPCResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <table cellpadding="0" cellspacing="0" border="0" width="100%" id="tblgvPCReport"
                                                style="display: block;" runat="server">
                                                <tr id="Tr3" runat="server">
                                                    <td id="Td3" runat="server">
                                                        <asp:GridView ID="gvPCReport" runat="server" Width="100%" CellPadding="4" CssClass="mytable1"
                                                            AutoGenerateColumns="False" ForeColor="#333333" HorizontalAlign="Left" AllowPaging="True"
                                                            AllowSorting="True" PageSize="25" OnPageIndexChanging="gvPCReport_PageIndexChanging"
                                                            DataKeyNames="ComplaintName" OnRowCommand="gvPCReport_RowCommand">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Complaint Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblComplaintName" Text='<%#Eval("ComplaintName") %>' runat="server"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="No Of Patient">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="btnEdit" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                            CommandName="OView" Text='<%#Eval("VisitCount")%>' Font-Underline="true" ToolTip="Click Here To View The Patient"></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </table>
                                            <div id="divPrintPhysioC">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%" id="tblPC" style="display: none;"
                                                    runat="server">
                                                    <tr id="Tr4" runat="server">
                                                        <td id="Td4" runat="server">
                                                            <asp:GridView ID="gvPCReportP" runat="server" Width="100%" CellPadding="4" CssClass="mytable1"
                                                                AutoGenerateColumns="False" ForeColor="#333333" HorizontalAlign="Left">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Complaint Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblComplaintNamep" Text='<%#Eval("ComplaintName") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="No Of Patient">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblVisitCountp" Text='<%#Eval("VisitCount") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                <PagerStyle CssClass="dataheaderInvCtrl" HorizontalAlign="Center" />
                                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Panel ID="pnlPatientDetail" runat="server" CssClass="modalPopup dataheaderPopup"
                                                Width="75%" Style="display: none" ScrollBars="Auto" Height="50%" meta:resourcekey="pnlPatientDetailResource1">
                                                <table id="tblPatientDetail" cellpadding="2" cellspacing="0" border="0" width="100%"
                                                    runat="server" class="dataheaderInvCtrl" style="display: block;">
                                                    <tr id="Tr5" class="defaultfontcolor" runat="server">
                                                        <td id="Td5" runat="server">
                                                            <asp:GridView ID="gvPatientDetail" runat="server" Width="100%" CellPadding="4" CssClass="mytable1"
                                                                AutoGenerateColumns="False" ForeColor="#333333" HorizontalAlign="Left">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Patient Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblName" Text='<%#Eval("Name") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Patient No">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblPatientNumber" Text='<%#Eval("PatientNumber") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Date">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblVisitDate" Text='<%#Eval("VisitDate") %>' runat="server"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                    <tr id="Tr6" runat="server">
                                                        <td id="Td6" align="center" runat="server">
                                                            <asp:Button ID="BtnPatientDetail" runat="server" Text="Close" CssClass="btn" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <ajc:ModalPopupExtender ID="ModelPopPatientDetail" runat="server" TargetControlID="btnR"
                                                    PopupControlID="pnlPatientDetail" BackgroundCssClass="modalBackground" OkControlID="BtnPatientDetail"
                                                    DynamicServicePath="" Enabled="True" />
                                                <input type="button" id="btnR" runat="server" style="display: none;" /></asp:Panel>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
