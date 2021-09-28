<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VoucherSearch.aspx.cs" Inherits="Billing_VoucherSearch"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/VoucherSearch.ascx" TagName="BillSearch" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Voucher Search</title>
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">

    <script language="javascript" type="text/javascript">
        function VisitDetails(visitID, PatientID, PName, Bid) {

            document.getElementById("<%= hdnVID.ClientID %>").value = visitID;
            document.getElementById("<%= hdnPID.ClientID %>").value = PatientID;
            document.getElementById("<%= hdnPNAME.ClientID %>").value = PName;
            document.getElementById("<%= hdnBID.ClientID %>").value = Bid;

        }

        function closeData()
        { }
        function SelectedVoucherNo(dAmount, dDate, dVoucherNo, PNAME, dOutID,BilledBy) {

            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
            strFeatures = strFeatures + ",left=0,top=0";

//            var strURL = "../admin/PrintVoucherPage.aspx?Amount="
//            + dAmount
//            + "&dDate=" + dDate
//            + "&VONO=" + dVoucherNo
//            + "&OID=" + dOutID
//            + "&RNAME=" + PNAME + ""
            //            + "&BBy=" + BilledBy + "";
            var strURL = "../admin/PrintVoucherPage.aspx?VONO=" + dVoucherNo
            + "&OID=" + dOutID;
            window.open(strURL, "", strFeatures, true);

        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                        <table class="w-100p">
                            <tr>
                                <td class="paddingB10">
                                    <div class="defaultfontcolor">
                                        <uc2:BillSearch ID="uctrlBillSearch" runat="server" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="defaultfontcolor">
                                    <asp:Label ID="lblResult" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr id="aRow" class="w-100p" runat="server" visible="false">
                                <td class="defaultfontcolor w-100p" align="center">
                                    <%-- <asp:Button ID="bGo"  runat="server" Text="Print Receipt" OnClick="bGo_Click" CssClass="btn"
                                          onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" />
                                    </ContentTemplate>
                                    </asp:UpdatePanel>--%>
                                </td>
                            </tr>
                        </table>
                    </div>
               
        <input type="hidden" id="hdnBID" name="bid" value="0" runat="server" />
        <input type="hidden" id="hdnVID" name="vid" value="0" runat="server" />
        <input type="hidden" id="hdnPID" name="pid" value="0" runat="server" />
        <input type="hidden" id="hdnPNAME" name="PName" runat="server" />
        <input type="hidden" id="hdnVisitDetail" runat="server" />
        <input type="hidden" id="hdnBillStatus" name="bStatus" runat="server" />
       <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
