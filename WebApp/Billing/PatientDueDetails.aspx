<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientDueDetails.aspx.cs"
    Inherits="Billing_PatientDueDetails" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/DueDetails.ascx" TagName="DueDetail" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/InPatientProceduresBill.ascx" TagName="ipTreatmentBillDetails"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/ConsultationDetails.ascx" TagName="ipConsultationDetails"
    TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/InPatientInvestigation.ascx" TagName="ipInvestigation"
    TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="ucinv1" %>
<%@ Register Src="../CommonControls/DynamicDHEBAdder.ascx" TagName="DHEBAdd" TagPrefix="uc12" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="paymentType"
    TagPrefix="uc13" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<%@ Register Src="../CommonControls/DateSelection.ascx" TagName="DateSelection" TagPrefix="DateCtrl" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
  </head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scrpt" runat="server">
    </asp:ScriptManager>

    <script language="javascript" type="text/javascript">
        /* Common Alert Validation */
        var AlertType;

//        $(document).ready(function() {
//            AlertType = SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04') == null ? "Alert" : SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04');
//        });

        function ShowAlertMsg(key) {
            /* Added By Venkatesh S */
            var vNoRecordFound = SListForAppMsg.Get('Billing_PatientDueDetails_aspx_01') == null ? "No Matching Records Found" : SListForAppMsg.Get('Billing_PatientDueDetails_aspx_01');
            AlertType = SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04') == null ? "Alert" : SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04');
              var userMsg = SListForApplicationMessages.Get(key);
              if (userMsg != null) {
                //alert(userMsg);
                ValidationWindow(userMsg, AlertType);
                  return false;
              }
              else {
                ValidationWindow(vNoRecordFound, AlertType);
                  return false;
              }
              return true;
          }





          function SelectSingleRow(rid, Pdid, PNum, BillNum, PName, patientId, CurrentVisitState) {
              var len = document.forms[0].elements.length;
              for (var i = 0; i < len; i++) {
                  if (document.forms[0].elements[i].type == "radio") {
                      document.forms[0].elements[i].checked = false;
                  }
                  document.getElementById(rid).checked = true;
                  document.getElementById('hdnPNo').value = PNum;
                  document.getElementById('hdnBillNo').value = BillNum;
                  document.getElementById('hdnPatientname').value = PName;
                  document.getElementById('hdnrdo').value = Pdid;
                  document.getElementById('hdnPatientId').value = patientId;
                  document.getElementById('hdnCurrentVisitState').value = CurrentVisitState;

              }
          }
          function ValidatePatientName() {
            /* Added By Venkatesh S */
            var vSelectPatient = SListForAppMsg.Get('Billing_PatientDueDetails_aspx_02') == null ? "Select patient" : SListForAppMsg.Get('Billing_PatientDueDetails_aspx_02');
            var vDueAmt = SListForAppMsg.Get('Billing_PatientDueDetails_aspx_03') == null ? "Due amount cannot be collected for Existing In Patient" : SListForAppMsg.Get('Billing_PatientDueDetails_aspx_03');
            AlertType = SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04') == null ? "Alert" : SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04');
              if (document.getElementById("hdnrdo").value == '') {
                      ValidationWindow(vSelectPatient, AlertType);
                      return false;
                  var userMsg = SListForApplicationMessages.Get("Billing\\PatientDueDetails.aspx_1");
                  if (userMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg, AlertType);
                      return false;
                  }
                  else {
                    ValidationWindow(vSelectPatient, AlertType);
                      return false;
                  }
                  return false;
              }
              if (document.getElementById("hdnCurrentVisitState").value == 'Y') {

                  var userMsg = SListForApplicationMessages.Get("Billing\\PatientDueDetails.aspx_4");
                  if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlertType);
                      return false;
                  }
                  else {
                    ValidationWindow(vDueAmt, AlertType);
                      return false;
                  }
                  return false;
              }
              else {
                  return true;
              }
          }
         
    </script>
          <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <%--<div id="Nodata" runat="server" visible="false">
                        <asp:Label ID="lblMessage" runat="server" Text="No Data Available for the selected patient"></asp:Label>
                           
                            <asp:Button ID="Button1" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                onmouseout="this.className='btn'" Text="Back" OnClick="btnClose_Click" />
                        </div>--%>
                        
                         <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                        <div>
                            <table border="0" cellpadding="1" cellspacing="1" class="dataheader2 defaultfontcolor w-100p searchPanel">
                                <tr>
                                    <td class="w-10p">
                                        <asp:Label ID="Rs_PatientNo" Text="Patient No:" runat="server" meta:resourcekey="Rs_PatientNoResource1"></asp:Label>
                                    </td>
                                    <td class="w-20p">
                                        <asp:TextBox ID="txtPatientNo" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtPatientNoResource1"></asp:TextBox>
                                        <ajc:FilteredTextBoxExtender runat="server" FilterType="Custom,Numbers" ID="filtxtPatientNo"
                                            TargetControlID="txtPatientNo" ValidChars="1234567890qwertyuiopasdfghjklzxcvbnm/.SDCEFGHIKJLMNOPQRSTUVWXYZAN" Enabled="True">
                                        </ajc:FilteredTextBoxExtender>
                                    </td>
                                    <td>
                                        <DateCtrl:DateSelection ID="ucDateCtrl" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Rs_PatientName" Text="Patient Name:" runat="server" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPatientName" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                                    </td>
                                    <td>
                                        <table class="w-100p">
                                            <tr>
                                                 <td class="w-12p">
                                                   <asp:Label ID="lblLocation" runat="server" Text="Location" meta:resourcekey="Rs_SelectLocationResource1"
                                                    class="w-82"></asp:Label></td>
                                                <td>
                                                    <asp:DropDownList ID="ddlLocation" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlLocationResource1">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Rs_BillNo" Text="Bill No:" runat="server" meta:resourcekey="Rs_BillNoResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtBillNo" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtBillNoResource1"></asp:TextBox>
                                        <ajc:FilteredTextBoxExtender runat="server" FilterType="Custom,Numbers" ID="filtxtBillNo"
                                          ValidChars="1234567890qwertyuiopasdfghjklzxcvbnm/.BSDCEFGHIKJLMNOPQRSTUVWXYZAN"  TargetControlID="txtBillNo" Enabled="True">
                                        </ajc:FilteredTextBoxExtender>
                                    </td>
                                     <td>
                                        <table>
                                            <tr>
                                                 <td class="w-12p">
                                                    <asp:Label ID="LblVisitNumber" Text="Visit Number:" runat="server" meta:resourcekey="Rs_VisitNumber1"></asp:Label>
                                                </td>
                                                <td class="w-10p">
                                                    <asp:TextBox ID="txtVisitNumber" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtVisitNumber1"></asp:TextBox>
                                                </td>
                                                <td class="a-left">
                                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click"
                                                meta:resourcekey="btnSearchResource1" OnClientClick="return chkdateEmpty('ucDateCtrl');"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="YesData" runat="server">
                            <table class="w-100p" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td colspan="3">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" class="a-center">
                                        <asp:GridView ID="gvDueDetails" runat="server" AutoGenerateColumns="False"
                                            CssClass="dataheaderInvCtrl w-100p gridView" PagerSettings-Mode="NextPrevious" OnRowDataBound="gvDueDetails_RowDataBound"
                                            AllowPaging="true" PageSize="25" meta:resourcekey="gvDueDetailsResource1" OnPageIndexChanging="gvDueDetails_PageIndexChanging">
                                            <PagerStyle HorizontalAlign="Center" />
                                            <HeaderStyle CssClass="dataheader1" />
                                            <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                            <Columns>
                                        <asp:BoundField HeaderText="PatientID" Visible="false" DataField="PatientID" meta:resourcekey="BoundFieldResource1" />
                                                <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                    <ItemTemplate>
                                                        <asp:RadioButton ID="rdoSelect" runat="server" GroupName="PatientSel" meta:resourcekey="rdoSelectResource1" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                 <asp:BoundField DataField="VersionNo" HeaderText="Visit Number" ItemStyle-HorizontalAlign="Left"
                                                    meta:resourcekey="BoundFieldResource8" />
                                                     <asp:BoundField DataField="BillNo" HeaderText="Bill No." ItemStyle-HorizontalAlign="Left"
                                                    meta:resourcekey="BoundFieldResource6" />
                                                <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" ItemStyle-HorizontalAlign="Left"
                                                    meta:resourcekey="BoundFieldResource1" />
                                                <asp:BoundField DataField="PatientName" ItemStyle-HorizontalAlign="Left" HeaderText="Patient Name"
                                                    meta:resourcekey="BoundFieldResource2" />
                                                <asp:BoundField DataField="CreatedAt" ItemStyle-HorizontalAlign="Center" HeaderText="Bill Date" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" meta:resourcekey="BoundFieldResource79" />
                                                 <asp:BoundField DataField="NetValue" HeaderText="Total Amount" ItemStyle-HorizontalAlign="Left"
                                                    meta:resourcekey="BoundFieldResource5" />
                                                     <asp:BoundField DataField="WriteOffAmt" HeaderText="Paid Amount" ItemStyle-HorizontalAlign="Left"
                                                    meta:resourcekey="BoundFieldResource10" />
                                                <asp:BoundField DataField="DueAmount" ItemStyle-HorizontalAlign="Right" HeaderText="Total Due Amount"
                                                    meta:resourcekey="BoundFieldResource3" />
                                                <asp:BoundField DataField="DuePaidAmt" HeaderText="Total Paid Due" ItemStyle-HorizontalAlign="Right"
                                                    meta:resourcekey="BoundFieldResource4" />
                                                    <asp:BoundField DataField="UserName" HeaderText="Billed Location" ItemStyle-HorizontalAlign="Right"
                                                    meta:resourcekey="BoundFieldResource7" />
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-center">
                                        <asp:Button ID="btnCollectDueAmt" runat="server" CssClass="btn" Visible="False" Text="Collect Due Amount"
                                            OnClick="btnCollectDueAmt_Click" OnClientClick="return ValidatePatientName();"
                                            meta:resourcekey="btnCollectDueAmtResource1" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
          <Attune:Attunefooter ID="Attunefooter" runat="server" />       
        <input type="hidden" id="hdnPNo" runat="server" name="pid" />
        <input type="hidden" id="hdnBillNo" runat="server" name="FiD" />
        <input type="hidden" id="hdnPatientname" runat="server" name="pName" />
        <input type="hidden" id="hdnrdo" runat="server" />
        <input type="hidden" id="hdnPatientId" runat="server" />
        <input type="hidden" id="hdnCurrentVisitState" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
