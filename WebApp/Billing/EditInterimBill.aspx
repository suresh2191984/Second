<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditInterimBill.aspx.cs"
    Inherits="Billing_EditInterimBill" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Edit Due Chart</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>
    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script>
        function Print_Btn_Click() {
            var sPage = document.getElementById("hdnFID").value
            window.open(sPage, '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            return false;
        }

        function CalcuteItemSum(ID1, ID2, ID3) {
            //            alert('a');

            document.getElementById(ID3).value = document.getElementById(ID1).value * document.getElementById(ID2).value;
            ChkTotal();
        }
        function ChkTotal() {
            var Ids = document.getElementById('txtHidden').value;
            var LenghtID = Ids.split('~');
            var Total = 0;
            for (var i = 0; i < LenghtID.length; i++) {
                if (LenghtID[i] != '') {
                    Total = parseFloat(Total) + parseFloat(document.getElementById(LenghtID[i]).value);
                }
            }
            document.getElementById('lblTotal').innerHTML = Total;
        }

    </script>

</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server" defaultbutton="btnSave">
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
                        <table width="100%" align="center" border="0" id="tblBillPrint" runat="server">
                            <tr>
                                <td>
                                    <table width="100%" border="0" cellspacing="0" style="font-family: Verdana; font-size: 10px;"
                                        cellpadding="0" align="center" id="tbl1" runat="server">
                                        <tr>
                                            <td colspan="6" align="center">
                                                <input type="hidden" runat="server" id="txtHidden" />
                                                <asp:Image ID="imgBillLogo" runat="server" Visible="False" 
                                                    meta:resourcekey="imgBillLogoResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" align="center">
                                                <label style="font-family: Arial; font-size: medium;" id="lblHospitalName" runat="server">
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" align="center"> 
                                              <asp:Label ID="Rs_EditPatientInterimDues" Text="Edit Patient Interim Dues" 
                                                    runat="server" meta:resourcekey="Rs_EditPatientInterimDuesResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6">
                                                &nbsp;&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6">
                                                <table border="0" cellspacing="0" width="100%" cellpadding="0" style="font-family: Verdana;
                                                    font-size: 10px;">
                                                    <tr>
                                                        <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                                            <label>
                                                               <asp:Label ID="Rs_PatientNumber" Text="Patient Number :" runat="server" 
                                                                meta:resourcekey="Rs_PatientNumberResource1"></asp:Label></label>
                                                        </td>
                                                        <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                                            <span style="width: 23%">
                                                                <asp:Label ID="lblPNumber" runat="server" 
                                                                meta:resourcekey="lblPNumberResource1"></asp:Label>
                                                            </span>
                                                        </td>
                                                        <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                                            &nbsp;
                                                        </td>
                                                        <td width="83%" align="right" nowrap="nowrap">
                                                        </td>
                                                        <td width="83%" align="left" nowrap="nowrap">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                                            <label>
                                                               <asp:Label ID="Rs_PatientName" Text="Patient Name :" runat="server" 
                                                                meta:resourcekey="Rs_PatientNameResource1"></asp:Label></label>
                                                        </td>
                                                        <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                                            <span style="width: 23%">
                                                                <asp:Label ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                                                            </span>
                                                        </td>
                                                        <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                                            &nbsp;
                                                        </td>
                                                        <td width="83%" align="right" nowrap="nowrap">
                                                            <asp:Label ID="Rs_InterimReferenceNumber" Text="Interim Reference Number :" 
                                                                runat="server" meta:resourcekey="Rs_InterimReferenceNumberResource1"></asp:Label>
                                                        </td>
                                                        <td width="83%" align="left" nowrap="nowrap">
                                                            <asp:Label ID="lblReferenceNo" runat="server" 
                                                                meta:resourcekey="lblReferenceNoResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                                            <label>
                                                               <asp:Label ID="Rs_Age" Text="Age:"  runat="server" 
                                                                meta:resourcekey="Rs_AgeResource1"></asp:Label>
                                                               </label>
                                                        </td>
                                                        <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                                            <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                                        </td>
                                                        <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                                            &nbsp;
                                                        </td>
                                                        <td align="right" colspan="2">
                                                        </td>
                                                        <td>
                                                            <%--  <asp:Label ID="lblPatientNumber" runat="server"></asp:Label>--%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                                            <label>
                                                                <asp:Label ID="Rs_MobileNumber" Text="Mobile Number :" runat="server" 
                                                                meta:resourcekey="Rs_MobileNumberResource1"></asp:Label></label>
                                                        </td>
                                                        <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                                            <asp:Label ID="lblMobileNumber" runat="server" 
                                                                meta:resourcekey="lblMobileNumberResource1"></asp:Label>
                                                        </td>
                                                        <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                                            &nbsp;
                                                        </td>
                                                        <td width="17%" style="width: 23%" align="right">
                                                            <asp:Label ID="Rs_RaisedDate" Text="Raised Date :" runat="server" 
                                                                meta:resourcekey="Rs_RaisedDateResource1"></asp:Label>
                                                        </td>
                                                        <td width="17%" style="width: 23%" align="left" nowrap="nowrap">
                                                            <asp:Label ID="lblRaisedDate" runat="server" 
                                                                meta:resourcekey="lblRaisedDateResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="5">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="Left" colspan="5">
                                                            <b><asp:Label ID="Rs_RequestDetails" Text="RequestDetails:" runat="server" 
                                                                meta:resourcekey="Rs_RequestDetailsResource1"></asp:Label></b>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%-- <tr>
                                            
                                            <td colspan="5" style="text-decoration: none;" align="right">
                                                Request&nbsp;Details:
                                                <br />
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;
                                            </td>
                                        </tr>--%>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td colspan="5">
                                                &nbsp;&nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="7" class="style3">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="7">
                                                <div id="dvDetails" runat="server">
                                                    <asp:GridView ID="gvIndents" CellPadding="3" runat="server" AutoGenerateColumns="False"
                                                        GridLines="None" Width="100%" DataKeyNames="DetailsID" 
                                                        Font-Names="Verdana" Font-Size="10px"
                                                        OnRowDataBound="gvIndents_RowDataBound" 
                                                        meta:resourcekey="gvIndentsResource1">
                                                        <HeaderStyle CssClass="dataheader1" />
                                                        <PagerStyle CssClass="dataheader1" />
                                                        <Columns>
                                                            <asp:BoundField HeaderText="Status" DataField="Status" Visible="false" 
                                                                meta:resourcekey="BoundFieldResource1">
                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:TemplateField HeaderText="Description" 
                                                                meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="chkID" runat="server" Style="text-align: left;" 
                                                                        Text='<%# Eval("Description") %>' meta:resourcekey="chkIDResource1" />
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Left" />
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Quantity" 
                                                                meta:resourcekey="TemplateFieldResource2">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtQuantity" runat="server" Style="text-align: right;" MaxLength="10"
                                                                        Text='<%# Eval("unit") %>'  onkeypress="return ValidateOnlyNumeric(this);"  
                                                                        Width="60px" meta:resourcekey="txtQuantityResource1"></asp:TextBox>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="UnitPrice" 
                                                                meta:resourcekey="TemplateFieldResource3">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtunitPrice" runat="server" Style="text-align: right;" MaxLength="10"
                                                                        Text='<%# Eval("AMOUNT") %>'  onkeypress="return ValidateOnlyNumeric(this);"  
                                                                        Width="60px" meta:resourcekey="txtunitPriceResource1"></asp:TextBox>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" />
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Amount" 
                                                                meta:resourcekey="TemplateFieldResource4">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtAmount" runat="server" Style="text-align: right;" ReadOnly="True"
                                                                        Text='<%# NumberConvert(Eval("unit"),Eval("AMOUNT")) %>' Width="60px" 
                                                                        meta:resourcekey="txtAmountResource1"></asp:TextBox>
                                                                    <asp:HiddenField ID="hdnAmount" runat="server" />
                                                                    <headerstyle horizontalalign="Center" />
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Right" />
                                                                <HeaderStyle HorizontalAlign="Right" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                                <div id="dvAdvance" runat="server" align="center">
                                                    &nbsp;</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style2" colspan="6">
                                                &nbsp;&nbsp;
                                            </td>
                                            <td class="style2">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style2" colspan="6" align="right">
                                              <asp:Label ID="Rs_Total" Text=" Total :" runat="server" 
                                                    meta:resourcekey="Rs_TotalResource1"></asp:Label>
                                              
                                                <asp:Label ID="lblTotal" runat="server" meta:resourcekey="lblTotalResource1" />
                                                /-
                                            </td>
                                            <td class="style2">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style2" colspan="6" style="display: none;" align="left">
                                                <asp:Label ID="Rs_TotalAmount" Text="Total Amount :" runat="server" 
                                                    meta:resourcekey="Rs_TotalAmountResource1"></asp:Label>
                                                <asp:Label ID="LblAmount" runat="server" 
                                                    meta:resourcekey="LblAmountResource1" />
                                            </td>
                                            <td class="style2">
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnSave_Click" Height="26px" 
                                        meta:resourcekey="btnSaveResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <input type="hidden" id="hdnFID" runat="server" />
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    
	

	<asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
