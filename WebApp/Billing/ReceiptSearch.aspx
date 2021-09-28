<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReceiptSearch.aspx.cs" Inherits="Billing_HospitalBillSearch"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/ReceiptSearch.ascx" TagName="BillSearch" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Receipt Search</title>
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p searchPanel">
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
                <td class="defaultfontcolor w-100p a-center">
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

    <script language="javascript" type="text/javascript">
        function VisitDetails(visitID, PatientID, PName, Bid) {

            document.getElementById("<%= hdnVID.ClientID %>").value = visitID;
            document.getElementById("<%= hdnPID.ClientID %>").value = PatientID;
            document.getElementById("<%= hdnPNAME.ClientID %>").value = PName;
            document.getElementById("<%= hdnBID.ClientID %>").value = Bid;

        }

        function closeData()
        { }
        function SelectedReceiptNo(dAmount, dDate, dReceiptNo, PNAME, PNumber, ddetid, dpatid, dvisitid, sType, BilledBy, Age, DuplicateCoply) {

            var duplicate;
            if (document.getElementById(DuplicateCoply).value != null) {
                if (document.getElementById(DuplicateCoply).checked == true)
                    duplicate = "Y";
                else
                    duplicate = "N";

            }
            else {
                duplicate = "N";
            }
            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
            strFeatures = strFeatures + ",left=0,top=0";
            var strURL = "../Reception/PrintDepositReceipt.aspx?Amount="
            + dAmount
            + "&dDate=" + dDate
            + "&rcptno=" + dReceiptNo
            + "&PID=" + dpatid
            + "&VID=" + dvisitid
            + "&pdid=" + ddetid
            + "&pDet=" + sType
            + "&PNAME=" + PNAME
            + "&PNumber=" + PNumber
            + "&BBY=" + BilledBy
             + "&Age=" + Age
            + "&Duplicate=" + duplicate + "";
            window.open(strURL, "", strFeatures, true);

        }
        //Print Receipt - Start
        function PrintSelectedReceiptNo(dReceiptNo) {

            //            var duplicate;
            //            if (document.getElementById(DuplicateCoply).value != null) {
            //                if (document.getElementById(DuplicateCoply).checked == true)
            //                    duplicate = "Y";
            //                else
            //                    duplicate = "N";

            //            }
            //            else {
            //                duplicate = "N";
            //            }
            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
            strFeatures = strFeatures + ",left=0,top=0";
            //            var strURL = "../Reception/PrintDepositReceipt.aspx?Amount="
            var strURL = "../Admin/PrintVoucherPage.aspx?OID=&VONO=&IFVNO=" + dReceiptNo;
            window.open(strURL, "", strFeatures, true);
        }
        //Print Receipt - end
        function SelectedPaymentReceiptNo(dAmount, dDate, dReceiptNo, PNAME, PNumber, ddetid, dpatid, dvisitid, sType, BilledBy, Age, DuplicateCoply) {

            var duplicate;
            if (document.getElementById(DuplicateCoply).value != null) {
                if (document.getElementById(DuplicateCoply).checked == true)
                    duplicate = "Y";
                else
                    duplicate = "N";

            }
            else {
                duplicate = "N";
            }
            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
            strFeatures = strFeatures + ",left=0,top=0";
            var strURL = "../Inpatient/PrintReceiptPage.aspx?Amount="
            + dAmount
            + "&dDate=" + dDate
            + "&rcptno=" + dReceiptNo
            + "&PID=" + dpatid
            + "&VID=" + dvisitid
            + "&pdid=" + ddetid
            + "&pDet=" + sType
            + "&PNAME=" + PNAME
            + "&PNumber=" + PNumber
            + "&BBY=" + BilledBy
             + "&Age=" + Age
             + "&Duplicate=" + duplicate + "";
            window.open(strURL, "", strFeatures, true);

        }
    </script>


