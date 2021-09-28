<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientDetails.ascx.cs"
    Inherits="CommonControls_PatientDetails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>

<script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

<%--<script src="../Scripts/Common.js" type="text/javascript"></script>
--%>

<script>
    $(function() {
        $('#btnclose').click(function() {
            $("#pnlPatientDet2").hide();
        })
    });
</script>

<style type="text/css">
    .grdRemarks1 th td
{
  border:1px solid #000000;
}
    .focus
    {
        border: 2px solid red;
        background-color: #FEFED5;
    }
    .style1
    {
        height: 20px;
        width: 8%;
    }
    .style2
    {
        height: 20px;
        width: 32px;
    }
    .style3
    {
        width: 5%;
    }
    .style6
    {
        height: 20px;
        width: 152px;
    }
    .style8
    {
        width: 60px;
    }
    .style10
    {
        width: 73px;
    }
    .style11
    {
        height: 20px;
        width: 49px;
    }
    .style12
    {
        width: 54px;
    }
    .style13
    {
        width: 45px;
    }
    .style15
    {
        height: 20px;
        width: 50px;
    }
  
    .style17
    {
        width: 49px;
    }
    .lbtxt
    {
        
        color: #1c94c4; 
        margin: 5 auto;
        font-family: Times New Roman;
        font-size: 13px;
        font-weight: bold;
        height: 15px;
        position: relative;
        display: marker;
        right: inherit;
    }
    .lbltr
    {
        text-align: center;
        height: 45px;
    }
</style>
<%--<asp:Panel ID="pnlptDetails" CssClass="dataheader2" BorderWidth="1px" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>--%>
<table class="dataheaderInvCtrl w-100p searchPanel">
    <tr class="Duecolor h-22 a-center">
        <td colspan="16">
            <asp:Label ID="lblpatdet" runat="server" Font-Bold="True" Text="Patient Details"
                meta:resourcekey="lblpatdetResource1"></asp:Label>
        </td>
    </tr>
    <tr class="lbltr" id="tbPatientDetails" runat="server">
        <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="lbvisitno" CssClass="lbtxt" runat="server" Text="Visit No: " meta:resourcekey="lbvisitnoResource1"></asp:Label>&nbsp;
            <asp:Label ID="lblVisitNo" runat="server" meta:resourcekey="lblVisitNoResource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="lbexvisitid" CssClass="lbtxt" runat="server" Text="External Visit No: "
                meta:resourcekey="lbexvisitidResource1"></asp:Label>&nbsp;
            <asp:Label ID="lblExVisitId" runat="server" meta:resourcekey="lblExVisitIdResource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="lbpatientname" CssClass="lbtxt" runat="server" Text="PatientName:"
                meta:resourcekey="lbpatientnameResource1"></asp:Label>
            &nbsp;
            <asp:Label ID="lblPatientName" runat="server" meta:resourcekey="lblPatientNameResource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="lbgenage" Text="Gender/Age" CssClass="lbtxt" runat="server" meta:resourcekey="lbgenageResource1"></asp:Label>
            &nbsp;
            <asp:Label ID="lblGender" runat="server" meta:resourcekey="lblGenderResource1"></asp:Label>
            <asp:HiddenField ID="hdnGender" runat="server" Value="Male" />
            
        </td>
        <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="Label2" CssClass="lbtxt" runat="server" Text="Visit Date:" meta:resourcekey="Label2Resource1" />
            &nbsp;
            <asp:Label ID="lblDate" runat="server" nowrap="nowrap" meta:resourcekey="lblDateResource1"></asp:Label><br />
            <asp:Label ID="lblCollectedDtId" CssClass="lbtxt" runat="server" Text="Collected Date:"
                nowrap="nowrap" meta:resourcekey="lblCollectedDtIdResource1" />&nbsp;
            <asp:Label ID="lblCollectedDt" runat="server" nowrap="nowrap" meta:resourcekey="lblCollectedDtResource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="lbpathist" Visible="False" CssClass="lbtxt" runat="server" Text="Patient History: "
                nowrap="nowrap" meta:resourcekey="lbpathistResource1" />&nbsp;
            <asp:Label ID="lblPatHist" runat="server" meta:resourcekey="lblPatHistResource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="style16 a-center">
            <asp:Image ImageUrl="~/Images/History.jpg" runat="server" Text="H" CssClass="h-30" 
                ID="imgchanges" meta:resourcekey="imgchangesResource1" />
        </td>
    </tr>
    <tr class="lbltr" id="tbPatientDetails1" runat="server">
        <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="Label1" runat="server" CssClass="lbtxt" Text="Patient No: " nowrap="nowrap"
                meta:resourcekey="Label1Resource1"></asp:Label>&nbsp;
            <asp:Label ID="lblPatientNo" runat="server" meta:resourcekey="lblPatientNoResource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="lblrefloc" CssClass="lbtxt" runat="server" Text="Reg.Location: " meta:resourcekey="lblreflocResource1"></asp:Label>&nbsp;
            <asp:Label ID="lblRefLocation" runat="server" meta:resourcekey="lblRefLocationResource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="lblRefDoctorId" runat="server" CssClass="lbtxt" Visible="False" Text="Ref. Doctor:"
                nowrap="nowrap" meta:resourcekey="lblRefDoctorIdResource1"></asp:Label>&nbsp;
            <asp:Label ID="lblRefDoctor" runat="server" meta:resourcekey="lblRefDoctorResource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="lblClientNameId" runat="server" CssClass="lbtxt" Visible="False" Text="Client Name:"
                nowrap="nowrap" meta:resourcekey="lblClientNameIdResource1"></asp:Label>&nbsp;
            <asp:Label ID="lblClientName" runat="server" meta:resourcekey="lblClientNameResource1"></asp:Label>
        </td>
        <td style="font-style: normal; color: Red;" class="style16 bold a-left">
            <asp:Label ID="lblRemarksId" runat="server" CssClass="lbtxt" Visible="False" Text="Remarks:"
                nowrap="nowrap" meta:resourcekey="lblRemarksIdResource1"></asp:Label>&nbsp;
            <asp:Label ID="lblRemarks" runat="server" meta:resourcekey="lblRemarksResource1"></asp:Label>
            <asp:Image ImageUrl="~/Images/History.jpg" runat="server" Text="H" CssClass="h-30"
                ID="imgchanges2" Visible="false" meta:resourcekey="imgchangesResource1" />
        </td>
        <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="lblRefHospitalId" runat="server" CssClass="lbtxt" Visible="False"
                Text="Ref. Hospital: " nowrap="nowrap" meta:resourcekey="lblRefHospitalIdResource1"></asp:Label>&nbsp;
            <asp:Label ID="lblRefHospital" runat="server" meta:resourcekey="lblRefHospitalResource1"></asp:Label>
        </td>
         <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="lblhistoID" runat="server" CssClass="lbtxt" Visible="False"
                Text="Histopathology No: " nowrap="nowrap"></asp:Label>&nbsp;
            <asp:Label ID="lblHistopathNo" runat="server"></asp:Label>
        </td>
    </tr>
    <tr id="trsrf" class="lbltr" runat="server" style="display:none;">
        <td id="tdsrfid" runat="server" style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="lblsrfid"  CssClass="lbtxt" runat="server" Text="SRF ID :"></asp:Label> 
            <asp:Label ID="txtsrfid" runat="server"></asp:Label>
        </td>
        <td id="tdtrfid" runat="server" style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="lbltrfid"  CssClass="lbtxt" runat="server" Text="TRF ID :"></asp:Label> 
            <asp:Label ID="txttrfid" runat="server"></asp:Label>
        </td>
    </tr>
</table>
<table id="Waters" runat="server"  class="dataheaderInvCtrl w-100p searchPanel">
    <tr class="lbltr">
        <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="WatersVisitNo" CssClass="lbtxt" runat="server" Text="Visit No: " meta:resourcekey="lbvisitnoResource1"></asp:Label>&nbsp;
            <asp:Label ID="WaterstxtVisitNo" runat="server" meta:resourcekey="lblVisitNoResource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="WatersSampleID" CssClass="lbtxt" runat="server" Text="Sample ID :"></asp:Label>&nbsp;
            <asp:Label ID="WaterstxtSampleID" runat="server"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="WatersSampleDesc" CssClass="lbtxt" runat="server" Text="Sample Descriptions :"></asp:Label>&nbsp;
            <asp:Label ID="WaterstxtSampleDesc" runat="server"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="WatersBarcode" CssClass="lbtxt" runat="server" Text="Barcode :"></asp:Label>&nbsp;
            <asp:Label ID="WaterstxtBarcode" runat="server"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="Label3" Visible="False" CssClass="lbtxt" runat="server" Text="Patient History: "
                nowrap="nowrap" meta:resourcekey="lbpathistResource1" />&nbsp;
            <asp:Label ID="Label4" runat="server" meta:resourcekey="lblPatHistResource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="style16 a-center">
            <asp:Image ImageUrl="~/Images/History.jpg" runat="server" Text="H" CssClass="h-30"
                ID="Image1" meta:resourcekey="imgchangesResource1" />
        </td>
    </tr>
    <tr class="lbltr">
        <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="WatersRegDate" CssClass="lbtxt" runat="server" Text="Register Date:" ></asp:Label>&nbsp;
            <asp:Label ID="WaterstxtRegDate" runat="server"></asp:Label>
        </td>
    </tr>
</table>
<table cellpadding="4" class="w-100p" style="display: none">
    <tr class="Duecolor h-15">
        <td colspan="13">
            <asp:Label ID="lblpatdet1" runat="server" Font-Bold="True" Text="Patient Details"
                meta:resourcekey="lblpatdetResource1"></asp:Label>
        </td>
    </tr>
    <tr class="h-20">
        <td style="font-weight: normal; color: #000;" class="style16 a-left">
            <asp:Label ID="Label11" runat="server" Text="Patient No:" nowrap="nowrap" meta:resourceKey="Label1Resource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="style15 a-left">
            <asp:Label ID="lblPatientNo1" runat="server" meta:resourceKey="lblPatientNoResource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="style1 a-left">
            <asp:Label ID="lblpatname" runat="server" Text="Patient Name" meta:resourcekey="lblpatnameResource1"></asp:Label>
            :
        </td>
        <td style="font-weight: normal; color: #000;" class="style6 a-left">
            <asp:Label ID="lblPatientName1" runat="server" meta:resourceKey="lblPatientNameResource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="a-left w-5p h-20">
            <asp:Label ID="lblgen" runat="server" Text="Gender" meta:resourcekey="lblgenResource1"></asp:Label>:
        </td>
        <td style="font-weight: normal; color: #000;" class="style3 a-left">
            <asp:Label ID="lblGender1" runat="server" meta:resourceKey="lblGenderResource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="style2 a-right">
            <asp:Label ID="lbage" runat="server" Text="Age" meta:resourcekey="lbageResource1"></asp:Label>:
        </td>
        <td style="font-weight: normal; color: #000; display: none" class="style10 a-left">
            <asp:Label ID="lblAge" runat="server" nowrap="nowrap" meta:resourceKey="lblAgeResource1"></asp:Label>
            <asp:Label ID="lblReferenceRangeAge" runat="server" nowrap="nowrap" Style="display: none;"
                meta:resourcekey="lblReferenceRangeAgeResource1"></asp:Label>
            <asp:HiddenField ID="hdnAgeDays" runat="server" Value="0" />
        </td>
        <td style="font-weight: normal; color: #000;" class="style12 a-right">
            <asp:Label ID="lbvisitno1" runat="server" Text="Visit No" meta:resourcekey="lbvisitnoResource1"></asp:Label>:
        </td>
        <td style="font-weight: normal; color: #000;" class="style11 a-left">
            <asp:Label ID="lblVisitNo1" runat="server" meta:resourceKey="lblVisitNoResource1"></asp:Label>
        </td>
        <td>
            <table>
                <tr>
                    <td style="font-weight: normal; color: #000;" class="style8 a-left">
                        <asp:Label ID="Label21" runat="server" Text="Visit Date:" nowrap="nowrap" meta:resourceKey="Label2Resource1" />
                    </td>
                    <td style="font-weight: normal; color: #000;" class="style17 a-left">
                        <asp:Label ID="lblDate1" runat="server" meta:resourceKey="lblDateResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
        <td id="imges" runat="server" class="a-right">
            <asp:Image ImageUrl="~/Images/History.jpg" runat="server" Text="H" CssClass="h-30"
                ID="imgchanges1" meta:resourcekey="imgchangesResource1" />
        </td>
    </tr>
    <tr style="display: none;" class="h-20" runat="server" id="trPatHistAndLabNo">
        <td style="font-weight: normal; color: #000; display: none;" class="style16 a-left"
            runat="server" id="tdLabNo1">
            <asp:Label ID="Rs_LabNo" runat="server" Text="Lab No:" nowrap="nowrap" meta:resourcekey="Rs_LabNoResource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000; display: none;" class="style15 a-left"
            runat="server" id="tdLabNo2">
            <asp:Label ID="lblLabNo" runat="server" meta:resourcekey="lblLabNoResource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="a-left" colspan="2" runat="server"
            id="tdPatHist">
            <asp:Label ID="lblPatHist1" runat="server" meta:resourcekey="lblPatHist1Resource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="a-left" colspan="4" runat="server"
            id="tdRemarks">
            <asp:Label ID="lblRemarks1" runat="server" meta:resourcekey="lblRemarks1Resource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="a-left" runat="server" id="tdClientName">
            <asp:Label ID="lblClientName1" runat="server" meta:resourcekey="lblClientName1Resource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="a-left" runat="server" id="tdRefHospital">
            <asp:Label ID="lblRefHospital1" runat="server" meta:resourcekey="lblRefHospital1Resource1"></asp:Label>
        </td>
        <td style="font-weight: normal; color: #000;" class="a-left" runat="server" id="tdRefDoctor">
            <asp:Label ID="lblRefDoctor1" runat="server" meta:resourcekey="lblRefDoctor1Resource1"></asp:Label>
        </td>
    </tr>
</table>
<asp:Panel ID="pnlPatientDet" runat="server" Width="550px" CssClass="modalPopup dataheaderPopup"
    Style="display: none" meta:resourcekey="pnlPatientDetResource1">
    <table class="w-98p a-center" id="tbl1">
        <tr id="mPatienthistory" runat="server">
            <td style="font-weight: normal; color: #000;" runat="server" class="a-left">
                <asp:Label ID="lblPatienthist" runat="server" Text="PatientHistory" meta:resourcekey="lblPatienthistResource1"></asp:Label>
            </td>
            <td style="font-weight: normal; color: #000;" runat="server" class="a-left">
                <asp:TextBox ID="txtpatientHist" runat="server" MaxLength="900" onBlur="return collapseTextBox(this.id);"
                    onFocus="return expandTextBox(this.id)" TextMode="MultiLine" CssClass="a-left small"></asp:TextBox>
            </td>
        </tr>
        <tr id="mremarks" runat="server">
            <td style="font-weight: normal; color: #000;" runat="server" class="a-left">
                <asp:Label ID="lblRemar" runat="server" Text="Remarks" meta:resourcekey="lblRemarResource1"></asp:Label>
            </td>
            <td style="font-weight: normal; color: #000;" runat="server" class="a-left">
                <asp:TextBox ID="txtRemarks" runat="server" MaxLength="900" onBlur="return collapseTextBox(this.id);"
                    onFocus="return expandTextBox(this.id)" TextMode="MultiLine" CssClass="small a-left"></asp:TextBox>
            </td>
        </tr>
        <tr id="mrefdoctors" runat="server">
            <td style="font-weight: normal; color: #000;" runat="server" class="a-left">
                <asp:Label ID="lblRefdoctors" runat="server" Text="Refering Doctor" meta:resourcekey="lblRefdoctorsResource1"></asp:Label>
            </td>
            <td style="font-weight: normal; color: #000;" runat="server" class="a-left">
                <asp:TextBox ID="txtRefdoctors" runat="server" CssClass="small" ReadOnly="true"></asp:TextBox>
                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" TargetControlID="txtRefdoctors"
                    EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetRateCardForBilling"
                    ServicePath="~/OPIPBilling.asmx" OnClientItemSelected="GetReferingPhyID" DelimiterCharacters=""
                    Enabled="True">
                </ajc:AutoCompleteExtender>
                <asp:HiddenField ID="hdnPhysicianValue" runat="server" Value="0"></asp:HiddenField>
            </td>
        </tr>
        <tr id="mrefhospitals" runat="server">
            <td style="font-weight: normal; color: #000;" runat="server" class="a-left">
                <asp:Label ID="lblRefHos" runat="server" Text="Refering Hospital" meta:resourcekey="lblRefHosResource1" ></asp:Label>
            </td>
            <td style="font-weight: normal; color: #000;" runat="server"  class="a-left">
                <asp:TextBox ID="txtrefhospitals" runat="server" CssClass="a-left small" ReadOnly="true"></asp:TextBox>
                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderReferringHospital" runat="server"
                    TargetControlID="txtrefhospitals" EnableCaching="False" FirstRowSelected="True"
                    CompletionInterval="1" MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box"
                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                    ServiceMethod="GetQuickBillRefOrg" ServicePath="~/WebService.asmx" OnClientItemSelected="GetReferingHospID"
                    DelimiterCharacters="" Enabled="True">
                </ajc:AutoCompleteExtender>
                <input id="hdfReferalHospitalID" type="hidden" value="0" runat="server" />
                <input id="hdnhospitalname" runat="server" type="hidden" value="0" />
            </td>
        </tr>
        <tr class="a-center">
            <td colspan="2">
                <asp:Button ID="btnOk" runat="server" Text="Save" CssClass="btn w-70" onmouseover="this.className='btn btnhov'"
                    onmouseout="this.className='btn'"  OnClick="btnsave_Click" Enabled="true"
                    meta:resourcekey="btnOkResource1" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn w-70" onmouseover="this.className='btn btnhov'"
                    onmouseout="this.className='btn'"  meta:resourcekey="btnCancelResource1" />
            </td>
        </tr>
    </table>
    <table id="PatientRem">
        <tr class="td1">
            <td class="a-center">
                <asp:Label ID="PatientRemarks" runat="server" BorderColor="Black" Text="Patient History and Remarks"
                    Font-Bold="True" ForeColor="Black" meta:resourcekey="PatientRemarksResource1"></asp:Label>
            </td>
        </tr>
        <tr class="a-center">
            <td class="a-center">
                <asp:Panel ID="Panel1" runat="server" CssClass="h-100" Width="530px" ScrollBars="Auto"
                    meta:resourcekey="Panel1Resource1">
                    <asp:GridView ID="grdRemarks"  BorderColor="Black" AlternatingRowStyle-BorderWidth="1"
                        HeaderStyle-BorderColor="Black" HeaderStyle-BorderWidth="1" BorderWidth="1" 
                        runat="server" AutoGenerateColumns="false" GridLines="Both" CellSpacing="2" AlternatingRowStyle-BorderColor="Black"
                        CellPadding="1" CssClass="sGrid gridView w-100p h-100p" EmptyDataText="No Remarks"  meta:resourcekey="grdRemarksResource1">
                        <Columns>
                           <asp:TemplateField HeaderText="History" meta:resourcekey="TemplateFieldResource7"
                                SortExpression="SampleDesc">
                                <ItemTemplate>
                                       <asp:Label ID="lblPatientHistory" runat="server" meta:resourcekey="lblRegistrationRemarksResource1"
                                        Text='<%# Bind("PatientHistory") %>'></asp:Label>
                               </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remarks" meta:resourcekey="TemplateFieldResource1"
                                SortExpression="SampleDesc">
                                <ItemTemplate>
                                    <asp:Label ID="lblRegistrationRemarks" runat="server" meta:resourcekey="lblRegistrationRemarksResource1"
                                        Text='<%# Bind("RegistrationRemarks") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="User Name" meta:resourcekey="TemplateFieldResource2"
                                SortExpression="SampleDesc">
                                <ItemTemplate>
                                    <asp:Label ID="lblRegistrationRemarks1" runat="server" meta:resourcekey="lblRegistrationRemarks1Resource1"
                                        Text='<%# Bind("IsDayCare") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Time" meta:resourcekey="TemplateFieldResource3" SortExpression="SampleDesc">
                                <ItemTemplate>
                                    <asp:Label ID="lblRegistrationRemarks2" runat="server" meta:resourcekey="lblRegistrationRemarks2Resource1"
                                        Text='<%# Bind("createdAt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Panel>
<asp:Panel ID="pnlPatientDet2" runat="server" Width="550px" CssClass="modalPopup dataheaderPopup"
    Style="display: none" meta:resourcekey="pnlPatientDetResource1">
    <table>
        <tr>
            <td class="a-center">
                <asp:Label ID="lblRemark" runat="server" Text="Patient History and Remarks" Font-Bold="True"
                    ForeColor="Black" meta:resourcekey="lblRemarkResource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="a-center">
                <asp:Panel ID="Panel2" runat="server" CssClass="h-100" Width="530px" ScrollBars="Auto"
                    meta:resourcekey="Panel2Resource1">
                    <asp:GridView ID="grdRemarks1"  BorderColor="Black" BorderWidth="1"
                         runat="server" AutoGenerateColumns="false" GridLines="Both" CellSpacing="2"
                        AlternatingRowStyle-BorderColor="Black" CellPadding="1" HeaderStyle-BorderWidth="1"
                        HeaderStyle-BorderColor="Black" CssClass="sGrid gridView w-100p h-100p" meta:resourcekey="grdRemarks1Resource1">
                        <Columns>
                            <asp:TemplateField HeaderText="History" meta:resourcekey="TemplateFieldResource7"
                                SortExpression="SampleDesc">
                                <ItemTemplate>
                                       <asp:Label ID="lblPatientHistory" runat="server" meta:resourcekey="lblRegistrationRemarksResource1"
                                        Text='<%# Bind("PatientHistory") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remarks" meta:resourcekey="TemplateFieldResource4"
                                SortExpression="SampleDesc">
                                <ItemTemplate>
                                    <asp:Label ID="lblRegistrationRemarks" runat="server" meta:resourcekey="lblRegistrationRemarksResource2"
                                        Text='<%# Bind("RegistrationRemarks") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="User Name" meta:resourcekey="TemplateFieldResource5"
                                SortExpression="SampleDesc">
                                <ItemTemplate>
                                    <asp:Label ID="lblRegistrationRemarks1" runat="server" meta:resourcekey="lblRegistrationRemarks1Resource2"
                                        Text='<%# Bind("IsDayCare") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Time" meta:resourcekey="TemplateFieldResource6" SortExpression="SampleDesc">
                                <ItemTemplate>
                                    <asp:Label ID="lblRegistrationRemarks2" runat="server" meta:resourcekey="lblRegistrationRemarks2Resource2"
                                        Text='<%# Bind("createdAt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </td>
        </tr>
        <tr class="a-center">
            <td>
                <asp:Button ID="btnclose" runat="server" Text="Close" CssClass="w-70" meta:resourcekey="btncloseResource1" />
            </td>
        </tr>
    </table>
</asp:Panel>
<ajc:ModalPopupExtender ID="mpePatternSelection" runat="server" TargetControlID="imgchanges"
    PopupControlID="pnlPatientDet" BackgroundCssClass="modalBackground" CancelControlID="btnCancel"
    DynamicServicePath="" Enabled="True" />
<ajc:ModalPopupExtender ID="mpeShowRemarks" BehaviorID="RemShow" runat="server" TargetControlID="imgchanges2"
    PopupControlID="pnlPatientDet2" BackgroundCssClass="modalBackground" CancelControlID="btnclose"
    DynamicServicePath="" Enabled="True" />
<%-- </ContentTemplate>--%>
<triggers>
            <asp:PostBackTrigger ControlID="btnOk" />
            <%--<asp:  ControlID="btnOk" EventName="btnsave_Click" />--%>
        </triggers>
<%--    </asp:UpdatePanel>
</asp:Panel>
--%>
<asp:HiddenField ID="HiddenField1" runat="server" Value="Male" />
<asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
<asp:HiddenField ID="hdnVID" runat="server" Value="0" />
<asp:HiddenField ID="hdnIsMapped" runat="server" Value="N" />
<asp:HiddenField ID="hdnIsWaters" runat="server" Value="" />
<asp:HiddenField ID="hdnVisitID" runat="server" Value="" />

<script type="text/javascript">

    var datadiv_tooltip = false;
    var datadiv_tooltipShadow = false;
    var datadiv_shadowSize = 4;
    var datadiv_tooltipMaxWidth = 200;
    var datadiv_tooltipMinWidth = 100;
    var datadiv_iframe = false;
    var tooltip_is_msie = (navigator.userAgent.indexOf('MSIE') >= 0 && navigator.userAgent.indexOf('opera') == -1 && document.all) ? true : false;
    function showTooltip(e, tooltipTxt) {

        var bodyWidth = Math.max(document.body.clientWidth, document.documentElement.clientWidth) - 20;

        if (!datadiv_tooltip) {
            datadiv_tooltip = document.createElement('DIV');
            datadiv_tooltip.id = 'datadiv_tooltip';
            datadiv_tooltipShadow = document.createElement('DIV');
            datadiv_tooltipShadow.id = 'datadiv_tooltipShadow';

            document.body.appendChild(datadiv_tooltip);
            document.body.appendChild(datadiv_tooltipShadow);

            if (tooltip_is_msie) {
                datadiv_iframe = document.createElement('IFRAME');
                datadiv_iframe.frameborder = '5';
                datadiv_iframe.style.backgroundColor = '#FFFFFF';
                datadiv_iframe.src = '#';
                datadiv_iframe.style.zIndex = 100;
                datadiv_iframe.style.position = 'absolute';
                document.body.appendChild(datadiv_iframe);
            }

        }

        datadiv_tooltip.style.display = 'block';
        datadiv_tooltipShadow.style.display = 'block';
        if (tooltip_is_msie) datadiv_iframe.style.display = 'block';

        var st = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        if (navigator.userAgent.toLowerCase().indexOf('safari') >= 0) st = 0;
        var leftPos = e.clientX + 10;

        datadiv_tooltip.style.width = null; // Reset style width if it's set 
        datadiv_tooltip.innerHTML = tooltipTxt;
        datadiv_tooltip.style.left = leftPos + 'px';
        datadiv_tooltip.style.top = e.clientY + 10 + st + 'px';


        datadiv_tooltipShadow.style.left = leftPos + datadiv_shadowSize + 'px';
        datadiv_tooltipShadow.style.top = e.clientY + 10 + st + datadiv_shadowSize + 'px';

        if (datadiv_tooltip.offsetWidth > datadiv_tooltipMaxWidth) {	/* Exceeding max width of tooltip ? */
            datadiv_tooltip.style.width = datadiv_tooltipMaxWidth + 'px';
        }

        var tooltipWidth = datadiv_tooltip.offsetWidth;
        if (tooltipWidth < datadiv_tooltipMinWidth) tooltipWidth = datadiv_tooltipMinWidth;


        datadiv_tooltip.style.width = tooltipWidth + 'px';
        datadiv_tooltipShadow.style.width = datadiv_tooltip.offsetWidth + 'px';
        datadiv_tooltipShadow.style.height = datadiv_tooltip.offsetHeight + 'px';

        if ((leftPos + tooltipWidth) > bodyWidth) {
            datadiv_tooltip.style.left = (datadiv_tooltipShadow.style.left.replace('px', '') - ((leftPos + tooltipWidth) - bodyWidth)) + 'px';
            datadiv_tooltipShadow.style.left = (datadiv_tooltipShadow.style.left.replace('px', '') - ((leftPos + tooltipWidth) - bodyWidth) + datadiv_shadowSize) + 'px';
        }

        if (tooltip_is_msie) {
            datadiv_iframe.style.left = datadiv_tooltip.style.left;
            datadiv_iframe.style.top = datadiv_tooltip.style.top;
            datadiv_iframe.style.width = datadiv_tooltip.offsetWidth + 'px';
            datadiv_iframe.style.height = datadiv_tooltip.offsetHeight + 'px';
        }
    }

    function hideTooltip() {
        datadiv_tooltip.style.display = 'none';
        datadiv_tooltipShadow.style.display = 'none';
        if (tooltip_is_msie) datadiv_iframe.style.display = 'none';
    }
    function expandTextBox(id) {
        // //debugger;
        document.getElementById(id).rows = "5";
        document.getElementById(id).cols = "20";
        //ConverttoUpperCase(id);
        $('textarea').focus(function() {
            $(this).addClass("focus");
        });

    }
    function collapseTextBox(id) {

        document.getElementById(id).rows = "1";
        document.getElementById(id).cols = "20";
        //ConverttoUpperCase(id);
        $('textarea').blur(function() {
            $(this).removeClass("focus");
        });

    }
    function ConverttoUpperCase(id) {
        var lowerCase = document.getElementById(id).value;
        var upperCase = lowerCase.toUpperCase();
        document.getElementById(id).value = upperCase;
    }
    $(document).ready(function() {
        $('INPUT[type="text"]').focus(function() {
            $(this).addClass("focus");
        });

        $('INPUT[type="text"]').blur(function() {
            $(this).removeClass("focus");
        });
    });

    function GetReferingHospID(source, eventArgs) {
        document.getElementById('<%=txtrefhospitals.ClientID %>').value = eventArgs.get_text();
        document.getElementById('<%=hdnhospitalname.ClientID %>').value = eventArgs.get_text();
        var refHospID = eventArgs.get_value();
        document.getElementById('<%=hdfReferalHospitalID.ClientID %>').value = refHospID;
    }
    function GetReferingPhyID(source, eventArgs) {
        document.getElementById('<%=txtRefdoctors.ClientID %>').value = eventArgs.get_text();
        document.getElementById('<%=hdnPhysicianValue.ClientID %>').value = eventArgs.get_value();
        var refPhyValue = eventArgs.get_value().split('^');
        document.getElementById('<%=hdnPhysicianValue.ClientID %>').value = refPhyValue[1];
    }
        
</script>

