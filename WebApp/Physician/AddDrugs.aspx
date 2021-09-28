<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddDrugs.aspx.cs" Inherits="Physician_AddDrugs" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="Adv" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/OPCaseSheet.ascx" TagName="OPCaseSheet" TagPrefix="uc2" %>
<%@ Register Src="../ANC/ANCCaseSheet.ascx" TagName="ancCaseSheet" TagPrefix="uc13" %>
<%@ Register Src="../CommonControls/InventoryAdvice.ascx" TagName="InvenAdv" TagPrefix="uc12" %>

<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><head id="Head1" runat='server'><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /><title>Doctor's Home</title><%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/StyleSheet.css" rel="stylesheet" type="text/css" />
   <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
   
    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <script type="text/javascript" src="../Scripts/AutoComplete.js"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <script src="../Scripts/actb.js" type="text/javascript"></script>

    <script src="../Scripts/actbcommon.js" type="text/javascript"></script>
    
    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

	
    <script language="javascript" type="text/javascript">
        function avoiddoubleentry() {
            document.getElementById('btnSave').style.display = 'none';
            GetDesc();
        }

        function PrintOPCaseSheet() {

            if (document.getElementById('hdnCasesheetType').value == "ANC") {

                document.getElementById('trAncCaseSheet').style.display = "block"

                var prtContent = document.getElementById('trAncCaseSheet');

                var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0,Addressbar=no');
                //alert(WinPrint);
                //var WinPrint = window.open('', '', 'letf=0,top=0,width=900,height=900,toolbar=0,scrollbars=0,status=0,Addressbar=no');
                WinPrint.document.write(prtContent.innerHTML);

                WinPrint.document.close();

                WinPrint.focus();

                WinPrint.print();

                WinPrint.close();
                document.getElementById('trAncCaseSheet').style.display = "none"
            }
            else {

                document.getElementById('PrintOPSheet').style.display = "block"

                var prtContent = document.getElementById('PrintOPSheet');

                var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0,Addressbar=no');

                WinPrint.document.write(prtContent.innerHTML);

                WinPrint.document.close();

                WinPrint.focus();

                WinPrint.print();

                WinPrint.close();

                document.getElementById('PrintOPSheet').style.display = "none"

            }
        }

        function PrintPrescription() {


            document.getElementById('trPrescription').style.display = "block"


            var prtContent = document.getElementById('trPrescription');

            var WinPrint = window.open('', '', 'letf=100,top=100,width=600,height=500,toolbar=0,scrollbars=1,status=0,Addressbar=no');
            //alert(WinPrint);
            //var WinPrint = window.open('', '', 'letf=0,top=0,width=900,height=900,toolbar=0,scrollbars=0,status=0,Addressbar=no');
            WinPrint.document.write(prtContent.innerHTML);

            WinPrint.document.close();

            WinPrint.focus();

            WinPrint.print();

            WinPrint.focus();

            document.getElementById('trPrescription').style.display = "none"
        }

        
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server" defaultbutton="btnHideValues">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc3:DocHeader ID="docHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
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
                                <top:topheader id="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <h2 id="us">
                            <asp:Label ID="Rs_AddDrugstoprescription" Text="Add Drugs to prescription" 
                                runat="server" meta:resourcekey="Rs_AddDrugstoprescriptionResource1"></asp:Label></h2>
                        <table cellpadding="2" cellspacing="1" width="100%" class="dataheader2">
                            <tr>
                                <td>
                                    <uc5:Adv runat="server" ID="uAd" AdviceMode="EditMode" />
                                    <uc12:InvenAdv ID="uIAdv" runat="server" />
                                </td>
                                
                            </tr>
                            
                          
                            <tr>
                                <td nowrap="nowrap">
                                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="return avoiddoubleentry();"
                                        OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                    <input type="button" name="btnPrintPCaseSheet" id="btnPrintPCaseSheet" value="Print CaseSheet"
                                        class="btn" onmouseout="this.className='btn'" onclick="PrintOPCaseSheet();" />
                                    <asp:HiddenField ID="hdnCasesheetType" runat="server" />
                                    <input type="button" name="btnPrintPrescription" id="btnPrintPrescription"  value="Print Prescription"
                                        class="btn" onmouseout="this.className='btn'" onclick="PrintPrescription();" />
                                </td>
                            </tr>
                            <tr id="PrintOPSheet" style="display: none">
                                <td>
                                    <uc2:OPCaseSheet ID="OPCaseSheet" runat="server" />
                                </td>
                            </tr>
                            <tr id="trAncCaseSheet" style="display: none">
                                <td>
                                    <uc13:ancCaseSheet ID="ancCaseSheet" runat="server" />
                                </td>
                            </tr>
                            <tr id="trPrescription" style="display: none">
                                <td>
                                    <asp:Label ID="lblPrescription" CssClass="defaultfontcolorCaseSheet" 
                                        runat="server" meta:resourcekey="lblPrescriptionResource1"></asp:Label>
                                </td>
                            </tr>
                          <%--  <tr id="trpatientname" style="display: none">
                                <td>
                                    <asp:Label ID="lblpatientname" CssClass="defaultfontcolorCaseSheet" runat="server"
                                        Text=""></asp:Label>
                                </td>
                            </tr>--%>
                            
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    <asp:Button ID="btnHideValues" runat="server" OnClientClick="javascript:return false;"
        Style="height: 0px; width: 0px;" 
        meta:resourcekey="btnHideValuesResource1" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
