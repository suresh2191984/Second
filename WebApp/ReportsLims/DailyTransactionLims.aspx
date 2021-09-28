<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DailyTransactionLims.aspx.cs"
    Inherits="ReportsLims_DailyTransactionLims" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script language="javascript" type="text/javascript">
        function validateToDate() {

            if (document.getElementById('<%= txtFDate.ClientID %>').value == '') {
                alert('Provide / select value for From date');
                document.getElementById('<%= txtFDate.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%= txtTDate.ClientID %>').value == '') {
                alert('Provide / select value for To date');
                document.getElementById('<%= txtTDate.ClientID %>').focus();
                return false;
            }
        }
        function popupprint() {
            var prtContent = document.getElementById('prnReport');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
      
    </script>

    <style type="text/css">
        .ui-datepicker
        {
            font-size: 8pt !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">

                   <%--  <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

                        <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>

                        <script type="text/javascript">
                            $(function() {
                                $("#txtFDate").datepicker({
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '2008:2030'
                                });
                                $("#txtTDate").datepicker({
                                    changeMonth: true,
                                    changeYear: true,
                                    maxDate: 0,
                                    yearRange: '2008:2030'
                                })
                            });
                        </script>

                        <table id="tblCollectionOPIP" class="a-center w-100p">
                            <tr class="a-center">
                                <td>
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <ContentTemplate>
                                            <div class="dataheaderWider">
                                                <table id="tbl">
                                                    <tr>
                                                        <td class="w-7p">
                                                            <asp:Label ID="lblOrgs" runat="server" Text="Organization : "></asp:Label>
                                                        </td>
                                                        <td class="w-10p">
                                                            <asp:DropDownList ID="ddlTrustedOrg" runat="server" CssClass="ddl">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td id="Td3" class="w-5p" runat="server">
                                                            <asp:Label ID="lblLocation" Text="Location : " Font-Bold="false" runat="server"></asp:Label>
                                                        </td>
                                                        <td id="Td4" class="w-10p" runat="server">
                                                            <asp:DropDownList ID="drpLocation" runat="server" CssClass="ddlsmall">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblPatientName" Text="Patient Name:" runat="server" meta:resourcekey="lblResource1"></asp:Label>
                                                            <asp:TextBox ID="txtPatientName" CssClass="Txtboxsmall w-100" runat="server"
                                                                meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                                                        </td>
                                                        <td class="a-left w-12p">
                                                            <asp:Label ID="Rs_FromDate" Text="From date:" runat="server"></asp:Label>
                                                            <asp:TextBox ID="txtFDate" CssClass="Txtboxsmall" Width="70px" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                        </td>
                                                        <td class="w-12p">
                                                            <asp:Label ID="Rs_ToDate" Text="To date :" runat="server"></asp:Label>
                                                            <asp:TextBox ID="txtTDate" CssClass="Txtboxsmall w-70" runat="server" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClick="btnSubmit_Click" OnClientClick="javascript:return validateToDate();" />
                                                        </td>
                                                        <td>
                                                            <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                                ToolTip="Save As Excel" OnClick="imgBtnXL_Click" />
                                                        </td>
                                                        <td class="a-left">
                                                            <asp:LinkButton ID="lnkBack" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                                OnClick="lnkBack_Click">Back&nbsp;&nbsp;</asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <div id="progressBackgroundFilter" class="a-center">
                                                    </div>
                                                    <div id="processMessage" class="a-center w-20p">
                                                        <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                                    </div>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                            <div id="divPrint" style="display: none;" runat="server">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="a-right paddingR10" style="color: #000000;">
                                                            <b id="printText" runat="server">
                                                                <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server"></asp:Label></b>
                                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                                ToolTip="Print" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="prnReport">
                                                <asp:GridView ID="grdDailyTransReport" runat="server" AutoGenerateColumns="False"
                                                     CssClass="dataheader2 w-100p gridView">
                                                    <Columns>
                                                        <asp:BoundField DataField="PatientNumber" HeaderText="PatientNumber"></asp:BoundField>
                                                        <asp:BoundField DataField="VisitNumber" HeaderText="VisitNumber"></asp:BoundField>
                                                        <asp:BoundField DataField="RegistrationDate" HeaderText="Reg. Date"></asp:BoundField>
                                                        <asp:BoundField DataField="PatientName" HeaderText="Patient Name" ItemStyle-HorizontalAlign="Left">
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Location" HeaderText="Centre" ItemStyle-HorizontalAlign="Left">
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="ClientName" HeaderText="Corporate Name" ItemStyle-HorizontalAlign="Left">
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="TotalAmount" HeaderText="Total Billed Amount"></asp:BoundField>
                                                        <asp:BoundField DataField="Discount" HeaderText="Discount"></asp:BoundField>
                                                        <asp:BoundField DataField="NetValue" HeaderText="Net amount" />
                                                        <asp:BoundField DataField="ReceivedAmount" HeaderText="Amount Received" />
                                                        <asp:BoundField DataField="AmountRefund" HeaderText="Refund" />
                                                        <asp:BoundField DataField="TaxAmount" HeaderText="Balance" />
                                                        <asp:BoundField DataField="Cash" HeaderText="Cash"></asp:BoundField>
                                                        <asp:BoundField DataField="Cards" HeaderText="Card"></asp:BoundField>
                                                        <asp:BoundField DataField="Cheque" HeaderText="Cheque"></asp:BoundField>
                                                        <asp:BoundField DataField="PhysicianName" HeaderText="Doctor Name"></asp:BoundField>
                                                        <asp:BoundField DataField="UserName" HeaderText="UID"></asp:BoundField>
                                                    </Columns>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                </asp:GridView>
                                            </div>
                                            <div id="breakup" runat="server">
                                                <table id="tabGranTotal" runat="server" visible="False" class="dataheaderWider w-100p"
                                                     style="color: #000000;" height="80%">
                                                    <tr runat="server" align="right">
                                                        <td class="a-right w-90p" runat="server">
                                                            <asp:Label ID="Rs_TotalCardAmount" Text="Total Amount" runat="server"></asp:Label>
                                                            <label id="Label1" style="color: Green;" runat="server">
                                                                (A)</label>
                                                            :
                                                        </td>
                                                        <td class="a-center w-30p" runat="server">
                                                            <label id="lblCardTotal" runat="server">
                                                            </label>
                                                        </td>
                                                        <td class="a-right" runat="server">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:PostBackTrigger ControlID="imgBtnXL" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />     
    </form>
</body>
</html>
