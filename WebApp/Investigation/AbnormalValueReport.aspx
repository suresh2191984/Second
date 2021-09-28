<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AbnormalValueReport.aspx.cs"
    Inherits="Investigation_AbnormalValueReport" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

   <script src="../Scripts/Common.js" type="text/javascript"></script>

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
        function SelectedTest(source, eventArgs) {
            TestDetails = eventArgs.get_value();

            var TestName = TestDetails.split('~')[0];
            var TestID = TestDetails.split('~')[1];
            document.getElementById('hdnTestID').value = TestID;
        }
        function ClearTestDetails() {
           document.getElementById('txtTestName').value = '';
//            document.getElementById('hdnTestName').value = '';
           document.getElementById('hdnTestID').value = '0';
//            document.getElementById('hdnTestType').value = '';

        }
    
    </script>

    <style type="text/css">
        .style1
        {
            width: 370px;
        }
        .style2
        {
            width: 15px;
        }
        .style3
        {
            width: 111px;
        }
        .GroupBox
        {
            border: 2px solid #FFFFFF;
            display: inline;
            height: 25px;
        }
    </style>
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
                <td width="15%" valign="top" id="menu" style="display: none;">
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
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table id="tblCollectionOPIP" align="center" width="100%">
                            <tr align="center">
                                <td align="left">
                                    <div class="dataheaderWider">
                                        <table id="tbl">
                                            <tr style="width: 20%">
                                                <td style="width: 20%">
                                                    From Date :
                                                    <asp:TextBox ID="txtFDate" runat="server" Width="50%" CssClass="Txtboxsmall"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                        PopupButtonID="ImgFDate" />
                                                    <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                        Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                        OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" />
                                                </td>
                                                <td style="width: 20%">
                                                    To Date :
                                                    <asp:TextBox ID="txtTDate" runat="server" Width="50%" CssClass="Txtboxsmall"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                        PopupButtonID="ImgTDate" />
                                                    <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                        Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                        OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" />
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="lblLocation" Text="Location: " runat="server"></asp:Label>
                                                </td>
                                               <td align="left">
                                                    <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                </td>
                                                <td align="right"> 
                                                    <asp:Label ID="lblTestName" Text="Test Name: " runat="server"></asp:Label>                                                                                   
                                                </td>
                                                <td align="left"> 
                                                <asp:TextBox ID="txtTestName" runat="server" CssClass="Txtboxsmall" onfocus="javascript:ClearTestDetails();"></asp:TextBox>                                                                                   
                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                                TargetControlID="txtTestName" ServiceMethod="GetInvestigationNameFromOrgMapping" ServicePath="~/WebService.asmx"
                                                EnableCaching="False" BehaviorID="AutoCompleteExLstGrp11" CompletionInterval="2"
                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                Enabled="True" OnClientItemSelected="SelectedTest">
                                                </ajc:AutoCompleteExtender>
                                                <asp:HiddenField ID="hdnTestID" Value="0" runat="server" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClick="btnSubmit_Click" />
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" OnClick="lnkBack_Click">Back&nbsp;&nbsp;&nbsp;</asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="btn_export" runat="server" Font-Bold="true" Visible="true" Text="Export to Excel"
                                                    BackColor="" OnClick="btn_export_Click" Style="border-width: 2px;" Font-Size="12px"
                                                    ForeColor="#000000" Font-Underline="true" />
                                                </td>
                                            </tr>
                                           
                                        </table>
                                    </div>
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td style="width: 100%;" valign="top">
                                                <asp:UpdateProgress ID="Progressbar" runat="server">
                                                    <ProgressTemplate>
                                                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                                                        Please wait....
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                                <asp:UpdatePanel ID="updatePanel1" runat="server">
                                                    <ContentTemplate>
                                                            <table width="100%">
                                                                <tr>
                                                                    <td valign="top">
                                                                        <asp:Label ID="lblMessage" runat="server" Text="No Matching Records Found!" Font-Bold="true"
                                                                            Visible="false"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblCash" runat="server" Text="Paid Patients :" Font-Bold="true" Visible="false"></asp:Label>
                                                                        <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" Visible="false"
                                                                            Width="100%" ForeColor="#333333" CssClass="mytable1" RowStyle-BackColor="White">
                                                                            <Columns>
                                                                                    <asp:TemplateField HeaderText="S.NO" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="3%">
                                                                                    <ItemTemplate>
                                                                                    <%# Container.DataItemIndex + 1 %>
                                                                                    </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:BoundField HeaderText="Investigation ID" DataField="InvestigationID" HeaderStyle-HorizontalAlign="Center" Visible="false" />
                                                                                    <asp:BoundField HeaderText="Investigation Name" DataField="InvestigationName" ItemStyle-Width="25%"  HeaderStyle-HorizontalAlign="Center" />
                                                                                    <asp:BoundField HeaderText="Abnormal Value" DataField="InvestigationNameRate" HeaderStyle-HorizontalAlign="Center" />
                                                                                    <asp:BoundField HeaderText="Reference Range" DataField="ReferenceRange" HeaderStyle-HorizontalAlign="Center" />
                                                                                    <asp:BoundField HeaderText="Patient Name" DataField="Name" ItemStyle-Width="15%" HeaderStyle-HorizontalAlign="Center" />
                                                                                    <asp:BoundField HeaderText="Patient No" DataField="PatientNumber" HeaderStyle-HorizontalAlign="Center" />
                                                                                    <asp:BoundField HeaderText="Age" DataField="Age" ItemStyle-Width="12%"  HeaderStyle-HorizontalAlign="Center" />
                                                                                    <asp:BoundField HeaderText="Date" DataField="CreatedAt" ItemStyle-Width="20%" HeaderStyle-HorizontalAlign="Center" />
                                                                                    <asp:BoundField HeaderText="Location Name" DataField="Location" HeaderStyle-HorizontalAlign="Center" />
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <uc5:Footer ID="Footer1" runat="server" />
    </form>
</body>
</html>