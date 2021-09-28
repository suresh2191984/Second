<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CasualityMaster.aspx.cs"
    Inherits="Admin_CasualityMaster" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc10" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Casuality Master</title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css"/>
    
    <%-- <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>


	<script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

	

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function extractRow(src, srcID) {
            var eRow = src.parentElement.parentElement;
            var RI = eRow.rowIndex;
            var CasTbl = document.getElementById("grdResult");
            document.getElementById('HdnID').value = document.getElementById(srcID).value;
            document.getElementById('txtTstName').value = CasTbl.rows[RI].cells[1].innerHTML;
            document.getElementById('txtCC').value = CasTbl.rows[RI].cells[2].innerHTML;
            document.getElementById('txtCR').value = CasTbl.rows[RI].cells[3].innerHTML;
            document.getElementById('<%=btnSave.ClientID %>').value = "Update";

        }

        function resetTxtBx() {
            document.getElementById('txtTstName').value = "";
            document.getElementById('txtCC').value = "";
            document.getElementById('txtCR').value = "";
            document.getElementById('HdnID').value = "";
            document.getElementById('<%=btnSave.ClientID %>').value = "Save";
            return false;
        }

        //        function delRow(src) {

        //            var dRow = src.parentElement.parentElement;
        //            var RI = dRow.rowIndex;
        //            var i = 1;
        //            alert(RI);
        //            var CasTbl = document.getElementById("tblCasItems");
        //            var RMax = CasTbl.rows.length;
        //            CasTbl.deleteRow(RI);

        //            for (i = RI; i < RMax - 1; i++) {
                //                alert(CasTbl.rows[i].cells[0].innerHTML);
        //                CasTbl.rows[i].cells[0].innerHTML = i;
        //            }
        //        }

        //        function EditRow(i)
        //        {
        //            alert(i);
        //            return false;
        //        } 
      
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
        .style3
        {
            width: 102px;
            height: 30px;
        }
        .style4
        {
            height: 30px;
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
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
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
                        <div id="divInv" runat="server">
                            <table class="dataheader2 defaultfontcolor" width="100%" id="casip">
                                <tr>
                                    <td class="style2">
                                      <asp:Label ID="Rs_TestName" Text="Test Name" runat="server" 
                                            meta:resourcekey="Rs_TestNameResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtTstName" runat="server" 
                                            onBlur="return ConverttoUpperCase(this.id);" CssClass="Txtboxsmall" 
                                            meta:resourcekey="txtTstNameResource1" ></asp:TextBox>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style2">
                                       <asp:Label ID="Rs_CasualityCode" Text="Casuality Code" runat="server" 
                                            meta:resourcekey="Rs_CasualityCodeResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtCC" runat="server" 
                                            onBlur="return ConverttoUpperCase(this.id);" CssClass="Txtboxsmall" 
                                            meta:resourcekey="txtCCResource1"></asp:TextBox>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style3">
                                       <asp:Label ID="Rs_CasualityRate" Text="Casuality Rate" runat="server" 
                                            meta:resourcekey="Rs_CasualityRateResource1"></asp:Label>
                                    </td>
                                    <td class="style4">
                                        <asp:TextBox runat="server" ID="txtCR"  onkeypress="return ValidateOnlyNumeric(this);"  CssClass="Txtboxverysmall"
                                            MaxLength="9" autocomplete="off" meta:resourcekey="txtCRResource1"></asp:TextBox>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style1">
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
                                            meta:resourcekey="btnSaveResource1" /> 
                                            
                                        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" Width="75px" 
                                            OnClientClick=" return resetTxtBx()" meta:resourcekey="btnResetResource1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style2">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="20" align="center">
                                        <asp:GridView ID="grdResult" Width="100%" runat="server" AllowPaging="True" CellSpacing="1"
                                            CellPadding="1" AutoGenerateColumns="False" ForeColor="#333333" CssClass="mytable1"
                                            OnPageIndexChanging="grdResult_PageIndexChanging" 
                                            meta:resourcekey="grdResultResource1" >
                                            
                                            <Columns>
                                                <asp:TemplateField HeaderText="" ItemStyle-Width="5%" 
                                                    meta:resourcekey="TemplateFieldResource1"> 
                                                    
                                                    <ItemTemplate>
                                                        <input id="rdSel" name="radio" value='<%# Eval("CasualtyID") %>' onclick="extractRow(this, this.id)"
                                                            type="radio" />
                                                    </ItemTemplate>
                                                    <%--<ItemStyle Width="10%"></ItemStyle>--%><ItemStyle Width="5%"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="CasualtyID" HeaderText="CasualtyID" Visible="false" 
                                                    meta:resourcekey="BoundFieldResource1" />
                                                    
                                                <asp:BoundField DataField="TestName" HeaderText="TestName" 
                                                    meta:resourcekey="BoundFieldResource2" />
                                                  
                                                <asp:BoundField DataField="CasualtyCode" HeaderText="CasualtyCode" 
                                                    meta:resourcekey="BoundFieldResource3" /> 
                                                   
                                                <asp:BoundField DataField="CasualtyRate" HeaderText="Casualty Rate" 
                                                    meta:resourcekey="BoundFieldResource4" /> 
                                                    
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
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
