<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GeneralBillingItemsMaster.aspx.cs"
    Inherits="Admin_GeneralBillingItemsMaster" Debug="true" meta:resourcekey="PageResource1" %>
<%@ Register Src="../CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc10" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>
        <%--GeneralBillingItems Master--%><%=Resources.Admin_ClientDisplay.Admin_GeneralBillingItemsMaster_aspx_001%>
    </title>
    <%-- <link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>
  <script type="text/javascript" src="../Scripts/jquery-1.8.1.min.js"></script>

<script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>
    <script src="../Scripts/actb.js" type="text/javascript"></script>

    <script src="../Scripts/actbcommon.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">

        function pcheckitem() {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var UsrAlrtMsg = SListForAppMsg.Get("Admin_GeneralBillingItemsMaster_aspx_01") != null ? SListForAppMsg.Get("Admin_GeneralBillingItemsMaster_aspx_01") : "Provide the name ";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Admin_GeneralBillingItemsMaster_aspx_002") != null ? SListForAppMsg.Get("Admin_GeneralBillingItemsMaster_aspx_002") : "YES ";
            var UsrAlrtMsg2 = SListForAppMsg.Get("Admin_GeneralBillingItemsMaster_aspx_02") != null ? SListForAppMsg.Get("Admin_GeneralBillingItemsMaster_aspx_02") : "Item Already Added ";
	
            if (document.getElementById('txtItemName').value == '') {
                //var userMsg = SListForApplicationMessages.Get("Admin\\GeneralBillingItemsMaster.aspx_1");
                if (UsrAlrtMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert('Provide the name');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                document.getElementById('txtItemName').focus();
                return false;
            }
            var GBItem = $('#txtItemName').val();
            var GBitemID = $('#HdnitemID').val();
            var Flag = '';
            $('#grdResult tbody tr:not(:first)').each(function(i, n) {
                var $row = $(n);
                var pSelectedID = $row.find($('span[id$="lblGenBillID"]')).html();
                var OldGBItem = $row.find($('span[id$="lblGenBillName"]')).html();
                if (pSelectedID != GBitemID) {
                if (OldGBItem != undefined) {
                    if (GBItem.trim().toLowerCase() == OldGBItem.trim().toLowerCase()) {
                            //Flag = 'YES';
                            Flag = UsrAlrtMsg1;
                        return false;
                        }
                    }
                }

            });
            if (Flag == 'YES') {
                //alert("Item Already Added");

                ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                $('#txtItemName').val('');
                $("[id$=CheckBoxList1] input").removeAttr("checked");
                return false;
            }
        }

        function extractRow(rid, itemID, ItemName,IsDefaultBilling,IsDiscountable,IsTaxable,IsVariable) {
            var DispUpdate = SListForAppMsg.Get("Admin_GeneralBillingItemsMaster_aspx_03") != null ? SListForAppMsg.Get("Admin_GeneralBillingItemsMaster_aspx_03") : "Update";
            ////debugger; 
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
            document.getElementById('HdnitemID').value = itemID;
            //document.getElementById('HdnrateID').value = rateID;
            document.getElementById('txtItemName').value = ItemName;
            var checkboxCollection1 = document.getElementById('<%=CheckBoxList1.ClientID %>').getElementsByTagName('input');
            for (var i = 0; i < checkboxCollection1.length; i++) {
                if (i==0) {
                    checkboxCollection1[0].checked = IsDefaultBilling == 'Y' ? true : false;
                }
                if (i == 1) {
                    checkboxCollection1[1].checked = IsDiscountable == 'Y' ? true : false;
                }
                if (i == 2) {
                    checkboxCollection1[2].checked = IsTaxable == 'Y' ? true : false;
                }
                if (i == 3) {
                    checkboxCollection1[3].checked = IsVariable == 'Y' ? true : false;
                }
                
            }
            
//            document.getElementById('chkIsDefaultBilling').checked = IsDefaultBilling == 'Y' ? true : false;
//            document.getElementById('chkIsDiscountable').checked = IsDiscountable == 'Y' ? true : false;
//            document.getElementById('chkIsTaxable').checked = IsTaxable == 'Y' ? true : false;

//            if (IsDefaultBilling == 'Y') {
//                document.getElementById('chkIsDefaultBilling').checked == true;

//            }
//            else {
//                document.getElementById('chkIsDefaultBilling').checked == false;
//            }


//            if (IsDiscountable == 'Y') {
//                document.getElementById('chkIsDiscountable').checked == true;

//            }
//            else {
//                document.getElementById('chkIsDiscountable').checked == false;
//            }


//            if (IsTaxable == 'Y') {
//                document.getElementById('chkIsTaxable').checked == true;

//            }
//            else {
//                document.getElementById('chkIsTaxable').checked == false;
//            }
        
               
//                  document.getElementById('txtRate').value = Rate;
//                  document.getElementById('txtIPAmount').value = IPAmount
//                 document.getElementById('ddlRateName').value = rateID;
            document.getElementById('<%=btnsave.ClientID %>').value = DispUpdate;
            document.getElementById('hdnbtnsave').value = DispUpdate;

        }

        function validatenumberdot(evt) {
            var keyCode = 0;
            var cnt;
            if (evt) {
                keyCode = evt.keyCode || evt.which;
            }
            else
                keyCode = window.event.keyCode;


            var lst = cnt.indexOf('.');
            //alert(keyCode);
            if (lst == 1) {
                if (keyCode == 190)
                    return false;
                else {
                    if ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105) ||
                      (keyCode == 110) || (keyCode == 8) || (keyCode == 9) || (keyCode == 12) ||
                       (keyCode == 27) || (keyCode == 37)
                    || (keyCode == 39) || (keyCode == 46) || (keyCode == 190))
                        return true;
                    else
                        return false;

                }
            }
        }
   
    </script>

    <style type="text/css">
        .style7
        {
            width: 211px;
        }
        .style8
        {
            width: 96px;
        }
        .style11
        {
            width: 96px;
            height: 30px;
        }
        .style13
        {
            height: 30px;
        }
        .style14
        {
            width: 211px;
            height: 30px;
        }
        .style15
        {
            width: 273px;
            height: 30px;
        }
        .style16
        {
            height: 30px;
            width: 68px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        
                        <div id="divInv" runat="server">
                            <table class="dataheader2 defaultfontcolor w-100p searchPanel" id="casip">
                                <tr>
                                    <td class="style11">
                        <asp:Label ID="lblItemName" runat="server" Text="Item Name" meta:resourcekey="lblItemNameResource1"></asp:Label>
                                        
                                    </td>
                                    <td class="style14" style="empty-cells: hide">
                        <asp:TextBox ID="txtItemName" runat="server" onBlur="return ConverttoUpperCase(this.id);"
                            CssClass="Txtboxsmall" meta:resourcekey="txtItemNameResource1"></asp:TextBox>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </td>
                                    <td class="style15">
                        <asp:CheckBoxList ID="CheckBoxList1" runat="server" RepeatDirection="Horizontal"
                            Width="431px" meta:resourcekey="CheckBoxList1Resource1">
                           <%-- <asp:ListItem meta:resourcekey="ListItemResource1">IsDefaultBilling</asp:ListItem>
                            <asp:ListItem meta:resourcekey="ListItemResource2">IsDiscountable</asp:ListItem>
                            <asp:ListItem meta:resourcekey="ListItemResource3">IsTaxable</asp:ListItem>
                            <asp:ListItem meta:resourcekey="IsVariableListItemResource4">IsVariable</asp:ListItem>--%>
                        </asp:CheckBoxList>
                                    </td>
                                    <td class="style16">
                        <asp:Button ID="btnsave" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                            onmouseover="this.className='btn btnhov'" TabIndex="4" Text="Save" OnClientClick="javascript:return pcheckitem();"
                            OnClick="btnsave_Click1" Width="71px" meta:resourcekey="btnsaveResource1" />
                                    </td>
                                    <td class="style13">
                        <asp:Button ID="btnreset" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                            onmouseover="this.className='btn btnhov'" TabIndex="4" Text="RESET" OnClick="btnreset_Click"
                            Width="82px" meta:resourcekey="btnresetResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <%--<td>
                                        OPAmount
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtRate"  onkeypress="return ValidateOnlyNumeric(this);" 
                                            Width="65px" MaxLength="9" autocomplete="off"></asp:TextBox>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>--%>
                                    <td class="style8">
                                        <asp:HiddenField ID="HdnitemID" runat="server" />
                                    </td>
                                    <td class="style7">
                                        <asp:HiddenField ID="HdnrateID" runat="server" />
                                    </td>
                                    <td colspan="3">
                                    </td>
                                </tr>
                                <%-- <tr>
                                <td>
                                IPAmount
                                </td>
                                <td>
                                <asp:TextBox runat="server" ID="txtIpAmount"  onkeypress="return ValidateOnlyNumeric(this);" 
                                            Width="65px" MaxLength="9" autocomplete="off"></asp:TextBox>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                                </tr>--%>
                                <%--<tr>
                                    <td>
                                        Select Rate Type
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlRateName" runat="server"  Width="118px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>--%>
                                </table>
                            <input type="hidden" id="hdnbtnsave" runat="server" />
                            <%--<tr>
                                    <td colspan="2" align="center">
                                        <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                         onmouseout="this.className='btn'" Width="75px" OnClick="btnEdit_Click" />
                                    </td>
                                </tr>--%>
                            <table class="dataheader2 defaultfontcolor w-100p" id="Table1" >
                                <tr>
                                    <td class="a-center">
                        <asp:GridView ID="grdResult" runat="server" AllowPaging="True" CellSpacing="1" CellPadding="1"
                            AutoGenerateColumns="False" ForeColor="#333333" CssClass="mytable1 gridView w-100p"
                            OnPageIndexChanging="grdResult_PageIndexChanging" OnRowDataBound="grdResult_RowDataBound"
                            meta:resourcekey="grdResultResource1">
                                            
                                            <Columns>
                                               <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource1">
                                               <ItemStyle HorizontalAlign="Center" Width="2%" />
                                                    <ItemTemplate>
                                        <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="OrderSelect"
                                            meta:resourcekey="rdSelResource1" />
                                        <asp:Label ID="lblGenBillID" runat="server" Style="display: none;" Text='<%# Eval("GenBillID") %>'
                                            meta:resourcekey="lblGenBillIDResource1"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Item Name" meta:resourcekey="TemplateFieldResource2">
                                               <ItemStyle HorizontalAlign="Left" Width="40%" />
                                                    <ItemTemplate>
                                        <asp:Label ID="lblGenBillName" runat="server" Text='<%# Eval("GenBillName") %>' meta:resourcekey="lblGenBillNameResource1"></asp:Label>
                                                    </ItemTemplate>
                                                      
                                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DeFaultBilling" meta:resourcekey="TemplateFieldResource3">
                                                 <ItemStyle HorizontalAlign="Center" Width="2%" />
                                                    <ItemTemplate>
                                        <asp:Label ID="lblIsDefaultBilling" runat="server" Text='<%# Eval("IsDefaultBilling") %>'
                                            meta:resourcekey="lblIsDefaultBillingResource1"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Discountable" meta:resourcekey="TemplateFieldResource4">
                                                 <ItemStyle HorizontalAlign="Center" Width="2%" />
                                                    <ItemTemplate>
                                        <asp:Label ID="lblIsDiscountable" runat="server" Text='<%# Eval("IsDiscountable") %>'
                                                            meta:resourcekey="lblIsDiscountableResource1"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Taxable" meta:resourcekey="TemplateFieldResource5">
                                                    <ItemTemplate>
                                        <asp:Label ID="lblIsTaxable" runat="server" Text='<%# Eval("IsTaxable") %>'
                                            meta:resourcekey="lblIsTaxableResource1"></asp:Label>
                                                    </ItemTemplate>
                                               <ItemStyle HorizontalAlign="Center" Width="2%" />
                                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Variable" meta:resourcekey="VariableFieldResource5">
                                                    <ItemTemplate>
                                        <asp:Label ID="lblIsVariable" runat="server" Text='<%# Eval("IsVariable") %>'
                                            meta:resourcekey="lblIsVariableResource1"></asp:Label>
                                                    </ItemTemplate>
                                               <ItemStyle HorizontalAlign="Center" Width="2%" />
                                                </asp:TemplateField>
                                                  <%--<asp:BoundField DataField="GenBillName" HeaderText="ItemName" />
                                                  <asp:BoundField DataField="IsDefaultBilling" HeaderText="DeFaultBilling" />
                                                  <asp:BoundField DataField="IsDiscountable" HeaderText="ItemName" />
                                                  <asp:BoundField DataField="IsTaxable" HeaderText="ItemName" />--%>
                                                
                                                <%--<asp:BoundField DataField="Rate" HeaderText="OPAmount" />--%>
                                                <%--<asp:BoundField DataField="IPAmount" HeaderText="IPAmount" />--%>
                                                <%--<asp:BoundField DataField="RateName" HeaderText="Rate Name" />--%>
                                            </Columns>
                                            <RowStyle HorizontalAlign="Left" />
                                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                            <HeaderStyle CssClass="dataheader1" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
     <Attune:Attunefooter ID="Attunefooter" runat="server" />           
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>

