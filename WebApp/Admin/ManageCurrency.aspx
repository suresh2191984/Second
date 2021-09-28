<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageCurrency.aspx.cs" Inherits="Admin_ManageCurrency"
    meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Manage Currency</title>
    
    <script language="javascript" type="text/javascript">
        function BaseCurrencyValidation() {


            var objvarAlert = SListForAppMsg.Get("Admin_ManageCurrency_aspx_04") == null ? "Alert" : SListForAppMsg.Get("Admin_ManageCurrency_aspx_04");
            var btnoktext = SListForAppMsg.Get("Admin_ManageCurrency_aspx_02") == null ? "OK" : SListForAppMsg.Get("Admin_ManageCurrency_aspx_02");
            var btnclosetext = SListForAppMsg.Get("Admin_ManageCurrency_aspx_03") == null ? "Close" : SListForAppMsg.Get("Admin_ManageCurrency_aspx_03");
        
        
        
            var userMsg = SListForApplicationMessages.Get("Admin\\ManageCurrency.aspx_1");
            if (userMsg != null) {
                // andrews return confirm(userMsg);
                return ConfirmWindow(userMsg, AlertType, btnoktext, btnclosetext)
              
                //return false;
            }
            else {
                var objvar16 = SListForAppMsg.Get("Admin_ManageCurrency_aspx_01") == null ? "Adding/Changing base currency would change other currency conversion rates to Zero. Do you wish to proceed?" : SListForAppMsg.Get("Admin_ManageCurrency_aspx_01");

                return confirm(objvar16);
                //   return false;
            }
//            var txtCancel = confirm('Adding/Changing base currency would change other currency conversion rates to Zero. Do you wish to proceed?');
//            return txtCancel;
        }
        function setOnlineRate(chkID, hdn1ID, txtID, hdn2ID) {

            if (chkID.checked) {
                txtID.value = hdn2ID.value;
            }
            else {
                txtID.value = hdn1ID.value;
            }
        }


        function fnGetOutputFromServer(strOutput) {
            document.getElementById('grdCurrencyDiv').innerHTML = strOutput;
        }
        function fnSearchGrid() {
            // //debugger; 
            var param1 = document.getElementById('txtSearchCurrName').value;
            var inputarg = param1;
            fnCallServerMethod(inputarg, '');
        }


        function DisableButtons() 
        {
            document.getElementById("<%=btnAddCurrency.ClientID %>").disabled = true;
        }
        window.onbeforeunload = DisableButtons;
       

    </script>

</head>
<body oncontextmenu="return true;">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       <%-- <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />--%>
                        <asp:Panel ID="pnlSearch" CssClass="dataheader2 w-100p bg-row b-grey" runat="server"  meta:resourcekey="pnlSearchResource1">
                            <table class="w-100p">
                                <tr>
                                    <td class="a-center font12 h-20 w-30p" style="font-weight: normal; color: #000;">
                                        <asp:Label ID="Rs_SelectBaseCurrency" Text="Select Base Currency" runat="server"
                                            meta:resourcekey="Rs_SelectBaseCurrencyResource1"></asp:Label>
                                    </td>
                                    <td class="font12 h-20 w-26p" style="font-weight: normal; color: #000;">
                                        <asp:DropDownList ID="ddlBaseCurrency" ToolTip="Select Base Currency" runat="server" 
                                            CssClass="ddllarge" meta:resourcekey="ddlBaseCurrencyResource1">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnBaseCurrency" Text=" Save Base Currency " runat="server" ToolTip="Click here to Save Base Currency"
                                            CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                            OnClientClick="javascript:return BaseCurrencyValidation();" OnClick="btnBaseCurrency_Click"
                                            meta:resourcekey="btnBaseCurrencyResource1" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <table class="w-100p searchPanel">
                            <tr>
                                <td style="color: #000;" class="a-left h-23">
                                    <div id="ACX2plus2" style="display: block;">
                                        <img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top pointer"
                                            onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses5',1);" />
                                        <span class="dataheader1txt pointer" style="color: #000;" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses5',1);">
                                            &nbsp;<b><asp:Label ID="Rs_AddOtherCurrency" Text="Add Other Currency" runat="server"
                                                meta:resourcekey="Rs_AddOtherCurrencyResource1"></asp:Label></b></span>
                                    </div>
                                    <div id="ACX2minus2" style="display: none;">
                                        <img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses5',0);" />
                                        <span class="dataheader1txt pointer" style="color: #000;" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses5',0);">
                                            <b><asp:Label ID="Rs_AddOtherCurrency1" Text="Add Other Currency" runat="server" meta:resourcekey="Rs_AddOtherCurrency1Resource1"></asp:Label></b></span>
                                    </div>
                                </td>
                            </tr>
                            <tr class="tablerow" id="ACX2responses5" style="display: none;">
                                <td>
                                    <asp:Panel ID="Panel1" CssClass="dataheader2 w-80p" BorderWidth="1px" runat="server" 
                                        meta:resourcekey="Panel1Resource1">
                                        <table class="w-100p bg-row">
                                            <tr>
                                                <td class="a-center font12 h-20 w-9p" style="font-weight: normal; color: #000;">
                                                    <asp:Label ID="Rs_SearchCurrency" Text="Search Currency" runat="server" meta:resourcekey="Rs_SearchCurrencyResource1"></asp:Label>
                                                </td>
                                                <td style="font-weight: normal;color: #000;" class="w-26p h-20 font12">
                                                    <asp:TextBox ID="txtSearchCurrName" CssClass="Txtboxlarge" runat="server" OnKeyUp="javascript:fnSearchGrid();"
                                                        meta:resourcekey="txtSearchCurrNameResource1"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <br />
                                    <div id="grdCurrencyDiv" runat="server" style="overflow: auto; border: 2px; border-color: #fff;
                                        height: 200px;" class="ancCSviolet">
                                        <asp:GridView ID="grdCurrency" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                            CssClass="mytable1 gridView w-100p" ForeColor="#333333" DataKeyNames="CurrencyID" Font-Bold="False"
                                            OnRowDataBound="grdCurrency_RowDataBound" meta:resourcekey="grdCurrencyResource1">
                                            <HeaderStyle CssClass="dataheader1" />
                                            <HeaderStyle CssClass="colorforcontent" ForeColor="White" />
                                            <RowStyle ForeColor="#000066" />
                                            <Columns>
                                                <asp:BoundField HeaderText="Currency ID" DataField="CurrencyID" meta:resourcekey="BoundFieldResource1">
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkBox" ToolTip="Select to Add Currency" runat="server" meta:resourcekey="chkBoxResource1" />
                                                        <asp:HiddenField ID="hdnRate3" runat="server" Value='<%# Eval("CurrencyID") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderText="Currency Name" DataField="CurrencyName" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                </asp:BoundField>
                                                <%--  <asp:TemplateField HeaderText="Is Base Currency?">
                                             <ItemTemplate>
                                             <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select, if it is Base Currency" GroupName="BaseCurrencySelect" />
                                             </ItemTemplate>
                                             </asp:TemplateField>--%>
                                            </Columns>
                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                        </asp:GridView>
                                    </div>
                                    <br />
                                    <asp:Button ID="btnAddCurrency" Text=" Add Currency " runat="server" ToolTip="Click here to Add Other Currency"
                                        CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                        OnClick="btnAddCurrency_Click" meta:resourcekey="btnAddCurrencyResource1" />
                                </td>
                            </tr>
                            <tr id="noteTR" runat="server">
                                <td>
                                    <br />
                                    <asp:Label ID="Rs_Info" Text="Note: If there is no Internet Connection, the Online Rates of Currencies will be
                                    the Existing Rate and it will be displayed in" runat="server" meta:resourcekey="Rs_InfoResource1"></asp:Label>
                                    <b style='color: Red;'>
                                        <asp:Label ID="Rs_RedColor" Text="Red Color" runat="server" meta:resourcekey="Rs_RedColorResource1"></asp:Label></b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <br />
                                    <div>
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <asp:UpdateProgress ID="Progressbar" runat="server">
                                                    <ProgressTemplate>
                                                        <asp:Image ID="imgProgressbar2" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbar2Resource1" />
                                                        <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                                <asp:GridView ID="grdCurrencyConversion" runat="server" AutoGenerateColumns="False"
                                                    CellPadding="4" CssClass="mytable1 gridView" ForeColor="#333333" DataKeyNames="CurrencyID"
                                                    Font-Bold="False" OnRowDataBound="grdCurrencyConversion_RowDataBound" meta:resourcekey="grdCurrencyConversionResource1">
                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" ForeColor="White" />
                                                    <RowStyle ForeColor="#000066" />
                                                    <Columns>
                                                        <asp:BoundField HeaderText="Currency ID" DataField="CurrencyID" meta:resourcekey="BoundFieldResource3">
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                        </asp:BoundField>
                                                        <asp:BoundField HeaderText="Currency Code" DataField="CurrencyCode" meta:resourcekey="BoundFieldResource4">
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                        </asp:BoundField>
                                                        <asp:BoundField HeaderText="Currency Name" DataField="CurrencyName" meta:resourcekey="BoundFieldResource5">
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="Conversion Rate" meta:resourcekey="TemplateFieldResource2">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtConversionRate" Style="text-align: right;" runat="server" MaxLength="10"
                                                                    ToolTip="Enter Conversion Rate" Text='<%# Eval("ConversionRate") %>' Width="60px"
                                                                     onkeypress="return ValidateOnlyNumeric(this);"  meta:resourcekey="txtConversionRateResource1"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Online Rate" meta:resourcekey="TemplateFieldResource3">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblOnlineRate" runat="server" meta:resourcekey="lblOnlineRateResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderTemplate>
                                                                <asp:Label ID="Rs_OnlineRate" Text="Online Rate" runat="server" meta:resourcekey="Rs_OnlineRateResource1"></asp:Label>
                                                                <asp:ImageButton ImageUrl="~/Images/refresh1.png" OnClick="refreshImg_Click" Style="height: 15px;"
                                                                    ID="refreshImg" ToolTip="Refresh Online Rate" runat="server" meta:resourcekey="refreshImgResource1" />
                                                            </HeaderTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Use Online Rate" meta:resourcekey="TemplateFieldResource4">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkBoxRate" ToolTip="Select to use Online Rate" runat="server"
                                                                    meta:resourcekey="chkBoxRateResource1" />
                                                                <asp:HiddenField ID="hdnRate1" runat="server" Value='<%# Eval("ConversionRate") %>' />
                                                                <asp:HiddenField ID="hdnRate2" runat="server" />
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Center" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Remove Currency" meta:resourcekey="TemplateFieldResource5">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkBoxCurrency" ToolTip="Select to Remove Currency" runat="server"
                                                                    meta:resourcekey="chkBoxCurrencyResource1" />
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Center" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                </asp:GridView>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <br />
                                    <asp:Button ID="btnSaveRate" Text=" Save Changes " runat="server" ToolTip="Click here to Save Rate Conversion Changes"
                                        CssClass="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" OnClientClick="DisableButtons()"
                                        OnClick="btnSaveRate_Click" meta:resourcekey="btnSaveRateResource1" />
                                </td>
                            </tr>
                        </table>
                        <asp:HiddenField ID="hdnBaseCurrencyCode" runat="server" />
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />        
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
