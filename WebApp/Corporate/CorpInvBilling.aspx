<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CorpInvBilling.aspx.cs" Inherits="Corporate_CorpInvBilling" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asd" %>
<%@ Register Src="../CommonControls/INVAttributeUsage.ascx" TagName="INVAttributeUsage"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/DueDetails.ascx" TagName="DueDetail" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="paymentType"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/PharmacyHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay"
    TagPrefix="uc21" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Billing</title>

    <script type="text/javascript" src="../Scripts/animatedcollapse.js"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/CorpOPInv.js" type="text/javascript"></script>

    <script src="../Scripts/QuickBill.js" type="text/javascript"></script>

    <script src="../Scripts/CorpInvAutoCompBatcchNo.js" type="text/javascript"></script>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">

        function SetVisitTypePros() {
            var pvalue = document.getElementById('hdnSearchType').value;
            var s1val = pvalue;
            $find('AutoCompleteExLstGrp11').set_contextKey(s1val);
        }


    </script>

</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
        </Services>
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
                                <uc1:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:Panel ID="pnlptDetails" CssClass="dataheader2" BorderWidth="1px" 
                            runat="server" meta:resourcekey="pnlptDetailsResource1">
                            <table width="100%" class="dataheader2 defaultfontcolor" border="0" cellpadding="0"
                                cellspacing="0">
                                <tr style="height: 15px;" class="Duecolor">
                                    <td colspan="10">
                                        <b>Patient Details</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 9%">
                                        <asp:Label ID="Label1" Text="Patient No: " runat="server" 
                                            meta:resourcekey="Label1Resource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblPNo" runat="server" meta:resourcekey="lblPNoResource1"></asp:Label>
                                    </td>
                                    <td style="width: 5%">
                                        <asp:Label ID="Label2" Text="Name: " runat="server" 
                                            meta:resourcekey="Label2Resource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                                    </td>
                                    <td style="width: 9%">
                                        <asp:Label ID="Label5" Text="Visit Date: " runat="server" 
                                            meta:resourcekey="Label5Resource1"></asp:Label>
                                    </td>
                                    <td style="width: 9%">
                                        <asp:Label ID="lblDate" runat="server" meta:resourcekey="lblDateResource1"></asp:Label>
                                    </td>
                                    <td style="width: 4%">
                                        <asp:Label ID="Label3" Text="Age: " runat="server" 
                                            meta:resourcekey="Label3Resource1"></asp:Label>
                                    </td>
                                    <td style="width: 9%">
                                        <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                    </td>
                                    <td style="width: 4%">
                                        <asp:Label ID="Label4" Text="Sex: " runat="server" 
                                            meta:resourcekey="Label4Resource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblSex" runat="server" meta:resourcekey="lblSexResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table width="100%" class="dataheader2 defaultfontcolor" border="0" cellpadding="0"
                                    cellspacing="0">
                                    <tr>
                                        <td>
                                            <table width="100%">
                                                <tr>
                                                    <td align="left" style="width: 100px;" valign="top">
                                                        Prescribed By :
                                                    </td>
                                                    <td align="left" valign="top">
                                                        <div style="float: left;">
                                                            <asp:TextBox  ID="txtPhysicianName" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                            <asd:AutoCompleteExtender CompletionInterval="1" ID="autoCompExtPhys" runat="server"
                                                                TargetControlID="txtPhysicianName" EnableCaching="false" FirstRowSelected="true"
                                                                MinimumPrefixLength="1" CompletionListCssClass="listtwo" CompletionListItemCssClass="listitemtwo"
                                                                CompletionListHighlightedItemCssClass="hoverlistitemtwo" ServiceMethod="getVisitingConsultant"
                                                                ServicePath="~/InventoryWebService.asmx">
                                                            </asd:AutoCompleteExtender>
                                                        </div>
                                                    </td>
                                                    <td align="right">
                                                        <table width="100%" id="tableTask" runat="server" style="display: none;" border="0"
                                                            cellpadding="2" cellspacing="0">
                                                            <tr>
                                                                <td>
                                                                    <asp:Table CellPadding="1" CssClass="dataheaderInvCtrl" CellSpacing="1" BorderWidth="1"
                                                                        runat="server" ID="ConsumableItemsTabClose" Width="100%" >
                                                                    </asp:Table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Table CellPadding="1" CssClass="dataheaderInvCtrl" CellSpacing="1" BorderWidth="1"
                                                                        runat="server" ID="ConsumableItemsTab" Width="100%">
                                                                    </asp:Table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right">
                                                                    <asp:CheckBox ID="chkTaskReasgin" Text="Task Reassign" runat="server" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="divClients" style="display: none;">
                                                    <td class="style2">
                                                        Select Client :
                                                    </td>
                                                    <td class="style2">
                                                        <asp:DropDownList CssClass="ddlsmall" onchange="ShowCredit();" ID="ddlClients"
                                                            runat="server">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6" align="right">
                                                        <table>
                                                            <tr>
                                                                <td align="right">
                                                                    <div id="dvHelp" width="400px" runat="server" class="dataheaderInvCtrl" align="Left">
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        
                                    </tr>
                                </table>
                                <table border="0" cellpadding="1" cellspacing="1" width="100%">
                                    <tr>
                                        <td width="100%">
                                            <table border="0" cellpadding="2" cellspacing="1" class="dataheader2 defaultfontcolor"
                                                width="100%">
                                                <tr>
                                                    <td id="tdSearch" runat="server" align="left" colspan="1" valign="middle">
                                                        &nbsp;<asp:Label ID="lblmsg" runat="server"></asp:Label>
                                                        <asp:Panel ID="pnSearch" runat="server">
                                                            &nbsp;
                                                            <asp:TextBox ID="txtProduct" Width="225px" onkeyup="doClearTable();" runat="server"
                                                                onblur="pSetFocus('pro');" CssClass="Txtboxsmall"></asp:TextBox>
                                                            <asd:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" CompletionInterval="1"
                                                                CompletionListCssClass="listtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                                                CompletionListItemCssClass="listitemtwo" EnableCaching="false" FirstRowSelected="true"
                                                                MinimumPrefixLength="1" OnClientItemSelected="IAmSelected" ServiceMethod="GetProductBatchListForIP"
                                                                OnClientItemOver="BillingGetProductTotalQuantity" ServicePath="~/InventoryWebService.asmx"
                                                                TargetControlID="txtProduct">
                                                            </asd:AutoCompleteExtender>
                                                            &nbsp;<asp:Button Visible="false" ID="btnSearch" runat="server" CssClass="btn" OnClientClick="return SearchText()"
                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Search" />
                                                        </asp:Panel>
                                                    </td>
                                                    <td style="display: none;" align="right" rowspan="2" valign="top">
                                                        <%--style="font-size: 15px;"--%>
                                                        <span style="padding-right: 2%;">Grand Total</span>
                                                        <asp:TextBox ID="txtGrandTotal" runat="server" ReadOnly="true" Text="0.00" ></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td id="tdExpiredIndication" runat="server" style="display: none">
                                                        <asp:TextBox ID="txtExpiredColor" ReadOnly="true" Text="" runat="server" Height="10px"
                                                            Width="10px"></asp:TextBox>
                                                        <asp:Label ID="lblExpLevel" Text="Products Expires Within " runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td id="divlistProducts" runat="server">
                                                        <asp:ListBox ID="listProducts" runat="server" Height="80px" Width="270px"></asp:ListBox>
                                                    </td>
                                                    <td align="left" valign="top">
                                                        <div id="divProductDetails" runat="server" style="display: none;">
                                                            <table id="TableProductDetails" runat="server" style="border: 0px solid #999999;"
                                                                cellpadding="1" cellspacing="1" width="100% ">
                                                                <tr style="font-weight: bold; text-align: left;">
                                                                    <td style="width: 75px;">
                                                                        Batch No&nbsp;
                                                                    </td>
                                                                    <td style="width: 80px;">
                                                                        Available Qty
                                                                    </td>
                                                                    <td style="width: 60px;">
                                                                        <asp:Label ID="lblType" Text="Issued Qty" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 60px;">
                                                                        Unit&nbsp;
                                                                    </td>
                                                                    <td style="width: 60px; display: none;">
                                                                        <%--   <asp:Label ID="lblIsReimburse" runat="server" Text="IsReimbursable"></asp:Label>--%>
                                                                    </td>
                                                                    <td style="width: 60px; display: none;">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 75px;">
                                                                        <asp:TextBox ID="txtBatchNo" runat="server" onblur="return BindQuantity();" Width="90px"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 60px;">
                                                                        <asp:TextBox ID="txtBatchQuantity" runat="server" ReadOnly="true" Width="60px"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 60px;">
                                                                        <asp:TextBox ID="txtQuantity" runat="server" onKeyDown="return validateNaN(event);"
                                                                            onblur="pSetAddFocus();" Width="60px"></asp:TextBox><%--onblur="pSetAddFocus();"--%>
                                                                    </td>
                                                                    <td style="width: 60px;">
                                                                        <asp:TextBox ID="txtUnit" runat="server" ReadOnly="true" Width="60px"></asp:TextBox>
                                                                    </td>
                                                                    <td style="width: 60px; display:none;" >
                                                                        <asp:CheckBox CssClass="bilddltb" ID="chkIsReimburse" runat="server" Text="Is&nbsp;Reimbursable"
                                                                            Checked="true" />
                                                                    </td>
                                                                    <td style="width: 60px;">
                                                                        <input id="add" class="btn" name="add" onclick="javascript:if(checkIsEmpty()) return BindProductList();"
                                                                            onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" style="width: 60px;"
                                                                            type="button" value="Add" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Table CellPadding="1" CssClass="dataheaderInvCtrl" CellSpacing="1" BorderWidth="1"
                                                            runat="server" ID="tbllist" Width="100%">
                                                        </asp:Table>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tblOrederedItems" border="1" cellpadding="2" cellspacing="0" class="dataheaderInvCtrl"
                                                style="text-align: left; font-size: 11px;" width="100%">
                                            </table>
                                            <table>
                                                <tr>
                                                    <td align="center">
                                                        <asp:Button ID="btnConsumable" OnClick="btnConsumable_Click" Text="Submit" runat="server"
                                                            CssClass="btn" OnClientClick="javascript:if(!checkDetails()) return false;"
                                                            />
                                                        &nbsp;
                                                        <asp:Button ID="btnCancel" OnClick="btnCancel_Click" Text="Reset" runat="server"
                                                            onmouseover="this.className='btn btnhov'" CssClass="btn" onmouseout="this.className='btn'" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <div>
                                                <table width="100%" style="display: none;">
                                                    <tr>
                                                        <td valign="top" align="left">
                                                            <table>
                                                                <tr style="display: none;" id="divDue" runat="server">
                                                                    <td align="left">
                                                                        <spans>
                                                                            <img id="imgDue" alt="" onclick="ChangeImage();" src="../Images/collapse.jpg" />
                                                                            <a id="A1" runat="server" href="javascript:animatedcollapse.toggle('Due');" onclick="ChangeImage();"
                                                                                style="color: Black; font-size: 11px">Due </a>
                                                                        </span>Previous Due
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtDue" runat="server" CssClass="invtextb" Enabled="false" Text="0.00"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="left" colspan="2" style="color: Black">
                                                                        <div id="Due" style="display: none;" title="Due Details">
                                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                                <tr>
                                                                                    <td align="left">
                                                                                        <uc6:DueDetail ID="dueDetail" runat="server" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="left">
                                                                        Service Charge
                                                                    </td>
                                                                    <td style="margin-left: 40px">
                                                                        <asp:TextBox ID="txtServiceCharge" runat="server" CssClass="invtextb" Enabled="false"
                                                                            Text="0.00" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="left">
                                                                        Amount Received
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtAmountRecieved" Enabled="false" runat="server" CssClass="invtextb"
                                                                            onblur="CheckTotal(this.id);" ReadOnly="True" Text="0.00" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td valign="top">
                                                            <asp:Label ID="lbldigitalnumber" runat="server"></asp:Label>
                                                        </td>
                                                        <td valign="top" align="right">
                                                            <table id="Table1" runat="server" border="0" cellpadding="0" cellspacing="0" width="95%">
                                                                <tr>
                                                                    <td colspan="2">
                                                                    </td>
                                                                    <td align="right">
                                                                        Sub Total
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtSubTotal" runat="server" CssClass="invtextb" Enabled="false"
                                                                            Text="0.00"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                    </td>
                                                                    <td align="right">
                                                                        Vat
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtTax" runat="server" CssClass="invtextb" MaxLength="6" onblur="CheckTotal(this.id);"
                                                                             onkeypress="return ValidateOnlyNumeric(this);"  Text="0.00"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                    </td>
                                                                    <td align="right">
                                                                        Gross Amount
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtGross" runat="server" CssClass="invtextb" Enabled="false" Text="0.00"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right">
                                                                        &nbsp;
                                                                        <label id="tdDiscountLabel" runat="server">
                                                                            Select the Discount</label>
                                                                    </td>
                                                                    <td align="left">
                                                                        &nbsp;<asp:DropDownList ID="ddDiscountPercent" ToolTip="Select the Discount" onChange="javascript:setDiscount();"
                                                                            runat="server" Style="margin-left: 0px">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td align="right">
                                                                        Discount
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtDiscount" runat="server" CssClass="invtextb" MaxLength="9" onblur="CheckTotal(this.id);"
                                                                             onkeypress="return ValidateOnlyNumeric(this);"  Text="0.00" />
                                                                        <asp:HiddenField ID="hdnDefaultRoundoff" runat="server" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="left" colspan="2">
                                                                        <asp:TextBox ID="txtDiscountPercent" runat="server" CssClass="invtextb" MaxLength="9"
                                                                            onblur="CheckDiscount(this.id);"  onkeypress="return ValidateOnlyNumeric(this);"  Style="display: none;"
                                                                            Text="0.00" />
                                                                    </td>
                                                                    <td align="right">
                                                                        Net Amount
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtNetAmount" runat="server" CssClass="invtextb" Enabled="false"
                                                                            Text="0.00" />
                                                                        <asp:HiddenField ID="hdnRoundBalace" runat="server" Value="0.00"/>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                    </td>
                                                                    <td align="right">
                                                                        RoundOff Amount
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtRoundoffAmount" runat="server" CssClass="invtextb" Enabled="false"
                                                                            Text="0.00" />
                                                                    </td>
                                                                </tr>
                                                                <tr style="display: none;">
                                                                    <td colspan="2">
                                                                    </td>
                                                                    <td align="right">
                                                                        Amount Due
                                                                    </td>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtAmountDue" runat="server" CssClass="invtextb" Enabled="false"
                                                                            Text="0" />
                                                                    </td>
                                                                </tr>
                                                                <tr id="trNonReimburse" runat="server">
                                                                    <td colspan="2">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td align="right">
                                                                        <div id="Div1" style="display: block">
                                                                            Paid Against Non-MedicalItems
                                                                        </div>
                                                                    </td>
                                                                    <td align="left">
                                                                        <div id="Div2" style="display: block">
                                                                            <asp:TextBox ID="txtNonMedical" runat="server" CssClass="invtextb" Enabled="false"
                                                                                MaxLength="150" onblur="javascript:getPrecision(this);"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                                                TabIndex="8" Text="0.00" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr id="trCoPayment" runat="server">
                                                                    <td colspan="2">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td align="right">
                                                                        <div id="Div3" style="display: block">
                                                                            Co-Payment
                                                                        </div>
                                                                    </td>
                                                                    <td align="left">
                                                                        <div id="Div4" style="display: block">
                                                                            <asp:TextBox ID="txtCoPayment" runat="server" CssClass="invtextb" MaxLength="150"
                                                                                onblur="javascript:getPrecision(this);customCoPayment();" onfocus="javascript:prepareCopayment();"
                                                                                 onkeypress="return ValidateOnlyNumeric(this);"  TabIndex="8" Text="0.00" />
                                                                            <input id="hdnCoPayment" runat="server" type="hidden" value="0.00" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr id="trExcess" runat="server">
                                                                    <td colspan="2">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td align="right">
                                                                        <div id="Div5" style="display: block">
                                                                            Excess Amount Received
                                                                        </div>
                                                                    </td>
                                                                    <td align="left">
                                                                        <div id="Div6" style="display: block">
                                                                            <asp:TextBox ID="txtExcess" runat="server" CssClass="invtextb" Enabled="false" MaxLength="150"
                                                                                 onkeypress="return ValidateOnlyNumeric(this);"  TabIndex="8" Text="0.00" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <table id="Table2" style="display: none;" runat="server" border="0" cellpadding="1"
                                                cellspacing="1" width="100%">
                                                <tr>
                                                    <td align="left" colspan="2">
                                                        <div id="divisCredit" style="display: none;" runat="server">
                                                            <asp:CheckBox ID="chkisCreditTransaction" runat="server" class="defaultfontcolor"
                                                                onclick="checkIsCredit();" Text="Credit Transaction" />
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign="bottom" style="font-weight: bold;">
                                                        <span>
                                                            <asp:Label ID="lblNonMedicalDisplay" runat="server" Text="Non-MedicalItems : "></asp:Label>
                                                            <asp:Label ID="lblNonMedicalAmt" runat="server" Text="0.00"></asp:Label>
                                                            <br />
                                                        </span><span>
                                                            <uc21:OtherCurrencyDisplay ID="OtherCurrencyDisplay1" runat="server" />
                                                        </span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <div id="divpayType">
                                                            <uc9:paymentType ID="PaymentType" runat="server" />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                            <div>
                                                <asp:HyperLink ID="hdnprint" Target="BillWindow" runat="server"></asp:HyperLink>
                                                <input id="hdnProBatchNo" runat="server" type="hidden" value="" />
                                                <asp:HiddenField ID="hdnTotalAmtRec" Value="0" runat="server" />
                                                <asp:HiddenField ID="hdnUseDeposit" Value="N" runat="server" />
                                                <asp:HiddenField ID="hdnProductLists" runat="server" />
                                                <input id="hdnPatientNo" runat="server" type="hidden" value="0" />
                                                <input id="hdnBatchList" runat="server" type="hidden" value="" />
                                                <input id="hdnpatientID" runat="server" type="hidden" value="-1" />
                                                <input id="hdnPatVisitID" runat="server" type="hidden" value="-1" />
                                                <input id="hdnProductId" runat="server" type="hidden" value="" />
                                                <input id="hdnProductName" runat="server" type="hidden" value="" />
                                                <input id="hdnReceivedID" runat="server" type="hidden" value="" />
                                                <input id="hdnSellingPrice" runat="server" type="hidden" value="" />
                                                <input id="hdnTax" runat="server" type="hidden" value="" />
                                                <input id="hdnExpiryDate" runat="server" type="hidden" value="" />
                                                <input id="hdnProductList" runat="server" type="hidden" value="" />
                                                <input id="hdnGrandTotal" runat="server" type="hidden" value="0.00" />
                                                <input id="hdnRowEdit" runat="server" type="hidden" value="" />
                                                <input id="hdnAmountDue" runat="server" type="hidden" value="0.00" />
                                                <input id="hdnNetAmount" runat="server" type="hidden" value="0.00" />
                                                <input id="hdnGross" runat="server" type="hidden" value="0.00" />
                                                <input id="hdnTtax" runat="server" type="hidden" value="0.00" />
                                                <input id="hdnAmountRecieved" runat="server" type="hidden" value="0.00" />
                                                <input id="hdnTasklist" runat="server" type="hidden" value="" />
                                                <input id="hdnTaskAmount" runat="server" type="hidden" value="" />
                                                <input id="hdnAddedAmount" runat="server" type="hidden" value="" />
                                                <input id="hdnTaskCollectedItems" runat="server" type="hidden" value="" />
                                                <input id="hdnAddedTaskList" runat="server" type="hidden" value="" />
                                                <input id="hdnIsCreditBill" type="hidden" runat="server" value="N" />
                                                <input id="hdnType" runat="server" type="hidden" value="OP" />
                                                <input id="hdnExpiryDateLevel" runat="server" type="hidden" />
                                                <input id="hdnHasExpiryDate" runat="server" type="hidden" />
                                                <input type="hidden" id="hdnDepositUsed" value="0.00" runat="server" />
                                                <input id="hdnUnitPrice" runat="server" type="hidden" value="0.00" />
                                                 <input id="hdnPrescriptionNO" runat="server" type="hidden" value="0" />
                                                <asp:HiddenField ID="hdnRoundOffType" runat="server" />
                                            </div>
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

<script language="javascript" type="text/javascript">



    function SetOtherCurrValues() {
        var pnetAmt = 0;
        pnetAmt = getOPCustomRoundoff(document.getElementById('txtGrandTotal').value == "" ? "0" : Number(document.getElementById('txtGrandTotal').value) - Number(document.getElementById('txtDiscount').value == "" ? "0" : document.getElementById('txtDiscount').value));
        var ConValue = "OtherCurrencyDisplay1";
        SetPaybleOtherCurr(pnetAmt, ConValue, true);
    }
    function getUsageDeposit() {
        var dhelp = document.getElementById('dvHelp');
        dhelp.innerHTML = '';
        var Pid = document.getElementById('hdnpatientID').value == "" ? "0" : document.getElementById('hdnpatientID').value;
        if (Number(Pid) <= 0) {
            Pid = 0;
        }
        var OrgID = '<%= OrgID%>';
        if (Pid > 0) {
            OPIPBilling.GetPatientDepositDetails(Pid, OrgID, fDepositDetail);
        }
    }
    function SetSearchType(obj) {
        document.getElementById("hdnSearchType").value = obj;

    }
   
</script>

</html>
