<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientSampleRegistration.aspx.cs"
    Inherits="Reception_PatientSampleRegistration" EnableEventValidation="false" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Sample Registration</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        var z;

        function pageLoad() {
            document.getElementById('txtPatientName').focus();
            if (document.getElementById('rdClient').checked) {
                document.getElementById('divClient').style.display = 'block';
                document.getElementById('divPkg').style.display = 'none';
            }
            else if (document.getElementById('rdPackage').checked) {
                document.getElementById('divClient').style.display = 'none';
                document.getElementById('divPkg').style.display = 'block';
            }
            else {
                document.getElementById('divClient').style.display = 'none';
                document.getElementById('divPkg').style.display = 'none';
            }

        }
        function setPhysician() {
            if (document.getElementById('chkPhyOthers').checked) {
                document.getElementById('ddlPhysician').selectedIndex = 0;
                document.getElementById('ddlPhysician').options[0].selected = true;
                document.getElementById('trPhysician').style.display = 'block';
            }
            else {
                document.getElementById('trPhysician').style.display = 'none';
            }
        }
        function SHHospitalAddress() {
            if ((document.getElementById('ddlHospital').value != "0") || (document.getElementById('ddlBranch').value != "0")) {
                if (document.getElementById('chkHospitalAddress').checked) {
                    document.getElementById('divHospitalAddress').style.display = 'block';
                }
                else {
                    document.getElementById('divHospitalAddress').style.display = 'none';
                }
            }
            if (document.getElementById('ddlHospital').value != "0") {
                document.getElementById('divSHAddressCHKBOX').style.display = 'block';
            }

            if (document.getElementById('ddlBranch').value != "0") {
                document.getElementById('divSHAddressCHKBOX').style.display = 'block';
            }
            if (document.getElementById('ddlHospital').value == "0" && document.getElementById('ddlBranch').value == "0") {
                document.getElementById('divSHAddressCHKBOX').style.display = 'none';
            }
        }

        function showHideClientPackage(rdObj) {
            document.getElementById('ddlClients').selectedIndex = 0;
            document.getElementById('ddlClients').options[0].selected = true;
            document.getElementById('ddlPkg').selectedIndex = 0;
            document.getElementById('ddlPkg').options[0].selected = true;
            document.getElementById('ddlCollectionCentre').selectedIndex = 0;
            document.getElementById('ddlCollectionCentre').options[0].selected = true;
            if (rdObj.value == '1') {
                document.getElementById('divClient').style.display = 'block';
                document.getElementById('divPkg').style.display = 'none';
            }
            else if (rdObj.value == '2') {
                document.getElementById('divClient').style.display = 'none';
                document.getElementById('divCollectionCentre').style.display = 'none';
                document.getElementById('divPkg').style.display = 'block';
            }
            //else {
            //    document.getElementById('divClient').style.display = 'none';
            //   document.getElementById('divPkg').style.display = 'none';
            // }

        }

        function showHideClientType(rdObj) {
            document.getElementById('ddlHospital').selectedIndex = 0;
            document.getElementById('ddlHospital').options[0].selected = true;
            document.getElementById('ddlBranch').selectedIndex = 0;
            document.getElementById('ddlBranch').options[0].selected = true;
            document.getElementById('chkHospitalAddress').checked = false;
            document.getElementById('divSHAddressCHKBOX').style.display = 'none';
            document.getElementById('divHospitalAddress').style.display = 'none';
            if (rdObj.value == '1') {
                document.getElementById('CTHospital').style.display = 'block';
                document.getElementById('CTBranch').style.display = 'none';
            }
            else if (rdObj.value == '2') {
                document.getElementById('CTHospital').style.display = 'none';
                document.getElementById('CTBranch').style.display = 'block';
            }
            else {
                document.getElementById('CTHospital').style.display = 'none';
                document.getElementById('CTBranch').style.display = 'none';
            }

        }


        function age() {
            if (document.getElementById('txtAge').value == '') {
                document.getElementById('txtAge').value = '';
            }
        }
        function setClientPackage(x) {
            document.getElementById('ddlCollectionCentre').selectedIndex = 0;
            document.getElementById('ddlCollectionCentre').options[0].selected = true;
            if (x.options[x.selectedIndex].text == 'Collection Centre') {
                document.getElementById('divCollectionCentre').style.display = 'block';
            }
            else {
                document.getElementById('divCollectionCentre').style.display = 'none';

            }
        }
    </script>

</head>
<body onload="pageLoad();" oncontextmenu="return false;">
    <form id="prFrm" runat="server" defaultbutton="btnFinish">
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
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="ReceptionHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
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
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table border="0" cellpadding="2" cellspacing="1" width="100%">
                            <tr>
                                <td height="32">
                                    <table border="0" id="mytable1" cellpadding="4" cellspacing="0" width="100%">
                                        <tr>
                                            <td colspan="5" id="us">
                                                <asp:Label ID="Rs_RegisterthePatientsDetails" Text="Register the Patient's Details"
                                                    runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel1" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="padding-top: 5px;">
                                                    <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td align="right" style="width: 18%;">
                                                                <asp:Label ID="Rs_PatientsName" Text="Patient's Name" runat="server"></asp:Label>
                                                            </td>
                                                            <td style="width: 32%;">
                                                                <asp:DropDownList ID="ddSalutation" ToolTip="Select Salutation" runat="server" Width="54px"
                                                                    TabIndex="1">
                                                                </asp:DropDownList>
                                                                <asp:TextBox ID="txtPatientName" ToolTip="Patient Name" runat="server" MaxLength="60"
                                                                    TabIndex="2"></asp:TextBox>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                            <td align="right" style="width: 20%;">
                                                                <asp:Label ID="Rs_Priority" Text="Priority" runat="server"></asp:Label>
                                                            </td>
                                                            <td style="width: 30%;">
                                                                <asp:DropDownList ID="ddlPriority" ToolTip="Select Work Order Priority" TabIndex="3"
                                                                    runat="server">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" style="width: 18%;">
                                                                <asp:Label ID="Rs_Sex" Text="Sex" runat="server"></asp:Label>
                                                            </td>
                                                            <td style="width: 32%;">
                                                                <asp:DropDownList ID="ddSex" runat="server" TabIndex="4" ToolTip="Select Sex">
                                                                    <asp:ListItem Value="M">Male</asp:ListItem>
                                                                    <asp:ListItem Value="F">Female</asp:ListItem>
                                                                </asp:DropDownList>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                            <td align="right" style="width: 20%;">
                                                                <asp:Label ID="Rs_Age" Text="Age" runat="server"></asp:Label>
                                                            </td>
                                                            <td style="width: 30%;">
                                                                <asp:TextBox ID="txtAge" Width="65px" runat="server" ToolTip="Age" MaxLength="3"
                                                                    TabIndex="5"></asp:TextBox>
                                                                <asp:DropDownList ID="ddlAgeUnit" runat="server" ToolTip="Age Duration">
                                                                    <asp:ListItem Value="Day(s)">Day(s)</asp:ListItem>
                                                                    <asp:ListItem Value="Week(s)">Week(s)</asp:ListItem>
                                                                    <asp:ListItem Value="Month(s)">Month(s)</asp:ListItem>
                                                                    <asp:ListItem Value="Year(s)" Selected="True">Year(s)</asp:ListItem>
                                                                </asp:DropDownList>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-bottom: 2px;">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td>
                                                                <uc8:AddressControl ID="patientAddressCtrl" runat="server" StartIndex="6" />
                                                            </td>
                                                        </tr>
                                                        <tr style="display: none;">
                                                            <td style="width: 16%" align="right">
                                                                <asp:Label ID="Rs_DateofBirth" Text="Date of Birth" runat="server"></asp:Label>
                                                            </td>
                                                            <td class="style4">
                                                                <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB"
                                                                    Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                    OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                                    ErrorTooltipEnabled="True" />
                                                                <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB"
                                                                    PopupButtonID="ImgBntCalc" />
                                                                <asp:TextBox ID="tDOB" runat="server" Width="130px" ToolTip="Date Of Birth" MaxLength="1"
                                                                    Style="text-align: justify" ValidationGroup="MKE" TabIndex="14" />
                                                                <asp:ImageButton ID="ImgBntCalc" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                    CausesValidation="False" />
                                                                <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                    ControlToValidate="tDOB" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                    Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                    ValidationGroup="MKE" />
                                                            </td>
                                                            <td align="right" class="style6">
                                                                <asp:Label ID="Rs_Mobile" Text="Mobile" runat="server"></asp:Label>
                                                            </td>
                                                            <td class="style8">
                                                                <asp:TextBox ID="txtMobile" ToolTip="Mobile Number" runat="server" TabIndex="15"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel3" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td style="padding-top: 1px;">
                                                                <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                                    <tr>
                                                                        <td align="right" style="width: 18%;">
                                                                            <asp:Label ID="Rs_DoctorsName1" Text="Doctor's Name" runat="server"></asp:Label>
                                                                        </td>
                                                                        <td style="width: 62%;">
                                                                            <asp:DropDownList ID="ddlPhysician" ToolTip="Refering Physician(Doctor) Name" Width="300px"
                                                                                runat="server" TabIndex="16">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td style="width: 20%;">
                                                                            <asp:Label ID="Rs_IfOthers" Text="If Others" runat="server"></asp:Label><input type="checkbox"
                                                                                id="chkPhyOthers" tooltip="Other Refering Physician(Doctor)" onclick="javascript:setPhysician();"
                                                                                runat="server" value="1" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="padding-bottom: 3px;">
                                                                <div id="trPhysician" style="display: none;" runat="server">
                                                                    <table border="0" cellpadding="2" cellspacing="0" width="100%">
                                                                        <tr>
                                                                            <td style="width: 15%;" align="right">
                                                                                <asp:Label ID="Rs_DoctorsName" Text="Doctor's Name" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td align="left" style="width: 20%;">
                                                                                <asp:TextBox ID="txtDrName" runat="server" ToolTip="Refering Physician(Doctor) Name"
                                                                                    MaxLength="60"></asp:TextBox>
                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                            </td>
                                                                            <td style="width: 10%;" align="right">
                                                                                <asp:Label ID="Rs_Qualification" Text="Qualification" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td align="left" style="width: 10%;">
                                                                                <asp:TextBox ID="txtDrQualification" ToolTip="Refering Physician(Doctor) Qualification"
                                                                                    runat="server" MaxLength="40" Width="100px"></asp:TextBox>
                                                                            </td>
                                                                            <td style="width: 10%;" align="right">
                                                                                <asp:Label ID="Rs_Organization" Text="Organization" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td align="center" style="width: 10%;">
                                                                                <asp:TextBox ID="txtDrOrganization" ToolTip="Refering Physician(Doctor) Organization"
                                                                                    runat="server" MaxLength="60"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
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
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel7" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td style="width: 35%;">
                                                                <input id="rdoHospital" type="radio" name="clientType" tooltip="Refering Hospital"
                                                                    tabindex="17" checked value="1" onclick="javascript:showHideClientType(this);"
                                                                    runat="server" /><asp:Label ID="Rs_Hospital" Text="Hospital" runat="server"></asp:Label>
                                                                <input id="rdoBranch" tabindex="21" type="radio" name="clientType" value="2" onclick="javascript:showHideClientType(this);"
                                                                    runat="server" tooltip="Refering Branch" /><asp:Label ID="Rs_Branch" Text="Branch"
                                                                        runat="server"></asp:Label>
                                                                <input id="rdOthers" tabindex="27" type="radio" name="clientType" value="3" onclick="javascript:showHideClientType(this);"
                                                                    runat="server" /><asp:Label ID="Rs_Others" Text="Others" runat="server"></asp:Label>
                                                            </td>
                                                            <td style="width: 35%;">
                                                                <div id="CTHospital" runat="server">
                                                                    <asp:DropDownList ID="ddlHospital" ToolTip="Select Refering Hospital" runat="server"
                                                                        TabIndex="18" onchange="javascript:SHHospitalAddress();" Width="250px" OnSelectedIndexChanged="ddlHospital_SelectedIndexChanged"
                                                                        AutoPostBack="true">
                                                                    </asp:DropDownList>
                                                                </div>
                                                                <div id="CTBranch" runat="server" style="display: none;">
                                                                    <asp:DropDownList ID="ddlBranch" runat="server" ToolTip="Select Refering Branch"
                                                                        TabIndex="18" onchange="javascript:SHHospitalAddress();" AutoPostBack="true"
                                                                        OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged">
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </td>
                                                            <td style="width: 20%;">
                                                                <div id="divSHAddressCHKBOX" runat="server" style="display: none;">
                                                                    <asp:Label ID="Rs_ShowAddress" Text="Show Address" runat="server"></asp:Label><input
                                                                        type="checkbox" id="chkHospitalAddress" tooltip="View Refering Hospital / Branch Address"
                                                                        onclick="javascript:SHHospitalAddress();" runat="server" value="1" />
                                                                </div>
                                                            </td>
                                                            <td style="width: 10%;">
                                                                <asp:LinkButton ID="addNewHospital" Visible="false" ToolTip="Add New Refering Hospital"
                                                                    OnClick="addNewHospital_Click" ForeColor="#333" runat="server"><u>Add New</u></asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div style="display: none;" id="divHospitalAddress" runat="server">
                                        <asp:Panel ID="Panel5" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td style="padding-top: 1px;">
                                                        <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td align="right" style="width: 18%;">
                                                                    <asp:Label ID="Rs_Address" Text="Address" runat="server" 
                                                                        meta:resourcekey="Rs_AddressResource1"></asp:Label>
                                                                </td>
                                                                <td style="width: 82%;">
                                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                        <ContentTemplate>
                                                                            <asp:TextBox ID="txtHospitalAddress" runat="server" Columns="50" 
                                                                                meta:resourcekey="txtHospitalAddressResource1" ReadOnly="True" Rows="4" 
                                                                                TextMode="MultiLine" ToolTip="Refering Hospital / Branch"></asp:TextBox>
                                                                            &nbsp; &nbsp;
                                                                        </ContentTemplate>
                                                                        <Triggers>
                                                                            <asp:AsyncPostBackTrigger ControlID="ddlHospital" 
                                                                                EventName="SelectedIndexChanged" />
                                                                            <asp:AsyncPostBackTrigger ControlID="ddlBranch" 
                                                                                EventName="SelectedIndexChanged" />
                                                                        </Triggers>
                                                                    </asp:UpdatePanel>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel6" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="padding: 3px;">
                                                    <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td style="width: 20%;">
                                                                <input id="rdClient" type="radio" tooltip="Click here to choose Client" name="price"
                                                                    tabindex="19" onclick="javascript:showHideClientPackage(this);" runat="server"
                                                                    checked value="1" /><asp:Label ID="Rs_Client" Text="Client" runat="server"></asp:Label>
                                                                <input id="rdPackage" tabindex="26" type="radio" tooltip="Click here to choose Package"
                                                                    name="price" value="2" onclick="javascript:showHideClientPackage(this);" runat="server" />Insurance
                                                            </td>
                                                            <td style="width: 20%;">
                                                                <div id="divClient" runat="server">
                                                                    <asp:DropDownList ID="ddlClients" ToolTip="Select Client" OnChange="javascript:setClientPackage(this);"
                                                                        TabIndex="20" runat="server">
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </td>
                                                            <td style="width: 20%;">
                                                                <div id="divPkg" style="display: none" runat="server">
                                                                    <asp:DropDownList ID="ddlPkg" Width="250px" TabIndex="20" ToolTip="Select Insurance"
                                                                        runat="server">
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </td>
                                                            <td style="width: 20%;">
                                                                <div id="divCollectionCentre" style="display: none" runat="server">
                                                                    <asp:DropDownList ID="ddlCollectionCentre" ToolTip="Select Collection Centre" TabIndex="20"
                                                                        runat="server">
                                                                    </asp:DropDownList>
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
                            <tr>
                                <td align="left">
                                    <asp:Panel ID="Panel2" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="padding: 3px;">
                                                    <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td align="right" style="width: 18%;">
                                                                <asp:Label ID="Rs_ResultPublishing" Text="Result Publishing" runat="server"></asp:Label>
                                                            </td>
                                                            <td style="width: 32%;">
                                                                <asp:DropDownList ID="ddPublishingMode" ToolTip="Select Result Publishing Mode" OnChange="SampleRegShowHide();"
                                                                    TabIndex="21" runat="server">
                                                                </asp:DropDownList>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                            <td align="right" style="width: 20%;">
                                                                <asp:Label ID="Rs_email" Text="e-mail" runat="server"></asp:Label>
                                                            </td>
                                                            <td style="width: 30%;">
                                                                <asp:TextBox ID="txtEmailID" ToolTip="Contact E-Mail Address" runat="server" MaxLength="60"
                                                                    TabIndex="22"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div style="display: none;" id="trAddress" runat="server">
                                        <asp:Panel ID="Panel4" CssClass="dataheader2" BorderWidth="1px" runat="server">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td style="padding-top: 5px;">
                                                        <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td align="right" style="width: 18%;">
                                                                    <asp:Label ID="Rs_SameAsAbove" Text="Same As Above" runat="server"></asp:Label>
                                                                </td>
                                                                <td style="width: 82%;">
                                                                    <input type="checkbox" id="chkSameAsAbove" tooltip="Click here to choose same Address as Above"
                                                                        onclick="javascript:SameAsAbove();" runat="server" value="1" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" style="width: 18%;">
                                                                    <asp:Label ID="Rs_Name" Text="Name" runat="server"></asp:Label>
                                                                </td>
                                                                <td style="width: 82%;">
                                                                    <asp:TextBox ID="txtName" ToolTip="Name of the Person to which the Result has to be Sent/Publish"
                                                                        runat="server" MaxLength="60" TabIndex="23"></asp:TextBox>
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="padding-bottom: 2px;">
                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td>
                                                                    <uc8:AddressControl ID="shippingAddress" runat="server" StartIndex="24" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                    <asp:Button ID="btnFinish" runat="server" ToolTip="Click Here To Save & Continue"
                                        OnClientClick="return sampleRegValidation();" OnClick="btnFinish_Click" Text="Next"
                                        CssClass="btn" Style="cursor: pointer;" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" />
                                    <asp:Button ID="btnCancel" runat="server" ToolTip="Click Here To Cancel" Text="Cancel"
                                        OnClick="btnCancel_Click" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        Style="cursor: pointer;" onmouseout="this.className='btn'" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
