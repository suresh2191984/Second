<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DiscountReason.aspx.cs" Inherits="Admin_DiscountReason" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Discount Reason  Master</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css"/>
    
    <%-- <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

<script src="../Scripts/MessageHandler.js" type="text/javascript"></script>


    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function extractRow(src, cID) {
            var eRow = src.parentElement.parentElement;
            var RI = eRow.rowIndex;
            var CasTbl = document.getElementById("grdResult");
            document.getElementById('HdnID').value = cID;
            document.getElementById('txtDiscountCode').value = CasTbl.rows[RI].cells[1].innerHTML;
            document.getElementById('txtDiscountReason').value = CasTbl.rows[RI].cells[2].innerHTML;
//            document.getElementById('txtDiscountPercentage').value = CasTbl.rows[RI].cells[3].innerHTML;
            document.getElementById('<%=btnSave.ClientID %>').value = "Update";
            //            document.getElementById('divInv').style.display = 'block';

        }

     

        function ChkDiscountName() {            
            var TblDisc = document.getElementById("grdResult");
            if (TblDisc == null) {
                var grdlength = 0;
            }
            else {
                var grdlength = TblDisc.rows.length;
            }
            var txtdisCode = document.getElementById('txtDiscountCode').value;
            var btnvalue = document.getElementById('btnSave').value;
            //alert(btnvalue);

            if (document.getElementById('txtDiscountCode').value == "") {
                var userMsg = SListForApplicationMessages.Get("Admin\\DiscountReason.aspx_1");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Enter discount code');
                   return false;
                }
               
               // return false;
            }
            if (document.getElementById('txtDiscountReason').value == "") {
                var userMsg = SListForApplicationMessages.Get("Admin\\DiscountReason.aspx_2");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('Enter Discount Reason');
                    return false;
                }

                //return false;
            }
//            if (document.getElementById('txtDiscountPercentage').value == "") {
//                alert('Enter DiscountPercentage');
//                return false;
//            }
            if (btnvalue == 'Save') {
                for (var i = 1; i <= grdlength - 1; i++) {
                    var dis = TblDisc.rows[i].cells[0].childNodes[0].getAttribute('DiscID');
                    var DisName = TblDisc.rows[i].cells[1].innerHTML;
                    if (DisName == txtdisCode) {
                        var userMsg = SListForApplicationMessages.Get("Admin\\DiscountReason.aspx_3");
                        if (userMsg != null) {
                            alert(userMsg);
                            return false;
                        }
                        else {
                            alert('Reason Code already exists');
                            return false;
                        }
                      
                       // return false;
                    }             
              }

            }
        }

        function chkdelete() {
            var disid = document.getElementById('HdnID').value;
            if (disid == "") {
                var userMsg = SListForApplicationMessages.Get("Admin\\DiscountReason.aspx_4");
                if (userMsg != null) {
                    alert(userMsg);
                    return false;
                }
                else {
                    alert('select one record');
                    return false;
                }
                
                return false;
            }
            //return true;
        }


     
      
    </script>

    <style type="text/css">
        .style1
        {
            width: 102px;
            height: 8px;
        }
        .style2
        {
            width: 102px;
        }
    </style>
</head>
<body>
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
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc7:DocHeader ID="docHeader" runat="server" />
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
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                       
                        <div id="divInv" runat="server" >
                            <table class="dataheader2 defaultfontcolor" width="100%" id="casip">
                                <tr>
                                    <td>
                                        <asp:Label ID="DiscountCode" Text="Reason Code" runat="server" 
                                            meta:resourcekey="DiscountCodeResource1" ></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDiscountCode" runat="server" 
                                            onBlur="return ConverttoUpperCase(this.id);" CssClass="Txtboxsmall"
                                            meta:resourcekey="txtDiscountCodeResource1"></asp:TextBox>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="DiscountReason" Text="Reason Description" runat="server" 
                                            meta:resourcekey="DiscountReasonResource1" ></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDiscountReason" runat="server" 
                                            onBlur="return ConverttoUpperCase(this.id);" CssClass="Txtboxsmall"
                                            meta:resourcekey="txtDiscountReasonResource1"></asp:TextBox>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" /
                                    </td>
                                </tr>
                              
                                </tr>
                                <tr>
                                    <td>
                                        <asp:HiddenField ID="HdnID" runat="server" />
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td colspan="2" align="center">
                                        <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                         onmouseout="this.className='btn'" Width="75px" OnClick="btnEdit_Click" />
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td colspan="2" align="center">
                                        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" Width="75px" OnClick="btnSave_Click" 
                                            OnClientClick="return ChkDiscountName()" meta:resourcekey="btnSaveResource1"
                                           />
                                        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" Width="75px" 
                                            OnClientClick=" return resetTxtBx()" meta:resourcekey="btnResetResource1"
                                           />
                                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" Width="75px" OnClientClick="return chkdelete()"
                                            OnClick="btnDelete_Click" meta:resourcekey="btnDeleteResource1"  />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style2">
                                    </td>
                                </tr>
                                <tr>
                                
                                    <td align="center">
                                        <asp:GridView ID="grdResult" Width="100%" runat="server" CellSpacing="1" CellPadding="1"
                                            AutoGenerateColumns="False" ForeColor="#333333" CssClass="mytable1" 
                                            meta:resourcekey="grdResultResource1">
                                            <Columns>
                                                <asp:TemplateField HeaderText="" ItemStyle-Width="5%" meta:resourcekey="TemplateFieldResource1">
                                                    <ItemTemplate>
                                                        <input id="rdSel" name="radio" onclick='extractRow(this,&#039;<%# Eval("ReasonId") %>&#039;)'
                                                            type="radio" discid='<%# Eval("ReasonId") %>' />
                                                    </ItemTemplate>
                                                    <%--<ItemStyle Width="10%"></ItemStyle>--%><ItemStyle Width="5%"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ReasonId" HeaderText="ReasonID" 
                                                    Visible="False" meta:resourcekey="BoundFieldResource1"/>
                                                <asp:BoundField DataField="ReasonCode" HeaderText="Reason Code" 
                                                    meta:resourcekey="BoundFieldResource2" />
                                                <asp:BoundField DataField="ReasonDesc" HeaderText="Reason Description" 
                                                    meta:resourcekey="BoundFieldResource3" />
                                                <%--<asp:BoundField DataField="DiscountPercentage" HeaderText="Discount Percentage" meta:resourcekey="BoundFieldResource4" />--%>
                                            </Columns>
                                            <RowStyle HorizontalAlign="Left" />
                                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                            <HeaderStyle CssClass="dataheader1" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                        </div>
                      
                 
        <asp:HiddenField ID="hdnDiscountResonID" runat="server" />
     
        <uc5:Footer ID="Footer1" runat="server" />
	<asp:HiddenField ID="hdnMessages" runat="server" />
        
        </form> 
    
</body>
</html>
