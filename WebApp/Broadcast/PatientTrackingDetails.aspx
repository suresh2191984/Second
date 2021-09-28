<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientTrackingDetails.aspx.cs"
    Inherits="Reception_PatientsCurrDateVist" Culture="auto" UICulture="auto" EnableEventValidation="false" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/CommonControls/PhysicianHeader.ascx" TagName="PhyHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/ViewTRFImage.ascx" TagName="ViewTRFImage" TagPrefix="TRF" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Today's Patient Visits</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>

    <script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />

    <script src="../Scripts/AdobeReaderDetection.js" type="text/javascript" language="javascript" />

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <%-- <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_page.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_table.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_table_jui.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />--%>

    <script type="text/javascript">
        function ClosePopUp() {
            $find('modalPopUp').hide();
        }
    </script>

    <style type="text/css">
        .gridView
        {
            table-layout: fixed;
        }
        .col
        {
            word-wrap: break-word;
        }
        .Progress
        {
            background-color: #CF4342;
            color: White;
        }
        .Progress img
        {
            vertical-align: middle;
            margin: 2px;
        }
        #UpdateProgress2
        {
            background-color: #CF4342;
            color: #fff;
            top: 0px;
            right: 0px;
            position: fixed;
        }
        #UpdateProgress2 img
        {
            vertical-align: middle;
            margin: 2px;
        }
        .style6
        {
            height: 22px;
        }
    </style>

    <script type="text/javascript">

        function Validate() {

            if (document.getElementById('txtVisitNumber').value == '') {
                alert('Enter Visit Number');
                return false;
            }

        }
        function DisplayTab(tabName) {
            debugger;
            $('#TabsMenu li').removeClass('active');
            if (tabName == 'VREG') {
                document.getElementById('tdViewRegistration').style.display = 'block';
                $('#li1').addClass('active');
                document.getElementById('tdEpisodeHistory').style.display = 'none';
            }
            if (tabName == 'EPI') {
                document.getElementById('tdViewRegistration').style.display = 'none';
                $('#li2').addClass('active');
                document.getElementById('tdEpisodeHistory').style.display = 'block';
                var btnShow = document.getElementById('btnShow');
                btnShow.click();
            }

            if (tabName == 'CDM') {
                document.getElementById('tdViewRegistration').style.display = 'none';
                document.getElementById('tdEpisodeHistory').style.display = 'none';
                
                $('#li3').addClass('active');
                document.getElementById('tdCommunication').style.display = 'block';
                var btnCommunication = document.getElementById('btnCommunication');
                btnCommunication.click();
            }
            
        }


        function DisableTRFCtrls() {
            //divLnkHistory divLnkDevicevalue  
            document.getElementById('divLnkHistory').style.display = 'none';
            document.getElementById('divLnkDevicevalue').style.display = 'none';
            // 
            // document.getElementById('LnkHistory').style.display='none';
            // document.getElementById('LnkDevicevalue').style.display='none';
            // 
        }
 
    </script>

</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnGo">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header" runat="server">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="UsrHeader1" runat="server" />
                <uc7:PhyHeader ID="PhyHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" runat="server" style="display: none;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        runat="server" style="cursor: pointer;" />
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
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="UdtPanel" runat="server">
                            <ContentTemplate>
                                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UdtPanel" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter">
                                        </div>
                                        <div align="center" id="processMessage">
                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" />
                                            <br />
                                            <br />
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <table  border="0" width="100%">
                                    <tr>
                                        <td>
                                            <div id="ViewTRF" runat="server">
                                                <TRF:ViewTRFImage ID="TRFUC" runat="server" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <table border="0" cellspacing="6" cellpadding="0" width="100%">
                                    <tr>
                                        <td valign="top">
                                            <div id='TabsMenu' align="left">
                                                <ul>
                                                    <li id="li1" class="active" runat="server" onclick="DisplayTab('VREG')"><a href='#'>
                                                        <span>View Registration </span></a></li>
                                                    <li id="li2" runat="server" onclick="DisplayTab('EPI')"><a href="#"><span>Audit History
                                                    </span></a></li>
                                                    <li id="li3" runat="server" onclick="DisplayTab('CDM')"><a href="#"><span>Communication Details
                                                    </span></a></li>
                                                    
                                                    
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td id="tdViewRegistration" runat="server">
                                            <table border="0" cellspacing="0" cellpadding="0" width="99%">
                                                <tr>
                                                    <td colspan="2">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td id="trVisitAction" runat="server" class="defaultfontcolor" colspan="2">
                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td style="width: 20%">
                                                                    <span style="width: 260px;">
                                                                        <asp:RadioButtonList ID="rdbType" runat="server" RepeatDirection="Horizontal">
                                                                            <asp:ListItem Text="Visit Number" Value="1" Selected="True"></asp:ListItem>
                                                                            <asp:ListItem Text="Barcode Number" Value="2"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </span>
                                                                </td>
                                                                <td style="width: 15%" align="left">
                                                                    <asp:TextBox ID="txtVisitNumber" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:Button ID="btnGo" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                        onmouseout="this.className='btn'" Width="60px" OnClick="btnGo_Click" />
                                                                </td>
                                                                <td>
                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                        <tr>
                                                                            <td id="tdsamplefloating" runat="server" style="display: none">
                                                                                <table border="1" cellspacing="0" cellpadding="0" width="80%">
                                                                                    <tr>
                                                                                        <td id="tdtransist" runat="server" style="width: 25%" align="center">
                                                                                            <asp:Label ID="Label1" Text="Transist" runat="server"></asp:Label>
                                                                                        </td>
                                                                                        <td id="tdaccession" runat="server" style="width: 25%" align="center">
                                                                                            <asp:Label ID="Label2" Text="Accession" runat="server"></asp:Label>
                                                                                        </td>
                                                                                        <td id="tdtesting" runat="server" style="width: 25%" align="center">
                                                                                            <asp:Label ID="Label3" Text="Testing" runat="server"></asp:Label>
                                                                                        </td>
                                                                                        <td id="tdrepauth" runat="server" style="width: 25%" align="center">
                                                                                            <asp:Label ID="Label4" Text="ReportAuth." runat="server"></asp:Label>
                                                                                        </td>
                                                                                        <td id="tdreppdf" runat="server" style="width: 25%" align="center">
                                                                                            <asp:Label ID="Label5" Text="ReportPDF" runat="server"></asp:Label>
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
                                                                    &nbsp;
                                                                </td>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr id="trPatDetails" runat="server" style="display: none">
                                                    <td>
                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td>
                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                        <tr>
                                                                            <td style="width: 50%">
                                                                                <fieldset>
                                                                                    <legend style="font-size: medium; font-weight: bold; font-style: normal">Patient Details</legend>
                                                                                    <table border="0" cellspacing="5" cellpadding="0" width="100%">
                                                                                        <tr>
                                                                                            <td style="width: 27%">
                                                                                                <asp:Label ID="RS_PatName" runat="server" Text="Patient Name :"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="lblPatientName" runat="server"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="Rs_PatAge" runat="server" Text="Patient Age :"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="lblAge" runat="server"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="Rs_Gender" runat="server" Text="Gender :"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="lblGender" runat="server"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="Rs_DOB" runat="server" Text="DOB :"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="lblDOB" runat="server"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="RS_Phoneno" runat="server" Text="Phone No :"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="lblphoneno" runat="server"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="Rs_EmalID" runat="server" Text="EmailID :"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="lblEmailID" runat="server"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="RS_RefDR" runat="server" Text="Refering Doctor :"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="lblRefDr" runat="server"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </fieldset>
                                                                            </td>
                                                                            <td style="width: 50%">
                                                                                <fieldset>
                                                                                    <legend style="font-size: medium; font-weight: bold; font-style: normal">Client Details</legend>
                                                                                    <table border="0" cellspacing="5" cellpadding="0">
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="RS_ClientNAme" runat="server" Text="Client Name :"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="lblClientName" runat="server"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="RS_ClientCode" runat="server" Text="Client Code :"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="lblClientCode" runat="server"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="RS_ClientAddress" runat="server" Text="Client Address :"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="lblClientAddress" runat="server"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="RS_ClientZone" runat="server" Text="Client Zone :"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="lblClientZone" runat="server"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="Rs_Clientphone" runat="server" Text="Client Phone No :" nowrap="nowrap"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="lblClientPhNo" runat="server"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="Rs_EmailD" runat="server" Text="Client EmailID :" nowrap="nowrap"></asp:Label>
                                                                                            </td>
                                                                                            <td style="word-break: break-all">
                                                                                                <asp:Label ID="lblClientEmail" runat="server"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td colspan="2">
                                                                                                <asp:TextBox ID="TextBox1" Style="background-color: White; vertical-align: text-top"
                                                                                                    ReadOnly="True" runat="server" Height="5px" Width="5px"></asp:TextBox>
                                                                                                <asp:Label ID="Label8" Text="Active Client" runat="server"></asp:Label>
                                                                                                <asp:TextBox ID="TextBox2" Style="background-color: Orange; vertical-align: text-top"
                                                                                                    ReadOnly="True" runat="server" Height="5px" Width="5px"></asp:TextBox>
                                                                                                <asp:Label ID="Label9" Text="Suspended Client" runat="server"></asp:Label>
                                                                                                <asp:TextBox ID="TextBox3" Style="background-color: Red; vertical-align: text-top"
                                                                                                    ReadOnly="True" runat="server" Height="5px" Width="5px"></asp:TextBox>
                                                                                                <asp:Label ID="Label10" Text="Terminate Client" runat="server"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <%--<tr>
                                                                                    <td>
                                                                                        <asp:Label ID="Rs_ClientPh" runat="server" Text="Phone No :"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="lblClientPhone" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>--%>
                                                                                    </table>
                                                                                </fieldset>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 50%">
                                                                                <fieldset>
                                                                                    <legend style="font-size: medium; font-weight: bold; font-style: normal">Sample Details</legend>
                                                                                    <table border="0" cellspacing="5" cellpadding="0">
                                                                                        <tr>
                                                                                            <td style="width: 30%">
                                                                                                <asp:Label ID="RS_SamCollectedby" runat="server" Text="RegisteredAt :" Font-Bold="true"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="lblSampleCollectedBy" runat="server" Font-Bold="true"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="RS_SamCollTime" runat="server" Text="RegisteredBy :" Font-Bold="true"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="lblCollTime" runat="server" Font-Bold="true"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="RS_SamPickupTime" runat="server" Text="PickUpTime :"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="lblsampckuptime" runat="server"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <asp:Label ID="rs_samRegTime" runat="server" Text="RegistrationTime"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:Label ID="lblSampleRegTime" runat="server"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </fieldset>
                                                                            </td>
                                                                            <td>
                                                                                <table border="0" width="100%">
                                                                                    <tr>
                                                                                        <td valign="top" style="width: 50%">
                                                                                            <fieldset>
                                                                                                <legend style="font-size: medium; font-weight: bold; font-style: normal">Registration
                                                                                                    Details </legend>
                                                                                                <table border="0" cellspacing="5" cellpadding="0" width="100%">
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <table border="1" cellspacing="0" cellpadding="0" width="75%">
                                                                                                                <tr>
                                                                                                                    <td id="tdb2b" runat="server" style="width: 25%" align="center">
                                                                                                                        <asp:Label ID="RS_B2B" Text="B2B" runat="server"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td id="tdb2c" runat="server" style="width: 25%" align="center">
                                                                                                                        <asp:Label ID="RS_B2C" Text="B2C" runat="server"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td id="tdhv" runat="server" style="width: 25%" align="center">
                                                                                                                        <asp:Label ID="RS_homeVisit" Text="HV" runat="server"></asp:Label>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <table border="0" cellspacing="0" cellpadding="0" width="50%">
                                                                                                                <tr id="tramt" runat="server">
                                                                                                                    <td style="width: 40%" nowrap="nowrap">
                                                                                                                        <asp:Label ID="RS_AmtPaid" runat="server" Text="Amount Paid"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td align="left">
                                                                                                                        <asp:Label ID="lblAmtPaid" runat="server"></asp:Label>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr id="trdue" runat="server">
                                                                                                        <td>
                                                                                                            <table border="0" cellspacing="0" cellpadding="0" width="50%">
                                                                                                                <tr id="tr1" runat="server">
                                                                                                                    <td style="width: 40%" nowrap="nowrap">
                                                                                                                        <asp:Label ID="RS_DueAmt" runat="server" Text="Due Amount"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td align="left">
                                                                                                                        <asp:Label ID="lblDueAmt" runat="server"></asp:Label>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr id="trtotamt" runat="server">
                                                                                                        <td>
                                                                                                            <table border="0" cellspacing="0" cellpadding="0" width="50%">
                                                                                                                <tr id="tr2" runat="server">
                                                                                                                    <td style="width: 40%" nowrap="nowrap">
                                                                                                                        <asp:Label ID="Rs_GrandTotal" runat="server" Text="Total Amount"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td align="left">
                                                                                                                        <asp:Label ID="lbltotAmount" runat="server"></asp:Label>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </fieldset>
                                                                                        </td>
                                                                                        <td id="history" runat="server" align="center" valign="top">
                                                                                            <table width="100%" align="center" border="0">
                                                                                                <tr>
                                                                                                    <td style="width: 50%" valign="top">
                                                                                                        <fieldset>
                                                                                                            <legend style="font-size: medium; font-weight: bold; font-style: normal;">History And
                                                                                                                Remarks </legend>
                                                                                                            <asp:GridView ID="Bckgrd" Width="100%" runat="server" AutoGenerateColumns="False"
                                                                                                                ForeColor="#333333" BorderColor="ActiveCaption" CssClass="dataheader2">
                                                                                                                <HeaderStyle CssClass="dataheader1" />
                                                                                                                <Columns>
                                                                                                                    <asp:BoundField DataField="History" HeaderText="History" />
                                                                                                                    <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                                                                                                                </Columns>
                                                                                                            </asp:GridView>
                                                                                                        </fieldset>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                        <tr runat="server" id="trBillingDetails">
                                                                            <td style="width: 50%">
                                                                                <fieldset>
                                                                                    <legend style="font-size: medium; font-weight: bold; font-style: normal">Billing Details</legend>
                                                                                    <table border="0" cellspacing="5" cellpadding="0">
                                                                                        <tr id="trlegend" runat="server" style="display: block">
                                                                                            <td align="left">
                                                                                                <asp:TextBox ID="txtStatColor" Style="background-color: gray; vertical-align: text-top"
                                                                                                    ReadOnly="True" runat="server" Height="5px" Width="5px"></asp:TextBox>
                                                                                                <asp:Label ID="lblStatTestColor" Text="Client Bill" runat="server"></asp:Label>
                                                                                                <asp:TextBox ID="txtInvoiceColor" Style="background-color: Lime; vertical-align: text-top"
                                                                                                    ReadOnly="True" runat="server" Height="5px" Width="5px"></asp:TextBox>
                                                                                                <asp:Label ID="Label6" Text="Invoice Bill" runat="server"></asp:Label>
                                                                                                <asp:TextBox ID="txtDueBillColor" Style="background-color: IndianRed; vertical-align: text-top"
                                                                                                    ReadOnly="True" runat="server" Height="5px" Width="5px"></asp:TextBox>
                                                                                                <asp:Label ID="Label7" Text="Due Bill" runat="server"></asp:Label>
                                                                                                <asp:TextBox ID="TxtCopayment" Style="background-color: #FFDDAA; vertical-align: text-top"
                                                                                                    ReadOnly="True" runat="server" Height="5px" Width="5px"></asp:TextBox>
                                                                                                <asp:Label ID="lblCopay" Text="Co-Payment Bill" runat="server"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="width: 30%">
                                                                                                <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" DataKeyNames="BillID"
                                                                                                    OnRowDataBound="grdResult_RowDataBound" OnRowCommand="grdResult_RowCommand" meta:resourceKey="grdResultResource1">
                                                                                                    <Columns>
                                                                                                        <asp:BoundField DataField="BillID" HeaderText="BillID" meta:resourceKey="BoundFieldResource1"
                                                                                                            Visible="False" />
                                                                                                        <asp:TemplateField Visible="false" HeaderText="Select" meta:resourceKey="TemplateFieldResource1">
                                                                                                            <ItemTemplate>
                                                                                                                <asp:RadioButton ID="rdSel" runat="server" GroupName="BillSelect" ToolTip="Select Row" /><%--meta:resourceKey="rdSelResource1"--%>
                                                                                                            </ItemTemplate>
                                                                                                            <ItemStyle Width="3%" />
                                                                                                        </asp:TemplateField>
                                                                                                        <asp:BoundField Visible="False" DataField="PatientNumber" HeaderText="Patient No"
                                                                                                            meta:resourceKey="BoundFieldResource2">
                                                                                                            <ItemStyle Width="4%" />
                                                                                                        </asp:BoundField>
                                                                                                        <asp:BoundField DataField="VisitNumber" HeaderText="Visit Number">
                                                                                                            <ItemStyle Width="15%" />
                                                                                                        </asp:BoundField>
                                                                                                        <asp:BoundField DataField="BillNumber" HeaderText="Bill No" meta:resourceKey="BoundFieldResource3">
                                                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                                                            <ItemStyle HorizontalAlign="Left" Width="15%" />
                                                                                                        </asp:BoundField>
                                                                                                        <asp:BoundField DataField="PatientVisitId" HeaderText="VisitID" meta:resourceKey="BoundFieldResource4" />
                                                                                                        <asp:BoundField DataField="PatientID" HeaderText="PID" meta:resourceKey="BoundFieldResource5" />
                                                                                                        <asp:BoundField DataField="BillDate" DataFormatString="{0:dd MMM yyyy hh:mm tt}"
                                                                                                            HeaderText="Bill Date" meta:resourceKey="BoundFieldResource6">
                                                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                                                            <ItemStyle HorizontalAlign="Left" Width="15%" />
                                                                                                        </asp:BoundField>
                                                                                                        <asp:BoundField Visible="False" DataField="Name" HeaderText="Patient Name" meta:resourceKey="BoundFieldResource7">
                                                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                                                            <ItemStyle Width="18%" />
                                                                                                        </asp:BoundField>
                                                                                                        <asp:BoundField DataField="Amount" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Right"
                                                                                                            HeaderText="Amount" ItemStyle-Width="3%">
                                                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                                                            <ItemStyle Width="3%" />
                                                                                                        </asp:BoundField>
                                                                                                        <asp:BoundField DataField="AmountReceived" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Right"
                                                                                                            HeaderText="Amount Received" ItemStyle-Width="3%">
                                                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                                                            <ItemStyle Width="3%" />
                                                                                                        </asp:BoundField>
                                                                                                        <asp:BoundField DataField="DrName" HeaderStyle-HorizontalAlign="left" HeaderText="Doctor Name"
                                                                                                            ItemStyle-Width="17%" Visible="false">
                                                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                                                            <ItemStyle Width="17%" />
                                                                                                        </asp:BoundField>
                                                                                                        <asp:BoundField DataField="RefOrgName" HeaderText="Hospital/CC/Branch" meta:resourceKey="BoundFieldResource10"
                                                                                                            Visible="False">
                                                                                                            <HeaderStyle HorizontalAlign="Left" />
                                                                                                            <ItemStyle Width="25%" />
                                                                                                        </asp:BoundField>
                                                                                                        <asp:TemplateField HeaderText="Bill Status" HeaderStyle-HorizontalAlign="left" Visible="false">
                                                                                                            <ItemTemplate>
                                                                                                                <asp:Label ID="lblRefundstatus" Text='<%# Eval("RefundStatus") %>' runat="server"
                                                                                                                    meta:resourcekey="lblRefundstatusResource1"></asp:Label>
                                                                                                            </ItemTemplate>
                                                                                                        </asp:TemplateField>
                                                                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Action">
                                                                                                            <ItemTemplate>
                                                                                                                <asp:Label runat="server" Font-Underline="True" Style="cursor: pointer" ForeColor="Black"
                                                                                                                    Text="View Bill" ID="lblViewBill"></asp:Label>
                                                                                                                &nbsp; / &nbsp;
                                                                                                                <asp:Label runat="server" Font-Underline="True" Style="cursor: pointer" ForeColor="Black"
                                                                                                                    Text="Mail Bill" ID="lblMailBill"></asp:Label>
                                                                                                            </ItemTemplate>
                                                                                                        </asp:TemplateField>
                                                                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="0">
                                                                                                            <ItemTemplate>
                                                                                                                <asp:Label runat="server" Font-Underline="True" Style="cursor: pointer" ForeColor="Black"
                                                                                                                    Text="View Bill" ID="lblViewBillB2C"></asp:Label>
                                                                                                                <asp:Panel ID="dvDuePaidBill" runat="server">
                                                                                                                    <%--  &nbsp; / &nbsp;--%>
                                                                                                                    <asp:Label runat="server" Font-Underline="True" Style="cursor: pointer; display: block;"
                                                                                                                        ForeColor="Black" Text="View Complete Bill" ID="lblViewCompleteBillB2C"></asp:Label>
                                                                                                                </asp:Panel>
                                                                                                            </ItemTemplate>
                                                                                                        </asp:TemplateField>
                                                                                                    </Columns>
                                                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                                                                                                        PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                                                                                                    <PagerStyle HorizontalAlign="Center" />
                                                                                                </asp:GridView>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </fieldset>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td align="center" colspan="2">
                                                                                <table width="100%" align="center">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <fieldset>
                                                                                                <legend style="font-size: medium; font-weight: bold; font-style: normal">Sample And
                                                                                                    Container Details</legend>
                                                                                                <table border="0" cellspacing="0" cellpadding="0" width="100%" align="center">
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:GridView ID="GrdSample" Width="100%" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                                                                OnRowDataBound="GrdSample_Databound" ForeColor="#333333" BorderColor="ActiveCaption"
                                                                                                                PageSize="15" CssClass="dataheader2">
                                                                                                                <HeaderStyle CssClass="dataheader1" />
                                                                                                                <Columns>
                                                                                                                    <asp:BoundField DataField="Testname" Visible="false" HeaderText="TestName" />
                                                                                                                    <asp:BoundField DataField="BarcodeNumber" HeaderText="Sample ID" />
                                                                                                                    <asp:BoundField DataField="SampleDesc" HeaderText="Sample Name" />
                                                                                                                    <asp:BoundField DataField="SampleContainerName" HeaderText="Container Name" />
                                                                                                                    <asp:BoundField DataField="Status" HeaderText="Sample Status" />
                                                                                                                    <asp:BoundField DataField="CollectedDateTime" HeaderText="Sample CollectedAt" />
                                                                                                                    <asp:BoundField DataField="PatientName" HeaderText="Sample CollectedBy" />
                                                                                                                    <asp:BoundField DataField="TransferedDateTime" HtmlEncode="false" HeaderText="TransferedDateTime"
                                                                                                                        DataFormatString="{0:dd-MM-yyyy hh:mm tt}" />
                                                                                                                    <%-- <asp:TemplateField HeaderText="TransferedDateTime" Visible="true" ItemStyle-HorizontalAlign="Center" >
                                                                                                                        <ItemTemplate>
                                                                                                                            <asp:Label ID="lblTransferedDateTime" ItemStyle-Width="10%" Visible="true" runat="server"
                                                                                                                                Text='<%# Eval("TransferedDateTime").ToString()=="01/01/0001 00:00:00"? "" : string.Format("{0:dd-MM-yyyy hh:mm tt}", Eval("TransferedDateTime"))%>'></asp:Label>
                                                                                                                        </ItemTemplate>
                                                                                                                    </asp:TemplateField>--%>
                                                                                                                    <asp:BoundField DataField="Param2" HeaderText="Sample TransferBy" />
                                                                                                                    <asp:BoundField DataField="ReceivedDateTime" HtmlEncode="false" HeaderText="ReceivedDateTime"
                                                                                                                        DataFormatString="{0:dd-MM-yyyy hh:mm tt}" />
                                                                                                                    <%--<asp:TemplateField HeaderText="ReceivedDateTime" Visible="true" ItemStyle-HorizontalAlign="Center">
                                                                                                                        <ItemTemplate>
                                                                                                                            <asp:Label ID="lblReceivedDateTime" ItemStyle-Width="10%" Visible="true" runat="server"
                                                                                                                                Text='<%# Eval("ReceivedDateTime").ToString()=="1/1/0001 00:00:00 AM"? "" : string.Format("{0:dd-MM-yyyy hh:mm tt}", Eval("ReceivedDateTime"))%>'></asp:Label>
                                                                                                                        </ItemTemplate>
                                                                                                                    </asp:TemplateField>--%>
                                                                                                                    <asp:BoundField DataField="Param1" HeaderText="Sample ReceivedBy" />
                                                                                                                </Columns>
                                                                                                            </asp:GridView>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </fieldset>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td id="trreportdetails" runat="server" align="center" colspan="2">
                                                                                <table width="100%" align="center">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <fieldset>
                                                                                                <legend style="font-size: medium; font-weight: bold; font-style: normal">Report Details</legend>
                                                                                                <table border="0" cellspacing="0" cellpadding="0" width="100%" align="center">
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:GridView ID="GrdReport" Width="100%" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                                                                ForeColor="#333333" BorderColor="ActiveCaption" PageSize="15" CssClass="dataheader2" OnPageIndexChanging="GrdReport_PageIndexChanging"
                                                                                                                OnRowDataBound="GrdReport_RowDataBound">
                                                                                                                <HeaderStyle CssClass="dataheader1" />
                                                                                                                <Columns>
                                                                                                                    <asp:BoundField DataField="GroupName" ItemStyle-Width="30%" ItemStyle-Wrap="true" HeaderText="TestName" />
                                                                                                                    <asp:BoundField DataField="Migrated_TestCode" HeaderText="TCODE" />
                                                                                                                    <asp:BoundField DataField="PerformingPhysicainName" HeaderText="Authorized by" />
                                                                                                                    <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd-MM-yyyy hh:mm tt}"
                                                                                                                        HeaderText="Authorized time" />
                                                                                                                    <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd-MM-yyyy hh:mm tt}"
                                                                                                                        HeaderText="Report Generated time" />
                                                                                                                    <asp:BoundField DataField="OrderedAt" DataFormatString="{0:dd-MM-yyyy hh:mm tt}"
                                                                                                                        HeaderText="Report Printing time" />
                                                                                                                    <asp:TemplateField HeaderText="Report TAT" Visible="true" ItemStyle-HorizontalAlign="Center">
                                                                                                                        <ItemTemplate>
                                                                                                                            <asp:Label ID="lblCollectedDateTime" ItemStyle-Width="10%" Visible="true" runat="server"
                                                                                                                                Text='<%# string.Format("{0:dd-MM-yyyy hh:mm tt}", Eval("CollectedDateTime"))=="01-01-1753 12:00 AM"? "" : string.Format("{0:dd-MM-yyyy hh:mm tt}", Eval("CollectedDateTime"))%>'></asp:Label>
                                                                                                                        </ItemTemplate>
                                                                                                                    </asp:TemplateField>
                                                                                                                    <asp:BoundField DataField="DisplayStatus" HeaderText="Status" />
                                                                                                                </Columns>
                                                                                                            </asp:GridView>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </fieldset>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <asp:Button ID="btnViewReport" runat="server" Text="ViewReport" CssClass="btn" OnClick="btnViewreport_Click"
                                                                                                meta:resourcekey="btnViewreportResource1" OnClientClick="javascript:return AssignReportValue();" />
                                                                                            <asp:Button ID="btnSendMailReport" runat="server" Text="Send Report Mail" CssClass="btn"
                                                                                                OnClick="btnSendMail_Click" meta:resourcekey="btnSendMailReportResource1" OnClientClick="javascript:return AssignReportValue();" />
                                                                                            <%--<asp:Button ID="btnViewBill" runat="server" Text="ViewBill" CssClass="btn" OnClick="btnViewreport_Click"
                                                                                                meta:resourcekey="btnViewreportResource1" OnClientClick="javascript:return AssignBillValue();" />
                                                                                            <asp:Button ID="btnSendMailBill" runat="server" Text="Send Bill Mail" CssClass="btn"
                                                                                                OnClick="btnSendMail_Click" meta:resourcekey="btnSendMailReportResource1" OnClientClick="javascript:return AssignBillValue();" />--%>
                                                                                            <asp:Button ID="btncancel" OnClick="btnCancel_Click" runat="server" Text="Cancel"
                                                                                                CssClass="btn" />
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr id="trMailDetails">
                                                                                        <td>
                                                                                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                                                                <ContentTemplate>
                                                                                                    <asp:HiddenField ID="hdnTargetCtlMailReport" runat="server" />
                                                                                                    <cc1:ModalPopupExtender ID="modalpopupsendemail" runat="server" PopupControlID="pnlMailReports"
                                                                                                        TargetControlID="hdnTargetCtlMailReport" BackgroundCssClass="modalBackground"
                                                                                                        CancelControlID="img1" DynamicServicePath="" Enabled="True">
                                                                                                    </cc1:ModalPopupExtender>
                                                                                                    <asp:Panel ID="pnlMailReports" BorderWidth="1px" Height="40%" Width="30%" CssClass="modalPopup dataheaderPopup"
                                                                                                        runat="server" meta:resourcekey="pnlMailReportResource1" Style="display: none">
                                                                                                        <asp:Panel ID="Panel5" runat="server" CssClass="dialogHeader" meta:resourcekey="Panel1Resource1">
                                                                                                            <table width="100%">
                                                                                                                <tr>
                                                                                                                    <td>
                                                                                                                        <asp:Label ID="Label11" runat="server" Text="Email Report" meta:resourcekey="Label11Resource2"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td align="right">
                                                                                                                        <img id="img1" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                                                                                                            style="cursor: pointer;" />
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </asp:Panel>
                                                                                                        <ul>
                                                                                                            <li>
                                                                                                                <uc6:ErrorDisplay ID="ErrorDisplay3" runat="server" />
                                                                                                            </li>
                                                                                                        </ul>
                                                                                                        <table width="100%">
                                                                                                            <tr>
                                                                                                                <td colspan="2">
                                                                                                                    &nbsp;
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td align="right" style="vertical-align: middle;">
                                                                                                                    <asp:Label ID="lblMailAddress" runat="server" Text="To: " meta:resourcekey="lblMailAddressResource1" />
                                                                                                                </td>
                                                                                                                <td align="left">
                                                                                                                    <asp:TextBox ID="txtMailAddress" TextMode="MultiLine" Width="300px" Height="40px"
                                                                                                                        runat="server" meta:resourcekey="txtMailAddressResource1" />
                                                                                                                    <p style="margin: 2px 0 5px 0; font-size: 11px; color: #666;">
                                                                                                                        <asp:Label ID="lblMailAddressHint" runat="server" Text="example: abc@example.com, def@example.com"
                                                                                                                            meta:resourcekey="lblMailAddressHintResource1" />
                                                                                                                    </p>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td colspan="2" align="center">
                                                                                                                    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                                                                                                        <ProgressTemplate>
                                                                                                                            <asp:Image ID="imgProgressbars" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                                                                                            <asp:Label ID="Rs_Pleasewaits" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                                                                                                        </ProgressTemplate>
                                                                                                                    </asp:UpdateProgress>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td align="center" colspan="2">
                                                                                                                    <asp:Button ID="Send" runat="server" Text="Send" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                                                        onmouseout="this.className='btn'" OnClick="btnSendMailReport_Click" meta:resourcekey="btnSendMailReportResource1" />
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td>
                                                                                                                    <asp:HiddenField ID="hdnPatientID" runat="server" />
                                                                                                                    <asp:HiddenField ID="hdnVisitID" runat="server" />
                                                                                                                    <asp:HiddenField ID="hdnPatientEmail" runat="server" />
                                                                                                                    <asp:HiddenField ID="hdnClientEmail" runat="server" />
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </asp:Panel>
                                                                                                </ContentTemplate>
                                                                                            </asp:UpdatePanel>
                                                                                        </td>
                                                                                        <td>
                                                                                            <cc1:ModalPopupExtender ID="modalPopUp" runat="server" DropShadow="false" PopupControlID="pnlOthers"
                                                                                                BackgroundCssClass="modalBackground" Enabled="True" TargetControlID="btnDummy">
                                                                                            </cc1:ModalPopupExtender>
                                                                                            <asp:Panel ID="pnlOthers" runat="server" Style="display: none; height: 600px; width: 1050px;
                                                                                                vertical-align: bottom; top: 80px;">
                                                                                                <table width="100%" align="center">
                                                                                                    <tr>
                                                                                                        <td align="right">
                                                                                                            <img src="../Images/Close_Red_Online_small.png" alt="Close" id="img2" onclick="ClosePopUp()"
                                                                                                                style="width: 5%; height: 5%; cursor: pointer;" />
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <iframe id="ifPDF" runat="server" width="1000" height="550"></iframe>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <input type="button" id="btnDummy" runat="server" style="display: none;" />
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
                                                                       <td colspan="2">
                                                                       <table width="95%" style="display: none;" runat="server" id="CheakInv" border="0"
                                    cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="height: 23px;" align="left">
                                            <asp:HiddenField ID="HdnInvID" runat="server" />
                                            <div id="ACX2plus21" style="display: none;">
                                                <img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top" style="cursor: pointer"
                                                    onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',1);" />
                                                <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',1);">
                                                    Ordered Investigation For PatientVisit</span>
                                            </div>
                                            <div id="ACX2minus21" style="display: block;">
                                                <img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                    style="cursor: pointer" onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',0);" />
                                                <span class="dataheader1txt" style="cursor: pointer; color: #000;" onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',0);">
                                                    &nbsp;Ordered Investigation For PatientVisit</span>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="tablerow" id="ACX2responses211" style="display: block;">
                                        <td colspan="2">
                                            <div class="dataheader2">
                                                <asp:UpdatePanel ID="UpdPnl1" runat="server">
                                                    <ContentTemplate>
                                                        <asp:DataList ID="GrdInv" runat="server" GridLines="Horizontal" RepeatColumns="1"
                                                            Width="100%" RepeatDirection="Vertical"  onitemdatabound="GrdInv_ItemDataBound">
                                                            <HeaderTemplate>
                                                                <table width="100%" border="0">
                                                                    <tr>
                                                                        <td>
                                                                            &nbsp;
                                                                        </td>
                                                                        <td>
                                                                            <b>INVESTIGATIONNAME </b>
                                                                        </td>
                                                                        <td>
                                                                            <b>STATUS </b>
                                                                        </td>
                                                                        <td>
                                                                            &nbsp;
                                                                        </td>
                                                                        <%--<td >
                                                                        <b> 
                                                                            INVESTIGATIONNAME
                                                                          </b>  
                                                                        </td>
                                                                        <td >
                                                                        <b> 
                                                                            STATUS
                                                                        <b>     
                                                                        </td>--%>
                                                                        <%--</tr>
                                                                    <tr>--%>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <td width="70%">
                                                                    <%# DataBinder.Eval(Container.DataItem, "InvestigationName")%>
                                                                   <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("ReferredType")%>'></asp:Label>
                                                                </td>
                                                                <td headers="Status">
                                                                    <%# DataBinder.Eval(Container.DataItem, "DisplayStatus")%>
                                                                </td>
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                </tr> </table>
                                                            </FooterTemplate>
                                                        </asp:DataList>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>
                                        </td>
                                    </tr>
                                </table></td>
                                                                       </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <%--<tr>
                                            <td colspan="2">
                                                <table border="0" cellpadding="0" cellspacing="3" width="100%">
                                                    <tr>
                                                        <td colspan="3" style="width:60%">
                                                        <fieldset>
                                                        <legend>PatientDetails</legend>
                                                        </fieldset>
                                                        </td>
                                                        <td class="style6" colspan="3">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 5%">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="lblpatname" runat="server" Text="Patient Name:" Font-Bold="true"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:Label ID="lbltxtPatName" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="lblClientName" runat="server" Text="Client Name:" Font-Bold="true"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:Label ID="lbltxtclientName" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                    <td>
                                                    
                                                    </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 5%">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="lblPatientAge" runat="server" Text="Patient Age:" Font-Bold="true"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:Label ID="Label2" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="Label3" runat="server" Text="Client Codee:" Font-Bold="true"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:Label ID="Label4" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                    <td>
                                                    
                                                    </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 5%">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="Label1" runat="server" Text="Gender :" Font-Bold="true"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:Label ID="Label5" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="Label6" runat="server" Text="Client Address:" Font-Bold="true"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:Label ID="Label7" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                     <tr>
                                                    <td>
                                                    
                                                    </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 5%">
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="Label8" runat="server" Text="DOB :" Font-Bold="true"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:Label ID="Label9" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="width: 10%">
                                                            <asp:Label ID="Label10" runat="server" Text="Client Zone:" Font-Bold="true"></asp:Label>
                                                        </td>
                                                        <td style="width: 20%">
                                                            <asp:Label ID="Label11" runat="server"></asp:Label>
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>--%>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <asp:Button ID="btnShow" runat="server" CssClass="btn" Text="Show" Style="display: none;"
                                            OnClick="btnShow_OnClick" OnClientClick="return Validate()" />
                                        <td id="tdEpisodeHistory" runat="server" style="display: none;">
                                            <table id="tblGrid" runat="server" width="100%" align="center">
                                                <tr>
                                                    <td>
                                                        <fieldset>
                                                            <legend style="font-size: medium; font-weight: bold; font-style: normal">Audit History
                                                            </legend>
                                                            <table border="0" cellspacing="0" cellpadding="0" width="100%" align="center">
                                                                <tr>
                                                                    <td>
                                                                        <asp:GridView ID="grdAudit" Width="100%" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                            ForeColor="#333333" BorderColor="ActiveCaption" OnRowDataBound="grdAudit_RowDataBound"
                                                                            OnPageIndexChanging="grdAudit_PageIndexChanging" PageSize="30" CssClass="dataheader2">
                                                                            <HeaderStyle CssClass="dataheader1" />
                                                                            <Columns>
                                                                                <asp:BoundField DataField="DateTime" HeaderText="Date Time" />
                                                                                <asp:BoundField DataField="User" HeaderText="User Name" />
                                                                                <asp:BoundField DataField="Location" HeaderText="Location" />
                                                                                <asp:BoundField DataField="Activity" HeaderText="Activity" />
                                                                                <asp:BoundField DataField="TestValue" HeaderText="Test Value" />
                                                                                <asp:BoundField DataField="OldValues" HeaderText="Old Value" />
                                                                                <asp:BoundField DataField="CurrentValues" HeaderText="Current Value" />
                                                                            </Columns>
                                                                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                        </asp:GridView>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </fieldset>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>  <td>
                                            <asp:Button ID="btnCommunication" runat="server" CssClass="btn" Text="Show" Style="display: none;"
                                             OnClientClick="return Validate()" OnClick="btnCommunication_Click" /></td>
                                        <td id="tdCommunication" runat="server" style="display: none;">
                                            <table  width="100%" align="center">
                                                <tr>
                                                    <td>
                                                        <fieldset>
                                                            <legend style="font-size: medium; font-weight: bold; font-style: normal">Communication Details
                                                            </legend>
                                                            <table border="0" cellspacing="0" cellpadding="0" width="100%" align="center">
                                                                <tr>
                                                                    <td>
                                                                        <asp:GridView ID="grdCommunication" Width="100%" runat="server" 
                                                                            AllowPaging="True" AutoGenerateColumns="False"
                                                                            ForeColor="#333333" BorderColor="ActiveCaption" OnRowDataBound="grdAudit_RowDataBound"
                                                                            PageSize="30" CssClass="dataheader2" 
                                                                            onpageindexchanging="grdCommunication_PageIndexChanging">
                                                                            <HeaderStyle CssClass="dataheader1" />
                                                                            <Columns>
                                                                                <asp:BoundField DataField="From" HeaderText="Date Time" />
                                                                                <asp:BoundField DataField="To" HeaderText="User Name" />
                                                                                <asp:BoundField DataField="Subject" HeaderText="Location" />
                                                                                <asp:BoundField DataField="Date" HeaderText="Date" />
                                                                                
                                                                            </Columns>
                                                                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                        </asp:GridView>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </fieldset>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                    
                                    </tr>
                                </table>
                                <asp:HiddenField ID="hdnSnapshotType" runat="server" />
                                <asp:HiddenField ID="hdnFinalBillID" runat="server" />
                                <asp:HiddenField ID="hdnFromDate" runat="server" />
                                <asp:HiddenField ID="hdnToDate" runat="server" />
                                <asp:HiddenField ID="hdnPatOrgID" runat="server" />
                                   <asp:HiddenField ID="hdnflag" runat="server" />
                                <asp:HiddenField ID="hdnBaseOrgId" runat="server" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnSelectedMailButton" runat="server" />
        <asp:HiddenField ID="hdnEMail" runat="server" />
        <uc5:Footer ID="Footer1" runat="server" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
    </div>
    </form>

    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

</body>
</html>

<script type="text/javascript" language="javascript">

    function AssignReportValue() {
        document.getElementById('hdnSnapshotType').value = 'Report'
        return true;
    }
    function AssignBillValue() {
        document.getElementById('hdnSnapshotType').value = 'Bill'
        return true;
    }
    
</script>

