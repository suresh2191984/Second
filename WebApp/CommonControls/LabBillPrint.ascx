<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LabBillPrint.ascx.cs"
    Inherits="CommonControls_LabBillPrint" %>
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
        height: 18px;
    }
    .style3
    {
        width: 10px;
        height: 18px;
    }
    .style4
    {
        width: 23%;
        height: 18px;
    }
    .w-100p {width:100%;}
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

<script runat="server">
    string _date;
    string GetDate(string Date)
    {
        if (Date != "01-01-00 12:00 AM")
        {
            _date = Date;
        }
        else
        {
            _date = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--";
        }
        return _date;
    }
</script>

<table class="w-100p a-center font10" id="tblBillPrint" style="font-family: Verdana;"
    runat="server">
    <%--<tr>
        <td align="center">
            Home
        </td>
    </tr>--%>
    <tr id="tbprint" runat="server">
        <td>
            <table class="w-100p a-center" id="tblHead" runat="server">
                <tr>
                    <td colspan="2" class="a-center">
                        <asp:Image ID="imgBillLogo" runat="server" Visible="False" meta:resourcekey="imgBillLogoResource2" />
                    </td>
                </tr>
                <tr>
                    <td colspan="5" class="a-center">
                        <label style="font-family: Verdana; font-size: 14px;" id="lblHospitalName" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" class="a-center">
                        <asp:Label Style="font-family: Verdana; font-size: 14px;" ID="lblsrs" runat="server"
                            Text="Service Requisition Slip(SRS)">
                        </asp:Label>
                    </td>
                    <td id="tdBarcode" runat="server" visible="false" colspan="7" class="w-15p a-center">
                        <asp:Image ID="imgBarcode" runat="server" meta:resourcekey="imgBarcodeResource1" />
                    </td>
                </tr>
                <tr>
                    <td id="tblPatientDetails" runat="server" colspan="6">
                        <table class="w-100p">
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="7" class="a-center">
                                    <asp:Label ID="lblTypeBill" Style="font-weight: bold;" runat="server" meta:resourcekey="lblTypeBillResource2"></asp:Label>
                                    <asp:Label ID="lblDupBill" Style="font-weight: bold;" Text="(Duplicate Copy)" Visible="False"
                                        runat="server" meta:resourcekey="lblDupBillResource2"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="7">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="7">
                                    <table class="w-100p" cellpadding="2" cellspacing="2">
                                        <tr>
                                            <td nowrap="nowrap" class="w-10p a-left">
                                                <asp:Label ID="Rs_PatientName" Text="Name" runat="server" meta:resourcekey="Rs_PatientNameResource2" />
                                            </td>
                                            <td class="a-left" nowrap="nowrap">
                                                &nbsp; :
                                            </td>
                                            <td class="a-left" nowrap="nowrap">
                                                <asp:Label ID="lblTitleName" runat="server" Style="font-weight: 700"></asp:Label>
                                                <asp:Label ID="lblName" runat="server" Style="font-weight: 700" meta:resourcekey="lblNameResource2"></asp:Label>
                                            </td>
                                            <td class="a-left w-15p" nowrap="nowrap">
                                                <asp:Label ID="PatientAge" Text="Patient Age /" runat="server" meta:resourcekey="PatientAgeResource2" />
                                                <asp:Label ID="Rs_sex" Text="Sex" runat="server" meta:resourcekey="Rs_sexResource1" />
                                            </td>
                                            <td class="a-left" nowrap="nowrap">
                                                &nbsp; :
                                            </td>
                                            <td class="a-left w-30p" nowrap="nowrap">
                                                <asp:Label ID="lblAge" runat="server" Style="font-weight: 700" meta:resourcekey="lblAgeResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblPermNo" runat="server" Text="Perm.No."></asp:Label>
                                            </td>
                                            <td class="a-left" nowrap="nowrap">
                                                &nbsp; :
                                            </td>
                                            <td>
                                                <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight: 700"></asp:Label>
                                            </td>
                                            <td class="a-left" nowrap="nowrap">
                                                <asp:Label runat="server" ID="lblPhy" Text="Referring Dr." meta:resourcekey="lblPhyResource2"></asp:Label>
                                            </td>
                                            <td class="a-left" nowrap="nowrap">
                                                &nbsp; :
                                            </td>
                                            <td class="a-left" nowrap="nowrap">
                                                <asp:Label ID="lblPhysician" runat="server" Style="font-weight: 700" meta:resourcekey="lblPhysicianResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-left" nowrap="nowrap">
                                                <asp:Label ID="Rs_VisitNumber" Text="Visit No." runat="server" />
                                            </td>
                                            <td class="a-left" nowrap="nowrap">
                                                &nbsp; :
                                            </td>
                                            <td>
                                                <asp:Label ID="lblVisitNumber" runat="server" Style="font-weight: 700"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblClient" runat="server" Text="Client"></asp:Label>
                                            </td>
                                            <td class="a-left" nowrap="nowrap">
                                                &nbsp; :
                                            </td>
                                            <td>
                                                <asp:Label ID="lblClientName" runat="server" Style="font-weight: 700"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-left" nowrap="nowrap">
                                                <asp:Label ID="Rs_PatPhoneNo" Text="Mobile No." runat="server" />
                                            </td>
                                            <td class="a-left" nowrap="nowrap">
                                                &nbsp; :
                                            </td>
                                            <td class="a-left" nowrap="nowrap">
                                                <asp:Label ID="lblPatPhoneNumber" runat="server" Style="font-weight: 700"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <%-- <td id="tdBarcode" runat="server" visible="false" width="5%">
                        <asp:Image ID="imgBarcode" runat="server" />
                    </td>--%>
                </tr>
                <%--<tr>
                    <td colspan="6" style="text-decoration: Underline;">
                        Billing Details
                    </td>
                </tr>--%>
                <tr>
                    <td colspan="9" class="w-100p">
                        <asp:GridView ID="grdTestReport" runat="server" AutoGenerateColumns="False" HorizontalAlign="Right"
                            Font-Names="Verdana" Font-Size="10px" RowStyle-HorizontalAlign="Right" OnRowDataBound="grdTestReport_RowDataBound"
                            CssClass="gridView w-100p">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <table class="w-100p">
                                            <tr>
                                                <td class="a-left h-25">
                                                    <asp:Label ID="lblReceiptInterim" Style="font-weight: bold; font-size: 10px;" runat="server"></asp:Label>
                                                    <%-- <%# DataBinder.Eval(Container.DataItem, "FORENAME")%></b>--%>
                                                    <asp:Label ID="lblforename" Text='<%# Bind("FORENAME") %>' runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="gvBillingDetail" runat="server" AutoGenerateColumns="False" BorderStyle="Solid"
                                                        BorderColor="#B6A8A8" CssClass="w-100p" BorderWidth="1px" meta:resourcekey="gvBillingDetailResource2">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="S No" ItemStyle-Width="3%">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Description" meta:resourcekey="TemplateFieldResource2"
                                                                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="30%">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblDescription" Text='<%# Bind("FeeDescription") %>' runat="server"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                             <asp:BoundField ItemStyle-Width="9%" DataFormatString="{0:N0}" HeaderText="SampleID"
                                                                DataField="DenialCode">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            </asp:BoundField>
                                                            <asp:BoundField ItemStyle-Width="20%" DataFormatString="{0:N0}" HeaderText="Sample"
                                                                DataField="ItemType">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            </asp:BoundField>
                                                           
                                                            <asp:BoundField ItemStyle-Width="15%" DataFormatString="{0:N0}" HeaderText="Container"
                                                                DataField="BatchNo">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            </asp:BoundField>
                                                            <asp:BoundField ItemStyle-Width="9%" DataFormatString="{0:N0}" HeaderText="Status"
                                                                DataField="PayType">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                            </asp:BoundField>
                                                            <%--<asp:BoundField ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center"
                                                                HeaderText="Collected Time" DataField="CreatedAt"  >
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                                            </asp:BoundField>--%>
                                                            <asp:TemplateField HeaderText="Collected Time" HeaderStyle-HorizontalAlign="Center"
                                                                ItemStyle-HorizontalAlign="Left" ItemStyle-Width="20%">
                                                                <ItemTemplate>
                                                                    <%# GetDate(DataBinder.Eval(Container.DataItem, "CreatedAt", "{0:dd-MM-yy hh:mm tt}").ToString())%>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <%-- <asp:BoundField ItemStyle-Width="8%" DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center"
                                                                HeaderText="Units" DataField="Quantity">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                                            </asp:BoundField>--%>
                                                        </Columns>
                                                        <HeaderStyle Font-Bold="True" ForeColor="Black" />
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr class="h-25">
                    <td class="w-10p">
                    </td>
                    <td class="w-10p v-middle">
                        <asp:Label ID="lblRemarks" runat="server" Text="Remarks :"></asp:Label>
                    </td>
                    <td class="a-left v-middle">
                        <asp:Label ID="lbltxtRemarks" Style="text-align: left" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr class="h-25">
                    <td class="w-10p">
                    </td>
                    <td class="w-10p v-middle">
                        <asp:Label ID="lblHistory" runat="server" Text="History :"></asp:Label>
                    </td>
                    <td class="a-left v-middle">
                        <asp:Label ID="lbltxtHistory" Style="text-align: left" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="w-100p" runat="server" style="display: none;" id="tdPrint" enableviewstate="false">
        </td>
    </tr>
</table>
<input type="hidden" id="hdnIsRoundOff" value="ON" runat="server" />
<uc1:ErrorDisplay ID="ErrorDisplay1" runat="server" />
