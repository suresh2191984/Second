<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientDashBoard.aspx.cs"
    Inherits="Admin_PatientDashBoard" %>

<%@ Register Src="~/CommonControls/PatientSearch.ascx" TagName="PatientSearch" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/ReportDisplay.ascx" TagName="ReportDisplay" TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/MRDSnapShotView.ascx" TagName="SnapShot" TagPrefix="uc9" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Disease Burden & Distribution</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/mapper.js" type="text/javascript"></script>

    <script src="../Scripts/cvi_map_lib.js" type="text/javascript"></script>

    <style type="text/css">
        .GeoCalendar .ajax__calendar_container
        {
            border: 1px solid black;
            background-color: #FAF8CC;
            color: black;
        }
        .mapcolor
        {
            border: 1PX;
            background-color: #666666;
        }
    </style>

    <script type="text/javascript" src="mapper.js"></script>

    <script type="text/javascript" src="cvi_map_lib.js"></script>

    <script type="text/javascript" language="javascript">

        function AnimateGridview() {

            $(document).ready(function() {

                document.getElementById("divRightPane").style.display = "none";

                $("#divRightPane").slideDown('slow');


            });
        }
          
    </script>

    <script type="text/javascript" language="javascript">


        function GetPatientGeoReport(id) {

            var location = new Array('Prevalence of HIV among adults aged 15 to 49 (%)', 'Number of reported cases of tuberculosis', 'Number of reported case of Malarial diseases', '(DTP3) immunization coverage among 1-year-olds (%)', '(MCV) immunization coverage among 1-year-olds (%)', 'Births by caesarean section (%)', 'Number of Birth (M/F)', 'Number of Death (M/F)');


            document.getElementById('divRightPane').innerHTML = '';

            
            var rowno = 1;
            if (id != 'Karur') {
                if (id != 'Thiruvallur') {
                    if (id != 'Erode') {
                        if (id != 'Theni') {
                            if (id != 'Sivagangai') {
                                var tmpTable = '<table  CELLSPACING=0 CELLSPACING=0 style = "border: thin solid #000000;width:100%;"><tr><td colspan="2" align="center" style = "background: #FBBBBB;">' + id + '</td></tr><tr style = "background: 	#C47451;"><td colspan=2 align="left"><font Color="white"><b>Disease burden</b></font></td></tr>';


                                for (var i = 0; i < 8; i++) {

                                    //alert("array "+controlarray[i]);

                                    if (rowno == 1) {

                                        if (i == 3)
                                        { tmpTable += '<tr style = "background: #C47451;"><td colspan=2 align="left"><font Color="white"><b>Health care system delivery</b></font></td></tr>' }



                                        if (i == 6)
                                        { tmpTable += '<tr style = "background: #FFF8C6;"><td align="left">' + location[i] + '</td><td><b><font color="#C34A2C">' + Math.floor(Math.random() * 14) + '/' + Math.floor(Math.random() * 7) + '</font></b></td></tr>'; }
                                        else { tmpTable += '<tr style = "background: #ECE5B6;"><td align="left">' + location[i] + '</td><td><b><font color="#C34A2C">' + Math.floor(Math.random() * 11) + '</font></b></td></tr>'; }

                                        rowno = 2;
                                    } else {

                                        if (i == 3)
                                        { tmpTable += '<tr style = "background: #C47451;"><td colspan=2 align="left"><font Color="white"><b>Health care system delivery</b></font></td></tr>' }

                                        if (i == 7)
                                        { tmpTable += '<tr style = "background: #FFF8C6;"><td align="left">' + location[i] + '</td><td><b><font color="#C34A2C">' + Math.floor(Math.random() * 14) + '/' + Math.floor(Math.random() * 7) + '</font></b></td></tr>'; }
                                        else { tmpTable += '<tr style = "background: #ECE5B6;"><td align="left">' + location[i] + '</td><td><b><font color="#C34A2C">' + Math.floor(Math.random() * 11) + '</font></b></td></tr>'; }


                                        //tmpTable += '<tr style = "background: #FFF8C6;"><td align="left">' + location[i] + '</td><td><b><font color="#C34A2C">' + Math.floor(Math.random() * 14) + '</font></b></td></tr>';
                                        rowno = 1;
                                    }
                                }
                            }
                            else {
                                var tmpTable = '<table  CELLSPACING=0 CELLSPACING=0 style = "border: thin solid #000000;width:100%;"><tr><td colspan="2" align="center" style = "background: #FBBBBB;">' + id + '</td></tr><tr style = "background: 	#C47451;"><td colspan=2 align="left"><font Color="white"><b>No Data Available..</b></font></td></tr>';
                            }
                        }
                        else {
                            var tmpTable = '<table  CELLSPACING=0 CELLSPACING=0 style = "border: thin solid #000000;width:100%;"><tr><td colspan="2" align="center" style = "background: #FBBBBB;">' + id + '</td></tr><tr style = "background: 	#C47451;"><td colspan=2 align="left"><font Color="white"><b>No Data Available..</b></font></td></tr>';
                        }
                    }
                    else {
                        var tmpTable = '<table  CELLSPACING=0 CELLSPACING=0 style = "border: thin solid #000000;width:100%;"><tr><td colspan="2" align="center" style = "background: #FBBBBB;">' + id + '</td></tr><tr style = "background: 	#C47451;"><td colspan=2 align="left"><font Color="white"><b>No Data Available..</b></font></td></tr>';
                    }
                }
                else {
                    var tmpTable = '<table  CELLSPACING=0 CELLSPACING=0 style = "border: thin solid #000000;width:100%;"><tr><td colspan="2" align="center" style = "background: #FBBBBB;">' + id + '</td></tr><tr style = "background: 	#C47451;"><td colspan=2 align="left"><font Color="white"><b>No Data Available..</b></font></td></tr>';
                }
            }
            else {
                var tmpTable = '<table  CELLSPACING=0 CELLSPACING=0 style = "border: thin solid #000000;width:100%;"><tr><td colspan="2" align="center" style = "background: #FBBBBB;">' + id + '</td></tr><tr style = "background: 	#C47451;"><td colspan=2 align="left"><font Color="white"><b>No Data Available..</b></font></td></tr>';
            }
            tmpTable += '</table>';
            document.getElementById('divRightPane').innerHTML = tmpTable;
            AnimateGridview();

        }
        function HideTextBox(ddlId) {
            //debugger;
            var ControlName = document.getElementById(ddlCountry.id);
            var ControlddlState = 'ddlState';
            if (ControlName.value == 1)  //it depends on which value Selection do u want to hide or show your textbox
            {
                //document.getElementById('MyTextBox').style.display = 'none';

            }
            else {
                //document.getElementById('MyTextBox').style.display = '';

            }
        }
        function GetPatientGeoReport1(id) {

        }
    </script>

    <script language="javascript" type="text/javascript">
        function GetState() {
            var ControlddlState = document.getElementById('ddlState');
            if (document.getElementById('ddlCountry').options[document.getElementById('ddlCountry').selectedIndex].innerHTML == 'India') {
                var newListItem = document.createElement('OPTION');
                newListItem.text = 'TamilNadu';

                // newListItem.value = Textvalue.replace("<", "&lt;");
                //newListItem.value = Textvalue.replace(">", "&gt;");
                newListItem.value = '1';
                ControlddlState.add(newListItem);
            }
            else {
                if (ControlddlState.options.length > 1) {
                    ControlddlState.remove(1);
                }
            }
        }
        function ShowReport() {
            if (document.getElementById('ddlCountry').options[document.getElementById('ddlCountry').selectedIndex].innerHTML == 'India' &&
         document.getElementById('ddlState').options[document.getElementById('ddlState').selectedIndex].innerHTML == 'TamilNadu') {
                document.getElementById('prnReport').style.display = "block";
            }
            else {
                document.getElementById('prnReport').style.display = "none";
            }
        }
         function respConfirm() {
            // var response = confirm('This Informations are very credentials from ... Security, If you Open this page, Your Information Saved for Future Survey, Do You wwnt to Continue?');
             //OR var response = window.confirm('Confirm Test: Continue?');

            //if (!response) {
              //  return false;
             // }

             if (document.getElementById('ddlCountry').options[document.getElementById('ddlCountry').selectedIndex].innerHTML != 'India') {
                 alert('Choose Country name');
                 document.getElementById('ddlCountry').focus();
                 return false;
             }
             if (document.getElementById('ddlState').options[document.getElementById('ddlState').selectedIndex].innerHTML != 'TamilNadu') {
                 alert('Choose State name');
                 document.getElementById('ddlCountry').focus();
                 return false;
             }   
         }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
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
                <uc3:Header ID="RHead" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: none;">
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
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table id="tblCollectionOPIP" align="center" width="100%">
                            <tr align="center">
                                <asp:UpdatePanel ID="updatePanel1" runat="server">
                                    <ContentTemplate>
                                        <td align="center">
                                            <div class="dataheaderWider">
                                                <table id="tbl" border="0">
                                                    <tr>
                                                        <td align="left">
                                                            <table border="1" cellpadding="5">
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblCountry" Text="Country Name: " Font-Bold="True" runat="server"></asp:Label>
                                                                        <asp:DropDownList ID="ddlCountry" ToolTip="Select Country" runat="server" Width="250px"
                                                                            OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged" AutoPostBack="true">
                                                                            <%--    onchange="GetState(this.options[this.selectedIndex].value);"--%>
                                                                            <asp:ListItem Text="----Select----" Value="0" Selected="True"></asp:ListItem>
                                                                            <asp:ListItem Text="India" Value="1"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblState" Text="State Name: " Font-Bold="True" runat="server"></asp:Label>
                                                                        <asp:DropDownList ID="ddlState" ToolTip="Select Country" runat="server" Width="250px">
                                                                            <asp:ListItem Text="----Select----" Value="0" Selected="True"></asp:ListItem>
                                                                            <%-- <asp:ListItem Text="TamilNadu" Value="1"></asp:ListItem>--%>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="left">
                                                                        <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server"></asp:Label>
                                                                        <asp:TextBox ID="txtFDate" runat="server" Enabled="false" ReadOnly="true" Text="01/01/2010"></asp:TextBox>
                                                                        <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                                            PopupButtonID="ImgFDate" Enabled="True" PopupPosition="Left" />
                                                                        <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                            CausesValidation="False" Enabled="false" />
                                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                            CultureTimePlaceholder="" Enabled="True" />
                                                                        <%-- <ajc:maskededitvalidator id="MaskedEditValidator5" runat="server" controlextender="MaskedEditExtender5"
                                                                            controltovalidate="txtFDate" emptyvaluemessage="Date is required" invalidvaluemessage="Date is invalid"
                                                                            display="Dynamic" tooltipmessage="(dd-mm-yyyy)" emptyvalueblurredtext="*" invalidvalueblurredmessage="*"
                                                                            validationgroup="MKE" errormessage="MaskedEditValidator5"  />--%>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server"></asp:Label>
                                                                        <asp:TextBox ID="txtTDate" runat="server" Enabled="false" ReadOnly="true" Text="01/01/2012"></asp:TextBox>
                                                                        <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                                            PopupButtonID="ImgTDate" Enabled="True" />
                                                                        <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                            CausesValidation="False" Enabled="false" />
                                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                                            Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                            CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                            CultureTimePlaceholder="" Enabled="True" />
                                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                                            ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:Label ID="lbltype" Text="Report Type" runat="server"></asp:Label>
                                                                        <asp:RadioButton ID="rdoDuePaid" runat="server" GroupName="rdo" Text="Summary" Checked="True" />
                                                                        <asp:RadioButton ID="rdoDueList" runat="server" GroupName="rdo" Text="Detail" Enabled="false" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                            onmouseout="this.className='btn'" OnClick="btnSubmit_Click" OnClientClick="return respConfirm();"  />
                                                                        <%--OnClientClick="javascript:return ShowReport();"--%>
                                                                        <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                                            OnClick="lnkBack_Click"></asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            &nbsp
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                                                    <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server"></asp:Label>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                        </td>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </tr>
                            <tr align="center">
                                <td align="center">
                                    <div id="prnReport" style="display: none;" runat="server" width="100%">
                                        <table align="center" width="100%">
                                            <tr align="center">
                                                <td align="right">
                                                    <table width="100%" border="0">
                                                        <tr>
                                                            <td width="50%" style="padding-top: 20px;">
                                                                <img id="tnmap" src="../Images/TNDistrictMap.jpg" class="mapper" width="364" height="437"
                                                                    border="0" usemap="#Map" />
                                                                <map name="Map" id="Map">
                                                                    <area id="Thiruvallur" shape="poly" coords="310,6,317,8,323,10,329,13,332,18,333,24,332,27,330,32,327,34,323,34,320,38,320,42,316,42,310,43,302,42,298,45,295,48,290,43,289,41,288,39,287,35,282,30,280,29,276,30,272,35,268,35,264,33,260,34,257,38,254,36,251,34,257,30,260,26,260,23,265,20,267,21,273,22,276,24,282,22,286,23,291,21,294,21,299,18,301,15,304,12,307,10"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Thiruvallur')" alt="Thiruvallur" />
                                                                    <area shape="poly" coords="194,63,197,56,200,46,206,42,213,40,218,38,220,40,229,40,234,43,239,44,245,38,251,35,256,38,263,36,267,37,274,37,279,31,283,32,285,35,286,40,288,42,280,47,276,52,270,55,267,57,264,61,262,66,259,71,252,67,248,65,244,63,240,65,237,67,233,66,230,64,228,60,223,61,219,65,216,72,213,74,211,78,209,85,204,87,197,92,196,96,190,93,184,92,182,88,181,81,181,76,185,73,190,68"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Vellore')" alt="Vellore" />
                                                                    <area shape="poly" coords="278,63,285,67,282,71,278,77,284,81,286,90,282,95,280,98,287,98,293,103,295,106,301,108,308,102,314,93,320,85,321,75,326,66,324,56,327,48,323,47,317,45,309,43,303,44,297,47,292,48,285,44,279,49,270,55"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Kancheepuram')" alt="Kancheepuram" />
                                                                    <area shape="poly" coords="320,41,323,46,326,47,329,43,331,36,329,35,323,36" onclick="GetPatientGeoReport('Chennai')"
                                                                        class="noborder icolor7F525D" alt="Chennai" />
                                                                    <area shape="poly" coords="194,98,195,106,200,107,199,113,199,117,204,122,205,125,212,124,219,122,226,121,234,122,241,120,245,117,244,111,246,103,246,98,244,94,245,90,251,90,259,91,265,96,272,96,279,96,283,92,284,86,280,79,278,74,282,69,279,65,273,60,271,58,265,61,263,66,260,71,253,70,248,68,243,65,235,67,231,66,229,62,223,63,219,68,213,75,210,81,209,84,205,89,199,91,194,95"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Thiruvannamalai')"
                                                                        alt="Thiruvannamalai" />
                                                                    <area shape="poly" coords="203,126,205,133,203,136,200,136,200,140,199,146,197,149,200,153,203,150,210,152,210,157,214,163,218,163,224,156,229,159,237,157,247,154,255,152,261,148,261,141,265,138,270,137,277,139,283,136,288,128,294,124,298,116,303,110,297,106,291,101,282,97,270,97,262,97,258,91,254,91,246,92,246,98,247,102,246,110,246,117,243,119,239,122,235,122,231,120,223,122,218,122,214,123,205,123"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Villupuram')" alt="Villupuram" />
                                                                    <area shape="poly" coords="178,77,171,71,164,69,162,65,159,63,156,61,153,59,148,57,146,60,142,57,136,55,133,56,130,61,129,67,125,71,121,71,117,69,113,71,113,78,115,83,117,86,116,92,113,96,111,100,110,103,107,104,107,108,112,109,118,109,123,110,131,114,127,110,133,107,136,104,137,101,143,99,144,97,146,92,141,88,145,86,149,87,153,88,155,90,159,92,160,93,161,97,165,101,167,103,171,104,176,106,176,108,177,111,181,110,184,111,187,113,191,110,194,110,194,106,194,103,194,100,189,96,186,94,184,92,182,87,180,84,178,80"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Krishnagiri')" alt="Krishnagiri" />
                                                                    <area shape="poly" coords="129,117,124,122,122,128,123,132,128,133,135,134,140,135,146,134,152,132,159,130,164,128,168,131,170,132,175,133,176,136,174,139,180,137,184,140,187,141,193,139,198,138,203,135,205,131,203,126,203,124,201,121,199,117,198,113,198,111,194,110,191,111,186,112,182,112,178,112,176,109,172,107,168,104,165,104,159,100,159,97,158,95,157,93,154,92,151,90,148,89,144,88,143,90,145,96,142,99,138,101,134,103,133,106,131,109,131,112,129,114"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Dharmapuri')" alt="Dharmapuri" />
                                                                    <area shape="poly" coords="122,130,122,138,120,141,123,144,123,148,123,150,125,154,128,152,129,156,128,158,127,161,125,166,127,170,131,169,137,170,142,169,145,167,148,165,155,164,159,161,167,161,176,161,181,159,183,161,183,164,181,169,187,172,188,176,195,177,200,177,200,172,204,170,207,170,210,172,211,168,213,165,210,161,209,157,207,154,202,154,198,155,197,149,199,146,197,143,200,139,193,141,185,140,178,140,172,142,174,138,172,133,169,131,165,131,161,129,154,131,147,134,141,134,134,133,125,129,122,133"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Salem')" alt="Salem" />
                                                                    <area shape="poly" coords="217,165,220,172,225,174,232,172,234,174,239,176,245,175,250,174,255,173,258,176,261,179,264,182,266,186,266,191,269,189,273,187,276,182,282,180,287,177,292,175,291,169,287,164,286,157,286,151,287,146,287,142,289,139,290,130,288,128,282,136,281,140,274,140,269,138,264,138,260,143,262,147,255,153,249,154,241,157,235,158,232,158,229,159,223,159,222,159,219,162"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Cuddalore')" alt="Cuddalore" />
                                                                    <area shape="poly" coords="212,166,212,173,206,172,203,173,201,179,205,182,204,188,202,191,204,195,206,200,209,196,213,198,221,198,223,198,227,201,228,204,226,207,225,209,229,213,232,210,240,211,245,207,251,204,258,200,262,195,266,190,265,183,261,179,254,174,248,175,240,176,234,174,228,173,222,171,218,168,212,163"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Perambalur')" alt="Perambalur" />
                                                                    <area shape="poly" coords="126,167,122,172,126,179,131,185,136,186,137,195,137,200,143,198,150,197,156,200,160,203,165,198,171,199,175,201,175,193,178,188,181,183,182,176,181,172,181,167,179,163,173,162,164,163,156,163,149,166,142,168,137,170,132,169,128,168"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Namakkal')" alt="Namakkal" />
                                                                    <area shape="poly" coords="182,170,181,179,181,185,178,190,175,195,174,200,168,198,164,201,161,207,165,210,172,210,181,209,182,211,188,215,192,218,191,223,187,227,182,229,179,229,172,229,170,235,168,240,168,243,162,245,167,248,171,249,171,254,173,262,178,258,181,256,188,255,189,248,192,246,187,243,185,237,184,233,187,230,192,231,195,229,196,229,199,229,205,227,208,231,215,229,216,222,213,219,210,218,216,215,223,214,225,212,223,210,227,205,224,202,223,199,213,199,209,199,204,196,199,191,202,188,204,185,203,181,198,178,194,177,189,174,181,171,181,176"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Tiruchirappalli')"
                                                                        alt="Tiruchirappalli" />
                                                                    <area shape="poly" coords="121,132,114,130,107,131,105,136,103,141,101,146,95,144,90,142,85,142,80,141,74,145,72,144,65,141,58,144,56,149,56,155,58,159,66,161,69,164,69,169,69,172,74,175,81,176,85,179,88,181,93,183,96,180,100,186,100,189,100,195,104,197,106,200,107,206,101,210,96,213,92,219,94,225,100,233,102,235,106,236,113,232,120,230,125,228,123,233,131,230,131,223,133,220,132,215,128,213,126,209,129,204,129,200,133,201,137,199,135,190,130,183,128,180,126,177,124,174,123,170,123,166,125,163,126,158,126,154,124,151,124,146,122,141,121,138,121,132"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Erode')" alt="Erode" />
                                                                    <area shape="poly" coords="56,160,46,158,36,157,33,153,30,150,24,151,22,152,21,155,17,156,13,157,8,158,8,164,9,167,15,169,22,170,24,172,29,175,31,179,29,182,26,184,24,190,32,190,38,191,44,188,50,185,55,184,58,177,62,175,66,176,72,175,69,174,67,170,68,166,65,162,61,161,58,161"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Nilgiri')" alt="Nilgiri" />
                                                                    <area shape="poly" coords="45,187,43,193,46,197,49,201,44,204,42,207,40,213,43,212,47,215,54,217,57,219,60,223,59,227,59,233,56,233,53,234,56,240,55,244,55,250,57,256,56,262,58,264,63,267,69,265,72,262,80,261,85,258,87,260,89,263,93,264,91,255,89,252,96,250,99,245,98,241,97,235,100,233,97,230,93,226,90,221,96,217,100,211,104,209,107,205,102,198,100,195,98,190,96,184,92,183,85,180,76,175,72,176,62,177,57,180,53,184,41,187"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Coimbatore')" alt="Coimbatore" />
                                                                    <area shape="poly" coords="131,232,136,233,141,235,145,234,148,229,147,226,145,224,152,223,155,222,159,218,160,223,158,228,158,232,158,238,161,239,163,242,164,245,166,248,169,250,169,255,173,258,173,260,171,263,171,269,168,273,166,276,165,277,161,273,158,270,154,269,149,270,146,274,140,275,136,278,129,281,126,282,124,276,123,273,119,270,115,268,110,268,108,270,103,273,100,273,93,273,91,273,91,269,92,265,96,262,94,257,93,253,92,251,98,250,101,246,98,242,96,236,102,236,108,238,112,234,117,232,122,233,126,235,128,233"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Dindigul')" alt="Dindigul" />
                                                                    <area shape="poly" coords="270,189,269,196,268,201,268,206,267,209,272,209,276,206,281,204,288,205,294,204,296,199,295,196,296,191,295,186,293,183,294,179,293,176,292,175,290,177,286,180,281,181,275,184,271,188,268,190"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Nagapattinam')" alt="Nagapattinam" />
                                                                    <area shape="poly" coords="216,230,221,231,223,231,227,228,233,233,234,235,238,239,241,242,239,247,239,251,238,255,237,259,240,263,242,267,245,270,249,265,254,262,259,259,262,256,263,250,260,242,257,238,254,235,251,232,250,229,252,225,253,222,251,219,249,215,252,212,258,213,262,215,267,213,268,208,267,203,268,199,269,195,269,192,266,192,262,194,260,198,256,201,250,203,245,208,238,210,232,211,226,211,225,209,220,210,216,214,211,218,214,221,217,225,213,229"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Thanjavur')" alt="Thanjavur" />
                                                                    <area shape="poly" coords="293,219,288,213,285,210,287,205,281,201,276,207,271,211,264,214,260,214,255,214,251,215,253,221,251,225,250,229,255,235,258,239,261,243,263,248,265,252,266,258,268,258,273,260,279,262,284,262,287,261,281,255,277,250,277,245,278,242,282,240,283,236,280,232,282,229,285,225,289,225,294,221,295,218"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Thiruvarur')" alt="Thiruvarur" />
                                                                    <area shape="poly" coords="279,250,281,259,288,262,295,262,296,256,296,252,296,246,296,240,296,235,295,230,293,224,293,222,288,223,282,227,281,229,279,233,282,240,279,241,276,244,278,252,280,255,283,262"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Nagapattinam')" alt="Nagapattinam" />
                                                                    <area shape="poly" coords="117,270,110,271,106,273,103,275,99,275,94,275,89,274,84,275,86,281,89,287,87,290,86,294,86,297,86,302,84,308,83,312,83,314,85,317,90,318,94,317,97,320,97,322,104,320,108,317,113,312,111,308,114,305,117,299,119,294,121,291,123,287,125,282,123,277,123,274,120,271"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Theni')" alt="Theni" />
                                                                    <area shape="poly" coords="173,262,171,268,167,274,165,276,160,274,157,271,152,271,147,274,141,279,135,280,130,282,127,283,125,288,122,292,118,298,116,302,114,304,114,310,116,310,119,308,127,307,127,310,133,314,139,314,146,313,152,310,155,302,159,300,156,295,163,293,167,292,174,291,178,287,182,285,181,281,180,275,177,270,177,266,174,262"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Madurai')" alt="Madurai" />
                                                                    <area shape="poly" coords="186,236,187,244,190,246,193,250,189,253,186,258,187,260,187,262,185,263,185,268,187,270,190,265,194,262,199,265,201,269,206,272,210,268,212,270,215,272,218,274,223,274,223,277,220,281,225,285,228,289,221,290,218,292,221,295,227,294,230,297,232,298,238,291,243,287,245,283,245,279,243,275,241,269,238,263,235,256,238,251,239,248,241,245,240,241,238,235,234,232,231,231,227,228,221,230,216,231,213,233,209,234,204,230,199,229,195,230,190,233,186,234"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Pudukkottai')" alt="Pudukkottai" />
                                                                    <area shape="poly" coords="182,277,183,284,180,288,176,290,171,291,168,295,163,297,160,297,158,300,157,304,163,304,172,306,173,310,177,313,180,315,184,315,189,317,194,318,198,321,204,318,208,316,211,316,208,312,205,310,202,308,202,304,208,303,211,304,216,303,215,299,216,296,218,293,222,292,226,288,224,285,221,280,223,277,216,273,213,272,210,270,206,270,202,269,198,266,196,264,190,263,189,268,184,268,185,263,186,260,184,257,182,256,176,255,175,260,178,266,176,270,181,276"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Sivagangai')" alt="Sivagangai" />
                                                                    <area shape="poly" coords="111,313,108,319,102,323,98,326,97,331,102,334,107,338,111,335,116,338,119,340,127,343,134,345,140,347,146,344,152,340,157,337,164,337,169,339,174,341,172,334,169,332,166,329,172,326,177,320,178,316,175,311,171,307,167,304,164,304,160,301,155,303,152,307,145,310,142,313,139,313,135,313,131,312,130,311,126,310,124,309,121,309,117,310,113,308"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Virudhunagar')" alt="Virudhunagar" />
                                                                    <area shape="poly" coords="95,333,91,342,90,347,89,351,85,358,82,360,81,362,84,369,86,373,89,377,86,382,84,385,84,392,88,396,90,400,97,401,101,404,105,409,109,413,113,419,112,425,112,431,116,431,121,431,130,428,134,423,137,420,143,419,136,412,133,407,131,403,127,396,131,390,131,382,133,378,130,375,127,372,123,370,122,365,122,362,124,360,122,357,120,354,122,350,128,350,133,349,135,347,131,345,127,343,121,343,119,342,116,340,112,335,110,338,107,337,103,335,98,334,95,332"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Tirunelveli')" alt="Tirunelveli" />
                                                                    <area shape="poly" coords="90,401,86,403,82,409,82,412,82,415,82,417,80,419,76,421,76,424,80,427,84,429,88,434,94,436,101,436,109,435,114,432,113,426,112,423,112,418,108,414,104,410,101,406,97,403,93,400"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Kanniyakumari')"
                                                                        alt="Kanniyakumari" />
                                                                    <area shape="poly" coords="170,341,163,339,157,339,152,343,149,346,144,348,137,349,133,350,125,352,122,354,123,358,125,363,122,368,128,370,131,374,132,384,132,386,131,396,130,399,134,405,137,412,140,416,144,418,149,414,153,407,155,404,157,398,157,392,156,385,159,380,160,375,159,371,164,366,167,364,171,360,175,358,173,354,170,352,168,347,169,343"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Tuticorn')" alt="Tuticorn" />
                                                                    <area shape="poly" coords="175,357,181,356,186,353,192,355,200,352,204,349,209,347,214,344,221,343,230,343,236,342,231,338,224,334,221,330,219,328,221,324,219,317,225,312,230,307,233,302,234,297,227,296,219,294,215,299,216,305,205,304,200,306,205,314,206,318,199,319,197,321,194,318,190,317,187,317,182,317,177,318,175,322,174,328,169,330,170,336,171,340,171,345,170,349,176,353,175,354"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Ramanathapuram')"
                                                                        alt="Ramanathapuram" />
                                                                    <area shape="poly" coords="133,217,129,211,126,208,129,204,133,200,137,200,141,199,147,197,153,197,156,200,160,203,161,206,165,208,167,211,172,211,178,210,183,210,187,215,189,217,191,218,190,223,188,228,183,229,178,230,174,230,171,233,168,236,167,241,165,244,163,241,159,235,160,230,158,224,159,220,156,220,153,223,150,223,147,224,150,229,147,232,146,236,142,235,139,234,135,235,133,231,134,227,132,223"
                                                                        class="noborder icolor7F525D" onclick="GetPatientGeoReport('Karur')" alt="Karur" />
                                                                </map>
                                                            </td>
                                                            <td align="left" valign="top">
                                                                <table>
                                                                    <tr>
                                                                        <td align="left" style="font-family: Arial; color: Purple; font-size: larger; font-weight: bold;">
                                                                            Disease Burden & Health Data Distribution - TamilNadu
                                                                        </td>
                                                                        <td align="left" valign="top">
                                                                            &nbsp;
                                                                        </td>
                                                                    </tr>                                                                    
                                                                    <tr>
                                                                        <td valign="top">
                                                                            <div id="divTopPane">
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td height="10px">
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td valign="middle">
                                                                            <div id="divRightPane" align="Left">
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
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
