<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TSPOutstandingDetailsMIS.aspx.cs"
    Inherits="Ledger_TSPOutstandingDetailsMIS" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="~/CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/HospitalBillSearch.ascx" TagName="BillSearch"
    TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        .message-text
        {
            display: block;
        }
        .message-dismiss.pull-right.ui-icon.ui-icon-circle-close
        {
            display: none;
        }
        .m-auto
        {
            margin: 0 auto;
        }
        .tblledgertsp
        {
            border: 1px solid #547d97;
            margin-top: 10px;
        }
        .tblledgertsp .colorforcontent td
        {
            padding: 5px 0;
        }
        .b-Lgreen
        {
            background: none repeat scroll 0 0 #F1F8F1;
        }
        .b-White
        {
            background: none repeat scroll 0 0 #FFFFFF;
        }
    </style>
</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <asp:UpdatePanel ID="uplmonthcls" runat="server">
        <ContentTemplate>
        
            <div class="contentdata" style="text-align: center">
                <asp:Panel ID="pnlFilter" runat="server" CssClass="defaultfontcolor w-100p">
                    <div class="w-100p searchPanel">
                        <table>
                            <tr class="panelHeader">
                                <td class="colorforcontent w-100p" align="center" style="height: 23px">
                                    <asp:Label ID="Rs_FilterResult2" runat="server" Text=" Client Month Closing Ledger"
                                        meta:resourcekey="Rs_FilterResult2Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <table class="w-100p m-auto">
                            <tr class="a-center">
                                <td style="width: 70%">
                                    <asp:Label ID="Rs_From" Text="From Month" Font-Bold="true" runat="server"></asp:Label>
                                    <asp:TextBox ID="txtFrom" runat="server"  CssClass="small"></asp:TextBox>
                                    <%-- <img alt="" src="../StyleSheets_New/start/images/calendar.gif" />--%>
                                    <%-- <asp:DropDownList ID="ddlFrom" runat="server">
                                        <asp:ListItem Value="01/01/2015">January 2015</asp:ListItem>
                                        <asp:ListItem Value="01/02/2015">February 2015</asp:ListItem>
                                        <asp:ListItem Value="01/03/2015">March 2015</asp:ListItem>
                                        <asp:ListItem Value="01/04/2015">April 2015</asp:ListItem>
                                        <asp:ListItem Value="01/05/2015">May 2015</asp:ListItem>
                                        <asp:ListItem Value="01/06/2015">June 2015</asp:ListItem>
                                        <asp:ListItem Value="01/07/2015">July 2015</asp:ListItem>
                                        <asp:ListItem Value="01/08/2015">August 2015</asp:ListItem>
                                        <asp:ListItem Value="01/09/2015">September 2015</asp:ListItem>
                                        <asp:ListItem Value="01/10/2015">October 2015</asp:ListItem>
                                        <asp:ListItem Value="01/11/2015">November 2015</asp:ListItem>
                                        <asp:ListItem Value="01/12/2015">December 2015</asp:ListItem>
                                    </asp:DropDownList>--%>
                                    &nbsp;<asp:Label ID="Rs_To" Text="To Month" Font-Bold="true" runat="server"></asp:Label>
                                    <asp:TextBox ID="txtTo" runat="server"  CssClass="small"></asp:TextBox>
                                    <%-- <img alt="" src="../StyleSheets_New/start/images/calendar.gif" />--%>
                                    <%--<asp:DropDownList ID="ddlTo" runat="server">
                                        <asp:ListItem Value="01/01/2015">January 2015</asp:ListItem>
                                        <asp:ListItem Value="01/02/2015">February 2015</asp:ListItem>
                                        <asp:ListItem Value="01/03/2015">March 2015</asp:ListItem>
                                        <asp:ListItem Value="01/04/2015">April 2015</asp:ListItem>
                                        <asp:ListItem Value="01/05/2015">May 2015</asp:ListItem>
                                        <asp:ListItem Value="01/06/2015">June 2015</asp:ListItem>
                                        <asp:ListItem Value="01/07/2015">July 2015</asp:ListItem>
                                        <asp:ListItem Value="01/08/2015">August 2015</asp:ListItem>
                                        <asp:ListItem Value="01/09/2015">September 2015</asp:ListItem>
                                        <asp:ListItem Value="01/10/2015">October 2015</asp:ListItem>
                                        <asp:ListItem Value="01/11/2015">November 2015</asp:ListItem>
                                        <asp:ListItem Value="01/12/2015">December 2015</asp:ListItem>
                                    </asp:DropDownList>--%>
                                    <asp:HiddenField ID="hdnClientID" runat="server" />
                                    <asp:HiddenField ID="hdnClientValue" runat="server" />
                                    <asp:HiddenField ID="hdnClientDet" runat="server" />
                                    <asp:Label ID="lblClientName" Font-Bold="true" Text="Client Name/Code" runat="server"></asp:Label>
                                    <asp:TextBox ID="txtClientName" runat="server" autocomplete="off" CssClass="medium"></asp:TextBox>
                                    <img align="middle" alt="" src="../Images/starbutton.png" id="imgMandatory" runat="server" />
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                        MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="FetchClientNameForBilling"
                                        OnClientItemSelected="SetClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                        OnClientItemOver="SelectedOver" Enabled="True">
                                    </cc1:AutoCompleteExtender>
                                    <asp:Button ID="btnSearch" runat="server" TabIndex="4" Text="GO" CssClass="btn" meta:resourcekey="btnChangeResource2"
                                        OnClientClick="return TextBoxvalueCheck();" OnClick="btnSearch_Click" />
                                    <asp:Button ID="btnReset" runat="server" TabIndex="4" Text="Reset" CssClass="btn"
                                        OnClick="btnReset_Click" meta:resourcekey="btnChangeResource2" />
                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                        Visible="false" ToolTip="Save As Excel" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                    <asp:LinkButton ID="lnkXL" Text="Export To Excel" Font-Underline="True" runat="server"
                                        Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel" meta:resourcekey="lnkExportXLResource1"
                                        OnClick="lnkXL_Click" Visible="false"></asp:LinkButton>
                                </td>
                                <td style="width: 10%">
                                </td>
                            </tr>
                        </table>
                        <table class="w-90p m-auto">
                            <tr class="a-center" id="trerror" runat="server" style="display: none; height: 15px">
                                <td style="width: 46%">
                                </td>
                                <td class="a-center" style="width: 20%" align="left">
                                    <asp:Label ID="lblerror" runat="server" Text=" * Client Name/Client Code is mandatory!"
                                        ForeColor="Red"></asp:Label>
                                </td>
                                <td style="width: 24%">
                                </td>
                            </tr>
                        </table>
                    </div>
                     <asp:Panel ID="pnlPrint" runat="server" CssClass="defaultfontcolor w-100p">
                    <div id="divClientName" style="display: none" runat="server">
                        <table class="w-100p">
                            <tr>
                                <td style="width: 5%">
                                </td>
                                <td class="w-90p">
                                    <table class="w-100p gridView">
                                        <tr >
                                            <td colspan="6" style="background-color:#446D87; ">
                                               <asp:label id = "lbl" runat="server" Text="LEDGER DETAILS" ForeColor = "White" Font-Bold= "true"></asp:label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="b-Lgreen">
                                                <asp:Label ID="lblhdrEMD" runat="server" CssClass="bold" Text="EMD/CL" nowrap="nowrap"></asp:Label>
                                            </td>
                                            <td align="left" class="b-White">
                                                <asp:Label ID="lblrstEMD" runat="server" nowrap="nowrap"></asp:Label>
                                            </td>
                                            <td class="b-Lgreen">
                                                <asp:Label ID="lblhdrAddress" runat="server" CssClass="bold" Text="Address" nowrap="nowrap"></asp:Label>
                                            </td>
                                            <td colspan="3" align="left" class="b-White">
                                                <asp:Label ID="lblrstAddress" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="b-Lgreen" style="width: 10%">
                                                <asp:Label ID="lblhdrPincode" runat="server" CssClass="bold" Text="PinCode" nowrap="nowrap"></asp:Label>
                                            </td>
                                            <td class="a-left b-White" style="width: 15%">
                                                <asp:Label ID="lblrstPinCode" runat="server"></asp:Label>
                                            </td>
                                            <td class="b-Lgreen" style="width: 15%">
                                                <asp:Label ID="lblhdrContactNo" runat="server" CssClass="bold" Text="ContactNo" nowrap="nowrap"></asp:Label>
                                            </td>
                                            <td class="a-left b-White" style="width: 30%">
                                                <asp:Label ID="lblrstContactNo" runat="server"></asp:Label>
                                            </td>
                                            <td class="b-Lgreen" style="width: 10%">
                                                <asp:Label ID="lblhdrPanNo" runat="server" CssClass="bold" Text="PanNo" nowrap="nowrap"></asp:Label>
                                            </td>
                                            <td class="a-left b-White" style="width: 20%">
                                                <asp:Label ID="lblrstPanNo" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 5%">
                                </td>
                            </tr>
                        </table>
                    </div>
                    <br />
                    <div id="divMessage" runat="server" class="hide">
                        <div class="ui-state-highlight ui-corner-all">
                            <p>
                                <span class="ui-icon ui-icon-info pull-left v-top"></span>
                                <asp:Label ID="lblErrMsg" CssClass="message-text a-left" runat="server"></asp:Label>
                                <a href="#" class="message-dismiss pull-right ui-icon ui-icon-circle-close">Dismiss</a>
                            </p>
                        </div>
                    </div>
                    <div class="w-100p" id="divGridHeaderFooter" style="display: none" runat="server">
                        <table class="w-100p">
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Label ID="Header" Text="Ledger Details From - " runat="server" Font-Bold="true"
                                        ForeColor="Blue"></asp:Label><asp:Label ID="lblDispFromdate" runat="server" Font-Bold="true"
                                            ForeColor="Red"></asp:Label>&nbsp;<asp:Label ID="Header3" Text="   To  " runat="server"
                                                Font-Bold="true" ForeColor="Blue"></asp:Label>
                                    <asp:Label ID="lblDispTodate" runat="server" Font-Bold="true" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table class="w-100p">
                            <tr class="a-center">
                                <td class="w-5p">
                                </td>
                                <td class="w-90p">
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <ContentTemplate>
                                            <div id="divPrint" runat="server">
                                                <asp:Label ID="Label1" CssClass="red" runat="server"></asp:Label>
                                                <asp:GridView ID="grdMonthClosing" runat="server" AllowPaging="True" AutoGenerateColumns="false"
                                                    CssClass="gridView a-center w-80p" DataKeyNames="ClientCode" meta:resourceKey="grdResultResource1"
                                                    OnPageIndexChanging="grdMonthClosing_PageIndexChanging" PageSize="5" Width="100%">
                                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                        PageButtonCount="5" PreviousPageText="" />
                                                    <PagerStyle BackColor="White" ForeColor="Red" HorizontalAlign="Center" />
                                                    <Columns>
                                                        <asp:BoundField DataField="date" DataFormatString="{0:dd/MMM/yyyy}" HeaderStyle-VerticalAlign="Middle"
                                                            HeaderText="Date" meta:resourceKey="BoundFieldResource2">
                                                            <ItemStyle HorizontalAlign="center" CssClass="w-10p" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="clientCode" HeaderStyle-VerticalAlign="Middle" HeaderText="Client Name"
                                                            meta:resourceKey="BoundFieldResource2">
                                                            <ItemStyle HorizontalAlign="left" Width="28%" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="openingBalance" DataFormatString="{0:0.00}" HeaderText="Opening Balance"
                                                            meta:resourceKey="BoundFieldResource3">
                                                            <HeaderStyle CssClass="a-center" HorizontalAlign="Center" />
                                                            <ItemStyle CssClass="w-10p" HorizontalAlign="right" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="bill" DataFormatString="{0:0.00}" HeaderText="Bills" meta:resourceKey="BoundFieldResource7">
                                                            <HeaderStyle CssClass="w-10p a-center" HorizontalAlign="Left" />
                                                            <ItemStyle CssClass="w-10p" HorizontalAlign="right" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="debit" DataFormatString="{0:0.00}" HeaderText="Debit"
                                                            meta:resourceKey="BoundFieldResource7">
                                                            <HeaderStyle CssClass="w-10p a-center" HorizontalAlign="Center" />
                                                            <ItemStyle CssClass="w-10p" HorizontalAlign="right" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="credit" DataFormatString="{0:0.00}" HeaderText="Credit"
                                                            ItemStyle-Width="3%">
                                                            <HeaderStyle CssClass="w-10p a-center" HorizontalAlign="Left" />
                                                            <ItemStyle CssClass="w-10p" HorizontalAlign="right" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="receipt" DataFormatString="{0:0.00}" HeaderText="Receipt"
                                                            ItemStyle-CssClass="w-3p">
                                                            <HeaderStyle CssClass="w-10p a-center" HorizontalAlign="Left" />
                                                            <ItemStyle CssClass="w-10p" HorizontalAlign="right" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="outstanding" DataFormatString="{0:0.00}" HeaderText="Closing Balance"
                                                            ItemStyle-CssClass="w-20p" ItemStyle-HorizontalAlign="center">
                                                            <HeaderStyle CssClass="w-20p a-center" HorizontalAlign="center" VerticalAlign="Middle" />
                                                            <ItemStyle CssClass="w-20p" HorizontalAlign="right" />
                                                        </asp:BoundField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:PostBackTrigger ControlID="imgBtnXL" />
                                            <asp:PostBackTrigger ControlID="lnkXL" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                                <td class="w-5p">
                                </td>
                            </tr>
                        </table>
                        <table class="w-100p">
                            <tr>
                                <td class="w-5p">
                                </td>
                                <td class="w-90p">
                                    <table class="w-100p gridView">
                                        <tr>
                                            <td class="w-48p">
                                                <asp:Label ID="Total" runat="server" Font-Bold="true" Text="Total"></asp:Label>
                                            </td>
                                            <td class="w-10p a-right">
                                                <asp:Label ID="lblTotBills" runat="server" Font-Bold="true"></asp:Label>
                                            </td>
                                            <td class="w-10p a-right">
                                                <asp:Label ID="lblTotDebit" runat="server" Font-Bold="true"></asp:Label>
                                            </td>
                                            <td class="w-10p a-right">
                                                <asp:Label ID="lblTotCredit" runat="server" Font-Bold="true"></asp:Label>
                                            </td>
                                            <td class="w-10p a-right">
                                                <asp:Label ID="lblTotReceipt" runat="server" Font-Bold="true"></asp:Label>
                                            </td>
                                            <td class="w-12p a-right">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="w-5p">
                                </td>
                            </tr>
                        </table>
                        <table class="w-100p m-auto">
                            <tr>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td class="w-5p">
                                </td>
                                <td class="w-90p">
                                    <table class="w-100p gridView">
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" Font-Bold="True" ID="lblOpbalance" Text="Opening Balance"></asp:Label>
                                            </td>
                                            <td align="right">
                                                <asp:Label runat="server" Font-Bold="True" ID="lblTotOpningBalance" ForeColor="Red"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label runat="server" Font-Bold="True" ID="lblClbalance" Text="Closing Balance"></asp:Label>
                                            </td>
                                            <td align="right">
                                                <asp:Label runat="server" Font-Bold="True" ID="lblTotClosingBalance" ForeColor="Red"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="w-5p">
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table class="w-100p m-auto a-center">
                            <tr>
                                <td>
                                    <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn w-10p" Style="height: 25px"
                                        OnClientClick="return PrintPanel();" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    </asp:Panel>
                   
                </asp:Panel>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <Attune:Attunefooter ID="Footer1" runat="server" />
    </form>

    <script type="text/javascript" language="javascript">

        function FromDateCheck() {
            if ($("#txtFrom").val() != null) {
                if ($("#txtFrom").val() != '') {
                    var obj = $("#txtFrom").val();

                    var currentTime;
                    if (obj != '' && obj != '01/01/1901' && obj != '__/__/____' && obj != 'dd/MM/yyyy') {
                        dobDt = obj.split('/');
                        var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
                        var mMonth = dobDtTime.getMonth() + 1;
                        var mDay = dobDtTime.getDate();
                        var mYear = dobDtTime.getFullYear();
                        currentTime = new Date();
                        var month = currentTime.getMonth() + 1;
                        var day = currentTime.getDate();
                        var year = currentTime.getFullYear();
                        var CurrentFullDate = day + "/" + month + "/" + year;
                        if (mYear == year && mMonth == month && mDay > day) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtFrom").val(CurrentFullDate);

                            //$("#DateTimePicker1_CalendarExtender12_popupDiv").datepicker("setDate", currentTime);
                            //calendarObj.datepicker("setDate", CurrentFullDate);
                            return false;
                        }
                        else if (mYear > year) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtFrom").val(CurrentFullDate);
                            return false;
                        }
                        else if (mYear == year && mMonth > month) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtFrom").val(CurrentFullDate);
                            //$("#txtFrom").IsSelectable = false;
                            return false;
                        }
                    }

                }

            }

        }



        function DateCheck() {
            //debugger;

            var varFrom = document.getElementById('txtFrom').value;
            var varTo = document.getElementById('txtTo').value;
            var fromdate, todate, dt1, dt2, mon1, mon2, yr1, yr2, date1, date2;
            var chkFrom = varFrom;
            var chkTo = varTo;
            if (document.getElementById('txtFrom').value == '') {
                alert('From date should not be empty');
                document.getElementById('txtFrom').value = '';
                document.getElementById('txtFrom').focus();
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {
                alert('To date should not be empty');
                document.getElementById('txtTo').value = '';
                document.getElementById('txtTo').focus();
                return false;
            }

            fromdate = document.getElementById('txtFrom').value;
            todate = document.getElementById('txtTo').value;
            dt1 = parseInt(fromdate.substring(0, 2), 10);
            mon1 = parseInt(fromdate.substring(3, 5), 10);
            yr1 = parseInt(fromdate.substring(6, 10), 10);
            dt2 = parseInt(todate.substring(0, 2), 10);
            mon2 = parseInt(todate.substring(3, 5), 10);
            yr2 = parseInt(todate.substring(6, 10), 10);
            date1 = new Date(yr1, mon1, dt1);
            date2 = new Date(yr2, mon2, dt2);

            if (date2 <= date1) {
                alert("To date Should be greater than From date");
                document.getElementById('txtTo').value = '';
                return false;
            }

            if ($("#txtTo").val() != null) {
                if ($("#txtTo").val() != '') {
                    var obj = $("#txtTo").val();

                    var currentTime;
                    if (obj != '' && obj != '01/01/1901' && obj != '__/__/____' && obj != 'dd/MM/yyyy') {
                        dobDt = obj.split('/');
                        var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
                        var mMonth = dobDtTime.getMonth() + 1;
                        var mDay = dobDtTime.getDate();
                        var mYear = dobDtTime.getFullYear();
                        currentTime = new Date();
                        var month = currentTime.getMonth() + 1;
                        var day = currentTime.getDate();
                        var year = currentTime.getFullYear();
                        var CurrentFullDate = day + "/" + month + "/" + year;
                        if (mYear == year && mMonth == month && mDay > day) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtTo").val(CurrentFullDate);

                            //$("#DateTimePicker1_CalendarExtender12_popupDiv").datepicker("setDate", currentTime);
                            //calendarObj.datepicker("setDate", CurrentFullDate);
                            return false;
                        }
                        else if (mYear > year) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtTo").val(CurrentFullDate);
                            return false;
                        }
                        else if (mYear == year && mMonth > month) {
                            alert('Selected date should not be greater than currentdate');
                            $("#txtTo").val(CurrentFullDate);
                            //$("#txtTo").IsSelectable = false;
                            return false;
                        }
                    }

                }

            }

            return true;


        }


        function SelectedOver(source, eventArgs) {
            $find('AutoCompleteExtender1')._onMethodComplete = function(result, context) {
                //var Perphysicianname = document.getElementById('txtperphy').value;
                $find('AutoCompleteExtender1')._update(context, result, /* cacheResults */false);
                if (result == "") {
                    alert('Please select from the list');
                    document.getElementById('txtClientName').value = '';
                    document.getElementById('<%=hdnClientID.ClientID %>').value = '';
                    document.getElementById('<%=hdnClientValue.ClientID %>').value = '';
                }
            };
        }
        function SetClientID(source, eventArgs) {
            //alert(eventArgs.get_value());
            var list = eventArgs.get_value().split('^');
            document.getElementById('<%=hdnClientID.ClientID %>').value = list[3];
            document.getElementById('<%=hdnClientValue.ClientID %>').value = list[5];

        }
        function TextBoxvalueCheck() {

            // var txtval = document.getElementById('txtClientName').value;
            if (document.getElementById('txtClientName').value == '') {
                // lbl = document.getElementById('lblerror')
                trerror.style.display = '';
                return false;
            }
            else {
                trerror.style.display = 'none';
                return true;
            }
        }
        function PrintPanel() {

           
            var panel = document.getElementById("<%=pnlPrint.ClientID %>");
            var printWindow = window.open('', '', 'height=400,width=800');
            printWindow.document.write('<html><head><title>TSP Ledger Outstanding Report </title>');
            printWindow.document.write('</head><body style="text-align: center">');
            printWindow.document.write(panel.innerHTML);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            setTimeout(function() {
                printWindow.print();
            }, 500);
            return false;
        }
        Sys.Application.add_load(PageLoaded);
        function PageLoaded(sender, args) {
            $(function() {
                $('#txtFrom,#txtTo').datepicker({
                    changeMonth: true,
                    changeYear: true,
                    showButtonPanel: true,
                    yearRange: '-2:+0',
                    dateFormat: 'MM yy'
                }).focus(function() {
                    var thisCalendar = $(this);
                    $('.ui-datepicker-calendar').detach();
                    $('.ui-datepicker-close').click(function() {
                        var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                        var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                        thisCalendar.datepicker('setDate', new Date(year, month, 1));

                    });
                });
            });
        }
    </script>
     <script type="text/javascript">
//         $(document).ready(function() {
//             Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(PageLoaded)
//         });
         //Sys.Application.add_load(PageLoaded);
//         function PageLoaded(sender, args) {
//             $(function() {
//                 $('#txtFrom,#txtTo').datepicker({
//                     changeMonth: true,
//                     changeYear: true,
//                     showButtonPanel: true,
//                     yearRange: '-2:+0',
//                     dateFormat: 'MM yy'
//                 }).focus(function() {
//                     var thisCalendar = $(this);
//                     $('.ui-datepicker-calendar').detach();
//                     $('.ui-datepicker-close').click(function() {
//                         var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
//                         var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
//                         thisCalendar.datepicker('setDate', new Date(year, month, 1));

//                     });
//                 });
//             });
//         }

</script>

</body>
</html>
