<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationCollectionReport.aspx.cs"
    Inherits="Admin_InvestigationCollectionReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Test Wise Collection Report</title>
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script type="text/javascript">

        function onClick1(id) {
            var AlertType = SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_01');
            var objdate = SListForAppMsg.Get('Admin_InvestigationCollectionReport_aspx_03') == null ? "Investigation already added" : SListForAppMsg.Get('Admin_InvestigationCollectionReport_aspx_03');

            var type;
            var AddStatus = 0;
            var obj = document.getElementById(id);
            var i = obj.getElementsByTagName('OPTION');
            document.getElementById('tblOrederedInves').style.display = 'block';
            if (id == "listINV") {
                type = 'INV';
            }
            if (id == "listGRP") {
                type = 'GRP';
            }
            if (id == "listPKG") {
                type = 'PKG';
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

                ValidationWindow(objdate, AlertType);
                //alert('Investigation already added');
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


        function LoadOrdItems() {

            var HidValue = document.getElementById('iconHid').value;
            var list = HidValue.split('^');
            if (document.getElementById('iconHid').value != "") {
                document.getElementById('lblHeader').style.display = 'block';
                for (var count = 0; count < list.length - 1; count++) {
                    var InvesList = list[count].split('~');
                    var row = document.getElementById('tblOrederedInves').insertRow(0);
                    row.id = InvesList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick1(" + InvesList[0] + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = InvesList[1];
                    cell3.innerHTML = InvesList[2];
                    cell3.style.display = "none";

                }
            }

        }





        function setItem(e, ctl) {

            var key = window.event ? e.keyCode : e.which;
            if (key == 13) {
                onClick1(ctl.id);
            }

        }


        function ValidateDate() {
            var AlertType = SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Admin_LabAdminSummaryReports_aspx_01');
            var objdate = SListForAppMsg.Get('Admin_DaywiseCollection_aspx_01') == null ? "Select from date and to date" : SListForAppMsg.Get('Admin_DaywiseCollection_aspx_01');

            if (document.getElementById('txtFDate').value == '') {
                ValidationWindow(objdate, AlertType);
                //alert('Select from date and to date');
                return false;
            }
            else if (document.getElementById('txtTDate').value == '') {
                ValidationWindow(objdate, AlertType);
                // alert('Select from date and to date');
                return false;

            }
            else {
                //  return checkFromDateToDate('txtFDate', 'txtTDate');
            }
        }

        function setList(id) {
            ////debugger;
            if (id == "rdoINV") {
                document.getElementById("trFilterINV").style.display = "block";
                if (document.getElementById("listINV")) { document.getElementById("trlistINV").style.display = "block"; }
                if (document.getElementById("listGRP")) { document.getElementById("trlistGRP").style.display = "none"; }
                if (document.getElementById("listPKG")) { document.getElementById("trlistPKG").style.display = "none"; }
                document.getElementById("lblLists").innerHTML = "Investigation(s)";
                //document.getElementById('listINV').focus();
                document.getElementById('listINV').selectedIndex = 0;
                document.getElementById("tdSelectMesg").style.display = "block";
                document.getElementById('hidID').value = document.getElementById('listINV').id;
                document.getElementById("txtFilterINV").value = "";
                MyUtil.selectFilter('listINV', '');

            }
            if (id == "rdoGRP") {
                document.getElementById("trFilterINV").style.display = "block";
                if (document.getElementById("listINV")) { document.getElementById("trlistINV").style.display = "none"; }
                if (document.getElementById("listGRP")) { document.getElementById("trlistGRP").style.display = "block"; }
                if (document.getElementById("listPKG")) { document.getElementById("trlistPKG").style.display = "none"; }
                document.getElementById("lblLists").innerHTML = "Group(s)";
                //document.getElementById('listGRP').focus();
                document.getElementById('listGRP').selectedIndex = 0;
                document.getElementById("tdSelectMesg").style.display = "block";
                document.getElementById('hidID').value = document.getElementById('listGRP').id;
                document.getElementById("txtFilterINV").value = "";
                MyUtil.selectFilter('listGRP', '');

            }
            if (id == "rdoPKG") {
                document.getElementById("trFilterINV").style.display = "block";
                if (document.getElementById("listINV")) { document.getElementById("trlistINV").style.display = "none"; }
                if (document.getElementById("listGRP")) { document.getElementById("trlistGRP").style.display = "none"; }
                if (document.getElementById("listPKG")) { document.getElementById("trlistPKG").style.display = "block"; }
                document.getElementById("lblLists").innerHTML = "Package(s)";
                //document.getElementById('listPKG').focus();
                document.getElementById('listPKG').selectedIndex = 0;
                document.getElementById("tdSelectMesg").style.display = "block";
                document.getElementById('hidID').value = document.getElementById('listPKG').id;
                document.getElementById("txtFilterINV").value = "";
                MyUtil.selectFilter('listPKG', '');


            }
            if (id == "rdoALL") {
                if (document.getElementById("listINV")) { document.getElementById("trlistINV").style.display = "none"; }
                if (document.getElementById("listGRP")) { document.getElementById("trlistGRP").style.display = "none"; }
                if (document.getElementById("listPKG")) { document.getElementById("trlistPKG").style.display = "none"; }
                document.getElementById("tdSelectMesg").style.display = "none";
                document.getElementById("trFilterINV").style.display = "none";
                document.getElementById("txtFilterINV").value = "";

            }
            clearListTable();
            document.getElementById("tdExport").style.display = "none";
        }

        function clearListTable() {
            var HidValue = document.getElementById('iconHid').value;
            var list = HidValue.split('^');
            var newInvList = '';
            if (document.getElementById('iconHid').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var InvesList = list[count].split('~');
                    if (InvesList[0] != '') {
                        document.getElementById(InvesList[0]).style.display = "none";
                    }
                }
            }

            document.getElementById('iconHid').value = "";
            document.getElementById('lblHeader').style.display = 'none';
            document.getElementById('tblOrederedInves').style.display = 'none';
            if (document.getElementById('grdResult')) {
                document.getElementById('grdResult').style.display = 'none';
            }
            document.getElementById('excelTab').style.display = 'none';
        }
        MyUtil = new Object();
        MyUtil.selectFilterData = new Object();
        MyUtil.selectFilter = function(selectId, filter) {
            selectId = document.getElementById('hidID').value;
            var list = document.getElementById(selectId);
            if (!MyUtil.selectFilterData[selectId]) { //if we don't have a list of all the options, cache them now'
                MyUtil.selectFilterData[selectId] = new Array();
                for (var i = 0; i < list.options.length; i++) MyUtil.selectFilterData[selectId][i] = list.options[i];
            }
            list.options.length = 0;   //remove all elements from the list
            for (var i = 0; i < MyUtil.selectFilterData[selectId].length; i++) { //add elements from cache if they match filter
                var o = MyUtil.selectFilterData[selectId][i];
                if (o.text.toLowerCase().indexOf(filter.toLowerCase()) >= 0) {

                    if (navigator.appName == "Microsoft Internet Explorer") {
                        //alert("hai")
                        list.add(o);
                    }
                    else {
                        //alert("httt")
                        list.add(o, null);
                    }
                }
            }
        }
        function CallPrint() {
            var prtContent = document.getElementById('divPrint');

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false;
        }
        function clearContextText() {
            $('#contentArea').hide();
            document.getElementById('ddlINVSelection').selectedvalue = 'rdoALL';
        }
 
    </script>

    <style type="text/css">
        .ui-datepicker
        {
            font-size: 8pt !important;
        }
    </style>
</head>
<body id="Body1" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <%--<script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

                        <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>

                        <script type="text/javascript">
                            
                          $(function() {
                            $("#txtFDate").datepicker({
                                    dateFormat: 'dd/mm/yy',
                                    defaultDate: "+1w",
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '1900:2100',
                                    onClose: function(selectedDate) {
                                    $("#txtTDate").datepicker("option", "minDate", selectedDate);

                                        var date = $("#txtFDate").datepicker('getDate');
                                        //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                                        // $("#txtTo").datepicker("option", "maxDate", d);

                                    }
                                });
                                $("#txtTDate").datepicker({
                                    dateFormat: 'dd/mm/yy',
                                    defaultDate: "+1w",
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '1900:2100',
                                    onClose: function(selectedDate) {
                                    $("#txtFDate").datepicker("option", "maxDate", selectedDate);
                                    }
                                })
                            });

                        </script>

                        <div>
                            <asp:Panel runat="server" CssClass="dataheader2 w-100p" ID="pnlDate" meta:resourcekey="pnlDateResource1">
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" meta:resourcekey="lblOrgsResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlTrustedOrg" onchange="javascript:clearContextText();" runat="server"
                                                            CssClass="ddl" meta:resourcekey="ddlTrustedOrgResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label1" runat="server" Text="Location:" meta:resourcekey="Label1Resource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlLocation" Width="180px" runat="server" CssClass="ddl" meta:resourcekey="ddlLocationResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Label runat="server" ID="fromDate" Text="From Date" CssClass="label_title" meta:resourcekey="fromDateResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtFDate" runat="server" onkeypress="datepickerspl();" CssClass="Txtboxsmall" Width="70px" MaxLength="1"
                                                            Style="text-align: justify" ValidationGroup="MKE" meta:resourcekey="txtFDateResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label runat="server" ID="toDate" Text="To Date" CssClass="label_title" meta:resourcekey="toDateResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtTDate" onkeypress="datepickerspl();" runat="server" CssClass="Txtboxsmall" Width="70px" MaxLength="1"
                                                            Style="text-align: justify" ValidationGroup="MKE" meta:resourcekey="txtTDateResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="RS_searchType" runat="server" Text="Search Type" meta:resourcekey="RS_searchTypeResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlINVSelection" OnChange="javascript:setList(this.value);"
                                                            meta:resourcekey="ddlINVSelectionResource1">
                                                            <%--       <asp:ListItem Value="rdoALL" Selected="True" 
                                                                meta:resourcekey="ListItemResource1" Text="ALL"></asp:ListItem>
                                                            <asp:ListItem Value="rdoINV" meta:resourcekey="ListItemResource2" 
                                                                Text="Investigation"></asp:ListItem>
                                                            <asp:ListItem Value="rdoGRP" meta:resourcekey="ListItemResource3" Text="Group"></asp:ListItem>
                                                            <asp:ListItem Value="rdoPKG" meta:resourcekey="ListItemResource4" 
                                                                Text="Package"></asp:ListItem>--%>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnFinish" runat="server" CssClass="btn" OnClick="btnFinish_Click"
                                                            onmouseout="this.className='btn'" OnClientClick="javascript:return ValidateDate();"
                                                            onmouseover="this.className='btn btnhov'" Text="Get Report" meta:resourcekey="btnFinishResource1" />
                                                        <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click"
                                                            meta:resourcekey="lnkBackResource1" Text="Back&amp;nbsp;&amp;nbsp;&amp;nbsp;"></asp:LinkButton>&nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                        <div id="contentArea">
                            <table class="w-100p">
                                <tr>
                                    <td runat="server" id="tdExport" style="display: none;">
                                        <b>
                                            <%=Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_26%><%--Export To Excel--%></b>&nbsp;&nbsp;&nbsp;
                                        <asp:ImageButton ID="btnXL" OnClick="btnXL_Click" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                            ToolTip="Save As Excel" meta:resourcekey="btnXLResource1" />
                                        &nbsp; &nbsp; &nbsp;
                                        <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="../Images/printer.GIF"
                                            ToolTip="Click Here To Print Supplier Details" OnClientClick="return CallPrint();"
                                            meta:resourcekey="imgBtnPrintResource1" />
                                        <asp:LinkButton ID="lnkPrint" runat="server" Font-Bold="True" OnClientClick="return CallPrint();"
                                            Font-Size="12px" ForeColor="Black" ToolTip="Click Here To Print Stock Details"
                                            meta:resourcekey="lnkPrintResource1" Text="&lt;u&gt;Print&lt;/u&gt;"></asp:LinkButton>
                                    </td>
                                </tr>
                                <%-- <tr>
                                <td>
                                    <label for="rdoINV" id="lblrdoINV" runat="server" visible="false">
                                        <input type="radio" runat="server" id="rdoINV" name="rdoType"  onclick="javascript:setList(this.id);"
                                            value="INV" />Investigation</label>
                                    <label for="rdoGRP" id="lblrdoGRP" runat="server" visible="false">
                                        <input type="radio" runat="server" id="rdoGRP" name="rdoType" onclick="javascript:setList(this.id);"
                                            value="GRP" />Group</label>
                                    <label for="rdoPKG" id="lblrdoPKG" runat="server" visible="false">
                                        <input type="radio" runat="server" id="rdoPKG" name="rdoType" onclick="javascript:setList(this.id);"
                                            value="PKG" />Package</label>
                                    <label for="rdoALL" id="lblrdoALL" runat="server" visible="true">
                                        <input type="radio" runat="server" id="rdoALL" name="rdoType" onclick="javascript:setList(this.id);"
                                            value="ALL" />ALL</label>
                                </td>
                            </tr>--%>
                                <tr id="trFilterINV" style="display: none;" runat="server">
                                    <td>
                                        <asp:Label ID="Rs_FilterINV" runat="server" Text="Filter:" Font-Bold="True" meta:resourcekey="Rs_FilterINVResource1"></asp:Label>
                                        <input type="text" onkeyup="MyUtil.selectFilter('listINV', this.value)" id="txtFilterINV" />
                                    </td>
                                </tr>
                                <tr>
                                    <td id="tdSelectMesg" align="left" style="color: #333;" runat="server">
                                        <input type="hidden" id="iconHid" value="" style="width: 50%;" runat="server" />
                                        <%--Select one or more--%><%=Resources.Admin_ClientDisplay.Admin_InvestigationCollectionReport_aspx_02%>
                                        <label id="lblLists" runat="server">
                                            <%--Investigation(s)--%><%=Resources.Admin_ClientDisplay.Admin_InvestigationCollectionReport_aspx_03%></label>,
                                        then click Go
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table class="w-100p">
                                            <tr>
                                                <td class="v-top">
                                                    <table class="w-100p">
                                                        <tr id="trlistINV" runat="server">
                                                            <td>
                                                                <asp:ListBox ID="listINV" Visible="False" runat="server" Width="350px" EnableViewState="False"
                                                                    Height="200px" onkeypress="javascript:setItem(event,this);" ondblClick="javascript:onClick1(this.id);"
                                                                    meta:resourcekey="listINVResource1"></asp:ListBox>
                                                            </td>
                                                        </tr>
                                                        <tr id="trlistGRP" runat="server" style="display: none;">
                                                            <td>
                                                                <asp:ListBox ID="listGRP" Visible="False" runat="server" Width="350px" EnableViewState="False"
                                                                    Height="200px" onkeypress="javascript:setItem(event,this);" ondblClick="javascript:onClick1(this.id);"
                                                                    meta:resourcekey="listGRPResource1"></asp:ListBox>
                                                            </td>
                                                        </tr>
                                                        <tr id="trlistPKG" runat="server" style="display: none;">
                                                            <td>
                                                                <asp:ListBox ID="listPKG" Visible="False" runat="server" Width="350px" EnableViewState="False"
                                                                    Height="200px" onkeypress="javascript:setItem(event,this);" ondblClick="javascript:onClick1(this.id);"
                                                                    meta:resourcekey="listPKGResource1"></asp:ListBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="w-50p v-top">
                                                    <table class="w-96p">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblHeader" runat="server" Style="display: none; font-size: 12px; vertical-align: middle;
                                                                    padding: 5px;" CssClass="Duecolor" meta:resourcekey="lblHeaderResource1" Text=" Selected Items"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table id="tblOrederedInves" class="dataheaderInvCtrl w-96p">
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblResult" ForeColor="#000333" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <div id="divPrint" runat="server">
                                <table id="excelTab" runat="server" cellpadding="5" style="display: none; color: #333;" class="w-80p">
                                    <tr>
                                        <td class="w-25p a-left">
                                            <b>
                                                <%=Resources.Admin_ClientDisplay.Admin_InvestigationCollectionReport_aspx_04%><%--Grand Total:--%></b>
                                            <asp:Label ID="lblGrdTotal" runat="server" meta:resourcekey="lblGrdTotalResource1"
                                                Font-Bold="true"></asp:Label>
                                        </td>
                                        <td class="w-75p a-left">
                                            <b>
                                                <%=Resources.Admin_ClientDisplay.Admin_InvestigationCollectionReport_aspx_05%><%--Investigation Total:--%></b>
                                            <asp:Label ID="lblInvTotal" runat="server" Font-Bold="True" meta:resourcekey="lblInvTotalResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                    CssClass="mytable1 gridView w-80p" ForeColor="#333333" meta:resourcekey="grdResultResource1">
                                    <HeaderStyle CssClass="dataheader1" />
                                    <RowStyle Font-Bold="false" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                            <ItemStyle />
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="BillID" HeaderText="ItemID" Visible="false" meta:resourcekey="BoundFieldResource1" />
                                        <asp:BoundField DataField="ItemName" HeaderStyle-HorizontalAlign="Left" HeaderText="Name"
                                            ItemStyle-HorizontalAlign="Left" Visible="true" meta:resourcekey="BoundFieldResource2">
                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Quantity" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                            HeaderText="Number of Tests" ItemStyle-HorizontalAlign="Right" Visible="true"
                                            meta:resourcekey="BoundFieldResource3">
                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Amount" ItemStyle-Font-Bold="true" DataFormatString="{0:0.00}"
                                            HeaderStyle-HorizontalAlign="right" HeaderText="Total Amount" ItemStyle-HorizontalAlign="Right"
                                            Visible="true" meta:resourcekey="BoundFieldResource4">
                                            <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script language="javascript" type="text/javascript">
        LoadOrdItems();
        //        if (document.getElementById('rdoINV')) {
        //            if (document.getElementById('rdoINV').checked) {
        //                document.getElementById('listINV').focus();
        //                document.getElementById('listINV').selectedIndex = 0;
        //            }
        //        }
        //        if (document.getElementById('rdoGRP')) {
        //            if (document.getElementById('rdoGRP').checked) {
        //                document.getElementById('listGRP').focus();
        //                document.getElementById('listGRP').selectedIndex = 0;
        //            }
        //        }
        //        if (document.getElementById('rdoPKG')) {
        //            if (document.getElementById('rdoPKG').checked) {
        //                document.getElementById('listPKG').focus();
        //                document.getElementById('listPKG').selectedIndex = 0;
        //            }
        //        }
    </script>

    <script language="javascript" type="text/javascript">
        //        document.onkeydown = catchIt;
        //        function catchIt() {
        //            if (window.event.keyCode == 8) {
        //                return false;
        //            }
        //        }
    </script>

</body>
</html>
