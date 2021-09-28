<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ConsentFormPrint.aspx.cs"
    Inherits="Reception_ConsentFormPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/PatientSearch.ascx" TagName="PatientSearch" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/FeesEntry.ascx" TagName="Billing" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/OPCaseSheet.ascx" TagName="OPCaseSheet" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>View Case Sheet</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript" src="jquery-1.4.2.min.js"></script>


<style type="text/css">
#contactinfo label
{
    float: left;
    width: 10em;
    margin-right:0.5em;
    text-align: right;
    font-size: 14px;
    background-color: #FFFFE0;
}
</style> 
    <script language="javascript" type="text/javascript">


        function avoiddoubleentry(bid) {
            document.getElementById(bid).style.display = 'none';
        }



        function popupprint() {
            var prtContent = document.getElementById('DivPrint');
            var WinPrint = window.open('', '', 'letf=900,top=500,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            // WinPrint.close();
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server" defaultbutton="btnHideValues">
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
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc6:PatientHeader ID="PatientHeader1" runat="server" />
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
                        <div id ="DivPrint" runat ="server" class ="contentdata" >
                        <table class="dataheader2" width="100%"
                            cellpadding="0" cellspacing="0">
                            <tr align>
                                <td>
                                    <asp:Label ID="lblName" Text="Name : " runat="server"></asp:Label>
                                    <asp:Label ID="lblNameValue" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblAgeOrSex" Text="Age/Sex : " runat="server"></asp:Label>
                                    <asp:Label ID="lblAgeOrSexValue" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblPno" Text="Patient Number : " runat="server"></asp:Label>
                                    <asp:Label ID="lblPnovalue" runat="server"></asp:Label>
                                </td>
                             
                            </tr>
                            <tr>
                               <td>
                                    <asp:Label ID="lblAddress" Text="Address : " runat="server"></asp:Label>
                                    <asp:Label ID="lbladdressvalue" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblContactNumber" Text="Contact Number : " runat="server"></asp:Label>
                                    <asp:Label ID="lblcontactNovalue" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <div id ="contactinfo">
                        
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" align="center">
                            <tr style="width: 100%;">
                                <td style="width: 90%;">
                                    <asp:Label ID="lblConsentForm" CssClass="contactinfo" runat="server"
                                       ></asp:Label>
                                </td>
                            </tr>
                           
                        </table>
                        </div>
                        </div>
                        <table width ="100%" >
                         <tr>
                                <td align="center">
                                    <asp:Button ID="btnOk" runat="server" Text="OK" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="return avoiddoubleentry(this.id);"
                                        OnClick="btnOk_Click" Visible="false" />
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnEdit_Click" Visible="false" />
                                    <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnPrint_Click"  OnClientClick ="return popupprint();"/>
                                    <asp:CheckBox ID="chkheader" Text="With Header" runat="server" Style="display: none;" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:Button ID="btnHideValues" runat="server" OnClientClick="javascript:return false;"
        Style="height: 0px; width: 0px; display: none;" meta:resourcekey="btnHideValuesResource1" />
    <input type="hidden" id="hdnRedirectedBy" runat="server" />
    <input type="hidden" id="hdnRedirectedTo" runat="server" />
    </form>
</body>
</html>
