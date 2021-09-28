<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CommunicableDiseaseReport.aspx.cs"
    Inherits="Reports_CommunicableDiseaseReport" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/PatientSearch.ascx" TagName="PatientSearch" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--<%@ Register Assembly="IdeaSparx.CoolControls.Web" Namespace="IdeaSparx.CoolControls.Web"  TagPrefix="Grd" %>--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Communicable Diseases Details</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
            <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <style type="text/css">
        /* So the overflow scrolls */.container
        {
            overflow: auto;
        }
        /* Keep the header cells positioned as we scroll */.container table th
        {
            position: relative;
        }
        /* For alignment of the scroll bar */.container table tbody
        {
            overflow-x: hidden;
        }
        .style1
        {
            width: 20%;
            height: 33px;
        }
        .style2
        {
            height: 33px;
        }
    </style>

    <script type="text/javascript">



        function PrintCD() {


            var prtContent = document.getElementById('PrintCD');

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0,Addressbar=no');
            //alert(WinPrint);
            //var WinPrint = window.open('', '', 'letf=0,top=0,width=900,height=900,toolbar=0,scrollbars=0,status=0,Addressbar=no');
            WinPrint.document.write(prtContent.innerHTML);

            WinPrint.document.close();

            WinPrint.focus();

            WinPrint.print();

            WinPrint.close();
        }


   

        

        

    
    </script>

</head>
<body onload="pageLoadFocus('txtFrom');" oncontextmenu="return false;">
    <form id="form1" runat="server">
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
                        <div>
                            <table cellpadding="2" class="dataheader2 defaultfontcolor" style="text-align: left;"
                                cellspacing="1" width="100%">
                                <tr>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblFrom" Text="From" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFrom"  CssClass ="Txtboxsmall"  Width ="120px" runat="server"></asp:TextBox>
                                                    <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" />
                                                    <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFrom"
                                                        Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                        OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" />
                                                    <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" />
                                                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFrom"
                                                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTo" Text="To" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtTo" CssClass ="Txtboxsmall"  Width ="120px" runat="server"></asp:TextBox>
                                                    <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" />
                                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTo"
                                                        Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                        OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" />
                                                    <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" />
                                                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtTo"
                                                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" />
                                                </td>
                                            </tr>
                                            <tr id="icddrop" runat="server" visible="false">
                                                <td align="left" class="defaultfontcolor">
                                                    <asp:Label ID="Rs_ICDCode" Text="ICD Code" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlICDCode"  CssClass ="ddl" runat="server">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" align="center">
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClick="btnSearch_Click" />
                                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                                                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />
                                                    &nbsp;
                                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" OnClick="imgBtnXL_Click" />
                                                    &nbsp;
                                                    <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="true" runat="server" CssClass="details_label_age"
                                                        OnClick="lnkBack_Click"></asp:LinkButton>
                                                    &nbsp;
                                                    <input type="button" name="btnPrint" id="btnPrint" onclick="PrintCD();" value="Print"
                                                        class="btn" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td id="PrintCD" class="dataheader2" nowrap="nowrap" runat="server">
                                        <asp:GridView Width="100%" ID="grdResult" runat="server" AutoGenerateColumns="False"
                                            CssClass="mytable1" PagerSettings-Mode="NextPrevious" meta:resourcekey="grdResultResource1">
                                            <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <HeaderStyle CssClass="dataheader1" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No">
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex + 1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="PatientID" HeaderText="Patient Number" meta:resourcekey="BoundFieldResource1">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="PatientName" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="PatientAge" HeaderText="Age" meta:resourcekey="BoundFieldResource3">
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="VisitType" meta:resourcekey="TemplateFieldResource1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblgrdVisitType" runat="server" Text='<%# Bind("VisitType") %>' meta:resourcekey="lblgrdVisitTypeResource1"></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtgrdVisitType" runat="server" Text='<%# Bind("VisitType") %>'
                                                            meta:resourcekey="txtgrdVisitTypeResource1"></asp:TextBox>
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ComplaintName" HeaderText="Complaint Name" meta:resourcekey="BoundFieldResource4">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ICDCode" HeaderText="ICD Code" meta:resourcekey="BoundFieldResource5">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ICDName" HeaderText="ICD Name" meta:resourcekey="BoundFieldResource6">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Visit Date"
                                                    meta:resourcekey="BoundFieldResource7"></asp:BoundField>
                                                <asp:TemplateField HeaderText="Address">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAddress" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    
                                                </asp:TemplateField>
                                                 
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource1"></asp:Label>
                                        <asp:Label ID="lblResult" runat="server" CssClass="casesheettext" meta:resourcekey="lblResultResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <input type="hidden" id="hdnPNAME" name="PName" runat="server" />
                    <input type="hidden" id="hdnPID" name="pid" runat="server" />
                    <input type="hidden" id="hdnVID" name="vid" runat="server" />
                    <input type="hidden" id="hdnVisitDetail" runat="server" />
                    <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
