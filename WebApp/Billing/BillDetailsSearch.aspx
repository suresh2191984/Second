<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillDetailsSearch.aspx.cs"
    Inherits="Billing_BillDetailsSearch" EnableEventValidation="false" meta:resourcekey="PageResource1"
    Culture="auto" UICulture="auto" %>

<%@ Register Src="../CommonControls/BillSearch.ascx" TagName="BillSearch" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="PhyHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/DateSelection.ascx" TagName="DateSelection" TagPrefix="uc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Bill Details Search</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>


</head>
<body oncontextmenu="return true;">
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
                <uc3:Header ID="userHeader" runat="server" />
                <uc7:PhyHeader ID="physicianHeader" runat="server" />
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
                <td width="100%" valign="top" class="tdspace">
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
                        <asp:UpdatePanel ID="pnl_Client" runat="server">
                            <ContentTemplate>
                                <table border="0" cellpadding="5" cellspacing="5" width="100%" class="dataheader3">
                                    <tr>
                                        <td align="center">
                                            <table border="0" cellpadding="0" cellspacing="0" width="60%" class="dataheader3">
                                                <tr style="height: 20px">
                                                    <td width="20%" align="left">
                                                        <asp:Label ID="lblClientname" runat="server" Text="Client Name"></asp:Label>
                                                    </td>
                                                    <td width="30px" align="left">
                                                        <asp:TextBox ID="txtClientName" runat="server" Width="130px" CssClass="AutoCompletesearchBox"
                                                            TabIndex="1" onblur="javascript:return CearetxtDate();" onchange="SetClientID()"></asp:TextBox>
                                                        <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientList"
                                                            OnClientItemSelected="SetClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                            Enabled="True">
                                                        </cc1:AutoCompleteExtender>
                                                    </td>
                                                    <td width="20%" align="left">
                                                        <asp:Label ID="lblVisitNo" runat="server" Text="Visit Number"></asp:Label>
                                                    </td>
                                                    <td width="30%" align="left">
                                                        <asp:TextBox ID="txtVisitNo" runat="server" TabIndex="2" CssClass="Txtboxsmall"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr style="height: 20px">
                                                    <td class="defaultfontcolor" align="left">
                                                        <asp:Label ID="lblFrom" Text="From" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtFrom" runat="server" TabIndex="4" MaxLength="1" CssClass="Txtboxsmall"
                                                            Style="text-align: justify" ValidationGroup="MKE" />
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" />
                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFrom"
                                                            Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                            OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                            ErrorTooltipEnabled="True" />
                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                            ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" />
                                                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFrom"
                                                            PopupButtonID="ImageButton1" Format="dd/MM/yyyy" />
                                                    </td>
                                                    <td class="defaultfontcolor" align="left">
                                                        <asp:Label ID="lblTo" Text="To" runat="server" meta:resourcekey="lblToResource1"></asp:Label>
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtTo" runat="server" CssClass="Txtboxsmall" TabIndex="5" MaxLength="1"
                                                            Style="text-align: justify" ValidationGroup="MKE" />
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" />
                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtTo"
                                                            Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                            OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                            ErrorTooltipEnabled="True" />
                                                        <cc1:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                            ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" />
                                                        <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtTo"
                                                            PopupButtonID="ImageButton2" Format="dd/MM/yyyy" />
                                                    </td>
                                                </tr>
                                                <tr style="height: 20px" align="left">
                                                    <td>
                                                        <asp:Label ID="lblSearchType" runat="server" Text="Search Type"></asp:Label>
                                                    </td>
                                                    <td align="left">
                                                        <asp:RadioButton ID="RdoMapData" runat="server" AutoPostBack="True" GroupName="RdoClient"
                                                            Checked="true" />
                                                        <asp:Label ID="lblchknonSch" runat="server" Text="All Data"></asp:Label>
                                                        <asp:RadioButton ID="RdoMissData" runat="server" AutoPostBack="True" GroupName="RdoClient" />
                                                        <asp:Label ID="lblchk" runat="server" Text="Wrong Data"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr style="height: 20px">
                                                    <td colspan="4" align="center">
                                                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" meta:resourcekey="btnSearchResource1" OnClick="btnSearch_Click"
                                                            OnClientClick="return CheckToSaveData()" />
                                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" meta:resourcekey="btnCancelResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table width="100%">
                                                <tr>
                                                
                                                    <td>
                                           <asp:ImageButton ID="imgExportToExcel" OnClick="lnkExportToExcel_Click" runat="server"
                                                ImageUrl="../Images/ExcelImage.GIF" ToolTip="Save As Excel"   />
                                                       <asp:LinkButton ID="lnkviewtestdetails" runat="server" Text="ExportToExcel" 
                                                          ForeColor="Blue" Font-Underline="True" onclick="lnkExportToExcel_Click"  >                                                                                                           
                                                       </asp:LinkButton>
                                                  <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="pnl_Client" runat="server">
                                                    <ProgressTemplate>
                                                        <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                        <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                                    <div  style="width:100%;  overflow:auto;">
                                                        <asp:GridView ID="grdResult" runat="server" CellPadding="1" AutoGenerateColumns="False"
                                                            DataKeyNames="FeeDescription" Width="100%" EmptyDataText="NO data Found">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                                                    <HeaderTemplate>
                                                                        <asp:CheckBox ID="chkHeader" runat="server" Checked="true" />
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkRow" runat="server" ToolTip="Select Row" Checked="true" />
                                                                         <asp:Label Visible="false" ID="lblFinalBillID" runat="server" Text='<%# Eval("FinalBillID") %>'></asp:Label>
                                                                        <asp:Label Visible="false" ID="lblBillingDetailsID" runat="server" Text='<%# Eval("BillingDetailsID") %>'></asp:Label>
                                                                        <asp:Label Visible="false" ID="lblRateID" runat="server" Text='<%# Eval("RateID") %>'></asp:Label>
                                                                        <asp:Label Visible="false" ID="lblMRateID" runat="server" Text='<%# Eval("MRateID") %>'></asp:Label>
                                                                        <asp:Label Visible="false" ID="lblBaseRateID" runat="server" Text='<%# Eval("BaseRateID") %>'></asp:Label>
                                                                        <asp:Label Visible="false" ID="lblMBaseRateID" runat="server" Text='<%# Eval("MBaseRateID") %>'></asp:Label>
                                                                        <asp:Label Visible="false" ID="lblDiscountPolicyID" runat="server" Text='<%# Eval("DiscountPolicyID") %>'></asp:Label>
                                                                        <asp:Label Visible="false" ID="lblMDiscountPolicyID" runat="server" Text='<%# Eval("MDiscountPolicyID") %>'></asp:Label>
                                                                        <asp:Label Visible="false" ID="lblDiscountPercentage" runat="server" Text='<%# Eval("DiscountPercentage") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="VisitNumber" HeaderText="Visit Number" HtmlEncode="False" />
                                                                <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                                    HeaderText="Visit DateTime" />
                                                                 <asp:BoundField DataField="Name" HeaderText="Name" />
                                                                <asp:BoundField DataField="FeeDescription" HeaderText="Fee Description" />
                                                                <asp:BoundField DataField="FeeType" HeaderText="Fee Type" />
                                                                <asp:BoundField DataField="Amount" HeaderText="Amount" />
                                                                <asp:BoundField DataField="MAmount" HeaderText="Master Amount" />
                                                                <asp:BoundField DataField="RateCard" HeaderText="RateCard" />
                                                                <asp:BoundField DataField="MRatecard" HeaderText="Master RateCard" />
                                                                <asp:BoundField DataField="BaseAmount" HeaderText="Base Amount" />
                                                                <asp:BoundField DataField="MBaseAmount" HeaderText="Master BaseAmount" />
                                                                <asp:BoundField DataField="BaseRateCard" HeaderText="BaseRateCard" />
                                                                <asp:BoundField DataField="MBaseRatecard" HeaderText="Master BaseRateCard" />
                                                                <asp:BoundField DataField="ClientName" HeaderText="Client Name" />
                                                                <asp:BoundField DataField="DiscounCategory" HeaderText="Discount Category" />
                                                                <asp:BoundField DataField="MDiscounCategory" HeaderText="Master DiscountCategory" />
                                                                <asp:BoundField DataField="DiscountPolicy" HeaderText="Discount Policy" />
                                                                <asp:BoundField DataField="MDiscountPolicy" HeaderText="Master DiscountPolicy" />
                                                            </Columns>
                                                        </asp:GridView>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr id="GrdFooter" runat="server" class="dataheaderInvCtrl">
                                                    <td align="center" colspan="10">
                                                        <asp:Label ID="Label1" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                                                        <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                                        <asp:Label ID="Label2" runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label>
                                                        <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                                        <asp:Button ID="Btn_Previous" runat="server" Text="Previous" CssClass="btn" OnClick="Btn_Previous_Click"
                                                            meta:resourcekey="Btn_PreviousResource1" />
                                                        <asp:Button ID="Btn_Next" runat="server" Text="Next" CssClass="btn" OnClick="Btn_Next_Click"
                                                            meta:resourcekey="Btn_NextResource1" />
                                                        <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                        <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                                                        <asp:TextBox ID="txtpageNo" runat="server" CssClass="Txtboxsmall" Width="30px" autocomplete="off"
                                                            onKeyDown="return  onkeypress="return ValidateOnlyNumeric(this);" meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                                        <asp:Button ID="btnGo1" runat="server" Text="Go" CssClass="btn" OnClick="btnGo1_Click"
                                                            onmouseover="this.className='btn btnhov'" meta:resourcekey="btnGo1Resource1"
                                                            OnClientClick="return checkForValues()" />
                                                        <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="GrdSavCancel" runat="server" >
                                        <td align="center" colspan="3">
                                            <asp:Button ID="Save" runat="server" CssClass="btn" meta:resourcekey="Btn_PreviousResource1"
                                                OnClick="Btn_Save_Click" Text="Save" />
                                                 <asp:Button ID="Cancel" runat="server" CssClass="btn" 
                                                OnClick="Btn_Cancel_Click" Text="Cancel" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                            <Triggers>
                            <asp:PostBackTrigger ControlID="lnkviewtestdetails" />
                            
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
        <uc5:Footer ID="Footer1" runat="server" />
    </div>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>

    <script type="text/javascript">
        $("[id*=chkHeader]").live("click", function() {
            var chkHeader = $(this);
            var grid = $(this).closest("table");
            $("input[type=checkbox]", grid).each(function() {
                if (chkHeader.is(":checked")) {
                    $(this).attr("checked", "checked");
                    $("td", $(this).closest("tr")).addClass("selected");
                } else {
                    $(this).removeAttr("checked");
                    $("td", $(this).closest("tr")).removeClass("selected");
                }
            });
        });
        $("[id*=chkRow]").live("click", function() {
            var grid = $(this).closest("table");
            var chkHeader = $("[id*=chkHeader]", grid);
            if (!$(this).is(":checked")) {
                $("td", $(this).closest("tr")).removeClass("selected");
                chkHeader.removeAttr("checked");
            } else {
                $("td", $(this).closest("tr")).addClass("selected");
                if ($("[id*=chkRow]", grid).length == $("[id*=chkRow]:checked", grid).length) {
                    chkHeader.attr("checked", "checked");
                }
            }
        });
 

        function CheckToSaveData() {


            var fromDate = document.getElementById('txtFrom').value;
            var toDate = document.getElementById('txtTo').value;

            //        if (customerType == '0') {
            //            alert('Please Select Business Type');
            //            document.getElementById('CSchedule_drpCustomerType').focus();
            //            //return false;
            //        }
            //else
            if (fromDate == '') {
                alert('Please Select FromDate');
                document.getElementById('txtFrom').focus();
                return false;
            }
            else if (toDate == '') {
                alert('Please Select ToDate');
                document.getElementById('txtTo').focus();
                return false;
            }

        }
        function SetClientID(source, eventArgs) {
            var ClientID = 0;
            if (eventArgs != undefined) {
                ClientID = eventArgs.get_value();
                document.getElementById('<%=hdnClientID.ClientID %>').value = ClientID.split('|')[0];
            }
            else {
                document.getElementById('<%=hdnClientID.ClientID %>').value = ClientID;
            }
        }
        function CearetxtDate() {
            // document.getElementById('txtFrom').value = '';
            //document.getElementById('txtTo').value = '';

        }
    </script>
   

    </form>
</body>
</html>
