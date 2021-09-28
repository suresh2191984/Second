<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrescriptionPrinting.aspx.cs"
    Inherits="Printing_PrescriptionPrinting" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/PrintPrescription.ascx" TagName="PrintPrescription"
    TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OPCaseSheet.ascx" TagName="OPCaseSheet" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/BillPrint.ascx" TagName="BillPrint" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/PatientPrescription.ascx" TagName="Treatment"
    TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Receipt.ascx" TagName="Receipt" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/DialysisOnFlow.ascx" TagName="OnFlowDialysis"
    TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/DialysisCaseSheet.ascx" TagName="DialysisCaseSheet"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc10" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc11" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc12" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Patient Visit Details</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <%-- <script src="../Scripts/jquery-ui.min.js" type="text/javascript"></script>
--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <style type="text/css">
        #floating-box
        {
            width: 90px;
            height: 200px;
            border: 1px solid red;
            background-color: #BBBBBB;
            float: left;
            margin-left: -100px;
            margin-right: 10px;
            position: absolute;
            z-index: 1;
        }
        #page
        {   
            width: 100px;
            margin: 0 auto;
        }
        #headerorg
        {
            height: 50px;
            margin: 8px;
        }
        #body1
        {
            height: 50px;
            margin: 8px;
        }
        #footer1
        { 
        	
            height: 50px;
            margin: 8px;
        }
        h1, h2
        {
            padding: 16px;
        }
    </style>

    <script language="javascript" type="text/javascript">
   
    
      function PopUps() {
            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=200,width=500";
            // ADDED THE LINE BELOW TO ORIGINAL EXAMPLE
            strFeatures = strFeatures + ",left=0,top=0";
             if(document.getElementById('chkheader').checked==true)
            {
            chk ='Y';
            }
            else
            {
            chk ='N';
            }
         
          var strURL = "../Reception/PrintPage.aspx?vid=<%=Request.QueryString["vid"]%>&pagetype=PP&IsPopup=Y&chk="+chk+"";
            window.open(strURL, "", strFeatures, true);
        }
      function popupprint() {
    
            var prtContent = document.getElementById('print');
            var WinPrint = window.open('', '', 'letf=0,top=0, height=500,width=600,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
               var chk;
            if(document.getElementById('chkheader').checked==true)
            {
               document.getElementById('trHeader').style.display = 'Block';
            document.getElementById('trHeader1').style.display = 'Block';
            document.getElementById('trFooter').style.display = 'Block';
            document.getElementById('trMoto').style.display = 'Block';
           
            }
            else
            {
               document.getElementById('trHeader').style.display = 'none';
            document.getElementById('trHeader1').style.display = 'none';
            document.getElementById('trFooter').style.display = 'none';
            document.getElementById('trMoto').style.display = 'none';
           
            }
            
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
           
        }
    </script>

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
                <uc10:MainHeader ID="MHead" runat="server" />
                <uc8:Header ID="RHead" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc9:LeftMenu ID="LeftMenu1" runat="server" />
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
                                <uc12:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <div id="print" runat="server">
                         <div id="headerorg">
                                <table width="100%" border="0">
                                    <tr id="trHeader" style="display: none;">
                                        <td colspan="9" align="center">
                                            <asp:Image ID="imgBillLogo" runat="server" meta:resourcekey="imgBillLogoResource1" />
                                        </td>
                                    </tr>
                                    <tr id="trHeader1" style="display: none;" align="center">
                                        <td colspan="9" align="center">
                                            <font color="Purple">
                                                <asp:Label ID="lblHospitalName" runat="server" Font-Bold="true" Font-Size="12">
                                                </asp:Label>
                                            </font>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            
                                <div id="footer1">
                                <table width="100%">
                                    <tr id="trFooter" runat="server" style="display: none;" align="center">
                                        <td align="center">
                                            <font color="Red">
                                                <asp:Label ID="lblFooter" runat="server" Font-Bold="true" Font-Size="12">
                                                </asp:Label>
                                            </font>
                                        </td>
                                    </tr>
                                    <tr id="trMoto" runat="server" style="display: none;" align="center">
                                        <td align="center">
                                            <font size="4" face="French Script MT" color="Purple">
                                                <asp:Label ID="lblmoto" runat="server" Font-Bold="true">
                                                </asp:Label>
                                            </font>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                           
                               <div  id ="body1">
                                <table id="Table1" cellspacing="1"  width="100%" border="0" runat="server">
                                    <tr align="left" valign="top">
                                        <td>
                                            <uc1:PrintPrescription ID="PrintPrescription" runat="server" />
                                        </td>
                                        </tr>
                                       
                                </table>
                                
                            </div>
                           
                      

                          
                        </div>
                        <table width="100%">
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btnPrint" Text="Print" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="popupprint();" runat="server"
                                        meta:resourcekey="btnPrintResource1" />
                                    <asp:CheckBox ID="chkheader" runat="server" Text="Print with Header" Font-Bold ="true"  />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        
    </div>
    <uc11:Footer ID="Footer" runat="server" />
    </form>
</body>
</html>
