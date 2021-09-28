<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MeanTATSummaryReport.aspx.cs"
    Inherits="Reports_MeanTATSummaryReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>MeanTAT Summary Report</title>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script language="javascript" type="text/javascript">

        function CheckEmpty() {
            var Check = document.getElementById("txtMailAddress").value;
            if (Check == "") {
                alert("Enter Email Address");
                return false;
            }
            return true;

        }

        function getCountryID() {
            document.getElementById("txtClient").value = "";
            var e = document.getElementById("ddlCountry");
            var ddlCountry = e.options[e.selectedIndex].value;
            if (ddlCountry == "--Select--") {
                document.getElementById("hdnCountryID").value = 0;
            }
            else {
                document.getElementById("hdnCountryID").value = ddlCountry;
            }
        }

        function ItemClientSelected(source, eventArgs) {

            var ClientCorpID;
            var list = eventArgs.get_value().split('^');
            ClientCorpID = list[0];
            document.getElementById('hdnSelectedClientID').value = ClientCorpID;

        }
        function getTypeID() {

            var e = document.getElementById("ddlType");
            var ddlType = e.options[e.selectedIndex].text;
            document.getElementById("hdnSearchType").value = ddlType;
        }

        function getTestTypeID() {

            var e = document.getElementById("ddlTestType");
            var ddlType = e.options[e.selectedIndex].text;
            document.getElementById("hdnTestType").value = ddlType;
        }

        function getDept() {
            var g = document.getElementById("ddlDept");
            var ddlDept = g.options[g.selectedIndex].value;
            document.getElementById("hdnDeptID").value = ddlDept;

        }
        function rdocheck() {
            if (document.getElementById('rdopostTAT').checked == true) {
                document.getElementById('tddept').style.display = 'block';
                document.getElementById('tddept1').style.display = 'block';
                document.getElementById('divPrint1').style.display = 'none';
                document.getElementById('Divpnl').style.display = 'none';
            }
            else {

                document.getElementById('tddept').style.display = 'none';
                document.getElementById('tddept1').style.display = 'none';
                document.getElementById('divPrint1').style.display = 'none';
                document.getElementById('Divpnl').style.display = 'none';
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
                <table id="tblCollectionOPIP" align="center" cellpadding="0" cellspacing="0" border="0"
                    class="w-100p">
                    <tr>
                        <td>
                            <asp:Panel ID="Panel1" runat="server" GroupingText="Weekly Mean TAT Summary" Width="25%">
                                <table class="searchPanel w-30p" cellpadding="3" style="border: 0px; border-color: Red"
                                    border="0" cellspacing="3">
                                    <tr>
                                        <td>
                                            <asp:RadioButton ID="rdopreTAT" runat="server" Text="Pre Analytical TAT Report" GroupName="GRP"
                                                onclick="rdocheck()" TabIndex="1" />
                                        </td>
                                        <td>
                                            <asp:RadioButton ID="rdopostTAT" runat="server" Text="Post Analytical TAT Report"
                                                GroupName="GRP" onclick="rdocheck()" TabIndex="2" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>
                                <table id="tblPatient" runat="server" class="w-100p searchPanel" border="0" cellpadding="0"
                                    cellspacing="0">
                                    <tr id="Tr1" runat="server">
                                        <td id="Td1" align="left" runat="server">
                                            <div style="display: block">
                                                <table border="0" cellpadding="0" cellspacing="0" class="w-100p">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblType" Text="Report Type" runat="server"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:DropDownList ID="ddlType" runat="server" CssClass="ddl" onchange="getTypeID();">
                                                                <asp:ListItem Text="Static" Value="0"></asp:ListItem>
                                                                <asp:ListItem Text="Dynamic" Value="1"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblTestType" Text="Test Type" runat="server"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:DropDownList ID="ddlTestType" runat="server" CssClass="ddl" onchange="getTestTypeID();">
                                                                <asp:ListItem Text="ALL" Value="ALL"></asp:ListItem>
                                                                <asp:ListItem Text="TESTWISE" Value="TESTWISE"></asp:ListItem>
                                                                <asp:ListItem Text="PROFILE" Value="PROFILE"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblCountry" Text="Country" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlCountry" runat="server" onchange="getCountryID();" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged"
                                                                AutoPostBack="true">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="Rs_ClientName" runat="server" Text="Client"></asp:Label>
                                                        </td>
                                                        <td id="tdClientParttxt" runat="server">
                                                            <asp:TextBox ID="txtClient" runat="server" autocomplete="off" Width="200px" CssClass="AutoCompletesearchBox"></asp:TextBox>
                                                            <cc1:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" CompletionInterval="1"
                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                Enabled="True" FirstRowSelected="True" MinimumPrefixLength="3" OnClientItemSelected="ItemClientSelected"
                                                                UseContextKey="true" ServiceMethod="GetCountryWiseClientNames" ServicePath="~/Webservice.asmx"
                                                                TargetControlID="txtClient">
                                                            </cc1:AutoCompleteExtender>
                                                        </td>
                                                        <td id="tddept" runat="server">
                                                            <asp:Label ID="lblDept" runat="server" Text="Dept"></asp:Label>
                                                        </td>
                                                        <td id="tddept1" runat="server">
                                                            <asp:DropDownList ID="ddlDept" runat="server" onchange="getDept();">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="Button1" runat="server" CssClass="btn" OnClick="btnSearch_Click"
                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Search" />
                                                        </td>
                                                        <td>
                                                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="details_label_age" Text="Back"
                                                                OnClick="lnkBack_Click"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="hdnSearchType" runat="server" Value="Static" />
                <asp:HiddenField ID="hdnTestType" runat="server" Value="ALL" />
                <asp:HiddenField ID="hdnDeptID" runat="server" Value="0" />
                <asp:UpdateProgress ID="Progressbar" runat="server">
                    <ProgressTemplate>
                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                        <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <div id="divPrint1" style="display: none;" runat="server">
                    <table cellpadding="0" cellspacing="0" border="0" class="w-100p">
                        <tr align="right">
                            <td id="tdexcel" style="padding-right: 10px; color: #000000;" runat="server">
                                <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="True" ForeColor="#000333"
                                    runat="server" meta:resourcekey="lbExcelResource1"></asp:Label>
                                <asp:ImageButton ID="btnConverttoXL" OnClick="btnConverttoXL_Click" runat="server"
                                    ImageUrl="~/Images/ExcelImage.GIF" meta:resourcekey="btnConverttoXLResource1" />
                                &nbsp;&nbsp;
                                <%-- </td>
                                            <td style="padding-right: 10px; color: #000000;">--%>
                                <b id="B1" runat="server">
                                    <asp:Label ID="Rs_PrintReport" Visible="true" Text="Print Report" runat="server"
                                        meta:resourcekey="Rs_PrintReportResource1"></asp:Label>
                                </b>
                                <asp:Button ID="btnPrintAll" runat="server" Text="Print" CssClass="btn" OnClick="btnPrintAll_Click" />
                                &nbsp;&nbsp;
                                <asp:Button ID="btnSendmail" runat="server" Text="Send Mail" CssClass="btn" OnClick="btnSendmail_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="Divpnl" runat="server">
                    <asp:Panel ID="pnl" runat="server" ScrollBars="Vertical" Style="width: 60%; height: 500px;"
                        Visible="false">
                        <asp:GridView ID="grdResult" AlternatingRowStyle-CssClass="trEven" runat="server"
                            CellPadding="4" AutoGenerateColumns="False" OnRowDataBound="grdResult_RowDataBound"
                            ForeColor="#333333" CssClass="gridView w-50p" EmptyDataText="Periodwise MeanTAT Not Available"
                            OnRowCreated="grdResult_RowCreated" ShowHeader="false">
                            <HeaderStyle CssClass="dataheader1" />
                            <Columns>
                                <asp:TemplateField HeaderText="SI.No" HeaderStyle-Width="3%">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Department" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnkDepartment" Style="font-family: Verdana; cursor: pointer;" Text='<%# Eval("Department") %>'
                                            runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Test / Profile">
                                    <ItemTemplate>
                                        <asp:Label ID="lnkFeeDescription" Style="font-family: Verdana; cursor: pointer;"
                                            Text='<%# Eval("Name") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="W1" HeaderText="W1">
                                    <HeaderStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" Width="5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="W2" HeaderText="W2">
                                    <HeaderStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" Width="5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="W3" HeaderText="W3">
                                    <HeaderStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" Width="5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="W4" HeaderText="W4">
                                    <HeaderStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" Width="5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="W5" HeaderText="W5">
                                    <HeaderStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" Width="5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="W6" HeaderText="W6">
                                    <HeaderStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" Width="5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="W7" HeaderText="W7">
                                    <HeaderStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" Width="5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="W8" HeaderText="W8">
                                    <HeaderStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" Width="5%" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </div>
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
                                <asp:HiddenField ID="hdnSelectedClientID" runat="server" Value="0" />
                                <asp:HiddenField ID="HiddenField1" runat="server" Value="0" />
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
