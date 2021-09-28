<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationCapture.aspx.cs"
    Inherits="Investigation_CheckDisplay" meta:resourcekey="PageResource1" %>

<%@ Register Src="MicroPattern.ascx" TagName="MicroPattern" TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc3" %>--%>
<%@ Register Src="../CommonControls/ReferDoctor.ascx" TagName="ReferDoctor" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%--<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Investigation Capture</title>
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>
 <%--   <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>--%>

    <script language="javascript" type="text/javascript">
        function txtBoxValidation() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vVisitNo = SListForAppMsg.Get('Investigation_InvestigationCapture_aspx_01') == null ? "Provide patient visit number to search" : SListForAppMsg.Get('Investigation_InvestigationCapture_aspx_01');

            if (document.getElementById('txtSearchTxt').value == '') {
                //alert('Provide patient visit number to search');
                ValidationWindow(vVisitNo, AlertType);
                document.getElementById('txtSearchTxt').focus();
                return false;
            }
            return true;
        }
        function getFocus() {
            if (document.getElementById('pnlSerch').style == "block") {
                document.getElementById('txtSearchTxt').focus();
            }
        }
    </script>

    <script type="text/javascript">

        function onClick1(id) {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vInvestigation = SListForAppMsg.Get('Investigation_InvestigationCapture_aspx_02') == null ? "Investigation already added" : SListForAppMsg.Get('Investigation_InvestigationCapture_aspx_02');

            var type;
            var AddStatus = 0;
            var obj = document.getElementById(id);
            var i = obj.getElementsByTagName('OPTION');

            if (id == "listINV") {
                type = 'INV';
            }

            var HidValue = document.getElementById('iconHid').value;
            var list = HidValue.split('^');

            if (document.getElementById('iconHid').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {

                        if (obj.selectedIndex >= 0) {
                            if (InvesList[0] == obj.options[obj.selectedIndex].value) {
                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                document.getElementById('lblHeader').style.display = "block";
                var row = document.getElementById('tblOrederedInves').insertRow(0);
                row.id = obj.options[obj.selectedIndex].value;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick1(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                cell3.innerHTML = type;
                cell3.style.display = "none";
                document.getElementById('iconHid').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "~" + type + "^";
                AddStatus = 2;
            }
            if (AddStatus == 0) {
                document.getElementById('lblHeader').style.display = 'block';
                var row = document.getElementById('tblOrederedInves').insertRow(0);
                row.id = obj.options[obj.selectedIndex].value;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick1(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                cell3.innerHTML = type;
                cell3.style.display = "none";
                document.getElementById('iconHid').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "~" + type + "^";
            }
            else if (AddStatus == 1) {
                //alert('Investigation already added');
                ValidationWindow(vInvestigation, AlertType);
            }
        }



        function ImgOnclick1(ImgID) {

            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('iconHid').value;
            var list = HidValue.split('^');

            var newInvList = '';
            if (document.getElementById('iconHid').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {
                        if (InvesList[0] != ImgID) {

                            newInvList += list[count] + '^';

                        }
                    }
                }
                document.getElementById('iconHid').value = newInvList;

            }

        }


        function setItem(e, ctl) {

            var key = window.event ? e.keyCode : e.which;
            if (key == 13) {
                onClick1(ctl.id);
            }

        }

        


        
 
    </script>

    <%--code added for check all in gridview BEGINS--%>

    <script type="text/javascript">

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

            var chkArraydropDown = new Array();
            chkArraydropDown = document.getElementById('HdnDropDownId').value.split('~');
            if (document.getElementById(IsChecked).checked) {
                for (var i = 0; i < chkArraydropDown.length; i++) {
                    var x = document.getElementById(chkArraydropDown[i]);
                    x.disabled = false;
                }
            } else {
                for (var i = 0; i < chkArraydropDown.length; i++) {

                    var x = document.getElementById(chkArraydropDown[i]);
                    x.disabled = true;
                }
            }
        }

        function CheckSampleSelected() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vChangeStaus = SListForAppMsg.Get('Investigation_InvestigationCapture_aspx_03') == null ? "Select a Sample to Change Status" : SListForAppMsg.Get('Investigation_InvestigationCapture_aspx_03');

            var chkArrayMain = new Array();
            var count = 0;
            chkArrayMain = document.getElementById('HdnCheckBoxId').value.split('~');
            for (var i = 0; i < chkArrayMain.length; i++) {
                if (document.getElementById(chkArrayMain[i]).checked) {
                    count++;
                }
            }
            if (count > 0) {
                return true
            }
            else {
                //alert('Select a Sample to Change Status');
                ValidationWindow(vChangeStaus, AlertType);
                return false
            }

        }

        function EnableSampleDropDown(chkStatus, DropDownId) {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vChangeStaus = SListForAppMsg.Get('Investigation_InvestigationCapture_aspx_03') == null ? "Select a Sample to Change Status" : SListForAppMsg.Get('Investigation_InvestigationCapture_aspx_03');

            if (document.getElementById(chkStatus).checked) {
                var drpStatus = document.getElementById(DropDownId);
                drpStatus.disabled = false;
            } else {
                var drpStatus = document.getElementById(DropDownId);
                drpStatus.disabled = true;
            }

            if (count > 0) {
                return true
            }
            else {
                //alert('Select a sample to change status');
                ValidationWindow(vChangeStaus, AlertType);
                return false
            }
        }

        function SelectAllTest(sender) {

            var chkArrayMain = new Array();
            chkArrayMain = document.getElementById('HdnTestCheckBoxId').value.split('~');
            if (document.getElementById(sender).checked) {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    document.getElementById(chkArrayMain[i]).checked = true;
                }
            }
            else {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    document.getElementById(chkArrayMain[i]).checked = false;
                }
            }
        }

    </script>

    <%--code added for check all in gridview - ENDS--%>
</head>
<body oncontextmenu="return false;" onload="javascript:getFocus();">
    <form id="form1" runat="server" defaultbutton="btnGo">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       <%-- <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>--%>
                        <input type="hidden" id="hdnVID" value="0" runat="server" />
                        <input type="hidden" id="hdnPID" value="0" runat="server" />
                        <asp:Panel ID="pnlSerch" CssClass="dataheader2" BorderWidth="1px" Width="85%" runat="server"
                            meta:resourcekey="pnlSerchResource1">
                            <table id="searchTab" runat="server" cellpadding="4" class="w-100p">
                                <tr runat="server">
                                    <td class="w-40p h-20 a-left" style="font-weight: normal;color: #000;"
                                        runat="server">
                                        <asp:Label ID="lblSearch" Text="Enter Lab Bill No / Visit No to Search" runat="server"></asp:Label>
                                    </td>
                                    <td class="w-20p h-20 a-left" style="font-weight: normal;color: #000;"
                                        runat="server">
                                        <asp:TextBox ID="txtSearchTxt" ToolTip="Lab Bill No / Visit No" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                        <ajc:FilteredTextBoxExtender ID="txtSearch" FilterType="Numbers" TargetControlID="txtSearchTxt"
                                            runat="server" Enabled="True">
                                        </ajc:FilteredTextBoxExtender>
                                    </td>
                                    <td class="h-20 a-center" style="font-weight: normal;color: #000;"  runat="server">
                                        <asp:Label ID="Rs_Selectyear" Text="Select year" runat="server"></asp:Label>
                                    </td>
                                    <td runat="server">
                                        <asp:DropDownList runat="server" ID="ddlSearchYear" ToolTip="Year" CssClass="ddlsmall">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="w-10p a-left" runat="server">
                                        <asp:Button ID="btnGo" runat="server" ToolTip="Click here to Enter the Result" Text="Search"
                                            CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                            OnClick="btnGo_Click" Style="cursor: pointer;" OnClientClick="return txtBoxValidation()" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Label ID="lblResult" ForeColor="#000333" Visible="False" runat="server" meta:resourcekey="lblResultResource1">
                            <asp:Label ID="Rs_NoMatchingRecordsFound" Text="No Matching Records Found!" runat="server"
                                meta:resourcekey="Rs_NoMatchingRecordsFoundResource1"></asp:Label>
                        </asp:Label>
                        <div runat="server" id="completeDIV" style="display: none">
                            <div runat="server" id="dInves" style="display: none">
                                <asp:Table CellPadding="2" CssClass="colorforcontentborder" CellSpacing="0" Font-Size="11px"
                                    BorderWidth="0px" runat="server" ID="dispTab" Width="100%" meta:resourcekey="dispTabResource1">
                                    <asp:TableRow ID="tblReferred" runat="server" Height="15px" BorderWidth="0" meta:resourcekey="tblReferredResource1">
                                        <asp:TableHeaderCell ForeColor="#000" HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource1">
                                            <asp:Literal ID="ColDrName" runat="server" Text="Dr. Name:" meta:resourcekey="ColDrNameResource1"></asp:Literal>
                                            &nbsp;
                                            <asp:Literal ID="DrName" runat="server" meta:resourcekey="DrNameResource2"></asp:Literal>
                                        </asp:TableHeaderCell>
                                        <asp:TableHeaderCell ForeColor="#000" HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource2">
                                            <asp:Literal ID="Literal3" runat="server" Text="Hospital/Branch:" meta:resourcekey="Literal3Resource1"></asp:Literal>
                                            &nbsp;
                                            <asp:Literal ID="HospitalName" runat="server" meta:resourcekey="HospitalNameResource1"></asp:Literal>
                                        </asp:TableHeaderCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="TableRow1" runat="server" BorderWidth="0" meta:resourcekey="TableRow1Resource1">
                                        <asp:TableHeaderCell ColumnSpan="4" HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource3">
                                            <asp:Table CellPadding="0" CellSpacing="0" BorderWidth="0" runat="server" ID="trCC"
                                                Style="display: none;" Width="100%" meta:resourcekey="trCCResource1">
                                                <asp:TableRow Height="15px" BorderWidth="0" meta:resourcekey="TableRowResource1">
                                                    <asp:TableHeaderCell ForeColor="#000" ColumnSpan="2" HorizontalAlign="left" meta:resourcekey="TableHeaderCellResource4">
                                                        <asp:Literal ID="Literal4" runat="server" Text="Collection Centre:" meta:resourcekey="Literal4Resource1"></asp:Literal>
                                                        &#160;
                                                        <asp:Literal ID="CollectionCentre" runat="server" meta:resourcekey="CollectionCentreResource1"></asp:Literal>
                                                    </asp:TableHeaderCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:TableHeaderCell>
                                    </asp:TableRow>
                                </asp:Table>
                                <%--<asp:Panel ID="pnlptDetails" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                    <table border="1" cellpadding="4" cellspacing="0" width="100%">
                                        <tr style="height: 15px;" class="Duecolor">
                                            <td colspan="12">
                                                <b>Patient Details</b>
                                            </td>
                                        </tr>
                                        <tr style="height: 20px;">
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 9%;" align="left">
                                                Patient No:
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                <asp:Label ID="lblPatientNo" runat="server"></asp:Label>
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                VisitDate:
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 7%;" align="left">
                                                <asp:Label ID="lblDate" runat="server"></asp:Label>
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 11%;" align="left">
                                                Patient Name:
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 15%;" align="left">
                                                <asp:Label ID="lblPatientName" runat="server"></asp:Label>
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                Gender:
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                <asp:Label ID="lblGender" runat="server"></asp:Label>
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 4%;" align="left">
                                                Age:
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 9%;" align="left">
                                                <asp:Label ID="lblAge" runat="server"></asp:Label>
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 7%;" align="left">
                                                Visit No:
                                            </td>
                                            <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                <asp:Label ID="lblVisitNo" runat="server"></asp:Label>
                                            </td>
                                          
                                        </tr>
                                        <tr>
                                            <td colspan="10">
                                                <%--<table border="0" cellpadding="0" cellspacing="0" visible="true" >
                                         <tr>
                                         <td>Referred by Dr.</td>
                                         <td><asp:DropDownList ID="ddlDoctor" runat="server" CssClass="ddlTheme12" onchange="javascript:datachanged();"></asp:DropDownList>
                                             <asp:HiddenField ID="hdnRefDoctor" runat="server" />
                                         </td>
                                         <td>
                                         <div id="divOtherDoctors" runat="server" style="display:none" >
                                            Dr. <asp:TextBox ID="txtOtherDoctors" runat="server" ></asp:TextBox>
                                         </div>
                                         </td>
                                         </tr>
                                         </table>--%>
                                <%-- </td>
                                        </tr>
                                    </table>
                                </asp:Panel>--%>
                            </div>
                            <div runat="server" id="divPatientDetails">
                                <ucPatientdet:PatientDetails ID="PatientDetail" runat="server" />
                            </div>
                            <br />
                            <table class="w-100p" style="display: none;" runat="server" id="ordInvTab">
                                <%--code added for sample status - begins--%>
                                <%-- <tr class="tablerow" id="tbltrSampleNotGiven" runat="server">
                                    <td style="height: 23px;" align="left">
                                        <div id="ACX2plus3" style="display: none;">
                                            <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',1);">
                                                <asp:Label ID="Rs_InvestigationsSampleStatus" Text="Investigations Sample Status"
                                                    runat="server"></asp:Label></span>
                                        </div>
                                        <div id="ACX2minus3" style="display: block;">
                                            <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus3','ACX2minus3','ACX2responses3',0);">
                                                &nbsp;<asp:Label ID="Rs_InvestigationsSampleStatus1" Text="Investigations Sample Status"
                                                    runat="server"></asp:Label></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responses3" style="display: block;" runat="server">
                                    <td colspan="2">
                                        <div class="dataheader2">
                                            <table>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <asp:GridView ID="grdSampleNotGiven" runat="server" AutoGenerateColumns="False" GridLines="None"
                                                            Width="500px" OnRowDataBound="grdSampleNotGiven_RowDataBound">
                                                            <Columns>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkSelect" runat="server" />
                                                                        <asp:HiddenField ID="HdnSampleID" Value='<%# Eval("SampleID") %>' runat="server" />
                                                                    </ItemTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                                                                    </EditItemTemplate>
                                                                    <HeaderTemplate>
                                                                        <asp:CheckBox ID="chkSelectAll" runat="server" />
                                                                    </HeaderTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Sample Description" SortExpression="SampleDesc">
                                                                    <EditItemTemplate>
                                                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("SampleDesc") %>'></asp:Label>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("SampleDesc") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Sample Status" SortExpression="InvSampleStatusID">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("InvSampleStatusID") %>'></asp:TextBox>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:DropDownList ID="drpSampleStatus" runat="server" SelectedValue='<%# Bind("InvSampleStatusID") %>'>
                                                                            <asp:ListItem Text="SampleReceived" Value="3"></asp:ListItem>
                                                                            <asp:ListItem Text="SampleRejected" Value="4"></asp:ListItem>
                                                                            <asp:ListItem Text="SampleNotGiven" Value="6"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <HeaderStyle HorizontalAlign="Left" />
                                                        </asp:GridView>
                                                        <asp:HiddenField ID="HdnCheckBoxId" runat="server" />
                                                        <asp:HiddenField ID="HdnDropDownId" runat="server" />
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnSampleStatus" runat="server" Text="Update Sample Status" ToolTip="Click here to Enter the Investigation Results"
                                                            Style="cursor: pointer;" CssClass="btn" OnClientClick="javascript:return CheckSampleSelected();"
                                                            OnClick="btnUpdateSampleStatus_Click" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>--%>
                                <%--code added for sample status - ends--%>
                                <tr>
                                    <td class="h-23 a-left">
                                        <div id="ACX2plus1" style="display: none;">
                                            <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);">
                                                <asp:Label ID="Rs_InvestigationOrderedForCurrentVisit" Text="Investigations Ordered For Current Visit"
                                                    runat="server" meta:resourcekey="lblResultResource20" ></asp:Label></span>
                                        </div>
                                        <div id="ACX2minus1" style="display: block;">
                                            <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);">
                                                &nbsp;<asp:Label ID="Rs_Info1" Text="Investigations Ordered For Current Visit" runat="server" meta:resourcekey="lblResultResource21"></asp:Label></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responses1" style="display: table-row;">
                                    <td colspan="2">
                                        <asp:Label ID="lblInvStatus" runat="server" Font-Size="Medium" Font-Bold="true" Text="No Investigations Ordered for Current Visit"
                                            Visible="false">
                                        </asp:Label>
                                        <div class="dataheader2">
                                            <asp:DataList ID="dlInvName" runat="server" RepeatLayout="Table" CssClass="w-100p searchPanel" 
                                                RepeatColumns="3" ItemStyle-Wrap="true"
                                                RepeatDirection="Horizontal" OnItemDataBound="dlInvName_ItemDataBound">
                                                <HeaderTemplate>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table cellpadding="1px" class="w-100p">
                                                        <tr>
                                                            <td class="a-top a-left h-20 w-30p">
                                                                <img src="../Images/bullet.png" alt="" align="middle" />
                                                                &nbsp;
                                                                <asp:Label ID="lblInvName" runat="server" Text='<%# Eval("InvestigationName")%>'></asp:Label>
                                                                <asp:Label ID="Labelpkg" runat="server" Text="("></asp:Label>
                                                        <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status")%>' style="display:none;"></asp:Label> 
																 <asp:Label ID="lblDisplayStatus" runat="server" Text='<%# Eval("DisplayStatus")%>'></asp:Label> 
                                                                <asp:Label ID="Labelpkg1" runat="server" Text=")"></asp:Label>
                                                                <asp:Label ID="lblPackageName" runat="server" Text=""></asp:Label>
                                                           <asp:Label ID="lblPatientStatus" runat="server" Text='<%# Eval("ReferredType")%>'></asp:Label>
                                                           <%--<asp:Image ImageUrl="~/Images/info.gif" ID="imginvinfo" runat="server" style="height:80%;" />--%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                </FooterTemplate>
                                            </asp:DataList>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                            <table class="w-45p" style="display: none;" runat="server" id="CheakInv">
                                <tr>
                                    <td class="a-left h-23">
                                        <asp:HiddenField ID="HdnInvID" runat="server" />
                                        <asp:HiddenField ID="HdnAllInvID" runat="server" />
                                        <div id="ACX2plus2" style="display: none;">
                                            <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);">
                                                <asp:Label ID="Rs_EnterResultForSelectedInvestigations" Text="Enter Result For Selected Investigations"
                                                    runat="server" meta:resourcekey="lblResultResource22"></asp:Label></span>
                                        </div>
                                        <div id="ACX2minus2" style="display: block;">
                                            <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);">
                                                &nbsp;<asp:Label ID="Rs_EnterResultForSelectedInvestigations1" Text="Enter Result For Selected Investigations"
                                                    runat="server" meta:resourcekey="lblResultResource23"></asp:Label>
                                            </span>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responses2" style="display: table-row;">
                                    <td colspan="2">
                                        <asp:Label ID="Label3" runat="server" Font-Size="Medium" Font-Bold="true" Text="No Investigations Ordered for Current Visit"
                                            Visible="false">
                                        </asp:Label>
                                        <div class="dataheader2">
                                            <asp:UpdatePanel ID="UpdPnl1" runat="server">
                                                <ContentTemplate>
                                                    <asp:GridView ID="GrdInv" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                        OnRowDataBound="GrdInv_RowBound" CellPadding="4" PageSize="25" CssClass="mytable1 gridView w-100p"
                                                        ForeColor="#333333" GridLines="none" PagerSettings-Mode="NextPrevious"
                                                        OnPageIndexChanging="GrdInv_PageSelectedIndexChange">
                                                        <PagerTemplate>
                                                            <tr>
                                                                <td class="a-center" colspan="6">
                                                                    <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="false" CommandArgument="Next"
                                                                        CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" Width="18px" />
                                                                    <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="false" CommandArgument="Prev"
                                                                        CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" Width="18px" />
                                                                </td>
                                                            </tr>
                                                        </PagerTemplate>
                                                        <HeaderStyle Font-Bold="true" Font-Underline="true" />
                                                        <RowStyle Font-Bold="false" />
                                                        <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                        <Columns>
                                                            <asp:BoundField Visible="false" DataField="InvestigationID" HeaderText="InvestigationID" />
                                                            <asp:TemplateField ItemStyle-Width="3%">
                                                                <HeaderTemplate>
                                                                    <asp:CheckBox ID="chkHeader" runat="server" ToolTip="Select Row" Text="Select" onclick="SelectAllTest(this.id);" meta:resourcekey="TemplateFieldResource24"  >
                                                                    </asp:CheckBox></HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="chkSel" runat="server" ToolTip="Select Row" />
                                                                    <asp:HiddenField ID="lblAccessionNumber" runat="server" Value='<%# bind("AccessionNumber") %>' />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="InvestigationName" HeaderStyle-HorizontalAlign="left"
                                                                HeaderText="Investigation" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="2%" meta:resourcekey="BoundFieldResource1">
                                                                <HeaderStyle HorizontalAlign="Left" Width="25%"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Status" HeaderStyle-HorizontalAlign="Left" HeaderText="Status" meta:resourcekey="BoundFieldResource2"
                                                                ItemStyle-HorizontalAlign="Left" Visible="false">
                                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Left" Width="8%"></ItemStyle>
                                                            </asp:BoundField>
                                                             <asp:BoundField DataField="DisplayStatus" HeaderStyle-HorizontalAlign="Left" HeaderText="Status" meta:resourcekey="BoundFieldResource3"
                                                                ItemStyle-HorizontalAlign="Left" Visible="true">
                                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Left" Width="8%"></ItemStyle>
                                                            </asp:BoundField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                            <%--By Shajahan--%>
                            <table class="w-95p" style="display: none;" id="trCPInvs" runat="server">
                                <tr>
                                    <td class="a-left h-23 w-100p">
                                        <div id="ACX3plus1" style="display: none;">
                                            <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responsescp',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responsescp',1);">
                                                <asp:Label ID="Rs_InvestigationsCapturedForCurrentVisit" Text="Investigations Captured For Current Visit"
                                                    runat="server"></asp:Label></span>
                                        </div>
                                        <div id="ACX3minus1" style="display: block;">
                                            <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responsescp',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responsescp',0);">
                                                &nbsp;<asp:Label ID="Rs_Info2" Text="Investigations Captured For Current Visit" runat="server"></asp:Label></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX3responsescp" style="display: table-row;">
                                    <td colspan="2">
                                        <asp:Label ID="Label1" runat="server" Font-Size="Medium" Font-Bold="true" Text="No Investigations Captured for Current Visit"
                                            Visible="false">
                                        </asp:Label>
                                        <div class="dataheader2">
                                            <asp:DataList ID="dlCPInvs" runat="server" RepeatLayout="Table" CssClass="w-100p"
                                             RepeatColumns="3" ItemStyle-Wrap="true" RepeatDirection="Horizontal">
                                                <HeaderTemplate>
                                                    <table cellpadding="1px" class="w-100p">
                                                        <tr>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <td class="v-top a-left h-20 w-30p" style="height: 20px; width: 30%;">
                                                        <img src="../Images/bullet.png" alt="" align="middle" />
                                                        &nbsp;
                                                        <%# DataBinder.Eval(Container.DataItem, "InvestigationName")%>
                                                    </td>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </tr> </table>
                                                </FooterTemplate>
                                            </asp:DataList>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <table id="resultValuesTab" runat="server" style="display: none;" class="w-95p">
                                <tr>
                                    <td class="a-left h-23">
                                        <div id="ACX4plus1" style="display: none;">
                                            <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                onclick="showResponses('ACX4plus1','ACX4minus1','ACX4responsescp',1);" />
                                            <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX4plus1','ACX4minus1','ACX4responsescp',1);">
                                                <asp:Label ID="Rs_InvestigationsPerformed" Text="Investigations Performed" runat="server"></asp:Label></span>
                                        </div>
                                        <div id="ACX4minus1" style="display: block;">
                                            <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                style="cursor: pointer" onclick="showResponses('ACX4plus1','ACX4minus1','ACX4responsescp',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX4plus1','ACX4minus1','ACX4responsescp',0);">
                                                &nbsp;<asp:Label ID="Rs_InvestigationsPerformed1" Text="Investigations Performed"
                                                    runat="server"></asp:Label></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX4responsescp" style="display: table-row;">
                                    <td>
                                        <div class="dataheader2">
                                            <asp:Label ID="Label2" runat="server" Font-Size="Medium" Font-Bold="true" Text="No Values Collected"
                                                Visible="false">
                                            </asp:Label>
                                            <%-- <uc25:SampleCctrl ID="ucSC" runat="server"></uc25:SampleCctrl>--%>
                                            <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                CellPadding="4" PageSize="50" CssClass="mytable1" ForeColor="#333333" GridLines="none"
                                                PagerSettings-Mode="NextPrevious" Width="80%">
                                                <PagerTemplate>
                                                    <tr>
                                                        <td class="a-center" colspan="6">
                                                            <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="false" CommandArgument="Prev"
                                                                CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" Width="18px" />
                                                            <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="false" CommandArgument="Next"
                                                                CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" Width="18px" />
                                                        </td>
                                                    </tr>
                                                </PagerTemplate>
                                                <HeaderStyle Font-Bold="true" Font-Underline="true" />
                                                <RowStyle Font-Bold="false" />
                                                <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                <Columns>
                                                    <asp:BoundField DataField="InvestigationName" HeaderStyle-HorizontalAlign="left"
                                                        HeaderText="Investigation" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="2%">
                                                        <HeaderStyle HorizontalAlign="Left" Width="25%"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <%-- <asp:BoundField DataField="Name" HeaderStyle-HorizontalAlign="Left" HeaderText="Name"
                    ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="15%">
                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="Value" HeaderStyle-HorizontalAlign="Left" HeaderText="Value"
                    ItemStyle-HorizontalAlign="Left" Visible="true">
                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left" Width="8%"></ItemStyle>
                </asp:BoundField>
                 <asp:BoundField DataField="UOMID" HeaderStyle-HorizontalAlign="Left" HeaderText="UOM"
                    ItemStyle-HorizontalAlign="Left" Visible="true">
                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left" Width="8%"></ItemStyle>
                </asp:BoundField>--%>
                                                    <asp:BoundField DataField="Status" HeaderStyle-HorizontalAlign="Left" HeaderText="Status"
                                                        ItemStyle-HorizontalAlign="Left" Visible="true">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Width="8%"></ItemStyle>
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <table id="ucSCTab" runat="server" style="display: none;" class="w-100p">
                                <tr>
                                    <td>
                                        <table class="w-95p">
                                            <tr>
                                                <td class="a-left">
                                                    <input type="hidden" id="iconHid" value="" class="w-50p" runat="server" />
                                    <asp:Label ID="lblInvestigation" runat="server" Visible="false">
                                    <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationCapture_aspx_01 %>
                                    </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td>
                                                                <asp:ListBox ID="listINV" Visible="false" runat="server" Width="350px" EnableViewState="false"
                                                                    Height="200px" onkeypress="javascript:setItem(event,this);" ondblClick="javascript:onClick1(this.id);">
                                                                </asp:ListBox>
                                                            </td>
                                                            <td class="w-50p v-top">
                                                                <table class="w-96p">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblHeader" runat="server" Style="display: none; font-size: 12px; vertical-align: middle;
                                                                                padding: 5px;" class="Duecolor">
                                                                                <asp:Label ID="Rs_Info" Text="Selected Investigations" runat="server"></asp:Label></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <table id="tblOrederedInves" class="dataheaderInvCtrl w-96p" cellpadding="4px">
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                             
                                            <tr>
                                                <td class="a-center">
                                                    <asp:Button ID="btnFinish" runat="server" ToolTip="Click here to Enter the Investigation Results"
                                                        Style="cursor: pointer;" CssClass="btn" OnClick="btnFinish_Click" onmouseout="this.className='btn'"
                                                        onmouseover="this.className='btn btnhov'" Text="Enter Result" UseSubmitBehavior="true" meta:resourcekey="btnFinishResource1" />
                                                    &nbsp;&nbsp;
                                                    <asp:Button ID="btnCancel" runat="server" ToolTip="Click here to Cancel, View the Home Page"
                                                        CssClass="btn" OnClick="btnCancel_Click" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                        Text="Cancel" UseSubmitBehavior="true" meta:resourcekey="btnCancelResource2" />
                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:HyperLink ID="hypLnkPrint" Text="Print Work List" Font-Underline="true" Font-Bold="true"
                                                        Font-Size="12px" ForeColor="#000000" Target="WorkListWindow" runat="server" ToolTip="Click Here To Print Work List" visible="false">
                                                        <img id="imgPrint" runat="server" style="border-width: 0px;" visible="false" src="~/Images/printer.gif" />&nbsp;
                                                    </asp:HyperLink>
                                                </td>
                                            </tr>
                                            <tr>
                                            <td>&nbsp;</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />  
               
        <asp:HiddenField ID="hdnHeaderName" runat="server" />
        <asp:HiddenField ID="HdnTestCheckBoxId" runat="server" />
         <asp:HiddenField ID="hdnMessages" runat="server" />
		         
    </form>
</body>
</html>
