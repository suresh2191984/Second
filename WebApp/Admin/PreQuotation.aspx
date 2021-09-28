+<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PreQuotation.aspx.cs" EnableEventValidation="false"
    Inherits="Billing_PreQuotation" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/BillingPart.ascx" TagName="BPart" TagPrefix="BillingPart" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>PreQuotation</title>
       <%-- <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>
    
    <script src="../Scripts/jquery-1.7.2.min.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/LabQuickBilling.js"></script>

    <script src="../Scripts/ServiceQuotation.js" type="text/javascript"></script>

    <script src="../Scripts/CommonBilling.js" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

    <%--    <script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>--%>
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../QMS/Script/jquery-ui-git.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .delete
        {
            width: 60px;
            border: none;
        }
    </style>

    <script type="text/javascript">
        function GetTableData() {
            var i = 0;
            var t = document.getElementById('flex1');
            $("#testtable tr").each(function() {
                var val1 = $(t.rows[i].cells[0]).text();
                alert(val1);
                i++;
            });
        }



        var AlertType;
        $(document).ready(function() {
            //         dvHealhcard.Style.Add("display", "none").hide;
            autocomplete();
            $('INPUT[type="text"]').focus(function() {
                $(this).addClass("focus");
            });
            $('INPUT[type="text"]').blur(function() {
                $(this).removeClass("focus");
            });
            AlertType = SListForAppMsg.Get('Billing_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Billing_Header_Alert');

            $("#testtable").on('click', '.btnDelete', function() {
                $(this).closest('tr').remove();
                return false;
            });
        });
    </script>

</head>
<body>
    <form id="form1" oncontextmenu="return false;" runat="server" onkeydown="SuppressBrowserRefresh();">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
        <Services>
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table style="border: thin;" class="w-100p">
            <tr class="v-top">
                <td>
                    <div class="dataheader3">
                        <%-- <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                            style="cursor: pointer;" />--%>
                        <asp:Panel CssClass="dataheaderInvCtrl" ID="PnlPatientDetail" runat="server" GroupingText="Patient Details"
                            meta:resourcekey="PnlPatientDetailResource1">                           
                                <table class="w-100p">
                                     <tr id="tblPre1" runat="server">
                                    <td>
                                        <table class="w-100p">
                                            <tr>
                                                <td class="w-7p">
                                                    <asp:Label ID="lblName" runat="server" Text="<u>N</u>ame" AssociatedControlID="txtName"
                                                        AccessKey="N" meta:resourcekey="lblNameResource1"></asp:Label>
                                                </td>
                                                <td class="w-26p">
                                                    <table class="w-100p" cellspacing="1">
                                                        <tr>
                                                            <td class="w-18p">
                                                                <asp:DropDownList ID="ddSalutation" runat="server">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtName" runat="server"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" onblur="javascript:ConverttoUpperCase(this.id);"
                                                                    autocomplete="off" CssClass="small"  meta:resourcekey="txtNameResource1" onkeydown = "return (event.keyCode!=13);">
                                                                </asp:TextBox>
                                                                <%-- <ajc:AutoCompleteExtender ID="AutoCompleteExtenderPatient" runat="server" TargetControlID="txtName"
                                                                                    ServiceMethod="GetLabQuickBillPatientList" ServicePath="~/OPIPBilling.asmx" EnableCaching="False"
                                                                                    CompletionInterval="1" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                                                                    Enabled="True">
                                                                                </ajc:AutoCompleteExtender>--%>
                                                                <img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="w-6p">
                                                    <asp:Label ID="lblSex" runat="server" Text="Se<u>x</u>" AssociatedControlID="ddlSex"
                                                        AccessKey="X" meta:resourcekey="lblSexResource1"></asp:Label>
                                                </td>
                                                <td class="w-25p">
                                                    <asp:DropDownList ID="ddlSex" runat="server">
                                                    </asp:DropDownList>
                                                    <input id="Hidden2" type="hidden" value="M" runat="server" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    <asp:Label ID="lblDOB" runat="server" Text="DO<u>B</u>" AssociatedControlID="tDOB"
                                                        AccessKey="B" meta:resourceKey="lblDOBResource1"></asp:Label>
                                                    <asp:Label Style="display: none;" ID="lblMarital" runat="server" Text="Marital Status" meta:resourcekey="lblMaritalResource1"></asp:Label>
                                                    <asp:DropDownList Style="display: none;" CssClass="ddlsmall" ID="ddMarital" runat="server">
                                                    </asp:DropDownList>
                                                    <img src="../Images/starbutton.png" style="display: none;" alt="" align="middle" />
                                                    <asp:TextBox ToolTip="dd/mm/yyyy" ID="tDOB" runat="server" onblur="javascript:countQuickAge(this.id);"
                                                        Style="text-align: justify" CssClass="small" ValidationGroup="MKE" meta:resourceKey="tDOBResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="tDOB"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                        CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="tDOB"
                                                        PopupButtonID="ImgBntCalc" Enabled="True" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td>
                                                    <table class="w-100p">
                                                        <tr class="w-100p">
                                                            <td class="w-8p" id="tdSex1" runat="server">
                                                                <asp:Label ID="lblAge" runat="server" Text="Age " meta:resourceKey="lblAgeResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-60p" id="tdSex2" runat="server">
                                                                <asp:TextBox ID="txtDOBNos" autocomplete="off" onblur="ClearDOB();" onchange="setDOBYear(this.id);"
                                                                         onkeypress="return ValidateOnlyNumeric(this);"    runat="server"
                                                                    CssClass="w-10p" MaxLength="3" Style="text-align: justify" meta:resourceKey="txtDOBNosResource1" />
                                                                                 <input type="hidden" id="hdnPatientDOB" runat="server" />
                                                                <asp:DropDownList onChange="getDOB();setDDlDOBYear(this.id);" ID="ddlDOBDWMY" runat="server"
                                                                    CssClass="ddlsmall">
                                                                </asp:DropDownList>
                                                                <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                <ajc:TextBoxWatermarkExtender ID="txt_DOB_TextBoxWatermarkExtender" runat="server"
                                                                    Enabled="True" TargetControlID="tDOB" WatermarkCssClass="watermarked" WatermarkText="dd/MM/yyyy">
                                                                </ajc:TextBoxWatermarkExtender>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="tblPre2" runat="server">
                                    <td>
                                        <table class="w-100p">
                                            <tr>
                                                <td class="w-7p">
                                                    <asp:Label ID="lblMobile" runat="server" Text="<u>M</u>obile" AssociatedControlID="txtMobileNumber"
                                                        AccessKey="M" meta:resourcekey="lblMobileResource1"></asp:Label>
                                                </td>
                                                <td class="w-26p">
                                                    <%--  <asp:CheckBox ID="chkMobileNotify" Text="SMS" ToolTip="Send SMS Notification" runat="server" />
                                                                    <asp:Label ID="lblCountryCode" runat="server"></asp:Label>--%>
                                                    <asp:TextBox ID="txtMobileNumber" autocomplete="off"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                        runat="server" MaxLength="12" CssClass="small" meta:resourcekey="txtMobileNumberResource1"></asp:TextBox>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td class="w-6p">
                                                    <asp:Label ID="lblLandLine" runat="server" Text="<u>T</u>elephone" AssociatedControlID="txtPhone"
                                                        AccessKey="T" meta:resourcekey="lblLandLineResource1"></asp:Label>
                                                </td>
                                                <td class="w-20p">
                                                    <asp:TextBox ID="txtPhone" autocomplete="off"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                        runat="server" MaxLength="15" CssClass="small" meta:resourcekey="txtPhoneResource1"></asp:TextBox>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                                <td>
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="w-8p a-right">
                                                                <asp:Label ID="lblEmail" Text="<u>E</u>-mail" runat="server" AssociatedControlID="txtEmail"
                                                                    AccessKey="E" meta:resourcekey="lblEmailResource1"></asp:Label>
                                                            </td>
                                                            <td class="w-25p">
                                                                <asp:TextBox ID="txtEmail" autocomplete="off" runat="server" CssClass="small" meta:resourcekey="txtEmailResource1" onkeydown = "return (event.keyCode!=13);" ></asp:TextBox>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" style="display: none;"
                                                                    id="imageEmail" runat="server" />
                                                                <%-- <asp:RegularExpressionValidator ID="regValidator" runat="server" ErrorMessage="Email is not vaild."
                                                                        ControlToValidate="txtEmail" ValidationExpression="^\s*(([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+)*\s*$"
                                                                        ValidationGroup="register" meta:resourceKey="regValidatorResource1">Email 
                                                            not valid</asp:RegularExpressionValidator>--%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="tblPre3" runat="server">
                                    <td>
                                        <table class="w-100p" id="1">
                                            <tr>
                                                <td class="w-7p">
                                                    <asp:Label ID="Rs_ClientName" runat="server" Text="<u>C</u>lient Name" AssociatedControlID="txtClient"
                                                        AccessKey="C" meta:resourcekey="Rs_ClientNameResource1"></asp:Label>
                                                </td>
                                                <td class="w-26p">
                                                    <asp:TextBox ID="txtClient" onfocus="CheckOrderedItems();" autocomplete="off" runat="server"
                                                        CssClass="small" meta:resourcekey="txtClientResource1" onkeydown = "return (event.keyCode!=13);"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" TargetControlID="txtClient"
                                                        EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetRateCardForBilling"
                                                        ServicePath="~/OPIPBilling.asmx" OnClientItemSelected="ClientSelected" DelimiterCharacters=""
                                                        Enabled="True" OnClientItemOver="SelectedTempClient">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td class="w-6p" id="tdRefDrPart" runat="server">
                                                    <asp:Label ID="lblRefby" runat="server" AccessKey="D" AssociatedControlID="txtInternalExternalPhysician"
                                                        Text="Ref Dr." meta:resourcekey="lblRefbyResource1"></asp:Label>
                                                </td>
                                                <td class="w-20p" id="tdRefDrParttxt" runat="server">
                                                    <asp:TextBox ID="txtInternalExternalPhysician" runat="server" CssClass="AutoCompletesearchBox" Height="21px"
                                                        onkeydown = "return (event.keyCode!=13);" ></asp:TextBox>
                                                          <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    <%--<ajc:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" CompletionInterval="1"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionSetCount="10" EnableCaching="false"
                                                        OnClientShown="DocPopulated" FirstRowSelected="true" MinimumPrefixLength="2"
                                                        OnClientItemSelected="PhysicianSelected" ServiceMethod="GetRateCardForBilling"
                                                        ServicePath="~/OPIPBilling.asmx" OnClientItemOver="PhysicianTempSelected" TargetControlID="txtInternalExternalPhysician">
                                                    </ajc:AutoCompleteExtender>--%>
                                                </td>
                                                <td></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table> 
                            <tr id="trSTATOutSource" runat="server" style="display: table-row;">
                                    <td colspan="2">
                                        <asp:TextBox ID="txtStatColor" Style="background-color: #EEB4B4;" ReadOnly="True"
                                            runat="server" Height="5px" TabIndex="-1" Width="5px" meta:resourcekey="txtStatColorResource1"></asp:TextBox>
                                        <asp:Label ID="lblStatTestColor" Text="STAT Test" runat="server" meta:resourcekey="lblStatTestColorResource1"></asp:Label>&nbsp;
                                        <asp:TextBox ID="txtOutsourceTest" Style="background-color: #D0FA58;" ReadOnly="True"
                                            runat="server" Height="5px" TabIndex="-1" Width="5px" meta:resourcekey="txtOutsourceTestResource1"></asp:TextBox>
                                        <asp:Label ID="lblOutSourceTestColor" runat="server" Text="Out Source" meta:resourcekey="lblOutSourceTestColorResource1"></asp:Label>&nbsp;
                                        <asp:TextBox ID="txtinvcolor" Style="background-color: #000000;" ReadOnly="True"
                                            runat="server" Height="5px" TabIndex="-1" Width="5px" meta:resourcekey="txtinvcolorResource1"></asp:TextBox>
                                        <asp:Label ID="lblinvcolor" Text="Investigation" runat="server" meta:resourcekey="lblinvcolorResource1"></asp:Label>&nbsp;
                                        <asp:TextBox ID="txtgrpcolor" Style="background-color: #C71585;" ReadOnly="True"
                                            runat="server" Height="5px" TabIndex="-1" Width="5px" meta:resourcekey="txtgrpcolorResource1"></asp:TextBox>
                                        <asp:Label ID="lblgrpcolor" Text="Group" runat="server" meta:resourcekey="lblgrpcolorResource1"></asp:Label>&nbsp;
                                        <asp:TextBox ID="txtpkgcolor" Style="background-color: #6699FF;" ReadOnly="True"
                                            runat="server" Height="5px" TabIndex="-1" Width="5px" meta:resourcekey="txtpkgcolorResource1"></asp:TextBox>
                                        <asp:Label ID="lblpkgcolor" Text="Package" runat="server" meta:resourcekey="lblpkgcolorResource1"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td class="w-55p">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="w-15p">
                                                    <asp:Label ID="lblTestName" Text="Test Name" runat="server" meta:resourcekey="lblTestNameResource1"></asp:Label>
                                                </td>
                                                <td class="w-50p">
                                                    <asp:TextBox ID="txtTestName1" runat="server" Height="20px"
                                                        Width="350px" Style="margin-top: 0px"  onkeydown = "return (event.keyCode!=13);" ></asp:TextBox>
                                                        </td>
                                                    <%--<ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtTestName1"
                                                        EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" OnClientItemSelected="BillingItemSelected"
                                                        
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetBillingItems"
                                                        FirstRowSelected="false"  UseContextKey="True" DelimiterCharacters=""
                                                        OnClientShown="InvPopulated" Enabled="True" OnClientPopulated="onTestListPopulated">
                                                    </ajc:AutoCompleteExtender>--%>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" ServiceMethod="GetBillingItems"
                                                        MinimumPrefixLength="2" CompletionInterval="10" CompletionSetCount="10" TargetControlID="txtTestName1"
                                                        FirstRowSelected="false" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" OnClientItemSelected="BillingItemSelected"
                                                        OnClientShown="InvPopulated" DelimiterCharacters="" EnableCaching="False" Enabled="True"
                                                        UseContextKey="True">
                                                    </ajc:AutoCompleteExtender>
                                                    &nbsp;
                                                    <td>
                                                    <asp:Button ID="btnadd" runat="server" Text="Add" CssClass="btn" width="30px"
                                                        OnClientClick="return AddButton();" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                               
                                
                                <tr><td> <table id="testtable" width="150%" border="1px;" cellpadding="0" cellspacing="0">
                                    <tr class='dataheader1'>
                                        <th scope='col' style='width: 15%;'>
                                            Test Name
                                        </th>
                                        <th scope='col' style='width: 5%;'>
                                            FeeID
                                        </th>
                                        <th scope='col' style='width: 5%;'>
                                            FeeType
                                        </th>
                                        <th style='width: 5%;'>
                                            Rate
                                        </th>
                                        <th style='width: 5%;'>
                                            Delete
                                        </th>
                                    </tr>
                                </table></td></tr>
                                <tr>
                                    <td>
                                        <BillingPart:BPart ID="billPart" runat="server" Visible="false" />
                                    </td>
                                    <td>
                                        <div id="divPrint" runat="server" style="display: none;">
                                            <asp:Label ID="lblPrintCCBillDetail" runat="server" meta:resourcekey="lblPrintCCBillDetailResource1"></asp:Label>
                                        </div>
                                    </td>
                                    <td id="divShowClientDetails" class="w-35p" style="display: none; position: absolute;
                                        left: 62%; top: 1%">
                                        <%--<div onclick="Itemhidebox();return false" class="divCloseRight">
                    </div>--%>
                                        <table cellspacing="1" class="w-32p modalPopup dataheaderPopup" cellpadding="1">
                                            <tr>
                                                <td id="Td5" class="w-100p" style="cursor: move; cursor: pointer">
                                                    <asp:Label ID="lblClientDetails" runat="server" meta:resourcekey="lblClientDetailsResource1" />
                                                    &nbsp;
                                                    <asp:DropDownList ID="ddCountry" onchange="javascript:loadState();" runat="server"
                                                        CssClass="ddlsmall">
                                                    </asp:DropDownList>
                                                    <asp:DropDownList ID="ddlRate" runat="server" Enabled="False" CssClass="ddlsmall"
                                                        onChange="javascript:setRate(this.value);">
                                                        <%-- <asp:ListItem Selected="True" meta:resourcekey="ListItemResource1">--Select--</asp:ListItem>--%>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table class="w-100p">
                                            <tr class="a-left">
                                                <td class="a-left w-15p">
                                                    <asp:CheckBox ID="chkboxPrintQuotation" Text="Print Quotation" runat="server" class="defaultfontcolor"
                                                        Checked="true" meta:resourcekey="chkboxPrintQuotationResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr class="a-center">
                                    <td class="dataheader3">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" OnClick="btnSave_Click"
                                                        OnClientClick="javascript:return validateEvents();" meta:resourcekey="btnSaveResource1" />
                                                </td>
                                                <%--<td>
                                <asp:Button ID="btnSaveBook" runat="server" Text="Save&Book" CssClass="btn" Visible="False"
                                    OnClientClick="return OpenBillPrint()" meta:resourcekey="btnSaveBookResource1" />
                            </td>--%>
                                                <td>
                                                    <button runat="server" id="btnClose" class="btn" onclick="javascript:clearSQControls(1);">
                                                        <%=Resources.Billing_ClientDisplay.Billing_ServiceQuotation_aspx_01 %></button>
                                                    <%-- <%=Resources.Billing_ClientDisplay.Billing_ServiceQuotation_aspx_01 %></button>--%>
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
        </table>
    </div>
    <input id="hdnMinimumDue" type="hidden" value="" runat="server" />
    <input id="hdnMinimumDuePercent" type="hidden" value="" runat="server" />
    <input id="hdnPatientID" type="hidden" value="-1" runat="server" />
    <input id="hdnPatientNumber" type="hidden" value="0" runat="server" />
    <input id="hdnMobileNumber" type="hidden" value="0" runat="server" />
    <input id="hdnQuotesGivenBy" type="hidden" value="" runat="server" />
    <input id="hdnQuotesDate" type="hidden" value="" runat="server" />
    <input id="hdnPatientDetails" type="hidden" runat="server" />
    <input id="hdnSelectedPatientTempDetails" type="hidden" value="0" runat="server" />
    <input id="hdnSelectedClientTempDetails" type="hidden" value="0" runat="server" />
    <input id="hdnOutSourceInvestigations" type="hidden" runat="server" />
    <input id="hdnOPIP" type="hidden" runat="server" value="OP" />
    <input id="hdnVisitPurposeID" type="hidden" value="-1" runat="server" />
    <input id="hdnReferedPhyID" type="hidden" value="0" runat="server" />
    <input id="hdnReferedPhyName" type="hidden" value="" runat="server" />
    <input id="hdnReferedPhysicianCode" type="hidden" value="0" runat="server" />
    <input id="hdnReferedPhysicianRateID" type="hidden" value="-1" runat="server" />
    <input id="hdnReferingPhysicianClientID" type="hidden" value="0" runat="server" />
    <input id="hdnReferingPhysicianMappingID" type="hidden" value="0" runat="server" />
    <input id="hdnReferedPhyType" type="hidden" value="" runat="server" />
    <input id="hdnRefPhySpecialityID" type="hidden" value="-1" runat="server" />
    <input id="hdnCollectionCenterID" type="hidden" value="-1" runat="server" />
    <input id="hdnCollectionCenterName" type="hidden" value="" runat="server" />
    <input id="hdnCollectionCenterCode" type="hidden" value="-1" runat="server" />
    <input id="hdnCollectionCenterRateID" type="hidden" value="-1" runat="server" />
    <input id="hdnCollectionCenterClientID" type="hidden" value="0" runat="server" />
    <input id="hdnCollectionCenterMappingID" type="hidden" value="0" runat="server" />
    <input id="hdnSelectedClientID" type="hidden" value="-1" runat="server" />
    <input id="hdnSelectedClientName" type="hidden" value="" runat="server" />
    <input id="hdnSelectedClientCode" type="hidden" value="-1" runat="server" />
    <input id="hdnSelectedClientRateID" type="hidden" value="-1" runat="server" />
    <input id="hdnSelectedClientClientID" type="hidden" value="0" runat="server" />
    <input id="hdnSelectedClientMappingID" type="hidden" value="0" runat="server" />
    <input id="hdfReferalHospitalID" type="hidden" value="0" runat="server" />
    <input id="hdnReferingHospitalName" type="hidden" value="0" runat="server" />
    <input id="hdnClientID" type="hidden" value="-1" runat="server" />
    <input id="hdnTPAID" type="hidden" value="-1" runat="server" />
    <input id="hdnClientType" type="hidden" value="CRP" runat="server" />
    <input id="hdnPageUrl" type="hidden" runat="server" />
    <input id="hdnBaseRateID" type="hidden" value="0" runat="server" />
    <input id="hdnBaseClientID" type="hidden" value="0" runat="server" />
    <input id="hdnPatientStateID" type="hidden" value="0" runat="server" />
    <input id="hdnPreviousVisitDetails" type="hidden" value="" runat="server" />
    <input id="hdnOrgID" type="hidden" value="0" runat="server" />
    <input id="hdnPatientAlreadyExists" type="hidden" value="0" runat="server" />
    <input id="hdnDefaultCountryID" type="hidden" value="0" runat="server" />
    <input id="hdnDefaultStateID" type="hidden" value="0" runat="server" />
    <input id="hdnPatientAlreadyExistsWebCall" type="hidden" value="0" runat="server" />
    <input id="hdnDefaultOrgBillingItems" type="hidden" value="" runat="server" />
    <input id="hdnIsReceptionPhlebotomist" value="N" runat="server" type="hidden" />
    <input id="hdnBillGenerate" value="N" runat="server" type="hidden" />
    <input id="hdnGender" runat="server" value="" type="hidden" />
    <asp:HiddenField ID="hdnLstPatientInvSample" runat="server" />
    <asp:HiddenField ID="hdnLstSampleTracker" runat="server" />
    <asp:HiddenField ID="hdnLstPatientInvSampleMapping" runat="server" />
    <asp:HiddenField ID="hdnLstInvestigationValues" runat="server" />
    <asp:HiddenField ID="hdnLstCollectedSampleStatus" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <input type="hidden" id="hdnVisitID" runat="server" />
    <input type="hidden" id="hdnGuID" runat="server" />
    <input type="hidden" id="hdnFinalBillID" value="-1" runat="server" />
    <input type="hidden" id="hdnClientBalanceAmount" value="-1" runat="server" />
    <input type="hidden" id="hdnCashClient" runat="server" />
    <input type="hidden" runat="server" id="hdnDefaultRoundoff" />
    <input type="hidden" runat="server" id="hdnRoundOffType" />
    <input type="hidden" runat="server" value="N" id="hdnIsMappedItem" />
    <input type="hidden" runat="server" value="LABB" id="hdnBillingPageName" />
    <input id="hdnMappingClientID" type="hidden" value="-1" runat="server" />
    <input type="hidden" runat="server" value="N" id="hdnIsCashClient" />
    <input type="hidden" runat="server" value="N" id="hdnIsEditMode" />
    <input id="Hidden1" type="hidden" value="0" runat="server" />
    <input type="hidden" runat="server" value="" id="hdnId" />
    <input type="hidden" runat="server" id="hdnDoFrmVisit" />
    <input type="hidden" runat="server" id="hdnConfig" />
    <input type="hidden" runat="server" id="hdnTestDetailes" />
    <input type="hidden" runat="server" id="hdnTestvalue" />
    <%--<asp:HiddenField ID="hdnFeeID" runat="server" />--%>
    <input type="hidden" runat="server" id="hdnFeeID" />
    <input type="hidden" runat="server" id="hdnFeeType" />
    <input type="hidden" runat="server" id="hdnSearchtext" />
    <input type="hidden" runat="server" id="hdnFeeType1" />
   <input type="hidden" runat="server" id="hdfBillType1" value="" />
    <input type="hidden" runat="server" id="hdnBookingID" />
    <input type="hidden" runat="server" id="hdnConfigID" />
    <%--<input type="hidden" runat="server" id="hdnRateID" />
    <input type="hidden" runat="server" id="hdnTestID" />--%>
    <%--<asp:HiddenField ID="hdnTestID" runat="server" Value="COM" />
    <asp:HiddenField ID="hdnRateID" runat="server" Value="0" />--%>
    <input id="hndLocationID" type="hidden" value="0" runat="server" />
    <%-- <input type="text" runat="server" id="txtPhleboName" value="Y" />--%>
    <asp:HiddenField ID="hdncollectcashforcreditclient" runat="server" Value="N" />
    <asp:HiddenField ID="HdnPhleboNameMandatory" runat="server" Value="N" />
    <asp:HiddenField ID="hdnPreQuotation" runat="server" Value="Y" />
    <asp:HiddenField ID="hdnView" runat="server" Value="N" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />

    <script type="text/javascript">

        if (document.getElementById('hdnBillGenerate').value == "Y") {
            document.getElementById('trCollectSample').style.display = "table-row";
            showResponses('divBill1', 'divBill2', 'divBill3', 0);
            showResponses('divBill1', 'divBill2', 'divOrder', 0);
        }
    </script>

    <script type="text/javascript" language="javascript">
        /* Common Alert Validation */
        //        var AlertType;
        //        $(document).ready(function() {
        //            //         dvHealhcard.Style.Add("display", "none").hide;
        //            autocomplete();
        //            $('INPUT[type="text"]').focus(function() {
        //                $(this).addClass("focus");
        //            });
        //            $('INPUT[type="text"]').blur(function() {
        //                $(this).removeClass("focus");
        //            });
        //            AlertType = SListForAppMsg.Get('Billing_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Billing_Header_Alert');

        //            $("#testtable").on('click', '.btnDelete', function() {
        //                $(this).closest('tr').remove();
        //                return false;
        //            });
        //        });
//        function OpenBillPrint() {
//            /* Added By Venkatesh S */
//            var vPatientName = SListForAppMsg.Get('Billing_ServiceQuotation_aspx_01') == null ? "Enter Patient Name" : SListForAppMsg.Get('Billing_ServiceQuotation_aspx_01');
//            var vDOB = SListForAppMsg.Get('Billing_ServiceQuotation_aspx_02') == null ? "Enter DOB" : SListForAppMsg.Get('Billing_ServiceQuotation_aspx_02');
//            var vTelephoneNo = SListForAppMsg.Get('Billing_ServiceQuotation_aspx_03') == null ? "Provide contact mobile or telephone number" : SListForAppMsg.Get('Billing_ServiceQuotation_aspx_03');
//            var vRefPhyName = SListForAppMsg.Get('Billing_ServiceQuotation_aspx_05') == null ? "Enter Referring Physician Name" : SListForAppMsg.Get('Billing_ServiceQuotation_aspx_05');
//            var vPreQuotation = SListForAppMsg.Get('Billing_ServiceQuotation_aspx_04') == null ? "Add Test to Print PreQuotation" : SListForAppMsg.Get('Billing_ServiceQuotation_aspx_04');
//            //            if (document.getElementById('txtName').value == "") {
//            //                //alert('Enter Patient Name');
//            //                ValidationWindow(vPatientName, AlertType);
//            //                document.getElementById('txtName').focus();
//            //                return false;
//            //            }
//            //            else if (document.getElementById('txtDOBNos').value == "") {
//            //                //alert('Enter DOB');
//            //                ValidationWindow(vDOB, AlertType);
//            //                document.getElementById('txtDOBNos').focus();
//            //                return false;
//            //            }
//            //            if ($.trim($('#txtMobileNumber').val()) == '' && $.trim($('#txtPhone').val()) == '') {
//            //                //alert('Provide contact mobile or telephone number');
//            //                ValidationWindow(vTelephoneNo, AlertType);
//            //                $('#txtMobileNumber').focus();
//            //                return false;
//            //            }
//            //            else if (document.getElementById('hdnReferedPhyID').value == 0 || document.getElementById('txtInternalExternalPhysician').value == '') {
//            //                ValidationWindow(vRefPhyName, AlertType);
//            //                document.getElementById('txtInternalExternalPhysician').focus();
//            //                return false;
//            //            }
//            //            //            else if (document.getElementById('txtMobileNumber').value == "") {
//            //            //                alert('Enter Mobile Number');
//            //            //                document.getElementById('txtMobileNumber').focus();
//            //            //                return false;
//            //            //            }
//            //            //            else if (document.getElementById('txtEmail').value == "") {
//            //            //                alert('Enter Email');
//            //            //                document.getElementById('txtEmail').focus();
//            //            //                return false;
//            //            //            }
//            //            //            else if (document.getElementById('txtClient').value == "") {
//            //            //                alert('Enter Client Name');
//            //            //                document.getElementById('txtClient').focus();
//            //            //                return false;
//            //            //            }
//            if ($.trim($('[id$="hdfBillType1"]').val()) == '') {
//                alert('Add Test to Print PreQuotation');
//                ValidationWindow(vServiceQuotation, AlertType);
//                return false;
//            }


        //        }

        
           
        
        
        function validateEvents() {

            if (document.getElementById('hdnConfigID').value == 'Y') {

            if (document.getElementById('txtName').value == '') {


                ValidationWindow("Provide Patient Name", "Alert");
                return false;
            }
            if (document.getElementById('ddlSex').value == '') {


                ValidationWindow("Provide Gender", "Alert");
                return false;
            }
            if (document.getElementById('txtDOBNos').value == '') {


                    ValidationWindow("Provide DOB", "Alert");
                    return false;
                }
                if (document.getElementById('txtMobileNumber').value == '' && document.getElementById('txtPhone').value == '') {


                    ValidationWindow("Provide Contact number", "Alert");
                    return false;
                }
//                if (document.getElementById('txtMobileNumber').value == '') {


//                    ValidationWindow("vProvidecontactmobile", "Alert");
//                    return false;
//                }
                if (document.getElementById('txtInternalExternalPhysician').value == '') {


                    ValidationWindow("Provide Ref.Physician", "Alert");
                    return false;
                }

               
            }


            if (document.getElementById('hdfBillType1').value == '') {


                ValidationWindow("Provide TestName", "Alert");
                return false;
            }
        }
           
        
        function BillingItemSelected(source, eventArgs) {
            AutoCompSelected = true;
            var varGetVal = eventArgs.get_value();
            var arrGetVal = new Array();
            var FeeID;
            var FeeType;


            arrGetVal = varGetVal.split("~");
            FeeID = arrGetVal[2];
            FeeType = arrGetVal[1];
           // BillType1 = arrGetVal[3];
            document.getElementById('hdnFeeID').value = arrGetVal[2];
            document.getElementById('hdnFeeType').value = arrGetVal[1];
//            document.getElementById('hdfBillType1').value = arrGetVal[3];
              document.getElementById('btnadd').focus();

        }
        function homeCollection() {
            var hdnID = document.getElementById('hdnId').value;
            window.location.href("../Lab/homecollection.aspx?bookingID=" + hdnID + "&IsPopup=Y");
        }
        function autocomplete() {
            $("#txtInternalExternalPhysician").autocomplete({
                source: function(request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: '../OPIPBilling.asmx/GetRateCardForBilling',

                        data: JSON.stringify({ prefixText: request.term, contextKey: "RPH" + '^' + document.getElementById('hdnOrgID').value + '^' + document.getElementById('hdfReferalHospitalID').value }),
                        dataType: "json",
                        success: function(data) {
                            if (data.d.length > 0) {

                                response($.map(data.d, function(item) {
                                    var txt = JSON.parse(item);
                                    var rsltlable = txt["First"];
                                    var rsltvalue = txt["Second"];
                                    return {
                                        label: rsltlable,
                                        val: rsltvalue
                                    }
                                }))
                            }
                            else {
                                response([{ label: "No Data found", val: -1}]);

                            }
                        },
                        error: function(response) {
                            alert(response.responseText);
                        },
                        failure: function(response) {
                            alert(response.responseText);
                        }
                    });
                },

                select: function(e, i) {
                    if (i.item.val == -1) {
                        $("#hdnReferedPhyID").val("");
                        $("#hdnReferedPhyName").val("")
                        $("#hdnReferedPhysicianCode").val("")
                        $("#hdnReferedPhyType").val("")
                    }
                    else {
                        //objAlert = SListForAppMsg.Get("Scripts_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_Alert");


                        var PhysicianID;
                        var PhysicianName;
                        var PhysicianCode;
                        var PhysicianType;
                        //document.getElementById('txtInternalExternalPhysician').value = eventArgs.get_text();
                        var PhyType;
                        var list = i.item.val.split('^');
                        //List[0] PhysicianType
                        //List[1] PhysicianID
                        //List[2] PhysicianName
                        //List[3] PhysicianCode
                        if (list.length > 0) {
                            for (i = 0; i < list.length; i++) {
                                if (list[i] != "") {
                                    PhysicianID = list[1];
                                    PhysicianName = list[2];
                                    PhysicianCode = list[3];
                                    PhysicianType = list[0].trim();
                                    PhyType = list[4];
                                }
                            }
                        }
                        document.getElementById('hdnReferedPhyID').value = PhysicianID;
                        document.getElementById('hdnReferedPhyName').value = PhysicianName;
                        document.getElementById('hdnReferedPhysicianCode').value = PhysicianCode;
                        document.getElementById('hdnReferedPhyType').value = PhysicianType;
                    }
                },
                minLength: 2
            });
        }

        function AddButton() {

            if (document.getElementById('hdnConfigID').value == 'Y') {

                if (document.getElementById('txtName').value == '') {


                ValidationWindow("Provide Patient Name", "Alert");
                return false;
            }
            if (document.getElementById('ddlSex').value == '') {


                ValidationWindow("Provide Gender", "Alert");
                return false;
            }
            if (document.getElementById('txtDOBNos').value == '') {


                    ValidationWindow("Provide DOB", "Alert");
                    return false;
                }
//                if (document.getElementById('txtMobileNumber').value == '') {


//                    ValidationWindow("Provide Contact", "Alert");
//                    return false;
//                }
                if (document.getElementById('txtMobileNumber').value == '' && document.getElementById('txtPhone').value == '') {


                    ValidationWindow("Provide Contact number", "Alert");
                    return false;
                }
                if (document.getElementById('txtInternalExternalPhysician').value == '') {


                    ValidationWindow("Provide ExternalPhysician", "Alert");
                    return false;
                }
            }

            if (document.getElementById('txtTestName1').value == '') {


                ValidationWindow("Provide TestName", "Alert");
                return false;
            }

            var OrgID = document.getElementById('hdnOrgID').value;
            var FeeID = document.getElementById('hdnFeeID').value;
            var FeeType = document.getElementById('hdnFeeType').value;
            var TestName;
            var Amount;
            
            var arrGotValue = new Array();
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/pGetBillingTestItemsSV",
                contentType: "application/json;charset=utf-8",
                data: "{'OrgID':" + parseInt(OrgID) + ",'FeeID':" + parseInt(FeeID) + ",'FeeType':'" + FeeType + "'}",
                dataType: "json",
                async: false,
                success: function(data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            TestName = data.d[0].FeeDescription;

                            Amount = data.d[0].Rate;
                            //                            if (arrGotValue.length > 0) {
                            //                                FeeId = arrGotValue[2];
                            //                                FeeType = arrGotValue[1];

                            //                                if (document.getElementById('txtVariableRate').value == "") {
                            //                                    amount = arrGotValue[3];
                            //                                } else {
                            //                                    amount = document.getElementById('txtVariableRate').value;
                            //                                }
                            //}


                        }
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    // alert(" Enter VisitNumber Error in Webservice pGetBulkResultEntry calling");
                    // $('#ManualResultEntryTbl').hide();
                    return false;
                }
            });
            document.getElementById('hdfBillType1').value = document.getElementById('hdfBillType1').value + "|" + "FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + TestName + "~Amount^" + Amount;
            CreateADDTable(FeeID, FeeType, TestName, Amount);
            //$('#hdfBillType1').val("FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + TestName + "~Amount^" + Amount);
            document.getElementById('txtTestName1').value = "";
            return false;
        }

        function CreateADDTable(FeeID, FeeType, TestName, Amount) {
            // document.getElementById('DivBillingTable').innerHTML = "";
            var startHeaderTag, newPaymentTables, startPaymentTag;
            //startHeaderTag = "<table id='t1' width='50%'  border='1px;' cellpadding='0' cellspacing='0'>";
            //startHeaderTag += "<TR class='dataheader1'><th  scope='col' style='width:15%;'>Test Name</th><th  scope='col' style='width:5%;'>FeeID</th><th scope='col' style='width:5%;'> FeeType </th> <th style='width:5%;'> Rate </th><th style='width:5%;'> Delete </th></TR>"

            // newPaymentTables = startHeaderTag;




            newPaymentTables = "<TR ID='test'>";


            if (FeeType == 'GRP') {
                newPaymentTables += "<TD ><input type='button' value ='" + TestName + "' style='width:250px;word-wrap: break-word;color:#C71585;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer' /></TD>";
            }
            else if (FeeType == 'PKG') {
                newPaymentTables += "<TD ><input type='button' value ='" + TestName + "' style='width:250px;word-wrap: break-word;color:#6699FF;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer'/></TD>";
            }
            else if (FeeType != "INV") {
                newPaymentTables += "<TD ><input type='button' value ='" + TestName + "' style='width:250px;word-wrap: break-word;background-color:Transparent;font-size:9px;border-style:none;text-align:left;text-decoration:underline;cursor:pointer'/></TD>";
            }

            else {
                newPaymentTables += "<TD ><input value ='" + TestName + "' type='button' style='width:250px;word-wrap: break-word;background-color:Transparent;font-size:10px;border-style:none;text-align:left;' /></TD>"
            }


            newPaymentTables += "<TD>" + FeeID + "</TD>";

            newPaymentTables += "<TD>" + FeeType + "</TD>";
            newPaymentTables += "<TD>" + Amount + "</TD>";


            newPaymentTables += "<TD> <button class='delete' Id='btnDelete' onclick='DeleteRow(this)'> Delete </button></TD>";


           
          //  document.getElementById('testtable').value = newPaymentTables;

            newPaymentTables += "</TR>";
            $("#testtable").append(newPaymentTables);
            var FeeViewStateValue;
            
            
           // FeeViewStateValue = "FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + TestName + "~Amount^" + Amount;
           // $('#hdfBillType1').val("FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + TestName + "~Amount^" + Amount);
           // document.getElementById('hdfBillType1').value= document.getElementById('hdfBillType1').value +"|"+ FeeViewStateValue;

        }



        function DeleteRow(row) {
            var i = row.parentNode.parentNode.rowIndex;
            document.getElementById('testtable').deleteRow(i);
            addRowHandlers('testtable');

        }
        function addRowHandlers(tableId) {
            if (document.getElementById(tableId) != null) {
                var table = document.getElementById(tableId);
                var rows = table.getElementsByTagName('tr');
                var TestName = '';
                var FeeID = '';
                var FeeType = '';
                var Amount = '';
                document.getElementById('hdfBillType1').value = "";
                for (var i = 1; i < rows.length; i++) {

                    rows[i].i = i;
                    //rows[i].onclick = function() {

                    TestName = table.rows[i].cells[0].firstElementChild.value;
                    FeeID = table.rows[i].cells[1].innerHTML;
                    FeeType = table.rows[i].cells[2].innerHTML;
                    Amount = table.rows[i].cells[3].innerHTML;
                    document.getElementById('hdfBillType1').value = document.getElementById('hdfBillType1').value + "|" + "FeeID^" + FeeID + "~FeeType^" + FeeType + "~Descrip^" + TestName + "~Amount^" + Amount;
//                    alert('Test Name: ' + TestName + ' FeeID: ' + FeeID + ' FeeType: ' + FeeType + ' Rate: ' + Amount);
//                    alert(document.getElementById('hdfBillType1').value);
                    ///};
                }
            }
        }

        function InvPopulated(sender, e) {

            var behavior = $find('AutoCompleteExtender3');
            var target = behavior.get_completionList();
            for (i = 0; i < target.childNodes.length; i++) {
                var text = target.childNodes[i]._value;
                var ItemArray;
                ItemArray = text.split('~');

                if (ItemArray[1].trim().toLowerCase() == 'inv') {
                    // target.childNodes[i].className = "focus"

                    target.childNodes[i].style.color = "Black";
                    //target.childNodes[i].style.fontcolor('Orange');
                }
                else if (ItemArray[1].trim().toLowerCase() == 'pkg') {
                    target.childNodes[i].style.color = "blue";

                }
                else {

                    target.childNodes[i].style.color = "MediumVioletRed";
                    //target.childNodes[i].style.fontcolor('red');
                }

            }

        }


        function GetData() {

            // var OrgId = document.getElementById('hdnOrgID').value;
            //var Searchtext = document.getElementById('txtVisitNumber').value;


            $.ajax({

                type: "POST",
                url: "../WebService.asmx/PgetPreQuotation",
                contentType: "application/json;charset=utf-8",
                data: "{'OrgID':" + OrgId + ",'VisitNumber':" + VisitNumber + "}",
                dataType: "json",
                async: false,
                success: AjaxGetFieldDataSucceeded,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(" Enter VisitNumber Error in Webservice PgetPreQuotation calling");
                    // $('#ManualResultEntryTbl').hide();
                    return false;
                }
            });



            //$('#ManualResultEntryTbl').show();
            return false;
            //  event.preventDefault();



        }
        function OpenBillPrint(url) {
            window.open(url + "&billprint", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
        }
        function CreatePaymentTables() {
        }
    </script>

    </form>
</body>
</html>
