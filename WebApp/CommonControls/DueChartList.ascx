<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DueChartList.ascx.cs"
    Inherits="CommonControls_DueChartList" %>
<%@ Register Src="ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>

<table width="100%" align="center" border="0" id="tblBillPrint" runat="server">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" id="tbl1"
                runat="server">
                <tr>
                    <td colspan="6" align="center">
                        <asp:Image ID="imgBillLogo" runat="server" Visible="False" meta:resourcekey="imgBillLogoResource1" />
                    </td>
                </tr>
                <tr>
                    <td colspan="6" align="center">
                        <label style="font-family: Arial; font-size: medium;" id="lblHospitalName" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="6" align="center">
                        <asp:Label ID="Rs_PatientInterimDues" Text="Patient Interim Dues" runat="server"
                            meta:resourcekey="Rs_PatientInterimDuesResource1" />
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td nowrap="nowrap">
                        &nbsp;&nbsp;
                    </td>
                    <td width="18%">
                        &nbsp;
                    </td>
                    <td width="24%">
                        &nbsp;
                    </td>
                    <td width="13%">
                        &nbsp;
                    </td>
                    <td nowrap="nowrap" align="right">
                        <label>
                            <asp:Label ID="Rs_Date" runat="server" Text="Date :" meta:resourcekey="Rs_DateResource1"></asp:Label>
                        </label>
                        <asp:Label ID="lblInvoiceDate" runat="server" meta:resourcekey="lblInvoiceDateResource1"></asp:Label>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        &nbsp;&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="5">
                        <table border="0" id="tblBillContentPrint" runat="server" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_PatientNumber" Text="Patient Number" runat="server" meta:resourcekey="Rs_PatientNumberResource1" />
                                    :
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <span style="width: 23%">
                                        <asp:Label ID="lblPNumber" runat="server" meta:resourcekey="lblPNumberResource1"></asp:Label>
                                    </span>
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                                <td width="83%" align="right" nowrap="nowrap">
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" meta:resourcekey="Rs_PatientNameResource1" />
                                    :
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <span style="width: 23%">
                                        <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                                    </span>
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                                <td width="83%" align="right" nowrap="nowrap">
                                    <asp:Label ID="Rs_InterimReferenceNumber" Text="Interim Reference Number" runat="server"
                                        meta:resourcekey="Rs_InterimReferenceNumberResource1" />
                                    :
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <asp:Label ID="lblReferenceNo" runat="server" meta:resourcekey="lblReferenceNoResource1"></asp:Label>
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_Age" Text="Age" runat="server" meta:resourcekey="Rs_AgeResource1" />
                                    :
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                                <td align="right">
                                </td>
                                <td>
                                    <%--  <asp:Label ID="lblPatientNumber" runat="server"></asp:Label>--%>
                                </td>
                            </tr>
                            <tr>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_ReferenceNPhyName" Text="Referring Physician Name :" runat="server" />
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <%--  <asp:Label ID="lblMobileNumber" runat="server"></asp:Label>--%>
                                    <asp:Label ID="lblReferenceName" runat="server"></asp:Label>
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                                <td width="17%" style="width: 23%" align="right">
                                    <asp:Label ID="Rs_RaisedDate" Text="Raised Date" runat="server" meta:resourcekey="Rs_RaisedDateResource1" />
                                    :
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <asp:Label ID="lblRaisedDate" runat="server" meta:resourcekey="lblRaisedDateResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trDuecharLabno" runat="server">
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <asp:Label ID="Rs_RequestDetails" Text="Request Details" runat="server" meta:resourcekey="Rs_RequestDetailsResource1" />
                                    :
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    &nbsp;</td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                                <td width="83%" align="right" nowrap="nowrap">
                                    <asp:Label ID="Label1" Text="Lab Number" runat="server" />
                                    :
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    <span style="width: 23%">
                                        <asp:Label ID="lblLabNo" runat="server"></asp:Label>
                                    </span>
                                </td>
                                <td width="83%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                            </tr>
                             <tr id="trPharmacyNO">
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    <asp:Label ID="lblPharmacyBillNo" Text="Pharmacy Bill No :" runat="server" />
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                   
                                    <asp:Label ID="lblPharmacybillNovalue"   runat="server"></asp:Label>
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                                <td width="17%" style="width: 23%" align="right">
                                  
                                    &nbsp;
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                   &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                                <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                 <tr>
                   
                    <td colspan="7" style="display: none;" width="100%" runat="server" id="tdPrint" enableviewstate="false">
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <div id="dvDetails" runat="server">
                            <asp:GridView ID="gvIndents" CellPadding="3" runat="server" AutoGenerateColumns="False"
                                GridLines="None" Width="100%" OnRowDataBound="gvIndents_RowDataBound" meta:resourcekey="gvIndentsResource1">
                                <HeaderStyle CssClass="dataheader1" />
                                <PagerStyle CssClass="dataheader1" />
                                <Columns>
                                   <asp:TemplateField HeaderText="S.No"  ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource1" ItemStyle-HorizontalAlign="Left">                                       
                                        <ItemTemplate>
                                            <asp:Label ID="chkID" runat="server" Style="text-align: left;" Text='<%# Eval("Description") %>'
                                                meta:resourcekey="chkIDResource1" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="From Date" DataField="FromDate" DataFormatString="{0:dd/MM/yyyy}"
                                        Visible="false" meta:resourcekey="BoundFieldResource1">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="To Date" DataField="ToDate" DataFormatString="{0:dd/MM/yyyy}"
                                        Visible="false" meta:resourcekey="BoundFieldResource2">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Quantity" meta:resourcekey="TemplateFieldResource2" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <asp:Label ID="txtQuantity" runat="server" Style="text-align: center;" MaxLength="10"
                                                Text='<%# Eval("unit") %>'    onkeypress="return ValidateOnlyNumeric(this);"   Width="60px"
                                                meta:resourcekey="txtQuantityResource1"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="UnitPrice" meta:resourcekey="TemplateFieldResource3">
                                        <ItemTemplate>
                                            <asp:Label ID="txtunitPrice" runat="server" Style="text-align: right;" MaxLength="10"
                                                Text='<%# Eval("AMOUNT") %>'    onkeypress="return ValidateOnlyNumeric(this);"   Width="60px"
                                                meta:resourcekey="txtunitPriceResource1"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right" meta:resourcekey="TemplateFieldResource4">
                                        <ItemTemplate>
                                            <asp:Label ID="txtAmount" runat="server" Style="text-align: right;" ReadOnly="true"
                                                Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>' Width="60px" meta:resourcekey="txtAmountResource1"></asp:Label>
                                            <asp:HiddenField ID="hdnAmount" runat="server" />
                                            <headerstyle horizontalalign="Center" />
                                        </ItemTemplate>
                                        <ItemStyle />
                                        <HeaderStyle HorizontalAlign="Right" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                        <div id="dvAdvance" runat="server" align="center">
                            &nbsp;</div>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        &nbsp;&nbsp;
                    </td>
                    <td>
                    </td>
                </tr>
                <tr id="trTotal" runat="server">
                    <td colspan="7" align="right">
                        <asp:Label ID="Rs_Total" Text="Total" runat="server" meta:resourcekey="Rs_TotalResource1" />
                        :
                        <asp:Label ID="lblTotal" runat="server" meta:resourcekey="lblTotalResource1" />
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr ID="trTotalAmount" runat="server">
                    <td colspan="6" align="left">
                        <asp:Label ID="Rs_TotalAmount" Text="Total Amount" runat="server" meta:resourcekey="Rs_TotalAmountResource1" />
                        :
                        <asp:Label ID="lblCurrency" runat="server" meta:resourcekey="lblCurrencyResource1"></asp:Label>-<asp:Label
                            ID="LblAmount" runat="server" meta:resourcekey="LblAmountResource1" />
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="lblBilledBy" runat="server" meta:resourcekey="lblBilledByResource1" />
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="2">
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="5">
                        <div id="dvDisclaimer" runat="server" style="display: none;">
                            <span>
                                <asp:Label ID="Rs_Disclaimer" Text="Disclaimer" runat="server" meta:resourcekey="Rs_DisclaimerResource1" />
                                :
                                <asp:Label ID="Rs_info" Text="This is only an Due Request. This request slip cannot be used for claiming purpose."
                                    runat="server" meta:resourcekey="Rs_infoResource1" /></span></div>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<script type="text/javascript">
    if (document.getElementById('<%= lblPharmacybillNovalue.ClientID %>').innerHTML != "") {
        document.getElementById('<%= trPharmacyNO.ClientID %>').style.display = "block";
       
    }
   else {
       document.getElementById('<%= trPharmacyNO.ClientID %>').style.display = "none";
    

    }
</script>