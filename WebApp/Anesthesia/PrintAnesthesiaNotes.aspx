<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintAnesthesiaNotes.aspx.cs" Inherits="Anesthesia_PrintAnesthesiaNotes" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientVitals.ascx" TagName="PatientVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Print Anesthesia Notes</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/actb.js" type="text/javascript"></script>

    <script src="../Scripts/actbcommon.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function PrintProgrssiveNotes() {
            var prtContent = document.getElementById('PrintProgrssive');

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0,Addressbar=no');
            //alert(WinPrint);
            //var WinPrint = window.open('', '', 'letf=0,top=0,width=900,height=900,toolbar=0,scrollbars=0,status=0,Addressbar=no');
            WinPrint.document.write(prtContent.innerHTML);

            WinPrint.document.close();

            WinPrint.focus();

            WinPrint.print();

            // WinPrint.close();
        }
        function ShowHideForPopup(strHide) {
            if (strHide == 'Y') {
                document.getElementById('header').style.display = 'none'; //to hide the org Logo
                document.getElementById('showmenu').style.display = 'none'; //to hide Left side "<<" move image.
                return true;
            }
            else {
                document.getElementById('header').style.display = 'block';
                document.getElementById('showmenu').style.display = 'block';
                return true;
            }
        }
    </script>

    <style type="text/css">
        .style8
        {
            width: 244px;
            height: 43px;
        }
        .style18
        {
            height: 21px;
        }
        .style20
        {
            width: 244px;
            height: 48px;
        }
        .btn
        {}
        .style27
        {
            height: 41px;
        }
        .style28
        {
            height: 38px;
        }
        .style29
        {
            height: 27px;
        }
        .style30
        {
            height: 48px;
            width: 106px;
        }
        .style31
        {
            width: 216px;
            height: 39px;
        }
        .style32
        {
            width: 190px;
            height: 49px;
        }
        .style33
        {
            height: 49px;
        }
        .style38
        {
            height: 41px;
            width: 106px;
        }
        .style39
        {
            height: 38px;
            width: 106px;
        }
        .style40
        {
            height: 21px;
            width: 106px;
        }
        .style41
        {
            width: 106px;
        }
        .style42
        {
            width: 106px;
            height: 39px;
        }
        .style43
        {
            height: 49px;
            width: 106px;
        }
        .style45
        {
            height: 38px;
            width: 199px;
        }
        .style47
        {
            width: 199px;
        }
        .style48
        {
            width: 199px;
            height: 48px;
        }
        .style49
        {
            width: 199px;
            height: 41px;
        }
        .style50
        {
            width: 199px;
            height: 21px;
        }
        .style51
        {
            width: 199px;
            height: 39px;
        }
        .style52
        {
            width: 199px;
            height: 49px;
        }
        .style53
        {
            height: 41px;
            width: 190px;
        }
        .style54
        {
            height: 38px;
            width: 190px;
        }
        .style55
        {
            height: 21px;
            width: 190px;
        }
        .style56
        {
            width: 190px;
        }
        .style57
        {
            width: 190px;
            height: 48px;
        }
        .style58
        {
            width: 190px;
            height: 39px;
        }
    </style>

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
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <%--<uc3:DocHeader ID="docHeader" runat="server" />--%>
                <uc3:PatientHeader ID="patientHeader" runat="server" />
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
                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td>
                                    <uc8:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <div id="PrintProgrssive">
                            <table cellpadding="0" runat="server" cellspacing="0" border="0"  id="tblDischrageResult"
                                style="display: block;" class="defaultfontcolor" >
                                <tr class="defaultfontcolor">
                                    <td style="font-weight: bold; color: #000; font-size: 15px" align="center" 
                                        colspan ="4" class="style29">
                                        <asp:Label ID="lbltext" Text="ANESTHESIA NOTES" runat="server" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                    <tr id="trname" runat="server">
                                <td class="style49">
                                    <strong>Name:</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td class="style38">
                                    <asp:Label ID="lblname" runat="server">
                                    </asp:Label>
                                </td>
                                <td align="left" class="style53">
                                    <strong>Patient Number : </strong>
                                </td>
                                <td class="style27">
                                    <asp:Label ID="lblPatientNO" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr id="traddress" runat="server">
                                <td class="style45">
                                    Age/Sex&nbsp;&nbsp; :
                                </td>
                                <td class="style39">
                                    <asp:Label ID="lblAge" runat="server"></asp:Label>
                                </td>
                                <td align="left" class="style54">
                                    IP/NO:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td class="style28">
                                    <asp:Label ID="lblIPNO" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr id="tr1" runat="server">
                                <td class="style50">
                                    Operating Diagnosis :&nbsp;&nbsp; :
                                </td>
                                <td class="style40">
                                    <asp:Label ID="lbldignosis" runat="server"></asp:Label>
                                </td>
                                <td align="left" class="style55">
                                   Bed No:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td class="style18">
                                    <asp:Label ID="lblRoomNo" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr id="tr2" runat="server">
                                <td class="style47">
                                    Surgery Type :&nbsp;&nbsp;
                                </td>
                                <td class="style41">
                                    <asp:Label ID="lblsurgeryname" runat="server"></asp:Label>
                                </td>
                                <td align="left" class="style56">
                                    Consultant Physician:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td class="style17">
                                    <asp:Label ID="lblConsultant" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="style50">
                                    Consultant Surgeon&nbsp;&nbsp;:
                                </td>
                                <td class="style41">
                                    <asp:Label ID="lblSurgeon" runat="server"></asp:Label>
                                </td>
                                <td class="style55">
                                    Anesthetist-In-Charge&nbsp;&nbsp;&nbsp;:
                                </td>
                                <td class="style8">
                                   <asp:Label ID="lblAnesthecianName" runat ="server" ></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="style48">
                                    Time of Anesthesia&nbsp;&nbsp;:
                                </td>
                                <td align="left" class="style30">
                               <asp:Label ID="lbltimeofanesthesia" runat ="server"></asp:Label>
                                </td>
                                <td class="style57">
                                    Time Of Surgery&nbsp;&nbsp;&nbsp;:
                                </td>
                                <td class="style20">
                                    <asp:Label ID="lbltimeofsurgery" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="style51">
                                     Anesthesia Type:
                                </td>
                                <td class="style42">
                                  <asp:Label ID="lblAnesthesiaType" runat ="server" ></asp:Label>
                                </td>
                                
                                <td class="style58">
                                   NPO Duration:
                                </td>
                                <td class="style31">
                                     <asp:Label ID="lblNPODuration" runat="server"></asp:Label>
                                </td>
                                
                               
                            </tr>
                            <tr>
                             
                                <td class="style52">
                                  Anesthesia Notes:
                                </td>
                             <td align="left" nowrap="nowrap" class="style43">
                                    <asp:Label ID="lblAnesthesiaNotes" runat="server"></asp:Label>
                                </td>
                                 <td class="style32">
                                  Mode Of Anesthesia:
                                </td>
                             <td align="left" nowrap="nowrap" class="style33">
                                    <asp:Label ID="lblModeofanesthesia" runat="server" ></asp:Label>
                                </td>
                             
                             
                            </tr>
                             <tr>
                               <td class="style49">
                                 Scoring System:
                                </td>
                             <td align="left" nowrap="nowrap" class="style38">
                                    <asp:Label ID="lblscoringSystem" runat="server" ></asp:Label>
                                </td>
                                <td class="style53">
                                 Scoring Value:
                                </td>
                             <td align="left" nowrap="nowrap" class="style27">
                                    <asp:Label ID="lblScoringValue" runat="server" ></asp:Label>
                                </td>
                               
                            </tr>
                            <tr>
                              <td class="style48">
                                 Complications:
                                </td>
                             <td align="left" nowrap="nowrap" class="style30">
                                    <asp:Label ID="lblcomplication" runat="server" ></asp:Label>
                                </td>
                            </tr>
                            <tr>
                             
                             <td align="left" nowrap="nowrap" class="style41">
                                    <asp:Label ID="lbladvice" runat="server" ></asp:Label>
                                </td>
                            </tr>
                           
                            </table>
                              <table width ="100%" border ="0">
                             <%-- <tr>
                              <td>
                              Vitals:
                              </td>
                              </tr>--%>
                             <tr>
                            <td>
                            <asp:Label ID ="lblVitals" runat ="server" ></asp:Label>
                            </td>
                            </tr>
                            </table>
                            <table >
                            <asp:Label ID ="lblPrescription" runat ="server" >
                            </asp:Label>
                            </table>
                          
                           
                           </div> 
                    </table>
              <%--  </td>
            </tr>
        </table>--%>
        <table cellpadding="0" cellspacing="0" border="0" width="100%" id="tblSave" style="display: block;"
            runat="server">
            <tr>
                <td align="center" colspan="4">
                    <asp:Button ID="btnOK" Text="OK" class="btn" runat="server" OnClick="btnOK_Click" />
                    <input type="button" name="btnPrint" id="btnPrint" onclick="PrintProgrssiveNotes();"
                        value="Print" class="btn" runat="server" />
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn" OnClick="btnEdit_Click" 
                        Visible="false" Height="26px" />
                    <asp:Button ID="btnback" runat="server" Text="Back" CssClass="btn" OnClick="btnback_Click" Visible ="false"  />
                </td>
            </tr>
        </table>
    </div>
    <uc2:Footer ID="Footer1" runat="server" />
    </form>
</body>
</html>
