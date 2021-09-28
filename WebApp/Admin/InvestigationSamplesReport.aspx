<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationSamplesReport.aspx.cs"
    Inherits="Admin_InvestigationSamplesReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="AdminHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Sample Collection Report</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
        <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var x;
        //= document.getElementById('flagSetter').value
        function validateHospital() {

            if (document.getElementById('flagSetter').value == "1") {
                if (document.getElementById('ddlHospital').value == "0") {
                alert('Select a hospital');
                    document.getElementById('ddlHospital').focus();
                    return false;
                }
            }

            if (document.getElementById('flagSetter').value == "2") {
                if (document.getElementById('ddlPhysician').value == "0") {
                alert('Select a doctor');
                    document.getElementById('ddlPhysician').focus();
                    return false;
                }
            }
            return ValidateDate();
        }
        function showHideHospitalDoctor(x) {
            document.getElementById('ddlPhysician').selectedIndex = 0;
            document.getElementById('ddlPhysician').options[0].selected = true;
            document.getElementById('ddlHospital').selectedIndex = 0;
            document.getElementById('ddlHospital').options[0].selected = true;
            if (x == "1") {

                document.getElementById('trHospital').style.display = "block";
                document.getElementById('trDoctor').style.display = "none";
                document.getElementById('flagSetter').value = x;
            }
            if (x == "2") {
                document.getElementById('trHospital').style.display = "none";
                document.getElementById('trDoctor').style.display = "block";
                document.getElementById('flagSetter').value = x;
            }

        }
        function ValidateDate() {

            if (document.getElementById('txtFrom').value == '') {

                alert('Select from date and to date');
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {
                alert('Select from date and to date');
                return false;

            }
            else {
                //return checkFromDateToDate('txtFrom', 'txtTo');
            }

        }

    </script>

    <style type="text/css">
        .style1
        {
            width: 16%;
        }
    </style>
</head>
<body onload="onComboFocus('ddlHospital')">
    <form id="form1" runat="server" defaultbutton="btnGo" defaultfocus="ddlHospital">
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
                <uc2:Header ID="Header2" runat="server" />
                <uc7:AdminHeader ID="AdminHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:leftmenu id="LeftMenu1" runat="server" />
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
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td height="32">
                                    <table border="0" id="mytable1" cellpadding="4" cellspacing="0" width="100%">
                                        <tr>
                                            <td colspan="5" id="us">
                                                Look up for Sample Collection Details.
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div>
                                        <asp:Panel runat="server" CssClass="dataheader2" ID="pnlDate" Width="99%" Visible="true">
                                            <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="height: 5px;">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table border="0" width="100%" cellpadding="4" cellspacing="0">
                                                            <tr>
                                                                <td align="right" style="width: 13%">
                                                                    <asp:Label runat="server" ID="fromDate" Text="From Date" CssClass="label_title">
                                                                    </asp:Label>
                                                                </td>
                                                                <td style="width: 37%;">
                                                                    <asp:TextBox ID="txtFrom" runat="server"  CssClass ="Txtboxsmall" TabIndex="4" MaxLength="1"
                                                                        Style="text-align: justify" ValidationGroup="MKE" />
                                                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                        CausesValidation="False" />
                                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFrom"
                                                                        Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                        OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                                        ErrorTooltipEnabled="True" />
                                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                                        ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                        ValidationGroup="MKE" />
                                                                    <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFrom"
                                                                        PopupButtonID="ImageButton1" Format="dd/MM/yyyy" />
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                                <td align="right" style="width: 13%;">
                                                                    <asp:Label runat="server" ID="toDate" Text="To Date" CssClass="label_title">
                                                                    </asp:Label>
                                                                </td>
                                                                <td style="width: 37%">
                                                                    <asp:TextBox ID="txtTo" runat="server"  CssClass ="Txtboxsmall" TabIndex="5" MaxLength="1" Style="text-align: justify"
                                                                        ValidationGroup="MKE" />
                                                                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                        CausesValidation="False" />
                                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtTo"
                                                                        Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                        OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                                        ErrorTooltipEnabled="True" />
                                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                                        ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                        ValidationGroup="MKE" />
                                                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtTo"
                                                                        PopupButtonID="ImageButton2" Format="dd/MM/yyyy" />
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td>
                                                                    <div id="trDoctor" runat="server">
                                                                        <table border="0" width="100%" cellpadding="4" cellspacing="0">
                                                                            <tr>
                                                                                <td align="right" style="width: 15%;">
                                                                                    <asp:Label runat="server" ID="lblDoctor" Text="Select a Doctor">
                                                                                    </asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:DropDownList ID="ddlPhysician" CssClass ="ddlmedium" runat="server">
                                                                                    </asp:DropDownList>
                                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div id="trHospital" runat="server">
                                                                        <table border="0" width="100%" cellpadding="4" cellspacing="0">
                                                                            <tr>
                                                                                <td align="right" class="style1">
                                                                                    <asp:Label runat="server" ID="lblHospital" Text="Select a Hospital">
                                                                                    </asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:DropDownList ID="ddlHospital" runat="server" CssClass ="ddlmedium" AutoPostBack="false">
                                                                                    </asp:DropDownList>
                                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table border="0" width="100%" cellpadding="4" cellspacing="0">
                                                            <tr>
                                                                <td>
                                                                    View Report based on
                                                                    <input id="Radio1" type="radio" name="reportType" checked value="1" onclick="javascript:showHideHospitalDoctor(this.value);"
                                                                        runat="server" />
                                                                    Hospital
                                                                    <input id="Radio2" type="radio" name="reportType" value="2" onclick="javascript:showHideHospitalDoctor(this.value);"
                                                                        runat="server" />
                                                                    Doctor
                                                                    <input type="hidden" id="flagSetter" runat="server" />
                                                                    <asp:Button runat="server" ID="btnGo" Text=" Go " CssClass="btn" TabIndex="6" onmouseover="this.className='btn btnhov'"
                                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateHospital();"
                                                                        OnClick="btnGo_Click" />
                                                                    &nbsp;
                                                                    <asp:Button ID="btnCancel" runat="server" Text="Reset" CssClass="btn" 
                                                                        onmouseout="this.className='btn'" OnClick="btnCancel_Click" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 5px;">
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblResult" ForeColor="#333" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:GridView ID="grdResult" Width="99%" runat="server" AllowPaging="True" CellPadding="4"
                                        AutoGenerateColumns="False" PagerSettings-Mode="NextPrevious" ForeColor="#333333"
                                        PageSize="10" GridLines="Both" CssClass="mytable1" OnPageIndexChanging="grdResult_PageIndexChanging">
                                        <PagerTemplate>
                                            <tr>
                                                <td colspan="6" align="center">
                                                    <asp:ImageButton ID="lnkPrev" CommandName="Page" runat="server" CausesValidation="false"
                                                        CommandArgument="Prev" ImageUrl="~/Images/previousimage.png" Width="18px" Height="18px" />
                                                    <asp:ImageButton ID="lnkNext" CommandName="Page" runat="server" CausesValidation="false"
                                                        CommandArgument="Next" ImageUrl="~/Images/nextimage.png" Width="18px" Height="18px" />
                                                </td>
                                            </tr>
                                        </PagerTemplate>
                                        <HeaderStyle CssClass="dataheader1" />
                                        <Columns>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <HeaderTemplate>
                                                    <asp:Label runat="server" ID="lblHeader" Text="Patient Name"></asp:Label>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <a href='<%# "~/Admin/ViewSamples.aspx?vid="+DataBinder.Eval(Container.DataItem,"PatientVisitId") %>'
                                                        runat="server" id="lnklist" style="color: Black; font-weight: bold; text-decoration: underline;">
                                                        <%# Eval("PatientName") %>
                                                    </a>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="HospitalName" Visible="true" HeaderText="Hospital Name"
                                                HeaderStyle-HorizontalAlign="left" />
                                            <asp:BoundField DataField="ReferingPhysicianName" Visible="true" HeaderText="Doctor Name"
                                                HeaderStyle-HorizontalAlign="left" />
                                            <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd/MM/yyyy hh:mm}" Visible="true"
                                                HeaderText="Date" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left"
                                                ItemStyle-Width="30%" />
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
