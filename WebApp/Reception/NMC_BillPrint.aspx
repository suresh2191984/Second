<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NMC_BillPrint.aspx.cs" Inherits="Reception_NMC_BillPrint" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/SampleBillPrint.ascx" TagName="BillPrintControl"
    TagPrefix="uc8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
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
        .style5
        {
            width: 293px;
        }
        .style6
        {
            width: 296px;
        }
        .style7
        {
            height: 17px;
        }
        .style8
        {
            height: 22px;
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

</head>
<body>
    <form id="form1" runat="server">
    <div>
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
                            <td align="right" rowspan="2" valign="middle" width=10%>
                                <asp:Image ID="imgBillLogo" runat="server" ImageUrl="~/Images/Logo/NMC.png" 
                                    meta:resourcekey="imgBillLogoResource1" />
                            </td>
                            <td colspan="6" align="center" width=90%>
                                <asp:Label ID="Label8" runat="server" 
                                    Text="NMC-SKY Imaging & Diagnostic Centre" Font-Bold="True"
                                    Font-Size="Medium" meta:resourcekey="Label8Resource1"></asp:Label> <br />
                                     <asp:Label ID="Label9" runat="server" 
                                    Text="LLRM Medical College & Hospital" Font-Size="Medium" Font-Bold="True" 
                                    meta:resourcekey="Label9Resource1"></asp:Label>
                            </td>
                        </tr>
                        <%--<tr>
                            <td colspan="2" align="center" class="style8">
                               
                            </td>
                        </tr>--%>
                        <tr>
                           
                            <td colspan="6" align="center">
                                <asp:Label ID="Label33" runat="server" Text="Garh Road, Meerut-250 005 Ph: 0121-4017200,2766541-3"
                                    Font-Size="Small" meta:resourcekey="Label33Resource1"></asp:Label>
                                <label style="font-family: Verdana; font-size: 14px;" id="Label34" runat="server">
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" align="center">
                            </td>
                            <td colspan="2" align="center">
                                <asp:Label ID="Label35" runat="server" Text="Helpline:9837478910 Fax:0121-4017299"
                                    Font-Size="Small" meta:resourcekey="Label35Resource1"></asp:Label>
                                <label style="font-family: Verdana; font-size: 14px;" id="Label36" runat="server">
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td class="style3">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" align="center">
                                            <asp:Label ID="lblBillType" runat="server" Font-Bold="True" 
                                                Font-Names="Lucida Console" meta:resourcekey="lblBillTypeResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" nowrap="nowrap" class="style3">
                                            <asp:Label ID="Rs_BillNo" runat="server" Text="Bill No" 
                                                meta:resourcekey="Rs_BillNoResource1"></asp:Label>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp; :
                                        </td>
                                        <td align="left" nowrap="nowrap" class="style6">
                                            <asp:Label ID="lbBillNo" runat="server" Style="font-weight: 700" 
                                                meta:resourcekey="lbBillNoResource1"></asp:Label>
                                        </td>
                                        <td align="right" nowrap="nowrap">
                                            <asp:Label ID="Rs_Visitno" runat="server" Text="Visit No" 
                                                meta:resourcekey="Rs_VisitnoResource1"></asp:Label>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp; :
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:Label ID="lbVisitno" runat="server" Style="font-weight: 700" 
                                                meta:resourcekey="lbVisitnoResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" nowrap="nowrap" class="style3">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" nowrap="nowrap" class="style3">
                                            <asp:Label ID="lbName" runat="server" Text="Name" 
                                                meta:resourcekey="lbNameResource1"></asp:Label>
                                        </td>
                                        <td align="left" nowrap="nowrap" class="style1">
                                            &nbsp; :
                                        </td>
                                        <td align="left" nowrap="nowrap" class="style6">
                                            <span style="width: 23%">
                                                <asp:Label ID="lblName" runat="server" Style="font-weight: 700" 
                                                meta:resourcekey="lblNameResource1"></asp:Label>
                                            </span>
                                        </td>
                                        <td align="right" nowrap="nowrap">
                                            <asp:Label ID="Rs_age" runat="server" Text="Age" 
                                                meta:resourcekey="Rs_ageResource1"></asp:Label>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp; :
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <span style="width: 23%">
                                                <asp:Label ID="lbage" runat="server" Style="font-weight: 700" 
                                                meta:resourcekey="lbageResource1"></asp:Label>
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
                                            <asp:Label ID="Rs_sex" runat="server" Text="Sex" 
                                                meta:resourcekey="Rs_sexResource1"></asp:Label>
                                        </td>
                                        <td align="left" nowrap="nowrap" class="style1">
                                            &nbsp; :&nbsp;
                                        </td>
                                        <td align="left" nowrap="nowrap" class="style6">
                                            <asp:Label ID="lbsex" runat="server" Style="font-weight: 700" 
                                                meta:resourcekey="lbsexResource1"></asp:Label>
                                        </td>
                                        <td align="right" nowrap="nowrap">
                                            <asp:Label ID="Rs_Date" runat="server" Text="Date" 
                                                meta:resourcekey="Rs_DateResource1"></asp:Label>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp; :
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:Label ID="lblDate" runat="server" Style="font-weight: 700" 
                                                meta:resourcekey="lblDateResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" nowrap="nowrap" class="style3">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" nowrap="nowrap" class="style3">
                                            <asp:Label runat="server" ID="Rs_DRName" Text="Dr.Name" 
                                                meta:resourcekey="Rs_DRNameResource1"></asp:Label>
                                        </td>
                                        <td align="left" nowrap="nowrap" class="style1">
                                            &nbsp; :&nbsp;
                                        </td>
                                        <td align="left" nowrap="nowrap" class="style6">
                                            <asp:Label ID="lblDRName" runat="server" Style="font-weight: 700" 
                                                meta:resourcekey="lblDRNameResource1"></asp:Label>
                                        </td>
                                        <td align="right" nowrap="nowrap">
                                            <asp:Label ID="Rs_HospitalName" runat="server" Text="Hospital/Branch" 
                                                meta:resourcekey="Rs_HospitalNameResource1"></asp:Label>
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            &nbsp; :
                                        </td>
                                        <td align="left" nowrap="nowrap">
                                            <asp:Label ID="lbHospitalName" runat="server" Style="font-weight: 700" 
                                                meta:resourcekey="lbHospitalNameResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trCC" runat="server" style="display: none;">
                                        <td align="left" nowrap="nowrap" class="style3">
                                            <asp:Label runat="server" ID="Rs_CollectionCentre" Text="Collection Centre:" 
                                                meta:resourcekey="Rs_CollectionCentreResource1"></asp:Label>
                                        </td>
                                        <td align="left" nowrap="nowrap" class="style1">
                                            &nbsp; :&nbsp;
                                        </td>
                                        <td align="left" nowrap="nowrap" class="style6">
                                            <asp:Label ID="lbCollectionCentre" runat="server" Style="font-weight: 700" 
                                                meta:resourcekey="lbCollectionCentreResource1"></asp:Label>
                                        </td>
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
                                            <br />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-decoration: Underline;">
                            </td>
                            <td align="left">
                                <asp:Label ID="RS_BillExName" runat="server" Text="Billing Executive Name:" 
                                    meta:resourcekey="RS_BillExNameResource1"></asp:Label>
                                <asp:Label ID="lblBillExName" runat="server" 
                                    meta:resourcekey="lblBillExNameResource1"></asp:Label>
                                <%-- <asp:Label ID="lblBilledBy" runat="server" />--%>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="center">
                                <asp:GridView ID="gvBillingDetail" runat="server" Width="100%" 
                                    AutoGenerateColumns="False" BorderStyle="Solid" BorderColor="#B6A8A8" 
                                    BorderWidth="1px" meta:resourcekey="gvBillingDetailResource1">
                                    <Columns>
                                        <%-- <asp:BoundField ItemStyle-Width="5%" DataField="ServiceCode" HeaderText="Code" />--%>
                                        <asp:BoundField DataField="ItemName" HeaderText="Item" 
                                            ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource1">
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField ItemStyle-Width="10%" DataField="Quantity" 
                                            HeaderText="Quantity" meta:resourcekey="BoundFieldResource2" >
<ItemStyle Width="10%"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField ItemStyle-Width="10%" DataField="Rate" HeaderText="Rate" 
                                            meta:resourcekey="BoundFieldResource3" >
<ItemStyle Width="10%"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField ItemStyle-Width="10%" DataField="Amount" HeaderText="Amount" 
                                            ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource4">
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        </asp:BoundField>
                                    </Columns>
                                    <HeaderStyle Font-Bold="True" ForeColor="Black" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr valign="top">
                                        <td align="right" style="width: 100%">
                                            <table border="0" cellpadding="0" cellspacing="0" style="border-color: #000000">
                                                <tr>
                                                    <td align="right" valign="Middle" class="style5">
                                                        <asp:Label ID="Rs_GrossAmount" Text="Gross Amount:" runat="server" 
                                                            meta:resourcekey="Rs_GrossAmountResource1"></asp:Label>
                                                    </td>
                                                    <td align="right">
                                                        <asp:Image runat="server" ID="Irupee3" ImageUrl="~/Images/Indian_rupees.PNG" 
                                                            meta:resourcekey="Irupee3Resource1" />
                                                        <asp:Label ID="lblGrossAmount" runat="server" 
                                                            meta:resourcekey="lblGrossAmountResource1" />
                                                    </td>
                                                </tr>
                                                <tr id="trServiceCharge" style="display: none;" runat="server">
                                                    <td align="right" valign="Middle" class="style5">
                                                        <asp:Label ID="Rs_Tax" Text="Tax :"  runat="server" 
                                                            meta:resourcekey="Rs_TaxResource1"></asp:Label>
                                                    </td>
                                                    <td align="right" valign="middle">
                                                        <asp:Label ID="lblTax" runat="server" meta:resourcekey="lblTaxResource1" />
                                                    </td>
                                                </tr>
                                                <tr id="trDiscount" style="display: none;" runat="server">
                                                    <td align="right" valign="Middle" class="style5">
                                                        <asp:Label ID="lblDiscountPercent" runat="server" 
                                                            meta:resourcekey="lblDiscountPercentResource1" />&nbsp;<asp:Label 
                                                            ID="Rs_Discount" Text="Discount (-) :" runat="server" 
                                                            meta:resourcekey="Rs_DiscountResource1"></asp:Label>
                                                    </td>
                                                    <td align="right" valign="middle">
                                                        <asp:Label ID="lblDiscount" runat="server" 
                                                            meta:resourcekey="lblDiscountResource1" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" valign="Middle" colspan="2">
                                                        -----------------------------------
                                                    </td>
                                                </tr>                                                
                                                <tr>
                                                    <td align="right" valign="Middle" class="style5">
                                                        <asp:Label ID="Rs_NetAmount" Text="Net Amount :" runat="server" 
                                                            meta:resourcekey="Rs_NetAmountResource1"></asp:Label>
                                                    </td>
                                                    <td align="right">
                                                        <asp:Image runat="server" ID="Irupee0" ImageUrl="~/Images/Indian_rupees.PNG" 
                                                            meta:resourcekey="Irupee0Resource1" />
                                                        <asp:Label ID="lblNetValue" runat="server" Style="font-weight: 700" 
                                                            meta:resourcekey="lblNetValueResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" valign="Middle" colspan="2">
                                                        -----------------------------------
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" valign="Middle" class="style5">
                                                       <asp:Label ID="Rs_AmountReceived" Text="Amount Received :" runat="server" 
                                                            meta:resourcekey="Rs_AmountReceivedResource1"></asp:Label>
                                                    </td>
                                                    <td align="right">
                                                        <asp:Image runat="server" ID="Irupee" ImageUrl="~/Images/Indian_rupees.PNG" 
                                                            meta:resourcekey="IrupeeResource1" /><asp:Label
                                                            ID="lblAmountRecieved" runat="server" Style="font-weight: 700" 
                                                            meta:resourcekey="lblAmountRecievedResource1" />
                                                    </td>
                                                </tr>
                                                <tr id="trPreviousDue" visible="false" runat="server">
                                                    <td align="right" valign="Middle" class="style5">
                                                        <asp:Label ID="Rs_AmountDue" Text="Amount Due :" runat="server" 
                                                            meta:resourcekey="Rs_AmountDueResource1"></asp:Label>
                                                    </td>
                                                    <td align="right">
                                                        <asp:Image runat="server" ID="Irupee2" ImageUrl="~/Images/Indian_rupees.PNG" 
                                                            meta:resourcekey="Irupee2Resource1" />
                                                        <asp:Label ID="lblPreviousDue" runat="server" 
                                                            meta:resourcekey="lblPreviousDueResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id="trdueline" visible="false" runat="server">
                                                    <td align="right" colspan="2" valign="Middle">
                                                        -----------------------------------
                                                    </td>
                                                </tr>
                                                <tr id="referenceIndicator" runat="server" style="display: none;">
                                                    <td>
                                                        <asp:Label ID="lblReferenceIndicator" runat="server" Style="font-weight: 700" 
                                                            meta:resourcekey="lblReferenceIndicatorResource1"></asp:Label>
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
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%">
                                            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                <tr>
                                                    <td style="padding-top: 5px;" class="style7">
                                                    </td>
                                                    <td align="right" class="style7">
                                                    </td>
                                                </tr>
                                                <tr id="trDeposit" runat="server" style="display: block">
                                                    <td>
                                                    </td>
                                                    <td align="right">
                                                        <asp:Label ID="lblsignature1" runat="server" 
                                                            meta:resourcekey="lblsignature1Resource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6" align="left">
                                                    </td>
                                                </tr>
                                                    <tr>
                                                        <td colspan="6" align="center">
                                                            <asp:Label ID="Label2" runat="server" Text="A Unit of Noida Medicare Centre Limited"
                                                                Font-Size="Small" Font-Bold="True" meta:resourcekey="Label2Resource1"></asp:Label>
                                                            <label style="font-family: Verdana; font-size: 14px;" id="Label3" runat="server">
                                                            </label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6" align="center">
                                                            <asp:Label ID="Label4" runat="server" Text="Regd.Office: VIMHANS, 1,Institutional Area, Nehru Nagar, New Delhi-110065, India"
                                                                Font-Size="Small" meta:resourcekey="Label4Resource1"></asp:Label>
                                                            <label style="font-family: Verdana; font-size: 14px;" id="Label5" runat="server">
                                                            </label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6" align="center">
                                                            <asp:Label ID="Label6" runat="server" Text="Films Collected Without The Opinion of Radiologist Should be Submitted 
                Within 7 Days for Opinion, After Which It will not be Possible to Give Radiological Opinion in Writing." 
                                                                Font-Size="X-Small" meta:resourcekey="Label6Resource1"></asp:Label>
                                                            <label style="font-family: Verdana; font-size: 14px;" id="Label7" runat="server">
                                                            </label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                        </td>
                                                    </tr>
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
    </div>
    </form>
</body>
</html>

<script language="javascript" type="text/javascript">
    window.print();
       
</script>

