<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillsfortheDayTestWiseMonthlyReport.aspx.cs"
    Inherits="Reports_BillsfortheDayTestWiseMonthlyReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Bills for the day Test Wise Monthly Report</title>

    <script language="javascript" type="text/javascript">

        //        function Validate() {
        //         var e =  document.getElementById("txtClient").value;
        //         if (e == "") {
        //             document.getElementById('hdnSelectedClientID').value = "0";
        //         }
        //        }

        function Show() {
            document.getElementById('<%=divPrint1.ClientID%>').style.display = "none";
            document.getElementById('<%=pnl.ClientID%>').style.display = "none";
            document.getElementById('<%=PnlCount.ClientID%>').style.display = "none";
            var e = document.getElementById("ddlSearchType");
            var ddlSearchType = e.options[e.selectedIndex].index;
            document.getElementById("hdnType").value = ddlSearchType;
            document.getElementById("tblFilter").style.display = "none";
        }

        function getCountryID() {
            document.getElementById('<%=divPrint1.ClientID%>').style.display = "none";
            document.getElementById('<%=pnl.ClientID%>').style.display = "none";
            document.getElementById('<%=PnlCount.ClientID%>').style.display = "none";
            var e = document.getElementById("ddlCountry");
            var ddlCountry = e.options[e.selectedIndex].value;
            document.getElementById("hdnCountryID").value = ddlCountry;
            document.getElementById("tblFilter").style.display = "none";
        }

        function getOrgID() {
            document.getElementById('<%=divPrint1.ClientID%>').style.display = "none";
            document.getElementById('<%=pnl.ClientID%>').style.display = "none";
            document.getElementById('<%=PnlCount.ClientID%>').style.display = "none";
            var f = document.getElementById("ddlOrganization");
            var ddlOrg = f.options[f.selectedIndex].value;
            document.getElementById("hdnOrgID").value = ddlOrg;
        }

        function ItemClientSelected(source, eventArgs) {

            var ClientCorpID;
            var list = eventArgs.get_value().split('^');
            ClientCorpID = list[0];
            document.getElementById('hdnSelectedClientID').value = ClientCorpID;

        }


        function CheckEmpty() {
            var Check = document.getElementById("txtMailAddress").value;
            if (Check == "") {
                alert("Enter Email Address");
                return false;
            }
            return true;

        }

        function filter(term, flag) {
            var decimalPlaces = 0;
            var suche = term.value.toLowerCase();
            if (document.getElementById("hdnType").value == 1) {
                decimalPlaces = 2;
                var table = document.getElementById("grdResult");
            }
            else {
                var table = document.getElementById("grdResultCount");
            }
            if (flag == 0) {

                suche = '';
                term.value = '';
                term.focus();
            }
            var ele;
            var sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum8, sum8, sum9, sum10, sum11, sum12;
            sum1 = 0;
            sum2 = 0;
            sum3 = 0;
            sum4 = 0;
            sum5 = 0;
            sum6 = 0;
            sum6 = 0;
            sum7 = 0;
            sum8 = 0;
            sum9 = 0;
            sum10 = 0
            sum11 = 0;
            sum12 = 0;

            var x = (table.rows.length) - 1;
            table.deleteRow(x);

            var filter = document.getElementById("SearchKey").value;
            for (var r = 1; r < table.rows.length; r++) {
                ele = table.rows[r].cells[filter].innerHTML.replace(/<[^>]+>/g, "");
                if (ele.toLowerCase().indexOf(suche) >= 0) {
                    table.rows[r].style.display = '';

                    if (!isNaN(table.rows[r].cells[3].innerText)) {

                        sum1 = (parseFloat(sum1) + parseFloat(table.rows[r].cells[3].innerText));
                    }
                    if (!isNaN(table.rows[r].cells[4].innerText)) {

                        sum2 = (parseFloat(sum2) + parseFloat(table.rows[r].cells[4].innerText));
                    }
                    if (!isNaN(table.rows[r].cells[5].innerText)) {

                        sum3 = (parseFloat(sum3) + parseFloat(table.rows[r].cells[5].innerText));
                    }
                    if (!isNaN(table.rows[r].cells[6].innerText)) {

                        sum4 = (parseFloat(sum4) + parseFloat(table.rows[r].cells[6].innerText));
                    }
                    if (!isNaN(table.rows[r].cells[7].innerText)) {

                        sum5 = (parseFloat(sum5) + parseFloat(table.rows[r].cells[7].innerText));
                    }
                    if (!isNaN(table.rows[r].cells[8].innerText)) {

                        sum6 = (parseFloat(sum6) + parseFloat(table.rows[r].cells[8].innerText));
                    }
                    if (!isNaN(table.rows[r].cells[9].innerText)) {

                        sum7 = (parseFloat(sum7) + parseFloat(table.rows[r].cells[9].innerText));
                    }
                    if (!isNaN(table.rows[r].cells[10].innerText)) {

                        sum8 = (parseFloat(sum8) + parseFloat(table.rows[r].cells[10].innerText));
                    }
                    if (!isNaN(table.rows[r].cells[11].innerText)) {

                        sum9 = (parseFloat(sum9) + parseFloat(table.rows[r].cells[11].innerText));
                    }
                    if (!isNaN(table.rows[r].cells[12].innerText)) {

                        sum10 = (parseFloat(sum10) + parseFloat(table.rows[r].cells[12].innerText));
                    }
                    if (!isNaN(table.rows[r].cells[13].innerText)) {

                        sum11 = (parseFloat(sum11) + parseFloat(table.rows[r].cells[13].innerText));
                    }
                    if (!isNaN(table.rows[r].cells[14].innerText)) {

                        sum12 = (parseFloat(sum12) + parseFloat(table.rows[r].cells[14].innerText));
                    }
                }
                else {
                    table.rows[r].style.display = 'none';
                }
            }
            if (table.rows.length > 1) {
                var newRow = table.insertRow();
                var i = 0;
                for (i = 0; i < table.rows[0].cells.length; i++) {
                    var newCell = newRow.insertCell();

                }
                document.getElementById("tblFilter").style.display = "block";
                table.rows[table.rows.length - 1].cells[1].innerHTML = "Total";
                table.rows[table.rows.length - 1].cells[1].style.fontWeight = "bold";

                table.rows[table.rows.length - 1].cells[3].innerHTML = "";
                table.rows[table.rows.length - 1].cells[3].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[3].innerHTML = parseFloat(sum1).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[4].innerHTML = "";
                table.rows[table.rows.length - 1].cells[4].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[4].innerHTML = parseFloat(sum2).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[5].innerHTML = "";
                table.rows[table.rows.length - 1].cells[5].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[5].innerHTML = parseFloat(sum3).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[6].innerHTML = "";
                table.rows[table.rows.length - 1].cells[6].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[6].innerHTML = parseFloat(sum4).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[7].innerHTML = "";
                table.rows[table.rows.length - 1].cells[7].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[7].innerHTML = parseFloat(sum5).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[8].innerHTML = "";
                table.rows[table.rows.length - 1].cells[8].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[8].innerHTML = parseFloat(sum6).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[9].innerHTML = "";
                table.rows[table.rows.length - 1].cells[9].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[9].innerHTML = parseFloat(sum7).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[10].innerHTML = "";
                table.rows[table.rows.length - 1].cells[10].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[10].innerHTML = parseFloat(sum8).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[11].innerHTML = "";
                table.rows[table.rows.length - 1].cells[11].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[11].innerHTML = parseFloat(sum9).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[12].innerHTML = "";
                table.rows[table.rows.length - 1].cells[12].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[12].innerHTML = parseFloat(sum10).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[13].innerHTML = "";
                table.rows[table.rows.length - 1].cells[13].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[13].innerHTML = parseFloat(sum11).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[14].innerHTML = "";
                table.rows[table.rows.length - 1].cells[14].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[14].innerHTML = parseFloat(sum12).toFixed(decimalPlaces);
            }
        }

        //////////////////////////////////////////////////////////////////////////
        function clearFilter(flag) {
            var decimalPlaces = 0;
            if (document.getElementById("hdnType").value == 1) {
                decimalPlaces = 2;
                var table = document.getElementById("grdResult");
            }
            else {
                var table = document.getElementById("grdResultCount");
            }
            if (flag == 0) {

                suche = '';

            }
            var ele;
            var sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum8, sum8, sum9, sum10, sum11, sum12;
            sum1 = 0;
            sum2 = 0;
            sum3 = 0;
            sum4 = 0;
            sum5 = 0;
            sum6 = 0;
            sum6 = 0;
            sum7 = 0;
            sum8 = 0;
            sum9 = 0;
            sum10 = 0
            sum11 = 0;
            sum12 = 0;


            for (var r = 1; r < table.rows.length; r++) {

                table.rows[r].style.display = '';

                if (!isNaN(table.rows[r].cells[3].innerText)) {

                    sum1 = (parseFloat(sum1) + parseFloat(table.rows[r].cells[3].innerText));
                }
                if (!isNaN(table.rows[r].cells[4].innerText)) {

                    sum2 = (parseFloat(sum2) + parseFloat(table.rows[r].cells[4].innerText));
                }
                if (!isNaN(table.rows[r].cells[5].innerText)) {

                    sum3 = (parseFloat(sum3) + parseFloat(table.rows[r].cells[5].innerText));
                }
                if (!isNaN(table.rows[r].cells[6].innerText)) {

                    sum4 = (parseFloat(sum4) + parseFloat(table.rows[r].cells[6].innerText));
                }
                if (!isNaN(table.rows[r].cells[7].innerText)) {

                    sum5 = (parseFloat(sum5) + parseFloat(table.rows[r].cells[7].innerText));
                }
                if (!isNaN(table.rows[r].cells[8].innerText)) {

                    sum6 = (parseFloat(sum6) + parseFloat(table.rows[r].cells[8].innerText));
                }
                if (!isNaN(table.rows[r].cells[9].innerText)) {

                    sum7 = (parseFloat(sum7) + parseFloat(table.rows[r].cells[9].innerText));
                }
                if (!isNaN(table.rows[r].cells[10].innerText)) {

                    sum8 = (parseFloat(sum8) + parseFloat(table.rows[r].cells[10].innerText));
                }
                if (!isNaN(table.rows[r].cells[11].innerText)) {

                    sum9 = (parseFloat(sum9) + parseFloat(table.rows[r].cells[11].innerText));
                }
                if (!isNaN(table.rows[r].cells[12].innerText)) {

                    sum10 = (parseFloat(sum10) + parseFloat(table.rows[r].cells[12].innerText));
                }
                if (!isNaN(table.rows[r].cells[13].innerText)) {

                    sum11 = (parseFloat(sum11) + parseFloat(table.rows[r].cells[13].innerText));
                }
                if (!isNaN(table.rows[r].cells[14].innerText)) {

                    sum12 = (parseFloat(sum12) + parseFloat(table.rows[r].cells[14].innerText));
                }

            }

            if (table.rows.length > 1) {
                var newRow = table.insertRow();
                var i = 0;
                for (i = 0; i < table.rows[0].cells.length; i++) {
                    var newCell = newRow.insertCell();

                }
                document.getElementById("tblFilter").style.display = "block";
                table.rows[table.rows.length - 1].cells[1].innerHTML = "Total";
                table.rows[table.rows.length - 1].cells[1].style.fontWeight = "bold";

                table.rows[table.rows.length - 1].cells[3].innerHTML = "";
                table.rows[table.rows.length - 1].cells[3].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[3].innerHTML = parseFloat(sum1).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[4].innerHTML = "";
                table.rows[table.rows.length - 1].cells[4].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[4].innerHTML = parseFloat(sum2).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[5].innerHTML = "";
                table.rows[table.rows.length - 1].cells[5].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[5].innerHTML = parseFloat(sum3).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[6].innerHTML = "";
                table.rows[table.rows.length - 1].cells[6].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[6].innerHTML = parseFloat(sum4).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[7].innerHTML = "";
                table.rows[table.rows.length - 1].cells[7].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[7].innerHTML = parseFloat(sum5).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[8].innerHTML = "";
                table.rows[table.rows.length - 1].cells[8].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[8].innerHTML = parseFloat(sum6).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[9].innerHTML = "";
                table.rows[table.rows.length - 1].cells[9].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[9].innerHTML = parseFloat(sum7).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[10].innerHTML = "";
                table.rows[table.rows.length - 1].cells[10].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[10].innerHTML = parseFloat(sum8).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[11].innerHTML = "";
                table.rows[table.rows.length - 1].cells[11].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[11].innerHTML = parseFloat(sum9).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[12].innerHTML = "";
                table.rows[table.rows.length - 1].cells[12].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[12].innerHTML = parseFloat(sum10).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[13].innerHTML = "";
                table.rows[table.rows.length - 1].cells[13].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[13].innerHTML = parseFloat(sum11).toFixed(decimalPlaces);

                table.rows[table.rows.length - 1].cells[14].innerHTML = "";
                table.rows[table.rows.length - 1].cells[14].style.fontWeight = "bold";
                table.rows[table.rows.length - 1].cells[14].innerHTML = parseFloat(sum12).toFixed(decimalPlaces);
            }
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter">
                        </div>
                        <div align="center" id="processMessage" width="60%">
                            <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" />
                            <br />
                            <br />
                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <div>
                    <table class="w-100p searchPanel" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <asp:Label ID="lblOrg" runat="server" Text="Select Organization"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlOrganization" runat="server" onchange="getOrgID();">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Label ID="lblSearchType" runat="server" Text="Search Type"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlSearchType" runat="server" onchange="Show();">
                                    <asp:ListItem Text="Count" Value="Count"></asp:ListItem>
                                    <asp:ListItem Text="Turn Over" Value="Turn Over"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Label ID="lblProcLoc" runat="server" Text="Processed Location"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCategory" runat="server" onchange="Show();">
                                    <asp:ListItem Text="ALL" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="InHouse" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Outsource" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Button ID="btnSearch" runat="server" CssClass="btn" OnClick="btnSearch_Click"
                                    onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Search" />
                                &nbsp;
                            </td>
                            <td>
                                <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" Text="Back"
                                    OnClick="lnkBack_Click"></asp:LinkButton>
                            </td>
                            <%--  
                                          <td nowrap="nowrap">
                                                <asp:Label ID="Rs_ClientName" runat="server" Text="Client Name"></asp:Label>
                                            </td>
                                            <td id="tdClientParttxt" runat="server">
                                                <asp:TextBox ID="txtClient" runat="server" autocomplete="off" Width="200px" CssClass="AutoCompletesearchBox"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" CompletionInterval="1"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                    CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                    Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2" OnClientItemSelected="ItemClientSelected"
                                                    UseContextKey="true" ServiceMethod="GetCountryWiseClientNames" ServicePath="~/Webservice.asmx"
                                                    TargetControlID="txtClient">
                                                </cc1:AutoCompleteExtender>
                                            </td>   --%>
                        </tr>
                        <tr>
                            <td>
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblCountry" Text="Select Country" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCountry" runat="server" onchange="getCountryID();">
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divPrint1" style="display: none;" runat="server">
                    <table cellpadding="0" cellspacing="0" border="0" class="w-100p">
                        <tr align="right">
                            <td id="tdexcel" style="padding-right: 10px; color: #000000;" runat="server">
                                <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="True" ForeColor="#000333"
                                    runat="server" meta:resourcekey="lbExcelResource1"></asp:Label>
                                <asp:ImageButton ID="btnConverttoXL" OnClick="btnConverttoXL_Click" runat="server"
                                    ImageUrl="~/Images/ExcelImage.GIF" Visible="false" />
                                <b id="B1" runat="server">
                                    <asp:Label ID="Rs_PrintReport" Visible="false" Text="Print Report" runat="server"
                                        meta:resourcekey="Rs_PrintReportResource1"></asp:Label>
                                </b>
                                <asp:Button ID="btnPrintAll" runat="server" Text="Print" CssClass="btn" Visible="false"
                                    OnClick="btnPrintAll_Click" />
                                &nbsp;&nbsp;
                                <asp:Button ID="btnSendmail" runat="server" Text="Send Mail" CssClass="btn" OnClick="btnSendmail_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
                <br />
                <table id="tblFilter" style="display: none">
                    <tr>
                        <td style="font-weight: bold;">
                            Select Filter
                        </td>
                        <td>
                            <asp:DropDownList ID="SearchKey" runat="server">
                                <asp:ListItem Text="Test Name" Value="1" Selected="True"></asp:ListItem>
                                <%--<asp:ListItem Text="Country" Value="2"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:TextBox ID="SearchTxt" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="pnl" runat="server" ScrollBars="Vertical" class="w-100p" Style="height: 500px;">
                    <asp:GridView ID="grdResult" Width="90%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                        OnRowDataBound="grdResult_RowDataBound" ForeColor="#333333" CssClass="gridView"
                        EmptyDataText="Bills for the Day Test Wise Monthly Report Not Available" meta:resourcekey="grdResultResource1">
                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <HeaderStyle CssClass="colorforcontent" ForeColor="White" />
                        <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Black" />
                        <Columns>
                            <asp:TemplateField HeaderText="SI.No" HeaderStyle-Width="3%">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Clientid" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lnkFeeID" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("FeeID") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="FeeType" HeaderText="FeeType" Visible="false">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Test Name" HeaderStyle-Width="25%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkFeeDescription" Style="font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("FeeDescription") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="left"></ItemStyle>
                                <FooterStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Country" HeaderStyle-Width="15%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkCountryName" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("CountryName") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="left"></ItemStyle>
                                <FooterStyle HorizontalAlign="left" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M1" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkM1" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("M1") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M2" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkM2" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("M2") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M3" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkM3" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("M3") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M4" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkM4" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("M4") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M5" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkM5" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("M5") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M6" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkM6" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("M6") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M7" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkM7" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("M7") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M8" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkM8" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("M8") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M9" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkM9" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("M9") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M10" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkM10" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("M10") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M11" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkM11" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("M11") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M12" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkM12" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("M12") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" />
                    </asp:GridView>
                </asp:Panel>
                <asp:Panel ID="PnlCount" runat="server" ScrollBars="Vertical" class="w-100p" Style="height: 500px;">
                    <br />
                    <asp:GridView ID="grdResultCount" runat="server" CellPadding="4" AutoGenerateColumns="False"
                        OnRowDataBound="grdResultCount_RowDataBound" ForeColor="#333333" CssClass="w-90p gridView"
                        EmptyDataText="Bills for the Day Test Wise Monthly Report Not Available" AlternatingRowStyle-CssClass="trEven">
                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <HeaderStyle CssClass="colorforcontent" ForeColor="black" />
                        <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Black" />
                        <Columns>
                            <asp:TemplateField HeaderText="SI.No" HeaderStyle-Width="3%">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="FeeID" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lnkcountFeeID" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("FeeID") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="FeeType" HeaderText="FeeType" Visible="false">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Test Name" HeaderStyle-Width="25%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkcountFeeDescription" Style="font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("FeeDescription") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="left"></ItemStyle>
                                <FooterStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Country" HeaderStyle-Width="15%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkcountCountryName" Style="font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("CountryName") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="left"></ItemStyle>
                                <FooterStyle HorizontalAlign="left" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M1" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkC1" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("C1") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M2" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkC2" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("C2") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M3" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkC3" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("C3") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M4" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkC4" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("C4") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M5" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkC5" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("C5") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M6" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkC6" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("C6") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M7" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkC7" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("C7") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M8" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkC8" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("C8") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M9" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkC9" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("C9") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M10" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkC10" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("C10") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M11" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkC11" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("C11") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="M12" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkC12" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("C12") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="right"></ItemStyle>
                                <FooterStyle HorizontalAlign="right" />
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" />
                    </asp:GridView>
                </asp:Panel>
                <asp:HiddenField ID="hdnSelectedClientID" runat="server" Value="0" />
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnConverttoXL" />
                <asp:PostBackTrigger ControlID="btnPrintAll" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <asp:HiddenField ID="hdnTargetCtlMailReport" runat="server" />
                <cc1:ModalPopupExtender ID="modalpopupsendemail" runat="server" PopupControlID="pnlMailReports"
                    TargetControlID="hdnTargetCtlMailReport" BackgroundCssClass="modalBackground"
                    CancelControlID="img1" DynamicServicePath="" Enabled="True">
                </cc1:ModalPopupExtender>
                <asp:Panel ID="pnlMailReports" BorderWidth="1px" Height="40%" Width="30%" CssClass="modalPopup dataheaderPopup"
                    runat="server" meta:resourcekey="pnlMailReportResource1" Style="display: none">
                    <asp:Panel ID="Panel5" runat="server" CssClass="dialogHeader" meta:resourcekey="Panel1Resource1">
                        <table class="w-100p">
                            <tr>
                                <td>
                                    <asp:Label ID="Label11" runat="server" Text="Email Report" meta:resourcekey="Label11Resource2"></asp:Label>
                                </td>
                                <td align="right">
                                    <img id="img1" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                        style="cursor: pointer;" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <table class="w-100p">
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="vertical-align: middle;">
                                <asp:Label ID="lblMailAddress" runat="server" Text="To: " meta:resourcekey="lblMailAddressResource1" />
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtMailAddress" TextMode="MultiLine" Width="300px" Height="40px"
                                    runat="server" meta:resourcekey="txtMailAddressResource1" />
                                <p style="margin: 2px 0 5px 0; font-size: 11px; color: #666;">
                                    <asp:Label ID="lblMailAddressHint" runat="server" Text="example: abc@example.com, def@example.com"
                                        meta:resourcekey="lblMailAddressHintResource1" />
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                    <ProgressTemplate>
                                        <asp:Image ID="imgProgressbars" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                        <asp:Label ID="Rs_Pleasewaits" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <asp:Button ID="Send" runat="server" Text="Send" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClientClick="javascript:return CheckEmpty();"
                                    OnClick="btnSendMailReport_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HiddenField ID="hdnClientEmail" runat="server" />
                                <asp:HiddenField ID="hdnCountryID" runat="server" Value="0" />
                                <asp:HiddenField ID="hdnOrgID" runat="server" Value="0" />
                                <asp:HiddenField ID="hdnType" runat="server" Value="0" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
