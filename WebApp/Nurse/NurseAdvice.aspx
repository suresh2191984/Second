<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NurseAdvice.aspx.cs" Inherits="Nurse_NurseAdvice" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/SmallSummary.ascx" TagName="SmallSummary" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/IpDrugEntry.ascx" TagName="Adv" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Profile.ascx" TagName="Profile" TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/PatientVitals.ascx" TagName="PatientVitals" TagPrefix="uc11" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="ucHead" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Drugs Administered</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

	
    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <script type="text/javascript" src="../Scripts/AutoComplete.js"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <script src="../Scripts/actb.js" type="text/javascript"></script>

    <script src="../Scripts/actbcommon.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function avoiddoubleentry() {
            document.getElementById('btnSubmit').style.display = 'none';
        }

        function NewCal1(imgID) {
            var str = imgID.split('_');
            NewCal(str[0] + '_' + str[1] + '_' + 'txtFDate', 'ddmmyyyy', true, 12);
        }
        function NewCal2(imgID) {
            var str = imgID.split('_');
            NewCal(str[0] + '_' + str[1] + '_' + 'txtTDate', 'ddmmyyyy', true, 12);
        }
        function SplitTime(btnID) {
            var str = btnID.split('_');
            var txtT = str[0] + '_' + str[1] + '_' + 'txtTDate';
            var txtF = str[0] + '_' + str[1] + '_' + 'txtFDate';
            document.getElementById(txtT).value = '';
            document.getElementById(txtF).value = '';
            return false;
        }
    </script>

</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server" defaultbutton="btnHideValues">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
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
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <top:topheader id="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata" id="dMain">
                        <ul>
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table width="100%">
                            <tr>
                                <td>
                                    <table width="200px">
                                        <tr>
                                            <td>
                                                <asp:Panel ID="PanelDC2" runat="server" CssClass="collapsePanelHeader" 
                                                    Height="30px" meta:resourcekey="PanelDC2Resource1">
                                                    <div style="cursor: pointer; vertical-align: middle;">
                                                        <div style="float: left; margin-left: 20px; border: 5px;">
                                                            <asp:Label ID="Label1" runat="server" meta:resourcekey="Label1Resource1">(Click to View Drug Chart...)</asp:Label>&nbsp;<asp:ImageButton
                                                                ID="Image1" runat="server" ImageUrl="../Images/collapse.jpg" 
                                                                AlternateText="(Click to View Details...)" meta:resourcekey="Image1Resource1" />
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:Panel ID="PanelDC1" runat="server" CssClass="collapsePanel" Height="0px" 
                                        meta:resourcekey="PanelDC1Resource1">
                                        <asp:GridView ID="grdDrugChart" AutoGenerateColumns="False" runat="server" CellPadding="4"
                                            ForeColor="#333333" CssClass="mytable1" 
                                            OnRowDataBound="grdDrugChart_RowDataBound" 
                                            meta:resourcekey="grdDrugChartResource1">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Drug Name" 
                                                    meta:resourcekey="TemplateFieldResource1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDrugFormulation" runat="server" 
                                                            meta:resourcekey="lblDrugFormulationResource1" 
                                                            Text='<%# Bind("DrugFormulation") %>'></asp:Label>
                                                        <asp:Label ID="lblDrugName" runat="server" 
                                                            meta:resourcekey="lblDrugNameResource1" Text='<%# Bind("DrugName") %>'></asp:Label>
                                                        (
                                                        <asp:Label ID="lblDose" runat="server" meta:resourcekey="lblDoseResource1" 
                                                            Text='<%# Bind("Dose") %>'></asp:Label>
                                                        )
                                                    </ItemTemplate>
                                                    <ItemStyle Width="200px" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ROA" HeaderText="ROA" 
                                                    meta:resourcekey="BoundFieldResource1">
                                                <ItemStyle Width="100px" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Instruction" HeaderText="Instructions" 
                                                    meta:resourcekey="BoundFieldResource2" />
                                                <asp:TemplateField HeaderText="Date Time (From)" 
                                                    meta:resourcekey="TemplateFieldResource2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAdministeredAtFrom" runat="server" 
                                                            meta:resourcekey="lblAdministeredAtFromResource1" 
                                                            Text='<%# Bind("AdministeredAtFrom") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="120px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Date Time (To)" 
                                                    meta:resourcekey="TemplateFieldResource3">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAdministeredAtTo" runat="server" 
                                                            meta:resourcekey="lblAdministeredAtToResource1" 
                                                            Text='<%# Bind("AdministeredAtTo") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="120px" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="NurseName" HeaderText="Given By" 
                                                    meta:resourcekey="BoundFieldResource3" />
                                            </Columns>
                                            <HeaderStyle CssClass="dataheader1" />
                                        </asp:GridView>
                                    </asp:Panel>
                                    <ajc:CollapsiblePanelExtender ID="cpeDemo" runat="Server" TargetControlID="PanelDC1"
                                        ExpandControlID="PanelDC2" CollapseControlID="PanelDC2" TextLabelID="Label1"
                                        ImageControlID="Image1" ExpandedText="(Click to View Drug Chart...)" CollapsedText="(Click to View Drug Chart...)"
                                        ExpandedImage="../Images/collapse.jpg" CollapsedImage="../Images/expand.jpg"
                                        SuppressPostBack="True" SkinID="CollapsiblePanelDemo" Enabled="True" />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <uc7:Adv ID="uAd" runat="server" />
                        <br />
                        <table width="100%">
                            <tr>
                                <td>
                                    <asp:Label ID="lblPrescribedBy" runat="server" 
                                        meta:resourcekey="lblPrescribedByResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <asp:HiddenField ID="hdNewID" runat="server" />
                                            <asp:GridView ID="grdPrescription1" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                                DataKeyNames="PrescriptionID" ForeColor="#333333" CssClass="mytable1"
                                                OnRowCommand="grdPrescription1_RowCommand" 
                                                OnRowDataBound="grdPrescription1_RowDataBound" 
                                                meta:resourcekey="grdPrescription1Resource1">
                                                <HeaderStyle CssClass="dataheader1" />
                                                <Columns>
                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource4">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkSelect" runat="server" 
                                                                meta:resourcekey="chkSelectResource1" />
                                                            <asp:Label ID="lblSno" Visible="False" runat="server" Text='<%# Bind("Sno") %>' 
                                                                meta:resourcekey="lblSnoResource1"></asp:Label>
                                                            <asp:Label ID="lblPrescriptionID" Visible="False" runat="server" 
                                                                Text='<%# Bind("PrescriptionID") %>' 
                                                                meta:resourcekey="lblPrescriptionIDResource1"></asp:Label>
                                                            <asp:Label ID="lblROA" Visible="False" runat="server" Text='<%# Bind("ROA") %>' 
                                                                meta:resourcekey="lblROAResource1"></asp:Label>
                                                            <asp:Label ID="lblDrugFrequency" Visible="False" runat="server" 
                                                                Text='<%# Bind("DrugFrequency") %>' 
                                                                meta:resourcekey="lblDrugFrequencyResource1"></asp:Label>
                                                            <asp:Label ID="lblDuration" Visible="False" runat="server" 
                                                                Text='<%# Bind("Duration") %>' meta:resourcekey="lblDurationResource1"></asp:Label>
                                                            <asp:Label ID="lblInstruction" Visible="False" runat="server" 
                                                                Text='<%# Bind("Instruction") %>' meta:resourcekey="lblInstructionResource1"></asp:Label>
                                                            <asp:Label ID="lblCreatedBy" Visible="False" runat="server" 
                                                                Text='<%# Bind("CreatedBy") %>' meta:resourcekey="lblCreatedByResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="5px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Drug Name" 
                                                        meta:resourcekey="TemplateFieldResource5">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDrugFormulation" Text='<%# Bind("DrugFormulation") %>' 
                                                                runat="server" meta:resourcekey="lblDrugFormulationResource2"></asp:Label>
                                                            <asp:Label ID="lblDrugName" Text='<%# Bind("DrugName") %>' runat="server" 
                                                                meta:resourcekey="lblDrugNameResource2"></asp:Label>
                                                            (
                                                            <asp:Label ID="lblDose" Text='<%# Bind("Dose") %>' runat="server" 
                                                                meta:resourcekey="lblDoseResource2"></asp:Label>
                                                            )
                                                        </ItemTemplate>
                                                        <ItemStyle Width="200px" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="DrugFrequency" HeaderText="FREQ" 
                                                        meta:resourcekey="BoundFieldResource4" >
                                                        <ItemStyle Width="30px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Instruction" HeaderText="Instruction" 
                                                        meta:resourcekey="BoundFieldResource5" >
                                                        <ItemStyle Width="100px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Duration" HeaderText="Duration" 
                                                        meta:resourcekey="BoundFieldResource6" >
                                                        <ItemStyle Width="60px" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="DateTime" 
                                                        meta:resourcekey="TemplateFieldResource6">
                                                        <ItemTemplate>
                                                            <asp:TextBox runat="server" ID="txtFDate" Text='<%# Bind("AdministeredAtFrom") %>'
                                                                DataFormatString="{0:dd-MM-yyyy hh:mm:ss tt}" MaxLength="25" Width="80px" 
                                                                meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                            <asp:Image src="../Images/Calendar_scheduleHS.png" ID="imgFDate" onclick="javascript:NewCal1(this.id);"
                                                                Width="16px" Height="16px" border="0" runat="server" 
                                                                meta:resourcekey="imgFDateResource1" />
                                                        </ItemTemplate>
                                                        <ItemStyle Width="110px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="To DateTime" 
                                                        meta:resourcekey="TemplateFieldResource7">
                                                        <ItemTemplate>
                                                            <asp:TextBox runat="server" ID="txtTDate" Text='<%# Bind("AdministeredAtTo") %>'
                                                                DataFormatString="{0:dd-MM-yyyy hh:mm:ss tt}" MaxLength="25" Width="80px" 
                                                                meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                            <asp:Image src="../Images/Calendar_scheduleHS.png" ID="imgTDate" onclick="javascript:NewCal2(this.id);"
                                                                Width="16px" Height="16px" border="0" runat="server" 
                                                                meta:resourcekey="imgTDateResource1" />
                                                        </ItemTemplate>
                                                        <ItemStyle Width="110px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource8">
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnAdd" runat="server" Text="ADD" class="btn" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" CommandName="Add" 
                                                                CommandArgument='<%# Bind("Sno") %>' meta:resourcekey="btnAddResource1" />
                                                        </ItemTemplate>
                                                        <ItemStyle Width="25px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource9">
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnStop" runat="server" Text="STOP" class="btn" onmouseout="this.className='btn'"
                                                                onmouseover="this.className='btn btnhov'" CommandName="Stop" 
                                                                CommandArgument='<%# Bind("PrescriptionID") %>' 
                                                                meta:resourcekey="btnStopResource1" />
                                                        </ItemTemplate>
                                                        <ItemStyle Width="25px" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <asp:Button ID="btnSave" runat="server" Text="Save" class="btn" onmouseout="this.className='btn'"
                                        onmouseover="this.className='btn btnhov'" OnClick="btnSave_Click" 
                                        meta:resourcekey="btnSaveResource1" />
                                    &nbsp;
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn" onmouseout="this.className='btn'"
                                        onmouseover="this.className='btn btnhov'" OnClick="btnCancel_Click" 
                                        meta:resourcekey="btnCancelResource1" />
                                    &nbsp;
                                    <asp:Button ID="btnStopMedicine" runat="server" Text="Stop" class="btn" onmouseout="this.className='btn'"
                                        onmouseover="this.className='btn btnhov'" OnClick="btnStopMedicine_Click" 
                                        meta:resourcekey="btnStopMedicineResource1" />
                                </td>
                            </tr>
                        </table>
                        <%--<table>
                        <tr>
                        <td>
                        <div style="display:none;" >
                        Review to our OPD after 
                        <asp:DropDownList ID="ddlNumber" runat="server" >
                                <asp:ListItem Text="1"  Value="1" ></asp:ListItem>
                                <asp:ListItem Text="2"  Value="2" ></asp:ListItem>
                                <asp:ListItem Text="3"  Value="3" ></asp:ListItem>
                                <asp:ListItem Text="4"  Value="4" ></asp:ListItem>
                                <asp:ListItem Text="5"  Value="5" Selected="True" ></asp:ListItem>
                                <asp:ListItem Text="6"  Value="6" ></asp:ListItem>
                                <asp:ListItem Text="7"  Value="7" ></asp:ListItem>
                                <asp:ListItem Text="8"  Value="8" ></asp:ListItem>
                                <asp:ListItem Text="9"  Value="9" ></asp:ListItem>
                                <asp:ListItem Text="10" Value="10" ></asp:ListItem>
                                <asp:ListItem Text="11" Value="11" ></asp:ListItem>
                        </asp:DropDownList>
                          <asp:DropDownList ID="ddlType" runat="server" >
                                <asp:ListItem Text="Day(s)"  Value="Day(s)" ></asp:ListItem>
                                <asp:ListItem Text="Weeks(s)"  Value="Weeks(s)" ></asp:ListItem>
                                <asp:ListItem Text="Month(s)"  Value="Month(s)" ></asp:ListItem>
                                <asp:ListItem Text="Year(s)"  Value="Year(s)" ></asp:ListItem>
                        </asp:DropDownList> with your medical reports
                            <br />
                            </div>
                        &nbsp;</td>
                        </tr>
                            </table>--%>
                    </div>
                    <%--<div id="DivProfile" style="display: none;" class="rum">
                      <uc6:InvestigationControl ID="InvestigationControl1" runat="server" />
                          <input type="button" value="OK" id="Button1" runat="server" class="btn" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" onclick="ShowProfile('DivProfile')" />
                     <input type="button" id="btnClose" value="Close" class="btn" onclick="ShowProfile('DivProfile')"
                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" /> 
                    </div>--%>
                </td>
            </tr>
        </table>
        <input type="hidden" id="hdHist" value="H" runat="server" />
        <input type="hidden" id="hdExam" value="E" runat="server" />
        <input type="hidden" id="hdnRedirectedBy" runat="server" />
        <input type="hidden" id="hdnRedirectedTo" runat="server" />
        <asp:Label ID="lblRedirectURL" runat="server" Visible="False" 
            meta:resourcekey="lblRedirectURLResource1"></asp:Label>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    <asp:Button ID="btnHideValues" runat="server" OnClientClick="javascript:return false;"
        Style="height: 0px; width: 0px; display: none;" 
        meta:resourcekey="btnHideValuesResource1" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>

<script language="javascript" type="text/javascript">

    function PreSBPKeyPress() {
        var key = window.event.keyCode;
        if ((key != 16) && (key != 4) && (key != 9)) {
            var sVal = document.getElementById('PatientVitalsControl_txtSBP').value;
            var ctrlDBP = document.getElementById('PatientVitalsControl_txtDBP');
            if (sVal.length == 3) {
                ctrlDBP.focus();
            }
        }
    }
</script>

</html>
