<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewPrescription.aspx.cs"
    Inherits="Corporate_ViewPrescription" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Prescription</title>

    <script src="../Scripts/Common.js" type="text/javascript"></script>
<script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function CallPrint() {
            var prtContent = document.getElementById('DivPrescription');
            var WinPrint =
                        window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>

    <style type="text/css">
        .style1
        {
            height: 189px;
        }
    </style>
</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
       
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
               
                <td width="85%" valign="top" class="tdspace">
                   
                    <div class="contentdata">
                      
                        <div id="DivPrescription">
                            <table width="100%" style="padding-left: 0px; font-size: 12px;font-weight: normal; color: #000000;" border="0" cellspacing="0"
                                cellpadding="0" align="center">
                                <tr>
                                    <td>
                                        <table width="100%">
                                            <tr>
                                                <td colspan="6" align="center" style="height: 35px; font-weight: bold;
                                                    text-decoration: underline;">
                                                 <asp:Label ID="lblpresdet" runat="server" Text="Prescription Details"  meta:resourcekey="lblpresdetResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr style="height: 15px;">
                                                <td style="width: 50px">
                                                    <asp:Label ID="lblName" runat="server" Text="Name" Font-Bold="True" 
                                                        meta:resourcekey="lblNameResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPname" runat="server" meta:resourcekey="lblPnameResource1"></asp:Label>
                                                </td>
                                                <td style="width: 100px">
                                                    <asp:Label ID="lblNumber" runat="server" Text="Patient No" Font-Bold="True" 
                                                        meta:resourcekey="lblNumberResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblPNumber" runat="server" 
                                                        meta:resourcekey="lblPNumberResource1"></asp:Label>
                                                </td>
                                                <td style="width: 100px">
                                                    <asp:Label runat="server" Text="Doctor Name" Font-Bold="True" 
                                                        meta:resourcekey="LabelResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblDoctorname" runat="server" 
                                                        meta:resourcekey="lblDoctornameResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr style="height: 15px;">
                                                <td>
                                                    <asp:Label runat="server" Text="Gender" Font-Bold="True" 
                                                        meta:resourcekey="LabelResource2"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblGender" runat="server" meta:resourcekey="lblGenderResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" Text="Prescription No" Font-Bold="True" 
                                                        meta:resourcekey="LabelResource3"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblVoucherno" runat="server" 
                                                        meta:resourcekey="lblVouchernoResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" Text="Prescription Date" Font-Bold="True" 
                                                        meta:resourcekey="LabelResource4"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblVoucherDtae" runat="server" 
                                                        meta:resourcekey="lblVoucherDtaeResource1"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr style="height: 15px;">
                                                <td>
                                                    <asp:Label runat="server" Text="Age" Font-Bold="True" 
                                                        meta:resourcekey="LabelResource5"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <%--<tr style="height: 15px;">
                                                <td align="left">
                                                    <asp:Label ID="lblAge" runat="server" Text="Age"></asp:Label>
                                                </td>
                                                <td style="text-align: left;">
                                                    :<asp:Label ID="lblAgeVal" runat="server"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="lblPrescriptionNo" Text="Prescription Number" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: left;">
                                                    :<asp:Label ID="lblPrescriptionNoVal" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr style="height: 15px;">
                                                <td align="left">
                                                    <asp:Label ID="lblDate" Text="Date" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: left;">
                                                    :<asp:Label ID="lblDateVal" runat="server"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="Label1" Text="Prescribed By" runat="server"></asp:Label>
                                                </td>
                                                <td style="text-align: left;">
                                                    :<asp:Label ID="lblPrescribedby" runat="server"></asp:Label>
                                                </td>
                                            </tr>--%>
                                        </table>
                                  
                                        <table width="100%">
                                               <tr>
                                                <td colspan="6">
                                                    <asp:Table CellPadding="2" CssClass="colorforcontentborder" CellSpacing="0" BorderWidth="0px"
                                                        runat="server" ID="billDetailLaser" Width="100%" 
                                                        meta:resourcekey="billDetailLaserResource1">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        &nbsp; &nbsp; &nbsp;
                        <table width="100%" cellpadding="5" cellspacing="0" border="0">
                            <tr style="display:none;">
                                <td align="center">
                                    <asp:Button ID="btnPrint" Text="Print" OnClientClick="CallPrint();return false;"
                                        Width="5%" runat="server" CssClass="btn" 
                                        meta:resourcekey="btnPrintResource1"  />
                                    <asp:Button ID="btnCancel" Text="Back" runat="server" CssClass="btn" 
                                        OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>
	<asp:HiddenField ID="hdnMessages" runat="server" />
    
    </form>
</body>
</html>
