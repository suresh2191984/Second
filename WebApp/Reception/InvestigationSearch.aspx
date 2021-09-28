<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationSearch.aspx.cs"
    Inherits="InvestigationSearch" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/InvestigationSearchControl.ascx" TagName="InvestigationSearchControl"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%--<%@ Register Src="../CommonControls/InvestigationSearchControl.ascx" TagName="InvestigationControl"
    TagPrefix="uc2" %>--%>
<%@ Register Src="../CommonControls/SampleBillPrint.ascx" TagName="SampleBillPrint"
    TagPrefix="uc7" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Investigation Search</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>
    <script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/ToolTip.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>
    
    <script type="text/javascript" language="javascript">

        $(function() {
//        $('#imgPatient').hide();
            $("#DrpTRF").change(function() {
            if ($('#DrpTRF :selected').text() != '-----Select-----') {
                $('#imgPatient').show();
                    $('#imgPatient').attr('src', 'TRFImagehandler.ashx?PictureName=' + $('#DrpTRF :selected').text() + "&OrgID=" + <%= OrgID %> );
                }
                else
                    $('#imgPatient').hide();
            });
        });
    </script>

</head>
<body onload="LoadOrdItems();" oncontextmenu="return true;">
    <form id="prFrm" runat="server">
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
                        <table id="pageBlock" runat="server" border="0" cellpadding="2" cellspacing="1" width="100%">
                            <tr id="trPriority" runat="server" style="display: none;">
                                <td align="center">
                                    <asp:Label ID="lblPriority" Font-Bold="True" ForeColor="#403F3E" runat="server" meta:resourcekey="lblPriorityResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                   
                                        <table border="0" cellpadding="2" cellspacing="1" width="100%">
                                            <tr>
                                                <td style="font-weight: bolder; font-size:14px; height: 20px; color: #000; width: 10%;" align="right">
                                                    <asp:LinkButton ForeColor="Yellow" runat="server" ToolTip="Click Here to View TRF Image"
                                                        ID="LnkTRF" Font-Underline="true" Text="View TRF Image"></asp:LinkButton>
                                                       
                                                </td>
                                            </tr>
                                            
                                            
                                            <tr>
                                                <td align="center" id="tdTRF" runat="server">
                                            
                                                    <asp:Panel ID="pnlOthers" runat="server" Style="display: none; height: 540px; width: 649px;"
                                                        CssClass="modalPopup dataheaderPopup">
                                                        <div id="divFullImage">
                                                            <table border="0" cellpadding="2" cellspacing="1" width="100%" class="dataheader2 defaultfontcolor">
                                                               
                                                               <tr>
                                            <td>
                                            <asp:DropDownList id="DrpTRF" runat="server"></asp:DropDownList>
                                            </td>
                                            
                                            </tr>
                                                               
                                                                <tr>
                                                                    <td id="PicPatient" width="2%">
                                                                    
                                                <img id="imgPatient" runat="server" alt="Patient Photo" src="~/Images/ProfileDefault.jpg" />
                                                                   
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <input id="btnClose" runat="server" class="btn" type="button" value="Close" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </asp:Panel>
                                                    <ajc:ModalPopupExtender ID="mpeOthers" runat="server" BehaviorID="mpeOthersBehavior"
                                                        BackgroundCssClass="modalBackground" DropShadow="false" PopupControlID="pnlOthers"
                                                        CancelControlID="btnClose" TargetControlID="LnkTRF" Enabled="True">
                                                    </ajc:ModalPopupExtender>
                                            
                                                </td>
                                            </tr>
                                        </table>
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="Panel1" CssClass="dataheader2" BorderWidth="1px" runat="server" meta:resourcekey="Panel1Resource1">
                                        <table border="0" cellpadding="4" cellspacing="0" width="100%">
                                            <tr>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    <asp:Label ID="Rs_PatientNo" Text="Patient No:" runat="server" meta:resourcekey="Rs_PatientNoResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    <asp:Label ID="lblPatientNo" runat="server" meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 13%;" align="left">
                                                    <asp:Label ID="Rs_PatientName" Text="Patient Name:" runat="server" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000;" align="left">
                                                    <asp:Label ID="lblPatientName" runat="server" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    <asp:Label ID="Rs_Gender" Text="Gender:" runat="server" meta:resourcekey="Rs_GenderResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                    <asp:Label ID="lblGender" runat="server" meta:resourcekey="lblGenderResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    <asp:Label ID="Rs_Age" Text="Age" runat="server" meta:resourcekey="Rs_AgeResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                    <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 8%;" align="left">
                                                    <asp:Label ID="Rs_VisitNo" Text="Visit No:" runat="server" meta:resourcekey="Rs_VisitNoResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal; height: 20px; color: #000; width: 5%;" align="left">
                                                    <asp:Label ID="lblVisitNo" runat="server" meta:resourcekey="lblVisitNoResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td class="evenforsurg" width="35%" height="23" align="left">
                                    <div style="display: block;" runat="server" id="ACX2plusEU">
                                        &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                            style="cursor: pointer" onclick="showResponses('ACX2plusEU','ACX2minusEU','ACX2responsesEU',1);" />
                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusEU','ACX2minusEU','ACX2responsesEU',1);">
                                            <asp:Label ID="Rs_VisitHistory" Text="Visit History" runat="server" meta:resourcekey="Rs_VisitHistoryResource1"></asp:Label></span>
                                    </div>
                                    <div style="display: none; height: 18px;" runat="server" id="ACX2minusEU">
                                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15" height="15" align="top"
                                            style="cursor: pointer" onclick="showResponses('ACX2plusEU','ACX2minusEU','ACX2responsesEU',0);" />
                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusEU','ACX2minusEU','ACX2responsesEU',0);">
                                            <asp:Label ID="Rs_VisitHistory1" Text="Visit History" runat="server" meta:resourcekey="Rs_VisitHistory1Resource1"></asp:Label></span>
                                    </div>
                                </td>
                            </tr>
                            <tr class="tablerow" id="ACX2responsesEU" style="display: none">
                                <td>
                                    <asp:GridView ID="VisitDetails" runat="server" AllowPaging="True" CellPadding="1"
                                        AutoGenerateColumns="False" DataKeyNames="PatientVisitID,Name" Width="98%" ForeColor="White"
                                        PageSize="6" OnPageIndexChanging="VisitDetails_PageIndexChanging" CssClass="mytable1"
                                        OnRowDataBound="VisitDetails_RowDataBound" PagerSettings-Visible="true" meta:resourcekey="VisitDetailsResource1">
                                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" ForeColor="black" />
                                        <%--<HeaderStyle CssClass="dataheader1" />--%>
                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                            PageButtonCount="5" PreviousPageText="" />
                                        <HeaderStyle CssClass="dataheader1" />
                                        <Columns>
                                            <asp:BoundField DataField="PatientName" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource1" />
                                            <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd MMM yyyy}" HeaderText="Visit Date"
                                                meta:resourcekey="BoundFieldResource2" />
                                            <asp:BoundField DataField="ReferingPhysicianName" HeaderText="Ref Physician" meta:resourcekey="BoundFieldResource3" />
                                            <asp:TemplateField HeaderText="Reporting Radiologist" meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <asp:Label Text='<%# DataBinder.Eval(Container.DataItem,"PerformingPhysicain") %>'
                                                        ID="lblReportingRadiologist" runat="server" meta:resourcekey="lblReportingRadiologistResource1" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Investigation" HeaderText="Investigation" meta:resourcekey="BoundFieldResource4" />
                                            <%--  <asp:TemplateField HeaderText="Physician Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPhysicianName" runat='server' Text='<%#Bind("Name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                                 <asp:BoundField DataField="Location" HeaderText="Location" />--%>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <%-- <tr>
                                <td>
                                    <div id="dinves" runat="server" style="display: block;">
                                    
                                        <asp:Label ID="ltrMsg" runat="server"></asp:Label>
                                        <uc2:InvestigationSearchControl ID="InvestigationSearchControl1" runat="server" />
                                        <asp:Table ID="Table1" BorderWidth="0" runat="server" Width="100%">
                                            <asp:TableRow Height="15px" BorderWidth="0">
                                                <asp:TableCell HorizontalAlign="left">
                                                    <asp:RadioButton ID="rdoPayNow" runat="server" GroupName="grprdo" Text="Pay Now" />
                                                    &nbsp;
                                                    <asp:RadioButton ID="rdoPayLater" runat="server" GroupName="grprdo" Text="Pay Later" />
                                                </asp:TableCell></asp:TableRow>
                                            <asp:TableRow Height="15px" BorderWidth="0">
                                                <asp:TableCell HorizontalAlign="left">
                                                    <asp:Button ID="btnBillShow" ToolTip="Click here to Generate the Bill" Style="cursor: pointer;"
                                                        runat="server" Text="Finish" OnClick="btnBillShow_Click" CssClass="btn" OnClientClick="javascript:if(!checkItemsAdded()) return false;"
                                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" />
                                                </asp:TableCell></asp:TableRow>
                                        </asp:Table>
                                    </div>
                                </td>
                            </tr>--%>
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <div id="dinves" runat="server" style="display: block;">
                                                    <table border="0">
                                                        <tr>
                                                            <td style="font-weight: normal; height: 20px; color: #000; width: 10%;" align="left">
                                                                <asp:LinkButton ForeColor="Red" runat="server" ToolTip="Click Here to add new investigation"
                                                                    ID="lnkAddnew" Text="Add New Investigation" OnClick="lnkAddnew_Click" meta:resourcekey="lnkAddnewResource1"></asp:LinkButton>
                                                                <asp:Label ID="ltrMsg" runat="server" meta:resourcekey="ltrMsgResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <uc2:InvestigationSearchControl ID="InvestigationSearchControl1" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Table ID="Table1" BorderWidth="0px" runat="server" Width="100%">
                                                                    <asp:TableRow Height="15px" BorderWidth="0">
                                                                        <asp:TableCell HorizontalAlign="left">
                                                                            <asp:RadioButton ID="rdoPayNow" runat="server" GroupName="grprdo" Text="Pay Now"
                                                                                meta:resourcekey="rdoPayNowResource1" />
                                                                            &nbsp;
                                                                            <asp:RadioButton ID="rdoPayLater" runat="server" GroupName="grprdo" Text="Pay Later"
                                                                                meta:resourcekey="rdoPayLaterResource1" />
                                                                                &nbsp;
                                                                             <asp:RadioButton ID="rdoSkipBill" runat="server" GroupName="grprdo" Text="Skip Bill" />
                                                                        </asp:TableCell></asp:TableRow>
                                                                    <asp:TableRow Height="15px" BorderWidth="0">
                                                                        <asp:TableCell HorizontalAlign="left">
                                                                            <asp:Button ID="btnBillShow" ToolTip="Click here to Generate the Bill" Style="cursor: pointer;"
                                                                                runat="server" Text="Finish" OnClick="btnBillShow_Click" CssClass="btn" OnClientClick="javascript:if(!checkItemsAdded()) return false;"
                                                                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnBillShowResource1" />
                                                                        </asp:TableCell></asp:TableRow>
                                                                </asp:Table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                        <ContentTemplate>
                                                            <table border="0" width="50%">
                                                                <tr>
                                                                    <td>
                                                                        <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none"
                                                                            meta:resourcekey="hiddenTargetControlForModalPopupResource1" />
                                                                        <ajc:ModalPopupExtender ID="programmaticModalPopup" runat="server" BackgroundCssClass="modalBackground"
                                                                            PopupControlID="pnlAttrib" TargetControlID="hiddenTargetControlForModalPopup"
                                                                            DynamicServicePath="" Enabled="True">
                                                                        </ajc:ModalPopupExtender>
                                                                        <asp:Panel ID="pnlAttrib" BorderWidth="1px" Width="44%" CssClass="modalPopup dataheaderPopup"
                                                                            runat="server" meta:resourcekey="pnlAttribResource1">
                                                                            <table border="2" style="border-color: Red;">
                                                                                <tr>
                                                                                    <td align="center">
                                                                                        <table>
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <asp:Label runat="server" ID="lblInvname" Text="Investigation Name" meta:resourcekey="lblInvnameResource1"></asp:Label>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:Label ID="lblHeader" runat="server" Text="Header" meta:resourcekey="lblHeaderResource1"></asp:Label>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:Label ID="lblDept" runat="server" Text="Department" meta:resourcekey="lblDeptResource1"></asp:Label>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <asp:TextBox ID="txtInvname" runat="server" meta:resourcekey="txtInvnameResource1"></asp:TextBox>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:DropDownList runat="server" ID="ddlHeader" meta:resourcekey="ddlHeaderResource1">
                                                                                                    </asp:DropDownList>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:DropDownList runat="server" ID="ddlDept" meta:resourcekey="ddlDeptResource1">
                                                                                                    </asp:DropDownList>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="center">
                                                                                        <table>
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                                        onmouseout="this.className='btn'" OnClick="Save_Click" meta:resourcekey="btnSaveResource1" />
                                                                                                </td>
                                                                                                <td align="center">
                                                                                                    <asp:Button ID="btnCancel" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                                        OnClick="btnCancel_Click" onmouseout="this.className='btn'" meta:resourcekey="btnCancelResource1" />
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="left">
                                                                                        <asp:Label runat="server" ID="lblStatus" Visible="False" meta:resourcekey="lblStatusResource1"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:Panel>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                                                <ProgressTemplate>
                                                                    <asp:Image ImageUrl="~/Images/ajax-loader.gif" ID="imgProg" runat="server" meta:resourcekey="imgProgResource1" />
                                                                </ProgressTemplate>
                                                            </asp:UpdateProgress>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
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

    <script language="javascript" type="text/javascript">
        //document.onkeydown = catchIt;
        window.onerror = handleError;
        function handleError() {
            return true;
        }
        function catchIt() {
            if (window.event.keyCode == 8) {
                return false;
            }
        }
    
    </script>

</body>
</html>
