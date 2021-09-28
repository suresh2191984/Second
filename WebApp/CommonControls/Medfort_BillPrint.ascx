<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Medfort_BillPrint.ascx.cs"
    Inherits="CommonControls_Medfort_BillPrint" %>
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
    .style3
    {
        width: 130px;
    }
    .style4
    {
        width: 45%;
    }
    .style5
    {
        width: 293px;
    }
    .style6
    {
        width: 296px;
    }
</style>

<script type="text/javascript" language="javascript">
    function AddTHEAD() {
        var table = document.getElementById('<%=tblBillPrint.ClientID %>');
        if (table != null) {
            var head = document.createElement("THEAD");
            head.style.display = "table-header-group";
            head.appendChild(table.rows[0]);
            table.insertBefore(head, table.childNodes[0]);

        }
    }
    window.onload = AddTHEAD;

</script>

<table width="100%" align="center" id="tblBillPrint" style="font-family: Verdana;
    font-size: 10px; border-style: solid; border-width: 1px;" runat="server">
    <%--<tr>
        <td align="center">
            Home
        </td>
    </tr>--%>
    <tr>
        <td>
            <table width="100%" id="tblHead" runat="server" border="0" cellspacing="0" cellpadding="0"
                align="center">
                <tr>
                    <td colspan="1" align="center">
                        <asp:Image ID="imgBillLogo" runat="server" Visible="false" />
                    </td>
                    <td colspan="5" align="center">
                        <label style="font-family: Verdana; font-size: 14px;" id="lblHospitalName" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="style3">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" id="tdDupBill" runat="server" align="center" style="display:none;">
                                    <asp:Label ID="lblTypeBill" Style="font-weight: bold;" runat="server"></asp:Label>
                                    <asp:Label ID="lblDupBill" Style="font-weight: bold;" Text="(Duplicate Copy)" Visible="false"
                                        runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" class="style3">
                                    Bill No
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap" class="style6">
                                    <asp:Label ID="lblInvoiceNo" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td align="right" nowrap="nowrap">
                                    <label>
                                        Bill Date</label>
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;:&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblInvoiceDate" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" class="style3">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" class="style3">
                                    Patient Name
                                </td>
                                <td align="left" nowrap="nowrap" class="style1">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap" class="style6">
                                    <span style="width: 23%">
                                    <asp:Label ID="lblTitleName" runat="server" Style="font-weight: 700"></asp:Label>
                                        <asp:Label ID="lblName" runat="server" Style="font-weight: 700"></asp:Label>
                                    </span>
                                </td>
                                <td align="right" nowrap="nowrap">
                                    Patient No
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;:&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <span style="width: 23%">
                                        <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight: 700"></asp:Label>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" class="style3">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" class="style3">
                                    Patient Age
                                </td>
                                <td align="left" nowrap="nowrap" class="style1">
                                    &nbsp; :
                                </td>
                                <td align="left" nowrap="nowrap" class="style6">
                                    <asp:Label ID="lblAge" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                                <td align="right" nowrap="nowrap">
                                    Sex
                                </td>
                                <td align="left" nowrap="nowrap">
                                    &nbsp;:&nbsp;
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblSex" runat="server" Style="font-weight: 700"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" class="style3">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <div id="Div2" runat="server">
                                    <td align="left" nowrap="nowrap" class="style3">
                                        <asp:Label runat="server" ID="lblPhy" Text="Physician Name"></asp:Label>
                                    </td>
                                    <td align="left" nowrap="nowrap" class="style1">
                                        &nbsp; :&nbsp;
                                    </td>
                                    <td align="left" nowrap="nowrap" class="style6">
                                        <b>Dr.<asp:Label ID="lblPhysician" runat="server" Style="font-weight: 700"></asp:Label>
                                        </b>
                                    </td>
                                </div>
                                <div id="phyDetails" runat="server">
                                    <td align="right" nowrap="nowrap" class="style3">
                                        MRD
                                    </td>
                                    <td align="right" nowrap="nowrap">
                                        &nbsp;:&nbsp;
                                    </td>
                                    <td align="left" nowrap="nowrap" class="style4">
                                        <b>
                                            <asp:Label ID="lblUrn" runat="server" Style="font-weight: 700"></asp:Label>
                                        </b>
                                    </td>
                                </div>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap" class="style3">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" class="style1">
                                    &nbsp;
                                </td>
                                <td align="left" nowrap="nowrap" class="style6">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" align="center">
                                    <uc3:FinalBillHeader ID="FinalBillHeader1" runat="server" />
                                    <br />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" style="text-decoration: Underline;">
                    </td>
                    <td colspan="6" align="left">
                        <asp:Label ID="lblmedfortbillind" runat="server" Text="Billing Executive Name:"></asp:Label>
                        <asp:Label ID="Label1" runat="server" Text="      "></asp:Label>
                        <%-- <asp:Label ID="lblBilledBy" runat="server" />--%>
                    </td>
                </tr>
                <tr>
                    <td colspan="6" align="center">
                        <asp:GridView ID="gvBillingDetail" runat="server" Width="100%" AutoGenerateColumns="False"
                            GridLines="Both" BorderStyle="Solid" BorderColor="#B6A8A8" BorderWidth="1px">
                            <Columns>
                                <%-- <asp:TemplateField HeaderText="Description">
                                    <ItemTemplate>
                                    
                                        <asp:Label ID="lblDescription" Text='<%#Bind("FeeDescription") %>' runat="server" ></asp:Label>
                                        
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                <asp:BoundField DataField="FeeDescription" HeaderText="Description" ItemStyle-HorizontalAlign="Left">
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField ItemStyle-Width="10%" DataField="ServiceCode" HeaderText="ServiceCode" />
                                <asp:BoundField ItemStyle-Width="20%" ItemStyle-HorizontalAlign="Left" HeaderText="Units"
                                    DataField="Quantity">
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField ItemStyle-Width="20%" DataField="Amount" HeaderText="Amount" DataFormatString="{0:F2}"
                                    ItemStyle-HorizontalAlign="Right">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
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
                                <td align="right" style="width: 70%">
                                    <table border="0" cellpadding="0" cellspacing="0" style="border-color: #000000">
                                        <tr>
                                            <td align="right" valign="Middle" class="style5">
                                                Gross Amount :
                                            </td>
                                            <td align="right">
                                                <asp:Image runat="server" ID="Irupee3" ImageUrl="~/Images/Indian_rupees.PNG" />
                                                <asp:Label ID="lblGrossAmount" runat="server" />
                                            </td>
                                        </tr>
                                        <tr style="display: none;">
                                            <td align="right" valign="Middle" class="style5">
                                                Deduction Amount :
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblDeduction" runat="server" />
                                            </td>
                                        </tr>
                                        <tr id="trServiceCharge" style="display: none;" runat="server">
                                            <td align="right" valign="Middle" class="style5">
                                                Service Charge :
                                            </td>
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblServiceCharge" runat="server" />
                                            </td>
                                        </tr>
                                        <tr id="trDiscount" style="display: none;" runat="server">
                                            <td align="right" valign="Middle" class="style5">
                                                <asp:Label ID="lblDiscountPercent" runat="server" />&nbsp;Discount (-) :
                                            </td>
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblDiscount" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="Middle" class="style5">
                                                Round Off Amount :
                                            </td>
                                            <td align="right" valign="middle">
                                                <asp:Label ID="lblRoundOff" runat="server" Text="0.00" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="Middle" align="right" colspan="2">
                                                <div id="dvTaxDetails" runat="server">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="Middle" colspan="2">
                                                -----------------------------------
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="Middle" class="style5">
                                                Grand Total :
                                            </td>
                                            <td align="right">
                                                <asp:Image runat="server" ID="Irupee1" ImageUrl="~/Images/Indian_rupees.PNG" />
                                                <asp:Label ID="lblGrandTotal" runat="server" />
                                            </td>
                                        </tr>
                                        <tr id="trPreviousDue" style="display: none" runat="server">
                                            <td align="right" valign="Middle" class="style5">
                                                Previous Due :
                                            </td>
                                            <td align="right">
                                                <asp:Image runat="server" ID="Irupee2" ImageUrl="~/Images/Indian_rupees.PNG" />
                                                <asp:Label ID="lblPreviousDue" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" colspan="2" valign="Middle">
                                                -----------------------------------
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="Middle" class="style5">
                                                Net Amount :
                                            </td>
                                            <td align="right">
                                                <asp:Image runat="server" ID="Irupee0" ImageUrl="~/Images/Indian_rupees.PNG" />
                                                <asp:Label ID="lblNetValue" runat="server" Style="font-weight: 700"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="Middle" colspan="2">
                                                -----------------------------------
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="Middle" class="style5">
                                                Amount Received :
                                            </td>
                                            <td align="right">
                                                <asp:Image runat="server" ID="Irupee" ImageUrl="~/Images/Indian_rupees.PNG" /><asp:Label
                                                    ID="lblAmountRecieved" runat="server" Style="font-weight: 700" />
                                            </td>
                                        </tr>
                                        <tr id="trDue" runat="server" style="display: none">
                                            <td align="right" valign="Middle" class="style5">
                                                <asp:Label ID="lblCurrentVisitDueLabel" Text="Due" runat="server"></asp:Label>
                                                &nbsp;:
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblCurrentVisitDueText" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" align="left">
                                    <asp:Label ID="lblrefundamt" runat="server" Visible="false" Style="font-weight: 700"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" align="left">
                                    <asp:Label ID="lblDisplayAmount" runat="server" Style="font-weight: 700"></asp:Label>
                                    <asp:Label ID="lblAmount" runat="server" Style="font-weight: 700"> </asp:Label>
                                </td>
                            </tr>
                            <%--<tr>
                                <td colspan="6">
                                    &nbsp;
                                </td>
                            </tr>--%>
                            <%-- <tr id="trPayingCurrency" runat="server" style="display: none">
                                <td colspan="6" align="left">
                                    <asp:Label ID="lblPayingCurrency" runat="server" Style="font-weight: 700"></asp:Label>
                                    <asp:Label ID="lblPayingCurrencyinWords" runat="server" Style="font-weight: 700"> </asp:Label>
                                </td>
                            </tr>--%>
                            <tr>
                                <td colspan="6" align="left">
                                    <asp:Label ID="lblDueAmountinWords" runat="server" Style="font-weight: 700"></asp:Label>
                                    <asp:Label ID="lblDueAmount" runat="server" Style="font-weight: 700"> </asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30%">
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td style="padding-top: 5px;">
                                                <asp:Label Font-Bold="true" ID="lblPayment" Text="Payment Mode" runat="server"></asp:Label>
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblmedfort" runat="server" Text="For Sharp Sight Centre" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" ID="lblPaymentMode"></asp:Label>
                                                <span id="lblPayMode" runat="server"></span>
                                            </td>
                                        </tr>
                                        <tr id="trDeposit" runat="server" style="display: table-row">
                                            <td>
                                                <asp:Label Visible="false" ID="lblDepositAmtUsed" runat="server"></asp:Label>
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lblsignature" runat="server" Text="Signature"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6">
                                                <table width="100%" border=".5" cellpadding="" cellspacing="">
                                                    <tr align="center">
                                                        <td>
                                                            <asp:Label ID="Label30" Style="font-weight: bold;" Text="Sharp Sight Laser Center Pvt.Ltd"
                                                                runat="server" /><br />
                                                            <asp:Label ID="Label31" Font-Size="Smaller" Font-Bold="true" Font-Italic="true" Text="(A Medfort Vision Care Enterprise)"
                                                                runat="server" /><br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="20%" align="left" nowrap="nowrap">
                                                            <asp:Label Font-Size="Smaller" Text="DEFENCE ENCLAVE" runat="server" />
                                                            <asp:Label ID="Label2" Font-Size="Smaller" Text=" 81, Defence Enclave," runat="server" />
                                                            <asp:Label ID="Label3" Font-Size="Smaller" Text="Vikas Marg - 110092" runat="server" />
                                                            <asp:Label ID="Label4" Font-Size="Smaller" Text="Phone: +91-011-22461134/35/46,"
                                                                runat="server" />
                                                            <asp:Label ID="Label5" Font-Size="Smaller" Text="+91-011-65259615" runat="server" /><br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="20%" align="left" nowrap="nowrap">
                                                            <asp:Label ID="Label6" Font-Size="Smaller" Text="PUSA ROAD" runat="server" />
                                                            <asp:Label ID="Label7" Font-Size="Smaller" Text="7B, 2nd Floor" runat="server" />
                                                            <asp:Label ID="Label8" Font-Size="Smaller" Text="Rajendra Park" runat="server" />
                                                            <asp:Label ID="Label9" Font-Size="Smaller" Text="Main Pusa Road - 110005" runat="server" />
                                                            <asp:Label ID="Label10" Font-Size="Smaller" Text="Phone: +91-011-65702464," runat="server" />
                                                            <asp:Label ID="Label11" Font-Size="Smaller" Text="+91-9999055514" runat="server" /><br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="20%" align="left" nowrap="nowrap">
                                                            <asp:Label ID="Label12" Font-Size="Smaller" Text="GK ENCLAVE II" runat="server" />
                                                            <asp:Label ID="Label13" Font-Size="Smaller" Text="Dr. Patnik's IIO" runat="server" />
                                                            <asp:Label ID="Label14" Font-Size="Smaller" Text="C2, GK Enclave II" runat="server" />
                                                            <asp:Label ID="Label15" Font-Size="Smaller" Text="110048" runat="server" />
                                                            <asp:Label ID="Label16" Font-Size="Smaller" Text="Phone: +91-011-29220859" runat="server" />
                                                            <asp:Label ID="Label17" Font-Size="Smaller" Text="+91-011-29224044" runat="server" /><br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="20%" align="left" nowrap="nowrap">
                                                            <asp:Label ID="Label18" Font-Size="Smaller" Text="JANAK PURI" runat="server" />
                                                            <asp:Label ID="Label19" Font-Size="Smaller" Text="A3 / 24, Janakpuri" runat="server" />
                                                            <asp:Label ID="Label20" Font-Size="Smaller" Text="- 110058" runat="server" />
                                                            <asp:Label ID="Label21" Font-Size="Smaller" Text="Phone: +91-011-41006539" runat="server" />
                                                            <asp:Label ID="Label22" Font-Size="Smaller" Text="+91-011-25506664	" runat="server" />
                                                            <asp:Label ID="Label23" Font-Size="Smaller" Text="+91-011-45508964" runat="server" /><br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="20%" align="left" nowrap="nowrap">
                                                            <asp:Label ID="Label24" Font-Size="Smaller" Text="NAJAFGARH" runat="server" />
                                                            <asp:Label ID="Label25" Font-Size="Smaller" Text="Orthoplus Hospital" runat="server" />
                                                            <asp:Label ID="Label26" Font-Size="Smaller" Text="RZ-B, 28, Gopal Nagar" runat="server" />
                                                            <asp:Label ID="Label27" Font-Size="Smaller" Text="- 1100043" runat="server" />
                                                            <asp:Label ID="Label28" Font-Size="Smaller" Text="Phone: +91-011-65657997" runat="server" />
                                                            <asp:Label ID="Label29" Font-Size="Smaller" Text="+91-8860009984, +91-9573578622"
                                                                runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%-- <tr>
                                            <td>
                                                <asp:Label runat="server" ID="lblOtherCurrency"></asp:Label>
                                            </td>
                                        </tr>--%>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<asp:HiddenField ID="hdnPayingCurrency" runat="server" />
<asp:HiddenField ID="hdnDiscount" runat="server" />
<asp:HiddenField ID="hdnServiceCharge" runat="server" />
<asp:HiddenField ID="hdnPreviousDue" runat="server" />
<asp:HiddenField ID="hdnDue" runat="server" />

<script type="text/javascript" language="javascript">

    if (document.getElementById('<%=hdnDiscount.ClientID %>').value == "1") {
        document.getElementById('<%=trDiscount.ClientID %>').style.display = "table-row";
    }
    if (document.getElementById('<%=hdnServiceCharge.ClientID %>').value == "1") {
        document.getElementById('<%=trServiceCharge.ClientID %>').style.display = "table-row";
    }
    if (document.getElementById('<%=hdnDue.ClientID %>').value == "1") {
        document.getElementById('<%=trDue.ClientID %>').style.display = "none";
    }
    if (document.getElementById('<%=hdnPreviousDue.ClientID %>').value == "1") {
        document.getElementById('<%=trPreviousDue.ClientID %>').style.display = "none";
    }
</script>

<uc1:ErrorDisplay ID="ErrorDisplay1" runat="server" />
