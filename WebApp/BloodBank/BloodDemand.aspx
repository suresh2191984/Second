<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BloodDemand.aspx.cs" Inherits="BloodBank_BloodDemand" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Department.ascx" TagName="Department" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Blood Demand</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>

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
        
        function checkAll(obj1) {
            var checkboxCollection = document.getElementById('chklstBloodGroups').getElementsByTagName('input');

            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    checkboxCollection[i].checked = obj1.checked;
                }
            }
        }
        function checkAll1(obj2) {
            var checkboxCollection = document.getElementById('chklstBloodComponents').getElementsByTagName('input');
            
            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    checkboxCollection[i].checked = obj2.checked;
                }
            }
        }
        function ShowOrHideFilters()
        {
            if(document.getElementById('rdoSummary').checked==true)
            {
              document.getElementById('pHeader').collapsed=true;
              document.getElementById('pHeader1').collapsed=true;
              document.getElementById('pHeader').style.display='none';
//              document.getElementById('pBody').style.display='none';
              document.getElementById('pHeader1').style.display='none';
//              document.getElementById('gvSummary').style.display='block';
              if(document.getElementById('gvDetail').style.display=='block')
              {
                 document.getElementById('gvDetail').style.display='none';
              }
              document.getElementById('divHeading').style.display='none';
//              document.getElementById('pBody1').style.display='none';
            }
            else if(document.getElementById('rdoDetail').checked==true)
            {
              document.getElementById('pHeader').style.display='block';
//              document.getElementById('pBody').style.display='block';
              document.getElementById('pHeader1').style.display='block';
              if(document.getElementById('gvSummary').style.display=='block')
              {
                 document.getElementById('gvSummary').style.display='none';
              }
//              document.getElementById('gvDetail').style.display='block';
//              document.getElementById('pBody1').style.display='block';
            }
        }
    </script>

</head>
<body>
    <form id="frmBloodDemand" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
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
                <uc3:Header ID="AdminHeader" runat="server" />
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
                    <table cellpadding="0" cellspacing="0" width="100%" border="0">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="updatePanel1" runat="server">
                            <%-- <Triggers>
                                <asp:PostBackTrigger ControlID="lnkExportXL" />
                                <asp:PostBackTrigger ControlID="imgBtnXL" />
                            </Triggers>--%>
                            <ContentTemplate>
                                <table id="tblCollectionOPIP" align="left" width="100%">
                                    <tr align="left">
                                        <td align="left">
                                            <div class="dataheaderWider">
                                                <table id="tbl">
                                                    <tr>
                                                        <td align="left">
                                                            <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server" meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txtFDate" CssClass="ddlsmall" runat="server" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                            <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                                PopupButtonID="ImgFDate" Enabled="True" />
                                                            <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                Enabled="True" />
                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                        </td>
                                                        <td align="left">
                                                            <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txtTDate" CssClass="ddlsmall" runat="server" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                            <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                                PopupButtonID="ImgTDate" Enabled="True" />
                                                            <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgTDateResource1" />
                                                            <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                                Enabled="True" />
                                                            <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                                ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                        </td>
                                                        <td>
                                                            <asp:RadioButton ID="rdoSummary" Text="Summary" GroupName="Radio" Checked="True"
                                                                OnClick="Javascript:ShowOrHideFilters();" runat="server" 
                                                                meta:resourcekey="rdoSummaryResource1" />
                                                            <asp:RadioButton ID="rdoDetail" Text="Detail" GroupName="Radio" OnClick="Javascript:ShowOrHideFilters();"
                                                                runat="server" meta:resourcekey="rdoDetailResource1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <asp:Panel ID="pHeader" runat="server" Style="display: none" 
                                                                meta:resourcekey="pHeaderResource1">
                                                                <table border="0">
                                                                    <tr>
                                                                        <td class="cpHeader" runat="server" id="tdimg">
                                                                            <asp:Image ID="ImgCollapse" runat="server" 
                                                                                meta:resourcekey="ImgCollapseResource1" />
                                                                            <asp:Label ID="lblText" runat="server" meta:resourcekey="lblTextResource1" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                            <asp:Panel ID="pBody" runat="server" meta:resourcekey="pBodyResource1">
                                                                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:CheckBox ID="ChkboxBloodGroups" Text="ALL" runat="server" CssClass="smallfon"
                                                                            onclick="checkAll(this)" Checked="True" 
                                                                            meta:resourcekey="ChkboxBloodGroupsResource1" />
                                                                        <asp:CheckBoxList ID="chklstBloodGroups" runat="server" RepeatColumns="3" 
                                                                            RepeatDirection="Horizontal" CssClass="smallfon" 
                                                                            meta:resourcekey="chklstBloodGroupsResource1">
                                                                        </asp:CheckBoxList>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                            </asp:Panel>
                                                        </td>
                                                        <td colspan="2">
                                                            <asp:Panel ID="pHeader1" runat="server" Style="display: none" 
                                                                meta:resourcekey="pHeader1Resource1">
                                                                <table border="0">
                                                                    <tr>
                                                                        <td class="cpHeader" runat="server" id="td1">
                                                                            <asp:Image ID="ImgCollapse1" runat="server" 
                                                                                meta:resourcekey="ImgCollapse1Resource1" />
                                                                            <asp:Label ID="lblText1" runat="server" meta:resourcekey="lblText1Resource1" />
                                                                        </td>
                                                                        <td align="right">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                            <asp:Panel ID="pBody1" runat="server" meta:resourcekey="pBody1Resource1">
                                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:CheckBox ID="chkBloodComponents" Text="ALL" runat="server" CssClass="smallfon"
                                                                            onclick="checkAll1(this)" Checked="True" 
                                                                            meta:resourcekey="chkBloodComponentsResource1" />
                                                                        <asp:CheckBoxList ID="chklstBloodComponents" runat="server" RepeatColumns="3" 
                                                                            RepeatDirection="Horizontal" CssClass="smallfon" 
                                                                            meta:resourcekey="chklstBloodComponentsResource1">
                                                                        </asp:CheckBoxList>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            <asp:Button ID="btnSubmit" runat="server" Text="Get Blood Requests" CssClass="btn"
                                                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                                OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                        </td>
                                                        <td align="left">
                                                            <asp:Button ID="btnBack" Text="Back" Font-Underline="True" runat="server" CssClass="btn"
                                                                meta:resourcekey="lnkBackResource1"></asp:Button>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <ajc:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" TargetControlID="pBody"
                                                                CollapseControlID="pHeader" ExpandControlID="pHeader" Collapsed="True" TextLabelID="lblText"
                                                                CollapsedText="Filter Blood groups" ExpandedText="Filter Blood groups" ImageControlID="ImgCollapse"
                                                                ExpandedImage="../Images/ShowBids.gif" 
                                                                CollapsedImage="../Images/HideBids.gif" Enabled="True">
                                                            </ajc:CollapsiblePanelExtender>
                                                        </td>
                                                        <td>
                                                            <ajc:CollapsiblePanelExtender ID="CollapsiblePanelExtender2" runat="server" TargetControlID="pBody1"
                                                                CollapseControlID="pHeader1" ExpandControlID="pHeader1" Collapsed="True" TextLabelID="lblText1"
                                                                CollapsedText="Filter Blood Components" ExpandedText="Filter Blood Components"
                                                                ImageControlID="ImgCollapse1" ExpandedImage="../Images/ShowBids.gif" 
                                                                CollapsedImage="../Images/HideBids.gif" Enabled="True">
                                                            </ajc:CollapsiblePanelExtender>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="updatePanel1" runat="server">
                                                <ProgressTemplate>
                                                    <div id="progressBackgroundFilter">
                                                    </div>
                                                    <div align="center" id="processMessage">
                                                        Please swait...<br />
                                                        <br />
                                                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" 
                                                            meta:resourcekey="imgProgressbarResource1" />
                                                    </div>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                            <div id="divPrint" visible="False" runat="server">
                                                <table cellpadding="0" cellspacing="0" border="0" width="95%">
                                                    <tr>
                                                        <td align="right" style="padding-right: 10px; color: #000000;">
                                                            <b id="printText" runat="server">
                                                                <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                                ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <table cellpadding="0" class="defaultfontcolor" width="100%" style="color: Black;
                                                font-family: Verdana; text-align: left;" cellspacing="1" width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvSummary" runat="server" AutoGenerateColumns="False" Width="100%"
                                                            HorizontalAlign="Right" Font-Names="Verdana" Font-Size="10px" 
                                                            meta:resourcekey="gvSummaryResource1">
                                                            <Columns>
                                                                <asp:BoundField HeaderText="BloodGroup/BloodComponent" 
                                                                    DataField="BloodGroupName" meta:resourcekey="BoundFieldResource1" >
                                                                    <ItemStyle Font-Bold="True" HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:BoundField HeaderText="WholeBlood" DataField="Whole Blood" 
                                                                    meta:resourcekey="BoundFieldResource2" />
                                                                <asp:BoundField HeaderText="Plasma" DataField="Plasma" 
                                                                    meta:resourcekey="BoundFieldResource3" />
                                                                <asp:BoundField HeaderText="Platelet" DataField="Platelet" 
                                                                    meta:resourcekey="BoundFieldResource4" />
                                                                <asp:BoundField HeaderText="Plasma Factors" DataField="Plasma Factors" 
                                                                    meta:resourcekey="BoundFieldResource5" />
                                                                <asp:BoundField HeaderText="Packed Red Cell" DataField="Packed Red Cell" 
                                                                    meta:resourcekey="BoundFieldResource6" />
                                                                <asp:BoundField HeaderText="Leukocyte poor red cells" 
                                                                    DataField="Leukocyte poor red cells" meta:resourcekey="BoundFieldResource7" />
                                                                <asp:BoundField HeaderText="Fresh Frozen Plasma (FFP)" 
                                                                    DataField="Fresh Frozen Plasma (FFP)" meta:resourcekey="BoundFieldResource8" />
                                                                <asp:BoundField HeaderText="Cryoprecipitated anti hemophilic factor" 
                                                                    DataField="Cryoprecipitated anti hemophilic factor" 
                                                                    meta:resourcekey="BoundFieldResource9" />
                                                                <asp:BoundField HeaderText="WBC" DataField="WBC" 
                                                                    meta:resourcekey="BoundFieldResource10" />
                                                                <asp:BoundField HeaderText="Plasma Protein Fraction" 
                                                                    DataField="Plasma Protein Fraction" meta:resourcekey="BoundFieldResource11" />
                                                                <asp:BoundField HeaderText="Albumin" DataField="Albumin" 
                                                                    meta:resourcekey="BoundFieldResource12" />
                                                            </Columns>
                                                            <RowStyle HorizontalAlign="Right" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </table>
                                            <div id="divHeading" style="display:none" runat="server">
                                                <table cellpadding="0" id="tblHeading" class="defaultfontcolor" width="100%" style="color: Black;
                                                    font-family: Verdana; text-align: left;" cellspacing="0">
                                                    <tr id="trHeading" class="dataheader1">
                                                        <td align="center" style="width: 5%">
                                                            <asp:Label ID="Rs_BloodGroup" runat="server" Text="BloodGroup" meta:resourcekey="Rs_BloodGroupResource1"></asp:Label>
                                                        </td>
                                                        <td style="width: 5%" align="left">
                                                            <asp:Label ID="Rs_BloodComponent" runat="server" Text="BloodComponent" meta:resourcekey="Rs_BloodComponentResource1"></asp:Label>
                                                        </td>
                                                        <td style="width: 5%" align="left">
                                                            <asp:Label ID="Rs_NoOfUnits" runat="server" Text="No. Of Units" meta:resourcekey="Rs_NoOfUnitsResource1"></asp:Label>
                                                        </td>
                                                        <td style="width: 5%" align="left">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <table cellpadding="0" class="defaultfontcolor" width="100%" style="color: Black;
                                                font-family: Verdana; text-align: left;" cellspacing="1">
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvDetail" AllowPaging="True" PageSize="11"
                                                            runat="server" AutoGenerateColumns="False" 
                                                            DataKeyNames="BloodGroup,BloodComponent" Width="100%" 
                                                            OnPageIndexChanging="gvDetail_PageIndexChanging" HorizontalAlign="Right" Font-Names="Verdana"
                                                            Font-Size="11px" OnRowCommand="gvDetail_RowCommand" 
                                                            meta:resourcekey="gvDetailResource1">
                                                            <Columns>
                                                                <asp:BoundField DataField="BloodGroup" Visible="False" 
                                                                    meta:resourcekey="BoundFieldResource13" />
                                                                <asp:BoundField DataField="BloodComponent" Visible="False" 
                                                                    meta:resourcekey="BoundFieldResource14" />
                                                                <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                                    <ItemTemplate>
                                                                        <table id="TabChild" runat="server" border="0" width="100%" align="left">
                                                                            <tr id="Tr1" runat="server">
                                                                                <td id="BloodGroup" align="center" style="width: 20%" nowrap="nowrap" runat="server">
                                                                                    <%# DataBinder.Eval(Container.DataItem, "BloodGroupName")%>
                                                                                </td>
                                                                                <td id="BloodComponent" align="left" style="width: 20%" nowrap="nowrap" runat="server">
                                                                                    <%# DataBinder.Eval(Container.DataItem, "BloodComponentName")%>
                                                                                </td>
                                                                                <td id="NoOfUnits" align="left" style="width: 20%" nowrap="nowrap" runat="server">
                                                                                    <%# DataBinder.Eval(Container.DataItem, "Count")%>
                                                                                </td>
                                                                                <td id="Td2" align="center" runat="server" style="width: 20%">
                                                                                    <asp:Button ID="btnViewDetails" Text="View Details & Actions" runat="server" CommandName="ViewDetails" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' />
                                                                                </td>
                                                                            </tr>
                                                                            <tr align="center" style="width: 100%" runat="server">
                                                                                <td colspan="4" runat="server">
                                                                                    <asp:TemplateField HeaderText="Questions" HeaderStyle-HorizontalAlign="Center">
                                                                                        <itemtemplate>
                                                                                          <div style="width: 100%;">
                                                                                            <div runat="server" style="width: 100%;"  id="DivChild" class="evenforsurg"  >
                                                                                                <asp:GridView ID="gvChildDetail" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                                                    ForeColor="#333333" Font-Size="10px" CssClass="mytable1">
                                                                                                    <Columns>
                                                                                                        <asp:TemplateField>
                                                                                                            <ItemTemplate>
                                                                                                                <asp:RadioButton ID="rdoSelect" runat="server" />
                                                                                                            </ItemTemplate>
                                                                                                            <ItemStyle Width="20px" />
                                                                                                        </asp:TemplateField>
                                                                                                        <asp:BoundField DataField="RequestNo" HeaderText="Request No" >
                                                                                                            <ItemStyle HorizontalAlign="Left" Width="20px" />
                                                                                                        </asp:BoundField>
                                                                                                        <asp:BoundField DataField="PatientNo" HeaderText="Patient No" >
                                                                                                            <ItemStyle HorizontalAlign="Left" Width="20px" />
                                                                                                        </asp:BoundField>
                                                                                                        <asp:BoundField DataField="PatientName" HeaderText="Patient Name">
                                                                                                            <ItemStyle HorizontalAlign="Left" Wrap="False" Width="40px"></ItemStyle>
                                                                                                        </asp:BoundField>
                                                                                                        <asp:BoundField DataField="NoOfUnits" HeaderText="No Of Units">
                                                                                                            <ItemStyle HorizontalAlign="Right" Wrap="False" Width="30px"></ItemStyle>
                                                                                                        </asp:BoundField>
                                                                                                        <asp:BoundField DataField="TransfusionDate"
                                                                                                            HeaderText="Transfusion Scheduled Date" >
                                                                                                            <ItemStyle HorizontalAlign="Center" Width="15px" />
                                                                                                        </asp:BoundField>
                                                                                                    </Columns>
                                                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                                                </asp:GridView>
                                                                                                        <asp:DropDownList ID="ddlVisitActionName" Visible="False" 
                                                                                                    CssClass="ddlTheme" runat="server">
                                                                                                        </asp:DropDownList>
                                                                                                        <asp:Button ID="btnGo" runat="server" Text="Go" Visible="False" 
                                                                                                    CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                                             onmouseout="this.className='btn'" />
                                                                                              </div>
                                                                                             </div>
                                                                                          </itemtemplate>
                                                                                    </asp:TemplateField>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <PagerSettings Mode="NumericFirstLast" />
                                                            <PagerStyle HorizontalAlign="Center" />
                                                            <RowStyle HorizontalAlign="Right" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
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
