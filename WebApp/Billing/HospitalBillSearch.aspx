<%@ Page EnableEventValidation="false" Language="C#" AutoEventWireup="true" CodeFile="HospitalBillSearch.aspx.cs"
    Inherits="Billing_HospitalBillSearch" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/HospitalBillSearch.ascx" TagName="BillSearch"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<%--Added bt Thamilselvan to Call the ASIS product Functionality.... Changing same as Billing Page....--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Bill Search</title>
       <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
   <script src="../Scripts/AdobeReaderDetection.js" type="text/javascript" language="javascript" />
  <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>
     
    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
   
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server" defaultbutton="bGo">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <script language="javascript" type="text/javascript">

        //Added bt Thamilselvan to Call the ASIS product Functionality.... Changing same as Billing Page....
        function OpenIframe(FinalBillID, patientVisitID) {
            $("#iframeBill1").html("<iframe id='myiframe' name='myname' src='..\\Investigation\\BillPrint.aspx?vid=" + patientVisitID + "&finalBillID=" + FinalBillID + "&actionType=POPUP&type=printreport&invstatus=approve' style='position:absolute;top:0px; left:0px;width:0px; height:0px;border:0px;overfow:none; z-index:-1'></iframe>");
        }
        //Added bt Thamilselvan to Call the Print Screen Popup While Clicking the PrintBill Button.... Changing same as Billing Page....
        function OpenIframe1() {
            var FullBill = $('#hdnIsFullBill').val(); //Added by Thamilselvan...for Full Bill
            if (FullBill != 'Y') {//Added by Thamilselvan...for Full Bill
                $("#iframeBill1").html("<iframe id='myiframe' name='myname' src='..\\Investigation\\BillPrint.aspx?vid=" + $('#hdnVID').val() + "&finalBillID=" + $('#hdnBID').val() + "&actionType=DefaultPrint&type=printreport&invstatus=approve' style='position:absolute;top:0px; left:0px;width:0px; height:0px;border:0px;overfow:none; z-index:-1'></iframe>");
            }
            else {//Added by Thamilselvan...for Full Bill
                $("#iframeBill1").html("<iframe id='myiframe1' name='myname' src='..\\Investigation\\BillPrint.aspx?vid=" + $('#hdnVID').val() + "&finalBillID=" + $('#hdnBID').val() + "&actionType=DefaultPrint&isFullBill=Y&type=printreport&invstatus=approve' style='position:absolute;top:0px; left:0px;width:0px; height:0px;border:0px;overfow:none; z-index:-1'></iframe>");
            }
        }



        function ShowAlertMsg(key) {
            /* Added By Venkatesh S */
            var vURLValidation = SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_03');
            var vAction = SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_04');
            var AlertType = SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04') == null ? "Alert" : SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04'); 

            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
            }
            else if (key == "Billing\\HospitalBillSearch.aspx.cs_10") {
                ValidationWindow(vURLValidation, AlertType);
            }

            else if (key == "Billing\\HospitalBillSearch.aspx.cs_11") {
                ValidationWindow(vAction, AlertType);
            }
           
            return true;
        }
    
    
      function consentalert()
      {
           alert("Consent form not applicable for this patient");
           return true;
      }
      function HideModalPopupcheck() {
          $find("modalpopupsendemail").hide();
          return false;
      }
      function HideModalPopupcheckctk() {
          $find("modalpopupCTK").hide();
         // $find("modalpopupCTE").show();
          return false;
      }
      function HideModalPopupcheckcte() {
          $find("modalpopupCTE").hide();
            if (document.getElementById("hdnisMRI").value == "Y") {
              $find("modalpopupMRIK").show();
          }
          return false;
      }
      function HideModalPopupcheckmrik() {
          $find("modalpopupMRIK").hide();
          $find("modalpopupMRIE").show();
          return false;
      }
        function HideModalPopupcheckmrie() {
            $find("modalpopupMRIE").show();
            return false;
        } 
    
    
        var userMsg;
        function VisitDetails(visitID, PatientID, PName, PNumber, Bid, BillNo, MemberShipCardNo) {

            document.getElementById("<%= hdnVID.ClientID %>").value = visitID;
            document.getElementById("<%= hdnPID.ClientID %>").value = PatientID;
            document.getElementById("<%= hdnPNAME.ClientID %>").value = PName;
            document.getElementById("<%= hdnPNumber.ClientID %>").value = PNumber;
            document.getElementById("<%= hdnBID.ClientID %>").value = Bid;
            document.getElementById("<%= hdnBillNo.ClientID %>").value = BillNo;


            //Added by Thamilselvan for showing the IFrame in Model Popup.......Added the MemberShipCardNo
            document.getElementById("<%=hdnMembershipCardno.ClientID %>").value = MemberShipCardNo;


        }
        function setBillNumber(billno) {
            document.getElementById('hdnBillNumber').value = billno;
        }
        function HideActions(obj) {
            if (obj == 'Y') {
                $("#dList option[value='Cancel_Bill_RefundtoPatient']").attr("disabled", "disabled");
                $("#dList option[value='Refund_to_Patient_RefundtoPatient']").attr("disabled", "disabled");
            }
            else {
                $("#dList option[value='Cancel_Bill_RefundtoPatient']").removeAttr("disabled", false);
                $("#dList option[value='Refund_to_Patient_RefundtoPatient']").removeAttr("disabled", false);
            }
        }

        function CheckVisitID() {
            /* Added By Venkatesh S */
            var vDueValidation = SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_05') == null ? "Due Collection Bill Cannot be Refunded" : SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_05');
            var vAction = SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_06') == null ? "Amount already Refunded to this Bill" : SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_06');
            var vCanRef = SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_07') == null ? "Cannot Refund to Selected Bill" : SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_07');
            var vSelectPatient = SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_08') == null ? "selected Patient is not credit" : SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_08');
            var vPatientNotDis = SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_09') == null ? "Selected Patient not discharged" : SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_09');
            var vSelectBill = SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_10') == null ? "Select bill number" : SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_10');
            var vBillCancel = SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_11') == null ? "This bill has been cancelled" : SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_11');
            var vAmtBill = SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_12') == null ? "Amount already Refunded to this Bill" : SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_12');
            var vPatientCredit = SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_13') == null ? "Selected Patient is not credit Patient" : SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_13');
            var vSelectCoPatient = SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_14') == null ? "Selected Patient is Co Payment Patient" : SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_14');
            var AlertType = SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04') == null ? "Alert" : SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04'); 
            var ddlaction = document.getElementById('dList')
            var vNochecklist = SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_15') != null ? "No Checklist for this Bill" : SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_15');
            var Vnosameday = SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_15') != null ? "Cancellation Not Allowed for Past Day Visit" : SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_15');
            var vduepending = SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_15') != null ? "Refund/Cancel can be Initiated after the due Cleared for the Patient Bill" : SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_15');
            var Vrefundsameday = SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_15') != null ? "Refund Not Allowed for Same Day Visit" : SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_15');

            var vCanRefClientType = SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_18') == null ? "Selected Patient is Credit Client, Cannot Refund the Bill" : SListForAppMsg.Get('Billing_HospitalBillSearch_aspx_18');
            
            var hdnBillSearchChecklist = document.getElementById('hdnBillSearchChecklist').value;
            var hdnBillSameday = document.getElementById('hdnBillSameday').value;
            var hdnDuePending = document.getElementById('hdnDuePending').value;
            var visitcreditClient = document.getElementById("hdnVisitTypeCredit").value.split('~');
            if (ddlaction.options[ddlaction.selectedIndex].text == 'Checklist Print' && hdnBillSearchChecklist != 'Y') {
                ValidationWindow(vNochecklist, AlertType);
                return false;
            }
            if (ddlaction.options[ddlaction.selectedIndex].text == 'Cancel Bill' && hdnBillSameday == 'N' && visitcreditClient[1] != 'Y') {
                ValidationWindow(Vnosameday, AlertType);
                return false;
            }
            if (ddlaction.options[ddlaction.selectedIndex].text == 'Cancel Bill' && hdnDuePending == 'Y') {
                ValidationWindow(vduepending, AlertType);
                return false;
            }
            if (ddlaction.options[ddlaction.selectedIndex].text == 'Refund to Patient') {
                if (ddlaction.options[ddlaction.selectedIndex].text == 'Refund to Patient' && hdnBillSameday == 'S' && visitcreditClient[1] == 'Y') {
                    ValidationWindow(vCanRefClientType, AlertType);
                    return false;
                }
                if (ddlaction.options[ddlaction.selectedIndex].text == 'Refund to Patient' && hdnBillSameday == 'S' && visitcreditClient[1] == 'N') {
                    ValidationWindow(Vrefundsameday, AlertType);
                    return false;
                }
                if (ddlaction.options[ddlaction.selectedIndex].text == 'Refund to Patient' && hdnDuePending == 'Y') {
                    ValidationWindow(vduepending, AlertType);
                    return false;
                }          
                if (document.getElementById('uctrlBillSearch_hdnCollectionType').value == 'Due Collection') {
                    userMsg = SListForApplicationMessages.Get('Billing\\HospitalBillSearch.aspx_7');
                    if (userMsg != null) {
                        ValidationWindow(userMsg, AlertType);
                       // alert(userMsg);
                        return false;
                    }
                    else {
                        ValidationWindow(vDueValidation, AlertType);
                        return false;
                    }
                }

                var BalAmt = document.getElementById('uctrlBillSearch_hdnReceivedAmount').value;
                var TotAmount = document.getElementById('uctrlBillSearch_hdnTotalAmount').value;
                var RefAmt = document.getElementById('uctrlBillSearch_hdnRefundAmount').value;
                if (document.getElementById('uctrlBillSearch_hdnRefundstatus').value == 'REFUND') {

                    if (BalAmt > 0) {
                        if ((Number(BalAmt) + Number(RefAmt)) > Number(TotAmount)) {
                            userMsg = SListForApplicationMessages.Get('Billing\\HospitalBillSearch.aspx_8');
                            if (userMsg != null) {
                                ValidationWindow(userMsg, AlertType);
                               // alert(userMsg);
                                return false;
                            }
                            else {
                                ValidationWindow(vAction, AlertType);
                                return false;
                            }
                        }
                    }
                    if (BalAmt <= 0) {
                        userMsg = SListForApplicationMessages.Get('Billing\\HospitalBillSearch.aspx_9');
                        if (userMsg != null) {
                            ValidationWindow(userMsg, AlertType);
                            //alert(userMsg);
                            return false;
                        }
                        else {
                            ValidationWindow(vCanRef, AlertType);
                            return false;
                        }
                    }
                }
            }
            if (ddlaction.options[ddlaction.selectedIndex].text == 'EditIPBillSettlement') {
                var visitcredit = document.getElementById("hdnVisitTypeCredit").value.split('~');

                if ((visitcredit[0] == 0 && visitcredit[1] == 'N') || (visitcredit[0] == 1 && visitcredit[1] == 'N')) {
                    userMsg = SListForApplicationMessages.Get('Billing\\HospitalBillSearch.aspx_2');
                    if (userMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg, AlertType);
                        return false;
                    }
                    else {
                        ValidationWindow(vSelectPatient, AlertType);
                        return false;
                    }
                }
                if (visitcredit[2] == 'Discharged') {
                    return true;
                }
                else {
                    userMsg = SListForApplicationMessages.Get('Billing\\HospitalBillSearch.aspx_3');
                    if (userMsg != null) {
                        // alert(userMsg);
                        ValidationWindow(userMsg, AlertType);
                        return false;
                    }
                    else {
                        ValidationWindow(vPatientNotDis, AlertType);
                        return false;
                    }
                }
            }
             
            if (document.getElementById("<%= hdnVID.ClientID %>").value == '0') {
                ValidationWindow(vSelectBill, AlertType);
                return false;
            }
            else {
                if (document.getElementById("<%= hdnBillStatus.ClientID %>").value == 'CANCELLED') {
                    userMsg = SListForApplicationMessages.Get('Billing\\HospitalBillSearch.aspx_5');
                    if (userMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg, AlertType);
                        return false;
                    }
                    else {
                        ValidationWindow(vBillCancel, AlertType);
                        return false;
                    }
                }
                else if (ddlaction.options[ddlaction.selectedIndex].text == 'Refund to Patient') {
                    if (document.getElementById('uctrlBillSearch_hdnRefundstatus').value == 'REFUND') {
                        var BalAmt2 = document.getElementById('uctrlBillSearch_hdnReceivedAmount').value;
                        if (BalAmt2 <= 0) {
                            ValidationWindow(vAmtBill, AlertType);
                            return false;
                        }
                    } 
                }
                else if (ddlaction.options[ddlaction.selectedIndex].text == 'Cancel Bill' || ddlaction.options[ddlaction.selectedIndex].text == 'View & Cancel Bill') {
                    var BalAmt1 = document.getElementById('uctrlBillSearch_hdnReceivedAmount').value;


                }
                
                else if (ddlaction.options[ddlaction.selectedIndex].text == 'Edit Bill') {
                    var visitcredit = document.getElementById("hdnVisitTypeCredit").value.split('~');

                    if (visitcredit[1] == 'N') {
                        userMsg = SListForApplicationMessages.Get('Billing\\HospitalBillSearch.aspx_2');
                        if (userMsg != null) {
                            //alert(userMsg);                           
                            ValidationWindow(vPatientCredit, AlertType);
                            return false;
                        }
                        else {
                            ValidationWindow(vPatientCredit, AlertType);
                            return false;
                        }
                    }
                    if (visitcredit[3] == 'Y') {
                        userMsg = SListForApplicationMessages.Get('Billing\\HospitalBillSearch.aspx_2');
                        if (userMsg != null) {
                            //alert(userMsg);                            
                            ValidationWindow(vSelectCoPatient, AlertType);
                            return false;
                        }
                        else {
                            ValidationWindow(vSelectCoPatient, AlertType);
                            return false;
                        }
                    }

                }
                else {
                    document.getElementById("<%= hdnVisitDetail.ClientID %>").value = document.getElementById("<%= dList.ClientID %>").options[document.getElementById("<%= dList.ClientID %>").selectedIndex].innerHTML;
                    return true;
                } 
            } 
        }


        function PrintReport() {
            var vid = document.getElementById('hdnVID').value;
            var pid = document.getElementById('hdnPID').value;
            var bid = document.getElementById('hdnBID').value;
            var ddlaction = document.getElementById('dList');
            if (ddlaction.options[document.getElementById('dList').selectedIndex].innerHTML == 'Print_Bill_Print_Page') {


                var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
                strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
                // ADDED THE LINE BELOW TO ORIGINAL EXAMPLE
                strFeatures = strFeatures + ",left=0,top=0";
               var chk=document.getElementById('uctrlBillSearch_chkSplit');
                var strURL;
                if(chk.checked==true)
                {
                strURL = "../Reception/ViewPrintPage.aspx?vid=" + vid + "&pagetype=BP&IsPopup=Y&CCPage=Y&pid=" + pid + "&bid=" + bid+"&Split=Y&ViewSplitCheckbox=Y";
                
                }
                else 
                {
                 strURL = "../Reception/ViewPrintPage.aspx?vid=" + vid + "&pagetype=BP&IsPopup=Y&CCPage=Y&pid=" + pid + "&bid=" + bid +"&ViewSplitCheckbox=Y";;
                
                } 
                var PrintWindow = window.open(strURL, "", strFeatures);
                PrintWindow.focus();
                PrintWindow.print();



            }
        }
        function PrintDynamic() {
            var vid = document.getElementById('hdnVID').value;
            var pid = document.getElementById('hdnPID').value;
            var bid = document.getElementById('hdnBID').value;
            var ddlaction = document.getElementById('dList');
            if (ddlaction.options[document.getElementById('dList').selectedIndex].innerHTML == 'Print Bill') {


                var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
                strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
                // ADDED THE LINE BELOW TO ORIGINAL EXAMPLE
                strFeatures = strFeatures + ",left=0,top=0";
                var strURL = "../Reception/ViewPrintPage.aspx?vid=" + vid + "&pagetype=BP&IsPopup=Y&CCPage=Y&dinc=y&pid=" + pid + "&bid=" + bid;
                var PrintWindow = window.open(strURL, "", strFeatures);



            }
        }
    </script>

    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p">
            <tr>
                <td>
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
            <tr>
                <td class="w-100p" style="display: none;" runat="server" id="pagetdPrint" enableviewstate="false">
                </td>
            </tr>
            <tr id="aRow" class="w-100p a-center" runat="server" visible="false">
                <td class="defaultfontcolor w-100p">
                    <asp:Label ID="Rs_SelectaBillandPerformoneofthefollowing" Text="Select a Bill and Perform one of the following"
                        runat="server" meta:resourcekey="Rs_SelectaBillandPerformoneofthefollowingResource1"></asp:Label>
                    <asp:DropDownList ID="dList" runat="server" CssClass="ddlsmall" meta:resourcekey="dListResource1">
                    </asp:DropDownList>
                    <%--<asp:UpdatePanel ID="updatePanel1" runat="server">
                                    <ContentTemplate>--%>
                                    <asp:Button ID="bGo" runat="server" Text="Go" OnClick="bGo_Click" CssClass="btn"
                                        OnClientClick="javascript:return CheckVisitID();" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" meta:resourcekey="bGoResource1" />
                                    <%--</ContentTemplate>
                                    </asp:UpdatePanel>--%>
                </td>
            </tr>
        </table>
    </div>
    <%--Added by Thamilselvan for showing the IFrame in Model Popup...............--%>
    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdnTargetCtlMailReport" runat="server" />            
            <asp:HiddenField ID="hdnisCT" runat="server" />
            <asp:HiddenField ID="hdnisMRI" runat="server" />
            <cc1:ModalPopupExtender ID="modalpopupsendemail" runat="server" PopupControlID="pnlMailReports"
                TargetControlID="hdnTargetCtlMailReport" BackgroundCssClass="modalBackground"
                CancelControlID="btnCancel" DynamicServicePath="" Enabled="True">
            </cc1:ModalPopupExtender> 
               <cc1:ModalPopupExtender ID="modalpopupCTK" runat="server" PopupControlID="pnlconforCTK"
                TargetControlID="hdnTargetCtlMailReport" BackgroundCssClass="modalBackground"
                CancelControlID="btncancelctk" DynamicServicePath="" Enabled="True">
            </cc1:ModalPopupExtender>
             <cc1:ModalPopupExtender ID="modalpopupCTE" runat="server" PopupControlID="pnlconforCTE"
                TargetControlID="hdnTargetCtlMailReport" BackgroundCssClass="modalBackground"
                CancelControlID="btncancelcte" DynamicServicePath="" Enabled="True">
            </cc1:ModalPopupExtender>
            <cc1:ModalPopupExtender ID="modalpopupMRIK" runat="server" PopupControlID="pnlconforMRIK"
                TargetControlID="hdnTargetCtlMailReport" BackgroundCssClass="modalBackground"
                CancelControlID="btncancelmrik" DynamicServicePath="" Enabled="True">
            </cc1:ModalPopupExtender>
            <cc1:ModalPopupExtender ID="modalpopupMRIE" runat="server" PopupControlID="pnlconforMRIE"
                TargetControlID="hdnTargetCtlMailReport" BackgroundCssClass="modalBackground"
                CancelControlID="btncancelmrie" DynamicServicePath="" Enabled="True">
            </cc1:ModalPopupExtender>
            <asp:Panel ID="pnlMailReports" BorderWidth="1px" CssClass="modalPopup dataheaderPopup w-70p"
                runat="server" meta:resourcekey="pnlMailReportResource1">
                <asp:Panel ID="Panel5" runat="server" CssClass="dialogHeader w-100p" Height="550px"
                    meta:resourcekey="Panel1Resource1">
                    <table class="w-100p">
                        <tr>
                            <td class="h-100p a-center">
                                <iframe id="CouponCardBillFrame" runat="server" name="myname" src="#toolbar=1" class="w-100p" style="height:500px; width:500px;"></iframe>
                               <%-- <input type="button" id="btnBillPrint" class="a-center font14 h-25 w-45" style='background-color: Transparent;
                                    color: white; border-style: solid; border-width: thin; border-color: White;'
                                    value="Print" onclick="javascript:return OpenIframe1();" />--%>
                                <asp:Button ID="btnCancel" CssClass="btn" runat="server" OnClick="btn_DisableIframSRC"
                                    Text="Close" meta:resourcekey="btnCancelResource1" />
                                <%--//Added by Thamilselvan...for Full Bill--%>
                                <%--<asp:Button ID="btnFullBill" CssClass="btn" runat="server" OnClick="btn_OpenFullBill_Click"
                                    Text="Print Complete Bill" meta:resourcekey="btnFullBillResource1" />--%>
                            </td>
                        </tr>
                    </table>
                    <%--//Added by Thamilselvan...for Full Bill--%>
                    <input type="hidden" id="hdnIsFullBill" name="hdnFull" runat="server" />
                </asp:Panel>
            </asp:Panel>
            <asp:Panel ID="pnlconforCTK" BorderWidth="1px" CssClass="modalPopup dataheaderPopup w-70p"
                runat="server" meta:resourcekey="pnlconforCTKResource1">
                <asp:Panel ID="Panel3" runat="server" CssClass="dialogHeader w-100p" Height="550px"
                    meta:resourcekey="Panel3Resource1">
                    <table class="w-100p">
                        <tr>
                            <td class="h-100p a-center">
                                <iframe id="ConsentformctkFrame" runat="server" name="myname" src="#toolbar=1" class="w-100p" style="height:500px; width:500px;"></iframe>
                                <asp:Button ID="btncancelctk" CssClass="btn" runat="server" OnClientClick="return HideModalPopupcheckctk()"
                                    Text="Close" meta:resourcekey="btnCancelResource1" />
                            </td>
                        </tr>
                    </table>  
                </asp:Panel>
            </asp:Panel>
            <asp:Panel ID="pnlconforCTE" BorderWidth="1px" CssClass="modalPopup dataheaderPopup w-70p"
                runat="server" meta:resourcekey="pnlconforCTEResource1">
                <asp:Panel ID="Panel4" runat="server" CssClass="dialogHeader w-100p" Height="550px"
                    meta:resourcekey="Panel4Resource1">
                    <table class="w-100p">
                        <tr>
                            <td class="h-100p a-center">
                                <iframe id="ConsentformcteFrame" runat="server" name="myname" src="#toolbar=1" class="w-100p" style="height:500px; width:500px;"></iframe>
                                <asp:Button ID="btncancelcte" CssClass="btn" runat="server" OnClientClick="return HideModalPopupcheckcte()"
                                    Text="Close" meta:resourcekey="btnCancelResource1" />
                            </td>
                        </tr>
                    </table>  
                </asp:Panel>
            </asp:Panel>
            <asp:Panel ID="pnlconforMRIK" BorderWidth="1px" CssClass="modalPopup dataheaderPopup w-70p"
                runat="server" meta:resourcekey="pnlconforMRIKResource1">
                <asp:Panel ID="Panel6" runat="server" CssClass="dialogHeader w-100p" Height="550px"
                    meta:resourcekey="Panel6Resource1">
                    <table class="w-100p">
                        <tr>
                            <td class="h-100p a-center">
                                <iframe id="ConsentformMRIKFrame" runat="server" name="myname" src="#toolbar=1" class="w-100p" style="height:500px; width:500px;"></iframe>
                                <asp:Button ID="btncancelmrik" CssClass="btn" runat="server" OnClientClick="return HideModalPopupcheckmrik()"
                                    Text="Close" meta:resourcekey="btnCancelResource1" />
                            </td>
                        </tr>
                    </table>  
                </asp:Panel>
            </asp:Panel>
            <asp:Panel ID="pnlconforMRIE" BorderWidth="1px" CssClass="modalPopup dataheaderPopup w-70p"
                runat="server" meta:resourcekey="pnlconforMRIEResource1">
                <asp:Panel ID="Panel7" runat="server" CssClass="dialogHeader w-100p" Height="550px"
                    meta:resourcekey="Panel6Resource1">
                    <table class="w-100p">
                        <tr>
                            <td class="h-100p a-center">
                                <iframe id="ConsentformMRIEFrame" runat="server" name="myname" src="#toolbar=1" class="w-100p" style="height:500px; width:500px;"></iframe>
                                <asp:Button ID="btncancelmrie" CssClass="btn" runat="server" OnClientClick="return HideModalPopupcheckmrie()"
                                    Text="Close" meta:resourcekey="btnCancelResource1" />
                            </td>
                        </tr>
                    </table>  
                </asp:Panel>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
    <%--Added by Thamilselvan for showing the IFrame in Model Popup.....END..........--%>
    <input type="hidden" id="hdnBillNo" name="bid" value="0" runat="server" />
    <input type="hidden" id="hdnBID" name="bid" value="0" runat="server" />
    <input type="hidden" id="hdnVID" name="vid" value="0" runat="server" />
    <input type="hidden" id="hdnPID" name="pid" value="0" runat="server" />
    <input type="hidden" id="hdnPNAME" name="PName" runat="server" />
    <input type="hidden" id="hdnPNumber" name="PNumber" runat="server" />
    <input type="hidden" id="hdnVisitDetail" runat="server" />
    <input type="hidden" id="hdnBillStatus" name="bStatus" runat="server" />
    <input type="hidden" id="hdnpatientType" runat="server" />
    <input type="hidden" id="hdnBillSearchChecklist" runat="server" />
    <input type="hidden" id="hdnBillSameday" runat="server" />
    <input type="hidden" id="hdnDuePending" runat="server" />
    <input type="hidden" id="hdnVisitTypeCredit" name="bStatus1" runat="server" />
    <%--Added by Thamilselvan for showing the IFrame in Model Popup...............--%>
    <input type="hidden" id="hdnMembershipCardno" name="bCardNo" runat="server" />
    <asp:HiddenField runat="server" ID="hdnBillNumber" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
		        <asp:HiddenField ID="hdnOldSearch" runat="server" />
    <%--Added by Thamilselvan for showing the IFrame in Model Popup...............--%>
    <div id="iframeBill1">
    </div>

    </form>
</body>
</html>
