<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OperationNotesCaseSheet.aspx.cs"
    Inherits="Physician_OperationNotesCaseSheet" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/DiagnoseWithICD.ascx" TagName="DiagnoseWithICD"
    TagPrefix="uc5" %>
<%--<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>--%>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Operation Notes Case Sheet</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
<%--         <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/actb.js" type="text/javascript"></script>

    <script src="../Scripts/actbcommon.js" type="text/javascript"></script>
          <script src ="../scripts/MessageHandler.js" language ="javascript" type ="text/javascript" ></script>

    <script language="javascript" type="text/javascript">
       var userMsg;
       function PrintCaseSheet() 
        {

            var prtContent = document.getElementById('PrintCaseSheet');

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0,Addressbar=no');
            //alert(WinPrint);
            //var WinPrint = window.open('', '', 'letf=0,top=0,width=900,height=900,toolbar=0,scrollbars=0,status=0,Addressbar=no');
            WinPrint.document.write(prtContent.innerHTML);

            WinPrint.document.close();

            WinPrint.focus();

            WinPrint.print();

            WinPrint.close();
            return false;
        }

        function pValidationTreatment() {

            if (document.getElementById("OPid").value == '') {
            userMsg = SListForApplicationMessages.Get('Physician\\OperationNotesCaseSheet.aspx_1');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{

                alert('Select treatment ');
                return false;
                
               
               }
            }
        }

    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <div style="display: none;">
        <t1:Theme ID="Theme1" runat="server" />
    </div>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <%--<uc3:DocHeader ID="docHeader" runat="server" />--%>
                <uc3:PatientHeader ID="patientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
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
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td>
                                    <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <table id="tblTreatment" cellpadding="0" cellspacing="0" border="0" width="100%"
                            style="display: block" runat="server">
                            <tr class="defaultfontcolor">
                                <td>
                                    <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                        <tr style="height: 10px;">
                                            <td style="font-weight: normal; color: #000;" colspan="2" align="center">
                                                <input type="hidden" id="OPid" name="OPid" />
                                                <asp:GridView ID="gvTreatment" runat="server" AutoGenerateColumns="False" DataKeyNames="OperationID"
                                                    OnRowDataBound="gvTreatment_RowDataBound" meta:resourcekey="gvTreatmentResource1">
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-Width="5%" meta:resourcekey="TemplateFieldResource1">
                                                            <ItemTemplate>
                                                                <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="PatientSelect"
                                                                    meta:resourcekey="rdSelResource1" />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="5%"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField Visible="False" meta:resourcekey="TemplateFieldResource2">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblOperationID" runat="server" Text='<%# Bind("IPTreatmentPlanName") %>'
                                                                    meta:resourcekey="lblIPTreatmentPlanNameResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Treatment Name" ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource3">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblIPTreatmentPlanName" runat="server" Text='<%# Bind("OperationID") %>'
                                                                    meta:resourcekey="lblOperationIDResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Performed By" ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource4">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPhysicianName" runat="server" Text='<%# Bind("PhysicianName") %>'
                                                                    meta:resourcekey="lblPhysicianNameResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Performed Date" ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource5">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblFromTime" runat="server" Text='<%# Bind("FromTime") %>' meta:resourcekey="lblFromTimeResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Type" ItemStyle-Width="14%" meta:resourcekey="TemplateFieldResource6">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblParentName" runat="server" Text='<%# Bind("ParentName") %>' meta:resourcekey="lblParentNameResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="14%" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2" align="center">
                                                <asp:Button ID="btnViewOperationNotes" runat="server" Text="View" CssClass="btn"
                                                    OnClientClick="return pValidationTreatment()" OnClick="btnViewOperationNotes_Click"
                                                    meta:resourcekey="btnViewOperationNotesResource1" />
                                                <asp:Button ID="btnAddNew" runat="server" Text="Add Operation Notes" CssClass="btn"
                                                    OnClick="btnAddNew_Click" meta:resourcekey="btnAddNewResource1" />
                                                <asp:HiddenField ID="hdnOPID" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <div id="PrintCaseSheet">
                            <table cellpadding="0" runat="server" cellspacing="0" border="0" width="100%" id="tblDischrageResult"
                                style="display: block;" class="defaultfontcolor">
                                <%-- <tr>
                                <td>
                                    <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                </td>
                            </tr>--%>
                                <tr class="defaultfontcolor">
                                    <td style="font-weight: bold; height: 20px; color: #000; font-size: 15px" align="center">
                                        <asp:Label ID="Rs_OPERATIONNOTES" Text="OPERATION NOTES" runat="server" meta:resourcekey="Rs_OPERATIONNOTESResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: bold; height: 20px;">
                                        <asp:Label ID="lblPatientDetail" runat="server" meta:resourcekey="lblPatientDetailResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trDOS" runat="server" style="display: none">
                                    <td>
                                        <asp:Label ID="Rs_DateTimeofOperation" Text="Date & Time of Operation -" runat="server"
                                            meta:resourcekey="Rs_DateTimeofOperationResource1"></asp:Label>
                                        <asp:Label ID="lblDTO" runat="server" meta:resourcekey="lblDTOResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr id="trsurgery" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_PERFORMEDSURGERYPROCEDURE" Text="PERFORMED SURGERY/PROCEDURE" runat="server"
                                                        meta:resourcekey="Rs_PERFORMEDSURGERYPROCEDUREResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tblSurgeryDetail" runat="server" CellSpacing="0" BorderWidth="1px"
                                                        GridLines="Both" meta:resourcekey="tblSurgeryDetailResource1">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trDiagnosis" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_CLINICALDIAGNOSIS" Text="CLINICAL DIAGNOSIS" runat="server" meta:resourcekey="Rs_CLINICALDIAGNOSISResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tbldiagnosis" runat="server" CellSpacing="0" meta:resourcekey="tbldiagnosisResource1">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <uc5:DiagnoseWithICD ID="DiagnoseWithICD1" runat="server" />
                                    </td>
                                </tr>
                                <tr id="trOperationTeam" runat="server">
                                    <td style="font-weight: bold; height: 20px; color: #000;">
                                        <asp:Label ID="Rs_OPERATIONTEAM" Text="OPERATION TEAM" runat="server" meta:resourcekey="Rs_OPERATIONTEAMResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trChiefOperator" runat="server" style="display: block">
                                    <td>
                                        <asp:Label ID="Rs_ChiefSurgeon" Text="Chief Surgeon :" runat="server" meta:resourcekey="Rs_ChiefSurgeonResource1"></asp:Label>
                                        <asp:Label ID="lblChiefOperator" runat="server" meta:resourcekey="lblChiefOperatorResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trAssistingOperator" runat="server" style="display: none">
                                    <td>
                                        <asp:Label ID="Rs_Assistingsurgeon" Text="Assisting surgeon :" runat="server" meta:resourcekey="Rs_AssistingsurgeonResource1"></asp:Label>
                                        <asp:Label ID="lblAssistingOperator" runat="server" meta:resourcekey="lblAssistingOperatorResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trAnesthetist" runat="server" style="display: none">
                                    <td>
                                        <asp:Label ID="Rs_Anesthetist" Text="Anesthetist :" runat="server" meta:resourcekey="Rs_AnesthetistResource1"></asp:Label>
                                        <asp:Label ID="lblAnesthetist" runat="server" meta:resourcekey="lblAnesthetistResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trTechnician" runat="server" style="display: none">
                                    <td>
                                        <asp:Label ID="Rs_Technician" Text="Technician :" runat="server" meta:resourcekey="Rs_TechnicianResource1"></asp:Label>
                                        <asp:Label ID="lblTechnician" runat="server" meta:resourcekey="lblTechnicianResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trNurse" runat="server" style="display: none">
                                    <td>
                                        <asp:Label ID="Rs_Nurse" Text="Nurse :" runat="server" meta:resourcekey="Rs_NurseResource1"></asp:Label><asp:Label
                                            ID="lblNurse" runat="server" meta:resourcekey="lblNurseResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: bold; height: 20px; color: #000;">
                                        <asp:Label ID="Rs_OPERATIONDETAILS" Text="OPERATION DETAILS" runat="server" meta:resourcekey="Rs_OPERATIONDETAILSResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Rs_SurgeryType" Text="Surgery Type :" runat="server" meta:resourcekey="Rs_SurgeryTypeResource1"></asp:Label>
                                        <asp:Label ID="lblSurgeryType" runat="server" meta:resourcekey="lblSurgeryTypeResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Rs_OperationType" Text="Operation Type :" runat="server" meta:resourcekey="Rs_OperationTypeResource1"></asp:Label>
                                        <asp:Label ID="lblOperationType" runat="server" meta:resourcekey="lblOperationTypeResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Rs_AnesthesiaType" Text="Anesthesia Type :" runat="server" meta:resourcekey="Rs_AnesthesiaTypeResource1"></asp:Label>
                                        <asp:Label ID="lblAnesthesiaType" runat="server" meta:resourcekey="lblAnesthesiaTypeResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr id="trPreOF" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_PREOPERATIVEFINDINGS" Text="PRE-OPERATIVE FINDINGS" runat="server"
                                                        meta:resourcekey="Rs_PREOPERATIVEFINDINGSResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblPreOF" runat="server" meta:resourcekey="lblPreOFResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trOPT" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_OPERATIVETECHNIQUE" Text="OPERATIVE TECHNIQUE" runat="server" meta:resourcekey="Rs_OPERATIVETECHNIQUEResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblOPT" runat="server" meta:resourcekey="lblOPTResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trOPF" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_OPERATIVEFINDINGS" Text="OPERATIVE FINDINGS" runat="server" meta:resourcekey="Rs_OPERATIVEFINDINGSResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblOPF" runat="server" meta:resourcekey="lblOPFResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trPostOF" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_POSTOPERATIVEFINDINGS" Text="POST-OPERATIVE FINDINGS" runat="server"
                                                        meta:resourcekey="Rs_POSTOPERATIVEFINDINGSResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblPostOF" runat="server" meta:resourcekey="lblPostOFResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trOperationComplication" runat="server" style="display: none">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="Rs_OPERATIONCOMPLICATION" Text="OPERATION COMPLICATION" runat="server"
                                                        meta:resourcekey="Rs_OPERATIONCOMPLICATIONResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Table ID="tblOperationComplication" runat="server" CellSpacing="0" meta:resourcekey="tblOperationComplicationResource1">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="tblSave" style="display: block;"
                            runat="server">
                            <tr>
                                <td align="center" colspan="4">
                                    <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn" OnClientClick="return PrintCaseSheet();" meta:resourcekey="btnPrintResource1"/>
                                    <%--<input type="button" name="btnPrint" id="btnPrint" onclick="PrintCaseSheet();" value="Print"
                                        class="btn" runat="server" />--%>
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn" OnClick="btnEdit_Click"
                                        meta:resourcekey="btnEditResource1" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" OnClick="btnCancel_Click"
                                        meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
            <asp:HiddenField ID ="hdnMessages" runat ="server" />
    </div>
    </form>
</body>
</html>
