<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationApprovelOrHoldNew.aspx.cs"
    Inherits="Investigation_InvestigationApprovelOrHoldNew" EnableEventValidation="false"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Src="MicroPattern.ascx" TagName="MicroPattern" TagPrefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Src="BioPattern1.ascx" TagName="BioPattern1" TagPrefix="uc11" %>
<%@ Register Src="ClinicalPattern12.ascx" TagName="ClinicalPattern12" TagPrefix="uc17" %>
<%@ Register Src="ClinicalPattern13.ascx" TagName="ClinicalPattern13" TagPrefix="uc18" %>
<%@ Register Src="FluidPattern.ascx" TagName="FluidPattern" TagPrefix="uc23" %>
<%@ Register Src="BioPattern5.ascx" TagName="BioPattern5" TagPrefix="uc10" %>
<%@ Register Src="CommanPattern.ascx" TagName="CommanPattern" TagPrefix="uc24" %>
<%@ Register Src="HistoPathologyPattern.ascx" TagName="HistoPathologyPattern" TagPrefix="uc26" %>
<%@ Register Src="BioPattern2.ascx" TagName="BioPattern2" TagPrefix="uc6" %>
<%@ Register Src="BioPattern3.ascx" TagName="BioPattern3" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/SampleCollection.ascx" TagName="SampleCctrl"
    TagPrefix="uc25" %>
<%@ Register Src="BioPattern4.ascx" TagName="BioPattern4" TagPrefix="uc9" %>
<%@ Register Src="CultureandSensitivityReport.ascx" TagName="CultureandSensitivityReport"
    TagPrefix="uc27" %>
<%@ Register Src="CultureandSensitivityReportV1.ascx" TagName="CultureandSensitivityReportV1"
    TagPrefix="uc48" %>
<%@ Register Src="CultureandSensitivityReportV2.ascx" TagName="CultureandSensitivityReportV2"
    TagPrefix="uc50" %>
<%@ Register Src="StoneAnalysis.ascx" TagName="StoneAnalysis" TagPrefix="uc28" %>
<%@ Register Src="FluidAnalysisCellsPattern.ascx" TagName="FluidAnalysisCellsPattern"
    TagPrefix="uc29" %>
<%@ Register Src="FluidAnalysisChemistryPattern.ascx" TagName="FluidAnalysisChemistryPattern"
    TagPrefix="uc30" %>
<%@ Register Src="FluidAnalysisCytologyPattern.ascx" TagName="FluidAnalysisCytologyPattern"
    TagPrefix="uc31" %>
<%@ Register Src="FluidAnalysisImmunolgyPattern.ascx" TagName="FluidAnalysisImmunolgyPattern"
    TagPrefix="uc32" %>
<%@ Register Src="FungalSmearPattern.ascx" TagName="FungalSmearPattern" TagPrefix="uc33" %>
<%@ Register Src="MicroBioPattern1.ascx" TagName="MicroBioPattern1" TagPrefix="uc34" %>
<%@ Register Src="AntibodyWithMethod.ascx" TagName="AntibodyWithMethod" TagPrefix="uc29" %>
<%@ Register Src="AntibodyQualitative.ascx" TagName="AntibodyQualitative" TagPrefix="uc35" %>
<%@ Register Src="SemenAnalysis.ascx" TagName="SemenAnalysis" TagPrefix="uc36" %>
<%@ Register Src="Imaging.ascx" TagName="Imaging" TagPrefix="uc37" %>
<%@ Register Src="PeripheralSmear.ascx" TagName="PeripheralSmear" TagPrefix="uc38" %>
<%@ Register Src="BleedingTime.ascx" TagName="BleedingTime" TagPrefix="uc39" %>
<%@ Register Src="ImagingWithFCKEditor.ascx" TagName="ImagingWithFCKEditor" TagPrefix="uc40" %>
<%@ Register Src="TextualPattern.ascx" TagName="TextualPattern" TagPrefix="uc41" %>
<%@ Register Src="GTT.ascx" TagName="GTT" TagPrefix="uc42" %>
<%@ Register Src="BodyFluidAnalysis.ascx" TagName="BodyFluidAnalysis" TagPrefix="uc43" %>
<%@ Register Src="SmearAnalysis.ascx" TagName="SmearAnalysis" TagPrefix="uc44" %>
<%@ Register Src="SemenAnalysisNewPattern.ascx" TagName="SemenAnalysisNewPattern"
    TagPrefix="uc45" %>
<%@ Register Src="GTTContentPattern.ascx" TagName="GTTContentPattern" TagPrefix="uc49" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<%--<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/MethodKitMapping.ascx" TagName="MethodKitCapture"
    TagPrefix="uc86" %>
<%@ Register Src="../CommonControls/ViewTRFImage.ascx" TagName="ViewTRFImage" TagPrefix="TRF" %>
<%@ Register Src="ImageUploadpattern.ascx" TagName="ImagePattern" TagPrefix="ImageUpload" %>
<%@ Register Src="FishPattern1.ascx" TagName="FishPattern" TagPrefix="FishPatternforGenetics" %>
<%@ Register Src="FishPattern2.ascx" TagName="FishPattern2" TagPrefix="FishPattern2" %>
<%@ Register Src="FishResultPattern.ascx" TagName="FishResult" TagPrefix="FishResultPattern1" %>
<%@ Register Src="FishResultPattern1.ascx" TagName="FishResult1" TagPrefix="FishResultPattern2" %>
<%@ Register Src="MultiAddControl.ascx" TagName="MultiAdd" TagPrefix="MultiAddControl" %>
<%@ Register Src="HBVDRUG.ascx" TagName="MultiAdd" TagPrefix="MolBioPattern" %>
<%@ Register Src="BRCAPattern.ascx" TagName="BRCA" TagPrefix="BRCAPattern" %>
<%@ Register Src="BRCAPattern1.ascx" TagName="BRCA1" TagPrefix="BRCAPattern1" %>
<%@ Register Src="OrganismDrugPattern.ascx" TagName="OrganismDrug" TagPrefix="OrganismDrugPattern" %>
<%--/* BEGIN | sabari | 20181129 | Dev | Culture Report */--%>
<%@ Register Src="OrganismDrugPatternWithLevel.ascx" TagName="OrganismDrugWithLevel" TagPrefix="OrganismDrugPatternWithLevel" %>
<%--/* END | sabari | 20181129 | Dev | Culture Report */--%>
<%@ Register Src="MicroStainPattern.ascx" TagName="MicroStain" TagPrefix="MicroStainPattern" %>
<%@ Register Src="MicroBio1.ascx" TagName="MicroBio1" TagPrefix="MicroBioPattern" %>
<%@ Register Src="HEMATOLOGY.ascx" TagName="HEMATOLOGY" TagPrefix="HEMATOLOGYPattern" %>
<%@ Register Src="~/Investigation/ReflexTest.ascx" TagName="ReflexTest" TagPrefix="Reflex" %>
<%@ Register Src="~/Investigation/SynopticTest.ascx" TagName="SynopticTest" TagPrefix="Synoptic" %>
<%@ Register Src="GeneralPattern.ascx" TagName="HPV" TagPrefix="GeneralPattern" %>
<%@ Register Src="Tablepatternautopopulate.ascx" TagName="Genera" TagPrefix="Tablepatternautopopulate" %>
<%@ Register Src="RichTextPattern.ascx" TagName="TextPattern" TagPrefix="RichTextPattern" %>
<%@ Register Src="PDFUploadpattern.ascx" TagName="PDFUPLOAD" TagPrefix="PDFUploadpattern" %>
<%@ Register Src="HistoImageDescriptionPattern.ascx" TagName="HistoDescription" TagPrefix="HistoImageDescriptionPattern" %>
<%@ Register Src="MultipleFileUpload.ascx" TagName="Multiple" TagPrefix="FUpload" %>
<%@ Register Src="ImageDescriptionpattern.ascx" TagName="ImageDescription" TagPrefix="ImageDescriptionpattern" %>
<%@ Register Src="HistoPathologyPatternQuantum.ascx" TagName="HistoPathologyPatternQuantum"
    TagPrefix="uc53" %>
<%@ Register Src="TablePatternV2.ascx" TagName="TableV2" TagPrefix="TablePatternV2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Investigation Capture</title>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery.min.js"></script>

    <script type="text/javascript" src="../Scripts/jquery-ui.min.js"></script>

    <script src="../Scripts/JsonScript.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <style type="text/css">
        #GrdInv .tdgridHeader
        {
            background: #446d87 none repeat scroll 0 0;
            border-bottom: 1px dotted #0f92c8;
            color: #fff;
            font-family: OpenSansSemibold;
            font-size: 14px;
            font-weight: normal;
            padding: 5px;
        }
        #pnlReportPreview
        {
            top: 7% !important;
        }
        #ViewTRF td
        {
            padding: 0;
        }
        .displaynonecls
        {
            display: none;
        }
    </style>
</head>
<body id="Body1" oncontextmenu="return true;" runat="server" onkeydown="SuppressBrowserBackspaceRefresh();">
    <form id="form1" runat="server" enctype="multipart/form-data">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="progressbarSave" style="display: none;" runat="server">
            <div id="progressBackgroundFilter" class="a-center">
            </div>
            <div id="processMessage" class="a-center w-20p">
                <asp:Image ID="SavePleasewait" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                    meta:resourcekey="img1Resource1" />
            </div>
        </div>
        <div id="ViewTRF" runat="server" style="display: block">
            <TRF:ViewTRFImage ID="TRFUC" runat="server" />
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Panel ID="pnlSerch" runat="server" BorderWidth="1px" CssClass="dataheader2 searchPanel w-60p"
                    Style="display: block;" meta:resourcekey="pnlSerchResource1">
                    <input id="hdnVID" runat="server" type="hidden" value="0"> </input>
                    <input id="hdnHeaderName" runat="server" type="hidden" value="0"></input>
                    <input id="hdnDept" runat="server" type="hidden" value="0"></input>
                    <table id="searchTab" runat="server" cellpadding="4" class="w-100p">
                        <tr runat="server">
                            <td runat="server" class="a-left h-20 w-40p" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblSearch" runat="server" Text="Enter Visit No to search"></asp:Label>
                            </td>
                            <td runat="server" class="a-left w-40p h-20" style="font-weight: normal; color: #000;">
                                <asp:TextBox ID="txtSearchTxt" runat="server" CssClass="small"></asp:TextBox>
                                <ajc:FilteredTextBoxExtender ID="txtSearch" runat="server" Enabled="True" FilterType="Numbers"
                                    TargetControlID="txtSearchTxt">
                                </ajc:FilteredTextBoxExtender>
                            </td>
                            <td runat="server" class="a-left w-20p">
                            </td>
                            <td runat="server" class="w-60p">
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <div id="divPatientDetails" runat="server">
                    <ucPatientdet:PatientDetails ID="PatientDetail" runat="server" />
                </div>
                <div id="testNameDIV" runat="server" style="border-width: 1px; border-color: #000;
                    display: none; position: fixed; z-index: 2; top: 200px; left: 200px;">
                    <table cellpadding="3" class="divtablePop">
                        <tr class="h-20 evenforsurg">
                            <td>
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_03 %>
                                        </td>
                                        <td class="a-right">
                                            <img id="imgbtn1" onclick="javascript:setTestNameClose();" src="../Images/Delete.jpg"
                                                style="cursor: pointer;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="testNameLBL" runat="server" ForeColor="#ffffff"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="testNameTXT" runat="server" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-center">
                                <input id="testNameHDN" runat="server" type="hidden" />
                                <input id="Hidden3" runat="server" type="hidden" />
                                <input id="Hidden4" runat="server" type="hidden" />
                                <input id="testNameHDN1" runat="server" type="hidden" />
                                <asp:Label ID="Label1" runat="server" Font-Bold="true" ForeColor="#ffffff" OnClick="javascript:setTestName();"
                                    Style="cursor: pointer;"><%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_04 %></asp:Label>
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label17" runat="server" Font-Bold="true" ForeColor="#ffffff" OnClick="javascript:setTestNameClose();"
                                    Style="cursor: pointer;"><%=Resources.Investigation_ClientDisplay.Investigation_InvestigationResultsCapture_aspx_05 %></asp:Label>
                                <%--  <asp:Button ID="testNameBTNOk" OnClientClick="" runat="server" UseSubmitBehavior="false" CssClass="btn" Text="Change" onmouseout="this.className='btn'" 
                                                        onmouseover="this.className='btn btnhov'" />
                                    <asp:Button ID="testNameBTNCancel" runat="server" UseSubmitBehavior="false" CssClass="btn" Text="Cancel" onmouseout="this.className='btn'" 
                                                        onmouseover="this.className='btn btnhov'" />--%>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divMultiFile">
                    <FUpload:Multiple ID="MultiFile" runat="server" />
                </div>
                <table class="w-95p" style="display: none;" runat="server" id="CheakInv">
                    <tr>
                        <td class="h-23 a-left">
                            <asp:HiddenField ID="HdnInvID" runat="server" />
                            <div id="ACX2plus21" style="display: block;">
                                <img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',2);" />
                                <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',2);">
                                    <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_03 %></span>
                            </div>
                            <div id="ACX2minus21" style="display: none;">
                                <img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',0);" />
                                <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',0);">
                                    &nbsp;<%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_03 %></span>
                            </div>
                        </td>
                    </tr>
                    <tr class="tablerow" id="ACX2responses211" style="display: none;">
                        <td colspan="2">
                            <div class="dataheader2">
                                <asp:UpdatePanel ID="UpdPnl1" runat="server">
                                    <ContentTemplate>
                                        <asp:DataList ID="GrdInv" runat="server" GridLines="Horizontal" RepeatColumns="1"
                                            CssClass="w-50p gridView" HeaderStyle-CssClass="tdgridHeader" OnItemDataBound="GrdInv_ItemDataBound"
                                            meta:resourcekey="GrdInvResource1">
                                            <HeaderTemplate>
                                                <%--<table class="w-100p">
                                                    <tr class="gridHeader">--%>
                                                <%-- <td>--%>
                                                <b>
                                                    <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_04 %>
                                                </b></td>
                                                <td class="tdgridHeader">
                                                    <b>
                                                        <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_05 %>
                                                    </b>
                                                </td>
                                                </tr>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <%-- <td class="w-70p">--%>
                                                <%# DataBinder.Eval(Container.DataItem, "InvestigationName")%>
                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("ReferredType")%>' meta:resourcekey="lblStatusResource1"></asp:Label>
                                                </td>
                                                <td headers="Status">
                                                    <%# DataBinder.Eval(Container.DataItem, "DisplayStatus")%>
                                                </td>
                                                <%--</tr> </table>--%>
                                            </ItemTemplate>
                                            <%--<FooterTemplate>
                                                </tr> </table>
                                            </FooterTemplate>--%>
                                        </asp:DataList>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </td>
                    </tr>
                </table>
                <table class="w-100p">
                    <tr>
                        <td>
                            <asp:LinkButton ID="linkbutton" runat="server" Text="Preview for methodKit details"
                                Font-Underline="True" Style="display: none;" meta:resourcekey="linkbuttonResource1"></asp:LinkButton>
                            <a id="linkbuttonCl" runat="server"><u>
                                <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_06 %></u></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:LinkButton ID="lnkPDFReportPreviewer" runat="server" Text="Show Report Preview"
                                Font-Underline="true" ForeColor="Blue" meta:resourcekey="lnkPDFReportPreviewerResource" />
                        </td>
                    </tr>
                    <tr>
                        <td class="a-right">
                            <asp:LinkButton ID="lnkslide" runat="server" Text="Show Slides" OnClientClick="window.open('http://115.112.32.176/DSStore/Slides.aspx');"
                                CssClass="showslides font15" meta:resourcekey="lnkslideResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center padding0" colspan="8">
                            <asp:Panel ID="pnlLocation" Width="800px" Height="400px" runat="server" CssClass="modalPopup dataheaderPopup"
                                ScrollBars="Vertical" Style="display: none" meta:resourcekey="pnlLocationResource1">
                                <table class="a-center">
                                    <tr>
                                        <td class="w-100p">
                                            <table class="w-100p">
                                                <tr>
                                                    <td class="a-left">
                                                        <asp:Label ID="lblPName" runat="server" meta:resourcekey="lblPNameResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:Label ID="lblPAge" runat="server" meta:resourcekey="lblPAgeResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:Label ID="lblSex" runat="server" meta:resourcekey="lblSexResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:Label ID="lblVisitNo" runat="server" meta:resourcekey="lblVisitNoResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table id="tblPatientTestHistory" cellpadding="4" class="dataheaderInvCtrl w-100p"
                                                style="display: none;">
                                                <tr class="dataheader1">
                                                    <td class="w-20p">
                                                        <asp:Label ID="Label2" runat="server" Text="Date" meta:resourcekey="Label2Resource1"></asp:Label>
                                                    </td>
                                                    <td class="w-30p">
                                                        <asp:Label ID="Label3" runat="server" Text="Investigation Name" meta:resourcekey="Label3Resource1"></asp:Label>
                                                    </td>
                                                    <td class="w-15p">
                                                        <asp:Label ID="Label4" runat="server" Text="Value" meta:resourcekey="Label4Resource1"></asp:Label>
                                                    </td>
                                                    <td class="w-20p">
                                                        <asp:Label ID="Label5" runat="server" Text="Reference Range" meta:resourcekey="Label5Resource1"></asp:Label>
                                                    </td>
                                                    <td class="w-20p">
                                                        <asp:Label ID="Label6" runat="server" Text="Comments" meta:resourcekey="Label6Resource1"></asp:Label>
                                                    </td>
                                                    <td class="w-15p">
                                                        <asp:Label ID="Label9" runat="server" Text="Investigation Status" meta:resourcekey="Label9Resource1"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <%--<tr>
                                            <td>
                                              <asp:GridView ID="NamesGridView" runat="server" ShowHeaderWhenEmpty="True">
                                               </asp:GridView>
                                            </td>
                                            </tr>--%>
                                    <tr>
                                        <td class="a-center">
                                            <button id="btnpopClose" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                onclick="ClearPopUp();">
                                                <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_01 %></button>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <ajc:ModalPopupExtender ID="mpeRoomType" runat="server" BackgroundCssClass="modalBackground"
                                CancelControlID="btnpopClose" DynamicServicePath="" Enabled="True" PopupControlID="pnlLocation"
                                TargetControlID="btnDummy">
                            </ajc:ModalPopupExtender>
                            <input id="btnDummy" runat="server" style="display: none;" type="button"></input>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-center" colspan="8">
                            <asp:Panel ID="pnlLocation1" Width="1000px" Height="400px" runat="server" CssClass="modalPopup dataheaderPopup"
                                ScrollBars="Vertical" Style="display: none" meta:resourcekey="pnlLocation1Resource1">
                                <table class="a-center w-90p">
                                    <tr>
                                        <td class="w-100p">
                                            <table class="w-100p">
                                                <tr>
                                                    <td class="a-left">
                                                        <asp:Label ID="lblPName1" runat="server" meta:resourcekey="lblPName1Resource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:Label ID="lblPAge1" runat="server" meta:resourcekey="lblPAge1Resource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:Label ID="lblSex1" runat="server" meta:resourcekey="lblSex1Resource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:Label ID="lblVisitNo1" runat="server" meta:resourcekey="lblVisitNo1Resource1"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="colorforcontent w-30p h-23 a-left">
                                            <div id="DeltaPlus" style="display: block; text-align: right;">
                                                <span class="dataheader1txt" style="cursor: pointer" onclick="showDeltaTableGraph('DeltaPlus','DeltaMinus','trDeltaTable',1);">
                                                    &nbsp;<asp:Label ID="lblinvfilter" runat="server" Text="Investigation Result History"
                                                        meta:resourcekey="lblinvfilterResource1"></asp:Label></span> &nbsp;<img src="../Images/Rotate360AntiClockwi2.png"
                                                            alt="Show Graph" class="w-15 h-15 v-top" style="cursor: pointer;" onclick="showDeltaTableGraph('DeltaPlus','DeltaMinus','trDeltaTable',1);" />&nbsp;
                                            </div>
                                            <div id="DeltaMinus" style="display: none; text-align: right;">
                                                <span class="dataheader1txt" style="cursor: pointer" onclick="showDeltaTableGraph('DeltaPlus','DeltaMinus','trDeltaGraph',0);">
                                                    &nbsp;<asp:Label ID="lblinvfilters" runat="server" Text="Investigation Result History"
                                                        meta:resourcekey="lblinvfiltersResource1"></asp:Label></span> &nbsp;<img src="../Images/Rotate360AntiClockwi2.png"
                                                            alt="Show Table" class="w-15 h-15 v-top" style="cursor: pointer" onclick="showDeltaTableGraph('DeltaPlus','DeltaMinus','trDeltaGraph',0);" />&nbsp;
                                            </div>
                                        </td>
                                    </tr>
                                    <tr id="trDeltaTable" runat="server" style="display: table-row;">
                                        <td>
                                            <table id="tblPatientTestHistory1" cellpadding="4" class="dataheaderInvCtrl w-100p"
                                                style="display: none;">
                                                <tr class="dataheader1">
                                                    <td class="w-10p">
                                                        <asp:Label ID="Label10" runat="server" Text="Select" meta:resourcekey="Label10Resource1"></asp:Label>
                                                    </td>
                                                    <td class="w-10p">
                                                        <asp:Label ID="Label11" runat="server" Text="Visit Number" meta:resourcekey="Label11Resource1"></asp:Label>
                                                    </td>
                                                    <td class="w-20p">
                                                        <asp:Label ID="Rs_Date" runat="server" Text="Date" meta:resourcekey="Rs_DateResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-30p">
                                                        <asp:Label ID="Rs_InvestigationName" runat="server" Text="Investigation Name" meta:resourcekey="Rs_InvestigationNameResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-15p">
                                                        <asp:Label ID="Rs_Value" runat="server" Text="Value" meta:resourcekey="Rs_ValueResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-25p">
                                                        <asp:Label ID="Rs_ReferenceRange" runat="server" Text="Reference Range" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-20p">
                                                        <asp:Label ID="Rs_Comments" runat="server" Text="Comments" meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-15p">
                                                        <asp:Label ID="Rs_Status" runat="server" Text="Investigation Status" meta:resourcekey="Rs_StatusResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-15p">
                                                        <asp:Label ID="lblKitAnalyzer" runat="server" Text="Kit/Analyzer" meta:resourcekey="lblKitAnalyzerResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trDeltaGraph" runat="server" style="display: none;">
                                        <td>
                                            <img id="ChartArea" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <button id="btnSetValues" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                            onclick="return SetValues();">
                                                            <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_02 %></button>
                                                    </td>
                                                    <td class="a-left">
                                                        <button id="btnpopClose1" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                            onclick="ClearPopUp1();">
                                                            <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_01 %></button>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                            </asp:Panel>
                            <ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modalBackground"
                                CancelControlID="btnpopClose1" DynamicServicePath="" Enabled="True" PopupControlID="pnlLocation1"
                                TargetControlID="btnDummy1">
                            </ajc:ModalPopupExtender>
                            <input id="btnDummy1" runat="server" style="display: none;" type="button"></input>
                            <asp:HiddenField runat="server" ID="hdnPatternID" />
                            <asp:HiddenField runat="server" ID="hdnPatientInvID" />
                            <asp:HiddenField runat="server" ID="hdnMappingPatternID" />
                            <asp:HiddenField runat="server" ID="hdnIsDeltaCheckWant" Value="false" />
                            <asp:HiddenField runat="server" ID="hdnPatientVisitID" />
                        </td>
                    </tr>
                </table>
                <table class="w-95p" style="display: none;" runat="server" id="tblSSRSReportPreview">
                    <tr>
                        <td class="h-23 a-left">
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                            <div id="ACX2plus211" style="display: none;">
                                <img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus211','ACX2minus211','ACX2responses2111',1);" />
                                <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus211','ACX2minus211','ACX2responses2111',1);">
                                    <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_07 %></span>
                            </div>
                            <div id="ACX2minus211" style="display: block;">
                                <img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top" style="cursor: pointer"
                                    onclick="showResponses('ACX2plus211','ACX2minus211','ACX2responses2111',0);" />
                                <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus211','ACX2minus211','ACX2responses2111',0);">
                                    &nbsp;<%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_08 %></span>
                            </div>
                        </td>
                    </tr>
                    <tr class="tablerow" id="ACX2responses2111" style="display: none;">
                        <td colspan="2">
                            <div class="dataheader2">
                                <table class="w-100p" id="tblResults" runat="server">
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
                                            <div id="dReport" runat="server">
                                                <asp:DataList ID="grdResultTemp" runat="server" CellPadding="4" RepeatLayout="Table"
                                                    ForeColor="#333333" RepeatColumns="2" OnItemDataBound="grdResultTemp_ItemDataBound"
                                                    ItemStyle-VerticalAlign="Top" RepeatDirection="Horizontal" OnItemCommand="grdResultTemp_ItemCommand">
                                                    <ItemStyle VerticalAlign="Top"></ItemStyle>
                                                    <ItemTemplate>
                                                        <table class="dataheaderInvCtrl" style="border-collapse: collapse;">
                                                            <tr>
                                                                <td class="v-top">
                                                                    <table cellpadding="5" class="colorforcontentborder w-100p" style="border-collapse: collapse;">
                                                                        <tr>
                                                                            <td class="Duecolor h-20">
                                                                                <table class="w-100p">
                                                                                    <tr>
                                                                                        <td class="a-left">
                                                                                            <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_09 %>
                                                                                        </td>
                                                                                        <td class="a-right">
                                                                                            &nbsp;<asp:CheckBox ID="chkSelectAll" runat="server" meta:resourcekey="chkSelectAllResource1" />
                                                                                            Select
                                                                                            <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_10 %><asp:Label
                                                                                                runat="server" ID="lblReportID" Visible="False" Text='<%# Eval("TemplateID") %>'
                                                                                                meta:resourcekey="lblReportIDResource1"></asp:Label>
                                                                                            <asp:Label runat="server" ID="lblReportname" Visible="False" Text='<%# Eval("ReportTemplateName") %>'
                                                                                                meta:resourcekey="lblReportnameResource1"></asp:Label>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <table cellpadding="5" class="colorforcontentborder w-100p" style="border-collapse: collapse;">
                                                                        <tr>
                                                                            <td style="font-weight: normal;">
                                                                                <asp:DataList ID="grdResultDate" runat="server" CellPadding="4" RepeatLayout="Table"
                                                                                    ForeColor="#333333" OnItemDataBound="grdResultDate_ItemDataBound" ItemStyle-VerticalAlign="Top"
                                                                                    OnItemCommand="grdResultDate_ItemCommand" RepeatColumns="2" RepeatDirection="Horizontal"
                                                                                    meta:resourcekey="grdResultDateResource1">
                                                                                    <ItemStyle VerticalAlign="Top" />
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
                                                                                                        runat="server" OnItemCommand="dlChildInvName_ItemCommand" ItemStyle-VerticalAlign="Top"
                                                                                                        CssClass="w-100p" meta:resourcekey="dlChildInvNameResource1">
                                                                                                        <ItemStyle VerticalAlign="Top" />
                                                                                                        <ItemTemplate>
                                                                                                            <table>
                                                                                                                <tr>
                                                                                                                    <td>
                                                                                                                        <asp:CheckBox ID="ChkBox" onclick="javascript:return ChkIfSelected(this.id);" runat="server"
                                                                                                                            meta:resourcekey="ChkBoxResource1" />
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
                                                                                                                        <asp:Label runat="server" ID="lblPatientID" Visible="False" Text='<%# Eval("PatientID") %>'
                                                                                                                            meta:resourcekey="lblPatientIDResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:LinkButton ID="lnkShow" ForeColor="Black" Font-Bold="true" Font-Underline="true"
                                                                                                                            runat="server" Visible="false" Text="Show" CommandName="ShowReport" meta:resourcekey="lnkShowResource1">
                                                                                                                        </asp:LinkButton>
                                                                                                                        <%--<a href="#" id="IdImg" runat="server" >View Image</a>--%>
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
                                                                            <td class="h-20 a-center" style="color: #000000;">
                                                                                <asp:LinkButton ID="lnkShowReport" OnClientClick="javascript:return ValidateCheckBox();"
                                                                                    ForeColor="Black" runat="server" Text="ShowReport" CommandName="ShowReport" Font-Underline="true"
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
                                        <td>
                                            <table runat="server" visible="false" style="background-color: #fcecb6" id="tblcontent">
                                                <tr>
                                                    <td class="alterimg">
                                                    </td>
                                                    <td>
                                                        <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_11 %></b>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <img src="../Images/box_menu_bullet.png" runat="server" id="imgInstallExe" alt="error"
                                                                        visible="true" /><asp:HyperLink Font-Bold="true" ForeColor="Black" runat="server"
                                                                            ID="lnkInstall" Text="Click to download & install Viewer" meta:resourcekey="lnkInstallResource1"></asp:HyperLink>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <img src="../Images/box_menu_bullet.png" alt="error" runat="server" id="imgInsGuide"
                                                                        visible="true" />
                                                                    <asp:LinkButton runat="server" Font-Bold="true" OnClick="lnkInsguide_Click" ForeColor="Black"
                                                                        ID="lnkInsguide" Text="Click to view the Installation Guide" meta:resourcekey="lnkInsguideResource1"></asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <img src="../Images/box_menu_bullet.png" alt="error" runat="server" id="imgUserGuide"
                                                                        visible="true" />
                                                                    <asp:LinkButton runat="server" OnClick="lnkUserGuide_Click" Font-Bold="true" ForeColor="Black"
                                                                        ID="lnkUserGuide" Text="Click to view the Viewer User Guide" meta:resourcekey="lnkUserGuideResource1"></asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <asp:HiddenField runat="server" ID="hdnInstallationGuidePath" />
                                            <asp:HiddenField runat="server" ID="hnUserGuidePath" />
                                            <asp:HiddenField runat="server" ID="hdnIpaddress" />
                                            <asp:HiddenField runat="server" ID="hdnPortNumber" />
                                            <asp:HiddenField runat="server" ID="hdnPath" />
                                            <input type="hidden" id="ChkID" runat="server" />
                                            <asp:HiddenField ID="HdnCheckBoxId" runat="server" />
                                            <asp:HiddenField ID="hdnOrgID" runat="server" />
                                            <asp:HiddenField ID="hdnTaskDetail" runat="server" />
                                            <asp:HiddenField ID="hdnErrorCount" runat="server" />
                                            <asp:HiddenField ID="hdnGenderAge" runat="server" />
                                            <asp:HiddenField ID="hdnValidateData" runat="server" />
                                            <asp:HiddenField ID="hdnOutofrangeCount" runat="server" />
                                            <asp:HiddenField ID="hdnhigh" runat="server" Value="" />
                                            <input id="Hdnhistoalert" runat="server" type="hidden" value='N' />
                                            <asp:HiddenField ID="hdnSaveandNext" runat="server" Value="N" />
                                            <asp:HiddenField ID="hdntotrows" Value="0" runat="server" />
                                            <asp:HiddenField ID="hdnRecollectCountFlag" runat="server" Value="0" />
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
                                                    <ajc:ModalPopupExtender ID="rptMdlPopup" runat="server" PopupControlID="pnlAttrib"
                                                        TargetControlID="hiddenTargetControlForModalPopup" BackgroundCssClass="modalBackground"
                                                        CancelControlID="btnCnl">
                                                    </ajc:ModalPopupExtender>
                                                    <asp:Panel ID="pnlAttrib" BorderWidth="1px" Height="95%" CssClass="modalPopup dataheaderPopup w-90p"
                                                        runat="server" meta:resourcekey="pnlAttribResource1">
                                                        <table class="w-100p w-100p">
                                                            <tr>
                                                                <td valign="top">
                                                                    <rsweb:ReportViewer ID="rReportViewer" runat="server" ProcessingMode="Remote" Font-Names="Verdana"
                                                                        Font-Size="8pt" meta:resourcekey="rReportViewerResource1" WaitMessageFont-Names="Verdana"
                                                                        WaitMessageFont-Size="14pt">
                                                                        <ServerReport ReportServerUrl="" />
                                                                    </rsweb:ReportViewer>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="a-center">
                                                                    <asp:Button ID="btnCnl" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                        onmouseout="this.className='btn'" meta:resourcekey="btnCnlResource1" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </td>
                    </tr>
                </table>
                <table class="w-95p" style="display: none;" runat="server" id="tblPDFReportViewer">
                    <tr>
                        <td>
                            <%--       <asp:LinkButton ID="lnkPDFReportPreviewer" runat="server" Text="Show Report Preview"
                                Font-Underline="true" ForeColor="Blue" meta:resourcekey="lnkPDFReportPreviewerResource1" />--%>
                            <asp:HiddenField ID="hdnTargetCtlReportPreview" runat="server" />
                            <ajc:ModalPopupExtender ID="mpReportPreview" runat="server" PopupControlID="pnlReportPreview"
                                TargetControlID="hdnTargetCtlReportPreview" BackgroundCssClass="modalBackground"
                                CancelControlID="imgPDFReportPreview" DynamicServicePath="" Enabled="True">
                            </ajc:ModalPopupExtender>
                            <asp:Panel ID="pnlReportPreview" BorderWidth="1px" CssClass="modalPopup dataheaderPopup w-90p"
                                runat="server" meta:resourcekey="pnlShowReportPreviewResource1" Style="display: none">
                                <asp:Panel ID="pnlReportPreviewHeader" runat="server" CssClass="dialogHeader" meta:resourcekey="pnlReportPreviewHeaderResource1">
                                    <table class="w-100p">
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="lblReportPreviewHeader" runat="server" Text="Report Preview" meta:resourcekey="lblReportPreviewHeaderResource2"></asp:Label>
                                            </td>
                                            <td class="a-right">
                                                <img id="imgPDFReportPreview" src="../Images/dialog_close_button.png" runat="server"
                                                    alt="Close" style="cursor: pointer;" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <table class="w-100p">
                                    <tr style="vertical-align: top;">
                                        <td>
                                            <table id="tblViewPreviewTRF" runat="server" class="w-100p" style="display: none;">
                                                <tr id="Tr3" runat="server">
                                                    <td id="Td3" class="colorforcontent w-30p h-23 a-left" runat="server">
                                                        <div id="ACX3plus1" style="display: block;">
                                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top" style="cursor: pointer"
                                                                onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);">
                                                                &nbsp;<asp:Label ID="lblReportTemplate" runat="server" Text="Show TRF" meta:resourcekey="lblReportTemplateResource1"></asp:Label></span></div>
                                                        <div id="ACX3minus1" style="display: none;">
                                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top" style="cursor: pointer"
                                                                onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);">
                                                                <asp:Label ID="Label12" runat="server" Text="Hide TRF" meta:resourcekey="lblReportTemplateResource11"></asp:Label></span></div>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="ACX3responses1" class="v-top w-100p" style="display: none;">
                                                <tr class="v-top">
                                                    <td>
                                                        <TRF:ViewTRFImage ID="ViewPreviewTRF" runat="server" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="h-5">
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table class="w-100p">
                                                <tr>
                                                    <td class="colorforcontent w-30p h-23 a-left">
                                                        <div id="ACX3plus2" style="display: none;">
                                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top" style="cursor: pointer"
                                                                onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',1);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',0);">
                                                                &nbsp;<asp:Label ID="Label13" runat="server" Text="Show Report" meta:resourcekey="lblReportViewerResource1"></asp:Label></span></div>
                                                        <div id="ACX3minus2" style="display: block;">
                                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top" style="cursor: pointer"
                                                                onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);" />
                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX3plus2','ACX3minus2','ACX3responses2',0);showResponses('ACX3plus1','ACX3minus1','ACX3responses1',1);">
                                                                <asp:Label ID="Label14" runat="server" Text="Hide Report" meta:resourcekey="lblReportViewerResource1"></asp:Label></span></div>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="ACX3responses2" style="display: table;" class="w-100p">
                                                <tr>
                                                    <td>
                                                        <div id="iframeplaceholder" class="w-100p" style="height: auto;">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
                <asp:Label ID="lblResult" runat="server" ForeColor="#000333" Visible="False" meta:resourcekey="lblResultResource1">
                <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_12 %>
                </asp:Label>
                <table id="ucSCTab" runat="server" class="w-100p" style="display: none;">
                    <tr>
                        <td>
                            <div id="dvSampleCctrl" runat="server">
                                <uc25:SampleCctrl ID="ucSC" runat="server" />
                            </div>
                            <div id="Div2" class="h-20" style="display: none; color: #000;">
                                <img class="v-top h-15 w-15" alt="hide" onclick="showResponses('Div3','Div2','viewTab',0);"
                                    src="../Images/hideBids.gif" style="cursor: pointer" />
                                <span onclick="showResponses('Div3','Div2','viewTab',0);" style="cursor: pointer;
                                    color: #000;">&nbsp;<%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_13 %>
                                </span>
                            </div>
                            <div id="Div3" style="display: none; color: #000; height: 20px;">
                                <img class="v-top h-15 w-15" alt="Show" onclick="showResponses('Div3','Div2','viewTab',1);"
                                    src="../Images/showBids.gif" style="cursor: pointer" />
                                <span onclick="showResponses('Div3','Div2','viewTab',1);" style="cursor: pointer;
                                    color: #000;">&nbsp;<%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_13 %>
                                </span>
                            </div>
                            <table id="viewTab" class="w-97p" cellpadding="2" style="display: none;">
                                <tr>
                                    <td>
                                        <asp:DataList ID="grdResult" runat="server" CellPadding="4" ForeColor="#333333" ItemStyle-VerticalAlign="Top"
                                            OnItemCommand="grdResult_ItemCommand" OnItemDataBound="grdResult_ItemDataBound"
                                            RepeatDirection="Horizontal" meta:resourcekey="grdResultResource1" RepeatLayout="Table">
                                            <ItemTemplate>
                                                <table class="dataheaderInvCtrl" style="border-collapse: collapse;">
                                                    <tr>
                                                        <td valign="top">
                                                            <table cellpadding="5" class="colorforcontentborder w-100p" style="border-collapse: collapse;">
                                                                <tr>
                                                                    <td class="Duecolor h-20">
                                                                        Report
                                                                        <asp:Label ID="lblReportID" runat="server" Text='<%# Eval("TemplateID") %>' Visible="False"
                                                                            meta:resourcekey="lblReportIDResource3"></asp:Label>
                                                                        <asp:Label ID="lblReportname" runat="server" Text='<%# Eval("ReportTemplateName") %>'
                                                                            Visible="False" meta:resourcekey="lblReportnameResource3"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table cellpadding="5" class="colorforcontentborder w-100p" style="border-collapse: collapse;">
                                                                <tr>
                                                                    <td style="font-weight: normal;">
                                                                        <asp:DataList ID="dlChildInvName" runat="server" ItemStyle-VerticalAlign="Top" CssClass="w-100p"
                                                                            OnItemCommand="dlChildInvName_ItemCommand" RepeatColumns="1" RepeatDirection="Vertical"
                                                                            RepeatLayout="Table" meta:resourcekey="dlChildInvNameResource2">
                                                                            <ItemTemplate>
                                                                                <table>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:Label ID="lblInvname" runat="server" Text='<%#Eval("InvestigationName") %>'>
                                                                                                meta:resourcekey=&quot;lblInvnameResource2&quot;&gt;</asp:Label>
                                                                                            <asp:Label ID="lblInvID" runat="server" Text='<%#Eval("InvestigationID") %>' Visible="false">
                                                                                                meta:resourcekey=&quot;lblInvIDResource2&quot;&gt;</asp:Label>
                                                                                            <asp:Label ID="lblReportID" runat="server" Text='<%#Eval("TemplateID") %>' Visible="false">
                                                                                                meta:resourcekey=&quot;lblReportIDResource4&quot;&gt;</asp:Label>
                                                                                            <asp:Label ID="lblReportname" runat="server" Text='<%#Eval("ReportTemplateName") %>'
                                                                                                Visible="False" meta:resourcekey="lblReportnameResource4"></asp:Label>
                                                                                            </asp:Label>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:LinkButton ID="lnkShow" runat="server" CommandName="ShowReport" Font-Bold="true"
                                                                                                Font-Underline="true" ForeColor="Black" Text="Show" Visible="false" meta:resourcekey="lnkShowResource2">
                                                                                            </asp:LinkButton>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </ItemTemplate>
                                                                        </asp:DataList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-center h-20" style="color: #000000;">
                                                                        <asp:LinkButton ID="lnkShowReport" runat="server" CommandName="ShowReport" Font-Underline="true"
                                                                            ForeColor="Black" Text="ShowReport" meta:resourcekey="lnkShowReportResource2"></asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                        <rsweb:ReportViewer ID="ReportViewer" runat="server" CssClass="w-100p" ProcessingMode="Remote">
                                            <ServerReport ReportServerUrl="" />
                                        </rsweb:ReportViewer>
                                    </td>
                                </tr>
                            </table>
                            <input id="sourceSenderHDN" runat="server" type="hidden" />
                            <input id="sourceNameHDN" runat="server" type="hidden" />
                            <input id="sourceNameHDN1" runat="server" type="hidden" />
                            <div id="sourceNameDIV" runat="server" style="border-width: 1px; border-color: #000;
                                display: none; position: fixed; z-index: 2; top: 200px; left: 200px;">
                                <table cellpadding="3" style="background-color: #333; border-color: #000; color: #fff;">
                                    <tr class="h-20" class="colorforcontent">
                                        <td colspan="2">
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_14 %>
                                                    </td>
                                                    <td class="a-right">
                                                        <img id="img2" onclick="javascript:setSourceNameClose();" src="../Images/Delete.jpg"
                                                            style="cursor: pointer;" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Label ID="sourceNameLBL" runat="server" ForeColor="White" meta:resourcekey="sourceNameLBLResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_15 %>
                                        </td>
                                        <td>
                                            <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_16 %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:ListBox ID="lstSource" runat="server" meta:resourcekey="lstSourceResource1">
                                            </asp:ListBox>
                                        </td>
                                        <td>
                                            <asp:ListBox ID="lstQualitativeMaster" runat="server" meta:resourcekey="lstQualitativeMasterResource1">
                                            </asp:ListBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:TextBox ID="sourceNameTXT" runat="server" Width="200px" meta:resourcekey="sourceNameTXTResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center" colspan="2">
                                            <input id="Hidden1" runat="server" type="hidden" />
                                            <input id="Hidden2" runat="server" type="hidden" />
                                            <asp:Label ID="Label15" runat="server" Font-Bold="True" ForeColor="White" OnClick="javascript:return addSourceName();"
                                                Style="cursor: pointer;" meta:resourcekey="Label15Resource1">Add</asp:Label>
                                            &nbsp;&nbsp;&nbsp;
                                            <asp:Label ID="Label16" runat="server" Font-Bold="True" ForeColor="White" OnClick="javascript:setSourceNameClose();"
                                                Style="cursor: pointer;" meta:resourcekey="Label16Resource1">Cancel</asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <%--Code added for Group Level Comments --%>
                            <%-- BEGIN--%>
                            <div id="groupCommentDIV" runat="server" style="border-width: 1px; border-color: #000;
                                display: none; position: fixed; z-index: 2; top: 200px; right: 200px;">
                                <table cellpadding="3" style="background-color: #333; border-color: #000; color: #fff;">
                                    <tr class="colorforcontent h-20">
                                        <td>
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_17 %>
                                                    </td>
                                                    <td class="a-right">
                                                        <img id="img3" onclick="javascript:setGroupCommentClose();" src="../Images/Delete.jpg"
                                                            style="cursor: pointer;" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="groupCommentLBL" runat="server" ForeColor="White" meta:resourcekey="groupCommentLBLResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblTechnicalRemarks" Text="Technical Remarks:" runat="server" meta:resourcekey="lblTechnicalRemarksResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="groupCommentTXT" runat="server" Columns="6" Rows="2" TextMode="MultiLine"
                                                Width="200px" meta:resourcekey="groupCommentTXTResource1"></asp:TextBox>
                                            <asp:HiddenField ID="hdnGrpTechRemChangedCtl" runat="server" />
                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                                TargetControlID="groupCommentTXT" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                                                EnableCaching="False" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarksGrpTech">
                                            </ajc:AutoCompleteExtender>
                                            <%--<asp:HiddenField ID="hdnAppRemarksID" runat="server" />--%>
                                            <asp:HiddenField ID="hdnInvRemGrpIDList" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblMedicalRemarks" Text="Medical Remarks:" runat="server" meta:resourcekey="lblMedicalRemarksResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtGrpCommentMed" runat="server" Columns="6" Rows="2" TextMode="MultiLine"
                                                Width="200px" meta:resourcekey="txtGrpCommentMedResource1"></asp:TextBox>
                                            <asp:HiddenField ID="hdnGrpMedRemChangedCtl" runat="server" />
                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                                                TargetControlID="txtGrpCommentMed" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                                                EnableCaching="False" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarksGrpMed">
                                            </ajc:AutoCompleteExtender>
                                            <%--<asp:HiddenField ID="hdnAppMedRemarksID" runat="server" />--%>
                                            <asp:HiddenField ID="hdnInvMedRemGrpIDList" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <input id="groupCommentHDN" runat="server" type="hidden" />
                                            <input id="hdnstatuschange" runat="server" type="hidden" />
                                            <input id="groupCommentHDN1" runat="server" type="hidden" />
                                            <input id="groupMedCommentHDN" runat="server" type="hidden" />
                                            <input id="groupMedCommentHDN1" runat="server" type="hidden" />
                                            <asp:Label ID="Label7" runat="server" Font-Bold="True" ForeColor="White" OnClick="javascript:setGroupComment();"
                                                Style="cursor: pointer;" meta:resourcekey="Label7Resource1">Add</asp:Label>
                                            &nbsp;&nbsp;&nbsp;
                                            <asp:Label ID="Label8" runat="server" Font-Bold="True" ForeColor="White" OnClick="javascript:setGroupCommentClose();"
                                                Style="cursor: pointer;" meta:resourcekey="Label8Resource1">Cancel</asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <%-- END--%>
                            <div id="DInvest" runat="server" visible="true">
                                <div id="ACX2minus4" class="h-20" style="display: none; color: #000;">
                                    <img class="v-top h-15 w-15" alt="hide" onclick="showResponses('ACX2plus4','ACX2minus4','captureTab',0);"
                                        src="../Images/hideBids.gif" style="cursor: pointer" />
                                    <span onclick="showResponses('ACX2plus4','ACX2minus4','captureTab',0);" style="cursor: pointer;
                                        color: #000;">&nbsp;<%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_18 %>
                                    </span>
                                </div>
                                <div class="h-20" id="ACX2plus4" style="display: none; color: #000;">
                                    <img class="v-top h-15 w-15" alt="Show" onclick="showResponses('ACX2plus4','ACX2minus4','captureTab',1);"
                                        src="../Images/showBids.gif" style="cursor: pointer" />
                                    <span onclick="showResponses('ACX2plus4','ACX2minus4','captureTab',1);" style="cursor: pointer;
                                        color: #000;">&nbsp;<%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_18 %>
                                    </span>
                                </div>
                                <table id="captureTab" style="display: table;" class="w-100p">
                                    <tr>
                                        <td>
                                            <div id="divSave1" runat="server">
                                                <table class="defaultfontcolor w-22p m-auto">
                                                    <tr>
                                                        <td id="trsavecontinue" runat="server" class="w-25p a-right">
                                                            <asp:Button ID="btnSave1" runat="server" CssClass="btn" OnClick="btnSave_Click" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Text="Save" OnClientClick="return SaveClicked();"
                                                                meta:resourcekey="btnSave1Resource1" />
                                                        </td>
                                                        <td id="trsaveorg" runat="server" class="a-right w-25p">
                                                            <asp:Button ID="btnSaveToDispatch1" runat="server" CssClass="btn" OnClick="btnSave_Click"
                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Save And Home"
                                                                OnClientClick="return SaveToDispatchClicked();" meta:resourcekey="btnSaveToDispatch1Resource1" />
                                                        </td>
                                                        <td id="trSaveandNext" runat="server" class="a-left w-50p">
                                                            <asp:Button ID="btsaveandnext" runat="server" CssClass="btn displaynonecls" OnClick="btnSave_Click"
                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Save And Next"
                                                                OnClientClick="return CheckSaveandnext1();" meta:resourcekey="btsaveandnextResource1" />
                                                            <asp:Button ID="Button4" runat="server" CssClass="btn" OnClick="Button1_Click" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Text="Cancel" meta:resourcekey="Button4Resource1" />
                                                                <asp:Button ID="btnSavePreview1" runat="server" Visible="False" CssClass="btn" OnClick="btnSavePreview_Click"
                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Save And Preview"
                                                                OnClientClick="return Clicked();" meta:resourcekey="btnSavePreviewResource1" />
                                                        </td>                                                
                                                        
                                                        
                                                    </tr>
                                                </table>
                                                <table class="defaultfontcolor" class="w-100p">
                                                    <tr id="trRangeColor" runat="server" style="display: block;">
                                                        <td colspan="4">
                                                            <asp:TextBox ID="txtAuto" Enabled="False" runat="server" CssClass="w-10 h-10" meta:resourcekey="txtAutoResource1"></asp:TextBox>
                                                            <asp:Label ID="lblAutoColor" Text="Auto Authorization Range" runat="server" meta:resourcekey="lblAutoColorResource1"></asp:Label>
                                                            <asp:TextBox ID="txtPanic" Enabled="False" runat="server" CssClass="w-10 h-10" meta:resourcekey="txtPanicResource1"></asp:TextBox>
                                                            <asp:Label ID="lblPanicColor" runat="server" Text="Panic Range" meta:resourcekey="lblPanicColorResource1"></asp:Label>
                                                            <asp:TextBox ID="txtReference" Enabled="False" runat="server" CssClass="w-10 h-10"
                                                                meta:resourcekey="txtReferenceResource1"></asp:TextBox>
                                                            <asp:Label ID="lblreferencecolor" Text="Normal Range" runat="server" meta:resourcekey="lblreferencecolorResource1"></asp:Label>
                                                            <asp:TextBox ID="txtLower" Enabled="False" runat="server" CssClass="w-10 h-10" meta:resourcekey="txtLowerResource1"></asp:TextBox>
                                                            <asp:Label ID="lblLower" Text="Lower Abnormal Range" runat="server" meta:resourcekey="lblLowerResource1"></asp:Label>
                                                            <asp:TextBox ID="txtHigher" Enabled="False" runat="server" CssClass="w-10 h-10" meta:resourcekey="txtHigherResource1"></asp:TextBox>
                                                            <asp:Label ID="lblHigher" Text="Higher Abnormal Range" runat="server" meta:resourcekey="lblHigherResource1"></asp:Label>
                                                            <asp:TextBox ID="txtDeviceError" Enabled="false" runat="server" Width="10px" Height="10px"></asp:TextBox>
                                                            <asp:Label ID="lblDeviceError" Text="Device Error" runat="server" meta:resourcekey="lblDeviceErrorResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Table ID="drawNewPattern" runat="server" CssClass="w-100p searchPanel" meta:resourcekey="drawNewPatternResource1">
                                            </asp:Table>
                                            <div id="divSave" runat="server">
                                                <table class="defaultfontcolor w-22p m-auto">
                                                    <tr>
                                                        <td id="trbottomsavecontinue" runat="server" class="w-25p a-right">
                                                            <asp:Button ID="btnSave" runat="server" CssClass="btn" OnClick="btnSave_Click" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Text="Save" OnClientClick="return SaveClicked();"
                                                                meta:resourcekey="btnSaveResource1" />
                                                        </td>
                                                        <td id="trbottom" runat="server" class="w-25p a-right">
                                                            <asp:Button ID="btnSaveToDispatch" runat="server" CssClass="btn" OnClick="btnSave_Click"
                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Save And Home"
                                                                OnClientClick="return SaveToDispatchClicked();" meta:resourcekey="btnSaveToDispatchResource1" />
                                                        </td>
                                                        <td id="btnbottomsavennext" runat="server" class="w-50p a-left">
                                                            <asp:Button ID="btnbtmsavennext" runat="server" CssClass="btn" OnClick="btnSave_Click"
                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Save And Next"
                                                                OnClientClick="return CheckSaveandnext1();" meta:resourcekey="btnbtmsavennextResource1" />
                                                            <asp:Button ID="Button1" runat="server" CssClass="btn" OnClick="Button1_Click" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" Text="Cancel" meta:resourcekey="Button1Resource1" />
                                                            <asp:Button ID="btnSavePreview" runat="server" Visible="False" CssClass="btn" OnClick="btnSavePreview_Click"
                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Save And Preview"
                                                                OnClientClick="return Clicked();" meta:resourcekey="btnSavePreviewResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divProgress" runat="server" style="position: absolute; top: 200px; left: 350px;
                                                display: none; z-index: 9999;" class="a-center">
                                                <table cellpadding="3" style="border-color: #000; color: #fff;">
                                                    <tr>
                                                        <td colspan="2">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <div id="progressBackgroundFilter">
                                                            </div>
                                                            <div class="a-center w-60p" id="processMessage">
                                                                <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                                                <br />
                                                                <br />
                                                                <asp:Image ID="imgProgressbar" runat="server" ImageUrl="../Images/working.gif" AlternateText="Please wait..."
                                                                    meta:resourcekey="imgProgressbarResource1" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
                <ajc:ModalPopupExtender ID="mpeAttributeLocation" runat="server" BackgroundCssClass="modalBackground"
                    Drag="false" DropShadow="false" PopupControlID="pnlPop" TargetControlID="btnDummy2" />
                <input id="btnDummy2" runat="server" style="display: none;" type="button" />
                <asp:Panel ID="pnlPop" runat="server" Style="display: block; max-height: 200px;"
                    Width="400px" meta:resourcekey="pnlPopResource1">
                    <asp:UpdatePanel ID="selectpnl" runat="server">
                        <ContentTemplate>
                            <div id="floatdiv" runat="server" class="w-100p" style="display: block; border-width: 1px;
                                border-color: #000; z-index: 100">
                                <table cellpadding="3" class="w-100p" style="background-color: #333; border-color: #000;
                                    color: #fff;">
                                    <tr class="colorforcontent h-20">
                                        <td>
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_19 %>
                                                    </td>
                                                    <td class="a-right">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <font face="arial" size="2">
                                                <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_20 %></font>
                                            </font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left">
                                            <div id="divscrl" runat="server" class="w-100p" style="overflow: auto; max-height: 190px;">
                                                <table class="w-90p marginL10">
                                                    <font color="yellow" face="arial" size="2">
                                                        <asp:Label ID="ltrlTestName" runat="server" meta:resourcekey="ltrlTestNameResource1"></asp:Label>
                                                    </font>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <font face="arial" size="2">
                                                <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_21 %></font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <table class="w-20p">
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnSaveConfirm" runat="server" CssClass="btn" OnClick="btnSave_Click"
                                                            OnClientClick="javascript:return displayProgress();" onmouseout="this.className='btn'"
                                                            onmouseover="this.className='btn btnhov'" Text="Yes" meta:resourcekey="btnSaveConfirmResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnCloseWarning" runat="server" CssClass="btn" OnClientClick="return HideAbnormalPopup();"
                                                            onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="No"
                                                            meta:resourcekey="btnCloseWarningResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:Panel>
                <Reflex:ReflexTest ID="ucReflexTest" runat="server" />
                <Synoptic:SynopticTest ID="ucSynopticTest" runat="server" />
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnSave" />
                <asp:PostBackTrigger ControlID="btnSaveToDispatch" />
                <asp:PostBackTrigger ControlID="btnSave1" />
                <asp:PostBackTrigger ControlID="btnSaveToDispatch1" />
                
            </Triggers>
        </asp:UpdatePanel>
        <input type="hidden" id="hdnTaskDate" runat="server" value="-1" />
        <input type="hidden" id="hdncategory" runat="server" value="-1" />
        <input type="hidden" id="hdnspecId" runat="server" value="-1" />
        <input type="hidden" id="hdnInvLocationID" runat="server" value="0" />
        <input type="hidden" id="hdncurrentPageNo" runat="server" value="0" />
        <input type="hidden" id="hdnDeptID" runat="server" value="-1" />
        <asp:UpdateProgress DynamicLayout="true" ID="UpdateProgress1" runat="server">
            <ProgressTemplate>
                <asp:Image ID="imgLoadingbars" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgLoadingResource1" />
                <asp:Label ID="Rs_Loading" Text="Loading ..." runat="server" meta:resourcekey="Rs_LoadingResource1" />
            </ProgressTemplate>
        </asp:UpdateProgress>
        <asp:HiddenField runat="server" ID="hdnClickCheck" Value="False" />
        <asp:HiddenField runat="server" ID="hdnSaveToDispatch" Value="0" />
        <asp:HiddenField ID="hdnDCcheck" runat="server" Value="false" />
        <asp:HiddenField ID="hdnIsCultureSensitivityV2" runat="server" Value="false" />
        <asp:HiddenField ID="hdnFishResulPattern" runat="server" Value="false" />
        <asp:HiddenField ID="hdnFishResulPattern1" runat="server" Value="false" />
        <asp:HiddenField ID="hdnMolbio" runat="server" Value="false" />
        <asp:HiddenField ID="hdnBRCA" runat="server" Value="false" />
        <asp:HiddenField ID="hdnBRCA1" runat="server" Value="false" />
        <asp:HiddenField ID="hdnMicroBio1" runat="server" Value="false" />
        <asp:HiddenField ID="hdnUnCheckedAbnormalControl" runat="server" Value="" />
        <asp:HiddenField ID="hdnEditableFormulaFields" runat="server" Value="" />
        <asp:HiddenField ID="hdnComputationFieldList" runat="server" Value="" />
        <asp:HiddenField ID="hdnDDLValues" runat="server" Value="" />
        <asp:HiddenField ID="hdnIsCoAuthList" runat="server" Value="" />
        <asp:HiddenField ID="hdnlstreasons" runat="server" Value="" />
        <asp:HiddenField ID="hdnDomainvalue" runat="server" Value="false" />
        <asp:HiddenField ID="hdnOutOfRangeDetails" runat="server" Value="" />
        <asp:HiddenField ID="hdnHighRangeDetails" runat="server" Value="" />
        <asp:HiddenField ID="hdnIsExcludeAutoApproval" runat="server" Value="" />
        <asp:HiddenField ID="hdnMessages" runat="server" Value="" />
        <asp:HiddenField ID="hdnLstCoAuthorizeUser" runat="server" Value="" />
        <input id="hdnabnormalchange" runat="server" type="hidden" />
        <asp:HiddenField ID="hdnTaskID" runat="server" Value="-1" />
        <asp:HiddenField ID="hdnDefaultDropDownStatus" runat="server" Value="" />
        <asp:HiddenField ID="hdnIscommonValidation" runat="server" Value="" />
        <asp:HiddenField ID="hdnIsAutoAuthRecollect" runat="server" Value="" />
        <asp:HiddenField ID="hdnAutoApproveQueueCount" runat="server" Value="" />
        <asp:HiddenField ID="hdnrerunrecollect" runat="server" Value="" />
        <asp:HiddenField ID="hdnNoGraphAttached" runat="server" Value="" />
        <asp:HiddenField ID="hdnRoleName" runat="server" Value="" />
        <asp:HiddenField ID="hdnSensitivehigh" runat="server" Value="" />
        <asp:HiddenField ID="hdnSensitiveRangeDetails" runat="server" Value="" />
        <asp:HiddenField ID="hdnlstNotYetResolvedRRParams" runat="server" Value="" />
        <asp:HiddenField ID="hdnPatientGender" runat="server" Value="" />
        <asp:HiddenField ID="hdnpagearraw" runat="server" />
        <asp:HiddenField ID="hdnSynopticTestFlag" runat="server" />
    </div>
    <ajc:ModalPopupExtender ID="ModalPopupExtender3" runat="server" BackgroundCssClass="modalBackground"
        CancelControlID="btnpopClose1" DynamicServicePath="" Enabled="True" PopupControlID="pnlLocation1"
        TargetControlID="btnDummy11">
    </ajc:ModalPopupExtender>
    <input id="btnDummy11" runat="server" style="display: none;" type="button"></input>
    <asp:HiddenField runat="server" ID="hdnGroupCollection" />
    <asp:HiddenField runat="server" ID="HdnIsCompleted" />
    <asp:HiddenField ID="hdnConfigValue" runat="server" Value="" />
    <asp:HiddenField ID="hdnsavebuttonclick" runat="server" Value="N" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <%--    <uc2:Footer ID="Footer1" runat="server" />--%>
    </div>
    <%--     <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>
<script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>--%>

    <script type="text/javascript" src="../Scripts/InvPattern.js"></script>

    <script type="text/javascript" src="../Scripts/ResultCapture.js"></script>

    <script language="javascript" type="text/javascript">
        function ShowReportPreview(vid, roleId, invStatus) 
        {
            try {
                
                $find("mpReportPreview").show();
                $("#iframeplaceholder").html("<iframe id='myiframe' name='myname' src='PrintVisitDetails.aspx?vid=" + vid + "&roleid=" + roleId + "&type=showreport&invstatus=" + invStatus + "' style='width: 100%;height: 450px; border: 0px; overfow: none;'></iframe>");
            }
            catch (e) {
                return false;
            }
        }
        function ShowReportPreviewonReport(vid, roleId, invStatus) {
           
            try {               
               
              $("#iframeplaceholder").html("<iframe id='myiframe' name='myname' src='PrintVisitDetails.aspx?vid=" + vid + "&roleid=" + roleId + "&type=showreport&invstatus=" + invStatus + "' style='width: 100%;height: 450px; border: 0px; overfow: none;'></iframe>");
            }
            catch (e) {
            return false;
            }
        }
        function changeTestName(x) {
            document.getElementById("testNameDIV").style.display = "block";
            document.getElementById("testNameLBL").innerHTML = document.getElementById(x).innerHTML;
            document.getElementById("testNameHDN").value = x;
            document.getElementById("testNameTXT").value = "";
            document.getElementById("testNameTXT").focus();
        }
        function setTestName() {
            if (document.getElementById("testNameTXT").value != "") {
                document.getElementById(document.getElementById("testNameHDN").value).innerHTML = document.getElementById("testNameTXT").value;
                z = document.getElementById("testNameHDN").value.split("~");
                document.getElementById("testNameHDN1").value += z[0] + "~" + document.getElementById("testNameTXT").value + "^";
            }
            document.getElementById("testNameTXT").value = "";
            document.getElementById("testNameDIV").style.display = "none";
        }
        function setTestNameClose() {
            document.getElementById("testNameDIV").style.display = "none";
        }


        function SelectAll(IsChecked) {
            var chkArrayMain = new Array();
            chkArrayMain = document.getElementById('HdnCheckBoxId').value.split('~');
            if (document.getElementById(IsChecked).checked) {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    document.getElementById(chkArrayMain[i]).checked = true;
                }
            } else {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    document.getElementById(chkArrayMain[i]).checked = false;
                }
            }

        }
        function ValidateCheckBox() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vInv = SListForAppMsg.Get('Investigation_InvestigationApprovel_aspx_01') == null ? "Select an investigation" : SListForAppMsg.Get('Investigation_InvestigationApprovel_aspx_01');
            var chkArrayMain = new Array();
            var count = 0;
            chkArrayMain = document.getElementById('HdnCheckBoxId').value.split('~');
            for (var i = 0; i < chkArrayMain.length; i++) {
                if (document.getElementById(chkArrayMain[i]).checked == true) {
                    count++;
                }
            }
            if (count > 0)
            { return true; } else {
                //alert('Select an investigation');
                ValidationWindow(vInv, AlertType);
                return false;

            }

        }
        function ShowReportDiv() {

            // alert(document.getElementById('dReport'));
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
                document.getElementById('grdResultTemp_ctl00_chkSelectAll').checked = false;
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
            var vInvestigation = SListForAppMsg.Get('Investigation_InvestigationApprovel_aspx_02') == null ? "Select an investigation to display  report" : SListForAppMsg.Get('Investigation_InvestigationApprovel_aspx_02');
            if (document.getElementById('ChkID').value != '') {
                HideDiv();
                return true;
            }
            else {
                //alert('Select an investigation to display  report');
                ValidationWindow(vInvestigation, AlertType);
            }
            return false;
        }         
        
    </script>

    <script type="text/javascript">
        if ($('.tb').length) {
            $(function() {

                $(".tb").autocomplete({
                    source: function(request, response) {
                        $.ajax({
                            url: "../WebService.asmx/FetchDrugList",
                            data: "{ 'drug': '" + request.term + "','Orgid': '" + parseInt(document.getElementById('hdnOrgID').value) + "' }",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataFilter: function(data) { return data; },
                            success: function(data) {
                                response($.map(data.d, function(item) {
                                    return {
                                        value: item.BrandName
                                    }
                                }))
                            },
                            error: function(XMLHttpRequest, textStatus, errorThrown) {
                                alert(textStatus);
                            }
                        });
                    },
                    minLength: 2
                });
            });
        }


        function reloadauto() {

            $(function() {

                $(".tb").autocomplete({
                    source: function(request, response) {
                        $.ajax({
                            url: "../WebService.asmx/FetchDrugList",
                            data: "{ 'drug': '" + request.term + "','Orgid': '" + parseInt(document.getElementById('hdnOrgID').value) + "' }",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataFilter: function(data) { return data; },
                            success: function(data) {
                                response($.map(data.d, function(item) {
                                    return {
                                        value: item.BrandName
                                    }
                                }))
                            },
                            error: function(XMLHttpRequest, textStatus, errorThrown) {
                                alert(textStatus);
                            }
                        });
                    },
                    minLength: 2
                });
            });
        }

        window.onbeforeunload = LeavePage;
        function LeavePage(e) {
            if(document.getElementById('hdnsavebuttonclick').value != 'Y')
            {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/UpdateCurrentTask",
                data: "{taskID: '" + $("#hdnTaskID").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function Success(data) {
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    return false;
                }
            });
            //ValidateUserExit("User");
            //ValidateUserExit(document.getElementById('hdnClickCheck').value + '$' + document.getElementById('hdnClickCheck').id);
}
        }
        function TaskOpenJs(arg) {
            //LockReleased
            //alert(arg);
        }
        function ProcessCallBackError(arg) {
            //Error in UnLocking
            //alert('Error In Unlocking');
        }
        function CheckSaveandnext1() {
            //debugger;
            document.getElementById('hdnSaveandNext').value = 'Y';
            SaveToDispatchClicked();
        }
        function SaveToDispatchClicked() {
            try {
                if (!CheckSaveValidationFuntion()) {
                    return false;
                }
            } catch (e) {
            }
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vGraph = SListForAppMsg.Get('Investigation_InvestigationApprovel_aspx_03') == null ? "Graph or image is not yet uploaded for some of the visit(s). Do you want to continue?" : SListForAppMsg.Get('Investigation_InvestigationApprovel_aspx_03');
            var vSomeAuthorization = SListForAppMsg.Get('Investigation_InvestigationApprovel_aspx_04') == null ? "Some of the test are selected for co-authorization but user is not selected" : SListForAppMsg.Get('Investigation_InvestigationApprovel_aspx_04');
            var vValues = SListForAppMsg.Get('Investigation_InvestigationApprovel_aspx_05') == null ? "Do you want save above values?" : SListForAppMsg.Get('Investigation_InvestigationApprovel_aspx_05');
            try {
                if (document.getElementById("hdnNoGraphAttached").value != "") {
                    if (!confirm("" + vGraph + "")) {
                        return false;
                    }
                }
                //var result = CheckDifferentStatus();
                //if (!result) return false;
                //
                try {
                    if (!ValidationFuntionEmptyValueFuntion()) {
                        return false;
                    }
                } catch (e) {
                }
                //
                try {
                    var isAuthorizedUserSelected = true;
                    $('select[id$="ddlstatus"]').each(function(i, n) {
                        var selectedStatus = $(this).val();
                        var lstStatus = selectedStatus.split('_');
                        if (lstStatus[0] != null && (lstStatus[0] == "Co-authorize" || lstStatus[0] == "Second Opinion")) {
                            var ddlOpinionUserId = $(this).attr('id').replace('ddlstatus', 'ddlOpinionUser');
                            if (ddlOpinionUserId != null && ddlOpinionUserId != undefined && document.getElementById(ddlOpinionUserId) != null && document.getElementById(ddlOpinionUserId).selectedIndex > 0) {
                                isAuthorizedUserSelected = true;
                            }
                            else {
                                isAuthorizedUserSelected = false;
                                return false;
                            }
                        }
                    });
                    if (!isAuthorizedUserSelected) {
                        //alert("Some of the test are selected for co-authorization but user is not selected");
                        ValidationWindow(vSomeAuthorization, AlertType);
                        return false;
                    }
                    if ($("#Attuneheader_lblRoleDes").text() == "Physician Assistant") {

                        var isRCRoleUserSelected = true;
                        $('select[id$="ddlOpinionUser"]').each(function(i, n) {
                            var selectedStatus = $(this).val();
                            //var lstStatus = selectedStatus.split('_');
                            if (selectedStatus != "--Select--") {
                                //var ddlOpinionUserId = $(this).attr('id').replace('ddlstatus', 'ddlOpinionUser');
                                //if (ddlOpinionUserId != null && ddlOpinionUserId != undefined && document.getElementById(ddlOpinionUserId) != null && document.getElementById(ddlOpinionUserId).selectedIndex > 0) {
                                    isRCRoleUserSelected = true;
                                }
                                else {
                                    isRCRoleUserSelected = false;
                                    return false;
                                }
                            
                        });
                        if (!isRCRoleUserSelected) {
                            alert("Some of the Department User is not selected");
                            //ValidationWindow(vSomeAuthorization, AlertType);
                            return false;
                        }

                    }
                    var hdnSensitiveRangeDetails = document.getElementById('hdnSensitiveRangeDetails').value;
                    var lstSensitiveRangeDetails = {};
                    if (hdnSensitiveRangeDetails != "") {
                        lstSensitiveRangeDetails = JSON.parse(hdnSensitiveRangeDetails);
                    }
                    var lstSensitiveHign = [];
                    for (prop1 in lstSensitiveRangeDetails) {
                        lstSensitiveHign.push({
                            Name: prop1,
                            Value: lstSensitiveRangeDetails[prop1]
                        });
                    }
                    if (lstSensitiveHign.length > 0) {
                        document.getElementById('hdnSensitivehigh').value = JSON.stringify(lstSensitiveHign);
                    }

                }
                catch (e) {
                }
                document.getElementById('hdnSaveToDispatch').value = "1";
                Clicked();
                var hdnOutOfRangeDetails = document.getElementById('hdnOutOfRangeDetails').value;
                var lstOutOfRangeDetails = {};
                if (hdnOutOfRangeDetails != "") {
                    lstOutOfRangeDetails = JSON.parse(hdnOutOfRangeDetails);
                }
                var hdnHighRangeDetails = document.getElementById('hdnHighRangeDetails').value;
                var lstHighRangeDetails = {};
                if (hdnHighRangeDetails != "") {
                    lstHighRangeDetails = JSON.parse(hdnHighRangeDetails);
                }
                var lstHign = [];
                for (prop1 in lstHighRangeDetails) {
                    lstHign.push(
                    {
                        Name: prop1,
                        Value: lstHighRangeDetails[prop1]
                    });
                }
                if (lstHign.length > 0) {
                    document.getElementById('hdnhigh').value = JSON.stringify(lstHign);
                }
                var lstTestName = "";
                for (property in lstOutOfRangeDetails) {
                    lstTestName += lstOutOfRangeDetails[property];
                }
                //                HideProgress();
                //                if ($.trim(lstTestName).length > 0) {
                //                    document.getElementById('ltrlTestName').innerHTML = lstTestName;
                //                    document.getElementById("btnSaveConfirm").style.display = "block";
                //                    document.getElementById("btnSaveToDispatch").style.display = "none";
                //                    document.getElementById("btnSaveToDispatch1").style.display = "none";
                //                    $find('mpeAttributeLocation').show();
                //                    return false;
                //                }
                //                else {
                //                    $find("mpeAttributeLocation").hide();
                //                }
                if (document.getElementById('Hdnhistoalert').value == 'Y') {
                    var ans = window.confirm('' + vValues + '');
                    if (ans == true)
                        return true;
                    else
                        return false;
                }
            }
            catch (e) {
                return false;
            }
            document.getElementById('hdnsavebuttonclick').value = 'Y';
        }
        function SaveClicked() {
            try {
                
                try {
                    if (!CheckSaveValidationFuntion()) {
                        return false;
                    }
                } catch (e) {
                }
                //var result = CheckDifferentStatus();
                //if (!result) return false;
                document.getElementById('hdnSaveToDispatch').value = "0";
                Clicked();
                var hdnSensitiveRangeDetails = document.getElementById('hdnSensitiveRangeDetails').value;
                var lstSensitiveRangeDetails = {};
                if (hdnSensitiveRangeDetails != "") {
                    lstSensitiveRangeDetails = JSON.parse(hdnSensitiveRangeDetails);
                }
                var lstSensitiveHign = [];
                for (prop1 in lstSensitiveRangeDetails) {
                    lstSensitiveHign.push(
                    {
                        Name: prop1,
                        Value: lstSensitiveRangeDetails[prop1]
                    });
                }
                if (lstSensitiveHign.length > 0) {
                    document.getElementById('hdnSensitivehigh').value = JSON.stringify(lstSensitiveHign);
                }

                var hdnOutOfRangeDetails = document.getElementById('hdnOutOfRangeDetails').value;
                var lstOutOfRangeDetails = {};
                if (hdnOutOfRangeDetails != "") {
                    lstOutOfRangeDetails = JSON.parse(hdnOutOfRangeDetails);
                }
                var hdnHighRangeDetails = document.getElementById('hdnHighRangeDetails').value;
                var lstHighRangeDetails = {};
                if (hdnHighRangeDetails != "") {
                    lstHighRangeDetails = JSON.parse(hdnHighRangeDetails);
                }
                var lstHign = [];
                for (prop1 in lstHighRangeDetails) {
                    lstHign.push(
                    {
                        Name: prop1,
                        Value: lstHighRangeDetails[prop1]
                    });
                }
                if (lstHign.length > 0) {
                    document.getElementById('hdnhigh').value = JSON.stringify(lstHign);
                }
                var lstTestName = "";
                for (property in lstOutOfRangeDetails) {
                    lstTestName += lstOutOfRangeDetails[property];
                }
                //                HideProgress();
                //                if ($.trim(lstTestName).length > 0) {
                //                    document.getElementById('ltrlTestName').innerHTML = lstTestName;
                //                    document.getElementById("btnSaveConfirm").style.display = "block";
                //                    document.getElementById("btnSaveToDispatch").style.display = "none";
                //                    document.getElementById("btnSaveToDispatch1").style.display = "none";
                //                    $find('mpeAttributeLocation').show();
                //                    return false;
                //                }
                //                else {
                //                    $find("mpeAttributeLocation").hide();
                //                }
            }
            catch (e) {
                return false;
            }
        }
        function Clicked() {
            try {
                document.getElementById('hdnClickCheck').value = "True";
                CheckCultureSensitivityV2();
            }
            catch (e) {
            }
        }

        function ChangeComputationFieldEditOption(txtid) {
            try {
                var lstEditableFormulaFields = '';
                if (document.getElementById('hdnEditableFormulaFields') != null) {
                    lstEditableFormulaFields = document.getElementById('hdnEditableFormulaFields').value;
                    if (lstEditableFormulaFields.indexOf(txtid) >= 0) {
                        document.getElementById(txtid).readOnly = true;
                        lstEditableFormulaFields = lstEditableFormulaFields.replace(txtid + "^", "").replace(txtid, "");
                        document.getElementById('hdnEditableFormulaFields').value = lstEditableFormulaFields;
                        ChecKGroupSum(txtid);
                    }
                    else {
                        document.getElementById(txtid).readOnly = false;
                        lstEditableFormulaFields = lstEditableFormulaFields + txtid + "^";
                        document.getElementById('hdnEditableFormulaFields').value = lstEditableFormulaFields;
                    }
                }
            }
            catch (e) {
                return false;
            }
        }

        function displayProgress() {
            document.getElementById("btnSaveConfirm").style.display = "none";
            document.getElementById("divProgress").style.display = "block";
        }
        function HideProgress() {
            document.getElementById("divProgress").style.display = "none";
            return false;
        }
        function HideAbnormalPopup() {
            document.getElementById('hdnSaveandNext').value = 'N';
            document.getElementById("btnSaveToDispatch").style.display = "block";
            document.getElementById("btnSaveToDispatch1").style.display = "block";
            $find("mpeAttributeLocation").hide();
            return false;
        }

        function ProcessCallBackError(arg) {

            //alert('error'+arg);
            //document.getElementById("txtdummy").value = arg;
            //alert('Result value cannot be blank ');
        }
        function showConfirmpop() {

            document.getElementById('floatdiv').style.display = 'block';

        }

        function hideConfirmpop() {

            document.getElementById('floatdiv').style.display = 'none';
            document.getElementById("btnSave").style.display = "block";

        }
        function CheckError() {
            if (document.getElementById('hdnErrorCount').value <= 0) {

                return true;
            }
            else {

                return false;
            }
        }

        //code added for reference range - end
        function CheckCultureSensitivityV2() {
            try {
                try {
                    if (document.getElementById('hdnHPVPattern').value = "true") {
                        CallingSaveHPVPattern();
                    }
                }
                catch (e) {
                }
                try {
                    if (document.getElementById('hdnFishResulPattern').value = "true") {
                        CallingSaveFishResultpattern();
                    }
                }
                catch (e) {
                }
                try {
                    if (document.getElementById('hdnFishResulPattern1').value = "true") {
                        CallingSaveFishResultpattern1();
                    }
                }
                catch (e) {
                }
                try {
                    if (document.getElementById('hdnMolbio').value = "true") {
                        CallingSaveMolBioPattern();
                    }
                }
                catch (e) {
                }
                try {
                    if (document.getElementById('hdnBRCA').value = "true") {
                        CallingSaveBRCAPattern();
                    }
                }
                catch (e) {
                }
                try {
                    if (document.getElementById('hdnBRCA1').value = "true") {
                        CallingSaveBRCA();
                    }
                }
                catch (e) {
                }
                try {
                    if (document.getElementById('hdnMicroBio1').value = "true") {
                        CallingSaveMicroBio1Pattern();
                    }
                }
                catch (e) {
                }
                try {
                    if (document.getElementById('hdnIsCultureSensitivityV2').value = "true") {
                        CallingSaveCultureSensitiveV2();
                    }
                }
                catch (e) {
                }
                try {
                    CallingOrganisumDrugPatternDetails();
                }
                catch (e) {
                }
                try {
                    CallingMicroStainPatternDetails();
                }
                catch (e) {
                }
                try {
                    CallingSaveHEMATOLOGYPattern();
                }
                catch (e) {
                }
                try {

                    CallingSaveGeneralPattern();

                }
                catch (e) {
                }
                try {

                    CallingSaveTablepatternautopopulate();
                }
                catch (e) {
                }
            }
            catch (e) {
            }
        }
        function changeSourceName(x, ddlId, type) {


            var lstsource = document.getElementById("lstSource");
            var lstQRMaster = document.getElementById("lstQualitativeMaster");

            document.getElementById("sourceNameDIV").style.display = "block";
            //document.getElementById("sourceNameLBL").innerHTML = document.getElementById(x).innerHTML;
            //var ddlsource = document.getElementById("ddlSource");       

            var ddlsourceSender = document.getElementById(ddlId);
            document.getElementById("sourceSenderHDN").value = ddlId;
            z = document.getElementById("sourceSenderHDN").value.split("~");
            document.getElementById("sourceNameHDN1").value = z[0] + "~" + type;


            for (var i = lstsource.options.length - 1; i >= 0; i--) {
                lstsource.options[i] = null;
            }
            for (var i = 1; i < ddlsourceSender.length; i++) {

                var opt = document.createElement("option");
                opt.text = ddlsourceSender.options[i].text;
                opt.value = ddlsourceSender.options[i].Value;
                //  ddlsource.options.add(opt);
                lstsource.add(opt);

            }

            var listLength1 = lstQRMaster.options.length;
            var listLength2 = lstsource.options.length;

            for (var i = 0; i < listLength2; i++) {

                for (var j = 0; j < listLength1; j++) {

                    if (lstQRMaster.options[j].text == lstsource.options[i].text) {

                        lstQRMaster.options[j] = null
                        listLength1--;
                        j--;
                    }

                }
            }

            document.getElementById("lstQualitativeMaster").focus();

        }


        function setSourceNameClose() {
            document.getElementById("sourceNameDIV").style.display = "none";
        }





        function addSourceName() {
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vItemAdd = SListForAppMsg.Get('Investigation_InvestigationApprovel_aspx_06') == null ? "Please enter item to Add" : SListForAppMsg.Get('Investigation_InvestigationApprovel_aspx_06');
            var vItemList = SListForAppMsg.Get('Investigation_InvestigationApprovel_aspx_07') == null ? "Already exist in current item list." : SListForAppMsg.Get('Investigation_InvestigationApprovel_aspx_07');
            if (document.getElementById("sourceNameTXT").value != "") {
                var lstsource = document.getElementById("lstSource");
                for (var i = 0; i < lstsource.options.length; i++) {
                    if (lstsource[i].innerHTML == document.getElementById("sourceNameTXT").value) {
                        //alert("Already exist in current item list.");
                        ValidationWindow(vItemList, AlertType);
                        return false;
                    }
                }
                temp1 = document.getElementById("sourceNameHDN1").value;
                //document.getElementById("sourceNameHDN1").value = '';
                document.getElementById("sourceNameHDN").value += temp1 + "~" + document.getElementById("sourceNameTXT").value + "^";
                //alert(document.getElementById("sourceNameHDN").value);
                var ddlsourceSender = document.getElementById(document.getElementById("sourceSenderHDN").value);

                var opt = document.createElement("option");
                var opt1 = document.createElement("option");
                opt.text = document.getElementById("sourceNameTXT").value;
                opt.value = document.getElementById("sourceNameTXT").value;
                opt1.text = document.getElementById("sourceNameTXT").value;
                opt1.value = document.getElementById("sourceNameTXT").value;

                ddlsourceSender.options.add(opt);
                document.getElementById('lstSource').add(opt1);

                document.getElementById("sourceNameTXT").value = "";
                //alert(document.getElementById("sourceNameHDN").value);
                //document.getElementById("sourceNameDIV").style.display = "none";
                return true;
            }
            else {
                //alert('Please enter item to Add');
                ValidationWindow(vItemAdd, AlertType);
                return false;
            }
        }
        function DisplaySelectedItem(lstbox, textbox) {

            var lstQRMaster = document.getElementById(lstbox)

            var listLength = lstQRMaster.options.length;

            for (var i = 0; i < listLength; i++) {
                if (lstQRMaster.options[i].selected) {

                    document.getElementById(textbox).value = lstQRMaster.options[i].text
                }
            }
        }
    </script>

    <%-- <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>--%>
    </form>
</body>
</html>
