<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintProgressiveNotes.aspx.cs"
    Inherits="Nurse_PrintProgressiveNotes" %>

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
<%@ Register Src="../CommonControls/DiagnoseWithICD.ascx" TagName="DiagnoseWithICD"
    TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../DischargeSummary/Musculoskeletal.ascx" TagName="Musculoskeletal"
    TagPrefix="uc6" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Progress Notes</title>
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
        .style2
        {
            height: 19px;
        }
        .style6
        {
            height: 43px;
        }
        .style7
        {
            width: 216px;
            height: 43px;
        }
        .style8
        {
            width: 244px;
            height: 43px;
        }
        .style18
        {
            height: 21px;
        }
        .style19
        {
            width: 216px;
            height: 21px;
        }
        .style20
        {
            width: 244px;
            height: 21px;
        }
        .style21
        {
            height: 20px;
        }
        .style22
        {
            width: 216px;
            height: 20px;
        }
        .style23
        {
            width: 244px;
            height: 20px;
        }
        .style24
        {
            height: 25px;
        }
        .style25
        {
            width: 216px;
            height: 25px;
        }
        .style26
        {
            width: 244px;
            height: 25px;
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
                                    <td style="font-weight: bold; height: 20px; color: #000; font-size: 15px" align="center" colspan ="4">
                                        <asp:Label ID="lbltext" Text="PROGRESS NOTES" runat="server" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style2">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: bold; height: 20px;">
                                        <asp:Label ID="lblPatientDetail" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trname" runat="server">
                                    <td class="style18" >
                                      <strong>Name:</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        
                                    </td>
                                    <td class="style19">
                                       <asp:Label ID="lblname" runat="server">
                                        </asp:Label>
                                    </td>
                                    <td align="left" class="style20" >
                                       <strong> Patient Number : </strong>
                                       
                                    </td>
                                    <td class="style20">
                                     <asp:Label ID="lblPNo" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="traddress" runat="server">
                                    <td class="style21">
                                        Age/Sex&nbsp;&nbsp; :
                                       
                                    </td>
                                    <td class="style22">
                                     <asp:Label ID="lblAge" runat="server"></asp:Label>
                                    </td>
                                    <td align="left" class="style21">
                                        Address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </td>
                                    <td class="style23">
                                        <asp:Label ID="lbladdress" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="tr1" runat="server">
                                    <td class="style24">
                                        Primary Doctor :&nbsp;&nbsp; :
                                    
                                    </td>
                                    <td class="style25">
                                        <asp:Label ID="lblPrimaryDoctor" runat="server"></asp:Label>
                                    </td>
                                    <td align="left" class="style24">
                                       Purpose Of Admission:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </td>
                                    <td class="style26">
                                        <asp:Label ID="lblpurposeadmission" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="tr2" runat="server">
                                    <td class="style24">
                                        Admitting Doctor :&nbsp;&nbsp; 
                                        
                                    </td>
                                    <td class="style25">
                                    <asp:Label ID="lbladmitdoctor" runat="server"></asp:Label>
                                    </td>
                                    <td align="left" class="style24">
                                        Diagnosis:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </td>
                                    <td class="style26">
                                        <asp:Label ID="lbldiagnosis" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style6">
                                        DOA&nbsp;&nbsp;:
                                      
                                    </td>
                                    <td class="style7">
                                      <asp:Label ID="lblDOA" runat="server"></asp:Label>
                                    </td>
                                    <td class="style6">
                                       DOD&nbsp;&nbsp;&nbsp;:
                                        
                                    </td>
                                    <td class="style8">
                                    <asp:Label ID="lblDOD" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                </table>
                                <table width="80%" >
                                <tr id="trCSB" runat="server" style="display: block">
                                    <td colspan="3" class="style6">
                                        <asp:Label ID="Rs_CaseSeenby" runat="server" Text="Case Reviewd By :"></asp:Label>
                                        <asp:Label ID="lblCSB" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="tr3" runat="server" style="display: block">
                                    <td colspan="3">
                                        <asp:Label ID="lblreviewdate1" runat="server" Text="Date and Time of Case Review:"></asp:Label>
                                        <asp:Label ID="lblreviewdate" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trAdmissionVitals" runat="server" style="display: block">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;" colspan="3">
                                                    <asp:Label ID="lblVitals" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <asp:Table ID="tblAdmissionVitals" runat="server" CellSpacing="0" BorderWidth="1px"
                                                        CellPadding="8" GridLines="Both">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                          
                                        </table>
                                    </td>
                                </tr>
                               
                                <tr id="trObjective" runat="server" style="display: block">
                                    <td colspan="3">
                                        <table cellpadding="0" cellspacing="0" border="0" width="80%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;">
                                                    <asp:Label ID="lblobjtitle" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px; color: #000;" colspan="3">
                                                    <asp:Label ID="lblObjective" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <asp:Table ID="tblobjective" runat="server" CellSpacing="0" Width="26px">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                          
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trAssesment" runat="server" style="display: block">
                                    <td colspan="3">
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;" colspan="3">
                                                    <asp:Label ID="lblAssesment" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px; color: #000;" colspan="3">
                                                    <asp:Label ID="lblassessment" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <asp:Table ID="tblAssesment" runat="server" CellSpacing="0">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                          
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trPlanning" runat="server" style="display: block">
                                    <td colspan="3">
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td style="font-weight: bold; height: 20px; color: #000;" colspan="3">
                                                    <asp:Label ID="lblPlanningTitle" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px; color: #000;" colspan="3">
                                                    <asp:Label ID="lblplanning" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <asp:Table ID="tblplanning" runat="server" CellSpacing="0">
                                                    </asp:Table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
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
                        Visible="false" />
                    <asp:Button ID="btnback" runat="server" Text="Back" CssClass="btn" OnClick="btnback_Click" />
                </td>
            </tr>
        </table>
    </div>
    <uc2:Footer ID="Footer1" runat="server" />
    </form>
</body>
</html>
