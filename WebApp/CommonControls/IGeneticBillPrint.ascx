<%@ Control Language="C#" AutoEventWireup="true" CodeFile="~/CommonControls/IGeneticBillPrint.ascx.cs"
    Inherits="CommonControls_IGeneticBillPrint" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<%@ Register Src="FinalBillHeader.ascx" TagName="FinalBillHeader" TagPrefix="uc3" %>
<style type="text/css">
    .style1
    {
        width: 10px;
    }
    tHead
    {
        display: table-header-group;
    }
    .style2
    {
        width: 4%;
        height: 18px;
    }
    .style4
    {
        width: 2%;
        height: 18px;
    }
    .style6
    {
        width: 4%;
        height: 18px;
    }
    .style8
    {
        width: 2%;
    }
</style>

<script type="text/javascript" language="javascript">
    function AddTHEAD() {
        var table = document.getElementById('<%=tblBillPrint1.ClientID %>');
        if (table != null) {
            var head = document.createElement("THEAD");
            head.style.display = "table-header-group";
            head.appendChild(table.rows[0]);
            table.insertBefore(head, table.childNodes[0]);

        }
    }
    window.onload = AddTHEAD;

</script>

<script runat="server">
    string _date;
    string GetDate(string Date)
    {
        if (Date != "01/Jan/1900")
        {
            if (Date != "01/Jan/1900 12:00:AM")
            {
                _date = Date;
            }
            else
            {
                _date = " ";
            }
        }
        else
        {
            _date = " ";
        }
        return _date;
    }
</script>
<div id="divBillprint" runat="server" >
<table width="100%" align="center" id="tblBillPrint1" style="font-family: Tahoma;
    font-weight: normal; font-size: 11px;" runat="server">
    <tr id="tbprint" runat="server">
        <td style="font-family: Titillium;">
            <table width="100%" id="tblHead1" runat="server" border="0" cellspacing="0" cellpadding="0"
                align="center">
                <tr>
                    <td align="left" valign="top" width="70%">
                        <asp:Image ID="imgBillLogo" runat="server" Visible="False" />
                    </td>
        
                   <%-- client logo strats --%>
                    <td id="tdClientLogo" align="left" valign="top" style="display:none" width="30%">
                        <img id="ClientLogo" runat="server" align="middle" alt="Logo Display" style="height:65px" ></img>
                    </td>
                     <%-- client logo ends --%>
                    <td valign="middle" align="right">
                        <asp:Label ID="lblTitleText" Text="BILL CUM RECEIPT" Style="background-color: Red;
                            color: White; font-size: x-large;" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <hr noshade="noshade" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                    </td>
                </tr>
                <tr>
                    <td id="tblPatientDetails1" runat="server" colspan="6">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td colspan="7" id="tdDupBill" runat="server" align="center" style="display: none">
                                    <asp:Label ID="lblTypeBill" Style="font-weight: bold;" runat="server"></asp:Label>
                                    <asp:Label ID="lblDupBill" Style="font-weight: bold;" Text="(Duplicate Copy)" Visible="False"
                                        runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 4%">
                                </td>
                                <td align="left" nowrap="nowrap" class="style6">
                                    <asp:Label ID="Rs_PatientName" Text="Name" runat="server" />
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 2%">
                                    &nbsp;:
                                </td>
                                <td align="left" nowrap="nowrap" class="style6">
                                    <span class="style6">
                                        <asp:Label ID="lblTitleName" runat="server" Style="font-weight: 700"></asp:Label>
                                        <asp:Label ID="lblName" runat="server" Style="font-weight: 700"></asp:Label>
                                    </span>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 3%;" class="style8">
                                    <asp:Label ID="Rs_BillDate" Text="Bill Date" runat="server" />
                                </td>
                                <td id="tdPhysician" runat="server" align="left" nowrap="nowrap" class="style8">
                                    :&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 13%;">
                                    <asp:Label ID="lblInvoiceDate" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td id="td2" runat="server" align="left" nowrap="nowrap" style="width: 3%;" class="style4">
                                    &nbsp;
                                </td>
                                <td rowspan="10" class="style6" id="tdBarcode" runat="server" visible="true" align="right"
                                    valign="top">
                                    <asp:Image ID="imgBarcode" runat="server" Style="display: none;" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" style="width: 4%">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="style2">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" class="style6">
                                    <asp:Label ID="Rs_PatientNo0" Text="Patient No" runat="server" />
                                </td>
                                <td align="left" nowrap="nowrap" class="style4">
                                    &nbsp;:
                                </td>
                                <td align="left" class="style9">
                                    <span>
                                        <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight: 700;"></asp:Label>
                                    </span>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 3%;" class="style6">
                                    <asp:Label ID="Rs_BillNo0" Text="Bill No" runat="server" />
                                </td>
                                <td id="tdReferringHos0" runat="server" align="left" nowrap="nowrap" class="style4">
                                    :&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 13%;" class="style10">
                                    <asp:Label ID="lblInvoiceNo0" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td id="td1" runat="server" align="left" nowrap="nowrap" style="width: 3%;" class="style4">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="style2">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" class="style6">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" class="style4">
                                    &nbsp;
                                </td>
                                <td align="left" class="style9">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 3%;" class="style6">
                                    &nbsp;
                                </td>
                                <td id="tdReferringHos1" runat="server" align="left" nowrap="nowrap" class="style4">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 13%;" class="style10">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="style2">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" class="style6">
                                    <asp:Label ID="lLabNo" Visible="false" runat="server" Text="LabNo" />
                                    <asp:Label ID="Rs_VisitNumber" runat="server" Text="/Visit No." Visible="false" />
                                </td>
                                <td align="left" nowrap="nowrap" class="style1" style="width: 2%">
                                    &nbsp;:&nbsp;
                                </td>
                                <td align="left" class="style9">
                                    <asp:Label ID="lblLabNo" runat="server" Style="font-weight: 700"></asp:Label>
                                    <asp:Label ID="lblVisitNumber" runat="server" Style="font-weight: 700" Visible="false"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 3%;" class="style6">
                                    <asp:Label ID="Rs_PatPhoneNo" Text="Cantact No" runat="server" />
                                </td>
                                <td align="left" style="width: 2%">
                                    :
                                </td>
                                <td align="left" style="width: 2%">
                                    &nbsp;<asp:Label ID="lblPatPhoneNumber" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td align="left" style="width: 2%">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" style="width: 4%">
                                    &nbsp;
                                </td>
                                <td colspan="3" align="right">
                                    &nbsp;
                                </td>
                                <td colspan="3">
                                    &nbsp;
                                </td>
                                <td id="td3" runat="server" align="left" nowrap="nowrap" class="style4">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="Tr1" visible="true" runat="server">
                                <td style="width: 4%">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" class="style6">
                                    <asp:Label ID="PatientAge" Text="Age" runat="server" />
                                    /<asp:Label ID="Rs_sex" Text="Sex" runat="server" />
                                </td>
                                <td align="left" nowrap="nowrap" class="style1" style="width: 2%">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblAge" runat="server" Style="font-weight: 700"></asp:Label>
                                    /<asp:Label ID="lblSex" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 3%;" id="trLabNo" runat="server" visible="false"
                                    class="style8">
                                    &nbsp;<asp:Label ID="lblmail" runat="server" Text="Email"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" id="trLabNo1" runat="server" visible="false" class="style8">
                                    :
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 13%;" id="trLabNo2" runat="server"
                                    visible="false">
                                    <asp:Label ID="lblEmail" runat="server" Style="font-weight: 700; text-wrap: normal"></asp:Label>
                                </td>
                                <td id="td4" runat="server" align="left" nowrap="nowrap" class="style4">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" style="width: 4%">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 4%">
                                </td>
                                <td align="left" nowrap="nowrap" class="style6">
                                    <asp:Label runat="server" ID="lblPhy" Text="Ref Doctor"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" class="style1" style="width: 2%">
                                    &nbsp;:&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 23%">
                                    <asp:Label ID="lblPhysician" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 3%;" class="style8">
                                    <asp:Label ID="lblModedelivirey" runat="server" Text="Mode of Delivery"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" class="style8">
                                    :&nbsp;
                                </td>
                                <td align="left" style="width: 13%;" nowrap="nowrap">
                                    <asp:Label ID="lblModetype" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td id="td6" runat="server" align="left" nowrap="nowrap" class="style4">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" style="width: 4%">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 4%">
                                    &nbsp;
                                </td>
                                <td align="left" valign="top" nowrap="nowrap" class="style6" >
                                    <asp:Label ID="lblHistory" runat="server" Text="Patient History" style="display:none"></asp:Label>
                                </td>
                                <td id="tdHis" runat="server" visible="false" align="left" nowrap="nowrap" class="style8">
                                    :&nbsp;
                                </td>
                              <%--  <td align="left" valign="top" nowrap="nowrap" class="style1" style="width: 2%;display: none;">
                                    &nbsp;: &nbsp;
                                </td>--%>
                                <td align="left" rowspan="2" nowrap="nowrap" colspan="6" valign="top" width="8%">
                                    <asp:Label ID="lblpatientHistory" runat="server" Style="font-weight: 700; display:none" ></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" style="width: 4%">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="trFinalBillHeader" runat="server" style="display: none;">
                                <td align="left" nowrap="nowrap" style="width: 4%">
                                    &nbsp;
                                </td>
                                <td colspan="8" align="center">
                                    <uc3:FinalBillHeader ID="FinalBillHeader1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="9" align="center">
                                    <hr noshade="noshade" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <asp:GridView ID="gvBillingDetail1" runat="server" Width="100%" AutoGenerateColumns="False"
                            BorderStyle="Solid" BorderColor="#B6A8A8" BorderWidth="1px" OnRowDataBound="gvBillingDetail1_RowDataBound">
                            <Columns>
                                <asp:TemplateField HeaderText="S.No" ItemStyle-Width="4%" Visible="false">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="LightGray" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDescription" Text='<%# Bind("FeeDescription") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="LightGray" />
                                </asp:TemplateField>
                                <asp:BoundField ItemStyle-Width="15%" DataField="ServiceCode" HeaderText="ServiceCode"
                                    Visible="false">
                                    <ItemStyle Width="15%"></ItemStyle>
                                    <HeaderStyle BackColor="LightGray" />
                                </asp:BoundField>
                                <asp:BoundField ItemStyle-Width="8%" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center"
                                    HeaderText="Units" DataField="Quantity" Visible="false">
                                    <HeaderStyle HorizontalAlign="Center" BackColor="LightGray" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Report Date" ItemStyle-Width="18%">
                                    <ItemTemplate>
                                        <%# GetDate(DataBinder.Eval(Container.DataItem, "ModifiedAt", "{0:dd/MMM/yyyy hh:mm:tt}").ToString())%>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="LightGray" />
                                </asp:TemplateField>
                                <asp:BoundField ItemStyle-Width="12%" DataField="Amount" HeaderText="Amount" DataFormatString="{0:F2}"
                                    ItemStyle-HorizontalAlign="Center">
                                    <HeaderStyle HorizontalAlign="Center" BackColor="LightGray" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle"></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                            <HeaderStyle Font-Bold="True" ForeColor="Black" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr valign="top">
                                <td style="width: 30%" valign="bottom">
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td style="padding-top: 5px; border-left: none;" valign="bottom">
                                                <asp:Label Font-Bold="True" ID="lblPayment" Text="Payment Mode" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="border-left: none;">
                                                <asp:Label runat="server" ID="lblPaymentMode"></asp:Label>
                                                <span id="lblPayMode" runat="server"></span>
                                            </td>
                                        </tr>
                                        <tr id="trDeposit" runat="server" style="display: table-row">
                                            <td style="border-left: none;">
                                                <asp:Label Visible="False" ID="lblDepositAmtUsed" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="border-left: none;">
                                                <asp:Label runat="server" ID="lblOtherCurrency"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="right" style="width: 70%">
                                    <table cellpadding="0" border="0" style="border-left: none; border-right: none;"
                                        cellspacing="0">
                                        <tr>
                                            <td align="right" valign="Middle" style="border: none;">
                                                <asp:Label ID="Rs_GrossAmount" Text="Gross Amount :" runat="server" />
                                            </td>
                                            <td align="right" style="border: none; border-right: none;">
                                                <asp:Label ID="lblGrossAmount" runat="server" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr style="display: none;">
                                            <td align="right" valign="Middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="Rs_DeductionAmount" Text="Deduction Amount :" runat="server" />
                                            </td>
                                            <td align="right" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblDeduction" runat="server" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr id="trServiceCharge" style="display: none;" runat="server">
                                            <td align="right" valign="middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="Rs_ServiceCharge" Text="Service Charge :" runat="server" />
                                            </td>
                                            <td align="right" valign="middle" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblServiceCharge" runat="server" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr id="trTaxAmount" style="display: none;" runat="server">
                                            <td align="right" valign="middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="lblTaxAmounttxt" Text="Tax Amount :" runat="server" />
                                            </td>
                                            <td align="right" valign="middle" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblTaxAmount" runat="server" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr id="trEDCess" style="display: none;" runat="server">
                                            <td align="right" valign="middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="Rs_EDCess" Text="ED Cess :" runat="server" />
                                            </td>
                                            <td align="right" valign="middle" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblEDCess" runat="server" />&nbsp;
                                                <input type="hidden" id="hdnEDCess" runat="server" value="0" />
                                            </td>
                                        </tr>
                                        <tr id="trSHEDCess" style="display: none;" runat="server">
                                            <td align="right" valign="middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="Rs_SHEDCess" Text="SHED Cess :" runat="server" />
                                            </td>
                                            <td align="right" valign="middle" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblSHEDCess" runat="server" />&nbsp;
                                                <input id="hdnSHEDCess" type="hidden" runat="server" value="0" />
                                            </td>
                                        </tr>
                                        <tr id="trDiscount" style="display: none;" runat="server">
                                            <td align="right" valign="middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="lblDiscountPercent" runat="server" />&nbsp;Discount (-) :
                                            </td>
                                            <td align="right" valign="middle" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblDiscount" runat="server" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr id="trRoundoff" style="display: none;" runat="server">
                                            <td align="right" valign="middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="Rs_RoundOffAmount" Text="Round Off Amount :" runat="server" />
                                            </td>
                                            <td align="right" valign="middle" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblRoundOff" runat="server" Text="0.00" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="Middle" align="right" colspan="2" style="border-right: none;
                                                border-left: none;">
                                                <div id="dvTaxDetails" runat="server">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="Middle" colspan="2" style="border: none;">
                                                -----------------------------------
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="Middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="Rs_GrandTotal" Text="Grand Total :" runat="server" />
                                            </td>
                                            <td align="right" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblGrandTotal" runat="server" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr id="trPreviousDue" style="display: none" runat="server">
                                            <td align="right" valign="Middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="Rs_PreviousDue" Text="Previous Due :" runat="server" />
                                            </td>
                                            <td align="right" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblPreviousDue" runat="server"></asp:Label>&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" colspan="2" valign="Middle" style="border-left: none;">
                                                -----------------------------------
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="Rs_NetAmount" Text="Net Amount :" runat="server" />
                                            </td>
                                            <td align="right" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblNetValue" runat="server" Style="font-weight: 700"></asp:Label>&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="middle" colspan="2" style="border-left: none;">
                                                -----------------------------------
                                            </td>
                                        </tr>
                                        <tr id="trAmountReceived" runat="server">
                                            <td align="right" valign="middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="Rs_AmountReceived" Text="Amount Received :" runat="server" />
                                            </td>
                                            <td align="right" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblAmountRecieved" runat="server" Style="font-weight: 700" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr id="trDue" runat="server" style="display: none">
                                            <td align="right" valign="middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="lblCurrentVisitDueLabel" Text="Due :" runat="server"></asp:Label>
                                            </td>
                                            <td align="right" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblCurrentVisitDueText" runat="server" />&nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="left">
                                    <asp:Label ID="lblrefundamt" runat="server" Visible="False" Style="font-weight: 700"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="trReportDate" runat="server">
                                <td colspan="2" align="left">
                                    <asp:Label ID="lblReportcommitDate" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr id="TRAMTRcvd" runat="server">
                                <td colspan="2" align="left">
                                    <asp:Label ID="lblDisplayAmount" runat="server" Style="font-weight: 700"></asp:Label>
                                    <asp:Label ID="lblAmount" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trPayingCurrency" runat="server" style="display: none">
                                <td colspan="2" align="left">
                                    <asp:Label ID="lblPayingCurrency" runat="server" Style="font-weight: 700; display: none;"></asp:Label>
                                    <asp:Label ID="lblPayingCurrencyinWords" runat="server" Style="font-weight: 700;
                                        display: none;"></asp:Label>
                                </td>
                            </tr>
                            <tr id="TRDueAmt" runat="server">
                                <td align="left" nowrap="nowrap" colspan="2">
                                    <asp:Label ID="lblDueAmountinWords" runat="server" Style="font-weight: 700;"></asp:Label>
                                    <asp:Label ID="lblDueAmount" runat="server" Style="font-weight: 700; display: none;"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="left">
                                    <asp:Label ID="Label1" Visible="False" runat="server" Style="font-weight: 700"></asp:Label>
                                    <asp:Label ID="RemainDeposit" Visible="False" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trTaxDetails" runat="server">
                                <td colspan="2" align="left">
                                    <asp:Label ID="lblTaxDetails" Visible="False" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="left">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="trReportDate1" runat="server">
                                <td colspan="2" align="left">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="trReportDate2" runat="server">
                                <td colspan="2" align="left">
                                    <asp:Label ID="lblservicetax" runat="server" Style="font-weight: 700; display: none;"
                                        Text="Service Tax Registration Number:-AACCP1414ESD001"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trReportDate3" runat="server">
                                <td colspan="2" align="left">
                                    <asp:Label ID="lblCategoryservice" runat="server" Style="font-weight: 700; display: none;"
                                        Text="Category Of Service :-Technical Testing &amp; Analysis/Cosmetic &amp; Plastic Surgery."></asp:Label>
                                </td>
                            </tr>
                            <tr id="trReportDate4" runat="server">
                                <td colspan="2" align="left">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="trReportDate5" runat="server">
                                <td colspan="2" align="right">
                                    <img id="imgView" runat="server" align="middle" alt="Digital Signature" style="height: 2%;
                                        width: 3%"></img>&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2">
                                    <asp:Label ID="lblBilledBy" runat="server" />
                                </td>
                            </tr>
<tr>
                                <td align="right" colspan="2">
                                    <asp:Label ID="lblfulltext" Text="This is a computer-generated invoice and it does not require a signature" runat="server" />
                                </td>
                            </tr>

<tr>
                                <td align="left" colspan="2">
                                    <asp:Label ID="lblpatientportal" runat="server" />
                                </td>
                            </tr>


                            <tr>
                                <td rowspan="15" colspan="2" align="center">
                                    <hr noshade="noshade" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <%--<tr>
        <td>
            <asp:Label ID="lblNote" runat="server" Text=""></asp:Label>
        </td>
    </tr>--%>
    <tr>
        <td align="center">
	                    <label style="font-family: Verdana;font-size: 10px;" id="lblHospitalName" runat="server">
                        </label>
                    </td>
    </tr>
    <tr>
        <td width="100%" runat="server" style="display: none;" id="tdPrint" enableviewstate="false">
        </td>
    </tr>
</table>
</div>
 <div id="divBillprint_igenamount" runat="server" style="display:none" >
<table width="100%" align="center" id="tblBillPrint11" style="font-family: Tahoma;
    font-weight: normal; font-size: 11px;" runat="server">
     
    <tr id="tbprint1" runat="server">
        <td style="font-family: Titillium;">
            <table width="100%" id="tblHead11" runat="server" border="0" cellspacing="0" cellpadding="0"
                align="center">
                <tr>
                    <td align="left" valign="top" width="70%">
                        <asp:Image ID="imgBillLogo1" runat="server" Visible="False" />
                    </td>
                    <td valign="middle" align="right">
                        <asp:Label ID="lblTitleText1" Text="BILL CUM RECEIPT" Style="background-color: Red;
                            color: White; font-size: x-large;" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <hr noshade="noshade" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        Patient Bill</td>
                </tr>
                <tr>
                    <td id="tblPatientDetails11" runat="server" colspan="6">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td colspan="7" align="center" style="display: none">
                                    <asp:Label ID="lblTypeBill1" Style="font-weight: bold;" runat="server"></asp:Label>
                                    <asp:Label ID="lblDupBill1" Style="font-weight: bold;" Text="(Duplicate Copy)" Visible="False"
                                        runat="server"></asp:Label>
                                    </td>
                            </tr>
                            <tr>
                                <td style="width: 4%">
                                </td>
                                <td align="left" nowrap="nowrap" class="style6">
                                    <asp:Label ID="Rs_PatientName1" Text="Name" runat="server" />
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 2%">
                                    &nbsp;:
                                </td>
                                <td align="left" nowrap="nowrap" class="style6">
                                    <span class="style6">
                                        <asp:Label ID="lblTitleName1" runat="server" Style="font-weight: 700"></asp:Label>
                                        <asp:Label ID="lblName1" runat="server" Style="font-weight: 700"></asp:Label>
                                    </span></td>
                                <td align="left" nowrap="nowrap" style="width: 3%;" class="style8">
                                    <asp:Label ID="Rs_BillDate1" Text="Bill Date" runat="server" />
                                </td>
                                <td id="tdPhysician1" runat="server" align="left" nowrap="nowrap" class="style8">
                                    :&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 13%;">
                                    <asp:Label ID="lblInvoiceDate1" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td id="td21" runat="server" align="left" nowrap="nowrap" style="width: 3%;" class="style4">
                                    &nbsp;
                                </td>
                                <td rowspan="10" class="style6" id="tdBarcode1" runat="server" visible="true" align="right"
                                    valign="top">
                                    <asp:Image ID="imgBarcode1" runat="server" Style="display: block;" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" style="width: 4%">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="style2">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" class="style6">
                                    <asp:Label ID="Rs_PatientNo01" Text="Patient No" runat="server" />
                                </td>
                                <td align="left" nowrap="nowrap" class="style4">
                                    &nbsp;:
                                </td>
                                <td align="left" class="style9">
                                    <span>
                                        <asp:Label ID="lblPatientNumber1" runat="server" Style="font-weight: 700;"></asp:Label>
                                    </span>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 3%;" class="style6">
                                    <asp:Label ID="Rs_BillNo01" Text="Bill No" runat="server" />
                                </td>
                                <td id="td5" runat="server" align="left" nowrap="nowrap" class="style4">
                                    :&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 13%;" class="style10">
                                    <asp:Label ID="lblInvoiceNo01" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td id="td11" runat="server" align="left" nowrap="nowrap" style="width: 3%;" class="style4">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="style2">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" class="style6">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" class="style4">
                                    &nbsp;
                                </td>
                                <td align="left" class="style9">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 3%;" class="style6">
                                    &nbsp;
                                </td>
                                <td id="tdReferringHos11" runat="server" align="left" nowrap="nowrap" class="style4">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 13%;" class="style10">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="style2">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" class="style6">
                                    <asp:Label ID="lLabNo1" Visible="false" runat="server" Text="LabNo" />
                                    <asp:Label ID="Rs_VisitNumber1" runat="server" Text="/Visit No." Visible="false" />
                                </td>
                                <td align="left" nowrap="nowrap" class="style1" style="width: 2%">
                                    &nbsp;:&nbsp;
                                </td>
                                <td align="left" class="style9">
                                    <asp:Label ID="lblLabNo1" runat="server" Style="font-weight: 700"></asp:Label>
                                    <asp:Label ID="lblVisitNumber1" runat="server" Style="font-weight: 700" Visible="false"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 3%;" class="style6">
                                    <asp:Label ID="Rs_PatPhoneNo1" Text="Cantact No" runat="server" />
                                </td>
                                <td align="left" style="width: 2%">
                                    :
                                </td>
                                <td align="left" style="width: 2%">
                                    <asp:Label ID="lblPatPhoneNumber1" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td align="left" style="width: 2%">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" style="width: 4%">
                                    &nbsp;
                                </td>
                                <td colspan="3" align="right">
                                    &nbsp;
                                </td>
                                <td colspan="3">
                                    &nbsp;
                                </td>
                                <td id="td31" runat="server" align="left" nowrap="nowrap" class="style4">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="Tr11" visible="true" runat="server">
                                <td style="width: 4%">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" class="style6">
                                    <asp:Label ID="PatientAge1" Text="Age" runat="server" />
                                    /<asp:Label ID="Rs_sex1" Text="Sex" runat="server" />
                                </td>
                                <td align="left" nowrap="nowrap" class="style1" style="width: 2%">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblAge1" runat="server" Style="font-weight: 700"></asp:Label>
                                    /<asp:Label ID="lblSex1" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 3%;" id="trLabNoemail" runat="server" visible="false"
                                    class="style8">
                                    &nbsp;<asp:Label ID="lblmail1" runat="server" Text="Email"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" id="trLabNo11" runat="server" visible="false" class="style8">
                                    :
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 13%;" id="trLabNo21" runat="server"
                                    visible="false">
                                    <asp:Label ID="lblEmail1" runat="server" Style="font-weight: 700; text-wrap: normal"></asp:Label>
                                </td>
                                <td id="td41" runat="server" align="left" nowrap="nowrap" class="style4">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" style="width: 4%">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 4%">
                                </td>
                                <td align="left" nowrap="nowrap" class="style6">
                                    <asp:Label runat="server" ID="lblPhy1" Text="Ref Doctor"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" class="style1" style="width: 2%">
                                    &nbsp;:&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 23%">
                                    <asp:Label ID="lblPhysician1" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" style="width: 3%;" class="style8">
                                    <asp:Label ID="lblModedelivirey1" runat="server" Text="Mode of Delivery"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" class="style8">
                                    :&nbsp;
                                </td>
                                <td align="left" style="width: 13%;" nowrap="nowrap">
                                    <asp:Label ID="lblModetype1" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td id="td61" runat="server" align="left" nowrap="nowrap" class="style4">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" style="width: 4%">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 4%">
                                    &nbsp;
                                </td>
                                <td align="left" valign="top" nowrap="nowrap" class="style6">
                                    <asp:Label ID="lblHistory1" runat="server" Text="Patient History" style="display:none;"></asp:Label>
                                </td>
                                <td id="tdHis1" runat="server" align="left" valign="top" nowrap="nowrap" class="style1" style="width: 2%;display:none;">
                                    &nbsp;: &nbsp;
                                </td>
                                <td align="left" rowspan="2" colspan="6" valign="top" width="8%">
                                    <asp:Label ID="lblpatientHistory1" runat="server" Style="font-weight: 700;display:none;"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" style="width: 4%">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="trFinalBillHeader1" runat="server" style="display: none;">
                                <td align="left" nowrap="nowrap" style="width: 4%">
                                    &nbsp;
                                </td>
                                <td colspan="8" align="center">
                                    <uc3:FinalBillHeader ID="FinalBillHeader11" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="9" align="center">
                                    <hr noshade="noshade" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <asp:GridView ID="gvBillingDetail_Dup" runat="server" Width="100%" AutoGenerateColumns="False"
                            BorderStyle="Solid" BorderColor="#B6A8A8" BorderWidth="1px" OnRowDataBound="gvBillingDetailD1_RowDataBound">
                            <Columns>
                                <asp:TemplateField HeaderText="S.No" ItemStyle-Width="4%" Visible="false">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="LightGray" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDescription" Text='<%# Bind("FeeDescription") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="LightGray" />
                                </asp:TemplateField>
                                <asp:BoundField ItemStyle-Width="15%" DataField="ServiceCode" HeaderText="ServiceCode"
                                    Visible="false">
                                    <ItemStyle Width="15%"></ItemStyle>
                                    <HeaderStyle BackColor="LightGray" />
                                </asp:BoundField>
                                <asp:BoundField ItemStyle-Width="8%" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center"
                                    HeaderText="Units" DataField="Quantity" Visible="false">
                                    <HeaderStyle HorizontalAlign="Center" BackColor="LightGray" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Report Date" ItemStyle-Width="18%">
                                    <ItemTemplate>
                                        <%# GetDate(DataBinder.Eval(Container.DataItem, "ModifiedAt", "{0:dd/MMM/yyyy hh:mm:tt}").ToString())%>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="LightGray" />
                                </asp:TemplateField>
                                <asp:BoundField ItemStyle-Width="12%" DataField="Amount" HeaderText="Amount" DataFormatString="{0:F2}"
                                    ItemStyle-HorizontalAlign="Center">
                                    <HeaderStyle HorizontalAlign="Center" BackColor="LightGray" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle"></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                            <HeaderStyle Font-Bold="True" ForeColor="Black" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr valign="top">
                                <td style="width: 30%" valign="bottom">
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td style="padding-top: 5px; border-left: none;" valign="bottom" visible="false">
                                                <asp:Label Font-Bold="True" ID="lblPayment1" Text="Payment Mode" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="border-left: none;">
                                                <asp:Label runat="server" ID="lblPaymentMode1"  Visible="false" ></asp:Label>
                                                <span id="lblPayMode1" runat="server" visible="false"></span>
                                            </td>
                                        </tr>
                                        <tr id="trDeposit1" runat="server" style="display: block">
                                            <td style="border-left: none;">
                                                <asp:Label Visible="False" ID="lblDepositAmtUsed1" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="border-left: none;">
                                                <asp:Label runat="server" ID="lblOtherCurrency1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="right" style="width: 70%">
                                    <table cellpadding="0" border="0" style="border-left: none; border-right: none;"
                                        cellspacing="0">
                                        <tr>
                                            <td align="right" valign="Middle" style="border: none;">
                                                <asp:Label ID="Rs_GrossAmount1" Text="Gross Amount :" runat="server" />
                                            </td>
                                            <td align="right" style="border: none; border-right: none;">
                                                <asp:Label ID="lblGrossAmount1" runat="server" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr style="display: none;">
                                            <td align="right" valign="Middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="Rs_DeductionAmount1" Text="Deduction Amount :" runat="server" />
                                            </td>
                                            <td align="right" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblDeduction1" runat="server" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr id="trServiceCharge1" style="display: none;" runat="server">
                                            <td align="right" valign="middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="Rs_ServiceCharge1" Text="Service Charge :" runat="server" />
                                            </td>
                                            <td align="right" valign="middle" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblServiceCharge1" runat="server" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr id="trTaxAmount1" style="display: none;" runat="server">
                                            <td align="right" valign="middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="lblTaxAmounttxt1" Text="Tax Amount :" runat="server" />
                                            </td>
                                            <td align="right" valign="middle" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblTaxAmount1" runat="server" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr id="trEDCess1" style="display: none;" runat="server">
                                            <td align="right" valign="middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="Rs_EDCess1" Text="ED Cess :" runat="server" />
                                            </td>
                                            <td align="right" valign="middle" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblEDCess1" runat="server" />&nbsp;
                                                <input type="hidden" id="hdnEDCess1" runat="server" value="0" />
                                            </td>
                                        </tr>
                                        <tr id="trSHEDCess1" style="display: none;" runat="server">
                                            <td align="right" valign="middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="Rs_SHEDCess1" Text="SHED Cess :" runat="server" />
                                            </td>
                                            <td align="right" valign="middle" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblSHEDCess1" runat="server" />&nbsp;
                                                <input id="hdnSHEDCess1" type="hidden" runat="server" value="0" />
                                            </td>
                                        </tr>
                                        <tr id="trDiscount1" style="display: none;" runat="server">
                                            <td align="right" valign="middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="lblDiscountPercent1" runat="server" />&nbsp;Discount (-) :
                                            </td>
                                            <td align="right" valign="middle" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblDiscount1" runat="server" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr id="trRoundoff1" style="display: none;" runat="server">
                                            <td align="right" valign="middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="Rs_RoundOffAmount1" Text="Round Off Amount :" runat="server" />
                                            </td>
                                            <td align="right" valign="middle" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblRoundOff1" runat="server" Text="0.00" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="Middle" align="right" colspan="2" style="border-right: none;
                                                border-left: none;">
                                                <div id="dvTaxDetails1" runat="server">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="Middle" colspan="2" style="border: none;">
                                                -----------------------------------
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="Middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="Rs_GrandTotal1" Text="Grand Total :" runat="server" />
                                            </td>
                                            <td align="right" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblGrandTotal1" runat="server" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr id="trPreviousDue1" style="display: none" runat="server">
                                            <td align="right" valign="Middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="Rs_PreviousDue1" Text="Previous Due :" runat="server" />
                                            </td>
                                            <td align="right" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblPreviousDue1" runat="server"></asp:Label>&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" colspan="2" valign="Middle" style="border-left: none;">
                                                -----------------------------------
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="Rs_NetAmount1" Text="Net Amount :" runat="server" />
                                            </td>
                                            <td align="right" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblNetValue1" runat="server" Style="font-weight: 700"></asp:Label>&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="middle" colspan="2" style="border-left: none;">
                                                -----------------------------------
                                            </td>
                                        </tr>
                                         <tr id="trAmountReceived1" runat="server" style="display: none">
                                            <td align="right" valign="middle" style="border-right: none; border-left: none;  ">
                                                <asp:Label ID="Rs_AmountReceived1" Text="Amount Received :" runat="server" />
                                            </td>
                                            <td align="right" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblAmountRecieved1" runat="server" Style="font-weight: 700" />&nbsp;
                                            </td>
                                        </tr>
                                        <tr id="trDue1" runat="server" style="display: none">
                                            <td align="right" valign="middle" style="border-right: none; border-left: none;">
                                                <asp:Label ID="lblCurrentVisitDueLabel1" Text="Due :" runat="server"></asp:Label>
                                            </td>
                                            <td align="right" style="border-left: none; border-right: none;">
                                                <asp:Label ID="lblCurrentVisitDueText1" runat="server" />&nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="left">
                                    <asp:Label ID="lblrefundamt1" runat="server" Visible="False" Style="font-weight: 700"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="tr2" runat="server">
                                <td colspan="2" align="left">
                                    <asp:Label ID="lblReportcommitDate1" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr id="TRAMTRcvd1" runat="server" style= "display:none">
                                <td colspan="2" align="left">
                                    <asp:Label ID="lblDisplayAmount1" runat="server" Style="font-weight: 700"></asp:Label>
                                    <asp:Label ID="lblAmount1" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trPayingCurrency1" runat="server" style="display: none">
                                <td colspan="2" align="left">
                                    <asp:Label ID="lblPayingCurrency1" runat="server" Style="font-weight: 700; display: none;"></asp:Label>
                                    <asp:Label ID="lblPayingCurrencyinWords1" runat="server" Style="font-weight: 700;
                                        display: none;"></asp:Label>
                                </td>
                            </tr>
                            <tr id="TRDueAmt1" runat="server">
                                <td align="left" nowrap="nowrap" colspan="2">
                                    <asp:Label ID="lblDueAmountinWords1" runat="server" Style="font-weight: 700; display: none;"></asp:Label>
                                    <asp:Label ID="lblDueAmount1" runat="server" Style="font-weight: 700; display: none;"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="left">
                                    <asp:Label ID="Label11" Visible="False" runat="server" Style="font-weight: 700"></asp:Label>
                                    <asp:Label ID="RemainDeposit1" Visible="False" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trTaxDetails1" runat="server">
                                <td colspan="2" align="left">
                                    <asp:Label ID="lblTaxDetails1" Visible="False" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="left">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="trReportDate11" runat="server">
                                <td colspan="2" align="left">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="trReportDate21" runat="server">
                                <td colspan="2" align="left">
                                    <asp:Label ID="lblservicetax1" runat="server" Style="font-weight: 700; display: none;"
                                        Text="Service Tax Registration Number:-AACCP1414ESD001"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trReportDate31" runat="server">
                                <td colspan="2" align="left">
                                    <asp:Label ID="lblCategoryservice1" runat="server" Style="font-weight: 700; display: none;"
                                        Text="Category Of Service :-Technical Testing &amp; Analysis/Cosmetic &amp; Plastic Surgery."></asp:Label>
                                </td>
                            </tr>
                            <tr id="trReportDate41" runat="server">
                                <td colspan="2" align="left">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="trReportDate51" runat="server">
                                <td colspan="2" align="right">
                                    <img id="imgView1" runat="server" align="middle" alt="Digital Signature" style="height: 2%;
                                        width: 3%"></img>&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2">
                                    <asp:Label ID="lblBilledBy1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2">
                                    <asp:Label ID="Label2" Text="This is a computer-generated invoice and it does not require a signature" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td rowspan="15" colspan="2" align="center">
                                    <hr noshade="noshade" />
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
            <asp:Label ID="lblNote" runat="server" Text=""></asp:Label>
        </td>
    </tr>
    <tr>
        <td align="center">
	                    <label style="font-family: Verdana;font-size: 10px;" id="lblHospitalName1" runat="server">
                        </label>
                    </td>
    </tr>
    <tr>
        <td width="100%" runat="server" style="display: none;" id="tdPrint1" enableviewstate="false">
        </td>
    </tr>
</table> 
 
</div>



<asp:HiddenField ID="hdnPayingCurrency" runat="server" />
<asp:HiddenField ID="hdnDiscount" runat="server" />
<asp:HiddenField ID="hdnServiceCharge" runat="server" />
<asp:HiddenField ID="hdnTaxAmount" runat="server" />
<asp:HiddenField ID="hdnPreviousDue" runat="server" />
<asp:HiddenField ID="hdnDue" runat="server" />
<asp:HiddenField ID="hdnRoundoff" runat="server" />
<asp:HiddenField ID="hdnRound" runat="server" />
<asp:HiddenField ID="hdfRoundcalc" runat="server" Value="0" />
<asp:HiddenField ID="hdnRoundAmt" runat="server" />
<asp:HiddenField ID="hdnCleintFlag" runat="server" />
<asp:HiddenField ID="hdnClientDuplicate" runat="server" />
<input type="hidden" id="hdnIsRoundOff" value="ON" runat="server" />

<script type="text/javascript" language="javascript">
    if (document.getElementById('<%=hdnPayingCurrency.ClientID %>').value == "1") {
        document.getElementById('<%=trPayingCurrency.ClientID %>').style.display = "table-row";
    }
    if (document.getElementById('<%=hdnDiscount.ClientID %>').value == "1") {
        document.getElementById('<%=trDiscount.ClientID %>').style.display = "table-row";
    }
    if (document.getElementById('<%=hdnServiceCharge.ClientID %>').value == "1") {
        document.getElementById('<%=trServiceCharge.ClientID %>').style.display = "table-row";
    }
    if (document.getElementById('<%=hdnTaxAmount.ClientID %>').value == "1") {
        document.getElementById('<%=trTaxAmount.ClientID %>').style.display = "table-row";
    }
    if (document.getElementById('<%=hdnCleintFlag.ClientID %>').value != "Y") {
        if (document.getElementById('<%=hdnDue.ClientID %>').value == "1") {
            document.getElementById('<%=trDue.ClientID %>').style.display = "table-row";
        }
    }
    if (document.getElementById('<%=hdnPreviousDue.ClientID %>').value == "1") {
        document.getElementById('<%=trPreviousDue.ClientID %>').style.display = "none";
    }
    if (document.getElementById('<%=hdnRoundoff.ClientID %>').value == "1") {
        document.getElementById('<%=trRoundoff.ClientID %>').style.display = "table-row";
    }
    if (document.getElementById('<%=hdnEDCess.ClientID %>').value == "1") {
        document.getElementById('<%=trEDCess.ClientID %>').style.display = "table-row";
    }
    if (document.getElementById('<%=hdnSHEDCess.ClientID %>').value == "1") {
        document.getElementById('<%=trSHEDCess.ClientID %>').style.display = "table-row";
    }
     
</script>

<uc1:ErrorDisplay ID="ErrorDisplay1" runat="server" />
