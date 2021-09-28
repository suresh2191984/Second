<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RadiologyReport.aspx.cs"
    Inherits="Investigation_RadiologyReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/OrderedSamples.ascx" TagName="OrderedSamples"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Radiology Report</title>
    <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />


    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function checkForValues() {

        if (document.getElementById('txtpageNo').value == "") {
                alert('Provide page number');
            return false;
        }

        if (Number(document.getElementById('txtpageNo').value) < Number(1)) {
                alert('Provide correct page number');
            return false;
        }

        if (Number(document.getElementById('txtpageNo').value) > Number(document.getElementById('lblTotal').innerText)) {
                alert('Provide correct page number');
            return false;
        }
        function GetPatientName(PID) {
            var pID = PID.split('~');
            if (pID.length > 1) {
                var name = PID.split('(');
                var name1 = name[0].split('-');
                document.getElementById('txtPatient').value = name1[0];
            }
        }
        function GetHospitalName(HID) {
            var name = HID.split('(');
            document.getElementById('txtClinic').value = name[0];
        }
        function getList(PhyID) {
            if (PhyID != '') {
                var StringSplit = PhyID.split('~');
                if ("1" in StringSplit) {
                    document.getElementById('txtDoctor').value = StringSplit[0];
                }
            }
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <%--<uc3:PatientHeader ID="patientHeader" runat="server" />--%>
                <uc6:UserHeader ID="UserHeader1" runat="server" />
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
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay2" runat="server" />
                            </li>
                        </ul>
                        <%--   <asp:UpdatePanel ID="updatePanel2" runat="server">
                            <ContentTemplate>--%>
                        <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                            <tr style="height: 25px;">
                                <td style="width: 25%;" align="right">
                                    <asp:Label ID="Rs_PatientName" Text="Patient Name:" runat="server" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                </td>
                                <td style="width: 25%;">
                                    <asp:TextBox ID="txtPatient" runat="server" ToolTip="Enter Patient Name" CssClass="Txtboxsmall" onblur="ConverttoUpperCase(this.id); GetPatientName(this.value);"
                                        meta:resourcekey="txtPatientResource1"></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="AutoCompletePatient" runat="server" TargetControlID="txtPatient"
                                        EnableCaching="False" FirstRowSelected="True" CompletionInterval="100" MinimumPrefixLength="2"
                                        CompletionListCssClass="listtwo" CompletionListItemCssClass="listitemtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                        ServiceMethod="GetPatientListWithDetails" ServicePath="~/InventoryWebService.asmx"
                                        DelimiterCharacters="" Enabled="True">
                                    </ajc:AutoCompleteExtender>
                                </td>
                                <td style="width: 25%;" align="right">
                                    <asp:Label ID="Rs_URNo" Text="URNo:" runat="server" meta:resourcekey="Rs_URNoResource1"></asp:Label>
                                </td>
                                <td style="width: 25%;">
                                    <asp:TextBox ID="txtURno" runat="server" ToolTip="Enter URNo" CssClass="Txtboxsmall" meta:resourcekey="txtURnoResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr style="height: 25px;">
                                <td style="width: 25%;" align="right">
                                    <asp:Label ID="Rs_RefPhysicianName" Text="Ref. Physician Name:" runat="server" meta:resourcekey="Rs_RefPhysicianNameResource1"></asp:Label>
                                </td>
                                <td style="width: 25%;">
                                    <asp:TextBox ID="txtDoctor" runat="server" ToolTip="Enter Doctor Name" CssClass="Txtboxsmall" onblur="ConverttoUpperCase(this.id); getList(this.value);"
                                        meta:resourcekey="txtDoctorResource1"></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="AutoRname" runat="server" TargetControlID="txtDoctor"
                                        FirstRowSelected="True" ServiceMethod="GetPhysician" ServicePath="~/WebService.asmx"
                                        EnableCaching="False" MinimumPrefixLength="2" BehaviorID="AutoCompleteEx1" CompletionInterval="10"
                                        DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected" Enabled="True">
                                    </ajc:AutoCompleteExtender>
                                </td>
                                <td style="width: 25%;" align="right">
                                    <asp:Label ID="Rs_RefHospitalClinicName" Text="Ref. Hospital/Clinic Name:" runat="server"
                                        meta:resourcekey="Rs_RefHospitalClinicNameResource1"></asp:Label>
                                </td>
                                <td style="width: 25%;">
                                    <asp:TextBox ID="txtClinic" runat="server" ToolTip="Enter Clinic Name" CssClass="Txtboxsmall" onblur="ConverttoUpperCase(this.id); GetHospitalName(this.value);"
                                        meta:resourcekey="txtClinicResource1"></asp:TextBox>
                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClinic"
                                        EnableCaching="False" FirstRowSelected="True" CompletionInterval="100" MinimumPrefixLength="2"
                                        CompletionListCssClass="listtwo" CompletionListItemCssClass="listitemtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                        ServiceMethod="GetReferingHospitalList" ServicePath="~/InventoryWebService.asmx"
                                        DelimiterCharacters="" Enabled="True">
                                    </ajc:AutoCompleteExtender>
                                </td>
                            </tr>
                            <tr style="height: 25px;">
                                <td style="width: 25%;" align="right">
                                    <asp:Label ID="Rs_ReportingRadiologist" Text="Reporting Radiologist:" runat="server"
                                        meta:resourcekey="Rs_ReportingRadiologistResource1"></asp:Label>
                                </td>
                                <td style="width: 25%;">
                                    <asp:DropDownList ID="ddlPerformingPhysician" Width="190px" runat="server" CssClass="ddlsmall" ToolTip="Select Radiologist"
                                        meta:resourcekey="ddlPerformingPhysicianResource1">
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 25%;" align="right">
                                    <asp:Label ID="Rs_ReportContent" Text="Report Content:" runat="server" meta:resourcekey="Rs_ReportContentResource1"></asp:Label>
                                </td>
                                <td style="width: 25%;">
                                    <asp:TextBox ID="txtReportContent" CssClass="Txtboxsmall" runat="server" ToolTip="Enter Report Content"
                                        meta:resourcekey="txtReportContentResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr style="height: 25px;">
                                <td style="width: 25%;" align="right">
                                    <asp:Label ID="Rs_FromVisitDate" Text="From Visit Date:" runat="server" meta:resourcekey="Rs_FromVisitDateResource1"></asp:Label>
                                </td>
                                <td style="width: 25%;">
                                    <asp:TextBox Width="125px" ID="txtFrom" runat="server" CssClass="Txtboxsmall" ToolTip="Enter From Visit Date"
                                        meta:resourcekey="txtFromResource1"></asp:TextBox>
                                    <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                        CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFrom"
                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                        CultureTimePlaceholder="" Enabled="True" />
                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                        ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFrom"
                                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                </td>
                                <td style="width: 25%;" align="right">
                                    <asp:Label ID="Rs_ToVisitDate" Text="To Visit Date:" runat="server" meta:resourcekey="Rs_ToVisitDateResource1"></asp:Label>
                                </td>
                                <td style="width: 25%;">
                                    <asp:TextBox ID="txtTo" Width="125px" CssClass="Txtboxsmall" runat="server" ToolTip="Enter To Visit Date"
                                        meta:resourcekey="txtToResource1"></asp:TextBox>
                                    <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                        CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTo"
                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                        CultureTimePlaceholder="" Enabled="True" />
                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                        ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                    <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtTo"
                                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                </td>
                            </tr>
                            <tr style="height: 25px;">
                                <td align="center" colspan="4">
                                    <asp:Button ID="btnSearch" runat="server" Text=" Search " ToolTip="Click here to Search"
                                        OnClick="btnSearch_Click" CssClass="btn" meta:resourcekey="btnSearchResource1" />
                                    &nbsp;&nbsp;
                                    <asp:Button ID="btnReset" runat="server" Text=" Reset " ToolTip="Click here to Reset Search"
                                        CssClass="btn" OnClientClick="javascript:return ResetSearch();" meta:resourcekey="btnResetResource1" />
                                    &nbsp;&nbsp;
                                    <asp:Button ID="btnHome" runat="server" Text=" Home " ToolTip="Click here to Go Home"
                                        OnClick="btnHome_Click" CssClass="btn" meta:resourcekey="btnHomeResource1" />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <asp:Label ID="lblStatus" Visible="False" runat="server" ForeColor="#000333" Text="No Matching Records Found!"
                            meta:resourcekey="lblStatusResource1"></asp:Label>
                        <%-- <div>
                   <table>
                  <tr>
                                    <td>
                                     <asp:UpdateProgress ID="Progressbar" runat="server">
                                <ProgressTemplate>
                                    <asp:Image ID="imgProgressbar2" runat="server" ImageUrl="~/Images/working.gif" />
                                    Please wait....
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                                    </td>
                                    </tr></table></div>--%>
                        <div id="resultDIV" runat="server">
                            <asp:Label ID="Label4" runat="server" ForeColor="#000333" Text="Please Click on the Record to View/Print Report:"
                                meta:resourcekey="Label4Resource1"></asp:Label>
                            <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                CssClass="mytable1" ForeColor="#333333" DataKeyNames="PatientVisitID,UID,TemplateID,InvestigationID,AccessionNumber,ReportPath"
                                Width="100%" OnRowCommand="grdResult_RowCommand" OnRowDataBound="grdResult_RowDataBound"
                                meta:resourcekey="grdResultResource1">
                                <RowStyle Font-Bold="false" />
                                <HeaderStyle CssClass="dataheader1" />
                                <HeaderStyle CssClass="colorforcontent" ForeColor="White" />
                                <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Red" />
                                <EmptyDataTemplate>
                                    <center>
                                        <asp:Label ID="Rs_NoMatchingPatientRecordsFound" Text="No Matching Patient Records Found."
                                            runat="server" meta:resourcekey="Rs_NoMatchingPatientRecordsFoundResource1"></asp:Label></center>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:BoundField DataField="PatientVisitID" HeaderText="PatientVisitID" Visible="false"
                                        meta:resourcekey="BoundFieldResource1" />
                                    <asp:BoundField DataField="UID" HeaderText="UID" Visible="false" meta:resourcekey="BoundFieldResource2" />
                                    <asp:BoundField DataField="AccessionNumber" HeaderText="AccessionNumber" Visible="false"
                                        meta:resourcekey="BoundFieldResource3" />
                                    <asp:BoundField DataField="TemplateID" HeaderText="TemplateID" Visible="false" meta:resourcekey="BoundFieldResource4" />
                                    <asp:BoundField DataField="InvestigationID" HeaderText="InvestigationID" Visible="false"
                                        meta:resourcekey="BoundFieldResource5" />
                                    <asp:BoundField DataField="ReportPath" HeaderText="ReportPath" Visible="false" meta:resourcekey="BoundFieldResource6" />
                                    <asp:BoundField DataField="PatientName" HeaderStyle-HorizontalAlign="Left" HeaderText="Patient Name"
                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource7">
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="URNO" HeaderStyle-HorizontalAlign="Left" HeaderText="URNo"
                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource8">
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="VisitDate" HeaderStyle-HorizontalAlign="Left" HeaderText="Visit Date"
                                        ItemStyle-HorizontalAlign="Left" DataFormatString="{0:dd MMM yyyy}" meta:resourcekey="BoundFieldResource9">
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ReportText" HtmlEncode="true" HeaderStyle-HorizontalAlign="Left"
                                        HeaderText="Report Content" ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource10">
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ReportedBy" HeaderStyle-HorizontalAlign="Left" HeaderText="Reporting Radiologist"
                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource11">
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ReferingPhysicianName" HeaderStyle-HorizontalAlign="Left"
                                        HeaderText="Ref. Physician" ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource12">
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="HospitalName" HeaderStyle-HorizontalAlign="Left" HeaderText="Ref. Hospital/Clinic"
                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource13">
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                            <br />
                            <div id="divFooterNav" class="dataheaderInvCtrl" runat="server">
                                <table cellpadding="3" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td style="width: 20%;">
                                            <asp:Label ID="Label1" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                                            <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                            <asp:Label ID="Label2" runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label>
                                            <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                        </td>
                                        <td style="width: 10%;">
                                            <asp:Button ID="Btn_Previous" runat="server" Text=" Previous " ToolTip="Click here to Move Previous Page"
                                                OnClick="Btn_Previous_Click" CssClass="btn" meta:resourcekey="Btn_PreviousResource1" />
                                        </td>
                                        <td style="width: 10%;">
                                            <asp:Button ID="Btn_Next" runat="server" Text=" Next " ToolTip="Click here to Move Next Page"
                                                OnClick="Btn_Next_Click" CssClass="btn" meta:resourcekey="Btn_NextResource1" />
                                        </td>
                                        <td align="right">
                                            <asp:HiddenField ID="hdnCurrent" runat="server" />
                                            <asp:HiddenField ID="hdnPostBack" runat="server" />
                                            <asp:Label ID="Label3" runat="server" Text="Go To Page:" meta:resourcekey="Label3Resource1"></asp:Label>
                                        </td>
                                        <td style="width: 10%;" align="center">
                                            <asp:TextBox ID="txtpageNo" runat="server" Width="30px" ToolTip="Enter Page Number"
                                                   onkeypress="return ValidateOnlyNumeric(this);"    CssClass="Txtboxverysmall" meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                        </td>
                                        <td style="width: 10%;">
                                            <asp:Button ID="btnGo" runat="server" Text="  Go  " ToolTip="Click here to go Required Page"
                                                OnClientClick="javascript:return checkForValues();" OnClick="btnGo_Click" CssClass="btn"
                                                meta:resourcekey="btnGoResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <%--      </ContentTemplate>
                        </asp:UpdatePanel> 
                        --%>
                        <%--    <asp:UpdatePanel ID="Rpt" runat="server" ><ContentTemplate>--%>
                        <table>
                            <tr>
                                <td>
                                    <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none"
                                        meta:resourcekey="hiddenTargetControlForModalPopupResource1" />
                                    <ajc:ModalPopupExtender ID="rptMdlPopup" runat="server" PopupControlID="pnlAttrib"
                                        TargetControlID="hiddenTargetControlForModalPopup" BackgroundCssClass="modalBackground"
                                        CancelControlID="btnCnl" DynamicServicePath="" Enabled="True">
                                    </ajc:ModalPopupExtender>
                                    <asp:Panel ID="pnlAttrib" BorderWidth="1px" Height="95%" Width="90%" CssClass="modalPopup dataheaderPopup"
                                        runat="server" meta:resourcekey="pnlAttribResource1">
                                        <table width="100%" style="height: 100%">
                                            <tr>
                                                <td valign="top">
                                                    <rsweb:ReportViewer ID="ReportViewer" runat="server"
                                                        ProcessingMode="Remote" Font-Names="Verdana" Font-Size="8pt" meta:resourcekey="ReportViewerResource1">
                                                        <ServerReport ReportServerUrl="" />
                                                    </rsweb:ReportViewer>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center">
                                                    <asp:Button ID="btnCnl" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" meta:resourcekey="btnCnlResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <%--     </ContentTemplate>
                        </asp:UpdatePanel>  --%>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>

    <script language="javascript" type="text/javascript">

        function GetText(pName) {
            if (pName != "") {
                // var Temp = pName.split('(');
                //if (Temp.length >= 2) {
                document.getElementById('<%=txtPatient.ClientID %>').value = pName;
                // }
            }
        }
    </script>

    </form>
</body>
</html>
