<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Anjanabillprint.ascx.cs"
    Inherits="CommonControls_Anjanabillprint" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<%--<%@ Register Src="FinalBillHeader.ascx" TagName="FinalBillHeader" TagPrefix="uc3" %>--%>
<style type="text/css">
    #remark {
    text-align: justify;
    -moz-text-align-last: right; /* Code for Firefox */
    text-align-last: right;
    
}
    tHead
    {
        display: table-header-group;
    }
    .style4
    {
        width: 2%;
        height: 30px;
    }
    .style6
    {
        width: 4%;
        height: 18px;
    }
    .style13
    {
        width: 4%;
        height: 34px;
    }
    .style14
    {
        height: 34px;
        width: 13%;
    }
    .style16
    {
        width: 23%;
        height: 34px;
    }
    .style17
    {
        width: 3%;
        height: 34px;
    }
    .style18
    {
        width: 5%;
        height: 34px;
    }
    .style21
    {
        height: 40px;
    }
    .style22
    {
        width: 4%;
        height: 40px;
    }
    .style24
    {
        width: 2%;
        height: 40px;
    }
    .style30
    {
        height: 34px;
    }
    .style31
    {
        width: 4%;
        height: 30px;
    }
    .style32
    {
        height: 30px;
    }
    .style33
    {
        width: 3%;
        height: 30px;
    }
    .style34
    {
        width: 5%;
        height: 30px;
    }
    .style35
    {
        height: 30px;
        width: 13%;
    }
    .style36
    {
        height: 28px;
    }
    .style37
    {
        width: 3%;
        height: 28px;
    }
    .style38
    {
        width: 2%;
        height: 28px;
    }
    .style39
    {
        height: 28px;
        width: 13%;
    }
    .style40
    {
        width: 5%;
        height: 28px;
    }
    .style41
    {
        height: 19px;
    }
    #Anjanabillprint_tblBillPrint1
    {
        width: 100% !important;
    }
    .style43
    {
        width: 229px;
    }
    .style44
    {
        width: 80px;
    }
    .style46
    {
        width: 338px;
    }
    .style47
    {
        width: 257px;
    }
</style>

<script type="text/javascript" language="javascript">
    function AddTHEAD() {
        var table = document.getElementById('<%=tblBillPrint1.ClientID %>');
        if (table != null) {
            var head = document.createElement("THEAD");
            //            head.style.display = "table-header-group";
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

<table width="100%" align="center" id="tblBillPrint1" style="font-family: Tahoma;
    font-weight: normal; font-size: 11px;" runat="server" border="0" cellspacing="0"
    cellpadding="0" bordercolor="">
    <tr id="tbprint" runat="server" border="0" cellspacing="0" cellpadding="0">
        <td style="font-family: Titillium; width: 100%;">
            <table width="100%" id="tblHead1" runat="server" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td colspan="3">
                        <table width="100%" border="0">
                            <tr>
                                <td align="left" valign="top"  id="tdlogoleft" runat="server">
                                    <asp:Image ID="imgBillLogo" runat="server" Visible="true" Width="85px" Height="70px" />
                                </td>
                                <td align="center" id="tdHospitalName" runat="server" visible="true" style="width: 70%;">
                                    
                                    <label style="font-family: Verdana; width: 538px; font-size: 11px; height: auto;"
										id="lblHospitalName" runat="server">  </label>
                                </td>
                                <td colspan="1" id="tdBarcode" runat="server" visible="true" align="left" style="width: 18%;">
                                </td>
                                <td align="left" Width="100px" id="tdbillBarcode" runat="server">
                                    <asp:Label ID="lblTitleText" Text="&nbsp;&nbsp;BILL CUM RECEIPT" Style="background-color: White;
                                        color: Black; font-size: small; vertical-align: top; vertical-align: middle"
                                        runat="server">
                                    </asp:Label>
                                    <asp:Image ID="imgBarcode" ImageAlign="Bottom" runat="server" Style="display: block;"
                                        Height="40px" />
                                </td>
                                <td>
                                    <asp:Image ID="imglogo2" runat="server" Width="131px" Height="65px" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center" id="tdline1" runat="server">
                        <hr noshade="noshade" />
                    </td>
                </tr>
                <tr>
                    <td id="tblPatientDetails1" runat="server" colspan="6">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td colspan="7" id="tdDupBill" runat="server" align="center" style="display:none;">
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <asp:Label ID="lblTypeBill" Style="font-weight: bold;" runat="server"></asp:Label>
                                    <asp:Label ID="lblDupBill" Style="font-weight: bold;" Text="(Duplicate Copy)" Visible="False"
                                        runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="style13">
                                </td>
                                <td align="left" nowrap="nowrap" class="style13" colspan="1">
                                    <asp:Label ID="Rs_PatientName" Text="Name" runat="server" />
                                </td>
                                <td align="left" nowrap="nowrap" class="style13">
                                    :
                                </td>
                                <td align="left" nowrap="nowrap" class="style13" colspan="2">
                                    <span class="style6" style="width: 478px">
                                        <asp:Label ID="lblTitleName" runat="server" Style="font-weight: 700"></asp:Label>
                                        <asp:Label ID="lblName" runat="server" Style="font-weight: 700"></asp:Label>
                                    </span>
                                </td>
                                <td class="style13">
                                </td>
                                <td align="left" nowrap="nowrap" class="style13" colspan="1">
                                    <asp:Label ID="PatientAge" Text="Age" runat="server" />
                                    /<asp:Label ID="Rs_sex" Text="Sex" runat="server" />
                                </td>
                                <td align="left" class="style18">
                                    :
                                </td>
                                <td align="left" nowrap="nowrap" class="style14">
                                    <asp:Label ID="lblAge" runat="server" Style="font-weight: 700"></asp:Label>
                                    <asp:Label ID="lblSex" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td class="style30">
                                </td>
                                <td align="left" nowrap="nowrap" class="style13">
                                    <asp:Label runat="server" ID="lblPhy" Text="Ref Doctor"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" class="style13">
                                    :&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" class="style16">
                                    <asp:Label ID="lblPhysician" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td id="td2" runat="server" align="left" nowrap="nowrap" class="style17">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <%-- <td align="left" nowrap="nowrap" style="width: 4%">
                                    &nbsp;
                                </td>--%>
                            </tr>
                            <tr>
                                <td class="style31">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" class="style31">
                                    <asp:Label ID="Rs_PatientNo0" Text="Patient No" runat="server" />
                                </td>
                                <td align="left" nowrap="nowrap" class="style4">
                                    :
                                </td>
                                <td align="left" class="style31" colspan="2">
                                    <span style="width: 300%">
                                        <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight: 700;"></asp:Label>
                                    </span>
                                </td>
                                <td class="style32">
                                </td>
                                <td align="left" nowrap="nowrap" class="style33">
                                    <asp:Label ID="Rs_BillNo0" Text="Bill No" runat="server" />
                                </td>
                                <td id="tdReferringHos0" runat="server" align="left" nowrap="nowrap" class="style34">
                                    :&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" class="style35">
                                    <asp:Label ID="lblInvoiceNo0" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td id="td1" runat="server" align="left" nowrap="nowrap" class="style33">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" class="style31">
                                    <asp:Label ID="lLabNo" Visible="false" runat="server" Text="LabNo" />
                                    <asp:Label ID="Rs_VisitNumber" runat="server" Text="/Visit No." Visible="false" />
                                </td>
                                <td align="left" nowrap="nowrap" class="style4">
                                    :&nbsp;
                                </td>
                                <td align="left" class="style31">
                                    <asp:Label ID="lblLabNo" runat="server" Style="font-weight: 700"></asp:Label>
                                    <asp:Label ID="lblVisitNumber" runat="server" Style="font-weight: 700" Visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <%--<td class="style2">
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
                                <td align="left" nowrap="nowrap" class="style20">
                                    &nbsp;
                                </td>--%>
                            </tr>
                            <tr>
                                <td class="style36">
                                </td>
                                <td align="left" nowrap="nowrap" class="style37">
                                    <asp:Label ID="Rs_BillDate" Text="Bill Date" runat="server" />
                                </td>
                                <td id="tdPhysician" runat="server" align="left" nowrap="nowrap" class="style38">
                                    :&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" colspan="2" class="style39">
                                    <asp:Label ID="lblInvoiceDate" runat="server" Style="font-weight: 700;"></asp:Label>
                                </td>
                                <td class="style36">
                                </td>
                                <td align="left" nowrap="nowrap" class="style37">
                                    <asp:Label ID="Rs_PatPhoneNo" Text="Contact No" runat="server" />
                                </td>
                                <td align="left" class="style40">
                                    :
                                </td>
                                <td align="left" class="style39">
                                    &nbsp;<asp:Label ID="lblPatPhoneNumber" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td align="left" class="style38">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" id="trLabNo" runat="server" visible="false" class="style37">
                                    <asp:Label ID="lblmail" runat="server" Text="Email"></asp:Label>
                                </td>
                                <td align="left" nowrap="nowrap" id="trLabNo1" runat="server" visible="false" class="style38">
                                    &nbsp;:
                                </td>
                                <td align="left" nowrap="nowrap" id="trLabNo2" runat="server" visible="false" class="style39">
                                    <asp:Label ID="lblEmail" runat="server" Style="font-weight: 700; text-wrap: normal"></asp:Label>
                                </td>
                            </tr>
                            <tr id="tr2">
                                <td class="style21">
                                </td>
                                <%--<td colspan="4" align="center" class="style21">
                                    <uc3:FinalBillHeader ID="FinalBillHeader2" runat="server" />
                                </td>--%>
                                <td align="left" nowrap="nowrap" class="style22">
                                    <asp:Label ID="lblTpaText1" runat="server" Text="Client Name"></asp:Label>
                                </td>
                                <td id="tdclient" align="left" class="style21" runat="server">
                                    :
                                </td>
                                <td id="td3" runat="server" align="left" nowrap="nowrap" class="style24" colspan="2">
                                    <asp:Label ID="lblTpaName1" runat="server" Style="font-weight: 700;"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblHistory" runat="server" Text="Patient Address" ></asp:Label>
                                </td>
                                <td id="tdhistory" runat="server">
                                    :
                                </td>
                                <td colspan="5">
                                    <asp:Label ID="lblpatientHistory" runat="server" Style="font-weight: 700;"></asp:Label>
                                </td>
                               
                            </tr>
                            <tr>
                                <td colspan="15" align="center id="tblLine2" runat="server">
                                    <hr noshade="noshade" />
                                </td>
                            </tr>
                            <tr id="trFinalBillHeader" runat="server" style="display: none;">
                                <td align="left" nowrap="nowrap" style="width: 4%">
                                </td>
                            </tr>
                            
                            <tr id="tr3" runat="server" style="height: 50px; display: none;"> 
                             
                            </tr>
                            
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <asp:GridView ID="gvBillingDetail1" runat="server" Width="100%" AutoGenerateColumns="False"
                            BorderStyle="Solid" BorderColor="#B6A8A8" BorderWidth="1px" OnRowDataBound="gvBillingDetail1_RowDataBound">
                            <Columns>
                                <asp:TemplateField HeaderText="S.No" ItemStyle-Width="4%">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="LightGray" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Top"></ItemStyle>
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
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Top"></ItemStyle>
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
                                <td align="left" style="width: 60%">
                                    <table cellpadding="0" border="0" style="border-left: none; border-right: none;"
                                        cellspacing="0">
                                        <tr>
                                            <td align="left" style="border: none;">
                                                <asp:Label ID="lblrefundamt" runat="server" Visible="False" Style="font-weight: 700"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="TRAMTRcvd" runat="server">
                                            <td colspan="2" align="left">
                                                <asp:Label ID="lblDisplayAmount" runat="server" Style="font-weight: 700"></asp:Label>
                                                <asp:Label ID="lblAmount" runat="server" Style="font-weight: 700"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="trPayingCurrency" runat="server" style="display: none">
                                            <td colspan="2" align="left" class="style41">
                                                <asp:Label ID="lblPayingCurrency" runat="server" Style="font-weight: 700; display: none;"></asp:Label>
                                                <asp:Label ID="lblPayingCurrencyinWords" runat="server" Style="font-weight: 700;
                                                    display: none;"></asp:Label>
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td style="padding-top: 5px;">
                                                <asp:Label Font-Bold="True" ID="lblPayment" Text="Payment Mode" runat="server" meta:resourcekey="lblPaymentResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" ID="lblPaymentMode" meta:resourcekey="lblPaymentModeResource2"></asp:Label>
                                                <span id="lblPayMode" runat="server"></span>
                                            </td>
                                        </tr>
                                        <tr></tr>
                                        
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
                                            <td align="left">
                                               
                                                <asp:Label ID="lblReportcommitDate" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                         <td align="left" style="width: 90%;">
                                   
                                        <label style="font-family: Verdana; font-size: 11px;" id="lblfooter" runat="server">  </label>
                                </td>
                                </tr>
                                        <tr id="trdiscountremarks" runat="server"  visible="false">
                                            <td>
                                            <asp:Label id="lbldiscountremarks" runat="server" Text="Remarks" ></asp:Label>
<%--                                            :
                                            <div id="remark" style="width: 400px;word-wrap: break-word">
                                            <asp:Label id="txtdiscountremarks"  runat="server" ></asp:Label>
                                            </div>--%>
                                            </td>
                                        </tr>
                                        <tr>
                                           <td id="trdiscountreason" runat="server" visible="false" >
                                             <asp:Label id="lbldiscounreason" runat="server" Text="DiscountReason" ></asp:Label>
                                             &nbsp;
                                             :
                                             <asp:Label id="txtdiscountreason" runat="server" ></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style41">
                                                                                                &nbsp;</td>
                                        </tr>
                                        <tr id="trReportDate" runat="server">
                                            <td colspan="2" align="left">
                                                <asp:Label ID="lblservicetax" runat="server" Style="font-weight: 700; display: none;"
                                                    Text="Service Tax Registration Number:-AACCP1414ESD001"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="trReportDate3" runat="server">
                                            <td colspan="2" align="left" class="style12">
                                                <asp:Label ID="lblCategoryservice" runat="server" Style="font-weight: 700; display: none;"
                                                    Text="Category Of Service :-Technical Testing &amp; Analysis/Cosmetic &amp; Plastic Surgery."></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="trReportDate4" runat="server">
                                            <td colspan="2" align="left">
                                                &nbsp;
                                            </td>
                                        </tr>
                                         <tr id="tr1" runat="server">
                                            <td colspan="2" align="left">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                               
                                                <asp:Label ID="lblRemark" runat="server"></asp:Label>
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
                                        <tr id="trServiceCharge"  style="visibility: hidden;" runat="server">
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
                                        <tr id="trDue" runat="server" >
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
                             <tr></tr>
                                        <tr  id="tdUserName" runat="server" visible="false">
                                         <td colspan="2"  align="right">
                                    <asp:Label ID="lblUserName" Text="User Name:" runat="server" 
                                        meta:resourcekey="lblUserNameResource1" />
                                    <asp:Label ID="lblLoginName" runat="server" 
                                        meta:resourcekey="lblLoginNameResource1" />
                                          </td>
                                        </tr>
                                        <tr id="tbPassword" runat="server" visible="false">
                                         <td colspan="2"  align="right" >
                                   <asp:Label ID="lblPass" Text="Password:" runat="server" Visible="False" 
                                         meta:resourcekey="lblPassResource1"/>
                                    <asp:Label ID="lblPassword" runat="server" 
                                         meta:resourcekey="lblPasswordResource1" />
                                </td>
                                        </tr>
                                          <tr  id="tburl" runat="server" visible="false">
                                <td colspan="2"  align="left">
                                    &nbsp;
                                   <asp:Label ID="lblURL" Visible="False" Text="To view Patient Report log on to" runat="server" 
                                        meta:resourcekey="lblURLResource1" /> 
                                   <asp:Label ID="lblLoginurl" runat="server" 
                                        meta:resourcekey="lblLoginurlResource1" /> 
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id="trReportDate5" runat="server">
        <td colspan="2" align="right">
            <img id="imgView" runat="server" align="middle" alt="Digital Signature" style="height: 2%;
                width: 3%"></img>
        </td>
    </tr>
    <tr>
        <td align="right" colspan="2">
            <asp:Label ID="lblBilledBy" runat="server" />
        </td>
    </tr>
    <%--<tr>
        <td align="center" style="width: 100%;">
            <label style="font-family: Verdana; font-size: 10px;" id="lblHospitalName" runat="server">
            </label>
        </td>
    </tr>--%>
    <tr>
        <td width="100%" runat="server" style="display: none; width: 100%;" id="tdPrint"
            enableviewstate="false">
        </td>
    </tr>
</table>
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
<input type="hidden" id="hdnIsRoundOff" value="ON" runat="server" />

<script type="text/javascript" language="javascript">
    if (document.getElementById('<%=hdnPayingCurrency.ClientID %>').value == "1") {
        document.getElementById('<%=trPayingCurrency.ClientID %>').style.display = "block";
    }
    if (document.getElementById('<%=hdnDiscount.ClientID %>').value == "1") {
        document.getElementById('<%=trDiscount.ClientID %>').style.display = "block";
    }
    if (document.getElementById('<%=hdnServiceCharge.ClientID %>').value == "1") {
        document.getElementById('<%=trServiceCharge.ClientID %>').style.visibility = "visible";
    }
    if (document.getElementById('<%=hdnTaxAmount.ClientID %>').value == "1") {
        document.getElementById('<%=trTaxAmount.ClientID %>').style.display = "block";
    }
    if (document.getElementById('<%=hdnCleintFlag.ClientID %>').value != "Y") {
        if (document.getElementById('<%=hdnDue.ClientID %>').value == "1") {
            document.getElementById('<%=trDue.ClientID %>').style.visibility = "visible";
        }
    }
    if (document.getElementById('<%=hdnPreviousDue.ClientID %>').value == "1") {
        document.getElementById('<%=trPreviousDue.ClientID %>').style.display = "none";
    }
    if (document.getElementById('<%=hdnRoundoff.ClientID %>').value == "1") {
        document.getElementById('<%=trRoundoff.ClientID %>').style.display = "block";
    }
    if (document.getElementById('<%=hdnEDCess.ClientID %>').value == "1") {
        document.getElementById('<%=trEDCess.ClientID %>').style.display = "block";
    }
    if (document.getElementById('<%=hdnSHEDCess.ClientID %>').value == "1") {
        document.getElementById('<%=trSHEDCess.ClientID %>').style.display = "block";
    }
     
</script>

<uc1:ErrorDisplay ID="ErrorDisplay1" runat="server" />
