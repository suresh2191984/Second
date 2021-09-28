<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintPage.aspx.cs" Inherits="Reception_PrintPage" meta:resourcekey="PageResource2" %>
<%@ Register Src="../CommonControls/PrintPrescription.ascx" TagName="PrintPrescription" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OPCaseSheet.ascx" TagName="OPCaseSheet" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/BillPrint.ascx" TagName="BillPrint" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LabBillPrint.ascx" TagName="SRSBillPrint" TagPrefix="uc27" %>
<%@ Register Src="../CommonControls/PatientPrescription.ascx" TagName="Treatment"TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Receipt.ascx" TagName="Receipt" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/DialysisOnFlow.ascx" TagName="OnFlowDialysis" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/DialysisCaseSheet.ascx" TagName="DialysisCaseSheet" TagPrefix="uc7" %>
<%@ Register Src="../ANC/ANCCaseSheet.ascx" TagName="ANCCaseSheet" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/SecPrescriptionPage.ascx" TagName="SecPPage" TagPrefix="uc9"%>
<%@ Register src="../EMR/PrintExam.ascx" tagname="PrintExam" tagprefix="uc10" %>
<%@ Register Src="../CommonControls/AdvanceBillPrint.ascx" TagName="AdvBillPrint" TagPrefix="AdvBP" %>
<%@ Register Src="../CommonControls/Genes2MEBillPrint.ascx" TagName="Genes2me" TagPrefix="GeneBP" %>
<%@ Register src="../EMR/PrintHistory.ascx" tagname="PrintHistory" tagprefix="uc11" %>
<%@ Register Src="../CommonControls/RakshithBillPrint.ascx" TagName="RakshithBillPrint" TagPrefix="uc12" %>

<%@ Register src="../CommonControls/EsBillPrint.ascx" tagname="EsBillPrint" tagprefix="uc13" %>
  <%@ Register Src="~/CommonControls/JulianBillPrint.ascx" TagName="JulianBillPrint"
    TagPrefix="uc14" %>
      <%@ Register Src="~/CommonControls/NMC-MeerutBill.ascx" TagName="NMCMeerutBill" TagPrefix="uc15" %>
 <%@ Register Src="~/CommonControls/Medfort_BillPrint.ascx" TagName="MedfortBillPrint"
    TagPrefix="uc19" %>
     <%@ Register Src="~/CommonControls/EMROPCaseSheet.ascx" TagName="EMRCaseSheet"
    TagPrefix="uc20" %>
<%@ Register Src="~/CommonControls/QuatumBillPrint.ascx" TagName="QuantumBillPrint" TagPrefix="QuanBP" %>
<%@ Register Src="~/CommonControls/Anjanabillprint.ascx" TagName="Anjanabillprint" TagPrefix="AnjBP" %>
<%@ Register Src="~/CommonControls/Uniscanbillprint.ascx" TagName="Uniscanbillprint" TagPrefix="UnBP" %>
<%@ Register Src="~/CommonControls/IGeneticBillPrint.ascx" TagName="IGeneticBillPrint" TagPrefix="IGenBP" %>
<%@ Register Src="~/CommonControls/Infexnbillprint.ascx" TagName="Infexnbillprint" TagPrefix="InfexnBP" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Patient Visit Details</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <script src="../Scripts/Common.js" type="text/javascript"></script>
    
	<script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

	
</head>
<body id="oneColLayout" style="font-size: 12px;" onunload="ShowOPCard()"; >
    <form id="form1" runat="server" >
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server"> </asp:ScriptManager>

    <table width="100%"><tr><td align="left">
    <div id="divPrintDetails" runat="server" align="center" >
        <asp:Label ID="Rs_Pleaseselectdocumentstobeprinted" 
            Text="Please select documents to be printed" runat="server" 
            meta:resourcekey="Rs_PleaseselectdocumentstobeprintedResource1"></asp:Label>
     <table>
        <tr>
            <td id="trchkPrintPrescription" runat="server">
                <asp:CheckBox ID="chkPrintPrescription" Text="Prescription" runat="server" 
                    meta:resourcekey="chkPrintPrescriptionResource1" />
            </td>
            <td id="trchkCaseSheet" runat="server">
                <asp:CheckBox ID="chkCaseSheet" Text="CaseSheet" runat="server" 
                    meta:resourcekey="chkCaseSheetResource1" />
            </td>
            <td id="trchkBillPrint" runat="server">
            
                <asp:CheckBox ID="chkBillPrint" Text="Bill" runat="server" 
                    meta:resourcekey="chkBillPrintResource1" />
            </td>
            <td id="trchkTreatment" runat="server">
                <asp:CheckBox ID="chkTreatment" Text="Treatment" runat="server" 
                    meta:resourcekey="chkTreatmentResource1" />
            </td>
            <td id="trchkReceipt" runat="server">
                <asp:CheckBox ID="chkReceipt" Text="Receipt" runat="server" 
                    meta:resourcekey="chkReceiptResource1" />
            </td>
            <td id="trchkonFlowDialysis" runat="server">
                <asp:CheckBox ID="chkonFlowDialysis" Text="onFlowDialysis" runat="server" 
                    meta:resourcekey="chkonFlowDialysisResource1" />
            </td>
            <td id="trchkDialysisCaseSheet" runat="server">
                <asp:CheckBox ID="chkDialysisCaseSheet" Text="DialysisCaseSheet" runat="server" 
                    meta:resourcekey="chkDialysisCaseSheetResource1" />
            </td>
            <td id="trchkSecPage" runat="server">
                <asp:CheckBox ID="chkSecPage" Text="Secured Prescription Page" runat="server" 
                    meta:resourcekey="chkSecPageResource1" />
            </td>
            <td id="trchkHealthPKG" runat="server">
                <asp:CheckBox ID="chkHealthPKG" Text="Select Health Package" runat="server" 
                    meta:resourcekey="chkHealthPKGResource1" />
            </td>
        </tr>
     </table>
    <br />
    
    <asp:Button ID="btnFilter" Text="Print" runat="server" CssClass="btn" 
            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"  
            onclick="btnFilter_Click" meta:resourcekey="btnFilterResource1" 
            />
    </div>
    
    <table border="0" id="maintable" runat="server" style="display:none;" cellpadding="0" cellspacing="0" width="100%" > 
        
        <tr>
            <td >
                 <uc1:PrintPrescription ID="PrintPrescription" runat="server" /> 
            </td>
        </tr>
        <tr>    
            <td > 
             <div id="divOPCaseSheet" runat="server" ><p class='pagestart'></p></div>
                <uc2:OPCaseSheet ID="OPCaseSheet" runat="server" /> 
                <uc20:EMRCaseSheet ID ="EMRCaseSheet" runat ="server" />
                <uc8:ANCCaseSheet ID="ancCaseSheet" runat="server" />
            </td>
        </tr>  
        <tr> <td >   
        <div id="divBillPrint" runat="server" ><p class='pagestart'></p></div>
               <uc3:BillPrint ID="BillPrint" runat="server" /> 
               <uc27:SRSBillPrint ID="SRSBillPrint" runat="server" /> 
               <uc12:RakshithBillPrint ID="rakshithbillPrint" runat="server"/>   
               <uc13:EsBillPrint ID="EsBillPrint1" runat="server" />
               <uc19:MedfortBillPrint ID="medfortBillPrint" runat="server" />
               <uc14:julianbillprint id="JulianBillPrint" runat="server" />
               <uc15:NMCMeerutBill id="NMCMeerutBill" runat="server" />
               <AdvBP:AdvBillPrint ID="advBillPrint" runat="server" />
               <GeneBP:Genes2me ID="Genes2meBillPrint" runat="server" />
               <QuanBP:QuantumBillPrint ID="QuantumBillPrint" runat="server" />
               <AnjBP:Anjanabillprint ID="Anjanabillprint" runat="server" />
			    <IGenBP:IGeneticBillPrint ID="IGeneticBillPrint" runat="server" />
			    <InfexnBP:Infexnbillprint ID="Infexnbillprint" runat="server" />
			     <UnBP:Uniscanbillprint ID="Uniscanbillprint" runat="server" />
            </td></tr>                      
        <tr>
            <td >
            <div id="divSecPage" runat="server" ><p class='pagestart'></p></div>
              <uc9:SecPPage ID="ucSecPPage" runat="server" />
            </td>
        </tr>
        <tr>
             <td > 
             <div id="divTreatment" runat="server" ><p class='pagestart'></p></div>
                 <uc4:Treatment ID="Treatment" runat="server" />  
            </td>
        </tr>
        <tr>
            <td > 
             <div id="divReceipt" runat="server" ><p class='pagestart'></p></div>
                <uc5:Receipt ID="Receipt" runat="server" /> 
                </td>
        </tr>
        <tr>
            <td >
                         <div id="divonFlowDialysis" runat="server" ><p class='pagestart'></p></div>
                <uc6:OnFlowDialysis ID="onFlowDialysis" runat="server" />
                </td>
        </tr>
        <tr>
           <td>  
             <div id="divDialysisCaseSheet" runat="server" ><p class='pagestart'></p></div>
               <uc7:DialysisCaseSheet ID="DialysisCaseSheet" runat="server" /> 
               </td>
        </tr>
        <tr>
        <td>
          <div id="divHealthPKG" runat="server" ><p class='pagestart'></p></div>
         <uc11:PrintHistory ID="PrintHistory1" runat="server" Visible="False"/>
                                        <uc10:PrintExam ID="PrintExam1" runat="server" 
                Visible="False"/>
                                        <asp:GridView ID="grdResult" Width="87%" 
                runat="server" CellPadding="4" AutoGenerateColumns="False"
                                            ForeColor="#333333" CssClass="mytable1" 
                Visible="False" meta:resourcekey="grdResultResource1">
                                            <HeaderStyle CssClass="dataheader1" />
                                            <Columns>
                                                <asp:TemplateField ItemStyle-Width="2%" HeaderText="SNO" 
                                                    HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_SequenceNO" runat="server" Text='<%# Eval("SequenceNO") %>' 
                                                            Font-Size="Small" meta:resourcekey="lbl_SequenceNOResource1"></asp:Label>
                                                    </ItemTemplate>

<HeaderStyle HorizontalAlign="Left"></HeaderStyle>

<ItemStyle Width="2%"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Recommendation" 
                                                    meta:resourcekey="TemplateFieldResource2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_details" runat="server" Text='<%# Eval("ResultValues") %>' 
                                                            Font-Size="Small" meta:resourcekey="lbl_detailsResource1"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>        
        </td>
        </tr>
    </table>                        
    </td></tr></table>
    
    <asp:HiddenField ID ="hdnemr" runat ="server" />
   <script type="text/javascript" >
   
       function PrintPage() {
           try {
               if ('<%= isQuickPrint() %>' == "Y") {
                   window.opener.ItemscloseData();

               }
               document.getElementById("divPrintDetails").style.display = 'none';
               window.print(); // window.close();

           }
           catch (e) {
               document.getElementById("divPrintDetails").style.display = 'none';
               window.print(); // window.close();

           }
       }
       function ShowOPCard() {

           if ('<%= isQuickPrint() %>' == "Y") {
               window.opener.PrintOPCard();

           }

       }
       PrintPage();
   </script>
   <asp:HiddenField ID="hdnMessages" runat="server" />
</form>
</body>
</html>


