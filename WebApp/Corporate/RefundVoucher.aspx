<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RefundVoucher.aspx.cs" Inherits="Corporate_RefundVoucher" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/PharmacyHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
   <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
   <head>
    <title>Refund Voucher</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function CallPrint() {
            var prtContent = document.getElementById('divPrint');
            var WinPrint =window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>

</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="ReceptionHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table width="85%" border="1" align="center" id="tblBillPrint" runat="server">
                            <tr>
                                <td>
                                    <div id="divPrint">
                                        <table width="95%" border="0" cellspacing="0" cellpadding="0" border="1" align="center">
                                            <tr>
                                                <%--  <td width="5%" align="center">
                                                    &nbsp;
                                                </td>
                                                <td width="16%" align="center">
                                                    &nbsp;
                                                </td>--%>
                                                <td colspan="7" align="center">
                                                    <label style="font-family: Arial; font-size: medium;" id="lblHospitalName" runat="server">
                                                    </label>
                                                </td>
                                                <%--  <td width="17%" align="center">
                                                    &nbsp;
                                                </td>
                                                <td width="7%" align="center">
                                                    &nbsp;
                                                </td>--%>
                                            </tr>
                                            <tr>
                                                <td colspan="7" align="center">
                                                    <asp:Label ID="lblHospitalAddress" runat="server" 
                                                        meta:resourcekey="lblHospitalAddressResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td nowrap="nowrap">
                                                    <label>
                                                        Bill No</label>
                                                    :
                                                    <asp:Label ID="lblInvoiceNo" runat="server" Style="font-weight: 700" 
                                                        meta:resourcekey="lblInvoiceNoResource1"></asp:Label>
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
                                                <td nowrap="nowrap">
                                                    <label>
                                                        Refund No :
                                                    </label>
                                                    <asp:Label ID="lblRefundNo" runat="server" Style="font-weight: 700" 
                                                        meta:resourcekey="lblRefundNoResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td nowrap="nowrap">
                                                    <label>
                                                        Patient Name</label>
                                                    :
                                                    <asp:Label ID="lblName" runat="server" Style="font-weight: 700" 
                                                        meta:resourcekey="lblNameResource1"></asp:Label>
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
                                                <td nowrap="nowrap">
                                                    <label>
                                                        Refund Date :
                                                    </label>
                                                    <asp:Label ID="lblInvoiceDate" runat="server" Style="font-weight: 700" 
                                                        meta:resourcekey="lblInvoiceDateResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <%--<tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td nowrap="nowrap" style="display:none">
                                                    <label>
                                                        Physician Name</label>
                                                    : <asp:Label ID="lblPhysician" runat="server" Style="font-weight: 700"></asp:Label>
                                                </td>
                                                <td width="18%">
                                                    &nbsp;
                                                </td>
                                                <td width="24%">
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td nowrap="nowrap" colspan="2">
                                                  
                                                        <asp:Label ID="lblPatientNo" runat="server" Text="Patient No  :" Visible="true"></asp:Label>
                                                  
                                                    <asp:Label ID="lblPatientNumber" runat="server"  Style="font-weight: 700" Visible="true"></asp:Label>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>--%>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblPatientNo" runat="server" Text="Patient No  :" 
                                                        meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                                    <asp:Label ID="lblPatientNumber" runat="server" Style="font-weight: 700" 
                                                        meta:resourcekey="lblPatientNumberResource1"></asp:Label>
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
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblPhysicianName" runat="server" Text="Physician Name :" Style="font-weight: 700;
                                                        display: none;" meta:resourcekey="lblPhysicianNameResource1"></asp:Label>
                                                    <asp:Label ID="lblPhysician" runat="server" 
                                                        Style="font-weight: 700; display: none;" 
                                                        meta:resourcekey="lblPhysicianResource1"></asp:Label>
                                                   <asp:Label ID="lblPrescriptionNo" runat="server" Text="Prescription No  :" 
                                                        meta:resourcekey="lblPrescriptionNoResource1"></asp:Label>
                                                    <asp:Label ID="lblPrescriptionNumber" runat="server" Style="font-weight: 700" 
                                                        meta:resourcekey="lblPrescriptionNumberResource1"></asp:Label>
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
                                                    <asp:Label ID="lblReasonForRefund" runat="server" Text="Reason For Refund :" Style="font-weight: 700;
                                                        display: none;" meta:resourcekey="lblReasonForRefundResource1" />
                                                    <asp:Label ID="lblReason" runat="server" 
                                                        meta:resourcekey="lblReasonResource1" />
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td colspan="5" style="text-decoration: Underline;">
                                                    Refund Details
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="7">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td colspan="5">
                                                    <div id="divBilling" runat="server">
                                                        Billed Items
                                                        <asp:GridView ID="gvBillingDetail" runat="server" Width="100%" 
                                                            AutoGenerateColumns="False" meta:resourcekey="gvBillingDetailResource1">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Description" ItemStyle-HorizontalAlign="Left" 
                                                                    meta:resourcekey="TemplateFieldResource1">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblDescription" Text='<%# Bind("FeeDescription") %>' 
                                                                            runat="server" meta:resourcekey="lblDescriptionResource1"></asp:Label>
                                                                    </ItemTemplate>

<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="BatchNo" HeaderText="Batch" 
                                                                    meta:resourcekey="BoundFieldResource1" />
                                                                <asp:BoundField DataField="ExpiryDate" HeaderText="Expiry" 
                                                                    DataFormatString="{0:MMM-yyyy}" meta:resourcekey="BoundFieldResource2" />
                                                                <asp:BoundField DataField="Quantity" HeaderText="Qty" DataFormatString="{0:F2}" 
                                                                    meta:resourcekey="BoundFieldResource3" />
                                                                <%--<asp:BoundField DataField="Rate" HeaderText="Amt Refund" DataFormatString="{0:F2}" />--%>
                                                                <asp:BoundField DataField="ReasonforRefund" HeaderText="Reason For Refund" 
                                                                    meta:resourcekey="BoundFieldResource4" />
                                                            </Columns>
                                                            <RowStyle HorizontalAlign="Right"></RowStyle>
                                                        </asp:GridView>
                                                    </div>
                                                   
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                       
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td colspan="3">
                                                    <asp:Label ID="lblRefundBy" runat="server" 
                                                        meta:resourcekey="lblRefundByResource1"></asp:Label>
                                                </td>
                                                <td align="center">
                                                    &nbsp; Signature
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div style="text-align: center;">
                                        <asp:Button ID="btnPrint" Text="Print" OnClientClick="CallPrint();return false;"
                                            Width="5%" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" meta:resourcekey="btnPrintResource1" />
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
