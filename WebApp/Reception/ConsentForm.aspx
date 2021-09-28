<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ConsentForm.aspx.cs" Inherits="Reception_ConsentForm" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/InPatientProceduresBill.ascx" TagName="ipTreatmentBillDetails"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/ConsultationDetails.ascx" TagName="ipConsultationDetails"
    TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/InPatientInvestigation.ascx" TagName="ipInvestigation"
    TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/InvestigationControl.ascx" TagName="InvestigationControl"
    TagPrefix="ucinv1" %>
<%@ Register Src="../CommonControls/MedicalIndents.ascx" TagName="medIndents" TagPrefix="uc13" %>
<%@ Register Src="../CommonControls/DynamicDHEBAdder.ascx" TagName="OtherPayments"
    TagPrefix="uc14" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="PaymentType"
    TagPrefix="uc15" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .tableborder
        {
            height: 386px;
        }
        .style3
        {
            width: 1111px;
            height: 289px;
        }
        .style4
        {
            width: 179px;
        }
    </style>
    
   <script type ="text/javascript">
       function popupprint() {
           var prtContent = document.getElementById('hdnContent');
           var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
           //alert(WinPrint);
           WinPrint.document.write(prtContent.defaultValue);
           WinPrint.document.close();
           WinPrint.focus();
           WinPrint.print();
          // WinPrint.close();
       }
   </script>
</head>
<body>
    <form id="form1" runat="server" onkeypress="SuppressBrowserBackspaceRefresh(this.id)">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <%--  <img alt="" src="<%=LogoPath%>" class="logostyle" />--%>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <%--  <img alt="" src="<%=LogoPath%>" class="logostyle" />--%>
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc8:PatientHeader ID="PatientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc121:LeftMenu ID="LeftMenu1" runat="server" />
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
                        <table width="100%">
                            <tr>
                                <td style="width: 125px">
                                    <asp:Label ID="lblTemype" Text="Select Form Type" runat="server"></asp:Label>
                                </td>
                                <td class="style4">
                                    <asp:DropDownList ID="ddlTemplateType" runat="server" Style="margin-left: 0px" OnSelectedIndexChanged="ddlTemplateType_SelectedIndexChanged"
                                        AutoPostBack="true">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                            </tr>
                         
                            <tr>
                              
                                <td colspan="2" class="style3">
                                 <div id ="Printform" runat ="server" >
                                    <FCKeditorV2:FCKeditor ID="FCKTemplate" runat="server" Height="500px">
                                    </FCKeditorV2:FCKeditor>
                                     </div>
                                </td>
                                  
                            </tr>
                         
                            <tr>
                                <td align="center" colspan="2">
                                    <asp:Button ID="btnSave" Text="Save" runat="server" CssClass="btn" OnClick="btnSave_Click" />
                                    
                                     <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'"  OnClick ="btnPrint_Click"
                                       />
                                    <asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
       <asp:HiddenField ID ="hdnContent" runat ="server" /> 
    </form>
 
</body>
</html>
