<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillPrinting.aspx.cs" Inherits="Billing_BillPrinting"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/BillPrint.ascx" TagName="BillPrint" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/RakshithBillPrint.ascx" TagName="RakshithBillPrint"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../ANC/ANCCaseSheet.ascx" TagName="ANCCaseSheet" TagPrefix="uc7" %>
<%@ Register Src="../EMR/PrintExam.ascx" TagName="PrintExam" TagPrefix="uc10" %>
<%@ Register Src="../EMR/PrintHistory.ascx" TagName="PrintHistory" TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/EMROPCaseSheet.ascx" TagName="EMROPCasesheet" TagPrefix="uc12" %>
<%@ Register Src="../CommonControls/OPCaseSheet.ascx" TagName="OpCaseSheet" TagPrefix="uc13" %>

<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript">
        function PrintFunction() {       
            document.getElementById('btnPrint').style.visibility = "hidden";
            document.getElementById('btnHome').style.visibility = "hidden";
            window.print();
            document.getElementById('btnHome').style.visibility = "visible";
            document.getElementById('btnPrint').style.visibility = "visible";
        }    
        
       function PopUps() {
            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
            // ADDED THE LINE BELOW TO ORIGINAL EXAMPLE
            strFeatures = strFeatures + ",left=0,top=0";
            var chkheader;
            if(document.getElementById('chkheader').checked == true)
            {
                chkheader = 'Y';
            }
            else
            {
                chkheader = 'N';
            }
            // var strURL = "../Reception/PrintPage.aspx?vid=<%=Request.QueryString["vid"] %>&pagetype=CR&pid=<%=Request.QueryString["pid"] %>";
            var strURL = "../Reception/ViewPrintPage.aspx?vid=<%=Request.QueryString["vid"] %>&pagetype=CR&IsPopup=Y&CCPage=Y&pid=<%=Request.QueryString["pid"]%>"+"&chkheader="+chkheader+"";
            var WinPrint = window.open(strURL, "", strFeatures, true);
            WinPrint.print();
        }
      function  getval()
        {
        
        }
    </script>

   

    <script src="../Scripts/Common.js" type="text/javascript"></script>

</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc2:Header ID="Header2" runat="server" />
                <uc1:PatientHeader ID="Header3" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:LeftMenu ID="LeftMenu1" runat="server" />
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
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <uc11:PrintHistory ID="PrintHistory1" runat="server" Visible="False" />
                                    <uc10:PrintExam ID="PrintExam1" runat="server" Visible="False" />
                                    <asp:GridView ID="grdResult" Width="87%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                        ForeColor="#333333" CssClass="mytable1" Visible="False" meta:resourcekey="grdResultResource1">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <Columns>
                                            <asp:TemplateField ItemStyle-Width="2%" HeaderText="SNO" HeaderStyle-HorizontalAlign="Left"
                                                meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbl_SequenceNO" runat="server" Text='<%# Eval("SequenceNO") %>' Font-Size="Small"
                                                        meta:resourcekey="lbl_SequenceNOResource1"></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                <ItemStyle Width="2%"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Recommendation" meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbl_details" runat="server" Text='<%# Eval("ResultValues") %>' Font-Size="Small"
                                                        meta:resourcekey="lbl_detailsResource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    
                                   <uc13:OPcaseSheet ID ="opCaseSheet" runat ="Server" />
                                    <uc12:EMROPCasesheet ID ="emrcasesheet" runat ="server" />
                                    <uc7:ANCCaseSheet ID="ancCaseSheet" runat="server" />
                                    <asp:Panel ID="pnlBillPrint" runat="server" 
                                        meta:resourcekey="pnlBillPrintResource1"></asp:Panel>
<%--                                    <uc6:BillPrint ID="billPrint" runat="server" />
                                    <uc8:RakshithBillPrint ID="rakshithbillPrint" runat="server" />--%>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btnPrint" Text="Print" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="PopUps()" runat="server" meta:resourcekey="btnPrintResource1" />
                                     <asp:CheckBox ID="chkheader" runat="server" Text="With Header"  style="display:none;"
                                        meta:resourcekey="chkheaderResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer" runat="server" />
    </div>
    </form>
</body>
</html>
