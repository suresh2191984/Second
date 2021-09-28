<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ResourceConsumption.aspx.cs"
    Inherits="Reception_ResourceConsumption" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/SurgeryforProcedurePlanning.ascx" TagName="SurgeryPlan"
    TagPrefix="uc8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <title>Resource Consumption</title>
   
      <script src ="../scripts/MessageHandler.js" language ="javascript" type ="text/javascript" ></script>
    <script type="text/javascript">

      

    </script>
         
  <style type="text/css">
        /*Calendar Control CSS*/.expand
        {
            background-image: url(images/plus.gif);
            width: 9px;
            height: 9px;
        }
        .collapse
        {
            background-image: url(images/minus.gif);
            width: 9px;
            height: 9px;
        }
        .cal_Theme1 .ajax__calendar_container
        {
            background-color: #DEF1F4;
            border: solid 1px #77D5F7;
        }
        .cal_Theme1 .ajax__calendar_header
        {
            background-color: #ffffff;
            margin-bottom: 4px;
        }
        .cal_Theme1 .ajax__calendar_title, .cal_Theme1 .ajax__calendar_next, .cal_Theme1 .ajax__calendar_prev
        {
            color: #004080;
            padding-top: 3px;
        }
        .cal_Theme1 .ajax__calendar_body
        {
            background-color: #ffffff;
            border: solid 1px #77D5F7;
        }
        .cal_Theme1 .ajax__calendar_dayname
        {
            text-align: center;
            font-weight: bold;
            margin-bottom: 4px;
            margin-top: 2px;
            color: #004080;
        }
        .cal_Theme1 .ajax__calendar_day
        {
            color: #004080;
            text-align: center;
        }
        .cal_Theme1 .ajax__calendar_hover .ajax__calendar_day, .cal_Theme1 .ajax__calendar_hover .ajax__calendar_month, .cal_Theme1 .ajax__calendar_hover .ajax__calendar_year, .cal_Theme1 .ajax__calendar_active
        {
            color: #004080;
            font-weight: bold;
            background-color: #DEF1F4;
        }
        .cal_Theme1 .ajax__calendar_today
        {
            font-weight: bold;
        }
        .cal_Theme1 .ajax__calendar_other, .cal_Theme1 .ajax__calendar_hover .ajax__calendar_today, .cal_Theme1 .ajax__calendar_hover .ajax__calendar_title
        {
            color: #bbbbbb;
        }
        body
        {
            margin: 0px;
        }
        </style> 
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
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
                <td width="15%" valign="top" id="menu" style="display: none;">
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
                    <div class="contentdata1">
                        <table class="dataheader2" width="100%" style="font-family: verdana; font-weight: bold"
                            cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblName" Text="Name : " runat="server" 
                                        meta:resourcekey="lblNameResource1"></asp:Label>
                                    <asp:Label ID="lblNameValue" runat="server" 
                                        meta:resourcekey="lblNameValueResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblAgeOrSex" Text="Age/Sex : " runat="server" 
                                        meta:resourcekey="lblAgeOrSexResource1"></asp:Label>
                                    <asp:Label ID="lblAgeOrSexValue" runat="server" 
                                        meta:resourcekey="lblAgeOrSexValueResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblPno" Text="Patient Number : " runat="server" 
                                        meta:resourcekey="lblPnoResource1"></asp:Label>
                                    <asp:Label ID="lblPnovalue" runat="server" 
                                        meta:resourcekey="lblPnovalueResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblAddress" Text="Address : " runat="server" 
                                        meta:resourcekey="lblAddressResource1"></asp:Label>
                                    <asp:Label ID="lbladdressvalue" runat="server" 
                                        meta:resourcekey="lbladdressvalueResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblContactNumber" Text="Contact Number : " runat="server" 
                                        meta:resourcekey="lblContactNumberResource1"></asp:Label>
                                    <asp:Label ID="lblcontactNovalue" runat="server" 
                                        meta:resourcekey="lblcontactNovalueResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lblServiceType" Text="Select Service" runat="server" 
                                        Font-Bold="True" meta:resourcekey="lblServiceTypeResource1" />
                                    <asp:DropDownList ID="ddlServices" runat="server" Width="200px"  CssClass ="ddlsmall"
                                        Height="16px" OnSelectedIndexChanged="ddlServices_OnSelectedIndexChanged" 
                                       AutoPostBack="True" meta:resourcekey="ddlServicesResource1">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <div id="divgv">
                            <asp:GridView ID="gvResources" runat="server" Width="76%" AutoGenerateColumns="False"
                                BorderStyle="Groove" BorderWidth="1px" PageSize="5" CellPadding="1"
                                PagerSettings-Mode="NextPrevious" 
                                OnRowDataBound="gvResources_RowDataBound" 
                                meta:resourcekey="gvResourcesResource1">
                                <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                    PageButtonCount="5" PreviousPageText="" />
                                <HeaderStyle CssClass="dataheader1" />
                                <RowStyle HorizontalAlign="Left" Font-Size="10px" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Select" 
                                        meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkBox" runat="server" meta:resourcekey="chkBoxResource1" />
                                            <asp:HiddenField ID="hdnvalue" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Description Name" 
                                        meta:resourcekey="TemplateFieldResource2">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescriptionName" Text='<%# Eval("ServiceName") %>' 
                                                runat="server" meta:resourcekey="lblDescriptionNameResource1"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Consumption Value" 
                                        meta:resourcekey="TemplateFieldResource3">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtValue" Width ="20px" runat="server" 
                                                meta:resourcekey="txtValueResource1"></asp:TextBox>
                                            <asp:DropDownList ID="ddlUOM" runat="server" meta:resourcekey="ddlUOMResource1">
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Start Date" 
                                        meta:resourcekey="TemplateFieldResource4">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtDate" runat="server" meta:resourcekey="txtDateResource1"></asp:TextBox>
                                            <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtDate"
                                                PopupButtonID="ImgFDate" Enabled="True"  CssClass="cal_Theme1"/>
                                            <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                            <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtDate"
                                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                CultureTimePlaceholder="" Enabled="True"   />
                                            <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                ControlToValidate="txtDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" 
                                                meta:resourcekey="MaskedEditValidator5Resource1"  />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Comments" 
                                        meta:resourcekey="TemplateFieldResource5">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtComments" runat="server" 
                                                meta:resourcekey="txtCommentsResource1"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                        <table border="0" cellpadding="2" cellspacing="2" class="defaultfontcolor" width="100%">
                            <tr>
                                <td id="btnSaveID" runat="server" align="center" class="style4" style="display: block">
                                    <asp:Button ID="btnSave" runat="server" CssClass="btn" Height="26px" OnClick="btnSave_Click"
                                        onmouseout="this.className='btn'" 
                                        onmouseover="this.className='btn btnhov'" Text="Save"
                                        Width="59px" meta:resourcekey="btnSaveResource1" />
                                    <asp:HiddenField ID="hdnSaveTable" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <input type="hidden" id="hdnStatus" runat="server" />
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
            <asp:HiddenField ID ="hdnMessages" runat ="server" />
    </div>
    <asp:HiddenField ID ="hdnResourceConsumption" runat ="server" />
    <asp:HiddenField ID ="hdnResourceID" runat ="server"  Value ="0"/>
    </form>
</body>
</html>
