<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VisitStateChangedScreen.aspx.cs"
    Inherits="Reception_VisitStateChangedScreen" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        function DataValidationDone() {
            var response = window.confirm("Do you want to Admit this Patient?");
            if (response) {
                $get('btnOK').disabled = true;
                javascript: __doPostBack('btnOK', '');
            }
            else {
                return false;
            }

        }
        function showModalPopup(evt, footDescID, footAmtID) {


            var modalPopupBehavior = $find('mpeOthersBehavior');
            modalPopupBehavior.show();
        }
        function Formvalidation() {
            if (document.getElementById('txtBillNo').value == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\VisitStateChangedScreen.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else { alert('Please Enter Bill No'); }
                return false;
            }
            if (document.getElementById('txtApprovedBy').value == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\VisitStateChangedScreen.aspx_2');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert('Please Enter Approved By');
                }
                return false;
            }
            if (document.getElementById('txtReason').value == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\VisitStateChangedScreen.aspx_3);
                if (userMsg != null) {
                    alert(userMsg);
                }else{
                alert('Please Enter reason');
                return false;
            }

        }
        function expandTextBox(id) {
            document.getElementById(id).rows = "5";
            document.getElementById(id).cols = "20";
            ConverttoUpperCase(id);
        }
        function collapseTextBox(id) {
            document.getElementById(id).rows = "2";
            document.getElementById(id).cols = "20";
            ConverttoUpperCase(id);

        }
        function ResetValue() {
            document.getElementById('txtBillNo').value = ''
            document.getElementById('txtApprovedBy').value = ''
            document.getElementById('txtReason').value = ''
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scrpt" runat="server">
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
                                <uc7:ErrorDisplay ID="ErrorDisplay2" runat="server" />
                            </li>
                        </ul>
                        <div id="YesData" runat="server">
                            <table width="100%" border="0" cellspacing="0" cellpadding="5">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblBillNo" Text="Please Enter Bill No" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtBillNo" Width="31%" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblApprovedBy" Text="Approved By" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtApprovedBy" Width="31%" autocomplete="off" runat="server"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoGname1" runat="server" TargetControlID="txtApprovedBy"
                                            ServiceMethod="getUserNamesWithLoginID" ServicePath="~/WebService.asmx" EnableCaching="false"
                                            MinimumPrefixLength="2" BehaviorID="AutoCompleteExLstGrp11" CompletionInterval="30"
                                            DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected">
                                        </ajc:AutoCompleteExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <asp:Label ID="lblReason" Text="Reason For Visit State Change" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox TextMode="MultiLine" ID="txtReason" onFocus="return expandTextBox(this.id)"
                                            onBlur="return collapseTextBox(this.id);" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        <asp:Button ID="btnSubmit" Text="Submit" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClientClick="return Formvalidation()" OnClick="btnSubmit_Click" />
                                        <asp:Button ID="btnCancel" Text="Cancel" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" OnClick="btnCancel_Click" />
                                        <input type="button" id="btnDummy" runat="server" style="display: none;" />
                                    </td>
                                </tr>
                            </table>
                            <asp:Panel ID="pnlOthers" runat="server" Style="display: none;" CssClass="modalPopup dataheaderPopup">
                                <center>
                                    <div id="divOthers" style="width: 350px; height: 160px; padding-top: 10px; padding-left: 15px">
                                        <table width="90%" cellpadding="5" cellspacing="5" align="center">
                                            <tr align="left">
                                                <td>
                                                    <label id="lblFeeDesc" style="width: 155px;">
                                                        <asp:Label ID="lblPatientName" Text="Patient Name" runat="server"></asp:Label></label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPatientNameText" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr align="left">
                                                <td>
                                                    <label id="Label1" style="width: 155px;">
                                                        <asp:Label ID="lblPatientNo" Text="Patient No" runat="server"></asp:Label></label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPatientNoText" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr align="left">
                                                <td>
                                                    <label id="Label3" style="width: 155px;">
                                                        <asp:Label ID="lblBillNumber" Text="Bill Number" runat="server"></asp:Label></label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblBillNoText" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr align="left">
                                                <td>
                                                    <label id="Label5" style="width: 155px;">
                                                        <asp:Label ID="lblDischargDate" Text="Discharged Date" runat="server"></asp:Label></label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblDischargDateText" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center">
                                                    <asp:Button ID="btnOK" Text="OK" OnClientClick="return DataValidationDone();" runat="server"
                                                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                        OnClick="btnOK_Click" />
                                                    <input type="button" id="btnClose" class="btn" runat="server"
                                                        value="Close" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </center>
                            </asp:Panel>
                            <asp:HiddenField ID="hiddenTargetControlFormpeOthers" runat="server" />
                            <ajc:ModalPopupExtender ID="mpeOthers" runat="server" BehaviorID="mpeOthersBehavior"
                                PopupControlID="pnlOthers" CancelControlID="btnClose" TargetControlID="btnDummy" DynamicServicePath="" Enabled="True">
                            </ajc:ModalPopupExtender>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <input type="hidden" id="hdnBillNo" runat="server" />
        <input type="hidden" id="hdnApprovedBy" runat="server" />
        <input type="hidden" id="hdnReason" runat="server" />
        <input type="hidden" id="hdnIsDayCareBill" value="N" runat="server" />
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
