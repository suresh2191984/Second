<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvReportsForApproval.aspx.cs"
    Inherits="Investigation_InvReportsForApproval" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Src="NotesPattern.ascx" TagName="NotesPattern" TagPrefix="uc41" %>
<%@ Register Src="../CommonControls/ViewTRFImage.ascx" TagName="ViewTRFImage" TagPrefix="TRF" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Investigation Report</title>


    <style type="text/css">
        #searchTab
        {
            width: 99%;
        }
        .style1
        {
            height: 20px;
            width: 20%;
        }
    </style>
</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server" defaultfocus="txtVisitSampleNo">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <div id="ViewTRF" runat="server" visible="false">
                                    <TRF:ViewTRFImage ID="TRFUC" runat="server" />
                                </div>
                        <div runat="server" id="divPatientDetails" class="w-100p">
                            <table class="w-100p">
                                <tr>
                                    <td>
                                        <ucPatientdet:PatientDetails ID="PatientDetail" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </div>
        <asp:Label runat="server" ID="lblStatus" Visible="False" Text="No Matching Record Found"
            meta:resourcekey="lblStatusResource1"></asp:Label>
                        <%--<img src="../Images/collapse_blue.jpg" id="imgClick" style="display: none;" runat="server"
                            onclick="javascript:return ShowReportDiv();" title="Show Report Template" />
                            <asp:Label runat="server" ID="lblHead" Text="Show Report Template" style="display:none;"></asp:Label>--%>
                        <table>
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td class="w-5p">
                                                <img src="../Images/collapse_blue.jpg" id="imgClick" title="Show Report Template"
                                                    style="display: none;" runat="server" onclick="javascript:return ShowReportDiv();" />
                                            </td>
                                            <td class="w-95p">
                                <asp:Label runat="server" ID="lblHead" Text="Show Report Template" Style="display: none;"
                                    meta:resourcekey="lblHeadResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:LinkButton ID="lnkSummaryReport" runat="server" Text="Show Summary Report" OnClick="lnkSummaryReport_Click"
                        ForeColor="Blue" Font-Underline="True" Visible="False" meta:resourcekey="lnkSummaryReportResource1" />
                                    <asp:HiddenField ID="hdnInvId" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdnSummaryReportPath" runat="server" Value="" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="dReport" runat="server">
                                        <asp:DataList ID="grdResult" runat="server" CellPadding="4" RepeatLayout="Table"
                                            ForeColor="#333333" OnItemDataBound="grdResult_ItemDataBound" ItemStyle-VerticalAlign="Top"
                                            RepeatDirection="Horizontal" OnItemCommand="grdResult_ItemCommand" meta:resourcekey="grdResultResource1">
                                            <ItemTemplate>
                                                <table class="searchPanel w-100p">
                                                    <tr>
                                                        <td class="v-top">
                                                            <table class="colorforcontentborder w-100p">
                                                                <tr>
                                                                    <td class="Duecolor h-20">
                                                        <%=Resources.Investigation_ClientDisplay.Investigation_InvReportsForApproval_aspx_02 %>
                                                        <asp:Label runat="server" ID="lblReportID" Visible="False" Text='<%# Eval("TemplateID") %>'
                                                            meta:resourcekey="lblReportIDResource1"></asp:Label>
                                                        <asp:Label runat="server" ID="lblReportname" Visible="False" Text='<%# Eval("ReportTemplateName") %>'
                                                            meta:resourcekey="lblReportnameResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table class="colorforcontentborder w-100p">
                                                                <tr>
                                                                    <td>
                                                                        <asp:DataList ID="grdResultDate" runat="server" CellPadding="4" RepeatLayout="Table"
                                                                            ForeColor="#333333" OnItemDataBound="grdResultDate_ItemDataBound" ItemStyle-VerticalAlign="Top"
                                                                            RepeatColumns="2" RepeatDirection="Horizontal"   meta:resourcekey="grdResultDateResource1">
                                                                            <ItemTemplate>
                                                                                <table>
                                                                                    <tr>
                                                                                        <td>
                                                                            <asp:Label runat="server" Font-Bold="True" ID="Label1" Text='<%# Eval("CreatedAt") %>'
                                                                                meta:resourcekey="Label1Resource1"></asp:Label>
                                                                            <asp:Label runat="server" ID="lblDtReportID" Visible="False" Text='<%# Eval("TemplateID") %>'
                                                                                meta:resourcekey="lblDtReportIDResource1"></asp:Label>
                                                                            <asp:Label runat="server" ID="lbldtReportname" Visible="False" Text='<%# Eval("ReportTemplateName") %>'
                                                                                meta:resourcekey="lbldtReportnameResource1"></asp:Label>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td style="font-weight: normal;">
                                                                                            <asp:DataList ID="dlChildInvName" RepeatColumns="1" RepeatDirection="Vertical" RepeatLayout="Table"
                                                                                                runat="server" OnItemCommand="dlChildInvName_ItemCommand" ItemStyle-VerticalAlign="Top" CssClass="w-100p" meta:resourcekey="dlChildInvNameResource1">
                                                                                                <ItemTemplate>
                                                                                                    <table>
                                                                                                        <tr>
                                                                                                            <td>
                                                                                                                <asp:CheckBox ID="ChkBox" onclick="javascript:return ChkIfSelected(this.id);" runat="server"
                                                                                                    Checked="True" meta:resourcekey="ChkBoxResource1" />
                                                                                                            </td>
                                                                                                            <td>
                                                                                                <asp:Label runat="server" ID="lblInvname" Text='<%# Eval("InvestigationName") %>'
                                                                                                    meta:resourcekey="lblInvnameResource1"></asp:Label>
                                                                                                <asp:Label runat="server" Visible="False" ID="lblInvID" Text='<%# Eval("InvestigationID") %>'
                                                                                                    meta:resourcekey="lblInvIDResource1"></asp:Label>
                                                                                                <asp:Label runat="server" ID="lblReportID" Visible="False" Text='<%# Eval("TemplateID") %>'
                                                                                                    meta:resourcekey="lblReportIDResource2"></asp:Label>
                                                                                                <asp:Label runat="server" ID="lblReportname" Visible="False" Text='<%# Eval("ReportTemplateName") %>'
                                                                                                    meta:resourcekey="lblReportnameResource2"></asp:Label>
                                                                                                <asp:Label runat="server" ID="lblAccessionNo" Visible="False" Text='<%# Eval("AccessionNumber") %>'
                                                                                                    meta:resourcekey="lblAccessionNoResource1"></asp:Label>
                                                                                                <asp:Label runat="server" ID="lblStatus" Visible="False" Text='<%# Eval("Status") %>'
                                                                                                    meta:resourcekey="lblStatusResource2"></asp:Label>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <asp:LinkButton ID="lnkShow" ForeColor="Black" Font-Bold="true" Font-Underline="true"
                                                                                                                    runat="server" Visible="false" Text="Show" CommandName="ShowReport" meta:resourcekey="lnkShowResource1">
                                                                                                                </asp:LinkButton>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </ItemTemplate>
                                                                                            </asp:DataList>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </ItemTemplate>
                                                                        </asp:DataList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-center h-20">
                                                                        <asp:LinkButton ID="lnkShowReport" ForeColor="Black" runat="server" Text="ShowReport"
                                                            OnClientClick="javascript:return IsSelected();" CommandName="ShowReport" Font-Underline="True"
                                                            meta:resourcekey="lnkShowReportResource1"></asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="a-left w-10p h-20">
                                    <table>
                                        <tr>
                                            <td class="a-left">
                                                <asp:Button ID="btnBack" CssClass="btn" runat="server" Text="Back" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClick="btnBack_Click" meta:resourcekey="btnBackResource1" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnEdit" CssClass="btn" runat="server" Text="Change Results" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClick="btnEdit_Click" meta:resourcekey="btnEditResource1" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnHome" CssClass="btn" runat="server" Text="Home" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClick="btnHome_Click" meta:resourcekey="btnHomeResource1" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnChangeSummary" CssClass="btn" runat="server" Text="Change Summary Report"
                                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnChangeSummary_Click"
                                    Visible="False" meta:resourcekey="btnChangeSummaryResource1" />
                                            </td>
                                             <td>
                                                <asp:Button ID="btnCancel" CssClass="btn" runat="server" Text="Back" 
                                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                    Visible="true" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <asp:UpdatePanel ID="updatePanel2" runat="server">
                            <ContentTemplate>
                                <table>
                                    <tr>
                                        <td>
                            <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none"
                                meta:resourcekey="hiddenTargetControlForModalPopupResource1" />
                                            <cc1:ModalPopupExtender ID="rptMdlPopup" runat="server" PopupControlID="pnlAttrib"
                                                TargetControlID="hiddenTargetControlForModalPopup" BackgroundCssClass="modalBackground"
                                                CancelControlID="btnCnl">
                                            </cc1:ModalPopupExtender>
                                            <asp:Panel ID="pnlAttrib" BorderWidth="1px" Height="95%" Width="90%" CssClass="modalPopup dataheaderPopup"
                                runat="server" meta:resourcekey="pnlAttribResource1">
                                                <table class="w-100p" style="height: 90%">
                                                    <tr>
                                                        <td class="a-right">
                                                            <asp:Button ID="btnPrint" OnClick="btnPrint_Click" runat="server" Text="Print Report"
                                                                OnClientClick="return onPrintReport();" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" Style="display: none;" />
                                                            <asp:HiddenField ID="hdnShowReport" runat="server" Value="false" />
                                                            <asp:HiddenField ID="hdnPrintbtnInReportViewer" runat="server" />
                                                            <asp:HiddenField ID="hdnTemplateId" runat="server" />
                                                            <asp:HiddenField ID="hdnPrevPageURL" runat="server" />
                                                            <asp:Button ID="btnSendMail" runat="server" Text="Send Mail" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnSendMail_Click" Style="display: none;"
                                                meta:resourcekey="btnSendMailResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="v-top">
                                                            <rsweb:ReportViewer ID="ReportViewer" runat="server" ProcessingMode="Remote" meta:resourcekey="ReportViewerResource1">
                                                                <ServerReport ReportServerUrl="" />
                                                            </rsweb:ReportViewer>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table class="w-100" style="height: 10%">
                                                <tr>
                                                        <td class="a-center">
                                                            <asp:Button ID="btnCnl" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClientClick="PopupClose();return false;"
                                                meta:resourcekey="btnCnlResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                            <ContentTemplate>
                                <table>
                                    <tr>
                                        <td>
                            <asp:Button ID="hiddenTargetControlForModalPopup2" runat="server" Style="display: none"
                                meta:resourcekey="hiddenTargetControlForModalPopup2Resource1" />
                                            <cc1:ModalPopupExtender ID="rptMdlPopup2" runat="server" PopupControlID="pnlAttrib2"
                                                TargetControlID="hiddenTargetControlForModalPopup2" BackgroundCssClass="modalBackground"
                                                CancelControlID="btnCnl2">
                                            </cc1:ModalPopupExtender>
                                            <asp:Panel ID="pnlAttrib2" BorderWidth="1px" Height="95%" CssClass="modalPopup dataheaderPopup w-80p"
                                runat="server" Style="background-color: White;" meta:resourcekey="pnlAttrib2Resource1">
                                                <table style="height: 100%" class="w-100p">
                                                    <tr>
                                                        <td class="a-center">
                                            <button  id="btnClientAttributes"  class="btn" onclick="return popupprint();" ><%=Resources.Investigation_ClientDisplay.Investigation_InvReportsForApproval_aspx_01%></button>
                                                            <asp:Button ID="btnCnl2" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="btnCnl2Resource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="v-top">
                                                            <div style="overflow: auto; height: 480px;" class="w-100p">
                                                                <div id="printANCCS">
                                                                    <uc41:NotesPattern ID="FckEdit1" runat="server" />
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <input type="hidden" id="ChkID" runat="server" />
                    </div>
         <Attune:Attunefooter ID="Attunefooter" runat="server" />       
    </form>
    
    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

<%--    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>--%>

    <script type="text/javascript">

        function setInputEnableState(reportViewer) {

            // It is ok to export if the viewer is not loading and is displaying a report.
            var disableInputs = reportViewer.get_isLoading() ||
                                reportViewer.get_reportAreaContentType() !== Microsoft.Reporting.WebFormsClient.ReportAreaContent.ReportPage;


            $get("PrintButton").disabled = disableInputs;
        }

        function onReportViewerLoadingChanged(sender, e) {

            var propertyName = e.get_propertyName();

            if (propertyName === "isLoading" || propertyName === "reportAreaContentType") {
                setInputEnableState(sender);
            }
        }

        function onPrintButtonClicked() {
            var reportViewer = $find("rReportViewer");
            reportViewer.invokePrintDialog();
        }
        var hookedPropertyChangedEvent = false;

        function ReportLoad() {
            //            if (!hookedPropertyChangedEvent) {

            //                var reportViewer = $find("rReportViewer");
            //                reportViewer.add_propertyChanged(onReportViewerLoadingChanged);

            //                // Make sure the input controls are in the correct state initially
            //                setInputEnableState(reportViewer);

            //                // pageLoad is called after each asynchronous postback.  Only
            //                // hook the property changed event once.
            //                hookedPropertyChangedEvent = true;
            //            }
        }
    </script>

    <script language="javascript" type="text/javascript">
        function validateVisitSampleNo() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vVisitNo = SListForAppMsg.Get('Investigation_InvReportsForApproval_aspx_02') == null ? "Provide visit number" : SListForAppMsg.Get('Investigation_InvReportsForApproval_aspx_02');
           
            if (document.getElementById('txtVisitSampleNo').value == '') {
                //alert('Provide visit number');
                ValidationWindow(vVisitNo, AlertType);
                document.getElementById('txtVisitSampleNo').focus();
                return false;
            }
            return true;
        }
        function ShowReportDiv() {

            //alert(document.getElementById('dReport'));
            document.getElementById('dReport').style.display = 'block';
            return false;
        }
        function HideDiv() {
            document.getElementById('dReport').style.display = 'none';
            document.getElementById('imgClick').style.display = 'block';
            document.getElementById('lblHead').style.display = 'block';
            return true;
        }

        function ChkIfSelected(obj) {
            // alert(obj);
            if (document.getElementById(obj).checked) {
                document.getElementById('ChkID').value = obj + '^';
            }
            else {
                //alert('else');
                var x = document.getElementById('ChkID').value.split('^');
                document.getElementById('ChkID').value = '';
                for (i = 0; i < x.length; i++) {
                    if (x[i] != '') {
                        if (x[i] != obj) {
                            document.getElementById('ChkID').value = x[i] + '^';
                        }
                    }

                }
            }
        }
        function IsSelected() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vInv = SListForAppMsg.Get('Investigation_InvReportsForApproval_aspx_02') == null ? "Select an investigation to display  report" : SListForAppMsg.Get('Investigation_InvReportsForApproval_aspx_02');
            
            if (document.getElementById('ChkID').value != '') {
                HideDiv();
                return true;
            }
            else {
                //alert('Select an investigation to display  report');
                ValidationWindow(vInv, AlertType);
            }
            return false;
        }
        function launchSessionUrl(launchurl) {
            //alert('hello : ' + launchurl);
            window.location.href = launchurl;

        }


        function popupprint() {
            var prtContent = document.getElementById('printANCCS');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,width=1024,height=768');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            //        WinPrint.close();

        }

        function onPrintReport() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vUnable = SListForAppMsg.Get('Investigation_InvReportsForApproval_aspx_03') == null ? "Unable to print report" : SListForAppMsg.Get('Investigation_InvReportsForApproval_aspx_03');
            
            var reportViewer = $find("ReportViewer");
            var disablePrint = reportViewer.get_isLoading() ||
                                reportViewer.get_reportAreaContentType() !== Microsoft.Reporting.WebFormsClient.ReportAreaContent.ReportPage;
            if (!disablePrint) {
                reportViewer.invokePrintDialog();
                return true;

            }
            else {
                //alert("Unable to print report");
                ValidationWindow(vUnable, AlertType);
            } 
            return false;
        }
        function PopupClose() {
            document.getElementById('hdnShowReport').value = 'false';
        }
        

    </script>
</body>
</html>
