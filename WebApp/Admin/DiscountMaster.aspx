<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DiscountMaster.aspx.cs" Inherits="Admin_DiscountMaster" EnableEventValidation="false" 
    meta:resourcekey="PageResource2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>
        <%--Discount Master--%><%=Resources.Admin_AppMsg.Admin_DiscountMaster_aspx_01 %>
    </title>
    <%--
    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>--%>
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />

    <script type="text/javascript" src="../Scripts/JsonScript.js"></script>

    <%-- <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>
    <style type="text/css">
        .ui-datepicker
        {
            font-size: 8pt !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" ScriptMode="Release" EnablePartialRendering="true" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdtPnlTOD" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <div id='TabsMenu' class="a-left">
                                <ul>
                                    <li id="li1" onclick="DisplayTab('DIS','1')"><a href='#'><span><%=Resources.Admin_AppMsg.Admin_DiscountMaster_aspx_36 %></span></a></li>
                                    <li id="li2" onclick="DisplayTab('TAX','1')"><a href='#'><span><%=Resources.Admin_AppMsg.Admin_DiscountMaster_aspx_37 %></span></a></li>
                                    <li id="li3" onclick="DisplayTab('TOD','1')"><a href='#'><span><%=Resources.Admin_AppMsg.Admin_DiscountMaster_aspx_38 %></span></a></li>
                                    <li id="li4" onclick="DisplayTab('CUP','1')"><a href='#'><span><%=Resources.Admin_AppMsg.Admin_DiscountMaster_aspx_39 %></span></a></li>
                                    <li id="li5" onclick="DisplayTab('RCD','1')"><a href='#'><span><%=Resources.Admin_AppMsg.Admin_DiscountMaster_aspx_40 %></span></a></li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div id="divInv" runat="server" style="display: block;" class="divTab">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table class="dataheader2 defaultfontcolor w-100p b-tab">
                        <tr>
                            <td class="a-left">
                                <asp:Panel ID="Panel1" runat="server" meta:resourcekey="Panel1Resource1">
                                    <table class="dataheaderInvCtrl searchPanel">
                                        <tr>
                                            <td class="a-left w-15p">
                                                <asp:Label ID="lbldiscountcode" Text="Discount Code" runat="server" meta:resourcekey="lbldiscountcodeResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txtDiscountCode" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                                    meta:resourcekey="txtDiscountCodeResource1"></asp:TextBox>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="Rs_DiscountName" Text="Discount Name" runat="server" meta:resourcekey="Rs_DiscountNameResource2"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txtDiscountName" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                                    meta:resourcekey="txtDiscountNameResource2"></asp:TextBox>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="Rs_DiscountValue" Text="Discount Value" runat="server" meta:resourcekey="Rs_DiscountValueResource2"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txtDiscountValue" runat="server" 
                                                    onblur="validatePercentageKeyup(this.id,Rs_TaxPercentage)"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                    MaxLength="5" meta:resourcekey="txtDiscountValueResource2"></asp:TextBox>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="display: none" class="a-left">
                                                <asp:Label ID="Rs_DiscountPercentage" Text="Discount Percentage" runat="server" meta:resourcekey="Rs_DiscountPercentageResource2"></asp:Label>
                                            </td>
                                            <td style="display: none" class="a-left">
                                                <asp:TextBox runat="server" ID="txtDiscountPercentage" onkeypress="return ValidateOnlyNumeric(this);"
                                                    Width="65px" MaxLength="5" autocomplete="off" meta:resourcekey="txtDiscountPercentageResource2"></asp:TextBox>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="a-left">
                                                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" Width="75px" OnClick="btnSave_Click" OnClientClick="return ChkDiscountName()"
                                                    meta:resourcekey="btnSaveResource2" />
                                                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" Width="75px" OnClientClick=" return resetTxtBx()"
                                                    meta:resourcekey="btnResetResource2" />
                                                <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" Width="75px" OnClientClick="return chkdelete();"
                                                    OnClick="btnDelete_Click" meta:resourcekey="btnDeleteResource2" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" ForeColor="#333333"
                                    CssClass="mytable1 gridView w-100p" meta:resourcekey="grdResultResource2">
                                    <Columns>
                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource3">
                                            <ItemTemplate>
                                                <input id="rdSel" name="radio" onclick='extractRow(this,&#039;<%# Eval("DiscountID") %>&#039;)'
                                                    type="radio" discid='<%# Eval("DiscountID") %>' />
                                                <asp:Label ID="lblDiscountID" runat="server" Text='<%# Eval("DiscountID") %>' Style="display: none;"
                                                    meta:resourcekey="lblDiscountIDResource1"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="5%"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="DiscountID" HeaderText="DiscountID" Visible="False" meta:resourcekey="BoundFieldResource8" />
                                        <asp:BoundField DataField="Code" HeaderText="Discount Code" meta:resourcekey="BoundFieldResource9" />
                                        <asp:BoundField DataField="DiscountName" HeaderText="Discount Name" meta:resourcekey="BoundFieldResource10" />
                                        <asp:BoundField DataField="Discount" HeaderText="Discount Value" meta:resourcekey="BoundFieldResource11" />
                                    </Columns>
                                    <RowStyle HorizontalAlign="Left" />
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="dataheader1" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                    <asp:HiddenField ID="HdnID" runat="server" />
                    <asp:HiddenField ID="hdnRowID1" Value="0" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div id="divTaxmaster" runat="server" style="display: none;" class="divTab">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel2" runat="server">
                        <ProgressTemplate>
                            <div id="progressBackgroundFilter" class="a-center">
                            </div>
                            <div id="processMessage" class="a-center w-20p">
                                <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                    meta:resourcekey="img1Resource1" />
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    <table class="dataheader2 defaultfontcolor searchPanel w-100p b-tab" id="Table1">
                        <tr>
                            <td class="a-left">
                                <asp:Panel ID="pnlTax" runat="server" meta:resourcekey="pnlTaxResource2">
                                    <table class="dataheaderInvCtrl">
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="Rs_TaxName" Text="Tax Name" runat="server" meta:resourcekey="Rs_TaxNameResource2"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txtTaxName" CssClass="Txtboxsmall" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                                                    TabIndex="1" meta:resourcekey="txtTaxNameResource2"></asp:TextBox>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                            <td class="a-left">
                                                <asp:Label ID="lbltaxcode" Text="Tax Code" runat="server" meta:resourcekey="lbltaxcodeResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txttaxCode" CssClass="Txtboxsmall" runat="server" TabIndex="2" onBlur="return ConverttoUpperCase(this.id);"
                                                    meta:resourcekey="txttaxCodeResource1"></asp:TextBox>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="Rs_TaxPercentage" Text="Tax Percentage" runat="server" meta:resourcekey="Rs_TaxPercentageResource2"></asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox runat="server" CssClass="Txtboxsmall" ID="txtPercent" onkeypress="return ValidateOnlyNumeric(this);"
                                                    onblur="validatePercentageKeyup(this.id,Rs_TaxPercentage)"      
                                                    Width="65px" MaxLength="5" autocomplete="off" TabIndex="3" meta:resourcekey="txtPercentResource2"></asp:TextBox>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                            <td class="a-left">
                                                <asp:Label ID="lblReferenceType" Text="ReferenceType" runat="server" meta:resourcekey="lblReferenceTypeResource2"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:DropDownList ID="drpRefType" TabIndex="4" CssClass="ddl" runat="server" >
                                                </asp:DropDownList>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-center" colspan="2">
                                                <asp:Button ID="btnSaveTax" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" Width="75px" TabIndex="5" OnClientClick="return checkIsValid();"
                                                    OnClick="btnSaveTax_Click" meta:resourcekey="btnSaveTaxResource2" />
                                                <asp:Button ID="btnClear" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" Width="75px" TabIndex="6" OnClientClick="return ResetTaxField();"
                                                    meta:resourcekey="btnClearResource2" />
                                            </td>
                                            <td style="display: none;" id="tdbtnDeleteTax" runat="server" class="a-left">
                                                <asp:Button ID="btnDeleteTax" runat="server" Text="Delete" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" Width="75px" TabIndex="7" OnClientClick="return chkdeleteTax();"
                                                    OnClick="btnDeleteTax_Click" meta:resourcekey="btnDeleteTaxResource2" />
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <asp:GridView ID="GrdTaxmaster" runat="server" CellSpacing="1" CellPadding="1" AutoGenerateColumns="False"
                                    ForeColor="#333333" CssClass="mytable1 w-100p gridView" meta:resourcekey="GrdTaxmasterResource2">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource4">
                                            <ItemTemplate>
                                                <input id="rdSelTax" name="radio" onclick='getrowid(this,&#039;<%# Eval("TaxID") %>&#039;,&#039;<%# Eval("TaxName") %>&#039;,&#039;<%# Eval("TaxPercent") %>&#039;,&#039;<%# Eval("Code") %>&#039;,&#039;<%# Eval("ReferenceType") %>&#039;)'
                                                    type="radio" />
                                                <asp:Label ID="lblpTaxID" runat="server" Text='<%# Eval("TaxID") %>' Style="display: none;"
                                                    meta:resourcekey="lblpTaxIDResource1"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="5%" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="TaxID" HeaderText="Tax ID" Visible="False" meta:resourcekey="BoundFieldResource12" />
                                        <asp:BoundField DataField="TaxName" HeaderText="Tax Name" meta:resourcekey="BoundFieldResource14">
                                            <ItemStyle Width="20%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Code" HeaderText="Tax Code" meta:resourcekey="BoundFieldResource13">
                                            <ItemStyle Width="10%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TaxPercent" HeaderText="Tax Percentage(%)" DataFormatString="{0:00}"
                                            meta:resourcekey="BoundFieldResource15">
                                            <ItemStyle Width="5%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ReferenceName" HeaderText="Reference Type" meta:resourcekey="BoundFieldResource4">
                                            <ItemStyle Width="10%" />
                                        </asp:BoundField>
                                    </Columns>
                                    <RowStyle HorizontalAlign="Left" />
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Left" />
                                    <HeaderStyle CssClass="dataheader1" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                            </td>
                        </tr>
                    </table>
                    <asp:HiddenField ID="hdnTaxID" runat="server" />
                    <asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div id="divTurnovrDisc" runat="server" style="display: none;" class="divTab">
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
                    <table cellpadding="4" class="dataheader2 defaultfontcolor w-100p searchPanel" id="tblTurnOver">
                        <tr>
                            <td>
                                <asp:Panel ID="pnlTOD" runat="server" meta:resourcekey="pnlTODResource2">
                                    <table cellpadding="3" class="defaultfontcolor w-100p searchPanel">
                                        <tr>
                                            <td>
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="w-10p">
                                                            <asp:Label ID="lblCode" runat="server" Text="Code" meta:resourcekey="lblCodeResource1"></asp:Label>
                                                        </td>
                                                        <td class="w-10p">
                                                            <asp:TextBox ID="TODCode" Width="60px" CssClass="Txtboxmedium" MaxLength="4" runat="server"
                                                                AutoPostBack="True"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  OnTextChanged="TODCode_TextChanged"
                                                                meta:resourcekey="TODCodeResource1"></asp:TextBox>
                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="TODCode"
                                                                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetTODCode"
                                                                ServicePath="~/WebService.asmx" UseContextKey="True" DelimiterCharacters="" Enabled="True">
                                                            </ajc:AutoCompleteExtender>
                                                        </td>
                                                        <td class="w-10p">
                                                            <asp:Label ID="lblBasedOn" runat="server" Text="Based On" meta:resourcekey="lblBasedOnResource2"></asp:Label>
                                                        </td>
                                                        <td class="w-10p">
                                                            <asp:DropDownList ID="drpTODType" runat="server" CssClass="drpsmall" onchange="javascript:DrpInv();">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="w-12p">
                                                            <asp:Label ID="lblInv" runat="server" Text="Investigation Name" meta:resourcekey="lblInvResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="TxtInv" Width="250px" runat="server" onkeydown="javascript:clearfn();"
                                                                CssClass="Txtboxmedium" meta:resourcekey="TxtInvResource1"></asp:TextBox>
                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="TxtInv"
                                                                EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetOrgInvestigationsGroupandPKG"
                                                                OnClientItemSelected="IAmSelected" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                DelimiterCharacters="" Enabled="True" OnClientItemOver="SelectedTest">
                                                            </ajc:AutoCompleteExtender>
                                                        </td>
                                                        <td class="a-left w-19p">
                                                            <asp:Label ID="lblInvType" runat="server" ForeColor="Red" Font-Bold="True" meta:resourcekey="lblInvTypeResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <asp:HiddenField ID="hdnInvID" runat="server" />
                                                <asp:HiddenField ID="hdnInvName" runat="server" />
                                                <asp:HiddenField ID="hdnInvType" runat="server" />
                                                <asp:HiddenField ID="hdnSelectedTest" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="a-left w-10p">
                                                            <asp:Label ID="lblLowerRange" runat="server" Text="LowerRange" meta:resourcekey="lblLowerRangeResource2"></asp:Label>
                                                        </td>
                                                        <td class="w-10p">
                                                            <asp:TextBox ID="txtFrom" CssClass="Txtboxmedium" runat="server" onKeyDown="return  isNumeric(event,this.id)"
                                                                Width="60px" MaxLength="9" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                                        </td>
                                                        <td class="a-left w-10p">
                                                            <asp:Label ID="lblUpperRange" runat="server" Text="Upper Range" meta:resourcekey="lblUpperRangeResource2"></asp:Label>
                                                        </td>
                                                        <td class="w-10p">
                                                            <asp:TextBox ID="txtTo" onKeyDown="return  isNumeric(event,this.id)" CssClass="Txtboxmedium"
                                                                runat="server" Width="60px" MaxLength="9" meta:resourcekey="txtToResource1"></asp:TextBox>
                                                        </td>
                                                        <td class="a-left w-12p">
                                                            <asp:Label ID="lblTODPercent" Text="Percentage" runat="server" meta:resourcekey="lblTODPercentResource3"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtPercentage" CssClass="Txtboxmedium" runat="server" Width="30px"
                                                                MaxLength="5" onKeyDown="return  isNumericss(event,this.id)" onblur="validatePercentageKeyup(this.id,lblTODPercent)"
                                                                     onkeypress="return ValidateOnlyNumeric(this);"    meta:resourcekey="txtPercentageResource1"></asp:TextBox>
                                                            <asp:Label ID="lblpercen" runat="server" Text="%" meta:resourcekey="lblpercenResource1"></asp:Label>
                                                            &nbsp;
                                                            <%--<asp:Button ID="btnAdd" Text="Add" CssClass="btn" onmouseout="this.className='btn1'"
                                                                runat="server" OnClientClick="return GetValues(this.id);" meta:resourcekey="btnAddResource1" />--%>
                                                            <input type="button" id="btnAdd" runat="server" value="Add" meta:resourcekey="btnAddResource1"  class="btn" onmouseout="this.className='btn1'"
                                                                onclick="return GetValues(this.id);" enabled="false" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="TDActive" style="display: none" class="a-left">
                                                <asp:CheckBox ID="chkActive" runat="server" Text="IsActive" meta:resourcekey="chkActiveResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" id="tdTodTable" style="display: none">
                                <table id="tblTODiscount" class="dataheaderInvCtrl w-85p" runat="server">
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="w-20p">
                                    <tr>
                                        <td>
                                            <asp:Button Style="display: none;" ID="btnSaveTOD" runat="server" Text="Save" CssClass="btn1"
                                                OnClientClick="return checktable();" OnClick="btnSaveTOD_Click" meta:resourcekey="btnSaveTODResource1">
                                            </asp:Button>
                                        </td>
                                        <td>
                                            <%--<asp:Button ID="btnClearAll" runat="server" Text=" Clear Sup" CssClass="btn1" OnClientClick="ClearTOD();"
                                                meta:resourcekey="btnClearAllResource1" />--%>
                                            <input type="button" id="btnClearAll"  runat="server"  value="<%$Resources:btnClearAllResource1.Text%> " class="btn1" onclick="ClearTOD();" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <asp:HiddenField ID="hdnTODiscount" runat="server" />
                    <asp:HiddenField ID="hdnEditedValue" runat="server" />
                    <asp:HiddenField ID="hdnTODdetails" runat="server" />
                    <asp:HiddenField ID="hdnTodID" runat="server" Value="0" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div id="divCoupon" runat="server" style="display: none;" class="divTab">
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <table class="dataheader2 defaultfontcolor w-100p">
                        <tr>
                            <td class="colorforcontent">
                                <div id="DeltaPlus" class="a-left">
                                    <span class="dataheader1txt pointer" onclick="showCouponMasterDetails('DeltaPlus','DeltaMinus','divCouponMaster',1);">
                                        &nbsp;<asp:Label ID="lblinvfilter" runat="server" Text="Go to Coupon Details" meta:resourcekey="lblinvfilterResource1"></asp:Label></span>
                                    <img src="../Images/showBids.gif" alt="Go to Coupon Details" class="w-15 h-15 v-top pointer"
                                        onclick="showCouponMasterDetails('DeltaPlus','DeltaMinus','divCouponMaster',1);" />&nbsp;
                                </div>
                                <div id="DeltaMinus" class="a-left" style="display: none;">
                                    <span class="dataheader1txt pointer" onclick="showCouponMasterDetails('DeltaPlus','DeltaMinus','divCouponDetails',0);">
                                        <img src="../Images/hideBids.gif" alt="Go to Coupon Master" class="w-15 h-15 v-top pointer"
                                            onclick="showCouponMasterDetails('DeltaPlus','DeltaMinus','divCouponDetails',0);" />&nbsp;
                                </div>
                            </td>
                        </tr>
                    </table>
                    <div id="divCouponMaster" style="display: block;" runat="server">
                        <table class="dataheader2 defaultfontcolor w-100p searchPanel" id="tblCouponMaster1">
                            <tr>
                                <td class="Duecolor" colspan="5">
                                    &nbsp;&nbsp;<asp:Label ID="lblCouponMasterHeader" Text="Coupon Master" runat="server"
                                        meta:resourcekey="lblCouponMasterHeaderResource1" />
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5">
                                    <table width="100%" class="a-left">
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblCouponCode" Text="Code" runat="server" meta:resourcekey="lblCouponCodeResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtCouponCode" MaxLength="15" CssClass="Txtboxsmall" runat="server"
                                                    meta:resourcekey="txtCouponCodeResource1"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblCouponName" Text="Name" runat="server" meta:resourcekey="lblCouponNameResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtCouponName" MaxLength="50" CssClass="Txtboxsmall" runat="server"
                                                    meta:resourcekey="txtCouponNameResource1"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="chkStatus" Text="Active" runat="server" meta:resourcekey="chkStatusResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="a-center">
                                                <asp:Button ID="btnSaveCouponMaster" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" OnClientClick="return ValidateCouponMaster();"
                                                    OnClick="btnSaveCouponMaster_Click" meta:resourcekey="btnSaveCouponMasterResource1" />
                                                <asp:Button ID="btnClearCouponMaster" runat="server" Text="Clear" CssClass="btn"
                                                    onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="ClearCouponMaster();return false"
                                                    meta:resourcekey="btnClearCouponMasterResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="gvwCouponMaster" runat="server" AllowPaging="True" PageSize="5"
                                        AutoGenerateColumns="False" ForeColor="#333333" CssClass="mytable1 gridView w-100p"
                                        OnPageIndexChanging="gvwCouponMaster_PageIndexChanging" meta:resourcekey="gvwCouponMasterResource1">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <RowStyle Font-Bold="False" HorizontalAlign="Left" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource5">
                                                <ItemTemplate>
                                                    <input id="rdSel" name="radio" onclick='getcouponmasterrowid(this,&#039;<%# Eval("CouponID") %>&#039;,&#039;<%# Eval("Code") %>&#039;,&#039;<%# Eval("Name") %>&#039;,&#039;<%# Eval("Status") %>&#039;)'
                                                        type="radio" />
                                                </ItemTemplate>
                                                <ItemStyle Width="5%" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="CouponID" HeaderText="CouponID" Visible="False" meta:resourcekey="BoundFieldResource16" />
                                            <asp:BoundField DataField="Code" HeaderText="Code" meta:resourcekey="BoundFieldResource17">
                                                <ControlStyle Width="15%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Name" HeaderText="Name" meta:resourcekey="BoundFieldResource18">
                                                <ControlStyle Width="45%" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Status" HeaderText="Status" meta:resourcekey="BoundFieldResource19">
                                                <ControlStyle Width="5%" />
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                        </Columns>
                                        <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divCouponDetails" style="display: none;" runat="server">
                        <table class="dataheader2 defaultfontcolor w-100p" id="tblCouponDetail1">
                            <tr>
                                <td class="Duecolor h-23 a-left" colspan="6">
                                    &nbsp;&nbsp;<asp:Label ID="lblCouponDetailsHeader" Text="Coupon Details" runat="server"
                                        meta:resourcekey="lblCouponDetailsHeaderResource1" />
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblCoupon" Text="Select Coupon" runat="server" meta:resourcekey="lblCouponResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlCoupon" CssClass="ddl" runat="server" >
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblStartSerialNo" Text="Starting Serial No." runat="server" meta:resourcekey="lblStartSerialNoResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtStartSerialNo" MaxLength="30" CssClass="Txtboxsmall" runat="server"
                                        meta:resourcekey="txtStartSerialNoResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblEndSerialNo" Text="Ending Serial No." runat="server" meta:resourcekey="lblEndSerialNoResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEndSerialNo" MaxLength="30" CssClass="Txtboxsmall" runat="server"
                                        meta:resourcekey="txtEndSerialNoResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblBatchNo" Text="Batch No." runat="server" meta:resourcekey="lblBatchNoResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtBatchNo" MaxLength="30" CssClass="Txtboxsmall" runat="server"
                                        meta:resourcekey="txtBatchNoResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblOrderedUnits" Text="Ordered Units" runat="server" meta:resourcekey="lblOrderedUnitsResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtOrderedUnits" MaxLength="10"  onkeypress="return ValidateOnlyNumeric(this);" 
                                        CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtOrderedUnitsResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblCouponValue" Text="Coupon Value" runat="server" meta:resourcekey="lblCouponValueResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtCouponValue"  onkeypress="return ValidateOnlyNumeric(this);"  MaxLength="13"
                                        CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtCouponValueResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblExpiryDate" Text="Expiry Date" runat="server" meta:resourcekey="lblExpiryDateResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtExpiryDate" CssClass="Txtboxsmall" runat="server" meta:resourcekey="txtExpiryDateResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" class="a-center">
                                    <asp:Button ID="btnSaveCouponDetails" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="return ValidateCouponDetails();"
                                        OnClick="btnSaveCouponDetails_Click" meta:resourcekey="btnSaveCouponDetailsResource1" />
                                    <asp:Button ID="btnClearCouponDetails" runat="server" Text="Clear" CssClass="btn"
                                        onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="ClearCouponDetails();return false"
                                        meta:resourcekey="btnClearCouponDetailsResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <asp:GridView ID="gvwCouponDetails" runat="server" CellSpacing="1" CellPadding="1"
                                        AllowPaging="True" PageSize="5" AutoGenerateColumns="False" ForeColor="#333333"
                                        CssClass="mytable1 gridView w-100p" OnPageIndexChanging="gvwCouponDetails_PageIndexChanging"
                                        meta:resourcekey="gvwCouponDetailsResource1">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <RowStyle Font-Bold="False" HorizontalAlign="Left" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource6">
                                                <ItemTemplate>
                                                    <input id="rdSel" name="radio" onclick='getcoupondetailsrowid(this,&#039;<%# Eval("CouponDetailID") %>&#039;,&#039;<%# Eval("CouponID") %>&#039;,&#039;<%# Eval("StartSerialNo") %>&#039;,&#039;<%# Eval("EndSerialNo") %>&#039;,&#039;<%# Eval("BatchNo") %>&#039;,&#039;<%# Eval("OrderedUnits") %>&#039;,&#039;<%# Eval("CouponValue") %>&#039;,&#039;<%# Eval("ExpiryDate") %>&#039;,&#039;<%# Eval("ConsumedUnits") %>&#039;)'
                                                        type="radio" />
                                                </ItemTemplate>
                                                <ItemStyle Width="5%" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="CouponDetailID" HeaderText="CouponDetailsID" Visible="False"
                                                meta:resourcekey="BoundFieldResource20" />
                                            <asp:BoundField DataField="CouponID" HeaderText="CouponID" Visible="false" meta:resourcekey="BoundFieldResource21" />
                                            <asp:BoundField DataField="Code" HeaderText="Coupon" meta:resourcekey="BoundFieldResource3" />
                                            <asp:BoundField DataField="StartSerialNo" HeaderText="Starting Serial No." meta:resourcekey="BoundFieldResource22" />
                                            <asp:BoundField DataField="EndSerialNo" HeaderText="Ending Serial No." meta:resourcekey="BoundFieldResource23" />
                                            <asp:BoundField DataField="BatchNo" HeaderText="Batch No." meta:resourcekey="BoundFieldResource24" />
                                            <asp:BoundField DataField="OrderedUnits" HeaderText="Ordered Units" meta:resourcekey="BoundFieldResource25">
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CouponValue" HeaderText="Coupon Value" meta:resourcekey="BoundFieldResource26">
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ExpiryDate" HeaderText="Expiry Date" DataFormatString="{0:dd/MM/yyyy}"
                                                HtmlEncode="False" meta:resourcekey="BoundFieldResource27">
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ConsumedUnits" HeaderText="Consumed Units" meta:resourcekey="BoundFieldResource28">
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                        </Columns>
                                        <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </div>
                    <asp:HiddenField ID="hdnCouponID" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div id="divRateDiscount" runat="server" style="display: none;" class="divTab">
            <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                <ContentTemplate>
                    <table class="dataheader2 defaultfontcolor w-100p">
                        <tr>
                            <td class="a-left">
                                <asp:Panel ID="pnlRCD" runat="server" CssClass="w-100p" Font-Bold="False" meta:resourcekey="pnlRCDResource1">
                                    <table class="w-100p searchPanel" id="tbRateDiscount" style="font-family: Tahoma;">
                                        <tr>
                                            <td class="Duecolor" colspan="5">
                                                <asp:Label ID="lblCreatePolicy" Font-Bold="True" runat="server" Text="Manage Discount Policy"
                                                    meta:resourcekey="lblCreatePolicyResource3"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5" class="a-center">
                                                <asp:Label ID="lblResultStatus" runat="server" Font-Bold="False" Font-Names="Tahoma"
                                                    ForeColor="Blue" meta:resourcekey="lblResultStatusResource4"></asp:Label>
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="lblPolicyCode" runat="server" Text="Discount Policy Code" meta:resourcekey="lblPolicyCodeResource1"></asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtDiscountPolicy" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtDiscountPolicyResource1"></asp:TextBox>
                                                <ajc:AutoCompleteExtender ID="ACEdiscountPolicy" runat="server" TargetControlID="txtDiscountPolicy"
                                                    EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="0" FirstRowSelected="True"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetTODCodeAndID"
                                                    OnClientItemSelected="SetPolicyID" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                    DelimiterCharacters="" Enabled="True">
                                                </ajc:AutoCompleteExtender>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                            <td class="a-left">
                                                <asp:Label ID="lblFeeType" runat="server" Text="Fee Type" meta:resourcekey="lblFeeTypeResource1"></asp:Label>
                                            </td>
                                            <td class="a-left" colspan="2">
                                                <asp:DropDownList ID="ddlFeeType" runat="server" CssClass="ddl" onChange="LoadCategory()">
                                                </asp:DropDownList>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-left">
                                                <asp:Label ID="lblTestCategory" runat="server" Text="Category" meta:resourcekey="lblTestCategoryResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:DropDownList ID="drpCategory" runat="server" CssClass="ddlsmall" >
                                                    <asp:ListItem Value="0" Text="--Select--" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td class="a-left">
                                                <asp:Label ID="lblDiscount" runat="server" Text="Value(%)" meta:resourcekey="lblDiscountResource1"></asp:Label>
                                            </td>
                                            <td class="a-left">
                                                <asp:TextBox ID="txtDisValue" onblur="validatePercentageKeyup(this.id,Rs_TaxPercentage)"
                                                         onkeypress="return ValidateOnlyNumeric(this);"    runat="server" CssClass="Txtboxsmall"
                                                    Width="30px" MaxLength="5" meta:resourcekey="txtDisValueResource3"></asp:TextBox>
                                                <asp:DropDownList ID="drpDisType" runat="server" CssClass="ddl" >
                                                </asp:DropDownList>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <table class="w-100p" style="font-family: Tahoma;">
                                                    <tr>
                                                        <td class="w-50p" align="right">
                                                            <%--<asp:Button ID="btnAddRateDetails" runat="server" Text="Add" CssClass="btn1" meta:resourcekey="btnAddRateDetailsResource1"
                                                                OnClientClick="return DiscountPolicyValidation();" />--%>
                                                            <input type="button" id="btnAddRateDetails" runat="server" value="Add" class="btn1"
                                                                onclick="return DiscountPolicyValidation();" />
                                                        </td>
                                                        <td class="w-50p">
                                                            <%--<asp:Button ID="btnPolicyClear" runat="server" Text="Clear" CssClass="btn1" meta:resourcekey="btnPolicyClearResource1"
                                                                OnClientClick="return ClearPolicyDetails();" />--%>
                                                              <input type="button" id="btnPolicyClear" runat="server" value="<%$Resources:btnPolicyClearResource1.Text%>"  class="btn1"
                                                                onclick="return ClearPolicyDetails()" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <hr />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5" class="a-center">
                                                <div id="divRCD" runat="server" style="display: none">
                                                    <table id="tbDisPolicy" class="dataheaderInvCtrl w-80p font12" style="font-family: Tahoma;">
                                                        <thead>
                                                            <tr class="dataheader1">
                                                                <th class="w-20p" scope="col">
                                                                    <asp:Label ID="thFeeType" runat="server" Text="Fee Type" meta:resourcekey="thFeeTypeResource3"></asp:Label>
                                                                </th>
                                                                <th class="w-20p" scope="col">
                                                                    <asp:Label ID="thCategory" runat="server" Text="Category" meta:resourcekey="thCategoryResource3"></asp:Label>
                                                                </th>
                                                                <th class="w-20p" scope="col">
                                                                    <asp:Label ID="thlblValue" runat="server" Text="Value(%)" meta:resourcekey="thlblValueResource3"></asp:Label>
                                                                </th>
                                                                <th class="w-20p" scope="col">
                                                                    <asp:Label ID="thValueType" runat="server" Text="Type" meta:resourcekey="thValueTypeResource3"></asp:Label>
                                                                </th>
                                                                <th class="w-20p" scope="col">
                                                                    <asp:Label ID="thAction" runat="server" Text="Action" meta:resourcekey="thActionResource3"></asp:Label>
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr style="display: none;" runat="server" id="trAction">
                                            <td colspan="2" align="right" runat="server">
                                                <asp:Button ID="btnSaveRCD" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" OnClick="btnSaveRCD_Click" OnClientClick="SavePolicyDetails()" meta:resourcekey="btnSaveRCDResource1" />
                                                <asp:Button ID="btnClearRCD" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" OnClientClick="return ClearTable()" meta:resourcekey="btnClearRCDResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                    <asp:HiddenField ID="hdnRCDdetails" runat="server" />
                    <asp:HiddenField ID="hdnRowPolicyIndex" runat="server" />
                    <asp:HiddenField ID="hdnGroupCategory" runat="server" />
                    <asp:HiddenField ID="hdnTestCategory" runat="server" />
                    <asp:HiddenField ID="hdnPolicyID" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnSetTab" runat="server" />
    </form>

    <script type="text/javascript" language="javascript">
     

      $(function() {
            $("#txtExpiryDate").datepicker({
                changeMonth: true,
               changeYear: true,
                minDate: 0,
                yearRange: '2008:2030'
            });
        });
        //Only numbers will allowed
        function isNumeric(e, Id) {
            var key; var isCtrl; var flag = 0;
            var txtVal = document.getElementById(Id).value.trim();
            var len = txtVal.split('.');
            if (len.length > 0) {
                flag = 1;
            }
            if (window.event) {
                key = window.event.keyCode;
                if (window.event.shiftKey) {
                    isCtrl = false;
                }
                else {
                    if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                        isCtrl = true;
                    }
                    else {
                        isCtrl = false;
                    }
                }
            } return isCtrl;
        }
        function isSpclChar(e) {
            var key;
            var isCtrl = false;

            if (window.event) // IE8 and earlier
            {
                key = e.keyCode;
            }
            else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
            {
                key = e.which;
            }

            if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32)) {
                isCtrl = true;
            }

            return isCtrl;
        }
        function isNumericss(e, Id) {

            var key; var isCtrl; var flag = 0;
            var txtVal = document.getElementById(Id).value.trim();
            var len = txtVal.split('.');
            if (len.length > 1) {
                flag = 1;
            }
            if (window.event) {
                key = window.event.keyCode;
                if (window.event.shiftKey) {
                    isCtrl = false;
                }
                else {
                    if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                        isCtrl = true;
                    }
                    else {
                        isCtrl = false;
                    }
                }
            } return isCtrl;
        }

        $(function() {
            $("#drpCategory").attr("disabled", true);
            var setTab = $('#hdnSetTab').val();
            if (setTab != '') {
                switch (setTab) {
                    case 1:
                        DisplayTab('DIS', 0);
                        break;

                    case 2:
                        DisplayTab('TAX', 0);
                        break;

                    case 3:
                        DisplayTab('TOD', 0);
                        break;

                    case 4:
                        DisplayTab('CUP', 0);
                        break;

                    case 5:
                        DisplayTab('RCD', 0);
                        break;

                }
            }
            else {
                DisplayTab('DIS', 0);
            }

        });

        function DrpInv() {
            var Hidden = document.getElementById('hdnTODdetails').value;
            if (Hidden == "") {
                if (document.getElementById('drpTODType').options[document.getElementById('drpTODType').selectedIndex].value == 'Vol') {

                    document.getElementById('lblInv').style.display = "block";
                    document.getElementById('TxtInv').style.display = "block";
                    document.getElementById('lblInvType').style.display = "block";
                }
                else {

                    document.getElementById('lblInv').style.display = "none";
                    document.getElementById('TxtInv').style.display = "none";
                    document.getElementById('lblInvType').style.display = "none";
                    document.getElementById('lblInvType').value = '';

                }
            }
            else {

                if (document.getElementById('drpTODType').options[document.getElementById('drpTODType').selectedIndex].value == 'Vol') {

                    document.getElementById('lblInv').style.display = "block";
                    document.getElementById('TxtInv').style.display = "block";
                    document.getElementById('lblInvType').style.display = "block";
                }
                else {

                    document.getElementById('lblInv').style.display = "none";
                    document.getElementById('TxtInv').style.display = "none";
                    document.getElementById('lblInvType').style.display = "none";
                    document.getElementById('lblInvType').value = '';

                }

            }

        }
        function validatePercentageKeyup(txtID, txtMessage) {
             var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_DiscountMaster_aspx_02") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_02") : "Enter Valid ";
            var userMsg2 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_03") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_03") : " should not be greater than 100 ";
            var txtValue = document.getElementById(txtID).value;
            if (isNaN(txtValue)) {
                var ShowText= txtMessage.innerHTML;
                ValidationWindow(userMsg+ShowText," "+ AlrtWinHdr);
                //alert('Enter Valid ' + txtMessage.innerHTML);
                document.getElementById(txtID).focus();
                return false;
            }
            if (parseFloat(txtValue) > 100) {
             var ShowText2=txtMessage.innerHTML;
                ValidationWindow(ShowText2 + userMsg2 ," "+ AlrtWinHdr);
                //alert(txtMessage.innerHTML + ' should not be greater than 100');
                document.getElementById(txtID).focus();
                return false;
            }
            else {
                return true;
            }
        }
        
        function DisplayTab(tabName, flag) {
            $('#TabsMenu li').removeClass('active');
            $('.divTab').attr("style", "display:none");
            if (tabName == 'DIS') {
                $('#li1').addClass('active');
                $('#divInv').attr("style", "display:block");
                $('#hdnSetTab').val(1);
            }
            else if (tabName == 'TAX') {
                $('#li2').addClass('active');
                $('#divTaxmaster').attr("style", "display:block");
                $('#hdnSetTab').val(2);
            }
            else if (tabName == 'TOD') {
                $('#li3').addClass('active');
                $('#divTurnovrDisc').attr("style", "display:block");
                $('#hdnSetTab').val(3);
            }
            else if (tabName == 'CUP') {
                $('#li4').addClass('active');
                $('#divCoupon').attr("style", "display:block");
                $('#hdnSetTab').val(4);
            }
            else if (tabName == 'RCD') {
                $('#li5').addClass('active');
                $('#divRateDiscount').attr("style", "display:block");
                $('#hdnSetTab').val(5);
            }
            if (flag == 1)
                ClearText();

            //            switch (tabName) {
            //                case 'DIS':
            //                    $('#li1').addClass('active');
            //                    $('#divInv').attr("style", "display:block");
            //                    break;
            //                case 'TAX':
            //                    $('#li2').addClass('active');
            //                    $('#divTaxmaster').attr("style", "display:block");
            //                    break;
            //                case 'TOD':
            //                    $('#li3').addClass('active');
            //                    $('#divTurnovrDisc').attr("style", "display:block");
            //                    break;
            //                case 'CUP':
            //                    $('#li4').addClass('active');
            //                    $('#divCoupon').attr("style", "display:block");
            //                    break;
            //                case 'RCD':
            //                    $('#li5').addClass('active');
            //                    $('#divRateDiscount').attr("style", "display:block");
            //                    break;
            //            }
            //            if (flag == 1)
            //                ClearText();
        }
        function IAmSelected(source, eventArgs) {

            var varGetVal = eventArgs.get_value();
            var ID;
            var name;
            var InvType;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        ID = list[0];
                        name = list[1];
                        InvType = list[2];
                        document.getElementById('hdnInvID').value = ID;
                        document.getElementById('hdnInvName').value = name;
                        document.getElementById('hdnInvType').value = InvType;


                    }
                }
            }
        }
        function clearfn() {

            if (document.getElementById('TxtInv').value.length <= 0 && document.getElementById('TxtInv').value != "") {
                document.getElementById('lblInvType').innerHTML = '';
            }
            else {
                document.getElementById('lblInvType').innerHTML = document.getElementById('hdnInvType').value;
            }
        }

        function SelectedTest(source, eventArgs) {
            document.getElementById('hdnSelectedTest').value = eventArgs.get_value();
            var x = document.getElementById('hdnSelectedTest').value.split("~");
            var Type = x[0].split("^");
            var InvType = Type[2];
            document.getElementById('lblInvType').innerHTML = InvType;



        }

        function checktable() {
             var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
            var userMsg= SListForAppMsg.Get("Admin_DiscountMaster_aspx_04") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_04") : " Empty TOD Policy Doesnot Add";
            if (document.getElementById('hdnTODdetails').value == "") {
                //               alert('Empty TOD Policy Doesnot Add');
                //                return false;
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_6');
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UserMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert('Empty TOD Policy Doesnot Add');
                    ValidationWindow(UserMsg, AlrtWinHdr);
                    return false;
                }
            }
        }

        function extractRow(src, cID) {
        var updateDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") : "Update";
            var eRow = src.parentElement.parentElement;
            var RI = eRow.rowIndex;
            var CasTbl = document.getElementById("grdResult");
            document.getElementById('HdnID').value = cID;
            document.getElementById('txtDiscountName').value = CasTbl.rows[RI].cells[2].innerHTML;
            document.getElementById('txtDiscountValue').value = CasTbl.rows[RI].cells[3].innerHTML;
            document.getElementById('txtDiscountCode').value = CasTbl.rows[RI].cells[1].innerHTML;
            document.getElementById('<%=btnSave.ClientID %>').value = updateDisplay;

        }

        function isSpclChar(e) {
            var key;
            var isCtrl = false;
            if (window.event) // IE8 and earlier
            {
                key = e.keyCode;
            }
            else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
            {
                key = e.which;
            }
            //*************To block slash(/) into text box change the key value to 48***************************//
            if ((key >= 47 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32)) {
                isCtrl = true;
            }
            return isCtrl;
        }
        function resetTxtBx() {
        var saveDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_save") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_save") : "Save";
        
            document.getElementById('txtDiscountName').value = "";
            document.getElementById('txtDiscountValue').value = "";
            document.getElementById('txtDiscountCode').value = "";
            document.getElementById('HdnID').value = "";
            document.getElementById('<%=btnSave.ClientID %>').value = saveDisplay;
            var radList = document.getElementsByName('rdSel');
            for (var i = 0; i < radList.length; i++) {
                if (radList[i].checked) {
                    radList[i].checked = false;
                }
            }
            return false;
        }

        function ChkDiscountName() {
            var txtdisname = document.getElementById('txtDiscountName').value;
            var btnvalue = document.getElementById('btnSave').value;
             var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
	            var userMsg= SListForAppMsg.Get("Admin_DiscountMaster_aspx_05") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_05") : " Enter discount Code";
	            var userMsg1= SListForAppMsg.Get("Admin_DiscountMaster_aspx_06") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_06") : " Enter discount name";
	            var userMsg2= SListForAppMsg.Get("Admin_DiscountMaster_aspx_07") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_07") : " Enter discount Value";
            var UserDispWin = SListForAppMsg.Get("Admin_DiscountMaster_aspx_001") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_001") : "DiscountCode Already Added";
            if (document.getElementById('txtDiscountCode').value == "") {
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_7');
                if (userMsg != null) {
                   // alert(userMsg);
                   ValidationWindow(UserMsg, AlrtWinHdr);
                    document.getElementById('txtDiscountCode').focus();
                    return false;
                }
                else {
                    //alert('Enter discount Code');
                    ValidationWindow(UserMsg, AlrtWinHdr);
                    document.getElementById('txtDiscountCode').focus();
                    return false;
                }
            }
            if (document.getElementById('txtDiscountName').value == "") {
               // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_1');
                if (userMsg1 != null) {
                    //alert(userMsg);
                    ValidationWindow(UserMsg1, AlrtWinHdr);
                    document.getElementById('txtDiscountName').focus();
                    return false;
                }
                else {
                    //alert('Enter discount name');
                    ValidationWindow(UserMsg1, AlrtWinHdr);
                    document.getElementById('txtDiscountName').focus();
                    return false;
                }
            }
            if (document.getElementById('txtDiscountValue').value == "") {

                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_2');
                if (UserMsg2 != null) {
                    //alert(userMsg);
                    ValidationWindow(UserMsg2, AlrtWinHdr);
                    document.getElementById('txtDiscountValue').focus();
                    return false;
                }
                else {
                    //alert('Enter Discount Value');
                     ValidationWindow(UserMsg2, AlrtWinHdr);
                    document.getElementById('txtDiscountValue').focus();
                    return false;
                }
            }
            var DicountCode = $('#txtDiscountCode').val();
            var Flag = '';
            var DiscountID = $('#HdnID').val();
            $('#grdResult tbody tr:not(:first)').each(function(i, n) {
                var $row = $(n);
                var SelectedID = $row.find($('span[id$="lblDiscountID"]')).html();
                var OldDiscountCode = $row.find("td:eq(1)").html();
                if (SelectedID != DiscountID) {
                if (OldDiscountCode != undefined) {
                    if (DicountCode.trim().toLowerCase() == OldDiscountCode.trim().toLowerCase()) {
                        Flag = 'YES';
                        return false;
                        }
                    }
                }

            });
            if (Flag == 'YES') {

                ValidationWindow(UserDispWin, AlrtWinHdr);
                //alert("DiscountCode Already Added");
                $('#txtDiscountCode').val('');
                $('#txtDiscountName').val('');
                $('#txtDiscountValue').val('');
                document.getElementById('txtDiscountCode').focus();
                return false;
            }
        }
        function chkdelete() {
        var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
	            var userMsg= SListForAppMsg.Get("Admin_DiscountMaster_aspx_09") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_09") : " select one record";
	            var userMsg1= SListForAppMsg.Get("Admin_DiscountMaster_aspx_10") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_10") : " Confirm to delete !!";
	            
            if (document.getElementById('HdnID').value == "") {
               // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_5');
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UserMsg, AlrtWinHdr);
                    return false;
                } else {
                   // alert('select one record');
                   ValidationWindow(UserMsg, AlrtWinHdr);
                    return false;
                }
                return false;
            }
            var con = confirm(userMsg1);
            if (con == false) {
                return false;
            }
        }
        function chkdeleteTax() {
         var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
	            var userMsg= SListForAppMsg.Get("Admin_DiscountMaster_aspx_09") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_09") : " select one record";
	           var userMsg1= SListForAppMsg.Get("Admin_DiscountMaster_aspx_10") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_10") : " Confirm to delete !!";
	            
            if (document.getElementById('hdnTaxID').value == "") {
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_5');
                if (userMsg != null) {
                   // alert(userMsg);
                   ValidationWindow(UserMsg, AlrtWinHdr);
                    return false;
                } else {
                    //alert('select one record');
                    ValidationWindow(UserMsg, AlrtWinHdr);
                    return false;
                }
                return false;
            }
            var con = confirm(userMsg1);
            if (con == false) {
                return false;
            }
        }
        function showCouponMasterDetails(plusImg, minusImg, responses, status) {
            var obj1 = document.getElementById(plusImg);
            var obj2 = document.getElementById(minusImg);
            var obj3 = document.getElementById(responses);
            if (status == 1) {
                document.getElementById('divCouponDetails').style.display = 'block';
                document.getElementById('divCouponMaster').style.display = 'none';
                obj2.style.display = 'block';
                obj1.style.display = 'none';
            }
            else {
                document.getElementById('divCouponDetails').style.display = 'none';
                document.getElementById('divCouponMaster').style.display = 'block';
                obj2.style.display = 'none';
                obj1.style.display = 'block';
            }
        }
        function LoadCategory() {
            var feeType = $('#ddlFeeType').val();
            $("#drpCategory").children('option:not(:first)').remove();
            var CategoryList = [];
            $("#drpCategory").attr("disabled", false);
            switch (feeType) {
                case "INVESTIGATION_GROUP_FEE":
                    if ($.trim($('#hdnGroupCategory').val()) != '') {
                        CategoryList = JSON.parse($('#hdnGroupCategory').val());
                    }
                    break;
                case "INVESTIGATION_FEE":
                    if ($.trim($('#hdnTestCategory').val()) != '') {
                        CategoryList = JSON.parse($('#hdnTestCategory').val());
                    }
                    break;

                case "HEALTH_PACKAGE":
                    if ($.trim($('#hdnGroupCategory').val()) != '') {
                        CategoryList = JSON.parse($('#hdnGroupCategory').val());
                    }
                    break;
                default:
                    $("#drpCategory").attr("disabled", true);
                    break;
            }
            if (CategoryList != '' && CategoryList.length > 0) {
                $.each(CategoryList, function(i, obj) {
                    $("#drpCategory").append($("<option></option>").val(obj.Code).html(obj.Value));
                });
            }
            return true;
        }

        function SetPolicyID(source, eventArgs) {
            try {
                var PolicyID = eventArgs.get_value();
                var PolicyName = eventArgs.get_text();
                var OrgID = "<%= OrgID %>";
                var Error = true;
                if (PolicyName != null && PolicyName.length > 1) {
                    $("#txtDiscountPolicy").val(PolicyName);
                    Error = false;
                }
                if (PolicyID != '' && PolicyID.length > 0) {
                    $("#hdnPolicyID").val(PolicyID);
                    Error = false;
                }
                if (Error == false) {
                    $("#lblResultStatus").text('');
                    BindDiscountPolicy(PolicyID, OrgID);
                }
            }
            catch (e) {
                return false;
            }
        }

        function BindDiscountPolicy(PolicyID, OrgID) {
            try {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetDiscountPolicyMapping",
                    data: "{OrgID: " + OrgID + ", PolicyID:" + PolicyID + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function Success(data) {
                        var lstDiscountPolicy = data.d;
                        var oNameValueCollection = [];
                        if (lstDiscountPolicy.length > 0) {
                            for (var i = 0; i < lstDiscountPolicy.length; i++) {
                                oNameValueCollection.push({
                                    FeeType: lstDiscountPolicy[i].FeeType,
                                    FeeName: lstDiscountPolicy[i].FeeName,
                                    CategoryType: lstDiscountPolicy[i].CategoryCode,
                                    CategoryText: lstDiscountPolicy[i].CategoryName,
                                    DiscountValue: lstDiscountPolicy[i].DiscountPercentage,
                                    ValueType: lstDiscountPolicy[i].DiscountType,
                                    ValueText: lstDiscountPolicy[i].DiscountName
                                });
                            }
                            if (oNameValueCollection != null && oNameValueCollection.length > 0) {
                                $("[id$='tbDisPolicy'] tbody tr").remove();
                                CreateRateCardDisTable(oNameValueCollection);
                            }
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                     var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
                        //alert(xhr.status);
                        ValidationWindow(xhr.status, AlrtWinHdr);
                    }
                });
            }
            catch (e) {
                return false;
            }
        }
        function DiscountPolicyValidation() {
         var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
	            var userMsg= SListForAppMsg.Get("Admin_DiscountMaster_aspx_11") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_11") : " Please enter policy name";
	          var userMsg1= SListForAppMsg.Get("Admin_DiscountMaster_aspx_12") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_12") : " Please Select Free Type";
	         var userMsg2= SListForAppMsg.Get("Admin_DiscountMaster_aspx_13") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_13") : " Please enter discount value";
	         var userMsg3= SListForAppMsg.Get("Admin_DiscountMaster_aspx_14") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_14") : " Please select the Type";
	         
            if ($("#txtDiscountPolicy").val() == "") {
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_8');
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    $("#txtDiscountPolicy").focus();
                    return false;
                } else {
                   // alert("Please enter policy name");
                   ValidationWindow(userMsg, AlrtWinHdr);
                    $("#txtDiscountPolicy").focus();
                    return false;
                }
                //                alert("Please enter policy name");
                //                $("#txtDiscountPolicy").focus();
                //                return false;
            }
            if ($('#ddlFeeType').val() == "0") {
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_9');
                if (userMsg1 != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg1, AlrtWinHdr);
                    $("#ddlFeeType").focus();
                    return false;
                }
                else {
                   // alert("Please select fee type");
                    ValidationWindow(userMsg1, AlrtWinHdr);
                    $("#ddlFeeType").focus();
                    return false;
                }

                //                alert("Please select fee type");
                //                $("#ddlFeeType").focus();
                //                return false;
            }
            if ($("#txtDisValue").val() == "") {
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_10');
                if (userMsg2 != null) {
                    //alert(userMsg);
                     ValidationWindow(userMsg2, AlrtWinHdr);
                    $("#txtDisValue").focus();
                    return false;
                }
                else {
                   // alert("Please enter discount value");
                    ValidationWindow(userMsg2, AlrtWinHdr);
                    $("#txtDisValue").focus();
                    return false;
                }

                //                alert("Please enter discount value");
                //                $("#txtDisValue").focus();
                //                return false;
            }
            if ($("#drpDisType").val() == "0") {
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_11');
                if (userMsg3 != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg3, AlrtWinHdr);
                    $("#drpDisType").focus();
                    return false;
                }
                else {
                    //alert("Please select the Type");
                    ValidationWindow(userMsg3, AlrtWinHdr);
                    $("#drpDisType").focus();
                    return false;
                }

                //                alert("Please select the Type");
                //                $("#drpDisType").focus();
                //                return false;
            }
            AddDiscountPolicy();
            return false;
        }

        function AddDiscountPolicy() {
         var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
	var userMsg= SListForAppMsg.Get("Admin_DiscountMaster_aspx_15") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_15") : " You cannot allow to add more than 1 Discount for this Fee Type and Category";
	
            try {
                var newDataSet = '';
                var CategoryType = '';
                var CategoryName = '';
                var policyName = $("#txtDiscountPolicy").val();
                var feeType = $('#ddlFeeType').val();
                var feeName = $("#ddlFeeType option:selected").text();
                var disValue = $("#txtDisValue").val();
                if ($('#drpCategory').val() != "0") {
                    CategoryType = $('#drpCategory').val();
                    CategoryName = $("#drpCategory option:selected").text();
                }
                var Exists = false;
                var ValueType = $('#drpDisType').val();
                var ValueText = $("#drpDisType option:selected").text();
                var policyID = 0;
                var oNameValueCollection = [];
                if ($("#hdnPolicyID").val() != "" && $("#hdnPolicyID").val().length > 0) {
                    policyID = $("hdnPolicyID").val();
                }
                $('[id$="tbDisPolicy"] tbody tr').each(function(i, n) {
                    var currentRow = $(n);
                    var tbfeeTypeID = currentRow.find("span[id$='feeID']").html();
                    var tbCategoryID = currentRow.find("span[id$='CTypeID']").html();
                    var tbAmount = currentRow.find("span[id$='DisValue']").html();
                    if ($('#btnAddRateDetails').val() != 'Update') {
                        if ($.trim(tbfeeTypeID) == feeType && $.trim(tbCategoryID) == CategoryType) {
                            //alert('You cannot allow to add more than 1 Discount for this Fee Type and Category');
                            ValidationWindow(UserMsg, AlrtWinHdr);
                            Exists = true;
                        }
                    }
                });
                if (!Exists) {
                    if ($('[id$="hdnRowPolicyIndex"]').val() == '') {
                        oNameValueCollection.push({
                            FeeType: feeType,
                            FeeName: feeName,
                            CategoryType: CategoryType,
                            CategoryText: CategoryName,
                            DiscountValue: disValue,
                            ValueType: ValueType,
                            ValueText: ValueText
                        });
                        CreateRateCardDisTable(oNameValueCollection);
                    }
                    else {
                        var selectedRowID = $('[id$="hdnRowPolicyIndex"]').val();
                        var selectedRow = '';
                        selectedRow = $('[id$="tbDisPolicy"] tbody tr:eq(' + selectedRowID + ')');
                        selectedRow.find("span[id$='feeID']").html(feeType);
                        selectedRow.find("span[id$='feeText']").html(feeName)
                        selectedRow.find("span[id$='CTypeID']").html(CategoryType)
                        selectedRow.find("span[id$='CName']").html(CategoryName)
                        selectedRow.find("span[id$='DisValue']").html(disValue)
                        selectedRow.find("span[id$='vType']").html(ValueType)
                        selectedRow.find("span[id$='vName']").html(ValueText)
                        ClearPolicyDetails();
                    }
                }
                else {
                    return false;
                }

            }
            catch (e) {
                return false;
            }
        }

        function CreateRateCardDisTable(nameValueCollection) {
            try {
                var DataTable = [];
                DataTable = nameValueCollection;
                $.each(DataTable, function(i, obj) {
                    dtTR = $('<tr/>');
                    var tdfTypeID = $('<td style="display:none;"/>').html("<span id='feeID'>" + obj.FeeType + " </span>");
                    var tdfName = $('<td align="left"/>').html("<span id='feeText'>" + obj.FeeName + " </span>");
                    var tdCTypeID = $('<td style="display:none;"/>').html("<span id='CTypeID'>" + obj.CategoryType + " </span>");
                    var tdCName = $('<td/>').html("<span id='CName'>" + obj.CategoryText + " </span>");
                    var tdDisValue = $('<td/>').html("<span id='DisValue'>" + obj.DiscountValue + " </span>");
                    var tdvType = $('<td style="display:none;"/>').html("<span id='vType'>" + obj.ValueType + " </span>");
                    var tdvName = $('<td/>').html("<span id='vName'>" + obj.ValueText + " </span>");
                    //                    var btnEdit = '<input id="btnEditDiscount" value="Edit" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;" onclick="onEditDiscount(this);"/>';
                    //                    var btnDelete = '<input id="btnDeleteDiscount" value="Delete" type="button" style="background-color: Transparent; color: Red; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;" onclick="onDeleteDiscount(this);"/>';
                    var btnEdit = '<input id="btnEditDiscount" value="<%=Resources.ClientSideDisplayTexts.Admin_DiscountMaster_Edit%>" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;" onclick="onEditDiscount(this);"/>';
                    var btnDelete = '<input id="btnDeleteDiscount" value="<%=Resources.ClientSideDisplayTexts.Admin_DiscountMaster_Delete%>" type="button" style="background-color: Transparent; color: Red; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;" onclick="onDeleteDiscount(this);"/>';
                    var tdAction = $('<td/>').html(btnEdit + btnDelete);
                    dtTR.append(tdfTypeID).append(tdfName).append(tdCTypeID).append(tdCName).append(tdDisValue).append(tdvType).append(tdvName).append(tdAction);
                    $('[id$="tbDisPolicy"] tbody').append(dtTR);
                });
                $("#divRCD").attr("style", "display:block");
                $("#trAction").attr("style", "display:table-row");
                ClearPolicyDetails();
            }
            catch (e) {
                return false;
            }
        }

        function ClearPolicyDetails() {
        var clearDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_clear") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_clear") : "Clear";
        var addDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_Add") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_Add") : "Add";
        try {
                $('#txtDiscountPolicy').val("");
                $("#btnPolicyClear").val(clearDisplay);
                $('[id$="ddlFeeType"] option:first').attr('selected', true);
                $('[id$="drpCategory"] option:first').attr('selected', true);
                $("#txtDisValue").val("");
                $('[id$="drpDisType"] option:first').attr('selected', true);
                $('[id$="hdnRowPolicyIndex"]').val("");
                $('#btnAddRateDetails').val(addDisplay);
                $('[id$="drpCategory"]').attr("disabled", false);
                
                $('#ddlFeeType').val('0');
               
                return false;
            }
            catch (e) {
                return false;
            }
        }

        function ClearTable1() {
            ClearPolicyDetails();
            $("[id$='tbDisPolicy'] tbody tr").remove();
            $("#txtDiscountPolicy").val("");
            $("#hdnPolicyID").val("");
            $("#divRCD").attr("style", "display:none");
            $("#trAction").attr("style", "display:none");
            $("#txtDiscountPolicy").val("");
            $("#hdnPolicyID").val("");
            $("[id$='btnAddRateDetails']").attr("style", "display:block");
            $("[id$='txtDiscountPolicy']").removeAttr('disabled');
            $("[id$='txtDiscountPolicy']").focus();
            DisplayTab('RCD', '0');
            return false;
        }
        function onEditDiscount(editItmes) {
        var updateDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") : "Update";
            try {
                var $setItems = $(editItmes).closest('tr');
                var rowIndex = $setItems.index();
                $('#btnAddRateDetails').val(updateDisplay);
                var feeType = $setItems.find("span[id$='feeID']").html();
                if (feeType != '')
                    $('[id$="ddlFeeType"] option[value=' + feeType + ']').attr("selected", "selected");
                else
                    $('[id$="ddlFeeType"] option:first').attr('selected', true);
                LoadCategory();
                var Cid = $setItems.find("span[id$='CTypeID']").html();
                $('[id$="drpCategory"]').attr("disabled", true);
                if (Cid != '') {
                    $('[id$="drpCategory"] option[value=' + Cid + ']').attr("selected", "selected");
                }
                else {
                    $('[id$="drpCategory"] option:first').attr('selected', true);
                }
                var disValue = $setItems.find("span[id$='DisValue']").html();
                if (disValue != '')
                    $('[id$="txtDisValue"]').val(disValue);
                else
                    $('[id$="txtDisValue"]').val('');
                var disType = $setItems.find("span[id$='vType']").html();
                if (disType != '')
                    $('[id$="drpDisType"] option[value=' + disType + ']').attr("selected", "selected");
                else
                    $('[id$="drpDisType"] option:first').attr("selected", true);
                $('[id$="hdnRowPolicyIndex"]').val(rowIndex);
            }
            catch (e) {
                return false;
            }
            return false
        }

        function onDeleteDiscount(DeleteItems) {
            try {
                $(DeleteItems).closest('tr').remove();
            }
            catch (e) {
                return false;
            }
            return false;
        }

        function SavePolicyDetails() {
            if ($("#txtDiscountPolicy").val() != "") {
                var policyID = 0;
                var lstDiscountPolicyMapping = [];
                if ($("#hdnPolicyID").val() != "" && $("#hdnPolicyID").val().length > 0) {
                    policyID = $("#hdnPolicyID").val();
                }
                var amountOfRows = $("#tbDisPolicy  tbody  tr").length;
                if (amountOfRows == 0) {
                    lstDiscountPolicyMapping.push({
                        PolicyID: policyID,
                        FeeType: 'N',
                        CategoryCode: 'N',
                        DiscountPercentage: 0.00,
                        DiscountType: 'DEL'
                    });
                    if (lstDiscountPolicyMapping.length > 0) {
                        $('[id$="hdnRCDdetails"]').val(JSON.stringify(lstDiscountPolicyMapping));
                    }
                }
                else {
                  
                    $('[id$="tbDisPolicy"] tbody tr').each(function(i, n) {
                        var currentRow = $(n);
                        var feeType = currentRow.find("span[id$='feeID']").html();
                        var categoryCode = currentRow.find("span[id$='CTypeID']").html();
                        var discountPercentage = currentRow.find("span[id$='DisValue']").html();
                        var discountType = currentRow.find("span[id$='vType']").html();                     
                        lstDiscountPolicyMapping.push({
                            PolicyID: policyID,
                            FeeType: feeType,
                            CategoryCode: categoryCode,
                            DiscountPercentage: discountPercentage,
                            DiscountType: discountType
                        });
                        if (lstDiscountPolicyMapping.length > 0) {
                            $('[id$="hdnRCDdetails"]').val(JSON.stringify(lstDiscountPolicyMapping));
                        }
                    });
                }
            }
        }

        function getrowid(rid, TaxID, TaxName, taxpercent, Code, ReferenceType) {
        var updateDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") : "Update";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            rid.checked = true;
            document.getElementById('hdnTaxID').value = TaxID;
            document.getElementById('txtTaxName').value = TaxName;
            document.getElementById('txtPercent').value = taxpercent.split('.')[0];
            document.getElementById('txttaxCode').value = Code;
            document.getElementById('drpRefType').value = ReferenceType;
            document.getElementById('<%=btnSaveTax.ClientID %>').value = updateDisplay;
            if (document.getElementById('tdbtnDeleteTax').style.display == 'none')
                document.getElementById('tdbtnDeleteTax').style.display = 'table-cell';
        }
        function ValidateCouponMaster() {
         var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
	var userMsg= SListForAppMsg.Get("Admin_DiscountMaster_aspx_16") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_16") : "Enter Coupon Code";
	var userMsg1= SListForAppMsg.Get("Admin_DiscountMaster_aspx_17") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_17") : "Enter Coupon Name";
            if (document.getElementById('txtCouponCode').value == '') {
               // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_12');
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UserMsg, AlrtWinHdr);
                    document.getElementById('txtCouponCode').focus();
                    return false;
                }
                else {
                    //alert('Enter Coupon Code');
                    ValidationWindow(UserMsg, AlrtWinHdr);
                    document.getElementById('txtCouponCode').focus();
                    return false;
                }
                //                alert('Enter Coupon Code');
                //                return false;
            }
            if (document.getElementById('txtCouponName').value == '') {
               //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_13');
                if (userMsg1 != null) {
                    //alert(userMsg);
                     ValidationWindow(UserMsg1, AlrtWinHdr);
                    document.getElementById('txtCouponName').focus();
                    return false;
                }
                else {
                    //alert('Enter Coupon Name');
                     ValidationWindow(UserMsg1, AlrtWinHdr);
                    document.getElementById('txtCouponName').focus();
                    return false;

                }
                //                alert('Enter Coupon Name');
                //                return false;
            }
        }
        function ValidateCouponDetails() {
        var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
	var userMsg= SListForAppMsg.Get("Admin_DiscountMaster_aspx_18") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_18") : "Select Coupon Code";
	var userMsg1= SListForAppMsg.Get("Admin_DiscountMaster_aspx_19") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_19") : "Enter Starting Serail No.";
           var userMsg2= SListForAppMsg.Get("Admin_DiscountMaster_aspx_20") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_20") : "Enter End Serial No.";
            var userMsg3= SListForAppMsg.Get("Admin_DiscountMaster_aspx_21") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_21") : "Enter Batch No.";
            if (document.getElementById('ddlCoupon').value == '-1') {
              //  var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_12');
                if (userMsg != null) {
                    //alert(userMsg);
                      ValidationWindow(UserMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert('Select Coupon Code');
                      ValidationWindow(UserMsg, AlrtWinHdr);
                    return false;
                }
                //                alert('Select Coupon Code');
                //                return false;
            }
            if (document.getElementById('txtStartSerialNo').value == '') {
               // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_14');
                if (userMsg1 != null) {
                    //alert(userMsg);
                    ValidationWindow(UserMsg1, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert('Enter Starting Serail No.');
                    ValidationWindow(UserMsg1, AlrtWinHdr);
                    return false;
                }
                //                alert('Enter Starting Serail No.');
                //                return false;
            }
            if (document.getElementById('txtEndSerialNo').value == '') {
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_14');
                if (userMsg2 != null) {
                    //alert(userMsg);
                    ValidationWindow(UserMsg2, AlrtWinHdr);
                    return false;
                }
                else {
                   // alert('Enter End Serial No.');
                    ValidationWindow(UserMsg2, AlrtWinHdr);
                    return false;
                }
                //                alert('Enter End Serial No.');
                //                return false;
            }
            if (document.getElementById('txtBatchNo').value == '') {
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_15');
                if (UserMsg3 != null) {
                    //alert(userMsg);
                    	ValidationWindow(UserMsg3, AlrtWinHdr);
                    return false;
                }
                else {
                   // alert('Enter Batch No.');
                   	ValidationWindow(UserMsg3, AlrtWinHdr);
                    return false;
                }
                //                alert('Enter Batch No.');
                //                return false;

            }
            if (document.getElementById('txtOrderedUnits').value == '') {
            var userMsg4= SListForAppMsg.Get("Admin_DiscountMaster_aspx_22") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_22") : "Enter Ordered Units";
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_16');
                if (userMsg4 != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg4, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert('Enter Ordered Units');
                    ValidationWindow(userMsg4, AlrtWinHdr);
                    return false;
                }
                //                alert('Enter Ordered Units');
                //                return false;

            }
            if (document.getElementById('txtCouponValue').value == '') {
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_17');
                var userMsg5= SListForAppMsg.Get("Admin_DiscountMaster_aspx_23") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_23") : "Enter Coupon Value";
	
                if (userMsg5 != null) {
                    ValidationWindow(userMsg5, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert('Enter Coupon Value');
                   ValidationWindow(userMsg5, AlrtWinHdr);
                    return false;
                }
                //                alert('Enter Coupon Value');
                //                return false;
            }
            if (document.getElementById('txtExpiryDate').value == '') {
               // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_18');
               var userMsg6= SListForAppMsg.Get("Admin_DiscountMaster_aspx_24") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_24") : "Enter/Select Expiry Date";
                if (userMsg6 != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg6, AlrtWinHdr);
                    return false;
                }
                else {
                   // alert('Enter/Select Expiry Date');
                     ValidationWindow(userMsg6, AlrtWinHdr);
                    return false;

                }
                //                alert('Enter/Select Expiry Date');
                //                return false;
            }

        }
        function ClearCouponMaster() {
            document.getElementById('txtCouponCode').value = '';
            document.getElementById('txtCouponName').value = '';
            document.getElementById('chkStatus').checked = false;
            document.getElementById('hdnCouponID').value = '';
            return false;
        }
        function getcouponmasterrowid(rid, CouponID, Code, Name, Status) {
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            rid.checked = true;
            document.getElementById('txtCouponCode').value = Code;
            document.getElementById('txtCouponName').value = Name;
            if (Status == 'Active') {
                document.getElementById('chkStatus').checked = true;
            }
            else {
                document.getElementById('chkStatus').checked = false;
            }
            document.getElementById('hdnCouponID').value = CouponID;
        }
        function ClearCouponDetails() {
            document.getElementById('ddlCoupon').value = '-1';
            document.getElementById('txtStartSerialNo').value = '';
            document.getElementById('txtEndSerialNo').value = '';
            document.getElementById('txtBatchNo').value = '';
            document.getElementById('txtOrderedUnits').value = '';
            document.getElementById('txtCouponValue').value = '';
            document.getElementById('txtExpiryDate').value = '';
            document.getElementById('hdnCouponID').value = '';
            return false;
        }
        function getcoupondetailsrowid(rid, CouponDetailID, CouponID, StartSerialNo, EndSerialNo, BatchNo, OrderedUnits, CouponValue, ExpiryDate, ConsumedUnits) {
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            rid.checked = true;
            document.getElementById('ddlCoupon').value = CouponID;
            document.getElementById('txtStartSerialNo').value = StartSerialNo;
            document.getElementById('txtEndSerialNo').value = EndSerialNo;
            document.getElementById('txtBatchNo').value = BatchNo;
            document.getElementById('txtOrderedUnits').value = OrderedUnits;
            document.getElementById('txtCouponValue').value = CouponValue;
            document.getElementById('txtExpiryDate').value = ExpiryDate.substring(0, 10);
            document.getElementById('hdnCouponID').value = CouponDetailID;
            Temp();
        }
        function SelectedClientValue(source, eventArgs) {
            var Name = eventArgs.get_text();
            var ID = eventArgs.get_value();
            document.getElementById('hdnClientID').value = ID;
            var ctype = 'cstype';
            GetTODCustomerdetails(ID);
        }
        function checkIsValid() {
         var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
	var userMsg= SListForAppMsg.Get("Admin_DiscountMaster_aspx_25") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_25") : "Provide tax name";
            if (document.getElementById('txtTaxName').value == "") {
               // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_19');
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    document.getElementById('txtTaxName').focus();
                    return false;
                }
                else {
                    //alert('Provide tax name');
                    ValidationWindow(userMsg, AlrtWinHdr);
                    document.getElementById('txtTaxName').focus();
                    return false;
                }
                //                alert('Provide tax name');
                //                document.getElementById('txtTaxName').focus();
                //                return false;
            }
            if (document.getElementById('txttaxCode').value == "") {
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_20');
                var userMsg1= SListForAppMsg.Get("Admin_DiscountMaster_aspx_26") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_26") : "Provide tax Code";
                if (userMsg1 != null) {
                    //alert(userMsg);
                     ValidationWindow(userMsg1, AlrtWinHdr);
                    document.getElementById('txttaxCode').focus();
                    return false;
                }
                else {
                    //alert('Provide tax Code');
                         ValidationWindow(userMsg1, AlrtWinHdr);
                    document.getElementById('txttaxCode').focus();
                    return false;
                }
                //                alert('Provide tax Code');
                //                document.getElementById('txttaxCode').focus();
                //                return false;
            }
            if (document.getElementById('txtPercent').value == "") {
              //  var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_21');
              var userMsg2= SListForAppMsg.Get("Admin_DiscountMaster_aspx_27") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_27") : "Provide tax percent";
                if (userMsg2 != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg2, AlrtWinHdr);
                    document.getElementById('txtPercent').focus();
                    return false;
                }
                else {
                   // alert('Provide tax percent');
                    ValidationWindow(userMsg2, AlrtWinHdr);
                    document.getElementById('txtPercent').focus();
                    return false;
                }
                //                alert('Provide tax percent');
                //                document.getElementById('txtPercent').focus();
                //                return false;
            }
            if (document.getElementById('drpRefType').options[document.getElementById('drpRefType').selectedIndex].value == '0') {
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_22');
                var userMsg3= SListForAppMsg.Get("Admin_DiscountMaster_aspx_28") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_28") : "Please Select the reference type";
                if (userMsg3 != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg3, AlrtWinHdr);
                    document.getElementById('drpRefType').focus();
                    return false;
                }
                else {
                    //alert('Please seletect the refernce type');
                     ValidationWindow(userMsg3, AlrtWinHdr);
                    document.getElementById('drpRefType').focus();
                    return false;
                }
            }
            var TaxCode = $('#txttaxCode').val();
            var TaxPercent = $('#txtPercent').val();
            var SelReferenceType = $('#drpRefType').val();
            var ReferenceType;
            if (SelReferenceType == 'INV') {
                ReferenceType='Invoice'
            }
            if (SelReferenceType == 'BIL') {
                ReferenceType = 'Bill'
            }
            var pTaxID = $('#hdnTaxID').val();
            var Flag1 = '';
            $('#GrdTaxmaster tbody tr:not(:first)').each(function(i, n) {
                var $row = $(n);
                var OldSelectedID = $row.find($('span[id$="lblpTaxID"]')).html();
                var OldTaxCode = $row.find("td:eq(2)").html();
                var OldTaxPercent = $row.find("td:eq(3)").html();
                var OldReferenceType = $row.find("td:eq(4)").html();
                if (OldSelectedID != pTaxID) {
                if (OldTaxCode != undefined && OldTaxPercent != undefined) {
                    if (TaxCode.trim().toLowerCase() == OldTaxCode.trim().toLowerCase() && TaxPercent.trim().toLowerCase() == OldTaxPercent.trim().toLowerCase() && ReferenceType.trim().toLowerCase() == OldReferenceType.trim().toLowerCase()) {
                        Flag1 = 'YES';
                        return false;
                        }
                    }
                }

            });
            if (Flag1 == 'YES') {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
            var userMsg4= SListForAppMsg.Get("Admin_DiscountMaster_aspx_29") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_29") : "Tax Already Added";
            //    alert("Tax Already Added");
            ValidationWindow(userMsg4, AlrtWinHdr);
                $('#txtTaxName').val('');
                $('#txttaxCode').val('');
                $('#txtPercent').val('');
                $('#drpRefType').val(0);
                return false;
            }
        }

        function ResetTaxField() {
        var saveDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_save") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_save") : "Save";
            document.getElementById('txtTaxName').value = "";
            document.getElementById('txtPercent').value = "";
            document.getElementById('txttaxCode').value = "";
            document.getElementById('drpRefType').value = '0';
            if (document.getElementById('tdbtnDeleteTax').style.display == 'table-cell')
                document.getElementById('tdbtnDeleteTax').style.display = 'none';
            document.getElementById('<%=btnSaveTax.ClientID %>').value = saveDisplay;
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            return false;
        }
        function GetValues(id) {
            var TodId = "0";
var updateDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") : "Update";
            if (document.getElementById(id).value == updateDisplay) {
                TodId = document.getElementById('hdnEditedValue').value.split('~')[0];
                Active = document.getElementById('hdnEditedValue').value.split('~')[6];
                var hdnList = document.getElementById('hdnTODdetails').value;
                document.getElementById('hdnTODdetails').value = "";
                var hdnVal = hdnList.split("^");
                for (var i = 0; i < hdnVal.length; i++) {
                    if (hdnVal[i] != "") {
                        if (document.getElementById('hdnEditedValue').value != hdnVal[i]) {
                            document.getElementById('hdnTODdetails').value += hdnVal[i] + "^";
                        }
                    }
                    document.getElementById('TDActive').style.display = 'none';
                }
            }
            var Type = document.getElementById('drpTODType').options[document.getElementById('drpTODType').selectedIndex].value;
            var Code = document.getElementById('TODCode').value;
            var txtfrom = document.getElementById('txtFrom').value;
            var txtto = document.getElementById('txtTo').value;
            var percentage = document.getElementById('txtPercentage').value;
            var Inv = document.getElementById('TxtInv').value;
            var FeeID = document.getElementById('hdnInvID').value;
            var FeeType = document.getElementById('hdnInvType').value;
            var InvName = document.getElementById('hdnInvName').value;

            var Active = "Y";
            if (document.getElementById(id).value == updateDisplay) {
                Active = document.getElementById('chkActive').checked == true ? "Y" : "N";
            }



            if (document.getElementById('drpTODType').options[document.getElementById('drpTODType').selectedIndex].innerText == 'Select') {
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_23');
                	 var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
	                    var userMsg= SListForAppMsg.Get("Admin_DiscountMaster_aspx_30") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_30") : "Select Type";
                if (userMsg != null) {
                   // alert(userMsg);
                   ValidationWindow(userMsg, AlrtWinHdr);
                    document.getElementById('drpTODType').focus();
                    return false;
                }
                else {
                    //alert('Select Type');
                    ValidationWindow(userMsg, AlrtWinHdr);
                    document.getElementById('drpTODType').focus();
                    return false;
                }

                //                alert('Select Type');
                //                document.getElementById('drpTODType').focus();
                //                return false;

            }
            if (document.getElementById(id).value != updateDisplay) {
                if (document.getElementById('drpTODType').options[document.getElementById('drpTODType').selectedIndex].value == 'Vol' && document.getElementById('drpTODType').disabled == false) {
                    if (Inv == "") {
                     var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
	                    var userMsg1= SListForAppMsg.Get("Admin_DiscountMaster_aspx_31") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_31") : "Select Investigation";
                        //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_24');
                        if (userMsg1 != null) {
                            //alert(userMsg);
                             ValidationWindow(userMsg1, AlrtWinHdr);
                            document.getElementById('TxtInv').focus();
                            return false;
                        }
                        else {
                            //alert('Select Investigation');
                             ValidationWindow(userMsg1, AlrtWinHdr);
                            document.getElementById('TxtInv').focus();
                            return false;
                        }

                        //                        alert('Select Investigation');
                        //                        document.getElementById('TxtInv').focus();
                        //                        return false;
                    }
                }
            }

            if (Code == "") {
             var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
	            var userMsg2= SListForAppMsg.Get("Admin_DiscountMaster_aspx_32") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_32") : "Provide Code ";
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_25');
                if (userMsg2 != null) {
                    //alert(userMsg);
                     ValidationWindow(userMsg2, AlrtWinHdr);
                    document.getElementById('TODCode').focus();
                    return false;
                }
                else {
                    //alert('Provide Code');
                      ValidationWindow(userMsg2, AlrtWinHdr);
                    document.getElementById('TODCode').focus();
                    return false;
                }

                //                alert('Provide Code');
                //                document.getElementById('TODCode').focus();
                //                return false;

            }
            if (Type == 'Vol') {
                if (Inv == "") {
                var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
	var userMsg3= SListForAppMsg.Get("Admin_DiscountMaster_aspx_33") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_33") : "Provide The Investigation Name ";
                  //  var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_25');
                    if (userMsg3 != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg3, AlrtWinHdr);
                        document.getElementById('TxtInv').focus();
                        return false;
                    }
                    else {
                        //alert('Provide The Investigation Name');
                        ValidationWindow(userMsg3, AlrtWinHdr);
                        document.getElementById('TxtInv').focus();
                        return false;
                    }
                }
            }

            if (txtfrom == "" || txtfrom =='0') {
               // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_26');
                var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
	var userMsg4= SListForAppMsg.Get("Admin_DiscountMaster_aspx_34") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_34") : "This Range is Not Valid.Please give valid Range";
                if (userMsg4 != null) {
                    //alert(userMsg);
                     ValidationWindow(userMsg4, AlrtWinHdr);
                    document.getElementById('txtFrom').focus();
                    return false;
                }
                else {
                    //alert('This Range is Not Valid.Please give valid Range');
                     ValidationWindow(userMsg4, AlrtWinHdr);
                    //alert('Provide valid range');
                    document.getElementById('txtFrom').focus();
                    return false;
                }

                //                alert('Provide valid range');
                //                document.getElementById('txtFrom').focus();
                //                return false;
            }
            if (txtto == "" || txtto == '0') {
             var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
	var userMsg4= SListForAppMsg.Get("Admin_DiscountMaster_aspx_34") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_34") : "This Range is Not Valid.Please give valid Range";
                
               // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_26');
                if (userMsg4 != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg4, AlrtWinHdr);
                    document.getElementById('txtTo').focus();
                    return false;
                }
                else {
                   // alert('This Range is Not Valid.Please give valid Range');
                   ValidationWindow(userMsg4, AlrtWinHdr);
                    // alert('Provide valid range');
                    document.getElementById('txtTo').focus();
                    return false;
                }

                //                alert('Provide valid range');
                //                document.getElementById('txtTo').focus();
                //                return false;
            }
            if (percentage == "") {
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_27');
                 var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
	            var userMsg4= SListForAppMsg.Get("Admin_DiscountMaster_aspx_35") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_35") : "Provide percentage";
                if (userMsg4 != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg4, AlrtWinHdr);
                    document.getElementById('txtPercentage').focus();
                    return false;
                }
                else {
                    //alert('Provide percentage');
                     ValidationWindow(userMsg4, AlrtWinHdr);
                    document.getElementById('txtPercentage').focus();
                    return false;
                }

                //                alert('Provide percentage');
                //                document.getElementById('txtPercentage').focus();
                //                return false;
            }

            if (parseInt(txtto) <= parseInt(txtfrom)) {
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_28');
                 var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
	var userMsg4= SListForAppMsg.Get("Admin_DiscountMaster_aspx_34") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_34") : "This Range is Not Valid.Please give valid Range";
            
                if (userMsg4 != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg4, AlrtWinHdr);
                    document.getElementById('txtFrom').focus();
                    return false;
                }
                else {
                    //alert('This Range is Not Valid.Please give valid Range');
                    ValidationWindow(userMsg4, AlrtWinHdr);
                    //alert('Given range not valid !');
                    document.getElementById('txtFrom').focus();
                    return false;
                }

                //                alert('Given range not valid !');
                //                document.getElementById('txtFrom').focus();
                //                return false;

            }
            var hdnVal = document.getElementById('hdnTODdetails').value.split("^");
            var isValid = true;
            for (var i = 0; i < hdnVal.length; i++) {
                if (hdnVal[i] != "") {
                    if (Type == 'Rev') {

                        if (parseInt(txtfrom) >= parseInt(hdnVal[i].split('~')[1]) && parseInt(txtfrom) <= parseInt(hdnVal[i].split('~')[2])) {
                            isValid = false;
                        }
                        if (parseInt(txtto) >= parseInt(hdnVal[i].split('~')[1]) && parseInt(txtto) <= parseInt(hdnVal[i].split('~')[2])) {
                            isValid = false;
                        }
                    }
                }
            }


var addDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_Add") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_Add") : "Add";
            if (isValid) {
                document.getElementById('hdnTODdetails').value += TodId + "~" + txtfrom + "~" + txtto + "~" + percentage + "~" + Code + "~" + Type + "~" + Active + "~" + FeeID + "~" + FeeType + "~" + Inv + "^";
                if (document.getElementById('hdnTODdetails').value != '') {
                    GenerateTable();
                    document.getElementById('btnAdd').value =addDisplay;
                    document.getElementById('btnSaveTOD').style.display = 'block';
                    document.getElementById('txtFrom').value = "";
                    document.getElementById('txtTo').value = "";
                    document.getElementById('txtPercentage').value = "";
                    document.getElementById('TxtInv').disabled = false;
                    document.getElementById('drpTODType').disabled = true;
                    document.getElementById('TxtInv').value = "";
                }
            }
            else {
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_29');
                var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
	            var userMsg4= SListForAppMsg.Get("Admin_DiscountMaster_aspx_34") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_34") : "This Range is Not Valid.Please give valid Range";
            
                if (userMsg4 != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg4, AlrtWinHdr);
                    document.getElementById('txtFrom').focus();
                    return false;
                }
                else {
                   // alert('This Range is Not Valid.Please give valid Range');
                   ValidationWindow(userMsg4, AlrtWinHdr);
                    document.getElementById('txtFrom').focus();
                    return false;
                }


                //                alert('This Range in Not Valid.Please give valid Range');
                //                document.getElementById('txtFrom').focus();
                //                return false;


            }
        }
        function GetTODCustTypedetails() {
            document.getElementById('TODCode').disabled = false;
            document.getElementById('txtFrom').disabled = false;
            document.getElementById('txtTo').disabled = false;
            document.getElementById('txtPercentage').disabled = false;
            document.getElementById('btnAdd').disabled = false;
            var todDetails = document.getElementById('hdnTODdetails').value.split('^');
            for (var i = 0; i < todDetails.length; i++) {
                if (todDetails[i] != '') {
                    document.getElementById('hdnTODiscount').value += todDetails[i].split('~')[0] + '~' + todDetails[i].split('~')[1] + '~' + todDetails[i].split('~')[2] + '~' + todDetails[i].split('~')[3] + '~' + todDetails[i].split('~')[4] + '~' + todDetails[i].split('~')[5] + '~' + todDetails[i].split('~')[6] + '^';
                }
            }
            if (document.getElementById('hdnTODiscount').value != '') {
                GenerateTable();
            }
        }


        function GetTODCustomerdetails() {
            document.getElementById('hdnTODiscount').value = '';
            var todDetails = document.getElementById('hdnTODdetails').value.split('^');
            for (var i = 0; i < todDetails.length; i++) {
                if (todDetails[i] != '') {

                    document.getElementById('hdnTODiscount').value += todDetails[i].split('~')[0] + '~' + todDetails[i].split('~')[1] + '~' + todDetails[i].split('~')[2] + '~' + todDetails[i].split('~')[3] + '~' + todDetails[i].split('~')[4] + '^';

                }
            }
            GenerateTable();

        }

        function GenerateTable() {

            while (count = document.getElementById('tblTODiscount').rows.length) {
                for (var j = 0; j < document.getElementById('tblTODiscount').rows.length; j++) {
                    document.getElementById('tblTODiscount').deleteRow(j);
                }
            }
            var flag = 0;
            var checkItem = document.getElementById('hdnTODdetails').value.split('^');
            if (checkItem != "") {

                for (var k = 0; k < checkItem.length; k++) {
                    if (checkItem[k] != '') {
                        if (checkItem[k].split('~')[5] == 'Vol') {
                            flag = 1;
                            break;
                        }
                    }
                }
                document.getElementById('btnSaveTOD').style.display = 'block';
                document.getElementById('tdTodTable').style.display = 'table-cell';
                var pList = document.getElementById('hdnTODdetails').value.split("^");
                var pParentLst = document.getElementById('hdnTODdetails').value.split("^");
                var Headrow = document.getElementById('tblTODiscount').insertRow(0);
                var Type = document.getElementById('drpTODType').options[document.getElementById('drpTODType').selectedIndex].value;
                Headrow.id = "HeadID";
                Headrow.style.fontWeight = "bold";
                Headrow.style.textAlign = "center";
                Headrow.className = "dataheader1";

                var cell0 = Headrow.insertCell(0);
                var cell1 = Headrow.insertCell(1);
                var cell2 = Headrow.insertCell(2);
                var cell3 = Headrow.insertCell(3);
                var cell4 = Headrow.insertCell(4);
                var cell5 = Headrow.insertCell(5);
                var cell6 = Headrow.insertCell(6);
                var cell7 = Headrow.insertCell(7);
                var cell8 = Headrow.insertCell(8);
                var cell9 = Headrow.insertCell(9);
                var cell10 = Headrow.insertCell(10);

                cell0.innerHTML = "TODID";
                cell1.innerHTML = "Lower Range";
                cell2.innerHTML = "Upper Range";
                cell3.innerHTML = "Percentage";
                cell4.innerHTML = "TODCode"
                cell5.innerHTML = "TODType";
                cell6.innerHTML = "IsActive";
                cell7.innerHTML = "FeeID";
                cell8.innerHTML = "FeeType";
                cell9.innerHTML = "InvName";
                cell10.innerHTML = "Action";
                cell0.style.width = "13%";
                cell1.style.width = "13%";
                cell2.style.width = "13%";
                cell3.style.width = "13%";
                cell4.style.width = "13%";
                cell5.style.width = "13%";
                cell6.style.width = "13%";
                cell7.style.width = "18%";
                cell8.style.width = "10%";
                cell9.style.width = "20%";
                cell10.style.width = "22%";
                cell8.style.display = 'none';
                if (Type == 'Rev') {
                    cell9.style.display = 'none';
                }
//                cell9.style.display = 'block';
                cell0.style.display = 'none';
                cell4.style.display = 'none';
                cell5.style.display = 'none';
                cell7.style.display = 'none';



                for (j = 0; j < pParentLst.length; j++) {
                    if (pParentLst[j] != "") {
                        var row = document.getElementById('tblTODiscount').insertRow(1);
                        row.style.height = "10px";
                        row.style.textAlign = "center";
                        var cell0 = row.insertCell(0);
                        cell0.style.display = 'none';
                        var cell1 = row.insertCell(1);
                        var cell2 = row.insertCell(2);
                        var cell3 = row.insertCell(3);
                        var cell4 = row.insertCell(4);
                        var cell5 = row.insertCell(5);
                        var cell6 = row.insertCell(6);
                        var cell7 = row.insertCell(7);
                        var cell8 = row.insertCell(8);
                        var cell9 = row.insertCell(9);
                        cell4.style.display = 'none';
                        cell5.style.display = 'none';
                        cell7.style.display = 'none';
                        cell8.style.display = 'none';
                        if (Type == 'Rev') {
                            cell9.style.display = 'none';
                        }
                        var cell10 = row.insertCell(10);
                        y = pList[j].split('~');
                        cell0.innerHTML = y[0];
                        cell1.innerHTML = y[1];
                        cell2.innerHTML = y[2];
                        cell3.innerHTML = y[3];
                        cell4.innerHTML = y[4];
                        cell5.innerHTML = y[5];
                        cell6.innerHTML = y[6];
                        cell7.innerHTML = y[7];
                        cell8.innerHTML = y[8];
                        cell9.innerHTML = y[9];

                        //                        cell10.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                        //                                                 "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "' onclick='btnDelete_OnClick(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"
                        cell10.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "' onclick='btnEdit_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.Admin_DiscountMaster_Edit%>' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                                                 "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "' onclick='btnDelete_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.Admin_DiscountMaster_Delete%>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"

                        //                        document.getElementById('TODCode').disabled = true;

                    }
                }
            }
        }
        function btnEdit_OnClick(sEditedData) {
        var updateDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") : "Update";
            document.getElementById('hdnEditedValue').value = sEditedData;
            var y = sEditedData.split('~');
            document.getElementById('btnAdd').value = updateDisplay;
            document.getElementById('txtFrom').value = y[1];
            document.getElementById('txtTo').value = y[2];
            document.getElementById('txtPercentage').value = y[3];
            document.getElementById('TODCode').value = y[4];
            document.getElementById('drpTODType').value = y[5];
            document.getElementById('drpTODType').disabled = true;
            document.getElementById('TODCode').disabled = true;


            if (y[5] == 'Vol') {
            //ADDED BY PREM 
                document.getElementById('hdnInvID').value =y[7];
                document.getElementById('hdnInvType').value=y[8];
                document.getElementById('hdnInvName').value = y[9];
                //---------//
                document.getElementById('lblInv').style.display = "block";
                document.getElementById('TxtInv').style.display = "block";
                document.getElementById('lblInvType').style.display = "block";
                document.getElementById('lblInvType').innerHTML = y[8];
                document.getElementById('TxtInv').value = y[9];


            }
            else {

                document.getElementById('lblInv').style.display = "none";
                document.getElementById('TxtInv').style.display = "none";
                document.getElementById('lblInvType').style.display = "none";
            }




            if (y[6] == "Y") {
                document.getElementById('TDActive').style.display = 'table-cell';
                document.getElementById('chkActive').checked = true;
            }
            else {
                document.getElementById('TDActive').style.display = 'table-cell';
                document.getElementById('chkActive').checked = false;
            }

        }
        function btnDelete_OnClick(sEditedData) {

            var i;
            var ConfirmString;
            //userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_30');
             var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
	    var userMsg= SListForAppMsg.Get("Admin_UserMaster_aspx_36") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_36") : "Confirm to delete!!";
	var addDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_Add") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_Add") : "Add";
            if (userMsg != null) {
                ConfirmString = userMsg;
                var IsDelete = confirm(ConfirmString);
            }
            else {
             ConfirmString = userMsg;
               // ConfirmString = 'Confirm to delete!!';
                var IsDelete = confirm(ConfirmString);
            }
            if (IsDelete == true) {
                var x = document.getElementById('hdnTODdetails').value.split("^");
                document.getElementById('hdnTODdetails').value = '';
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        if (x[i] != sEditedData) {
                            document.getElementById('hdnTODdetails').value += x[i] + "^";
                        }
                    }
                }
                //                if (document.getElementById('btnAdd').value == 'Update') {
                //                    document.getElementById('hdnTODdetails').value += document.getElementById('txtFrom').value + "~" + document.getElementById('txtTo').value + "~" + document.getElementById('txtPercentage').value + "~" + document.getElementById('TxtInv').value + "^";
                document.getElementById('btnAdd').value = addDisplay;
                document.getElementById('txtFrom').value = '';
                document.getElementById('txtTo').value = '';
                document.getElementById('txtPercentage').value = '';
                document.getElementById('TxtInv').value = '';
                //                }
                GenerateTable();
            }
            else {
                return false;
            }
        }

        function ClearText() {
            
           // document.getElementById('TODCode').value = '';
            document.getElementById('txtFrom').value = '';
            document.getElementById('txtTo').value = '';
            document.getElementById('txtPercentage').value = '';
            document.getElementById('txtDiscountName').value = '';
            document.getElementById('txtDiscountValue').value = '';
            document.getElementById('txtDiscountCode').value = '';
            document.getElementById('txtTaxName').value = '';
            document.getElementById('txtDiscountPercentage').value = '';
            document.getElementById('txtPercent').value = '';
            //document.getElementById('hdnTODiscount').value = '';
            document.getElementById('hdnTaxID').value = '';
            document.getElementById('hdnClientID').value = '';
            document.getElementById('HdnID').value = '';
            //document.getElementById('hdnTODdetails').value = '';
            document.getElementById('txtCouponCode').value = '';
            document.getElementById('txtCouponName').value = '';
            document.getElementById('ddlCoupon').value = '-1';
            document.getElementById('txtStartSerialNo').value = '';
            document.getElementById('txtEndSerialNo').value = '';
            document.getElementById('txtBatchNo').value = '';
            document.getElementById('txtOrderedUnits').value = '';
            document.getElementById('txtCouponValue').value = '';
            document.getElementById('txtExpiryDate').value = '';
            document.getElementById('hdnInvID').value = '';
            document.getElementById('hdnInvName').value = '';
            document.getElementById('hdnInvType').value = '';
            document.getElementById('TxtInv').value = '';
            document.getElementById('lblInvType').style.display = 'none';
            //  document.getElementById('tdTodTable').style.display = 'none';
            //  document.getElementById('lblInv').style.display = "none";
            // document.getElementById('TxtInv').style.display = "none";
            //document.getElementById('TODCode').disabled = false;
            // document.getElementById('drpTODType').value = 'Rev';
            // document.getElementById('drpTODType').disabled = false;
         

        }
        
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
                return false;
            else {
                var len = document.getElementById("txtPercentage").value.length;
                var index = document.getElementById("txtPercentage").value.indexOf('.');

                if (index > 0 && charCode == 46) {
                    return false;
                }
                if (index > 0) {
                    var CharAfterdot = (len + 1) - index;
                    if (CharAfterdot > 3) {
                        return false;
                    }
                }

            }
            return true;
        }

        function isNumberKeytax(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
                return false;
            else {
                var len = document.getElementById("txtPercent").value.length;
                var index = document.getElementById("txtPercent").value.indexOf('.');

                if (index > 0 && charCode == 46) {
                    return false;
                }
                if (index > 0) {
                    var CharAfterdot = (len + 1) - index;
                    if (CharAfterdot > 3) {
                        return false;
                    }
                }

            }
            return true;
        }


        function isNumberKeydis(evt) {

            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
                return false;
            else {
                var len = document.getElementById("txtDiscountValue").value.length;
                var index = document.getElementById("txtDiscountValue").value.indexOf('.');

                if (index > 0 && charCode == 46) {
                    return false;
                }
                if (index > 0) {
                    var CharAfterdot = (len + 1) - index;
                    if (CharAfterdot > 3) {
                        return false;
                    }
                }

            }
            return true;
        }

        function isNumberKeyDP(evt) {

            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
                return false;
            else {
                var len = document.getElementById("txtDisValue").value.length;
                var index = document.getElementById("txtDisValue").value.indexOf('.');

                if (index > 0 && charCode == 46) {
                    return false;
                }
                if (index > 0) {
                    var CharAfterdot = (len + 1) - index;
                    if (CharAfterdot > 3) {
                        return false;
                    }
                }

            }
            return true;
        }    
    </script>

   <%--    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>--%>
    <script type="text/javascript" src="../Scripts/JsonScript.js"></script>

    <%-- <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>
<%--<script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>--%>

<script type="text/javascript" language="javascript">

    $(function() {
        $("#txtExpiryDate").datepicker({
            changeMonth: true,
            changeYear: true,
            minDate: 0,
            yearRange: '2008:2030'
        })
    });
    //Only numbers will allowed
    function isNumeric(e, Id) {
        var key; var isCtrl; var flag = 0;
        var txtVal = document.getElementById(Id).value.trim();
        var len = txtVal.split('.');
        if (len.length > 0) {
            flag = 1;
        }
        if (window.event) {
            key = window.event.keyCode;
            if (window.event.shiftKey) {
                isCtrl = false;
            }
            else {
                if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                    isCtrl = true;
                }
                else {
                    isCtrl = false;
                }
            }
        } return isCtrl;
    }
    function isSpclChar(e) {
        var key;
        var isCtrl = false;

        if (window.event) // IE8 and earlier
        {
            key = e.keyCode;
        }
        else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
        {
            key = e.which;
        }

        if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32)) {
            isCtrl = true;
        }

        return isCtrl;
    }
    function isNumericss(e, Id) {

        var key; var isCtrl; var flag = 0;
        var txtVal = document.getElementById(Id).value.trim();
        var len = txtVal.split('.');
        if (len.length > 1) {
            flag = 1;
        }
        if (window.event) {
            key = window.event.keyCode;
            if (window.event.shiftKey) {
                isCtrl = false;
            }
            else {
                if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                    isCtrl = true;
                }
                else {
                    isCtrl = false;
                }
            }
        } return isCtrl;
    }

    $(function() {
        $("#drpCategory").attr("disabled", true);
        var setTab = $('#hdnSetTab').val();
        if (setTab != '') {
            switch (setTab) {
                case 1:
                    DisplayTab('DIS', 0);
                    break;

                case 2:
                    DisplayTab('TAX', 0);
                    break;

                case 3:
                    DisplayTab('TOD', 0);
                    break;

                case 4:
                    DisplayTab('CUP', 0);
                    break;

                case 5:
                    DisplayTab('RCD', 0);
                    break;

            }
        }
        else {
            DisplayTab('DIS', 0);
        }

    });

    function DrpInv() {
        var Hidden = document.getElementById('hdnTODdetails').value;
        if (Hidden == "") {
            if (document.getElementById('drpTODType').options[document.getElementById('drpTODType').selectedIndex].value == 'Vol') {

                document.getElementById('lblInv').style.display = "block";
                document.getElementById('TxtInv').style.display = "block";
                document.getElementById('lblInvType').style.display = "block";
            }
            else {

                document.getElementById('lblInv').style.display = "none";
                document.getElementById('TxtInv').style.display = "none";
                document.getElementById('lblInvType').style.display = "none";
                document.getElementById('lblInvType').value = '';

            }
        }
        else {

            if (document.getElementById('drpTODType').options[document.getElementById('drpTODType').selectedIndex].value == 'Vol') {

                document.getElementById('lblInv').style.display = "block";
                document.getElementById('TxtInv').style.display = "block";
                document.getElementById('lblInvType').style.display = "block";
            }
            else {

                document.getElementById('lblInv').style.display = "none";
                document.getElementById('TxtInv').style.display = "none";
                document.getElementById('lblInvType').style.display = "none";
                document.getElementById('lblInvType').value = '';

            }

        }

    }
    function validatePercentageKeyup(txtID, txtMessage) {
        var txtValue = document.getElementById(txtID).value;

            var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_DiscountMaster_aspx_02") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_02") : "Enter the Valid";
            var userMsg1 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_03") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_03") : "should not be greater than 100";
        if (isNaN(txtValue)) {
                var addword = txtMessage.innerHTML;
            // alert('Enter Valid ' + txtMessage.innerHTML);
                ValidationWindow(userMsg + addword, AlrtWinHdr);
            document.getElementById(txtID).focus();
            return false;
        }
        if (parseFloat(txtValue) > 100) {
                var addWord2 = txtMessage.innerHTML;
            //alert(txtMessage.innerHTML + ' should not be greater than 100');
                ValidationWindow(addWord2 + userMsg1, AlrtWinHdr);
            document.getElementById(txtID).focus();
            return false;
        }
        else {
            return true;
        }
    }
</script>

<script language="javascript" type="text/javascript">
    function DisplayTab(tabName, flag) {
        $('#TabsMenu li').removeClass('active');
        $('.divTab').attr("style", "display:none");
        if (tabName == 'DIS') {
            $('#li1').addClass('active');
            $('#divInv').attr("style", "display:block");
            $('#hdnSetTab').val(1);
        }
        else if (tabName == 'TAX') {
            $('#li2').addClass('active');
            $('#divTaxmaster').attr("style", "display:block");
            $('#hdnSetTab').val(2);
        }
        else if (tabName == 'TOD') {
            $('#li3').addClass('active');
            $('#divTurnovrDisc').attr("style", "display:block");
            $('#hdnSetTab').val(3);
        }
        else if (tabName == 'CUP') {
            $('#li4').addClass('active');
            $('#divCoupon').attr("style", "display:block");
            $('#hdnSetTab').val(4);
        }
        else if (tabName == 'RCD') {
            $('#li5').addClass('active');
            $('#divRateDiscount').attr("style", "display:block");
            $('#hdnSetTab').val(5);
        }
        if (flag == 1)
            ClearText();

        //            switch (tabName) {
        //                case 'DIS':
        //                    $('#li1').addClass('active');
        //                    $('#divInv').attr("style", "display:block");
        //                    break;
        //                case 'TAX':
        //                    $('#li2').addClass('active');
        //                    $('#divTaxmaster').attr("style", "display:block");
        //                    break;
        //                case 'TOD':
        //                    $('#li3').addClass('active');
        //                    $('#divTurnovrDisc').attr("style", "display:block");
        //                    break;
        //                case 'CUP':
        //                    $('#li4').addClass('active');
        //                    $('#divCoupon').attr("style", "display:block");
        //                    break;
        //                case 'RCD':
        //                    $('#li5').addClass('active');
        //                    $('#divRateDiscount').attr("style", "display:block");
        //                    break;
        //            }
        //            if (flag == 1)
        //                ClearText();
    }
    function IAmSelected(source, eventArgs) {

        var varGetVal = eventArgs.get_value();
        var ID;
        var name;
        var InvType;
        var list = eventArgs.get_value().split('^');
        if (list.length > 0) {
            for (i = 0; i < list.length; i++) {
                if (list[i] != "") {
                    ID = list[0];
                    name = list[1];
                    InvType = list[2];
                    document.getElementById('hdnInvID').value = ID;
                    document.getElementById('hdnInvName').value = name;
                    document.getElementById('hdnInvType').value = InvType;


                }
            }
        }
    }
    function clearfn() {

        if (document.getElementById('TxtInv').value.length <= 0 && document.getElementById('TxtInv').value != "") {
            document.getElementById('lblInvType').innerHTML = '';
        }
        else {
            document.getElementById('lblInvType').innerHTML = document.getElementById('hdnInvType').value;
        }
    }

    function SelectedTest(source, eventArgs) {
        document.getElementById('hdnSelectedTest').value = eventArgs.get_value();
        var x = document.getElementById('hdnSelectedTest').value.split("~");
        var Type = x[0].split("^");
        var InvType = Type[2];
        document.getElementById('lblInvType').innerHTML = InvType;



    }

    function checktable() {
        document.getElementById('TODCode').disabled = false;
        var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
        var userMsg = SListForAppMsg.Get("Admin_DiscountMaster_aspx_04") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_04") : "Empty TOD Policy Doesnot Add";
        if (document.getElementById('hdnTODdetails').value == "") {
            //               alert('Empty TOD Policy Doesnot Add');
            //                return false;
           // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_6');
            if (userMsg != null) {
                //alert(userMsg);
                ValidationWindow(userMsg, AlrtWinHdr);
                return false;
            }
            else {
                //alert('Empty TOD Policy Doesnot Add');
                ValidationWindow(userMsg, AlrtWinHdr);
                return false;
            }
        }
    }

    function extractRow(src, cID) {
        var eRow = src.parentElement.parentElement;
        var RI = eRow.rowIndex;
        var CasTbl = document.getElementById("grdResult");
        document.getElementById('HdnID').value = cID;
        document.getElementById('txtDiscountName').value = CasTbl.rows[RI].cells[2].innerHTML;
        document.getElementById('txtDiscountValue').value = CasTbl.rows[RI].cells[3].innerHTML;
        document.getElementById('txtDiscountCode').value = CasTbl.rows[RI].cells[1].innerHTML;
        var updateDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") : "Update";
        
       // document.getElementById('<%=btnSave.ClientID %>').value = "Update";
        document.getElementById('<%=btnSave.ClientID %>').value = updateDisplay;
    }

    function isSpclChar(e) {
        var key;
        var isCtrl = false;
        if (window.event) // IE8 and earlier
        {
            key = e.keyCode;
        }
        else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
        {
            key = e.which;
        }
        //*************To block slash(/) into text box change the key value to 48***************************//
        if ((key >= 47 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32)) {
            isCtrl = true;
        }
        return isCtrl;
    }
    function resetTxtBx() {
            var saveDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_save") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_save") : "Save";
        document.getElementById('txtDiscountName').value = "";
        document.getElementById('txtDiscountValue').value = "";
        document.getElementById('txtDiscountCode').value = "";
        document.getElementById('HdnID').value = "";
            document.getElementById('<%=btnSave.ClientID %>').value = saveDisplay;
        var radList = document.getElementsByName('rdSel');
        for (var i = 0; i < radList.length; i++) {
            if (radList[i].checked) {
                radList[i].checked = false;
            }
        }
        return false;
    }

    function ChkDiscountName() {
        var txtdisname = document.getElementById('txtDiscountName').value;
        var btnvalue = document.getElementById('btnSave').value;
        var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
        var userMsg = SListForAppMsg.Get("Admin_DiscountMaster_aspx_05") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_05") : "Enter discount Code";
        var userMsg1 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_06") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_06") : "Enter discount name";
        var userMsg2 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_07") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_07") : "Enter discount value";
        if (document.getElementById('txtDiscountCode').value == "") {
           // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_7');
            if (userMsg != null) {
                //alert(userMsg);
                ValidationWindow(userMsg, AlrtWinHdr);
                document.getElementById('txtDiscountCode').focus();
                return false;
            }
            else {
                ValidationWindow(userMsg, AlrtWinHdr);
               // alert('Enter discount Code');
                document.getElementById('txtDiscountCode').focus();
                return false;
            }
        }
        if (document.getElementById('txtDiscountName').value == "") {
           // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_1');
            if (userMsg1 != null) {
                //alert(userMsg);
                ValidationWindow(userMsg1, AlrtWinHdr);
                document.getElementById('txtDiscountName').focus();
                return false;
            }
            else {
                // alert('Enter discount name');
                ValidationWindow(userMsg1, AlrtWinHdr);
                document.getElementById('txtDiscountName').focus();
                return false;
            }
        }
        if (document.getElementById('txtDiscountValue').value == "") {

            //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_2');
            if (userMsg2!= null) {
                //alert(userMsg);
                ValidationWindow(userMsg2, AlrtWinHdr);
                document.getElementById('txtDiscountValue').focus();
                return false;
            }
            else {
                //alert('Enter Discount Value');
                ValidationWindow(userMsg2, AlrtWinHdr);
                document.getElementById('txtDiscountValue').focus();
                return false;
            }
        }
        var DicountCode = $('#txtDiscountCode').val();
        var Flag = '';
        var DiscountID = $('#HdnID').val();
        $('#grdResult tbody tr:not(:first)').each(function(i, n) {
            var $row = $(n);
            var SelectedID = $row.find($('span[id$="lblDiscountID"]')).html();
            var OldDiscountCode = $row.find("td:eq(1)").html();
            if (SelectedID != DiscountID) {
                if (OldDiscountCode != undefined) {
                    if (DicountCode.trim().toLowerCase() == OldDiscountCode.trim().toLowerCase()) {
                        Flag = 'YES';
                        return false;
                    }
                }
            }

        });
        if (Flag == 'YES') {
            alert("DiscountCode Already Added");
            $('#txtDiscountCode').val('');
            $('#txtDiscountName').val('');
            $('#txtDiscountValue').val('');
            document.getElementById('txtDiscountCode').focus();
            return false;
        }
    }
    function chkdelete() {
        var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
        var userMsg = SListForAppMsg.Get("Admin_DiscountMaster_aspx_08") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_08") : "select one record";
        var userMsg1 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_10") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_10") : "Confirm to delete !!";
        if (document.getElementById('HdnID').value == "") {
           // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_5');
            if (userMsg != null) {
                //alert(userMsg);
                ValidationWindow(userMsg, AlrtWinHdr);
                return false;
            } else {
            //  alert('select one record');
            ValidationWindow(userMsg, AlrtWinHdr);
                return false;
            }
            return false;
        }
        // var con = confirm('Confirm to delete !!');
        var con = confirm(userMsg1);
        if (con == false) {
            return false;
        }
    }
    function chkdeleteTax() {
        var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
        var userMsg = SListForAppMsg.Get("Admin_DiscountMaster_aspx_08") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_08") : "select one record";
        var userMsg1 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_10") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_10") : "Confirm to delete !!";
        
        if (document.getElementById('hdnTaxID').value == "") {
            //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_5');
            if (userMsg != null) {
                ValidationWindow(userMsg, AlrtWinHdr);
                return false;
            } else {
            //alert('select one record');
            ValidationWindow(userMsg, AlrtWinHdr);
                return false;
            }
            return false;
        }
        // var con = confirm('Confirm to delete !!');
        var con = confirm(userMsg1);
        if (con == false) {
            return false;
        }
    }
    function showCouponMasterDetails(plusImg, minusImg, responses, status) {
        var obj1 = document.getElementById(plusImg);
        var obj2 = document.getElementById(minusImg);
        var obj3 = document.getElementById(responses);
        if (status == 1) {
            document.getElementById('divCouponDetails').style.display = 'block';
            document.getElementById('divCouponMaster').style.display = 'none';
            obj2.style.display = 'block';
            obj1.style.display = 'none';
        }
        else {
            document.getElementById('divCouponDetails').style.display = 'none';
            document.getElementById('divCouponMaster').style.display = 'block';
            obj2.style.display = 'none';
            obj1.style.display = 'block';
        }
    }
    function LoadCategory() {
        var feeType = $('#ddlFeeType').val();
        $("#drpCategory").children('option:not(:first)').remove();
        var CategoryList = [];
        $("#drpCategory").attr("disabled", false);
        switch (feeType) {
            case "INVESTIGATION_GROUP_FEE":
                if ($.trim($('#hdnGroupCategory').val()) != '') {
                    CategoryList = JSON.parse($('#hdnGroupCategory').val());
                }
                break;
            case "INVESTIGATION_FEE":
                if ($.trim($('#hdnTestCategory').val()) != '') {
                    CategoryList = JSON.parse($('#hdnTestCategory').val());
                }
                break;

            case "HEALTH_PACKAGE":
                if ($.trim($('#hdnGroupCategory').val()) != '') {
                    CategoryList = JSON.parse($('#hdnGroupCategory').val());
                }
                break;
            default:
                $("#drpCategory").attr("disabled", true);
                break;
        }
        if (CategoryList != '' && CategoryList.length > 0) {
            $.each(CategoryList, function(i, obj) {
                $("#drpCategory").append($("<option></option>").val(obj.Code).html(obj.Value));
            });
        }
        return true;
    }

    function SetPolicyID(source, eventArgs) {
        try {
            var PolicyID = eventArgs.get_value();
            var PolicyName = eventArgs.get_text();
            var OrgID = "<%= OrgID %>";
            var Error = true;
            if (PolicyName != null && PolicyName.length > 1) {
                $("#txtDiscountPolicy").val(PolicyName);
                Error = false;
            }
            if (PolicyID != '' && PolicyID.length > 0) {
                $("#hdnPolicyID").val(PolicyID);
                Error = false;
            }
            if (Error == false) {
                $("#lblResultStatus").text('');
                BindDiscountPolicy(PolicyID, OrgID);
            }
        }
        catch (e) {
            return false;
        }
    }

    function BindDiscountPolicy(PolicyID, OrgID) {
        try {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetDiscountPolicyMapping",
                data: "{OrgID: " + OrgID + ", PolicyID:" + PolicyID + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Success(data) {
                    var lstDiscountPolicy = data.d;
                    var oNameValueCollection = [];
                    if (lstDiscountPolicy.length > 0) {
                        for (var i = 0; i < lstDiscountPolicy.length; i++) {
                            oNameValueCollection.push({
                                FeeType: lstDiscountPolicy[i].FeeType,
                                FeeName: lstDiscountPolicy[i].FeeName,
                                CategoryType: lstDiscountPolicy[i].CategoryCode,
                                CategoryText: lstDiscountPolicy[i].CategoryName,
                                DiscountValue: lstDiscountPolicy[i].DiscountPercentage,
                                ValueType: lstDiscountPolicy[i].DiscountType,
                                ValueText: lstDiscountPolicy[i].DiscountName
                            });
                        }
                        if (oNameValueCollection != null && oNameValueCollection.length > 0) {
                            $("[id$='tbDisPolicy'] tbody tr").remove();
                            CreateRateCardDisTable(oNameValueCollection);
                        }
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
                // alert(xhr.status);
                ValidationWindow(xhr.status, AlrtWinHdr);
                }
            });
        }
        catch (e) {
            return false;
        }
    }
    function DiscountPolicyValidation() {
        var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
        var userMsg = SListForAppMsg.Get("Admin_DiscountMaster_aspx_11") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_11") : "Please Enter Policy Name.";
 
            var userMsg2 = SListForAppMsg.Get("Admin_UserMaster_aspx_37") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_37") : "Please select fee type.";
            var userMsg1 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_13") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_13") : "Please enter discount value.";
        if ($("#txtDiscountPolicy").val() == "") {
            //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_8');
            if (userMsg != null) {
                //  alert(userMsg);
                ValidationWindow(userMsg, AlrtWinHdr);
                $("#txtDiscountPolicy").focus();
                return false;
            } else {
            //alert("Please enter policy name");
            ValidationWindow(userMsg, AlrtWinHdr);
                $("#txtDiscountPolicy").focus();
                return false;
            }
            //                alert("Please enter policy name");
            //                $("#txtDiscountPolicy").focus();
            //                return false;
        }
        if ($('#ddlFeeType').val() == "0") {
  
            //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_9');
                if (userMsg2 != null) {
                // alert(userMsg);
                    ValidationWindow(userMsg2, AlrtWinHdr);
                $("#ddlFeeType").focus();
                return false;
            }
            else {
                //alert("Please select fee type");
                    ValidationWindow(userMsg2, AlrtWinHdr);
                $("#ddlFeeType").focus();
                return false;
            }

            //                alert("Please select fee type");
            //                $("#ddlFeeType").focus();
            //                return false;
        }
        if ($("#txtDisValue").val() == "") {
            //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_10');
            if (userMsg1 != null) {
                // alert(userMsg);
                ValidationWindow(userMsg1, AlrtWinHdr);
                $("#txtDisValue").focus();
                return false;
            }
            else {
                // alert("Please enter discount value");
                ValidationWindow(userMsg1, AlrtWinHdr);
                $("#txtDisValue").focus();
                return false;
            }

            //                alert("Please enter discount value");
            //                $("#txtDisValue").focus();
            //                return false;
        }
        if ($("#drpDisType").val() == "0") {
            //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_11');
            var userMsg2 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_14") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_14") : "Please select the Type";
            if (userMsg2 != null) {
                //alert(userMsg);
                ValidationWindow(userMsg2, AlrtWinHdr);
                $("#drpDisType").focus();
                return false;
            }
            else {
                // alert("Please select the Type");
                ValidationWindow(userMsg2, AlrtWinHdr);
                $("#drpDisType").focus();
                return false;
            }

            //                alert("Please select the Type");
            //                $("#drpDisType").focus();
            //                return false;
        }
        AddDiscountPolicy();
        return false;
    }

    function AddDiscountPolicy() {
        var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
        var userMsg = SListForAppMsg.Get("Admin_DiscountMaster_aspx_15") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_15") : "You cannot allow to add more than 1 Discount for this Fee Type and Category";
        try {
            var newDataSet = '';
            var CategoryType = '';
            var CategoryName = '';
            var policyName = $("#txtDiscountPolicy").val();
            var feeType = $('#ddlFeeType').val();
            var feeName = $("#ddlFeeType option:selected").text();
            var disValue = $("#txtDisValue").val();
            if ($('#drpCategory').val() != "0") {
                CategoryType = $('#drpCategory').val();
                CategoryName = $("#drpCategory option:selected").text();
            }
            var Exists = false;
            var ValueType = $('#drpDisType').val();
            var ValueText = $("#drpDisType option:selected").text();
            var policyID = 0;
            var oNameValueCollection = [];
            if ($("#hdnPolicyID").val() != "" && $("#hdnPolicyID").val().length > 0) {
                policyID = $("hdnPolicyID").val();
            }
            $('[id$="tbDisPolicy"] tbody tr').each(function(i, n) {
                var currentRow = $(n);
                var tbfeeTypeID = currentRow.find("span[id$='feeID']").html();
                var tbCategoryID = currentRow.find("span[id$='CTypeID']").html();
                var tbAmount = currentRow.find("span[id$='DisValue']").html();
                if ($('#btnAddRateDetails').val() != 'Update') {
                    if ($.trim(tbfeeTypeID) == feeType && $.trim(tbCategoryID) == CategoryType) {
                        //alert('You cannot allow to add more than 1 Discount for this Fee Type and Category');
                        ValidationWindow(userMsg, AlrtWinHdr);
                        Exists = true;
                    }
                }
            });
            if (!Exists) {
                if ($('[id$="hdnRowPolicyIndex"]').val() == '') {
                    oNameValueCollection.push({
                        FeeType: feeType,
                        FeeName: feeName,
                        CategoryType: CategoryType,
                        CategoryText: CategoryName,
                        DiscountValue: disValue,
                        ValueType: ValueType,
                        ValueText: ValueText
                    });
                    CreateRateCardDisTable(oNameValueCollection);
                }
                else {
                    var selectedRowID = $('[id$="hdnRowPolicyIndex"]').val();
                    var selectedRow = '';
                    selectedRow = $('[id$="tbDisPolicy"] tbody tr:eq(' + selectedRowID + ')');
                    selectedRow.find("span[id$='feeID']").html(feeType);
                    selectedRow.find("span[id$='feeText']").html(feeName)
                    selectedRow.find("span[id$='CTypeID']").html(CategoryType)
                    selectedRow.find("span[id$='CName']").html(CategoryName)
                    selectedRow.find("span[id$='DisValue']").html(disValue)
                    selectedRow.find("span[id$='vType']").html(ValueType)
                    selectedRow.find("span[id$='vName']").html(ValueText)
                    ClearPolicyDetails();
                }
            }
            else {
                return false;
            }

        }
        catch (e) {
            return false;
        }
    }

    function CreateRateCardDisTable(nameValueCollection) {
        try {
            var DataTable = [];
            DataTable = nameValueCollection;
            $.each(DataTable, function(i, obj) {
                dtTR = $('<tr/>');
                var tdfTypeID = $('<td style="display:none;"/>').html("<span id='feeID'>" + obj.FeeType + " </span>");
                var tdfName = $('<td align="left"/>').html("<span id='feeText'>" + obj.FeeName + " </span>");
                var tdCTypeID = $('<td style="display:none;"/>').html("<span id='CTypeID'>" + obj.CategoryType + " </span>");
                var tdCName = $('<td/>').html("<span id='CName'>" + obj.CategoryText + " </span>");
                var tdDisValue = $('<td/>').html("<span id='DisValue'>" + obj.DiscountValue + " </span>");
                var tdvType = $('<td style="display:none;"/>').html("<span id='vType'>" + obj.ValueType + " </span>");
                var tdvName = $('<td/>').html("<span id='vName'>" + obj.ValueText + " </span>");
                //                    var btnEdit = '<input id="btnEditDiscount" value="Edit" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;" onclick="onEditDiscount(this);"/>';
                //                    var btnDelete = '<input id="btnDeleteDiscount" value="Delete" type="button" style="background-color: Transparent; color: Red; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;" onclick="onDeleteDiscount(this);"/>';
                var btnEdit = '<input id="btnEditDiscount" value="<%=Resources.ClientSideDisplayTexts.Admin_DiscountMaster_Edit%>" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;" onclick="onEditDiscount(this);"/>';
                var btnDelete = '<input id="btnDeleteDiscount" value="<%=Resources.ClientSideDisplayTexts.Admin_DiscountMaster_Delete%>" type="button" style="background-color: Transparent; color: Red; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;" onclick="onDeleteDiscount(this);"/>';
                var tdAction = $('<td/>').html(btnEdit + btnDelete);
                dtTR.append(tdfTypeID).append(tdfName).append(tdCTypeID).append(tdCName).append(tdDisValue).append(tdvType).append(tdvName).append(tdAction);
                $('[id$="tbDisPolicy"] tbody').append(dtTR);
            });
            $("#divRCD").attr("style", "display:block");
            $("#trAction").attr("style", "display:table-row");
            ClearPolicyDetails();
        }
        catch (e) {
            return false;
        }
    }

    function ClearPolicyDetails() {
            var clearDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_clear") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_clear") : "Clear";
            var addDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_Add") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_Add") : "Add";
            try {
                //$('#txtDiscountPolicy').val("");
                $("#btnPolicyClear").val(clearDisplay);
            $('[id$="ddlFeeType"] option:first').attr('selected', true);
            $('[id$="drpCategory"] option:first').attr('selected', true);
            $("#txtDisValue").val("");
            $('[id$="drpDisType"] option:first').attr('selected', true);
            $('[id$="hdnRowPolicyIndex"]').val("");
                $('#btnAddRateDetails').val(addDisplay);
            $('[id$="drpCategory"]').attr("disabled", false);

            return false;
        }
        catch (e) {
            return false;
        }
    }

    function ClearTable() {
        ClearPolicyDetails();
        $("[id$='tbDisPolicy'] tbody tr").remove();
        $("#txtDiscountPolicy").val("");
        $("#hdnPolicyID").val("");
        $("#divRCD").attr("style", "display:none");
        $("#trAction").attr("style", "display:none");
        $("#txtDiscountPolicy").val("");
        $("#hdnPolicyID").val("");
        $("[id$='btnAddRateDetails']").attr("style", "display:block");
        $("[id$='txtDiscountPolicy']").removeAttr('disabled');
        // $("[id$='txtDiscountPolicy']").focus();
       // $("#txtDisValue").val("");
        DisplayTab('RCD', '0');
        return false;
    }
    function onEditDiscount(editItmes) {
            var updateDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") : "Update";
        try {
            var $setItems = $(editItmes).closest('tr');
            var rowIndex = $setItems.index();
                $('#btnAddRateDetails').val(updateDisplay);
            var feeType = $setItems.find("span[id$='feeID']").html();
            if (feeType != '')
            // $('[id$="ddlFeeType"] option[value=' + feeType + ']').attr("selected", "selected");
                $('#ddlFeeType').val(feeType.trim());
            else
                $('[id$="ddlFeeType"] option:first').attr('selected', true);
            LoadCategory();
            var Cid = $setItems.find("span[id$='CTypeID']").html();
            $('[id$="drpCategory"]').attr("disabled", true);
            if (Cid != '') {
                $('[id$="drpCategory"] option[value=' + Cid + ']').attr("selected", "selected");
            }
            else {
                $('[id$="drpCategory"] option:first').attr('selected', true);
            }
            var disValue = $setItems.find("span[id$='DisValue']").html();
            if (disValue != '')
                $('[id$="txtDisValue"]').val(disValue);
            else
                $('[id$="txtDisValue"]').val('');
            var disType = $setItems.find("span[id$='vType']").html();
            if (disType != '')
                $('[id$="drpDisType"] option[value=' + disType + ']').attr("selected", "selected");
            else
                $('[id$="drpDisType"] option:first').attr("selected", true);
            $('[id$="hdnRowPolicyIndex"]').val(rowIndex);
        }
        catch (e) {
            return false;
        }
        return false
    }

    function onDeleteDiscount(DeleteItems) {
        try {
            $(DeleteItems).closest('tr').remove();
        }
        catch (e) {
            return false;
        }
        return false;
    }

    function SavePolicyDetails() {
        if ($("#txtDiscountPolicy").val() != "") {
            var policyID = 0;
            var lstDiscountPolicyMapping = [];
            if ($("#hdnPolicyID").val() != "" && $("#hdnPolicyID").val().length > 0) {
                policyID = $("#hdnPolicyID").val();
            }
            var amountOfRows = $("#tbDisPolicy  tbody  tr").length;
            if (amountOfRows == 0) {
                lstDiscountPolicyMapping.push({
                    PolicyID: policyID,
                    FeeType: 'N',
                    CategoryCode: 'N',
                    DiscountPercentage: 0.00,
                    DiscountType: 'DEL'
                });
                if (lstDiscountPolicyMapping.length > 0) {
                    $('[id$="hdnRCDdetails"]').val(JSON.stringify(lstDiscountPolicyMapping));
                }
            }
            else {

                $('[id$="tbDisPolicy"] tbody tr').each(function(i, n) {
                    var currentRow = $(n);
                    var feeType = currentRow.find("span[id$='feeID']").html();
                    var categoryCode = currentRow.find("span[id$='CTypeID']").html();
                    var discountPercentage = currentRow.find("span[id$='DisValue']").html();
                    var discountType = currentRow.find("span[id$='vType']").html();
                    lstDiscountPolicyMapping.push({
                        PolicyID: policyID,
                        FeeType: feeType,
                        CategoryCode: categoryCode,
                        DiscountPercentage: discountPercentage,
                        DiscountType: discountType
                    });
                    if (lstDiscountPolicyMapping.length > 0) {
                        $('[id$="hdnRCDdetails"]').val(JSON.stringify(lstDiscountPolicyMapping));
                    }
                });
            }
        }
    }

    function getrowid(rid, TaxID, TaxName, taxpercent, Code, ReferenceType) {
        var len = document.forms[0].elements.length;
            var updateDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") : "Update";
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        rid.checked = true;
        document.getElementById('hdnTaxID').value = TaxID;
        document.getElementById('txtTaxName').value = TaxName;
        document.getElementById('txtPercent').value = taxpercent.split('.')[0];
        document.getElementById('txttaxCode').value = Code;
        document.getElementById('drpRefType').value = ReferenceType;
            document.getElementById('<%=btnSaveTax.ClientID %>').value = updateDisplay;
        if (document.getElementById('tdbtnDeleteTax').style.display == 'none')
            document.getElementById('tdbtnDeleteTax').style.display = 'table-cell';
    }
    function ValidateCouponMaster() {
        var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
        var userMsg = SListForAppMsg.Get("Admin_DiscountMaster_aspx_16") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_16") : "Enter Coupon code";
        if (document.getElementById('txtCouponCode').value == '') {
          // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_12');
            if (userMsg != null) {
                //alert(userMsg);
                ValidationWindow(userMsg, AlrtWinHdr);
                document.getElementById('txtCouponCode').focus();
                return false;
            }
            else {
                ValidationWindow(userMsg, AlrtWinHdr);
                //alert('Enter Coupon Code');
                document.getElementById('txtCouponCode').focus();
                return false;
            }
            //                alert('Enter Coupon Code');
            //                return false;
        }
        if (document.getElementById('txtCouponName').value == '') {
            // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_13');
            var userMsg1 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_17") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_17") : "Enter Coupon Name";
            if (userMsg1 != null) {
                //alert(userMsg);
                ValidationWindow(userMsg1, AlrtWinHdr);
                document.getElementById('txtCouponName').focus();
                return false;
            }
            else {
                //alert('Enter Coupon Name');
                ValidationWindow(userMsg1, AlrtWinHdr);
                document.getElementById('txtCouponName').focus();
                return false;

            }
            //                alert('Enter Coupon Name');
            //                return false;
        }
    }
    function ValidateCouponDetails() {
        var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
        var userMsg = SListForAppMsg.Get("Admin_DiscountMaster_aspx_18") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_18") : "Select Coupon Code";
        if (document.getElementById('ddlCoupon').value == '-1') {
           // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_12');
            if (userMsg != null) {
                //  alert(userMsg);
                ValidationWindow(userMsg, AlrtWinHdr);
                return false;
            }
            else {
                //alert('Select Coupon Code');
                ValidationWindow(userMsg, AlrtWinHdr);
                return false;
            }
            //                alert('Select Coupon Code');
            //                return false;
        }
        if (document.getElementById('txtStartSerialNo').value == '') {
            // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_14');
            var userMsg1 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_19") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_19") : "Enter Starting Serail No.";
            if (userMsg1 != null) {
                // alert(userMsg);
                ValidationWindow(userMsg1, AlrtWinHdr);
                return false;
            }
            else {
                // alert('Enter Starting Serail No.');
                ValidationWindow(userMsg1, AlrtWinHdr);
                return false;
            }
            //                alert('Enter Starting Serail No.');
            //                return false;
        }
        if (document.getElementById('txtEndSerialNo').value == '') {
            // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_14');
            var userMsg2 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_20") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_20") : "Enter End Serial No.";
            if (userMsg2 != null) {
                // alert(userMsg);
                ValidationWindow(userMsg2, AlrtWinHdr);
                return false;
            }
            else {
                // alert('Enter End Serial No.');
                ValidationWindow(userMsg2, AlrtWinHdr);
                return false;
            }
            //                alert('Enter End Serial No.');
            //                return false;
        }
        if (document.getElementById('txtBatchNo').value == '') {
            //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_15');
            var userMsg3 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_21") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_21") : "Enter Batch No.";
            if (userMsg3 != null) {
                //  alert(userMsg);
                ValidationWindow(userMsg3, AlrtWinHdr);
                return false;
            }
            else {
                //  alert('Enter Batch No.');
                ValidationWindow(userMsg3, AlrtWinHdr);
                return false;
            }
            //                alert('Enter Batch No.');
            //                return false;

        }
        if (document.getElementById('txtOrderedUnits').value == '') {
            // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_16');
            var userMsg4 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_22") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_22") : "Enter Ordered Units";
            if (userMsg4 != null) {
                //alert(userMsg);
                ValidationWindow(userMsg4, AlrtWinHdr);
                return false;
            }
            else {
                //  alert('Enter Ordered Units');
                ValidationWindow(userMsg4, AlrtWinHdr);
                return false;
            }
            //                alert('Enter Ordered Units');
            //                return false;

        }
        if (document.getElementById('txtCouponValue').value == '') {
            // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_17');
            var userMsg5 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_23") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_23") : "Enter Coupon Value";
            if (userMsg5 != null) {
                //alert(userMsg);
                ValidationWindow(userMsg5, AlrtWinHdr); 
                return false;
            }
            else {
                // alert('Enter Coupon Value');
                ValidationWindow(userMsg5, AlrtWinHdr); 
                return false;
            }
            //                alert('Enter Coupon Value');
            //                return false;
        }
        if (document.getElementById('txtExpiryDate').value == '') {
            // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_18');
            var userMsg6 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_24") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_24") : "Enter/Select Expiry Date";
            if (userMsg6 != null) {
                //alert(userMsg);
                ValidationWindow(userMsg6, AlrtWinHdr); 
                return false;
            }
            else {
                //alert('Enter/Select Expiry Date');
                ValidationWindow(userMsg6, AlrtWinHdr); 
                return false;

            }
            //                alert('Enter/Select Expiry Date');
            //                return false;
        }

    }
    function ClearCouponMaster() {
        document.getElementById('txtCouponCode').value = '';
        document.getElementById('txtCouponName').value = '';
        document.getElementById('chkStatus').checked = false;
        document.getElementById('hdnCouponID').value = '';
        return false;
    }
    function getcouponmasterrowid(rid, CouponID, Code, Name, Status) {
        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        rid.checked = true;
        document.getElementById('txtCouponCode').value = Code;
        document.getElementById('txtCouponName').value = Name;
        if (Status == 'Active') {
            document.getElementById('chkStatus').checked = true;
        }
        else {
            document.getElementById('chkStatus').checked = false;
        }
        document.getElementById('hdnCouponID').value = CouponID;
    }
    function ClearCouponDetails() {
        document.getElementById('ddlCoupon').value = '-1';
        document.getElementById('txtStartSerialNo').value = '';
        document.getElementById('txtEndSerialNo').value = '';
        document.getElementById('txtBatchNo').value = '';
        document.getElementById('txtOrderedUnits').value = '';
        document.getElementById('txtCouponValue').value = '';
        document.getElementById('txtExpiryDate').value = '';
        document.getElementById('hdnCouponID').value = '';
        return false;
    }
    function getcoupondetailsrowid(rid, CouponDetailID, CouponID, StartSerialNo, EndSerialNo, BatchNo, OrderedUnits, CouponValue, ExpiryDate, ConsumedUnits) {
        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        rid.checked = true;
        document.getElementById('ddlCoupon').value = CouponID;
        document.getElementById('txtStartSerialNo').value = StartSerialNo;
        document.getElementById('txtEndSerialNo').value = EndSerialNo;
        document.getElementById('txtBatchNo').value = BatchNo;
        document.getElementById('txtOrderedUnits').value = OrderedUnits;
        document.getElementById('txtCouponValue').value = CouponValue;
        document.getElementById('txtExpiryDate').value = ExpiryDate.substring(0, 10);
        document.getElementById('hdnCouponID').value = CouponDetailID;
        Temp();
    }
    function SelectedClientValue(source, eventArgs) {
        var Name = eventArgs.get_text();
        var ID = eventArgs.get_value();
        document.getElementById('hdnClientID').value = ID;
        var ctype = 'cstype';
        GetTODCustomerdetails(ID);
    }
    function checkIsValid() {
        var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
        var userMsg = SListForAppMsg.Get("Admin_DiscountMaster_aspx_25") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_25") : "Provide tax name";
        if (document.getElementById('txtTaxName').value == "") {
          //  var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_19');
            if (userMsg != null) {
                // alert(userMsg);
                ValidationWindow(userMsg, AlrtWinHdr);
                document.getElementById('txtTaxName').focus();
                return false;
            }
            else {
                // alert('Provide tax name');
                ValidationWindow(userMsg, AlrtWinHdr);
                document.getElementById('txtTaxName').focus();
                return false;
            }
            //                alert('Provide tax name');
            //                document.getElementById('txtTaxName').focus();
            //                return false;
        }
        if (document.getElementById('txttaxCode').value == "") {
            // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_20');
            var userMsg1 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_26") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_26") : "Provide tax Code";
            if (userMsg1 != null) {
                // alert(userMsg);
                ValidationWindow(userMsg1, AlrtWinHdr);
                document.getElementById('txttaxCode').focus();
                return false;
            }
            else {
                //alert('Provide tax Code');
                ValidationWindow(userMsg1, AlrtWinHdr);
                document.getElementById('txttaxCode').focus();
                return false;
            }
            //                alert('Provide tax Code');
            //                document.getElementById('txttaxCode').focus();
            //                return false;
        }
        if (document.getElementById('txtPercent').value == "") {
            //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_21');
            var userMsg2 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_27") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_27") : "Provide tax percent";
            if (userMsg2 != null) {
                // alert(userMsg);
                ValidationWindow(userMsg2, AlrtWinHdr);
                document.getElementById('txtPercent').focus();
                return false;
            }
            else {
                // alert('Provide tax percent');
                ValidationWindow(userMsg2, AlrtWinHdr);
                document.getElementById('txtPercent').focus();
                return false;
            }
            //                alert('Provide tax percent');
            //                document.getElementById('txtPercent').focus();
            //                return false;
        }
        if (document.getElementById('drpRefType').options[document.getElementById('drpRefType').selectedIndex].value == '0') {
            // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_22');
            var userMsg3 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_28") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_28") : "Please select the reference type";
            if (userMsg3 != null) {
                //alert(userMsg);
                ValidationWindow(userMsg3, AlrtWinHdr);
                document.getElementById('drpRefType').focus();
                return false;
            }
            else {
                //alert('Please seletect the refernce type');
                ValidationWindow(userMsg3, AlrtWinHdr);
                document.getElementById('drpRefType').focus();
                return false;
            }
        }
        var TaxCode = $('#txttaxCode').val();
        var TaxPercent = $('#txtPercent').val();
        var SelReferenceType = $('#drpRefType').val();
        var ReferenceType;
        if (SelReferenceType == 'INV') {
            ReferenceType = 'Invoice'
        }
        if (SelReferenceType == 'BIL') {
            ReferenceType = 'Bill'
        }
        var pTaxID = $('#hdnTaxID').val();
        var Flag1 = '';
        $('#GrdTaxmaster tbody tr:not(:first)').each(function(i, n) {
            var $row = $(n);
            var OldSelectedID = $row.find($('span[id$="lblpTaxID"]')).html();
            var OldTaxCode = $row.find("td:eq(2)").html();
            var OldTaxPercent = $row.find("td:eq(3)").html();
            var OldReferenceType = $row.find("td:eq(4)").html();
            if (OldSelectedID != pTaxID) {
                if (OldTaxCode != undefined && OldTaxPercent != undefined) {
                    if (TaxCode.trim().toLowerCase() == OldTaxCode.trim().toLowerCase() && TaxPercent.trim().toLowerCase() == OldTaxPercent.trim().toLowerCase() && ReferenceType.trim().toLowerCase() == OldReferenceType.trim().toLowerCase()) {
                        Flag1 = 'YES';
                        return false;
                    }
                }
            }

        });
        if (Flag1 == 'YES') {
            var userMsg5 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_29") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_29") : "Tax Already Added";
                ValidationWindow(userMsg5, AlrtWinHdr);
            $('#txtTaxName').val('');
            $('#txttaxCode').val('');
            $('#txtPercent').val('');
            $('#drpRefType').val(0);
            return false;
        }
    }

    function ResetTaxField() {
            var saveDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_save") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_save") : "Save";
        document.getElementById('txtTaxName').value = "";
        document.getElementById('txtPercent').value = "";
        document.getElementById('txttaxCode').value = "";
        document.getElementById('drpRefType').value = '0';
        if (document.getElementById('tdbtnDeleteTax').style.display == 'table-cell')
            document.getElementById('tdbtnDeleteTax').style.display = 'none';
            document.getElementById('<%=btnSaveTax.ClientID %>').value = saveDisplay;
        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        return false;
    }
    function GetValues(id) {
        var TodId = "0";
            var updateDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") : "Update";
            if (document.getElementById(id).value == updateDisplay) {
            TodId = document.getElementById('hdnEditedValue').value.split('~')[0];
            Active = document.getElementById('hdnEditedValue').value.split('~')[6];
            var hdnList = document.getElementById('hdnTODdetails').value;
            document.getElementById('hdnTODdetails').value = "";
            var hdnVal = hdnList.split("^");
            for (var i = 0; i < hdnVal.length; i++) {
                if (hdnVal[i] != "") {
                    if (document.getElementById('hdnEditedValue').value != hdnVal[i]) {
                        document.getElementById('hdnTODdetails').value += hdnVal[i] + "^";
                    }
                }
                document.getElementById('TDActive').style.display = 'none';
            }
        }
        var Type = document.getElementById('drpTODType').options[document.getElementById('drpTODType').selectedIndex].value;
        var Code = document.getElementById('TODCode').value;
        var txtfrom = document.getElementById('txtFrom').value;
        var txtto = document.getElementById('txtTo').value;
        var percentage = document.getElementById('txtPercentage').value;
        var Inv = document.getElementById('TxtInv').value;
        var FeeID = document.getElementById('hdnInvID').value;
        var FeeType = document.getElementById('hdnInvType').value;
        var InvName = document.getElementById('hdnInvName').value;

        var Active = "Y";
            if (document.getElementById(id).value == updateDisplay) {
            Active = document.getElementById('chkActive').checked == true ? "Y" : "N";
        }



        if (document.getElementById('drpTODType').options[document.getElementById('drpTODType').selectedIndex].innerText == 'Select') {
            // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_23');
            var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_DiscountMaster_aspx_30") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_30") : "Select Type";
            if (userMsg != null) {
                // alert(userMsg);
                ValidationWindow(userMsg, AlrtWinHdr);
                document.getElementById('drpTODType').focus();
                return false;
            }
            else {
                //alert('Select Type');
                ValidationWindow(userMsg, AlrtWinHdr);
                document.getElementById('drpTODType').focus();
                return false;
            }

            //                alert('Select Type');
            //                document.getElementById('drpTODType').focus();
            //                return false;

        }
            if (document.getElementById(id).value != updateDisplay) {
            if (document.getElementById('drpTODType').options[document.getElementById('drpTODType').selectedIndex].value == 'Vol' && document.getElementById('drpTODType').disabled == false) {
                if (Inv == "") {
                    var userMsg1 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_31") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_31") : "Select Investigation";
                    if (userMsg1 != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg1, AlrtWinHdr);
                        document.getElementById('TxtInv').focus();
                        return false;
                    }
                    else {
                        //alert('Select Investigation');
                        ValidationWindow(userMsg1, AlrtWinHdr);
                        document.getElementById('TxtInv').focus();
                        return false;
                    }

                    //                        alert('Select Investigation');
                    //                        document.getElementById('TxtInv').focus();
                    //                        return false;
                }
            }
        }

        if (Code == "") {
            //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_25');
            var userMsg2 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_32") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_32") : "Provide Code";
            if (userMsg2 != null) {
                // alert(userMsg);
                ValidationWindow(userMsg2, AlrtWinHdr);
                document.getElementById('TODCode').focus();
                return false;
            }
            else {
                //   alert('Provide Code');
                ValidationWindow(userMsg2, AlrtWinHdr);
                document.getElementById('TODCode').focus();
                return false;
            }

            //                alert('Provide Code');
            //                document.getElementById('TODCode').focus();
            //                return false;

        }
        if (Type == 'Vol') {
            if (Inv == "") {
                //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_25');
                var userMsg3= SListForAppMsg.Get("Admin_DiscountMaster_aspx_33") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_33") : "Provide The Investigation Name";
                if (userMsg3 != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg3, AlrtWinHdr);
                    document.getElementById('TxtInv').focus();
                    return false;
                }
                else {
                    // alert('Provide The Investigation Name');
                    ValidationWindow(userMsg3, AlrtWinHdr);
                    document.getElementById('TxtInv').focus();
                    return false;
                }
            }
        }

        if (txtfrom == "" || txtfrom == '0') {
            //  var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_26');
            var userMsg4 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_34") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_34") : "This Range is Not Valid.Please give valid Range";
            if (userMsg4 != null) {
                // alert(userMsg);
                ValidationWindow(userMsg4, AlrtWinHdr);
                document.getElementById('txtFrom').focus();
                return false;
            }
            else {
                //alert('This Range is Not Valid.Please give valid Range');
                ValidationWindow(userMsg4, AlrtWinHdr);
                //alert('Provide valid range');
                document.getElementById('txtFrom').focus();
                return false;
            }

            //                alert('Provide valid range');
            //                document.getElementById('txtFrom').focus();
            //                return false;
        }
        if (txtto == "" || txtto == '0') {
            // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_26');
            var userMsg5 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_34") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_34") : "This Range is Not Valid.Please give valid Range";

            if (userMsg5 != null) {
                //  alert(userMsg);
                ValidationWindow(userMsg5, AlrtWinHdr);
                document.getElementById('txtTo').focus();
                return false;
            }
            else {
                // alert('This Range is Not Valid.Please give valid Range');
                ValidationWindow(userMsg5, AlrtWinHdr);
                // alert('Provide valid range');
                document.getElementById('txtTo').focus();
                return false;
            }

            //                alert('Provide valid range');
            //                document.getElementById('txtTo').focus();
            //                return false;
        }
        if (percentage == "") {
            //var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_27');
            var userMsg6 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_35") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_35") : "Provide percentage";
            if (userMsg6 != null) {
                // alert(userMsg);
                ValidationWindow(userMsg6, AlrtWinHdr);
                document.getElementById('txtPercentage').focus();
                return false;
            }
            else {
                // alert('Provide percentage');
                ValidationWindow(userMsg6, AlrtWinHdr);
                document.getElementById('txtPercentage').focus();
                return false;
            }

            //                alert('Provide percentage');
            //                document.getElementById('txtPercentage').focus();
            //                return false;
        }

        if (parseInt(txtto) <= parseInt(txtfrom)) {
            //  var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_28');
            var userMsg7 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_34") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_34") : "This Range is Not Valid.Please give valid Range";

            if (userMsg7 != null) {
                //  alert(userMsg);
                ValidationWindow(userMsg7, AlrtWinHdr);
                document.getElementById('txtFrom').focus();
                return false;
            }
            else {
                //alert('This Range is Not Valid.Please give valid Range');
                ValidationWindow(userMsg7, AlrtWinHdr);
                //alert('Given range not valid !');
                document.getElementById('txtFrom').focus();
                return false;
            }

            //                alert('Given range not valid !');
            //                document.getElementById('txtFrom').focus();
            //                return false;

        }
        var hdnVal = document.getElementById('hdnTODdetails').value.split("^");
        var isValid = true;
        for (var i = 0; i < hdnVal.length; i++) {
            if (hdnVal[i] != "") {
                if (Type == 'Rev') {

                    if (parseInt(txtfrom) >= parseInt(hdnVal[i].split('~')[1]) && parseInt(txtfrom) <= parseInt(hdnVal[i].split('~')[2])) {
                        isValid = false;
                    }
                    if (parseInt(txtto) >= parseInt(hdnVal[i].split('~')[1]) && parseInt(txtto) <= parseInt(hdnVal[i].split('~')[2])) {
                        isValid = false;
                    }
                }
            }
        }

            var addDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_Add") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_Add") : "Add";
        if (isValid) {
            document.getElementById('hdnTODdetails').value += TodId + "~" + txtfrom + "~" + txtto + "~" + percentage + "~" + Code + "~" + Type + "~" + Active + "~" + FeeID + "~" + FeeType + "~" + Inv + "^";
            if (document.getElementById('hdnTODdetails').value != '') {
                GenerateTable();
                    document.getElementById('btnAdd').value = addDisplay;
                document.getElementById('btnSaveTOD').style.display = 'block';
                document.getElementById('txtFrom').value = "";
                document.getElementById('txtTo').value = "";
                document.getElementById('txtPercentage').value = "";
                document.getElementById('TxtInv').disabled = false;
                document.getElementById('drpTODType').disabled = true;
                document.getElementById('TxtInv').value = "";
            }
        }
        else {
            // var userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_29');
            var userMsg8 = SListForAppMsg.Get("Admin_DiscountMaster_aspx_34") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_34") : "This Range is Not Valid.Please give valid Range";

            if (userMsg8 != null) {
                // alert(userMsg);
                ValidationWindow(userMsg8, AlrtWinHdr);
                document.getElementById('txtFrom').focus();
                return false;
            }
            else {
                //alert('This Range is Not Valid.Please give valid Range');
                ValidationWindow(userMsg8, AlrtWinHdr);
                document.getElementById('txtFrom').focus();
                return false;
            }


            //                alert('This Range in Not Valid.Please give valid Range');
            //                document.getElementById('txtFrom').focus();
            //                return false;


        }
    }
    function GetTODCustTypedetails() {
        document.getElementById('TODCode').disabled = false;
        document.getElementById('txtFrom').disabled = false;
        document.getElementById('txtTo').disabled = false;
        document.getElementById('txtPercentage').disabled = false;
        document.getElementById('btnAdd').disabled = false;
        var todDetails = document.getElementById('hdnTODdetails').value.split('^');
        for (var i = 0; i < todDetails.length; i++) {
            if (todDetails[i] != '') {
                document.getElementById('hdnTODiscount').value += todDetails[i].split('~')[0] + '~' + todDetails[i].split('~')[1] + '~' + todDetails[i].split('~')[2] + '~' + todDetails[i].split('~')[3] + '~' + todDetails[i].split('~')[4] + '~' + todDetails[i].split('~')[5] + '~' + todDetails[i].split('~')[6] + '^';
            }
        }
        if (document.getElementById('hdnTODiscount').value != '') {
            GenerateTable();
        }
    }


    function GetTODCustomerdetails() {
        document.getElementById('hdnTODiscount').value = '';
        var todDetails = document.getElementById('hdnTODdetails').value.split('^');
        for (var i = 0; i < todDetails.length; i++) {
            if (todDetails[i] != '') {

                document.getElementById('hdnTODiscount').value += todDetails[i].split('~')[0] + '~' + todDetails[i].split('~')[1] + '~' + todDetails[i].split('~')[2] + '~' + todDetails[i].split('~')[3] + '~' + todDetails[i].split('~')[4] + '^';

            }
        }
        GenerateTable();

    }

    function GenerateTable() {

        while (count = document.getElementById('tblTODiscount').rows.length) {
            for (var j = 0; j < document.getElementById('tblTODiscount').rows.length; j++) {
                document.getElementById('tblTODiscount').deleteRow(j);
            }
        }
        var flag = 0;
        var checkItem = document.getElementById('hdnTODdetails').value.split('^');
        if (checkItem != "") {

            for (var k = 0; k < checkItem.length; k++) {
                if (checkItem[k] != '') {
                    if (checkItem[k].split('~')[5] == 'Vol') {
                        flag = 1;
                        break;
                    }
                }
            }
            document.getElementById('btnSaveTOD').style.display = 'block';
            document.getElementById('tdTodTable').style.display = 'table-cell';
            var pList = document.getElementById('hdnTODdetails').value.split("^");
            var pParentLst = document.getElementById('hdnTODdetails').value.split("^");
            var Headrow = document.getElementById('tblTODiscount').insertRow(0);
            var Type = document.getElementById('drpTODType').options[document.getElementById('drpTODType').selectedIndex].value;
            Headrow.id = "HeadID";
            Headrow.style.fontWeight = "bold";
            Headrow.style.textAlign = "center";
            Headrow.className = "dataheader1";

            var cell0 = Headrow.insertCell(0);
            var cell1 = Headrow.insertCell(1);
            var cell2 = Headrow.insertCell(2);
            var cell3 = Headrow.insertCell(3);
            var cell4 = Headrow.insertCell(4);
            var cell5 = Headrow.insertCell(5);
            var cell6 = Headrow.insertCell(6);
            var cell7 = Headrow.insertCell(7);
            var cell8 = Headrow.insertCell(8);
            var cell9 = Headrow.insertCell(9);
            var cell10 = Headrow.insertCell(10);

            cell0.innerHTML = "TODID";
            cell1.innerHTML = "Lower Range";
            cell2.innerHTML = "Upper Range";
            cell3.innerHTML = "Percentage";
            cell4.innerHTML = "TODCode"
            cell5.innerHTML = "TODType";
            cell6.innerHTML = "IsActive";
            cell7.innerHTML = "FeeID";
            cell8.innerHTML = "FeeType";
            cell9.innerHTML = "InvName";
            cell10.innerHTML = "Action";
            cell0.style.width = "13%";
            cell1.style.width = "13%";
            cell2.style.width = "13%";
            cell3.style.width = "13%";
            cell4.style.width = "13%";
            cell5.style.width = "13%";
            cell6.style.width = "13%";
            cell7.style.width = "18%";
            cell8.style.width = "10%";
            cell9.style.width = "20%";
            cell10.style.width = "22%";
            cell8.style.display = 'none';
            if (Type == 'Rev') {
                cell9.style.display = 'none';
            }
            //                cell9.style.display = 'block';
            cell0.style.display = 'none';
            cell4.style.display = 'none';
            cell5.style.display = 'none';
            cell7.style.display = 'none';



            for (j = 0; j < pParentLst.length; j++) {
                if (pParentLst[j] != "") {
                    var row = document.getElementById('tblTODiscount').insertRow(1);
                    row.style.height = "10px";
                    row.style.textAlign = "center";
                    var cell0 = row.insertCell(0);
                    cell0.style.display = 'none';
                    var cell1 = row.insertCell(1);
                    var cell2 = row.insertCell(2);
                    var cell3 = row.insertCell(3);
                    var cell4 = row.insertCell(4);
                    var cell5 = row.insertCell(5);
                    var cell6 = row.insertCell(6);
                    var cell7 = row.insertCell(7);
                    var cell8 = row.insertCell(8);
                    var cell9 = row.insertCell(9);
                    cell4.style.display = 'none';
                    cell5.style.display = 'none';
                    cell7.style.display = 'none';
                    cell8.style.display = 'none';
                    if (Type == 'Rev') {
                        cell9.style.display = 'none';
                    }
                    var cell10 = row.insertCell(10);
                    y = pList[j].split('~');
                    cell0.innerHTML = y[0];
                    cell1.innerHTML = y[1];
                    cell2.innerHTML = y[2];
                    cell3.innerHTML = y[3];
                    cell4.innerHTML = y[4];
                    cell5.innerHTML = y[5];
                    cell6.innerHTML = y[6];
                    cell7.innerHTML = y[7];
                    cell8.innerHTML = y[8];
                    cell9.innerHTML = y[9];

                    //                        cell10.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                    //                                                 "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "' onclick='btnDelete_OnClick(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"
                    cell10.innerHTML = "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "' onclick='btnEdit_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.Admin_DiscountMaster_Edit%>' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                                                 "<input name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "~" + y[6] + "~" + y[7] + "~" + y[8] + "~" + y[9] + "' onclick='btnDelete_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.Admin_DiscountMaster_Delete%>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"

                    //                        document.getElementById('TODCode').disabled = true;

                }
            }
        }
    }
    function btnEdit_OnClick(sEditedData) {
            var updateDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_update") : "Update";
        document.getElementById('hdnEditedValue').value = sEditedData;
        var y = sEditedData.split('~');
            document.getElementById('btnAdd').value = updateDisplay;
        document.getElementById('txtFrom').value = y[1];
        document.getElementById('txtTo').value = y[2];
        document.getElementById('txtPercentage').value = y[3];
        document.getElementById('TODCode').value = y[4];
        document.getElementById('drpTODType').value = y[5];
        document.getElementById('drpTODType').disabled = true;
        document.getElementById('TODCode').disabled = true;


        if (y[5] == 'Vol') {
            //ADDED BY PREM 
            document.getElementById('hdnInvID').value = y[7];
            document.getElementById('hdnInvType').value = y[8];
            document.getElementById('hdnInvName').value = y[9];
            //---------//
            document.getElementById('lblInv').style.display = "block";
            document.getElementById('TxtInv').style.display = "block";
            document.getElementById('lblInvType').style.display = "block";
            document.getElementById('lblInvType').innerHTML = y[8];
            document.getElementById('TxtInv').value = y[9];


        }
        else {

            document.getElementById('lblInv').style.display = "none";
            document.getElementById('TxtInv').style.display = "none";
            document.getElementById('lblInvType').style.display = "none";
        }




        if (y[6] == "Y") {
            document.getElementById('TDActive').style.display = 'table-cell';
            document.getElementById('chkActive').checked = true;
        }
        else {
            document.getElementById('TDActive').style.display = 'table-cell';
            document.getElementById('chkActive').checked = false;
        }

    }
    function btnDelete_OnClick(sEditedData) {
        var AlrtWinHdr = SListForAppMsg.Get("Admin_UserMaster_aspx_41") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_41") : "Information";
        var userMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_36") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_36") : "Confirm to delete!!";
        var i;
        var ConfirmString;
            var addDisplay = SListForAppMsg.Get("Admin_DiscountMaster_aspx_Add") != null ? SListForAppMsg.Get("Admin_DiscountMaster_aspx_Add") : "Add";
       // userMsg = SListForApplicationMessages.Get('Admin\\DiscountMaster.aspx_30');
        if (userMsg != null) {
            ConfirmString = userMsg;
            var IsDelete = confirm(ConfirmString);
        }
        else {
            ConfirmString = userMsg;
           // ConfirmString = 'Confirm to delete!!';
            var IsDelete = confirm(ConfirmString);
        }
        if (IsDelete == true) {
            var x = document.getElementById('hdnTODdetails').value.split("^");
            document.getElementById('hdnTODdetails').value = '';
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != sEditedData) {
                        document.getElementById('hdnTODdetails').value += x[i] + "^";
                    }
                }
            }
            //                if (document.getElementById('btnAdd').value == 'Update') {
            //                    document.getElementById('hdnTODdetails').value += document.getElementById('txtFrom').value + "~" + document.getElementById('txtTo').value + "~" + document.getElementById('txtPercentage').value + "~" + document.getElementById('TxtInv').value + "^";
                document.getElementById('btnAdd').value = addDisplay;
            document.getElementById('txtFrom').value = '';
            document.getElementById('txtTo').value = '';
            document.getElementById('txtPercentage').value = '';
            document.getElementById('TxtInv').value = '';
            //                }
            GenerateTable();
        }
        else {
            return false;
        }
    }

    function ClearTOD() {
        document.getElementById('TODCode').value = '';
        document.getElementById('TODCode').disabled = false;
        document.getElementById('drpTODType').value = 'Rev';
        document.getElementById('drpTODType').disabled = false;
        document.getElementById('txtFrom').value = '';
        document.getElementById('txtTo').value = '';
        document.getElementById('txtPercentage').value = '';
        // document.getElementById('lblInv').value = '';
        document.getElementById('TxtInv').value = '';

    }

    function ClearText() {

        // document.getElementById('TODCode').value = '';
        document.getElementById('txtFrom').value = '';
        document.getElementById('txtTo').value = '';
        document.getElementById('txtPercentage').value = '';
        document.getElementById('txtDiscountName').value = '';
        document.getElementById('txtDiscountValue').value = '';
        document.getElementById('txtDiscountCode').value = '';
        document.getElementById('txtTaxName').value = '';
        document.getElementById('txtDiscountPercentage').value = '';
        document.getElementById('txtPercent').value = '';
        // document.getElementById('hdnTODiscount').value = '';
        document.getElementById('hdnTaxID').value = '';
        document.getElementById('hdnClientID').value = '';
        document.getElementById('HdnID').value = '';
        //document.getElementById('hdnTODdetails').value = '';
        document.getElementById('txtCouponCode').value = '';
        document.getElementById('txtCouponName').value = '';
        document.getElementById('ddlCoupon').value = '-1';
        document.getElementById('txtStartSerialNo').value = '';
        document.getElementById('txtEndSerialNo').value = '';
        document.getElementById('txtBatchNo').value = '';
        document.getElementById('txtOrderedUnits').value = '';
        document.getElementById('txtCouponValue').value = '';
        document.getElementById('txtExpiryDate').value = '';
        document.getElementById('hdnInvID').value = '';
        document.getElementById('hdnInvName').value = '';
        document.getElementById('hdnInvType').value = '';
        document.getElementById('TxtInv').value = '';
        document.getElementById('lblInvType').style.display = 'none';
        //document.getElementById('tdTodTable').style.display = 'none';
        // document.getElementById('lblInv').style.display = "none";
        // document.getElementById('TxtInv').style.display = "none";
        document.getElementById('TODCode').disabled = false;
        document.getElementById('drpTODType').value = 'Rev';
        document.getElementById('drpTODType').disabled = false;



    }

    function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which : event.keyCode
        if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
            return false;
        else {
            var len = document.getElementById("txtPercentage").value.length;
            var index = document.getElementById("txtPercentage").value.indexOf('.');

            if (index > 0 && charCode == 46) {
                return false;
            }
            if (index > 0) {
                var CharAfterdot = (len + 1) - index;
                if (CharAfterdot > 3) {
                    return false;
                }
            }

        }
        return true;
    }

    function isNumberKeytax(evt) {
        var charCode = (evt.which) ? evt.which : event.keyCode
        if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
            return false;
        else {
            var len = document.getElementById("txtPercent").value.length;
            var index = document.getElementById("txtPercent").value.indexOf('.');

            if (index > 0 && charCode == 46) {
                return false;
            }
            if (index > 0) {
                var CharAfterdot = (len + 1) - index;
                if (CharAfterdot > 3) {
                    return false;
                }
            }

        }
        return true;
    }


    function isNumberKeydis(evt) {

        var charCode = (evt.which) ? evt.which : event.keyCode
        if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
            return false;
        else {
            var len = document.getElementById("txtDiscountValue").value.length;
            var index = document.getElementById("txtDiscountValue").value.indexOf('.');

            if (index > 0 && charCode == 46) {
                return false;
            }
            if (index > 0) {
                var CharAfterdot = (len + 1) - index;
                if (CharAfterdot > 3) {
                    return false;
                }
            }

            }
            return true;
        }

        function isNumberKeyDP(evt) {

        var charCode = (evt.which) ? evt.which : event.keyCode
        if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) {

            return false;
        }
         else {
            var len = document.getElementById("txtDisValue").value.length;
            var index = document.getElementById("txtDisValue").value.indexOf('.');

                if (index > 0 && charCode == 46) {
                    return false;
                }
                if (index > 0) {
                    var CharAfterdot = (len + 1) - index;
                    if (CharAfterdot > 3) {
                        return false;
                    }
                }

            }
            return true;
        }
    </script>

<script type="text/javascript">
    function Temp() {
        $(function() {
            $("#txtExpiryDate").datepicker({
                changeMonth: true,
                changeYear: true,
                minDate: 0,
                yearRange: '2008:2030'
            })
        });
    }
</script>


</body>
</html>

