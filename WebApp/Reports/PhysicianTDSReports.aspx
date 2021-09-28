<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PhysicianTDSReports.aspx.cs"
    Inherits="Admin_PhysicianTDSReports" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Physician TDS Report</title>

    <script type="text/javascript" runat="server">
        
        
        decimal TotalAmounts;
        decimal TotalDoctorsAmount(decimal totamt)
        {
            if (totamt != 0)
            {
                TotalAmounts += totamt;
            }
            else
            {
                totamt = 0;
            }
            return totamt;
        }
        decimal GetTotalAmount()
        {
            return TotalAmounts;
        }
        decimal TotalhosAmounts;
        decimal TotalHospitalAmount(decimal totamt)
        {
            if (totamt != 0)
            {
                TotalhosAmounts += totamt;
            }
            else
            {
                totamt = 0;
            }
            return totamt;
        }
        decimal GetHospitalAmount()
        {
            return TotalhosAmounts;
        }

        decimal Totalcharges;
        decimal Doctorscharges(decimal totamt)
        {
            if (totamt != 0)
            {
                Totalcharges += totamt;
            }
            else
            {
                totamt = 0;
            }
            return totamt;
        }
        decimal GetchargesAmount()
        {
            return Totalcharges;
        }
    </script>

    <style type="text/css">
        .style2
        {
            height: 23px;
        }
    </style>

</head>
<body>
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
                    <div class="contentdata1">
                        <ul id="ulErrorDiv" runat="server" style="display: none">
                            <li>
                                <uc6:ErrorDisplay ID="divError" runat="server" />
                            </li>
                        </ul>
                       <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <%--  <Triggers>
                                <asp:PostBackTrigger ControlID="bsave" />
                            </Triggers>--%>
                          <%--  <ContentTemplate>
                                <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                                    <ProgressTemplate>
                                        <div align="center">
                                            <asp:Image ID="Image2" ImageUrl="~/Images/working.gif" runat="server" meta:resourcekey="Image2Resource2" />
                                            <asp:Label ID="Rs_PleaseWait" Text="Please Wait..." runat="server" meta:resourcekey="Rs_PleaseWaitResource1"></asp:Label>
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress> --%>
                                <table border="0" cellpadding="2" cellspacing="1" width="100%">
                                    <tr>
                                        <td>
                                            <%-- contentdata--%>
                                            <table id="tbl" width="100%" border="0" class="dataheaderWider">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_Date" Text="Date:" runat="server"></asp:Label>
                                                    </td>
                                                    <td >
                                                        <asp:TextBox ID="txtFDate" runat="server"></asp:TextBox>
                                                        <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                            PopupButtonID="ImgFDate" Enabled="True" />
                                                        <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" />
                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                            CultureTimePlaceholder="" Enabled="True" />
                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                            ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" />
                                                    </td>
                                                    <td >
                                                        <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server"></asp:Label>
                                                    </td>
                                                    <td >
                                                        <asp:TextBox ID="txtTDate" runat="server"></asp:TextBox>
                                                        <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                            PopupButtonID="ImgTDate" Enabled="True" />
                                                        <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" />
                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                            CultureTimePlaceholder="" Enabled="True" />
                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                            ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" />
                                                    </td>
                                                   <%-- <td style="display: none;" >
                                                        <asp:Label ID="Rs_SelectReportType" Text="Select Report Type:" runat="server"></asp:Label>
                                                        <asp:DropDownList ID="ddlselect" runat="server" onchange="rblhide()" meta:resourcekey="ddlselectResource1">
                                                            <asp:ListItem Text="OP" Value="1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                            <asp:ListItem Text="IP" Selected="True" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>--%>
                                                </tr>
                                                <tr>
                                                    <td >
                                                        <asp:Label ID="lbldrname" Text="Physician Name :" runat="server" />
                                                    </td>
                                                    <td>
                                                     <asp:TextBox ID="txtNew" runat="server" ToolTip="Enter Text Here" onkeyup="FilterItems(this.value)"
                                                                    onblur="AddPhysician()"  />
                                                        <asp:DropDownList runat="server" ID="ddlDrName" CssClass="dropdownbutton">
                                                        </asp:DropDownList>
                                                   </td>
                                                     <td>
                                                        <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                            ToolTip="Save As Excel" onclick="imgBtnXL_Click" />
                                                         &nbsp; &nbsp;&nbsp;
                                                        <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" OnClick="btnSubmit_Click"  OnClientClick="javascript:return validateToDate();" />
                                                    </td>
                                                    <%--  <td align="left">
                                                        <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age"></asp:LinkButton>
                                                    </td>--%>
                                                </tr>
                                            </table>
                                            <table width="100%" id="drreports" runat="server">
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvPhysicianamtdet" runat="server" AutoGenerateColumns="false" HeaderStyle-Height="25px"
                                                            FooterStyle-Height="25px" CellPadding="1" ShowFooter="True" Width="100%" HorizontalAlign="Right"
                                                            BorderStyle="Ridge" EnableViewState="true" Visible="false" OnRowDataBound="gvPhysicianamtdet_RowDataBound">
                                                            <Columns>
                                                                <asp:BoundField HeaderText="BillNumber" DataField="BillNumber">
                                                                    <HeaderStyle Font-Bold="False" />
                                                                </asp:BoundField>
                                                                <asp:BoundField HeaderText="InterimBillNo" DataField="InterimBillNo">
                                                                    <HeaderStyle Font-Bold="False" />
                                                                </asp:BoundField>
                                                                <asp:BoundField HeaderText="ReceiptNo" DataField="ReceiptNo">
                                                                    <HeaderStyle Font-Bold="False" />
                                                                </asp:BoundField>
                                                                <%--<asp:BoundField HeaderText="Patient Number" DataField="PhysicianName">
                                                                    <HeaderStyle Font-Bold="False" />
                                                                </asp:BoundField>--%>
                                                                <asp:BoundField HeaderText="Patient Name" DataField="PatientName">
                                                                    <HeaderStyle Font-Bold="False" />
                                                                </asp:BoundField>
                                                                <asp:BoundField HeaderText="Date" DataField="VisitDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}">
                                                                    <HeaderStyle Font-Bold="False" />
                                                                </asp:BoundField>
                                                                <%--<asp:BoundField HeaderText="Quantity" DataField="Quantity" >
                                                                    <HeaderStyle Font-Bold="False" />
                                                                </asp:BoundField>--%>
                                                                <%-- <asp:BoundField HeaderText="Patient Type" DataField="VisitType" >
                                                                    <HeaderStyle Font-Bold="False" />
                                                                </asp:BoundField>--%>
                                                                <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right">
                                                                    <ItemTemplate>
                                                                        <%# TotalDoctorsAmount(decimal.Parse(Eval("Amount").ToString()))%>
                                                                    </ItemTemplate>
                                                                    <FooterTemplate>
                                                                        <%# (string)" " + GetTotalAmount()%>
                                                                    </FooterTemplate>
                                                                </asp:TemplateField>
                                                                <%-- <asp:BoundField HeaderText="Amount" DataField="Amount">
                                                                    <HeaderStyle Font-Bold="False" />
                                                                </asp:BoundField>--%>
                                                                <asp:TemplateField HeaderText="HospitalAmt" ItemStyle-HorizontalAlign="Right">
                                                                    <ItemTemplate>
                                                                        <%# TotalHospitalAmount(decimal.Parse(Eval("AmountToHostingOrg").ToString()))%>
                                                                    </ItemTemplate>
                                                                    <FooterTemplate>
                                                                        <%# (string)" " + GetHospitalAmount()%>
                                                                    </FooterTemplate>
                                                                </asp:TemplateField>
                                                                <%--  <asp:BoundField HeaderText="HospitalAmt" DataField="AmountToHostingOrg">
                                                                    <HeaderStyle Font-Bold="False" />
                                                                </asp:BoundField>--%>
                                                                <asp:TemplateField HeaderText="PhysicianAmt" ItemStyle-HorizontalAlign="Right">
                                                                    <ItemTemplate>
                                                                        <%# Doctorscharges(decimal.Parse(Eval("PhysicianAmount").ToString()))%>
                                                                    </ItemTemplate>
                                                                    <FooterTemplate>
                                                                        <%# (string)" " + GetchargesAmount()%>
                                                                    </FooterTemplate>
                                                                    <FooterTemplate>
                                                                        <%# (string)" " + GetchargesAmount()%>
                                                                    </FooterTemplate>
                                                                </asp:TemplateField>
                                                                <%--  <asp:BoundField HeaderText="PhysicianAmt" DataField="PhysicianAmount">
                                                                    <HeaderStyle Font-Bold="False" />
                                                                </asp:BoundField>--%>
                                                            </Columns>
                                                            <FooterStyle CssClass="dataheader1" HorizontalAlign="Right" />
                                                            <HeaderStyle CssClass="dataheader1" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td id="tdscalc" runat="server" visible="false">
                                                        <table width="100%">
                                                            <tr align="right" runat="server">
                                                                <td>
                                                                    <asp:Label ID="lbltds" Text="TDS (10%)" runat="server" />
                                                                </td>
                                                                <td  align="right" runat="server">
                                                                    <asp:Label ID="lbltdsamt" Text="0.00" runat="server" />
                                                                </td>
                                                            </tr>
                                                            <tr align="right" runat="server">
                                                                <td>
                                                                    
                                                                </td>
                                                                <td  align="right" runat="server"> 
                                                                    <asp:Label ID="Label2" Text="---------------" runat="server" />
                                                                </td>
                                                            </tr>
                                                            <tr align="right" runat="server">
                                                                <td class="style2">
                                                                    <asp:Label ID="lbls" Text="Net Total" runat="server" />
                                                                </td>
                                                                <td  align="right" runat="server">
                                                                    <asp:Label ID="lblnettotal" Text="0.00" runat="server" />
                                                                </td>
                                                            </tr>
                                                            <tr align="right" runat="server">
                                                                <td>
                                                                     
                                                                </td>
                                                                <td  align="right" runat="server">
                                                                    <asp:Label ID="Label4" Text="---------------" runat="server" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            <%--</ContentTemplate>
                        </asp:UpdatePanel>--%>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnPID" runat="server" />
    </form>
</body>
</html>
<script type="text/javascript">

    function FilterItems(value) {
        value = value.toLowerCase();
        ddl.options.length = 0;
        for (var i = 0; i < ddlText.length; i++) {
            if (ddlText[i].toLowerCase().indexOf(value) != -1) {
                AddItem(ddlText[i], ddlValue[i]);
            }
        }

        if (ddl.options.length == 0) {
            AddItem("No Physician Found", "");
        }
    }

    function AddItem(text, value) {
        var opt = document.createElement("option");
        opt.text = text;
        opt.value = value;
        ddl.options.add(opt);
    }
    function closeData() { }

    var ddlText, ddlValue, ddl, lblMesg;
    function CacheItems() {
        ddlText = new Array();
        ddlValue = new Array();
        ddl = document.getElementById("<%=ddlDrName.ClientID %>");
        for (var i = 0; i < ddl.options.length; i++) {
            ddlText[ddlText.length] = ddl.options[i].text;
            ddlValue[ddlValue.length] = ddl.options[i].value;
        }
    }

    window.onload = CacheItems;
    function AddPhysician() {

        var ddlPhy = document.getElementById("<%= ddlDrName.ClientID %>");
        var ddlPhyLength = ddlPhy.options.length;
        for (var i = 0; i < ddlPhyLength; i++) {
            if (ddlPhy.options[i].selected) {


                if (ddlPhy.options[i].text != '--Select--') {

                    document.getElementById('<%= txtNew.ClientID %>').value = ddlPhy.options[i].text;

                }

            }

        }
    }

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
        if (document.getElementById('ddlDrName').value == '0') {
            alert('Provide / select physician Name');
            document.getElementById('ddlDrName').focus();
            return false;
        }
    }
        
</script>
