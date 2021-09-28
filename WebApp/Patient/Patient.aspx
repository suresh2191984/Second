<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Patient.aspx.cs" Inherits="Masters_Patient" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>*+ATTUNE+* Patient Home</title>

    <script src="../Scripts/Common.js" type="text/javascript"></script>
         <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
   <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <%--<link href="../../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../../StyleSheets/UserStyle.css" rel="stylesheet" type="text/css" />
</head>
<body id="oneColLayout" onContextMenu="return false;">
    <form id="form1" runat="server" defaultbutton="btnFinish"><asp:ScriptManager ID="ScriptManager2" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="title">
                <table width="100%" height="36" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td height="36" style="width: 12px">
                            <img src="../../../Images/header_left.png" alt="header" width="12" height="36">
                        </td>
                        <td width="984" class="main_title" style="background-image: url(../Images1/header.png)">
                            <asp:Label ID="Rs_GraceHospital" Text="Grace Hospital" runat="server" 
                                meta:resourcekey="Rs_GraceHospitalResource1"></asp:Label>
                        </td>
                        <td width="12">
                            <img src="../Images1/header_right.png" alt="header_right" width="12" height="36">
                        </td>
                    </tr>
                </table>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </div>
            <div class="details">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="background-image: url(../Images1/details.png)">
                    <tr>
                        <td width="13">
                            <img src="../Images1/details_left.png" alt="left" width="13" height="54">
                        </td>
                        <td width="51" align="center" valign="middle">
                            <img src="../Images1/sample_image.png" alt="sample image" width="42" height="42">
                        </td>
                        <td width="604" valign="middle">
                            <ul>
                                <li class="details_label" style="background-image: url(../Images1/label1.png)">Name</li>
                                <li >D.Suresh Kumar Ranjan</li>
                                <li class="details_label1" style="background-image: url(../Images1/label2.png)">Age</li>
                                <li >32</li>
                                <li class="details_label2" style="background-image: url(../Images1/label3.png)">Hospital
                                    No:</li>
                                <li >100010123</li>
                                <li class="details_label1" style="background-image: url(../Images1/label2.png)">Role</li>
                                <li >Out Patient</li>
                            </ul>
                            <div class="more_details">
                               <asp:Label  ID="Rs_Moredetailscanbeaddedhere" 
                                    Text="More details can be added here" runat="server" 
                                    meta:resourcekey="Rs_MoredetailscanbeaddedhereResource1"></asp:Label>
                            </div>
                        </td>
                        <td width="100" align="center" valign="middle">
                            <img src="../Images1/case_summary.png" alt="case summary" width="100" height="45">
                        </td>
                        <td width="225">
                            <ul class="casesummary">
                                <li class="casesummary">Antrostomy Done<strong> (12-03-2008)</strong></li>
                                <li class="casesummary">Appendectomy Done (12-03-2008)</li>
                                <li class="casesummary">Show All&nbsp; </li>
                            </ul>
                        </td>
                        <td width="12">
                            <img src="../Images1/details_right.png" alt="right" width="13" height="54">
                        </td>
                    </tr>
                </table>
            </div>
            
        </div>
        <div id="primaryContent" style="width: 1000px">
            <div id="maincontent" style="background-position: 500% 50%; background-repeat: repeat;
                background-color: #e8e8e8; width: 1004px;">
                <div class="Previsit" style="background-image: url(../Images1/box_menu_bg.png)">
                    <h1 style="background-image: url(../Images1/previous_visit.png)">
                    </h1>
                    <ul>
                        <li class="boxmenu">Last Week (12-09-07)</li>
                        <li class="boxmenu">Last Month (04-08-07)</li>
                        <li class="boxmenu">Followup 3 (18-01-07)</li>
                        <li class="boxmenu">Events Chart</li>
                    </ul>
                </div>
                <div class="Report" style="background-image: url(../Images1/box_menu_bg.png)">
                    <h1 style="background-image: url(../Images1/reports.png)">
                    </h1>
                    <ul>
                        <li class="boxmenu">Echo Report (18-01-07)</li>
                        <li class="boxmenu">CT Coronary Report</li>
                        <li class="boxmenu">Chest X Ray 912-03-07</li>
                    </ul>
                </div>
                <div class="outreport" style="background-image: url(../Images1/box_menu_bg.png)">
                    <h1 style="background-image: url(../Images1/outreports.png)">
                    </h1>
                    <ul>
                        <li class="boxmenu">Current Problems</li>
                        <li class="boxmenu">CT Coronary Report</li>
                        <li class="boxmenu">Other Reports</li>
                    </ul>
                    <%--</div>

<div class="data" style="background-image: url(../../../Images/patient_bg.png); height: 449px;">
<h1 style="background-image: url(../../../Images/patient_details.png)">
<ul>
<li class="patientdetailslist">
</li>
<li class="patientdetailslist">
</li>

<li class="patientdetailslist">
</li>
</ul>
<ul>
</h1>
    <table  cellpadding="1" cellspacing="1" style="width: 569px; left: 14px; position: relative; top: 0px;">
        <tr>
            <td style="width: 253px; height: 38px;">
                Name</td>
            <td style="width: 80px; height: 38px;">
                <table>
                    <tr>
                        <td style="width: 50px">
                            <asp:DropDownList ID="ddSalutation" runat="server" Width="46px">
                            </asp:DropDownList></td>
                        <td style="width: 100px">
                            <asp:TextBox ID="txtForename" runat="server" MaxLength="50" TabIndex="1" Width="105px"></asp:TextBox></td>
                    </tr>
                </table>
            </td>
            <td style="width: 72px; height: 38px;">
                Patient Code</td>
            <td style="width: 109px; height: 38px;">
                <asp:TextBox ID="txtPatientCode" runat="server" MaxLength="50" ReadOnly="True" TabIndex="2"></asp:TextBox></td>
            <td style="width: 100px; height: 38px">
            </td>
        </tr>
        <tr>
            <td style="width: 253px">
                Sur Name</td>
            <td style="width: 80px">
                <asp:TextBox ID="txtName" runat="server" MaxLength="50" TabIndex="3"></asp:TextBox></td>
            <td style="width: 72px">
                Middle Name</td>
            <td style="width: 109px">
                <asp:TextBox ID="txtMiddleName" runat="server" MaxLength="50" TabIndex="4"></asp:TextBox></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 253px">
                DOB</td>
            <td style="width: 80px">
                &nbsp; &nbsp;<br />
                <asp:TextBox ID="DateTextBoxDOB" runat="server" TabIndex="5" onPaste="Paste_Event()" onbeforepaste="BeforePaste_Event()" onblur="countAge()" ReadOnly="True"></asp:TextBox>
                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupPosition="TopLeft"
                    TargetControlID="DateTextBoxDOB">
                </cc1:CalendarExtender>
            </td>
            <td style="width: 72px">
                Age</td>
            <td align="left" style="width: 109px" valign="middle">
                &nbsp;&nbsp;
                <asp:TextBox ID="txtAge" runat="server" MaxLength="3" Style="left: -1px;
                    position: relative; top: -10px" TabIndex="8" onPaste="Paste_Event()" onbeforepaste="BeforePaste_Event()"></asp:TextBox></td>
            <td align="left" style="width: 100px" valign="middle">
            </td>
        </tr>
        <tr>
            <td style="width: 253px">
                Occupation</td>
            <td style="width: 80px">
                <asp:TextBox ID="txtOccupation" runat="server" MaxLength="20" Style="position: relative"
                    TabIndex="9"></asp:TextBox></td>
            <td style="width: 72px">
                Marital Status</td>
            <td style="width: 109px">
                <asp:DropDownList ID="ddMarital" runat="server" Style="position: relative" TabIndex="10"
                    Width="90px">
                    <asp:ListItem Selected="True">Select</asp:ListItem>
                    <asp:ListItem>Single</asp:ListItem>
                    <asp:ListItem>Married</asp:ListItem>
                    <asp:ListItem>Divorced</asp:ListItem>
                </asp:DropDownList></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 253px; height: 24px;">
                Religion</td>
            <td style="width: 80px; height: 24px;">
                <asp:TextBox ID="txtReligion" runat="server" MaxLength="25" Style="position: relative"
                    TabIndex="11"></asp:TextBox></td>
            <td style="width: 72px; height: 24px;">
                Blood Group</td>
            <td style="width: 109px; height: 24px;">
                <asp:DropDownList ID="ddBloodGrp" runat="server" Style="position: relative" TabIndex="12"
                    Width="90px">
                    <asp:ListItem>Select</asp:ListItem>
                    <asp:ListItem>A1</asp:ListItem>
                    <asp:ListItem>A1+</asp:ListItem>
                    <asp:ListItem>A+</asp:ListItem>
                    <asp:ListItem>A-</asp:ListItem>
                    <asp:ListItem>B+</asp:ListItem>
                    <asp:ListItem Value="B-"></asp:ListItem>
                    <asp:ListItem>o</asp:ListItem>
                </asp:DropDownList></td>
            <td style="width: 100px; height: 24px;">
            </td>
        </tr>
        <tr>
            <td style="width: 253px">
                Spouse/Father Name
            </td>
            <td style="width: 80px">
                <asp:TextBox ID="txtRelation" runat="server" MaxLength="50" Style="position: relative"
                    TabIndex="13"></asp:TextBox></td>
            <td style="width: 72px">
                Sex</td>
            <td style="width: 109px">
                <asp:DropDownList ID="ddSex" runat="server" Style="position: relative" TabIndex="14"
                    Width="90px">
                    <asp:ListItem>Select</asp:ListItem>
                    <asp:ListItem>Male</asp:ListItem>
                    <asp:ListItem>Female</asp:ListItem>
                    <asp:ListItem>Others</asp:ListItem>
                </asp:DropDownList></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 253px; height: 34px;">
                Place Of Birth</td>
            <td style="width: 80px; height: 34px;">
                <asp:TextBox ID="txtPlaceOfBirth" runat="server" MaxLength="30" Style="position: relative"
                    TabIndex="15"></asp:TextBox></td>
            <td style="width: 72px; height: 34px;">
            </td>
            <td style="width: 109px; height: 34px;">
            </td>
            <td style="width: 100px; height: 34px">
            </td>
        </tr>
        <tr>
            <td style="width: 253px; height: 24px">
                Address1</td>
            <td style="width: 80px; height: 24px">
                <asp:TextBox ID="txtAddr1" runat="server" MaxLength="60" TabIndex="16"></asp:TextBox></td>
            <td style="width: 72px; height: 24px">
                Address2</td>
            <td style="width: 109px; height: 24px">
                <asp:TextBox ID="txtAddr2" runat="server" MaxLength="60" TabIndex="17"></asp:TextBox></td>
            <td style="width: 100px; height: 24px">
            </td>
        </tr>
        <tr>
            <td style="width: 253px; height: 24px">
                Address3</td>
            <td style="width: 80px; height: 24px">
                <asp:TextBox ID="txtAddr3" runat="server" MaxLength="60" TabIndex="18"></asp:TextBox></td>
            <td style="width: 72px; height: 24px">
                Postal Code</td>
            <td style="width: 109px; height: 24px">
                <asp:TextBox ID="txtPostalcode" runat="server" MaxLength="6" onbeforepaste="BeforePaste_Event()"
                    onpaste="Paste_Event()" TabIndex="19"></asp:TextBox></td>
            <td style="width: 100px; height: 24px">
            </td>
        </tr>
        <tr>
            <td style="width: 253px; height: 15px">
                Telephone</td>
            <td style="width: 80px; height: 15px">
                <asp:TextBox ID="txtTelephone" runat="server" MaxLength="15" onbeforepaste="BeforePaste_Event()"
                       onkeypress="return ValidateOnlyNumeric(this);"   onpaste="Paste_Event()" TabIndex="20"></asp:TextBox></td>
            <td style="width: 72px; height: 15px">
                City</td>
            <td style="width: 109px; height: 15px">
                <asp:TextBox ID="txtCity" runat="server" MaxLength="25" TabIndex="21"></asp:TextBox></td>
            <td style="width: 100px; height: 15px">
            </td>
        </tr>
        <tr>
            <td style="width: 253px; height: 24px">
                Country</td>
            <td style="width: 80px; height: 24px">
                <asp:DropDownList ID="ddCountry" runat="server" AutoPostBack="True" 
                    TabIndex="22" Width="158px" OnSelectedIndexChanged="ddCountry_SelectedIndexChanged">
                </asp:DropDownList></td>
            <td style="width: 72px; height: 24px" align="left">
                State</td>
            <td style="width: 109px; height: 24px">
                <asp:UpdatePanel id="UpdatePanel1" runat="server">
                    <contenttemplate>
<asp:DropDownList id="ddState" runat="server"></asp:DropDownList>
</contenttemplate>
                    <triggers>
<asp:AsyncPostBackTrigger ControlID="ddCountry" EventName="SelectedIndexChanged"></asp:AsyncPostBackTrigger>
</triggers>
                </asp:UpdatePanel></td>
            <td style="width: 100px; height: 24px">
            </td>
        </tr>
        <tr>
            <td style="width: 253px; height: 24px">
                Comments</td>
            <td style="width: 80px; height: 24px">
                <asp:TextBox ID="txtComments" runat="server" TabIndex="24" TextMode="MultiLine"></asp:TextBox></td>
            <td style="width: 72px; height: 24px">
                <asp:CheckBox ID="cbxConfidential" runat="server" TabIndex="25" Text="IsConfidential"
                    Width="10px" CssClass="" /></td>
            <td style="width: 109px; height: 24px" align="right">
                <asp:Button ID="btnFinish" runat="server" BackColor="Silver" BorderStyle="Solid"
                    CssClass=".butonProperty"  TabIndex="26" Text="Finish" OnClick="btnFinish_Click" /></td>
            <td align="right" style="width: 100px; height: 24px">
                <asp:Button ID="Button1" runat="server" BackColor="Silver" BorderStyle="Solid" TabIndex="27"
                    Text="Cancel" /></td>
        </tr>
    </table>
    <ul>
    </ul>
    <ul>
    </ul>
    <ul>
    </ul>
    <ul>
    </ul>
</div>
    <asp:Label ID="lblUserName" runat="server" Text="Label" Visible="False"></asp:Label></div>
</div>--%>
                </div>
                <div class="data">
                    <h1>
                        <ul>
                            <li class="dataheader">Form Header</li>
                        </ul>
                    </h1>
                    <table height="105" cellpadding="2" cellspacing="2" class="datatable">
                        <tr class="defaultfontcolor">
                            <td width="25" style="height: 16px">
                            </td>
                            <td align="right"  style="width: 114px; height: 16px">
                               <asp:Label ID="Rs_Title" Text="Title" runat="server" 
                                    meta:resourcekey="Rs_TitleResource1"></asp:Label>
                            </td>
                            <td width="199" align="left" style="height: 16px">
                                <label>
                                    &nbsp;<asp:DropDownList ID="ddSalutation" runat="server"  CssClass ="ddl" 
                                    meta:resourcekey="ddSalutationResource1">
                                    </asp:DropDownList>
                                </label>
                            </td>
                            <td width="21" style="height: 16px">
                            </td>
                            <td width="116" align="right"  style="height: 16px">
                                <asp:Label ID="Rs_SurName" Text="Sur Name" runat="server" 
                                    meta:resourcekey="Rs_SurNameResource1"></asp:Label>
                            </td>
                            <td width="285" align="left" style="height: 16px">
                                <label>
                                    &nbsp;<asp:TextBox ID="txtName" runat="server" MaxLength="50" TabIndex="3" CssClass ="Txtboxsmall"
                                    meta:resourcekey="txtNameResource1"></asp:TextBox></label>
                            </td>
                        </tr>
                        <tr class="defaultfontcolor">
                            <td style="height: 20px">
                            </td>
                            <td align="right"  style="width: 114px; height: 20px">
                                <asp:Label ID="Rs_MiddleName" Text="Middle Name" runat="server" 
                                    meta:resourcekey="Rs_MiddleNameResource1"></asp:Label>
                            </td>
                            <td align="left" style="height: 20px">
                                <label>
                                    &nbsp;<asp:TextBox ID="txtMiddleName" runat="server" MaxLength="50"  CssClass ="Txtboxsmall"
                                    TabIndex="4" meta:resourcekey="txtMiddleNameResource1"></asp:TextBox></label>
                            </td>
                            <td style="height: 20px">
                            </td>
                            <td align="right"  style="height: 20px">
                                <asp:Label ID="Rs_Name" Text="Name" runat="server" 
                                    meta:resourcekey="Rs_NameResource1"></asp:Label>
                            </td>
                            <td align="left" style="height: 20px">
                                <label>
                                    &nbsp;<asp:TextBox ID="txtForeName" runat="server" MaxLength="50"  CssClass ="Txtboxsmall"
                                    TabIndex="3" meta:resourcekey="txtForeNameResource1"></asp:TextBox></label>
                            </td>
                        </tr>
                        <tr class="defaultfontcolor">
                            <td style="height: 20px">
                            </td>
                            <td align="right"  style="width: 114px; height: 20px">
                               <asp:Label ID="Rs_AliasName" Text="Alias Name" runat="server" 
                                    meta:resourcekey="Rs_AliasNameResource1"></asp:Label>
                            </td>
                            <td align="left" style="height: 20px">
                                <asp:TextBox ID="txtAliasName" runat="server" MaxLength="50" TabIndex="4"  CssClass ="Txtboxsmall"
                                    meta:resourcekey="txtAliasNameResource1"></asp:TextBox>
                            </td>
                            <td style="height: 20px">
                            </td>
                            <td align="right"  style="height: 20px">
                               <asp:Label ID="Rs_AlternateContact" Text="Alternate Contact" runat="server" 
                                    meta:resourcekey="Rs_AlternateContactResource1"></asp:Label>
                            </td>
                            <td align="left" style="height: 20px">
                                <asp:TextBox ID="txtAlternamte" runat="server" MaxLength="50" TabIndex="4"  CssClass ="Txtboxsmall"
                                    meta:resourcekey="txtAlternamteResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="defaultfontcolor">
                            <td style="height: 13px">
                            </td>
                            <td align="right" style="width: 114px" >
                                <span><asp:Label ID="Rs_DOB" Text="DOB" runat="server" 
                                    meta:resourcekey="Rs_DOBResource1"></asp:Label></span>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtDOB" runat="server" onbeforepaste="BeforePaste_Event()" onblur="countAge(this)"  CssClass ="Txtboxsmall"
                                    onpaste="Paste_Event()" ReadOnly="True" TabIndex="5"  
                                    meta:resourcekey="txtDOBResource1"></asp:TextBox>
                                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" 
                                    TargetControlID="txtDOB" Enabled="True">
                                </cc1:CalendarExtender>
                                &nbsp;&nbsp;
                            </td>
                            <td style="height: 13px">
                            </td>
                            <td align="right" >
                                <span><asp:Label ID="Rs_Age" Text="Age" runat="server" 
                                    meta:resourcekey="Rs_AgeResource1"></asp:Label></span>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtAge" runat="server"  CssClass ="Txtboxsmall"
                                    meta:resourcekey="txtAgeResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="defaultfontcolor">
                            <td>
                            </td>
                            <td align="right" style="width: 114px" >
                                <span><asp:Label ID="Rs_Occupation" Text="Occupation" runat="server" 
                                    meta:resourcekey="Rs_OccupationResource1"></asp:Label></span>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtOccupation" runat="server" onbeforepaste="BeforePaste_Event()"
                                    onblur="countAge()" onpaste="Paste_Event()" ReadOnly="True" TabIndex="5"   CssClass ="Txtboxsmall"
                                    meta:resourcekey="txtOccupationResource1"></asp:TextBox>
                            </td>
                            <td>
                            </td>
                            <td align="right" >
                                <span><asp:Label ID="Rs_MaritalStatus" Text="Marital Status" runat="server" 
                                    meta:resourcekey="Rs_MaritalStatusResource1"></asp:Label></span>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddMarital" runat="server" Style="position: relative" TabIndex="10"
                                   CssClass ="ddlsmall" meta:resourcekey="ddMaritalResource1">
                                    <asp:ListItem Selected="True" meta:resourcekey="ListItemResource1">Select</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource2">Single</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource3">Married</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource4">Divorced</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr class="defaultfontcolor">
                            <td>
                            </td>
                            <td align="right" style="width: 114px" >
                                <span><asp:Label ID="Rs_Religion" Text="Religion" runat="server" 
                                    meta:resourcekey="Rs_ReligionResource1"></asp:Label></span>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtReligion" runat="server" MaxLength="25" Style="position: relative" CssClass ="Txtboxsmall"
                                    TabIndex="11" meta:resourcekey="txtReligionResource1"></asp:TextBox>
                            </td>
                            <td>
                            </td>
                            <td align="right" >
                                <span><asp:Label ID="Rs_BloodGroup" Text="Blood Group" runat="server" 
                                    meta:resourcekey="Rs_BloodGroupResource1"></asp:Label></span>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddBloodGrp" runat="server" Style="position: relative" TabIndex="12"
                                     CssClass ="ddlsmall" meta:resourcekey="ddBloodGrpResource1">
                                    <asp:ListItem meta:resourcekey="ListItemResource5">Select</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource6">A1</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource7">A1+</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource8">A+</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource9">A-</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource10">B+</asp:ListItem>
                                    <asp:ListItem Value="B-" meta:resourcekey="ListItemResource11"></asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource12">o</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr class="defaultfontcolor">
                            <td>
                            </td>
                            <td align="right" style="width: 114px" >
                                <span></span><span style="color: #000000"><asp:Label ID="Rs_Sex" Text="Sex" 
                                    runat="server" meta:resourcekey="Rs_SexResource1"></asp:Label></span>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddSex" runat="server" Style="position: relative" TabIndex="14"
                                   CssClass ="ddlsmall" meta:resourcekey="ddSexResource1">
                                    <asp:ListItem meta:resourcekey="ListItemResource13">Select</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource14">Male</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource15">Female</asp:ListItem>
                                    <asp:ListItem meta:resourcekey="ListItemResource16">Others</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td align="right" >
                                <span><asp:Label ID  ="Rs_PersonalIdentification" 
                                    Text="Personal Identification" runat="server" 
                                    meta:resourcekey="Rs_PersonalIdentificationResource1"></asp:Label></span>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtPersonal" runat="server" MaxLength="30" Style="position: relative" CssClass ="Txtboxsmall"
                                    TabIndex="15" meta:resourcekey="txtPersonalResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="defaultfontcolor">
                            <td style="height: 24px">
                            </td>
                            <td align="right" style="width: 114px; height: 24px;" >
                                <span><asp:Label ID="Rs_PlaceOfBirth" Text="Place Of Birth" runat="server" 
                                    meta:resourcekey="Rs_PlaceOfBirthResource1"></asp:Label></span>
                            </td>
                            <td align="left" style="height: 24px">
                                <asp:TextBox ID="txtPlaceOfBirth" runat="server" MaxLength="30" Style="position: relative" CssClass ="Txtboxsmall"
                                    TabIndex="15" meta:resourcekey="txtPlaceOfBirthResource1"></asp:TextBox>
                            </td>
                            <td style="height: 24px">
                            </td>
                            <td align="right" style="height: 24px">
                            </td>
                            <td align="left" style="height: 24px">
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="Panel1" runat="server" Height="50px" Width="796px" 
                        meta:resourcekey="Panel1Resource1">
                        <asp:Panel ID="Panel2" runat="server" Height="50px" Width="424px" 
                            meta:resourcekey="Panel2Resource1">
                            <table style="width: 100%">
                                <tr class="defaultfontcolor">
                                    <td style="width: 100px; height: 22px;">
                                        <asp:RadioButton ID="rbtnPermanent" runat="server" Text="Permanent"
                                            AutoPostBack="True" Checked="True" GroupName="Address" 
                                            OnCheckedChanged="rbtnPermanent_CheckedChanged" 
                                            meta:resourcekey="rbtnPermanentResource1" />
                                    </td>
                                    <td style="width: 100px; height: 22px;">
                                        <asp:RadioButton ID="rbtnTemp" runat="server" Text="Current" AutoPostBack="True"
                                            GroupName="Address" OnCheckedChanged="rbtnTemp_CheckedChanged" 
                                            meta:resourcekey="rbtnTempResource1" />
                                    </td>
                                    <td style="width: 100px; height: 22px;">
                                        <asp:RadioButton ID="rbtnAlternate" runat="server" Text="Alternate"
                                            AutoPostBack="True" GroupName="Address" 
                                            OnCheckedChanged="rbtnAlternate_CheckedChanged" 
                                            meta:resourcekey="rbtnAlternateResource1" />
                                    </td>
                                </tr>
                            </table>
                            <div style="z-index: 101; left: 5px; width: 100px; position: absolute; top: 278px;
                                height: 148px">
                                <asp:Panel ID="pnlPermanent" runat="server" Height="50px" Width="125px" 
                                    meta:resourcekey="pnlPermanentResource1">
                                    <uc1:AddressControl ID="PermanentAddress" runat="server" />
                                </asp:Panel>
                                <div style="z-index: 101; left: 2px; width: 100px; position: absolute; top: 5px;
                                    height: 100px">
                                    <asp:Panel ID="pnlTemp" runat="server" Height="50px" Width="125px" 
                                        Visible="False" meta:resourcekey="pnlTempResource1">
                                        <uc1:AddressControl ID="TempAddress" runat="server" />
                                    </asp:Panel>
                                </div>
                                <div style="z-index: 102; left: 0px; width: 100px; position: absolute; top: 3px;
                                    height: 100px">
                                    <asp:Panel ID="pnlAlternate" runat="server" Height="50px" Width="125px" 
                                        Visible="False" meta:resourcekey="pnlAlternateResource1">
                                        <uc1:AddressControl ID="AlternateAddress" runat="server" />
                                    </asp:Panel>
                                </div>
                            </div>
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                            <br />
                        </asp:Panel>
                        <div style="z-index: 102; left: 532px; width: 262px; position: absolute; top: 252px;
                            height: 176px">
                            <asp:Panel ID="Panel3" runat="server" Height="48px" Width="260px" 
                                meta:resourcekey="Panel3Resource1">
                                <table style="width: 100%" class="defaultfontcolor">
                                    <tr>
                                        <td style="width: 100px">
                                            <span><asp:Label ID="Rs_Comments" Text="Comments" runat="server" 
                                                meta:resourcekey="Rs_CommentsResource1"></asp:Label></span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtComments" runat="server" TabIndex="24" TextMode="MultiLine" 
                                                meta:resourcekey="txtCommentsResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:CheckBox ID="cbxConfidential" runat="server" TabIndex="25"
                                                Text="IsConfidential" Width="10px" 
                                                meta:resourcekey="cbxConfidentialResource1" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <br />
                                <br />
                                <br />
                                <br />
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 100px">
                                            <asp:Button ID="btnFinish" runat="server" Text="Finish" 
                                                OnClick="btnFinish_Click1" meta:resourcekey="btnFinishResource1" />
                                        </td>
                                        <td style="width: 100px">
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                                                meta:resourcekey="btnCancelResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                        &nbsp;
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div id="footer" style="height: 27px">
            <table height="27" border="0" cellpadding="0" cellspacing="0" style="background-image: url(../Images1/footer.png)">
                <tr>
                    <td width="13" height="27">
                        <img src="../Images1/footer_left.png" alt="footer" width="13" height="27">
                    </td>
                    <td width="982">
                        <ul>
                            <li class="footer_label1">CCU - 10</li>
                            <li class="footer_value"></li>
                            <li class="footer_value">Dr. Anand GnanaRaj</li>
                            <li class="footer_label2" style="background-image: url(../Images1/footer_logout.png)">
                                <asp:LinkButton ID="lnkLogOut" runat="server" ForeColor="White" 
                                    meta:resourcekey="lnkLogOutResource1">Log Out</asp:LinkButton></li>
                        </ul>
                    </td>
                    <td height="27" style="width: 13px">
                        <img src="../Images1/footer_right.png" alt="footer_right" width="13" height="27">
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
