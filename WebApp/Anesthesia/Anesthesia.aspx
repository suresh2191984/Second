<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Anesthesia.aspx.cs" Inherits="Anesthesia_Anesthesia" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<%@ Register Src="../CommonControls/Advice.ascx" TagName="AdviceControl" TagPrefix="uc7" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="Task" TagPrefix="uc8" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc13" %>
<%@ Register Src="../CommonControls/GeneralAdvice.ascx" TagName="GeneralAdv" TagPrefix="uc9" %>
<%@ Register Src="~/CommonControls/IpDrugEntry.ascx" TagName="Adv" TagPrefix="uc11" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat='server'>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Anesthesia Notes</title>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <style type="text/css">
        #tbAddProc
        {
            width: 101%;
        }
        .style2
        {
            width: 147px;
        }
        .style7
        {
            width: 112px;
            height: 42px;
        }
        .style8
        {
            width: 231px;
            height: 40px;
        }
        .style10
        {
            height: 44px;
        }
        .style12
        {
            width: 112px;
            height: 40px;
        }
        .style15
        {
            height: 34px;
        }
        .style17
        {
            height: 38px;
        }
        .style18
        {
            height: 37px;
        }
        .style19
        {
            height: 40px;
        }
        .style20
        {
            height: 42px;
        }
    </style>

    <script type="text/javascript" language="javascript">
        function AddDataToDataTable() {
            //debugger;
            var rows = '';

            var rowcount = document.getElementById('tblCapturedData').rows.length;

            var row = document.getElementById('tblCapturedData').insertRow(rowcount);

            // row.id = e.options[e.options.selectedIndex].value;

            var cell1 = row.insertCell(0);

            var cell2 = row.insertCell(1);

            var cell3 = row.insertCell(2);

            var cell4 = row.insertCell(3);

            var cell5 = row.insertCell(4);

            var cell6 = row.insertCell(5);
            var cell7 = row.insertCell(6);
            var cell8 = row.insertCell(7);
            var cell9 = row.insertCell(8);
            var cell10 = row.insertCell(9);
            var cell11 = row.insertCell(10);

            var d = new Date();

            cell1.innerHTML = d.getDate() + "-" + d.getMonth() + "/" + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();

            cell1.width = 100;


            cell2.innerHTML = document.getElementById("txtStage").value;

            cell2.width = 50;

            cell2.align = 'left';


            //            cell12.innerHTML = document.getElementById("lblvitals1").value;

            //            cell12.width = 60;

            //            cell12.align = 'left';
            cell3.innerHTML = document.getElementById("txtHR").value;

            cell3.width = 60;

            cell3.align = 'left';

            cell4.innerHTML = document.getElementById("txtrythm").value;

            cell4.width = 100;

            cell4.align = 'left';

            cell5.innerHTML = document.getElementById("txtABP").value;

            cell5.width = 100;

            cell5.align = 'left';

            cell6.innerHTML = document.getElementById("txtMAP").value;

            cell6.width = 100;

            cell6.align = 'left';

            cell7.innerHTML = document.getElementById("txtCVP").value;

            cell7.width = 100;

            cell7.align = 'left';


            cell8.innerHTML = document.getElementById("txtPCWP").value;

            cell8.width = 100;

            cell8.align = 'left';

            cell9.innerHTML = document.getElementById("txtRR").value;

            cell9.width = 100;

            cell9.align = 'left';

            cell10.innerHTML = document.getElementById("txtSa02").value;

            cell10.width = 100;

            cell10.align = 'left';
            cell11.innerHTML = document.getElementById("txtTemp").value;

            cell11.width = 100;

            cell11.align = 'left';

            document.getElementById("txtStage").value = "";

            document.getElementById("txtrythm").value = "";

            document.getElementById("txtABP").value = "";

            document.getElementById("txtCVP").value = "";

            document.getElementById("txtPCWP").value = "";
            //
            document.getElementById("txtRR").value = "";
            document.getElementById("txtSa02").value = "";

            document.getElementById("txtTemp").value = "";
            var v1 = document.getElementById("lblvitals1").innerHTML;
            var v2 = document.getElementById("lblvitals2").innerHTML;
            var v3 = document.getElementById("lblvitals3").innerHTML;
            var v4 = document.getElementById("lblvitals4").innerHTML;
            var v5 = document.getElementById("lblvitals5").innerHTML;
            var v6 = document.getElementById("lblvitals6").innerHTML;
            var v7 = document.getElementById("lblvitals7").innerHTML;
            var v8 = document.getElementById("lblvitals8").innerHTML;
            var v9 = document.getElementById("lblvitals9").innerHTML;

            var u1 = document.getElementById("lblunits1").innerHTML;
            var u2 = document.getElementById("lblunits2").innerHTML;
            var u3 = document.getElementById("lblunits3").innerHTML;
            var u4 = document.getElementById("lblunits4").innerHTML;
            var u5 = document.getElementById("lblunits5").innerHTML;
            var u6 = document.getElementById("lblunits6").innerHTML;
            var u7 = document.getElementById("lblunits7").innerHTML;
            var u8 = document.getElementById("lblunits8").innerHTML;
            var u9 = document.getElementById("lblunits9").innerHTML;
            // lblunits1

            document.getElementById("hdnRecords").value = document.getElementById("hdnRecords").value + "^" + v1 + "_" + u1 + "_" + cell3.innerHTML + "~" + v2 + "_" + u2 + "_" + cell4.innerHTML + "~" + v3 + "_" + u3 + "_" + cell5.innerHTML + "~" + v4 + "_" + u4 + "_" + cell6.innerHTML + "~" + v5 + "_" + u5 + "_" + cell7.innerHTML + "~" + v6 + "_" + u6 + "_" + cell8.innerHTML + "~" + v8 + "_" + u8 + "_" + cell9.innerHTML + "~" + v9 + "_" + u9 + "_" + cell10.innerHTML + "~" + cell11.innerHTML;

            document.getElementById('tblCapturedData').style.display = "block";
        }


        function AddDataToDataTableBlood() {
         

            var rows = '';

            var rowcount = document.getElementById('tblBloodGas').rows.length;

            var row = document.getElementById('tblBloodGas').insertRow(rowcount);

            // row.id = e.options[e.options.selectedIndex].value;

            var cell1 = row.insertCell(0);

            var cell2 = row.insertCell(1);

            var cell3 = row.insertCell(2);

            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);

            var cell6 = row.insertCell(5);




            var d = new Date();

            cell1.innerHTML = d.getDate() + "-" + d.getMonth() + "/" + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();

            cell1.width = 100;


            cell2.innerHTML = document.getElementById("txtPH").value;

            cell2.width = 50;

            cell2.align = 'left';

            cell3.innerHTML = document.getElementById("txtPCo2").value;

            cell3.width = 60;

            cell3.align = 'left';


            cell4.innerHTML = document.getElementById("txtPo2").value;

            cell4.width = 60;

            cell4.align = 'left';

            cell5.innerHTML = document.getElementById("txtHCo3").value;

            cell5.width = 100;

            cell5.align = 'left';

            cell6.innerHTML = document.getElementById("txtBE").value;

            cell6.width = 100;

            cell6.align = 'left';



            document.getElementById("txtPH").value = "";

            document.getElementById("txtPCo2").value = "";
            document.getElementById("txtPo2").value = "";


            document.getElementById("txtHCo3").value = "";

            document.getElementById("txtBE").value = "";

            var v1 = document.getElementById("lblGasvitals1").innerHTML;
            var v2 = document.getElementById("lblGasvitals2").innerHTML;
            var v3 = document.getElementById("lblGasvitals3").innerHTML;
            var v4 = document.getElementById("lblGasvitals4").innerHTML;
            var v5 = document.getElementById("lblGasvitals5").innerHTML;



            var u1 = document.getElementById("lblgasunits1").innerHTML;
            var u2 = document.getElementById("lblgasunits2").innerHTML;
            var u3 = document.getElementById("lblgasunits3").innerHTML;
            var u4 = document.getElementById("lblgasunits4").innerHTML;
            var u5 = document.getElementById("lblgasunits5").innerHTML;


            document.getElementById("hdnRecordsBloodGas").value = document.getElementById("hdnRecordsBloodGas").value + "^" + v1 + "_" + u1 + "_" + cell2.innerHTML + "~" + v2 + "_" + u2 + "_" + cell3.innerHTML + "~" + v3 + "_" + u3 + "_" + cell4.innerHTML + "~" + v4 + "_" + u4 + "_" + cell5.innerHTML + "~" + v5 + "_" + u5 + "_" + cell6.innerHTML;

            document.getElementById('tblBloodGas').style.display = "block";
        }

        function AddDataToDataTableVentilator() {
          
            var rows = '';

            var rowcount = document.getElementById('tblVentilator').rows.length;

            var row = document.getElementById('tblVentilator').insertRow(rowcount);



            var cell1 = row.insertCell(0);

            var cell2 = row.insertCell(1);

            var cell3 = row.insertCell(2);

            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            var cell7 = row.insertCell(6);



            var d = new Date();

            cell1.innerHTML = d.getDate() + "-" + d.getMonth() + "/" + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();

            cell1.width = 100;


            cell2.innerHTML = document.getElementById("txtTidlevalue").value;

            cell2.width = 50;

            cell2.align = 'left';

            cell3.innerHTML = document.getElementById("txtRRVentilator").value;

            cell3.width = 60;

            cell3.align = 'left';

            cell4.innerHTML = document.getElementById("txtpeep").value;

            cell4.width = 100;

            cell4.align = 'left';

            cell5.innerHTML = document.getElementById("txtFi02").value;

            cell5.width = 100;

            cell5.align = 'left';

            cell6.innerHTML = document.getElementById("txtinspiratory").value;

            cell6.width = 100;

            cell6.align = 'left';

            cell7.innerHTML = document.getElementById("txtIE").value;

            cell7.width = 100;

            cell7.align = 'left';


            document.getElementById("txtTidlevalue").value = "";

            document.getElementById("txtRRVentilator").value = "";

            document.getElementById("txtpeep").value = "";

            document.getElementById("txtIE").value = "";
            document.getElementById("txtFi02").value = "";

            document.getElementById("txtinspiratory").value = "";


            var v1 = document.getElementById("lblvitalsventilator1").innerHTML;
            var v2 = document.getElementById("lblvitalsventilator2").innerHTML;
            var v3 = document.getElementById("lblvitalsventilator3").innerHTML;
            var v4 = document.getElementById("lblvitalsventilator4").innerHTML;
            var v5 = document.getElementById("lblvitalsventilator5").innerHTML;
            var v6 = document.getElementById("lblvitalsventilator6").innerHTML;



            var u1 = document.getElementById("lblventilatorunits1").innerHTML;
            var u2 = document.getElementById("lblventilatorunits2").innerHTML;
            var u3 = document.getElementById("lblventilatorunits3").innerHTML;
            var u4 = document.getElementById("lblventilatorunits4").innerHTML;
            var u5 = document.getElementById("lblventilatorunits5").innerHTML;
            var u6 = document.getElementById("lblventilatorunits6").innerHTML;


            document.getElementById("hdnventilator").value = document.getElementById("hdnventilator").value + "^" + v1 + "_" + u1 + "_" + cell2.innerHTML + "~" + v2 + "_" + u2 + "_" + cell3.innerHTML + "~" + v3 + "_" + u3 + "_" + cell4.innerHTML + "~" + v4 + "_" + u4 + "_" + cell5.innerHTML + "~" + v5 + "_" + u5 + "_" + cell6.innerHTML + "~" + v6 + "_" + u6 + "_" + cell7.innerHTML;

            document.getElementById('tblVentilator').style.display = "block";
        }




        function ShowHideComplications(ChkID) {
            //debugger;


            var trid = "_tr" + ChkID;

            if (document.getElementById(ChkID).checked == true) {
                document.getElementById(trid).style.display = 'block';
            }
            else {
                document.getElementById(trid).style.display = 'none';
            }
        }
        function expandBox(id) {
            document.getElementById(id).rows = "5";
        }
        function collapseBox(id) {
            document.getElementById(id).rows = "1";
        }

        function NewCal1(imgID) {
            var str = imgID.split('_');
            NewCal(str[0] + '_' + str[1] + '_' + 'txtFDate', 'ddmmyyyy', true, 12);
        }
        function NewCal2(imgID) {
            var str = imgID.split('_');
            NewCal(str[0] + '_' + str[1] + '_' + 'txtTDate', 'ddmmyyyy', true, 12);
        }
        function SplitTime(btnID) {
            var str = btnID.split('_');
            var txtT = str[0] + '_' + str[1] + '_' + 'txtTDate';
            var txtF = str[0] + '_' + str[1] + '_' + 'txtFDate';
            document.getElementById(txtT).value = '';
            document.getElementById(txtF).value = '';
            return false;
        }
        
    </script>

</head>
<body oncontextmenu="return false">
    <form id="form2" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
        </Services>
    </asp:ScriptManager>
    <div style="display: none;">
        <t1:Theme ID="Theme1" runat="server" />
    </div>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc3:PatientHeader ID="patientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: none;">
                    <div id="navigation">
                        <uc13:LeftMenu ID="LeftMenu1" runat="server" />
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
                                <td align="right">
                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="details_label_age" meta:resourcekey="LinkButton1Resource1"
                                        Text="Home&amp;nbsp;&amp;nbsp;&amp;nbsp;"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <table cellpadding="0" runat="server" cellspacing="0" border="0" id="tblDischrageResult"
                            style="display: block;" class="defaultfontcolor">
                            <tr class="defaultfontcolor">
                                <td style="font-weight: bold; height: 20px; color: #000; font-size: 15px" align="center"
                                    colspan="4">
                                    <asp:Label ID="lbltext" Text="Anesthesia Record" runat="server" Font-Bold="true"></asp:Label>
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
                                <td class="style15">
                                    <strong>Name:</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td class="style15">
                                    <asp:Label ID="lblname" runat="server">
                                    </asp:Label>
                                </td>
                                <td align="left" class="style15">
                                    <strong>Patient Number : </strong>
                                </td>
                                <td class="style15">
                                    <asp:Label ID="lblPatientNumber" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr id="traddress" runat="server">
                                <td class="style10">
                                    Age/Sex&nbsp;&nbsp; :
                                </td>
                                <td class="style10">
                                    <asp:Label ID="lblAge" runat="server"></asp:Label>
                                </td>
                                <td align="left" class="style10">
                                    IP/NO:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td class="style10">
                                    <asp:Label ID="lblIPNo" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr id="tr1" runat="server">
                                <td class="style18">
                                    Operating Diagnosis :&nbsp;&nbsp; :
                                </td>
                                <td class="style18">
                                    <asp:Label ID="lbldignosis" runat="server"></asp:Label>
                                </td>
                                <td align="left" class="style18">
                                    Bed NO:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td class="style18">
                                    <asp:Label ID="lblRoomNo" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr id="tr2" runat="server">
                                <td class="style17">
                                    Surgery Type :&nbsp;&nbsp;
                                </td>
                                <td class="style17">
                                    <asp:Label ID="lblsurgeryname" runat="server"></asp:Label>
                                </td>
                                <td align="left" class="style17">
                                    Consultant Physician:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </td>
                                <td class="style17">
                                    <asp:Label ID="lblConsultant" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="style19">
                                    Consultant Surgeon&nbsp;&nbsp;:
                                </td>
                                <td class="style12">
                                    <asp:Label ID="lblSurgeon" runat="server"></asp:Label>
                                </td>
                                <td class="style19">
                                    Anesthetist-In-Charge&nbsp;&nbsp;&nbsp;:
                                </td>
                                <td class="style8">
                                    <asp:DropDownList ID="DDLanesthesiologist" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="style20">
                                    Time of Anesthesia&nbsp;&nbsp;:
                                </td>
                                <td align="left">
                                    <asp:TextBox runat="server" ID="txtFromTime" MaxLength="25" size="25"></asp:TextBox>
                                    <a href="javascript:NewCal('<%=txtFromTime.ClientID %>','ddmmyyyy',true,12)">
                                        <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                                <td class="style20">
                                    Time Of Surgery&nbsp;&nbsp;&nbsp;:
                                </td>
                                <td class="style20">
                                    <asp:Label ID="lbltimeofsurgery" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="style19">
                                    Select Anesthesia Type:
                                </td>
                                <td class="style19">
                                    <asp:DropDownList ID="DDLAnesthesiaType" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td class="style19">
                                    NPO Duration:
                                </td>
                                <td class="style19">
                                    <asp:TextBox ID="txtNPODuration" runat="server"></asp:TextBox>Hours
                                </td>
                            </tr>
                            <tr>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lblAnesthesiaNotes" runat="server" Text="Anesthesia Notes"></asp:Label>
                                </td>
                                <td colspan="2" class="style21">
                                    <FCKeditorV2:FCKeditor ID="fckAnesthesiaNotes" runat="server" Width="100%" Height="150px">
                                    </FCKeditorV2:FCKeditor>
                                </td>
                            </tr>
                        </table>
                        <div>
                            <table>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lnkVitals" Text="Vitals Monitoring" runat="server" Style="color: Black;
                                            text-decoration: underline;"></asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                            <ajc:ModalPopupExtender ID="mpe" runat="server" TargetControlID="lnkVitals" PopupControlID="pnlvitals"
                                DropShadow="True" BackgroundCssClass="modalBackground" OkControlID="CloseButton"
                                DynamicServicePath="" Enabled="True" />
                            <asp:Panel ID="pnlvitals" runat="server" CssClass="modalPopup" Width="1100px" Height="70px">
                                <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <table runat="server">
                                            <tr align="left">
                                                <td align="left">
                                                    Stage:
                                                    <asp:TextBox ID="txtStage" runat="server" Width="90px"></asp:TextBox>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblvitals1" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtHR" runat="server" Width="58px"></asp:TextBox>
                                                    <asp:Label ID="lblunits1" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblvitals2" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtrythm" runat="server" Width="45px"></asp:TextBox>
                                                    <asp:Label ID="lblunits2" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblvitals3" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtABP" runat="server" Width="40px"></asp:TextBox>
                                                    <asp:Label ID="lblunits3" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblvitals4" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtMAP" runat="server" Width="40px"></asp:TextBox>
                                                    <asp:Label ID="lblunits4" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblvitals5" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtCVP" runat="server" Width="50px"></asp:TextBox>
                                                    <asp:Label ID="lblunits5" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblvitals6" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtPCWP" runat="server"></asp:TextBox>
                                                    <asp:Label ID="lblunits6" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblvitals7" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtRR" runat="server"></asp:TextBox>
                                                    <asp:Label ID="lblunits7" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblvitals8" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtSa02" runat="server"></asp:TextBox>
                                                    <asp:Label ID="lblunits8" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblvitals9" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtTemp" runat="server" Width="36px"></asp:TextBox>
                                                    <asp:Label ID="lblunits9" runat="server"></asp:Label>
                                                </td>
                                                <td align="center">
                                                    <asp:Button ID="OKButton" runat="server" Text="Add" OnClientClick="javascript:AddDataToDataTable()"
                                                        OnClick="OKButton_Click" Width="82px" />
                                                </td>
                                                <td align="center">
                                                    <asp:Button ID="CloseButton" runat="server" Text="Close" OnClick="OKButton_Click"
                                                        Width="88px" />
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </asp:Panel>
                        </div>
                        <div>
                            <table id="tblCapturedData" border="0" runat="server" cellpadding="0" class="dataheaderCtrl"
                                cellspacing="20" style="text-align: left; display: none; padding-left: 60; color: Black"
                                width="100%">
                                <tr id="Tr3" runat="server">
                                    <th id="Th1" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        Captured Date/Time
                                    </th>
                                    <th id="Th2" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        Stage
                                    </th>
                                    <th id="Th3" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        HR
                                    </th>
                                    <th id="Th4" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        Rythm
                                    </th>
                                    <th id="Th5" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        ABP
                                    </th>
                                    <th id="Th6" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        MAP
                                    </th>
                                    <th id="Th7" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        CVP
                                    </th>
                                    <th id="Th8" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        PCWP
                                    </th>
                                    <th id="Th9" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        RR
                                    </th>
                                    <th id="Th10" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        Sa02
                                    </th>
                                    <th id="Th11" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        Temp
                                    </th>
                                </tr>
                            </table>
                        </div>
                        <div>
                            <table>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lnkBloodGas" Text="Blood Gas Monitoring" runat="server" Style="color: Black;
                                            text-decoration: underline;"></asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                            <ajc:ModalPopupExtender ID="MPEBloodGas" runat="server" TargetControlID="lnkBloodGas"
                                PopupControlID="pnlBloodGas" DropShadow="True" BackgroundCssClass="modalBackground"
                                OkControlID="CloseButton" DynamicServicePath="" Enabled="True" />
                            <asp:Panel ID="pnlBloodGas" runat="server" CssClass="modalPopup" Width="1100px" Height="70px">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <table id="Table1" runat="server">
                                            <tr align="left">
                                                <td align="left">
                                                    <asp:Label ID="lblGasvitals1" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtPH" runat="server" Width="90px"></asp:TextBox>
                                                    <asp:Label ID="lblgasunits1" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblGasvitals2" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtPCo2" runat="server" Width="58px"></asp:TextBox>
                                                    <asp:Label ID="lblgasunits2" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblGasvitals3" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtPo2" runat="server" Width="58px"></asp:TextBox>
                                                    <asp:Label ID="lblgasunits3" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblGasvitals4" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtHCo3" runat="server" Width="45px"></asp:TextBox>
                                                    <asp:Label ID="lblgasunits4" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblGasvitals5" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtBE" runat="server" Width="40px"></asp:TextBox>
                                                    <asp:Label ID="lblgasunits5" runat="server"></asp:Label>
                                                </td>
                                                <td align="center">
                                                    <asp:Button ID="OKbuttonGas" runat="server" Text="Add" OnClientClick="javascript:AddDataToDataTableBlood()"
                                                        OnClick="OKButtonGas_Click" Width="82px" />
                                                </td>
                                                <td align="center">
                                                    <asp:Button ID="CloseButtonGas" runat="server" Text="Close" OnClick="OKButton_Click"
                                                        Width="88px" />
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </asp:Panel>
                        </div>
                        <div>
                            <table id="tblBloodGas" border="0" runat="server" cellpadding="0" class="dataheaderCtrl"
                                style="text-align: left; display: none; padding-left: 20; color: Black" width="100%">
                                <tr id="Tr5" runat="server">
                                    <th id="Th19" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        Captured Date/Time
                                    </th>
                                    <th id="Th20" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        PH
                                    </th>
                                    <th id="Th21" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        PCo2
                                    </th>
                                    <th id="Th22" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        HCo3
                                    </th>
                                    <th id="Th23" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        BE
                                    </th>
                                </tr>
                            </table>
                        </div>
                        <div>
                            <table>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lnkVentilator" Text="Ventilator Settings" runat="server" Style="color: Black;
                                            text-decoration: underline;"></asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                            <ajc:ModalPopupExtender ID="MPEVentilator" runat="server" TargetControlID="lnkVentilator"
                                PopupControlID="PnlVentilator" DropShadow="True" BackgroundCssClass="modalBackground"
                                OkControlID="CloseButton" DynamicServicePath="" Enabled="True" />
                            <asp:Panel ID="PnlVentilator" runat="server" CssClass="modalPopup" Width="1100px"
                                Height="70px">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <table runat="server">
                                            <tr align="left">
                                                <td align="left">
                                                    <asp:Label ID="lblvitalsventilator1" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtTidlevalue" runat="server" Width="90px"></asp:TextBox>
                                                    <asp:Label ID="lblventilatorunits1" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblvitalsventilator2" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtRRVentilator" runat="server" Width="58px"></asp:TextBox>
                                                    <asp:Label ID="lblventilatorunits2" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblvitalsventilator3" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtpeep" runat="server" Width="45px"></asp:TextBox>
                                                    <asp:Label ID="lblventilatorunits3" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblvitalsventilator4" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtFi02" runat="server" Width="40px"></asp:TextBox>
                                                    <asp:Label ID="lblventilatorunits4" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblvitalsventilator5" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtinspiratory" runat="server" Width="40px"></asp:TextBox>
                                                    <asp:Label ID="lblventilatorunits5" runat="server"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="lblvitalsventilator6" runat="server"> </asp:Label>
                                                    <asp:TextBox ID="txtIE" runat="server" Width="40px"></asp:TextBox>
                                                    <asp:Label ID="lblventilatorunits6" runat="server"></asp:Label>
                                                </td>
                                                <td align="center">
                                                    <asp:Button ID="OKButtonVentilator" runat="server" Text="Add" OnClientClick="javascript:AddDataToDataTableVentilator()"
                                                        OnClick="OKButtonVentilator_Click" Width="82px" />
                                                </td>
                                                <td align="center">
                                                    <asp:Button ID="CloseButtonVentilator" runat="server" Text="Close" OnClick="OKButtonVentilator_Click"
                                                        Width="88px" />
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </asp:Panel>
                        </div>
                        <div>
                            <table id="tblVentilator" border="0" runat="server" cellpadding="0" class="dataheaderCtrl"
                                cellspacing="10" style="text-align: left; display: none; padding-left: 60; color: Black"
                                width="100%">
                                <tr id="Tr4" runat="server">
                                    <th id="Th16" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        Captured Date/Time
                                    </th>
                                    <th id="Th12" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        Tiddle Value
                                    </th>
                                    <th id="Th13" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        RR
                                    </th>
                                    <th id="Th14" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        PEEP
                                    </th>
                                    <th id="Th15" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        Fi02
                                    </th>
                                    <th id="Th17" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        Inspiratory Flow
                                    </th>
                                    <th id="Th18" style="font-size: 10px; text-decoration: underline; text-align: left"
                                        runat="server">
                                        I:E
                                    </th>
                                </tr>
                            </table>
                        </div>
                        <div>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblmodeofanesthesia" runat="server" Text="Mode Of Anesthesia"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBoxList ID="chkModeofAnesthesia" runat="server">
                                            <asp:ListItem Text="IV Anesthesia" Value="IV Anesthesia"></asp:ListItem>
                                            <asp:ListItem Text="Inhalational Anesthesia" Value="Inhalational Anesthesia"></asp:ListItem>
                                        </asp:CheckBoxList>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblScoringSystem" runat="server" Text="Scoring System"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="DDLScoringSystem" runat="server">
                                            <asp:ListItem Value="ASA" Text="ASA"></asp:ListItem>
                                            <asp:ListItem Value="APACHE11" Text="APACHE11"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblScorevalue" runat="server" Text="Scoring Value"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="DDLScoringValue" runat="server">
                                            <asp:ListItem Value="1" Text="1"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="2"></asp:ListItem>
                                            <asp:ListItem Value="3" Text="3"></asp:ListItem>
                                            <asp:ListItem Value="4" Text="4"></asp:ListItem>
                                            <asp:ListItem Value="5" Text="5"></asp:ListItem>
                                            <asp:ListItem Value="6" Text="6"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div>
                            <uc11:Adv ID="uAd" runat="server" />
                            <asp:Panel ID="PanelDC1" runat="server" CssClass="collapsePanel" Height="0px" meta:resourcekey="PanelDC1Resource1">
                                <asp:GridView ID="grdDrugChart" AutoGenerateColumns="False" runat="server" CellPadding="4"
                                    ForeColor="#333333" CssClass="mytable1" OnRowDataBound="grdDrugChart_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Drug Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDrugFormulation" runat="server" Text='<%# Bind("DrugFormulation") %>'></asp:Label>
                                                <asp:Label ID="lblDrugName" runat="server" Text='<%# Bind("DrugName") %>'></asp:Label>
                                                (
                                                <asp:Label ID="lblDose" runat="server" Text='<%# Bind("Dose") %>'></asp:Label>
                                                )
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="ROA" HeaderText="ROA">
                                            <ItemStyle Width="100px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Instruction" HeaderText="Instructions" />
                                        <asp:TemplateField HeaderText="Date Time (From)">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAdministeredAtFrom" runat="server" Text='<%# Bind("AdministeredAtFrom") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="120px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date Time (To)">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAdministeredAtTo" runat="server" Text='<%# Bind("AdministeredAtTo") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="120px" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="NurseName" HeaderText="Given By" />
                                    </Columns>
                                    <HeaderStyle CssClass="dataheader1" />
                                </asp:GridView>
                            </asp:Panel>
                        </div>
                        <div>
                            <table>
                                <tr>
                                    <td>
                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                            <ContentTemplate>
                                                <asp:HiddenField ID="hdNewID" runat="server" />
                                                <asp:GridView ID="grdPrescription1" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                                    DataKeyNames="PrescriptionID" ForeColor="#333333" CssClass="mytable1" OnRowCommand="grdPrescription1_RowCommand"
                                                    OnRowDataBound="grdPrescription1_RowDataBound">
                                                    <HeaderStyle CssClass="dataheader1" />
                                                    <Columns>
                                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource4">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkSelect" runat="server" meta:resourcekey="chkSelectResource1" />
                                                                <asp:Label ID="lblSno" Visible="False" runat="server" Text='<%# Bind("Sno") %>' meta:resourcekey="lblSnoResource1"></asp:Label>
                                                                <asp:Label ID="lblPrescriptionID" Visible="False" runat="server" Text='<%# Bind("PrescriptionID") %>'
                                                                    meta:resourcekey="lblPrescriptionIDResource1"></asp:Label>
                                                                <asp:Label ID="lblROA" Visible="False" runat="server" Text='<%# Bind("ROA") %>' meta:resourcekey="lblROAResource1"></asp:Label>
                                                                <asp:Label ID="lblDrugFrequency" Visible="False" runat="server" Text='<%# Bind("DrugFrequency") %>'
                                                                    meta:resourcekey="lblDrugFrequencyResource1"></asp:Label>
                                                                <asp:Label ID="lblDuration" Visible="False" runat="server" Text='<%# Bind("Duration") %>'
                                                                    meta:resourcekey="lblDurationResource1"></asp:Label>
                                                                <asp:Label ID="lblInstruction" Visible="False" runat="server" Text='<%# Bind("Instruction") %>'
                                                                    meta:resourcekey="lblInstructionResource1"></asp:Label>
                                                                <asp:Label ID="lblCreatedBy" Visible="False" runat="server" Text='<%# Bind("CreatedBy") %>'
                                                                    meta:resourcekey="lblCreatedByResource1"></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="5px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Drug Name" meta:resourcekey="TemplateFieldResource5">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDrugFormulation" Text='<%# Bind("DrugFormulation") %>' runat="server"
                                                                    meta:resourcekey="lblDrugFormulationResource2"></asp:Label>
                                                                <asp:Label ID="lblDrugName" Text='<%# Bind("DrugName") %>' runat="server" meta:resourcekey="lblDrugNameResource2"></asp:Label>
                                                                (
                                                                <asp:Label ID="lblDose" Text='<%# Bind("Dose") %>' runat="server" meta:resourcekey="lblDoseResource2"></asp:Label>
                                                                )
                                                            </ItemTemplate>
                                                            <ItemStyle Width="200px" />
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="DrugFrequency" HeaderText="FREQ" meta:resourcekey="BoundFieldResource4">
                                                            <ItemStyle Width="30px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Instruction" HeaderText="Instruction" meta:resourcekey="BoundFieldResource5">
                                                            <ItemStyle Width="100px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Duration" HeaderText="Duration" meta:resourcekey="BoundFieldResource6">
                                                            <ItemStyle Width="60px" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="DateTime" meta:resourcekey="TemplateFieldResource6">
                                                            <ItemTemplate>
                                                                <asp:TextBox runat="server" ID="txtFDate" Text='<%# Bind("AdministeredAtFrom") %>'
                                                                    DataFormatString="{0:dd-MM-yyyy hh:mm:ss tt}" MaxLength="25" Width="80px" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                                <asp:Image src="../Images/Calendar_scheduleHS.png" ID="imgFDate" onclick="javascript:NewCal1(this.id);"
                                                                    Width="16px" Height="16px" border="0" runat="server" meta:resourcekey="imgFDateResource1" />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="110px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="To DateTime" meta:resourcekey="TemplateFieldResource7">
                                                            <ItemTemplate>
                                                                <asp:TextBox runat="server" ID="txtTDate" Text='<%# Bind("AdministeredAtTo") %>'
                                                                    DataFormatString="{0:dd-MM-yyyy hh:mm:ss tt}" MaxLength="25" Width="80px" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                                <asp:Image src="../Images/Calendar_scheduleHS.png" ID="imgTDate" onclick="javascript:NewCal2(this.id);"
                                                                    Width="16px" Height="16px" border="0" runat="server" meta:resourcekey="imgTDateResource1" />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="110px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource8">
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnAdd" runat="server" Text="ADD" class="btn" onmouseout="this.className='btn'"
                                                                    onmouseover="this.className='btn btnhov'" CommandName="Add" CommandArgument='<%# Bind("Sno") %>' />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="25px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource9">
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnStop" runat="server" Text="STOP" class="btn" onmouseout="this.className='btn'"
                                                                    onmouseover="this.className='btn btnhov'" CommandName="Stop" CommandArgument='<%# Bind("PrescriptionID") %>'
                                                                    meta:resourcekey="btnStopResource1" />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="25px" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="divcomplcations">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblComplication" Text="Complications" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trChkComplication" runat="server" style="display: block;">
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl" width="100%">
                                            <tr>
                                                <td>
                                                    <asp:CheckBoxList ID="ChkComplications" runat="server">
                                                        <asp:ListItem Text="Cardiovascular collapse" Value="Cardiovascular collapse"></asp:ListItem>
                                                        <asp:ListItem Text="Hypovolemic shock" Value="Hypovolemic shock"></asp:ListItem>
                                                        <asp:ListItem Text="Sinus Tachycardia" Value="Sinus Tachycardia"></asp:ListItem>
                                                        <asp:ListItem Text="Sinus Bradycardia" Value="Sinus Bradycardia"></asp:ListItem>
                                                        <asp:ListItem Text="Arrhythmia" Value="Arrhythmia"></asp:ListItem>
                                                        <asp:ListItem Text="Respiratory depression" Value="Respiratory depression"></asp:ListItem>
                                                        <asp:ListItem Text="Embolism" Value="Embolism"></asp:ListItem>
                                                        <asp:ListItem Text="Nausea and vomiting" Value="Nausea and vomiting"></asp:ListItem>
                                                        <asp:ListItem Text="Spinal Infection" Value="Spinal Infection"></asp:ListItem>
                                                    </asp:CheckBoxList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="ChkOthers" runat="server" />
                                                    <asp:Label ID="Rs_Others" Text="Others" runat="server"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" onfocus="javascript:expandBox(this.id);" onblur="javascript:collapseBox(this.id);"
                                                        Rows="1" ID="txtComplicationOthers" TextMode="MultiLine" Style="width: 200px;"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <uc9:GeneralAdv ID="uGAdv" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </div>
        </table>
    </div>
    <table width="100%">
        <tr align="center">
            <td>
                <asp:Button ID="btnSave" runat="server" Text="Save" class="btn" onmouseout="this.className='btn'"
                    onmouseover="this.className='btn btnhov'" OnClick="btnSave_Click" />
                &nbsp;
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" class="btn" onmouseout="this.className='btn'"
                    onmouseover="this.className='btn btnhov'" OnClick="btnCancel_Click" />
                &nbsp;
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnIPTreatmentPlanChild" runat="server" />
    <asp:HiddenField ID="hdnPerformed" runat="server" />
    <asp:HiddenField ID="hdnRecords" runat="server" />
    <asp:HiddenField ID="hdnRecordsBloodGas" runat="server" />
    <asp:HiddenField ID="hdnventilator" runat="server" />
    <asp:HiddenField ID="hdnchkitems" runat="server" />
    <uc2:Footer ID="Footer1" runat="server" />
    </form>
</body>
</html>
