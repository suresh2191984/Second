<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewPrintPage.aspx.cs" Inherits="Reception_ViewPrintPage"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/PrintPrescription.ascx" TagName="PrintPrescription"
    TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OPCaseSheet.ascx" TagName="OPCaseSheet" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/BillPrint.ascx" TagName="BillPrint" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/PatientPrescription.ascx" TagName="Treatment"
    TagPrefix="uc4" %>
<%@ Register Src="~/CommonControls/Receipt.ascx" TagName="Receipt" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/DialysisOnFlow.ascx" TagName="OnFlowDialysis"
    TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/DialysisCaseSheet.ascx" TagName="DialysisCaseSheet"
    TagPrefix="uc7" %>
<%@ Register Src="../ANC/ANCCaseSheet.ascx" TagName="ancCaseSheet" TagPrefix="uc13" %>
<%@ Register Src="~/CommonControls/SecPrescriptionPage.ascx" TagName="SecPPage" TagPrefix="uc14" %>
<%@ Register Src="~/CommonControls/RakshithBillPrint.ascx" TagName="RakshithBillPrint"
    TagPrefix="uc15" %>
<%@ Register Src="~/CommonControls/JulianBillPrint.ascx" TagName="JulianBillPrint"
    TagPrefix="uc17" %>
<%@ Register Src="~/CommonControls/NMC-MeerutBill.ascx" TagName="NMCMeerutBill" TagPrefix="uc18" %>
<%@ Register Src="~/CommonControls/Medfort_BillPrint.ascx" TagName="MedfortBillPrint"
    TagPrefix="uc19" %>
<%@ Register Src="../CommonControls/EsBillPrint.ascx" TagName="EsBillPrint" TagPrefix="uc16" %>
<%@ Register Src="../CommonControls/EMROPCaseSheet.ascx" TagName="EMROPCasesheet"
    TagPrefix="uc17" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/AdvanceBillPrint.ascx" TagName="AdvBillPrint"
    TagPrefix="AdvBP" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
    <%@ Register Src="~/CommonControls/QuatumBillPrint.ascx" TagName="QuantumBillPrint" TagPrefix="QuanBP" %>
    <%@ Register Src="../CommonControls/Anjanabillprint.ascx" TagName="Anjanabillprint" TagPrefix="AnjBP" %>
     <%@ Register Src="../CommonControls/Uniscanbillprint.ascx" TagName="Uniscanbillprint" TagPrefix="UnBP" %>
	<%@ Register Src="../CommonControls/IGeneticBillPrint.ascx" TagName="IGeneticBillPrint"
    TagPrefix="IGen" %>
    <%@ Register Src="~/CommonControls/Infexnbillprint.ascx" TagName="Infexnbillprint" TagPrefix="InfexnBP" %>
    <%@ Register Src="../CommonControls/Genes2MEBillPrint.ascx" TagName="Genes2me" TagPrefix="GeneBP" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Patient Visit Details</title>
    <style type="text/css">
        .classNav
        {
            visibility: hidden !important;
            height: 0px !important;
            display: none !important;
        }
        body:nth-of-type(1) img[src*="Blank.gif"]
        {
            display: none;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function PrintReport() {
        
             
            var dp;
            if(document.getElementById('chkDuplicate').checked == true)
            {
                dp = "1";
            }
            else
            {
                dp = "0";
            }
            
            var chkheader;
            if(document.getElementById('chkheader').checked == true)
            {
                chkheader = 'Y';
            }
            else
            {
                chkheader = 'N';
            }
            
            var lstSplit=document.getElementById('chkSplit').checked==true?"Y":"N";           
            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800,left=0,top=0";
            //var strURL = "../Reception/PrintPage.aspx?vid=<%=Request.QueryString["vid"] %>&pagetype=<%=Request.QueryString["pagetype"] %>&pid=<%=Request.QueryString["pid"] %>&bid=<%=Request.QueryString["bid"] %>&pdp=" + dp;
            var strURL = "../Reception/ViewPrintPage.aspx?vid=<%=Request.QueryString["vid"] %>&pagetype=<%=Request.QueryString["pagetype"] %>&IsPopup=Y&CCPage=Y&pid=<%=Request.QueryString["pid"] %>&bid=<%=Request.QueryString["bid"] %>&pdp=" + dp+"&chkheader="+chkheader+"&Split="+lstSplit + "&ViewSplitCheckbox=Y";
            var WinPrint = window.open(strURL, "", strFeatures, true);
            WinPrint.print();
            //if($('#hdndummybill').val()=="Y" && $('#IGeneticBillPrint_hdnClientDuplicate').val()=='MRPBill' )
			if( $('#IGeneticBillPrint_hdnClientDuplicate').val()=='MRPBill' )
            {
             var strURL1 = "../Reception/ViewPrintPage.aspx?vid=<%=Request.QueryString["vid"] %>&pagetype=<%=Request.QueryString["pagetype"] %>&IsPopup=Y&CCPage=Y&pid=<%=Request.QueryString["pid"] %>&bid=<%=Request.QueryString["bid"] %>&pdp=" + dp+"&chkheader="+chkheader+"&Split="+lstSplit + "&ViewSplitCheckbox=Y" + "&DuplicateBill=Y";
             var WinPrint1 = window.open(strURL1, "", strFeatures, true);
             WinPrint1.print();
            }
            return false;
            }
     function fullBillPrintReport() {
    
         
        var dp;
        if(document.getElementById('chkDuplicate').checked == true)
        {
            dp = "1";
        }
        else
        {
            dp = "0";
        }
        
        var chkheader;
        if(document.getElementById('chkheader').checked == true)
        {
            chkheader = 'Y';
        }
        else
        {
            chkheader = 'N';
        }
        
        var lstSplit=document.getElementById('chkSplit').checked==true?"Y":"N";           
        var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
        strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800,left=0,top=0";
        //var strURL = "../Reception/PrintPage.aspx?vid=<%=Request.QueryString["vid"] %>&pagetype=<%=Request.QueryString["pagetype"] %>&pid=<%=Request.QueryString["pid"] %>&bid=<%=Request.QueryString["bid"] %>&pdp=" + dp;
        var strURL = "../Reception/ViewPrintPage.aspx?vid=<%=Request.QueryString["vid"] %>&pagetype=<%=Request.QueryString["pagetype"] %>&IsPopup=Y&CCPage=Y&pid=<%=Request.QueryString["pid"] %>&bid=<%=Request.QueryString["bid"] %>&pdp=" + dp+"&chkheader="+chkheader+"&Split="+lstSplit + "&ViewSplitCheckbox=Y&isFB=Y&isDbill=Y";
        var WinPrint = window.open(strURL, "", strFeatures, true);
        WinPrint.print();
        return false;
    }
        function fnCallPrint() { 

            var prtContent = document.getElementById("pagetdPrint"); 
            var x=document.getElementById('tblBill').rows;
            var y=x[0].cells;
            var z= y[0].innerHTML;
            prtContent.innerHTML=prtContent.innerHTML.replace(' [Duplicate Copy]','');
            var m=z +' [Duplicate Copy]';
            if(document.getElementById('chkDuplicate').checked == true)
            {
                prtContent.innerHTML=prtContent.innerHTML.replace(z,m);
            } 

            var WinPrint = window.open('', '', 'left=-1,top=-1,height=600,width=700,toolbar=0,scrollbars=yes,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            return false;

        }
        
         function PrintPage() {
          
           try {
                if ('<%= isQuickPrint() %>' == "Y") {
                   window.print(); // window.close();
                }
           }
           catch (e) {
            
               window.print(); // window.close();

           }
       }
       PrintPage();
          
       function hideHeader() {
            document.getElementById('header').style.display = 'none';
            document.getElementById('Attuneheader_menu').style.display = 'none';
            document.getElementById('imagetd').style.display = 'none';
            $("#navigation").addClass("classNav");
            document.getElementById('Attuneheader_TopHeader1_ImgBtnHome').style.display = 'none';
            //document.getElementById('txtVisitNumber').disabled = true;
            //document.getElementById('btnGo').disabled = true;
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
             <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        
                        <table class="w-100p searchPanel">
            <tr id="trPrintPrescription" runat="server" style="display: none;">
                <td>
                                    <uc1:PrintPrescription ID="PrintPrescription" runat="server" />
                                </td>
                            </tr>
            <tr id="trUserControls" runat="server" style="display: none;">
                <td>
                                    <uc2:OPCaseSheet ID="OPCaseSheet" runat="server" />
                                    <uc17:EMROPCasesheet ID="EMRCaseSheet" runat="server" />
                                    <div id="divANCCS">
                                        <uc13:ancCaseSheet ID="ancCaseSheet" runat="server" />
                                    </div>
                                </td>
                            </tr>
                            <tr id="trpnlBillPrint" runat="server">
                                <td>
                                    <asp:Panel ID="pnlBillPrint" runat="server">
                                    </asp:Panel>
                                    <%-- <uc3:BillPrint ID="BillPrint" runat="server" Visible="False" />
                                    <uc16:EsBillPrint ID="EsBillPrint1" runat="server" />
                                    <uc15:RakshithBillPrint ID="rakshithbillPrint" runat="server" />
                                    <uc19:MedfortBillPrint ID="medfortBillPrint" runat="server" />
                                    <uc17:JulianBillPrint ID="JulianBillPrint" runat="server" />
                                    <uc18:NMCMeerutBill id="NMCMeerutBill" runat="server" />--%>
                                </td>
            </tr>
            <tr id="trucSecPPage" runat="server" style="display: none;">
                <td>
                    <uc14:SecPPage ID="ucSecPPage" runat="server" />
                </td>
            </tr>
            <tr id="trTreatment" runat="server" style="display: none;">
                <td>
                    <uc4:Treatment ID="Treatment" runat="server" />
                </td>
            </tr>
            <tr id="trReceipt" runat="server" style="display: none;">
                <td>
                    <uc5:Receipt ID="Receipt" runat="server" />
                </td>
            </tr>
            <tr id="tronFlowDialysis" runat="server" style="display: none;">
                <td>
                    <uc6:OnFlowDialysis ID="onFlowDialysis" runat="server" />
                </td>
            </tr>
            <tr id="trDialysisCaseSheet" runat="server" style="display: none;">
                <td>
                    <uc7:DialysisCaseSheet ID="DialysisCaseSheet" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="display: none; width:100%;"  runat="server" id="pagetdPrint" enableviewstate="false">
                </td>
            </tr>
                            <tr>
                                <td class="a-center">
                                    <asp:CheckBox ID="chkSplit" runat="server" Text="Show Fee Split" Style="display: none;"
                                        onclick="javascript:return ViewSplit();" />
                                    <asp:CheckBox ID="chkDuplicate" runat="server" Text="Duplicate Copy" meta:resourcekey="chkDuplicateResource1" />
                                    <asp:Button ID="btnPrintFullBill" Text="Print Complete Bill" OnClientClick="return fullBillPrintReport()"
                                        Width="10%" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" meta:resourcekey="btnPrintFullBillResource1" />
                                    <asp:Button ID="btnPrint" Text="Print" OnClientClick="return PrintReport()" Width="5%"
                                        runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                        meta:resourcekey="btnPrintResource1" />
                                    <asp:Button ID="btnDynamicPrint" Visible="false" runat="server" Text="Print" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" OnClientClick="return fnCallPrint();"
                                        onmouseout="this.className='btn'" />
                                    <asp:Button ID="btnHome" Text="Home" Width="5%" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnHome_Click" meta:resourcekey="btnHomeResource1" />
                                    <asp:Button ID="btnBack" Text="Back" Width="5%" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnBack_Click1" meta:resourcekey="btnBackResource1" />
                                    <asp:Button ID="btnPrintBarcode" Text="Print Barcode" runat="server" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnPrintBarcode_Click"
                                        Style="display: none;" />
                                    <asp:CheckBox ID="chkheader" runat="server" Text="With Header" Style="display: none;" />
                                    <asp:HiddenField ID="hdnPopup" runat="server" Value="0" />
                                </td>
                            </tr>
                        </table>
                    </div>
         <Attune:Attunefooter ID="Attunefooter" runat="server" />       
       
        <asp:HiddenField ID="hdnMessages" runat="server" />
        <asp:HiddenField ID="hdndummybill" runat="server" />
    </div>
    </form>

    <script type="text/javascript" language="javascript">
        if (document.getElementById('hdnPopup').value == "1") {
            if (document.getElementById('menu') != null) {
                document.getElementById('menu').style.display = "none";
            }
        }
        var SplitView = '<%= Request.QueryString["Split"] %>';

        if (SplitView == 'Y') {
            document.getElementById('chkSplit').checked = true;
           // ViewColumn(SplitView, true);
        }
        else {
           // ViewColumn(SplitView, false);
        }


        function ViewSplit() {

            ViewColumn("N", document.getElementById('chkSplit').checked);
        }    
            
    </script>

</body>
</html>
