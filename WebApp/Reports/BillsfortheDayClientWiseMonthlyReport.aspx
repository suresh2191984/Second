<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillsfortheDayClientWiseMonthlyReport.aspx.cs"
    Inherits="Reports_BillsfortheDayClientWiseMonthlyReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Bills for the day Client Wise Monthly Report</title>

    <script language="javascript" type="text/javascript">

        function CheckEmpty() {
            var Check = document.getElementById("txtMailAddress").value;
            if (Check == "") {
                alert("Enter Email Address");
                return false;
            }
            return true;

        }

        function Validate() {
            var e = document.getElementById("txtClient").value;
            if (e == "") {
                document.getElementById('hdnSelectedClientID').value = "0";
            }
        }

        function getCountryID() {
            document.getElementById("txtClient").value = "";
            var e = document.getElementById("ddlCountry");
            var ddlCountry = e.options[e.selectedIndex].value;
            document.getElementById("hdnCountryID").value = ddlCountry;
        }

        function getOrgID() {
            document.getElementById('<%=divPrint1.ClientID%>').style.display = "none";
            document.getElementById('<%=pnl.ClientID%>').style.display = "none";
            //document.getElementById("txtClient").value = "";
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
                    <table class="w-60p" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <asp:Label ID="lblOrg" runat="server" Text="Select Organization"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlOrganization" runat="server" onchange="getOrgID();" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged"
                                    AutoPostBack="true">
                                </asp:DropDownList>
                            </td>
                            <td visible="false">
                                <asp:Label ID="lblCountry" Text="Select Country" Visible="false" runat="server"></asp:Label>
                            </td>
                            <td visible="false">
                                <asp:DropDownList ID="ddlCountry" Visible="false" runat="server" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged"
                                    AutoPostBack="true">
                                </asp:DropDownList>
                            </td>
                            <td nowrap="nowrap" visible="false">
                                <asp:Label ID="Rs_ClientName" runat="server" Text="Client Name" Visible="false"></asp:Label>
                            </td>
                            <td id="tdClientParttxt" runat="server" visible="false">
                                <asp:TextBox ID="txtClient" runat="server" Visible="false" autocomplete="off" Width="200px"
                                    CssClass="AutoCompletesearchBox"></asp:TextBox>
                                <cc1:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" CompletionInterval="1"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                    Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2" OnClientItemSelected="ItemClientSelected"
                                    UseContextKey="true" ServiceMethod="GetCountryWiseClientNames" ServicePath="~/Webservice.asmx"
                                    TargetControlID="txtClient">
                                </cc1:AutoCompleteExtender>
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

                <script language="javascript" type="text/javascript">

                    function filter(term, GvId, flag) {


                        var SearchOn = '#' + SearchOn;
                        var cellNr = $(SearchOn).find('input:checked').val();
                        //alert(term);
                        var suche = term.value.toLowerCase();

                        if (flag == 0) {

                            suche = '';
                            term.value = '';
                            term.focus();
                        }
                        var table = document.getElementById(GvId);
                        var ele;

                        var sum1 = 0;
                        var sum2 = 0;
                        var sum3 = 0;
                        var sum4 = 0;
                        var sum5 = 0;
                        var sum6 = 0;
                        var sum7 = 0;
                        var sum8 = 0;
                        var sum9 = 0;
                        var sum10 = 0;
                        var sum11 = 0;
                        var sum12 = 0;
                        var x = (table.rows.length) - 1;
                        table.deleteRow(x);

                        var filter = document.getElementById("searchKey").value;
                        for (var r = 1; r < table.rows.length; r++) {
                            ele = table.rows[r].cells[filter].innerHTML.replace(/<[^>]+>/g, "");
                            if (ele.toLowerCase().indexOf(suche) >= 0) {
                                table.rows[r].style.display = '';
                                if (!isNaN(table.rows[r].cells[4].innerText)) {

                                    sum1 = (parseFloat(sum1) + parseFloat(table.rows[r].cells[4].innerText));
                                }
                                if (!isNaN(table.rows[r].cells[5].innerText)) {

                                    sum2 = (parseFloat(sum2) + parseFloat(table.rows[r].cells[5].innerText));
                                }
                                if (!isNaN(table.rows[r].cells[6].innerText)) {

                                    sum3 = (parseFloat(sum3) + parseFloat(table.rows[r].cells[6].innerText));
                                }
                                if (!isNaN(table.rows[r].cells[7].innerText)) {

                                    sum4 = (parseFloat(sum4) + parseFloat(table.rows[r].cells[7].innerText));
                                }
                                if (!isNaN(table.rows[r].cells[8].innerText)) {

                                    sum5 = (parseFloat(sum5) + parseFloat(table.rows[r].cells[8].innerText));
                                }
                                if (!isNaN(table.rows[r].cells[9].innerText)) {

                                    sum6 = (parseFloat(sum6) + parseFloat(table.rows[r].cells[9].innerText));
                                }

                                if (!isNaN(table.rows[r].cells[10].innerText)) {

                                    sum7 = (parseFloat(sum7) + parseFloat(table.rows[r].cells[10].innerText));
                                }

                                if (!isNaN(table.rows[r].cells[11].innerText)) {

                                    sum8 = (parseFloat(sum8) + parseFloat(table.rows[r].cells[11].innerText));
                                }

                                if (!isNaN(table.rows[r].cells[12].innerText)) {

                                    sum9 = (parseFloat(sum9) + parseFloat(table.rows[r].cells[12].innerText));
                                }
                                if (!isNaN(table.rows[r].cells[13].innerText)) {

                                    sum10 = (parseFloat(sum10) + parseFloat(table.rows[r].cells[13].innerText));
                                }
                                if (!isNaN(table.rows[r].cells[14].innerText)) {

                                    sum11 = (parseFloat(sum11) + parseFloat(table.rows[r].cells[14].innerText));
                                }
                                if (!isNaN(table.rows[r].cells[15].innerText)) {

                                    sum12 = (parseFloat(sum12) + parseFloat(table.rows[r].cells[15].innerText));
                                }
                            }
                            else {
                                table.rows[r].style.display = 'none';
                            }
                        }

                        var newRow = table.insertRow();
                        var i = 0;
                        for (i = 0; i < table.rows[0].cells.length; i++) {
                            var newCell = newRow.insertCell();

                        }

                        if (table.rows[0].cells.length > 1) {
                            table.rows[table.rows.length - 1].cells[1].innerHTML = "Total";
                            table.rows[table.rows.length - 1].cells[1].style.fontWeight = "bold";

                            table.rows[table.rows.length - 1].cells[4].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[4].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[4].innerHTML = Math.round(parseFloat(sum1).toFixed(2));

                            table.rows[table.rows.length - 1].cells[5].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[5].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[5].innerHTML = Math.round(parseFloat(sum2).toFixed(2));


                            table.rows[table.rows.length - 1].cells[6].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[6].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[6].innerHTML = Math.round(parseFloat(sum3).toFixed(2));


                            table.rows[table.rows.length - 1].cells[7].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[7].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[7].innerHTML = Math.round(parseFloat(sum4).toFixed(2));


                            table.rows[table.rows.length - 1].cells[8].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[8].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[8].innerHTML = Math.round(parseFloat(sum5).toFixed(2));


                            table.rows[table.rows.length - 1].cells[9].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[9].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[9].innerHTML = Math.round(parseFloat(sum6).toFixed(2));


                            table.rows[table.rows.length - 1].cells[10].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[10].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[10].innerHTML = Math.round(parseFloat(sum7).toFixed(2));


                            table.rows[table.rows.length - 1].cells[11].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[11].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[11].innerHTML = Math.round(parseFloat(sum8).toFixed(2));


                            table.rows[table.rows.length - 1].cells[12].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[12].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[12].innerHTML = Math.round(parseFloat(sum9).toFixed(2));


                            table.rows[table.rows.length - 1].cells[13].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[13].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[13].innerHTML = Math.round(parseFloat(sum10).toFixed(2));


                            table.rows[table.rows.length - 1].cells[14].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[14].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[14].innerHTML = Math.round(parseFloat(sum11).toFixed(2));


                            table.rows[table.rows.length - 1].cells[15].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[15].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[15].innerHTML = Math.round(parseFloat(sum12).toFixed(2));

                        }
                    }

                    //****************************************************************************

                    function clearFilter(GvId, flag) {

                        if (flag == 0) {

                            suche = '';

                        }
                        var table = document.getElementById(GvId);
                        var ele;

                        var sum1 = 0;
                        var sum2 = 0;
                        var sum3 = 0;
                        var sum4 = 0;
                        var sum5 = 0;
                        var sum6 = 0;
                        var sum7 = 0;
                        var sum8 = 0;
                        var sum9 = 0;
                        var sum10 = 0;
                        var sum11 = 0;
                        var sum12 = 0;



                        for (var r = 1; r < table.rows.length; r++) {

                            table.rows[r].style.display = '';
                            if (!isNaN(table.rows[r].cells[4].innerText)) {

                                sum1 = (parseFloat(sum1) + parseFloat(table.rows[r].cells[4].innerText));
                            }
                            if (!isNaN(table.rows[r].cells[5].innerText)) {

                                sum2 = (parseFloat(sum2) + parseFloat(table.rows[r].cells[5].innerText));
                            }
                            if (!isNaN(table.rows[r].cells[6].innerText)) {

                                sum3 = (parseFloat(sum3) + parseFloat(table.rows[r].cells[6].innerText));
                            }
                            if (!isNaN(table.rows[r].cells[7].innerText)) {

                                sum4 = (parseFloat(sum4) + parseFloat(table.rows[r].cells[7].innerText));
                            }
                            if (!isNaN(table.rows[r].cells[8].innerText)) {

                                sum5 = (parseFloat(sum5) + parseFloat(table.rows[r].cells[8].innerText));
                            }
                            if (!isNaN(table.rows[r].cells[9].innerText)) {

                                sum6 = (parseFloat(sum6) + parseFloat(table.rows[r].cells[9].innerText));
                            }

                            if (!isNaN(table.rows[r].cells[10].innerText)) {

                                sum7 = (parseFloat(sum7) + parseFloat(table.rows[r].cells[10].innerText));
                            }

                            if (!isNaN(table.rows[r].cells[11].innerText)) {

                                sum8 = (parseFloat(sum8) + parseFloat(table.rows[r].cells[11].innerText));
                            }

                            if (!isNaN(table.rows[r].cells[12].innerText)) {

                                sum9 = (parseFloat(sum9) + parseFloat(table.rows[r].cells[12].innerText));
                            }
                            if (!isNaN(table.rows[r].cells[13].innerText)) {

                                sum10 = (parseFloat(sum10) + parseFloat(table.rows[r].cells[13].innerText));
                            }
                            if (!isNaN(table.rows[r].cells[14].innerText)) {

                                sum11 = (parseFloat(sum11) + parseFloat(table.rows[r].cells[14].innerText));
                            }
                            if (!isNaN(table.rows[r].cells[15].innerText)) {

                                sum12 = (parseFloat(sum12) + parseFloat(table.rows[r].cells[15].innerText));
                            }


                        }

                        var newRow = table.insertRow();
                        var i = 0;
                        for (i = 0; i < table.rows[0].cells.length; i++) {
                            var newCell = newRow.insertCell();

                        }
                        if (table.rows[0].cells.length > 1) {
                            table.rows[table.rows.length - 1].cells[1].innerHTML = "Total";
                            table.rows[table.rows.length - 1].cells[1].style.fontWeight = "bold";

                            table.rows[table.rows.length - 1].cells[4].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[4].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[4].innerHTML = Math.round(parseFloat(sum1).toFixed(2));

                            table.rows[table.rows.length - 1].cells[5].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[5].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[5].innerHTML = Math.round(parseFloat(sum2).toFixed(2));


                            table.rows[table.rows.length - 1].cells[6].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[6].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[6].innerHTML = Math.round(parseFloat(sum3).toFixed(2));


                            table.rows[table.rows.length - 1].cells[7].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[7].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[7].innerHTML = Math.round(parseFloat(sum4).toFixed(2));


                            table.rows[table.rows.length - 1].cells[8].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[8].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[8].innerHTML = Math.round(parseFloat(sum5).toFixed(2));


                            table.rows[table.rows.length - 1].cells[9].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[9].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[9].innerHTML = Math.round(parseFloat(sum6).toFixed(2));


                            table.rows[table.rows.length - 1].cells[10].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[10].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[10].innerHTML = Math.round(parseFloat(sum7).toFixed(2));


                            table.rows[table.rows.length - 1].cells[11].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[11].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[11].innerHTML = Math.round(parseFloat(sum8).toFixed(2));


                            table.rows[table.rows.length - 1].cells[12].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[12].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[12].innerHTML = Math.round(parseFloat(sum9).toFixed(2));


                            table.rows[table.rows.length - 1].cells[13].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[13].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[13].innerHTML = Math.round(parseFloat(sum10).toFixed(2));


                            table.rows[table.rows.length - 1].cells[14].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[14].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[14].innerHTML = Math.round(parseFloat(sum11).toFixed(2));


                            table.rows[table.rows.length - 1].cells[15].innerHTML = "";
                            table.rows[table.rows.length - 1].cells[15].style.fontWeight = "bold";
                            table.rows[table.rows.length - 1].cells[15].innerHTML = Math.round(parseFloat(sum12).toFixed(2));
                        }

                    }
                                    
                                    
                </script>

                <asp:Panel ID="pnl" runat="server" ScrollBars="Vertical" CssClass="w-100p" Style="height: 500px;">
                    <table>
                        <tr>
                            <td style="font-weight: bold;">
                                Select Filter
                            </td>
                            <td>
                                <asp:DropDownList ID="searchKey" runat="server">
                                    <asp:ListItem Text="Client Code" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Client" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Country" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:TextBox ID="SearchTxt" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    <asp:GridView ID="grdResult" runat="server" CellPadding="4" AutoGenerateColumns="False"
                        DataKeyNames="ClientId" OnRowDataBound="grdResult_RowDataBound" ForeColor="#333333"
                        CssClass="gridView w-100p" EmptyDataText="Bills for the Day Not Available" meta:resourcekey="grdResultResource1">
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
                                    <asp:Label ID="lnkClientid" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                        Text='<%# Eval("Clientid") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="ClientCode" HeaderText="Client Code" Visible="true">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Client" HeaderStyle-Width="25%">
                                <ItemTemplate>
                                    <asp:Label ID="lnkClientName" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("ClientName") %>'
                                        runat="server"></asp:Label>
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
                        <table width="100%">
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
