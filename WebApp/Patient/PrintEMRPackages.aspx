<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintEMRPackages.aspx.cs"
    Inherits="Patient_PrintEMRPackages" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../EMR/PrintExam.ascx" TagName="PrintExam" TagPrefix="uc5" %>
<%@ Register Src="../EMR/PrintHistory.ascx" TagName="PrintHistory" TagPrefix="uc6" %>
<%@ Register Src="../EMR/PrintDiagnostics.ascx" TagName="PrintDiagnostics" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <script language="javascript" type="text/javascript">
        function popupprint() {
            var prtContent = document.getElementById('PrintPackage');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>

</head>
<body >
    <form id="form1" runat="server"><asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index:2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>"  class="logostyle" />
                </div>
            </div>
                <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc3:PatientHeader ID="patientHeader" runat="server" />
            </div>
                    <div style="float: right;"  class="Rightheader"></div>
        </div>
           <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
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
                    
                        <table style="width: 100%;">
                            <tr>
                                <td align="right">
                                    <asp:Button ID="btnPrint1" runat="server" Text="Print" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="return popupprint();" 
                                        meta:resourcekey="btnPrint1Resource1" />
                                </td>
                            </tr>
                        </table>
                        <div id="PrintPackage" style="height: 550px; overflow: auto">
                            <uc6:PrintHistory ID="PrintHistory1" runat="server" />
                            <uc5:PrintExam ID="PrintExam1" runat="server" />
                            <uc7:PrintDiagnostics ID="PrintDiagnostics1" runat="server" />
                            <div id="divVitalsSHN" runat="server">
                                <p class='pagestart'>
                                </p>
                            </div>
                            <br />
                            <asp:GridView ID="grdResult" Width="87%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                ForeColor="#333333" CssClass="mytable1" 
                                meta:resourcekey="grdResultResource1">
                                <HeaderStyle CssClass="dataheader1" />
                                <Columns>
                                    <asp:TemplateField ItemStyle-Width="2%" HeaderText="SNO" 
                                        HeaderStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_SequenceNO" runat="server" Text='<%# Eval("SequenceNO") %>' 
                                                Font-Size="Small" meta:resourcekey="lbl_SequenceNOResource1"></asp:Label>
                                        </ItemTemplate>

<HeaderStyle HorizontalAlign="Left"></HeaderStyle>

<ItemStyle Width="2%"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Recommendation" 
                                        meta:resourcekey="TemplateFieldResource2">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_details" runat="server" Text='<%# Eval("ResultValues") %>' 
                                                Font-Size="Small" meta:resourcekey="lbl_detailsResource1"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                        <table style="width: 95%;">
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="return popupprint();" 
                                        meta:resourcekey="btnPrintResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
               </td>
            </tr>
        </table>
        <uc2:Footer ID="ucFooter" runat="server" />
    </div>
    </form>
</body>
</html>
