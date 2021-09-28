<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ApprovalDetails.aspx.cs"
    Inherits="Billing_ApprovalDetails" %>

<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Department.ascx" TagName="Department" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Amount Approval Details</title>
     <script language="javascript" type="text/javascript">
          function AlertMsg(Name) {
              if (Name != null) {
                  alert('Task Assigned to' + Name + '');
              }
              window.location.href('../Admin/Home.aspx');
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
                    <%-- <img alt="" src="<%=LogoPath%>"  class="logostyle" />--%>
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="AdminHeader" runat="server" />
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
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table cellpadding="2" cellspacing="1" width="100%">
                            <tr>
                                <td>
                                    <asp:Panel ID="pnlas" runat="server" GroupingText="Patient Details">
                                        <table width="100%" border="0">
                                            <tr align="left">
                                                <td>
                                                    <asp:Label ID="re_" Text="Patient No" runat="server" />
                                                </td>
                                                <td>
                                                    :
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPatientNo" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" />
                                                </td>
                                                <td>
                                                    :
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblName" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="re_age" Text="Patient Age" runat="server" />
                                                </td>
                                                <td>
                                                    :
                                                </td>
                                                <td>
                                                    <asp:Label ID="labAge" runat="server" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="re_sex" Text="Sex" runat="server" />
                                                </td>
                                                <td>
                                                    :
                                                </td>
                                                <td>
                                                    <asp:Label ID="lalSex" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Rs_BillNo" Text="Bill No " runat="server" />
                                                </td>
                                                <td>
                                                    :
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblInvoiceNo" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="re_BillDate" Text="Bill Date " runat="server" />
                                                </td>
                                                <td>
                                                    :
                                                </td>
                                                <td>
                                                    <asp:Label ID="lalBillDate" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="plnAmountDetais" runat="server" GroupingText="AmountDetais">
                                        <asp:Label runat="server" ID="lblWriteoffAmount" Text="Writeoff Approval Amount"></asp:Label>
                                        <asp:TextBox runat="server" ID="txtWriteoffAmt" CssClass="Txtboxsmall"></asp:TextBox>
                                        <asp:RadioButton ID="rdoApprove" runat="server" Text="Approve" GroupName="DueWriteOff" />
                                        <asp:RadioButton ID="rdoReject" runat="server" Text="Reject" GroupName="DueWriteOff" />
                                        <asp:Button ID="btnOk" runat="server" Text="OK" CssClass="btn" 
                                            onclick="btnOk_Click" />
                                    </asp:Panel>
                                </td>
                            </tr>
                            <asp:HiddenField runat="server" ID="hdnCreatedBy" />
                            <asp:HiddenField runat="server" ID="hdnVisitID" />
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
