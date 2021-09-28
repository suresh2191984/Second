<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InvoicePrinting.ascx.cs"
    Inherits="CommonControls_InvoicePrinting" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<style type="text/css" media="print">
        #BillPrint_trInvoicePage
        {
            page-break-before:always;
        }
    </style>

<table width="100%" align="center" id="tblBillPrint" runat="server">
    <%--<tr>
        <td align="center">
            Home
        </td>
    </tr>--%>
    <tr id="tbprint" runat="server" valign="top">
        <td>
            <table width="100%" id="tblHead" runat="server" border="0" cellspacing="0" cellpadding="0"
                align="center">
                <tr valign="top">
                    <td id="tblPatientDetails" valign="top" runat="server">
                        <div>
                            <table width="100%" border="0" cellspacing="2" cellpadding="2">
                                <tr>
                                    <td>
                                        <table width="100%"  border="0" cellspacing="2" cellpadding="2">
                                            <tr valign="top">
                                                <td align="center" valign="top" style="display: none;">
                                                    <asp:Image ID="imgBillLogo" runat="server" />
                                                </td>
                                                <td align="center" colspan="7">
                                                    <label id="lblHospitalName" runat="server">
                                                    </label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="7" align="center">
                                                    <asp:Label ID="lblTypeBill" Text="Invoice" runat="server" style="font-weight:bold"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 7%">
                                                </td>
                                                <td align="left" nowrap="nowrap" style="width: 4%">
                                                    <asp:Label ID="InvoiceTo" Text="Bill To" runat="server" />
                                                </td>
                                                <td align="left" nowrap="nowrap" style="width: 1%">
                                                    &nbsp; :
                                                </td>
                                                <td align="left" nowrap="nowrap" style="width: 25%;">
                                                    <asp:Label ID="lblInvoiceFor" runat="server"></asp:Label>
                                                </td>
                                                <td align="left" nowrap="nowrap" style="width: 10%">
                                                    <asp:Label ID="InvoiceDate" Text="Invoice Date" runat="server" />
                                                </td>
                                                <td align="left" nowrap="nowrap" style="width: 1%">
                                                    &nbsp;:
                                                </td>
                                                <td align="left" nowrap="nowrap" style="width: 25%;">
                                                    <asp:Label ID="lblInvoiceDate" runat="server" ></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 7%">
                                                    &nbsp;
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    <asp:Label ID="Address" Text="Addres" runat="server" />
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    &nbsp; :
                                                </td>
                                                <td align="left" valign="top" rowspan="2" nowrap="nowrap">
                                                    <asp:Label ID="lblAddress" runat="server"></asp:Label>
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    <asp:Label ID="InvoiceNo" Text="Invoice No" runat="server" />
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    &nbsp;:&nbsp;
                                                </td>
                                                <td align="left" nowrap="nowrap" style="width: 23%">
                                                    <asp:Label ID="lblInvoiceNo" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr id="Tr1" visible="true" runat="server">
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    &nbsp;
                                                </td>
                                                <td align="left" nowrap="nowrap" id="trLabNo" runat="server">
                                                    <asp:Label ID="Period" Text="Period" runat="server" />
                                                </td>
                                                <td align="left" nowrap="nowrap" id="trLabNo1" runat="server">
                                                    &nbsp;:&nbsp;
                                                </td>
                                                <td align="left" nowrap="nowrap" style="width: 23%" id="trLabNo2" runat="server">
                                                    <asp:Label ID="lblPeriod" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 7%">
                                                </td>
                                                <td align="left" nowrap="nowrap" style="width: 7px;">
                                                    <asp:Label ID="SITEAT" Text="Site At" runat="server" />
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    &nbsp; :
                                                </td>
                                                <td align="left" nowrap="nowrap">
                                                    <asp:Label ID="lblSiteAt" runat="server"></asp:Label>
                                                </td>
                                                <td align="left" nowrap="nowrap" id="Td4" runat="server">
                                                    <asp:Label ID="SAPCODE" Text="SAP Code" runat="server" />
                                                </td>
                                                <td align="left" nowrap="nowrap" id="Td5" runat="server">
                                                    &nbsp;:&nbsp;
                                                </td>
                                                <td align="left" nowrap="nowrap" style="width: 23%" id="Td6" runat="server">
                                                    <asp:Label ID="lblSAPCode" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6">
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="grdInvoiceBill" runat="server" CellPadding="1" GridLines="None"
                                                        AutoGenerateColumns="false" Width="100%">
                                                        <Columns>
                                                            <asp:BoundField DataField="BillNumber" HeaderText="Bill No" HeaderStyle-HorizontalAlign="Left" />
                                                            <asp:BoundField DataField="FromDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Bill Date" HeaderStyle-HorizontalAlign="Left" />
                                                            <asp:BoundField DataField="Name" HeaderText="Patient Name" HeaderStyle-HorizontalAlign="Left" />
                                                            <asp:TemplateField HeaderText="Test Description" HeaderStyle-HorizontalAlign="Left" >
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblBilledFor" Text='<%# Eval("FeeDescription") %>' runat="server"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Test Amount" ItemStyle-HorizontalAlign="Right"  >
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblAmount" Text='<%# Eval("Amount") %>' runat="server"></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="Rate" HeaderText="Net Amount" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr valign="top">
                                                <td style="width: 30%">
                                                    &nbsp;
                                                </td>
                                                <td align="right" style="width: 70%">
                                                    <table border="0" cellpadding="2" cellspacing="2" style="border-color: #000000">
                                                        <tr>
                                                            <td align="right" valign="Middle">
                                                                <asp:Label ID="Total" Text="Total " runat="server" />
                                                                :
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="lblTotal" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr id="trServiceCharge" runat="server">
                                                            <td align="right" valign="middle">
                                                                <asp:Label ID="ServiceCharge" Text="Service Tax " runat="server" />
                                                                :
                                                            </td>
                                                            <td align="right" valign="middle">
                                                                <asp:Label ID="lblServiceCharge" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr >
                                                            <td align="right" valign="middle">
                                                                <asp:Label ID="lblDisCount" Text="Discount Amount" runat="server" />
                                                                :
                                                            </td>
                                                            <td align="right" valign="middle">
                                                                <asp:Label ID="lblDisAmt" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr id="trTaxAmount" runat="server">
                                                            <td align="right" valign="middle">
                                                                <asp:Label ID="CessTax" Text="Cess Tax " runat="server" />
                                                                :
                                                            </td>
                                                            <td align="right" valign="middle">
                                                                <asp:Label ID="lblCessTax" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr id="tr2" runat="server">
                                                            <td align="right" valign="middle">
                                                                <asp:Label ID="HigherCess" Text="Higher Edu Cess Tax " runat="server" />
                                                                :
                                                            </td>
                                                            <td align="right" valign="middle">
                                                                <asp:Label ID="lblHigherCessTax" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" valign="Middle" colspan="2">
                                                                -----------------------------------
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" valign="middle">
                                                                <asp:Label ID="NetAmount" Text="Net Amount" runat="server" />
                                                                :
                                                            </td>
                                                            <td align="right">
                                                                <asp:Label ID="lblNetValue" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" valign="middle" colspan="2">
                                                                -----------------------------------
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
                                                    <asp:Label ID="lblDisplayAmount" Text="Amount In Words :" runat="server"></asp:Label>
                                                    <asp:Label ID="lblAmounts" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" align="right">
                                                    <asp:Label ID="lblBilledBy" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblPanNumber" runat="server" Text="PAN NO :"></asp:Label>
                                                    <asp:Label ID="lblPANNO" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblserTax" runat="server" Text="Service Tax NO:"></asp:Label>
                                                    <asp:Label ID="lblServiceTaxNo" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblserTaxcategory" runat="server" Text="Service Tax Category"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblserCategory" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6">
                                                    <asp:Label ID="lblTerms" runat="server" Text="Terms & Conditions:-"> </asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6">
                                                    <asp:Label ID="lblTermsandConditions" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr id="trInvoicePage" runat="server" style="display: none;">
                    <td>
                        <div >
                            <table width="100%" id="tbnxtpage">
                                <tr>
                                    <td style="width:5%;">
                                        <asp:Label ID="lblDate" runat="server" Text="Date"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblDt" runat="server" ></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblKA" runat="server" Text="K/A"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblKAValue" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblTO" runat="server" Text="TO"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblTOValue" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Dear Madam/Sir,
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        Sub: Invoice for the month of <asp:Label ID="lblmonth" runat="server"></asp:Label> 
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        We enclose herewith Bill No 
                                        <asp:Label ID="lblbillNo" runat="server"></asp:Label>for the Period  <asp:Label ID="lblfPeriod" runat="server"></asp:Label><br />
                                        amounting to Rs.  <asp:Label ID="lblamtof" runat="server"></asp:Label>/-
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        You are requested to kindly process the same and issue cheque payment in favour
                                        of Metropolis
                                        <br />
                                        Health Services (I) Ltd; Do not hesitate to bring to our notice any billing discrepancy
                                        at the earliest<br />
                                        so that we can also update our records. If you have any query regarding the bill
                                        please feel free and revert back on below undersigned.
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        Thanking you.<br />
                                        For Metropolis Healthcare Ltd.
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td colspan="2">
                                    <asp:Label ID="lblCControler" runat="server" ></asp:Label>
                                        <br />
                                        <br />
                                        <asp:Label ID="lblem" runat="server" Text="EMAIL"></asp:Label>:
                                      <asp:Label ID="lblEmail" runat="server"></asp:Label>
                                        <br />
                                        <asp:Label ID="lblCAddress" runat="server"></asp:Label><br />
                                        End : 1. Invoice ( )
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
