<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IPDischargeAdmissionReport.aspx.cs"
    Inherits="Reports_IPDischargeAdmissionReport" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
        <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <link href="../StyleSheets/StyleSheet.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">
        function validateToDate() {

            if (document.getElementById('txtFDate').value == '') {
                alert('Provide / select value for From date');
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                alert('Provide / select value for To date');
                document.getElementById('txtTDate').focus();
                return false;
            }
        }
        function popupprint() {
            var prtContent = document.getElementById('prnReport');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
        function checkAddress(obj) {
            var len = document.forms[0].elements.length;
            document.getElementById('divShowAdd').style.display = "none";
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    if (document.forms[0].elements[i].checked == true && document.forms[0].elements[i].name == obj && document.forms[0].elements[i].value == "1") {
                        document.getElementById('divShowAdd').style.display = "block";
                    }
                }
            }
        }
       
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="RHead" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: None;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="updatePanel2" runat="server">
                            <ContentTemplate>
                                <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="updatePanel2" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter">
                                        </div>
                                        <div align="center" id="processMessage">
                                            <asp:Label ID="Rs_Loading" Text =" Loading..." runat="server" 
                                                meta:resourcekey="Rs_LoadingResource1" ></asp:Label> <br />
                                            <br />
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" 
                                                meta:resourcekey="imgProgressbarResource1" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <table id="tblCollectionOPIP" align="center" width="100%">
                                    <tr>
                                        <td>
                                            <table id="Table1" class="dataheaderWider" width="100%">
                                                <tr>
                                                    <td align="right">
                                                        <asp:Label ID="Rs_FromDate" Text ="From Date :" runat="server" 
                                                            meta:resourcekey="Rs_FromDateResource1" ></asp:Label> 
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtFDate" CssClass ="Txtboxsmall" Width="120px" runat="server" 
                                                            meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                        <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                            PopupButtonID="ImgFDate" Enabled="True" />
                                                        <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                            Mask="99/99/9999" MaskType="Date"
                                                            ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                            CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                            ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" 
                                                            meta:resourcekey="MaskedEditValidator5Resource1" />
                                                    </td>
                                                    <td align="right">
                                                       <asp:Label ID="Rs_ToDate" Text ="To Date :" runat="server" 
                                                            meta:resourcekey="Rs_ToDateResource1" ></asp:Label> 
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtTDate" CssClass ="Txtboxsmall" Width="120px" runat="server" 
                                                            meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                        <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                            PopupButtonID="ImgTDate" Enabled="True" />
                                                        <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" meta:resourcekey="ImgTDateResource1" />
                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                            Mask="99/99/9999" MaskType="Date"
                                                            ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                            CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                            ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" 
                                                            meta:resourcekey="MaskedEditValidator1Resource1" />
                                                    </td>
                                                    <td align="left">
                                                        <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" 
                                                            runat="server" meta:resourcekey="rblVisitTypeResource1">
                                                            <asp:ListItem Text="DISCHARGE" Selected="True" Value="0" 
                                                                meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                            <asp:ListItem Text="ADMISSION" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="2">
                                                        <asp:RadioButtonList ID="RdoSearchOption" RepeatDirection="Horizontal" 
                                                            runat="server" meta:resourcekey="RdoSearchOptionResource1">
                                                            <asp:ListItem Text="Speciality" Selected="True" Value="0" 
                                                                meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                            <asp:ListItem Text="Consultant" Value="1" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td align="left">
                                                        <asp:RadioButtonList ID="rblRptType" RepeatDirection="Horizontal" 
                                                            runat="server" meta:resourcekey="rblRptTypeResource1">
                                                            <asp:ListItem Text="Summary" Selected="True" Value="0" 
                                                                meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                            <asp:ListItem Text="Details" Value="1" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                        <div id="divShowAdd" runat="server" style="display: none;">
                                                            <asp:CheckBox ID="chkShowAddress" Text="Show Address" runat="server" 
                                                                Checked="True" meta:resourcekey="chkShowAddressResource1" />
                                                        </div>
                                                    </td>
                                                    <td align="left">
                                                        <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                            OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                            ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXL_Click" 
                                                            meta:resourcekey="imgBtnXLResource1" />
                                                    </td>
                                                    <td align="left">
                                                     <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " 
                                                        CssClass="details_label_age"  OnClick="lnkBack_Click" 
                                                        meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                       
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <tr>
                                            <td>
                                                <div id="divMoreDetails" runat="server" style="vertical-align: text-top; display: none;
                                                    text-align: left; width: 110px;">
                                                    <div id="divMore1" runat="server" onclick="showResponses('divMore1','divMore2','divMore3',1);"
                                                        style="cursor: pointer; display: block;">
                                                        &nbsp;<img src="../Images/plus.png" alt="Show" />
                                                        <strong> <asp:Label ID="Rs_MoreDetails" Text ="More Details" runat="server" 
                                                            meta:resourcekey="Rs_MoreDetailsResource1" ></asp:Label> </strong>
                                                    </div>
                                                    <div id="divMore2" runat="server" style="cursor: pointer; display: none; cursor: pointer;"
                                                        onclick="showResponses('divMore1','divMore2','divMore3',0);">
                                                        &nbsp;<img src="../Images/minus.png" alt="hide" />
                                                        <strong><asp:Label ID="Rs_MoreDetails1" Text ="More Details" runat="server" 
                                                            meta:resourcekey="Rs_MoreDetails1Resource1" ></asp:Label> </strong>
                                                    </div>
                                                </div>
                                                <table id="divMore3" runat="server" style="display: none;" title="More Details" width="100%">
                                                    <tr id="trSpeciality" runat="server">
                                                        <td align="left" class="dataheaderWider" runat="server">
                                                            <strong><asp:Label ID="Rs_Speciality" Text ="Speciality" runat="server" ></asp:Label></strong>
                                                            <div style="padding-left: 20px;">
                                                                <asp:CheckBoxList ID="cblSpeciality" Width="100%" RepeatColumns="4" runat="server">
                                                                </asp:CheckBoxList>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr id="trConsultant" runat="server">
                                                        <td align="left" class="dataheaderWider" runat="server">
                                                            <strong><asp:Label ID="Rs_Consultant" Text ="Consultant" runat="server" ></asp:Label></strong>
                                                            <div style="padding-left: 20px;">
                                                                <asp:CheckBoxList ID="cblConsultingName" Width="100%" RepeatColumns="4" runat="server">
                                                                </asp:CheckBoxList>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    <tr>
                                        <td>
                                        <div id="div1" runat="server" style="vertical-align: text-top; display: none;
                                                    text-align: left;">
                                                    <div id="div2" runat="server" onclick="showResponses('div2','div3','tblsearch',1);"
                                                        style="cursor: pointer; display: block;">
                                                        &nbsp;<img src="../Images/plus.png" alt="Show" />
                                                        <strong><asp:Label ID="Rs_MoreSearch" 
                                                            Text ="More Search(Ward wise and Speciality wise)" runat="server" 
                                                            meta:resourcekey="Rs_MoreSearchResource1" ></asp:Label></strong>
                                                    </div>
                                                    <div id="div3" runat="server" style="cursor: pointer; display: none; cursor: pointer;"
                                                        onclick="showResponses('div2','div3','tblsearch',0);">
                                                        &nbsp;<img src="../Images/minus.png" alt="hide" />
                                                        <strong><asp:Label ID="Rs_MoreSearch1" 
                                                            Text ="More Search(Ward wise and Speciality wise)" runat="server" 
                                                            meta:resourcekey="Rs_MoreSearch1Resource1" ></asp:Label></strong>
                                                    </div>
                                                </div>
                                                <div id="div31" runat="server" style="cursor: pointer; display: none; cursor: pointer;"
                                                    onclick="showResponses('div2','div31','tblsearch',0);">
                                                    &nbsp;<img src="../Images/minus.png" alt="hide" />
                                                    <strong><asp:Label ID="Rs_MoreSearch2" Text ="More Search" runat="server" 
                                                        meta:resourcekey="Rs_MoreSearch2Resource1" ></asp:Label></strong>
                                                </div>
                                            </div>
                                            <table id="tblsearch" runat="server" style="display: none;" title="More Details"
                                                width="100%">
                                                <tr id="tr1" runat="server">
                                                    <td align="left" class="dataheaderWider" runat="server">
                                                        <strong><asp:Label ID="Rs_ReferingPhysician" Text ="Refering Physician" runat="server" ></asp:Label></strong>
                                                        <div style="padding-left: 20px;">
                                                            <asp:CheckBoxList ID="cblReferingphysician" Width="100%" RepeatColumns="4" runat="server">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr id="trward" runat="server">
                                                    <td align="left" class="dataheaderWider" runat="server">
                                                        <strong><asp:Label ID="Rs_WardName" Text ="Ward Name" runat="server" ></asp:Label></strong>
                                                        <div style="padding-left: 20px;">
                                                            <asp:CheckBoxList ID="cblWardName" Width="100%" RepeatColumns="4" runat="server">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="divPrint" style="display: none;" runat="server">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td align="right" style="padding-right: 10px; color: #000000;">
                                                            <a id="printText" onclick="return popupprint();" runat="server">Print Report</a> 
                                                            &nbsp;&nbsp;
                                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                                ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td id="tdTotalCount" runat="server" align="left" style="padding-left: 10px; color: #000000;">
                                                            <strong><asp:Label ID="Rs_TotalCount" Text ="Total Count :" runat="server" 
                                                                meta:resourcekey="Rs_TotalCountResource1" ></asp:Label>
                                                                <asp:Label ID="lbltTotal" Text="0" runat="server" 
                                                                meta:resourcekey="lbltTotalResource1"></asp:Label></strong>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="prnReport">
                                                    <asp:GridView Width="100%" ID="gvSummary" OnRowDataBound="gvSummary_RowDataBound"
                                                        runat="server" AutoGenerateColumns="False" ForeColor="#333333" 
                                                    CssClass="mytable1" meta:resourcekey="gvSummaryResource1">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="S.No">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Speciality" 
                                                                meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblSpecialityName" runat="server" 
                                                                        meta:resourcekey="lblSpecialityNameResource1"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Consultant" 
                                                                meta:resourcekey="TemplateFieldResource2">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblConsultantName" runat="server" 
                                                                        meta:resourcekey="lblConsultantNameResource1"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="No.Of Count" 
                                                                meta:resourcekey="TemplateFieldResource3">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblTotal" runat="server" meta:resourcekey="lblTotalResource1"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <HeaderStyle CssClass="dataheader1" />
                                                        <RowStyle HorizontalAlign="Left" />
                                                    </asp:GridView>
                                                    <asp:Repeater ID="rptDetails" OnItemDataBound="rptDetails_ItemDataBound" runat="server">
                                                        <ItemTemplate>
                                                            <table width="100%" style="border: 2px solid #ffffff;">
                                                                <tr>
                                                                 <td align="left">
                                                                        <strong style="text-align: right;">
                                                                            <asp:Label ID="lblTotal" Text="0" runat="server" 
                                                                            meta:resourcekey="lblTotalResource2"></asp:Label>  
                                                                            <br />
                                                                            <asp:Label ID="lblMale" Text="0" runat="server" 
                                                                            meta:resourcekey="lblMaleResource1"></asp:Label>  
                                                                            <br />
                                                                            <asp:Label ID="lblFemale" Text="0" runat="server" 
                                                                            meta:resourcekey="lblFemaleResource1"></asp:Label>                                                                        
                                                                        </strong>                                                                            
                                                                    </td>
                                                                    <td align="left"; style="text-align: left;">
                                                                        <strong>
                                                                            <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                                                                        </strong>
                                                                    </td>
                                                                   
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <asp:GridView ID="gvIPCreditMain" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                            ForeColor="#333333" CssClass="mytable1" 
                                                                            OnRowDataBound="gvIPCreditMain_RowDataBound" 
                                                                            meta:resourcekey="gvIPCreditMainResource1">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="PatientNumber" HeaderText="ID" 
                                                                                    meta:resourcekey="BoundFieldResource1" >
                                                                                    <ItemStyle Width="25px" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="IPNumber" HeaderText="IP No" 
                                                                                    meta:resourcekey="BoundFieldResource2" >
                                                                                    <ItemStyle Width="25px" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="PatientName" HeaderText="Name" 
                                                                                    meta:resourcekey="BoundFieldResource3">
                                                                                    <ItemStyle HorizontalAlign="Left" Wrap="False" Width="200px"></ItemStyle>
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="Age" HeaderText="Age/Sex" 
                                                                                    meta:resourcekey="BoundFieldResource4">
                                                                                    <ItemStyle HorizontalAlign="Left" Wrap="False" Width="50px"></ItemStyle>
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="ConsultantName" HeaderText="Consultant" 
                                                                                    meta:resourcekey="BoundFieldResource5" >
                                                                                    <ItemStyle Width="100px" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="SpecialityName" HeaderText="Speciality" 
                                                                                    meta:resourcekey="BoundFieldResource6" >
                                                                                    <ItemStyle Width="100px" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="BedName" HeaderText="Ward-Room" 
                                                                                    meta:resourcekey="BoundFieldResource7" >
                                                                                    <ItemStyle Width="50px" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="DutyDoctor" HeaderText="DutyDoctor" 
                                                                                    meta:resourcekey="BoundFieldResource8" >
                                                                                    <ItemStyle Width="50px" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="DoAdmission" DataFormatString="{0:dd/MM/yyyy}"
                                                                                    HeaderText="DOA" meta:resourcekey="BoundFieldResource9" >
                                                                                    <ItemStyle Width="25px" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="DoDischarge" DataFormatString="{0:dd/MM/yyyy}"
                                                                                    HeaderText="DOD" meta:resourcekey="BoundFieldResource10" >
                                                                                    <ItemStyle Width="25px" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="LengthofStay" HeaderText="LOS" 
                                                                                    meta:resourcekey="BoundFieldResource11" >
                                                                                    <ItemStyle Width="25px" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="ADMDiagnosis" HeaderText="Diagnosis" 
                                                                                    meta:resourcekey="BoundFieldResource12" >
                                                                                    <ItemStyle Width="100px" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="MLCNo" HeaderText="MLC No" 
                                                                                    meta:resourcekey="BoundFieldResource13" >
                                                                                    <ItemStyle Width="100px" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="Address" HeaderText="Address" 
                                                                                    meta:resourcekey="BoundFieldResource14" >
                                                                                    <ItemStyle Width="25px" />
                                                                                </asp:BoundField>
                                                                            </Columns>
                                                                            <HeaderStyle CssClass="dataheader1" />
                                                                        </asp:GridView>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                    <asp:Label ID="lblTotal" runat="server" 
                                                    meta:resourcekey="lblTotalResource3"></asp:Label>
                                                </div>
                                            </td>
                                        </tr>
                                </table>
                                <asp:HiddenField ID="hdnStats" runat="server" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
