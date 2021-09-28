<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Adddiagonosis.aspx.cs" Inherits="Reception_Adddiagonosis" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/PendingICDCode.ascx" TagName="PendingICDCode"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/AddDiagonosis.ascx" TagName="AddDiagonosis" TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Reception</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
 <%--         <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>
    <script src="../Scripts/bid.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Scripts/AutoComplete.js"></script>
    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <script src ="../scripts/MessageHandler.js" language ="javascript" type ="text/javascript" ></script>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">
 var userMsg ;
        function showdiv() {


            if (document.getElementById('tblPrevVisit').style.display == "none") {
                document.getElementById('tblPrevVisit').style.display = "block";
            }
            else {
                document.getElementById('tblPrevVisit').style.display = "none";
            }

        }

        function showdivone() {

            if (document.getElementById('tblPPDT').style.display == "none") {
                document.getElementById('tblPPDT').style.display = "block";
            }
            else {
                document.getElementById('tblPPDT').style.display = "none";
            }

        }

        function showdivs() {

            if (document.getElementById('tblPrevSOI').style.display == "none") {
                document.getElementById('tblPrevSOI').style.display = "block";
            }
            else {
                document.getElementById('tblPrevSOI').style.display = "none";
            }

        }

        function showdivsbp() {

            if (document.getElementById('tblBP').style.display == "none") {
                document.getElementById('tblBP').style.display = "block";
            }
            else {
                document.getElementById('tblBP').style.display = "none";
            }

        }


        function InPageValidation() {

            if (document.getElementById('uctrlAddDiagonosis_hdnDiagnosisItems').value == '') {
             userMsg = SListForApplicationMessages.Get('Reception\\Adddiagonosis.aspx_1');
                if(userMsg !=null)
                {
                  alert (userMsg );
                             return false;
                  
                }  
              else{
                alert('Add Diagnosis before saving');
                //document.getElementById('INVStockUsage1_txtProduct').focus();
                return false;
                }

            }
        }


    
    </script>

</head>
<body  oncontextmenu="return false;">
    <form runat="server" id="form1">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <%--        <div id="header">
            <div style="float: left; width: 7%;" >
                <img alt="" src="<%=LogoPath%>" class="logostyle" />
            </div>
            <div style="float: right; width: 93%; z-index: 2">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="RHead" runat="server" />
            </div>
        </div>--%>
        <div id="header">
            <div class="logoleft" style="z-index:2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>"  class="logostyle" />
                </div>
            </div>
                <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="RHead" runat="server" />
            </div>
                    <div style="float: right;"  class="Rightheader"></div>
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
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                    
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td align="right">
                                </td>
                            </tr>
                            <tr>
                                <td class="blackfontcolorbig" height="32px">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table id="tblICDOPIP" width="100%" align="left" class="dataheaderInvCtrl defaultfontcolor">
                                        <tr>
                                            <td align="center">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            <asp:Panel ID="pnlPSearch" runat="server" GroupingText="Patient Details"
                                                    Style="color: #000000;" meta:resourcekey="pnlPSearchResource1">
                                                
                                                <table cellpadding="3" cellspacing="3" align="right" width="100%" class="dataheader3">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Rs_Name" Text="Name" runat="server" 
                                                                meta:resourcekey="Rs_NameResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblPatientName" runat="server" 
                                                                meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_PatientID" Text="Patient ID" runat="server" 
                                                                meta:resourcekey="Rs_PatientIDResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblPatientID" runat="server" 
                                                                meta:resourcekey="lblPatientIDResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Rs_Age" Text="Age" runat="server" 
                                                                meta:resourcekey="Rs_AgeResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label runat="server" ID="lblPatientAge" 
                                                                meta:resourcekey="lblPatientAgeResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_Address" Text="Address" runat="server" 
                                                                meta:resourcekey="Rs_AddressResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblPatientAddress" runat="server" 
                                                                meta:resourcekey="lblPatientAddressResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Rs_Sex" Text="Sex" runat="server" 
                                                                meta:resourcekey="Rs_SexResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblPatientSex" runat="server" 
                                                                meta:resourcekey="lblPatientSexResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                        </td>
                                                        <td>
                                                            <asp:Label runat="server" ID="lblVisitType" 
                                                                meta:resourcekey="lblVisitTypeResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="40%">
                                        <tr>
                                            <td class="colorforcontent" style="width: 15%;" height="23" align="left">
                                                <img id="img3" src="../images/showbids.gif" alt="show" width="15" height="15" align="top"
                                                    runat="server" style="cursor: pointer" onclick="javascript:showdivs()" />
                                                <span style="cursor: pointer" onclick="javascript:showdivs()">
                                                <asp:Label ID="Rs_ViewDiagonosisdetails" Text="View Diagonosis details" 
                                                    runat="server" meta:resourcekey="Rs_ViewDiagonosisdetailsResource1"></asp:Label>
                                                    </span>
                                            </td>
                                        </tr>
                                    </table>
                                    <table id="tblPrevSOI" cellpadding="2" cellspacing="0" border="0" width="100%" runat="server"
                                        class="dataheaderInvCtrl" style="display: none;">
                                        <tr>
                                            <td>
                                                <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td align="left">
                                                            <uc2:PendingICDCode ID="PendingICDCodePCT" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            <uc2:PendingICDCode ID="PendingICDCodeBP" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">
                                                            <uc2:PendingICDCode ID="PendingICDCodePCN" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="40%">
                                        <tr>
                                            <td class="colorforcontent" style="width: 15%;" height="23" align="left">
                                                <img id="img4" src="../images/showbids.gif" alt="show" width="15" height="15" align="top"
                                                    runat="server" style="cursor: pointer" onclick="javascript:showdivsbp()" />
                                                <span style="cursor: pointer" onclick="javascript:showdivsbp()">
                                                <asp:Label ID="Rs_AddDiagonosis" Text="Add Diagonosis" runat="server" 
                                                    meta:resourcekey="Rs_AddDiagonosisResource1"></asp:Label>
                                                </span>
                                            </td>
                                        </tr>
                                    </table>
                                    <table id="tblBP" cellpadding="2" cellspacing="0" border="0" width="100%" runat="server"
                                        class="dataheaderInvCtrl" style="display: block;">
                                        <tr>
                                            <td>
                                                <table cellpadding="4" class="dataheaderInvCtrl" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="font-weight: normal; color: #000;">
                                                            <uc8:AddDiagonosis ID="uctrlAddDiagonosis" runat="server"></uc8:AddDiagonosis>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btnFinish" runat="server" Text="Save" CssClass="btn" 
                                        OnClientClick="return InPageValidation();" OnClick="btnFinish_Click"
                                        onmouseover="this.className='btn btnhov'" 
                                        onmouseout="this.className='btn'" meta:resourcekey="btnFinishResource1" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" OnClick="btnCancel_Click"
                                        onmouseover="this.className='btn btnhov'" 
                                        onmouseout="this.className='btn'" meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
               </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnDiagnosisItems" runat="server" />
        <uc5:Footer ID="Footer1" runat="server" />
        <asp:HiddenField ID ="hdnMessages" runat ="server" />
    </div>
    </form>
</body>
</html>
