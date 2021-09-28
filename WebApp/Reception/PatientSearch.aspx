<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientSearch.aspx.cs" Inherits="Nurse_PatientSearch"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/PatientSearch.ascx" TagName="PatientSearch" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Patient Search</title>

    <script type="text/javascript">

        function ShowAlertMsg(key) {
           ////debugger;
            //var keyVal = key.replace("__", '\\');

            var objAlert = SListForAppMsg.Get("Reception_PatientSearch_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_PatientSearch_Alert");
            var objApp01 = SListForAppMsg.Get("Reception_PatientSearch_aspx_01") == null ? "This action Cannot be Performed as Patient belongs to another Organization" : SListForAppMsg.Get("Reception_PatientSearch_aspx_01");
            var objApp02 = SListForAppMsg.Get("Reception_PatientSearch_aspx_02") == null ? "Move on to Registration & Visit" : SListForAppMsg.Get("Reception_PatientSearch_aspx_02");
            var objApp03 = SListForAppMsg.Get("Reception_PatientSearch_aspx_03") == null ? "Patient registration is needed" : SListForAppMsg.Get("Reception_PatientSearch_aspx_03");
            var objApp04 = SListForAppMsg.Get("Reception_PatientSearch_aspx_04") == null ? "This action cannot be performed for This patient" : SListForAppMsg.Get("Reception_PatientSearch_aspx_04");
            var objApp05 = SListForAppMsg.Get("Reception_PatientSearch_aspx_05") == null ? "This action cannot be performed for inpatients" : SListForAppMsg.Get("Reception_PatientSearch_aspx_05");
            var objApp06 = SListForAppMsg.Get("Reception_PatientSearch_aspx_06") == null ? "The selected patient does not have any Due" : SListForAppMsg.Get("Reception_PatientSearch_aspx_06");
           var userMsg = SListForApplicationMessages.Get(key);
           if (userMsg != null) {
               ValidationWindow(userMsg, objAlert);
               //alert(userMsg);
           }
           else if (key == "Reception\\PatientSearch.aspx.cs_6") {
           ValidationWindow(objApp01, objAlert);
              // alert('This action Cannot be Performed as Patient belongs to another Organization');
           }

           else if (key == "Reception\\PatientSearch.aspx.cs_8") {
           ValidationWindow(objApp02, objAlert);
           //    alert('Move on to Registration & Visit');

           }
           else if (key == "Reception\\PatientSearch.aspx.cs_9") {
           ValidationWindow(objApp03, objAlert);
               //alert('Patient registration is needed');

           }
           else if (key == "Reception\\PatientSearch.aspx.cs_10") {
           ValidationWindow(objApp04, objAlert);
           //    alert('This action cannot be performed for This patient');

           }
           else if (key == "Reception\\PatientSearch.aspx.cs_11") {
           ValidationWindow(objApp05, objAlert);
               //alert('This action cannot be performed for inpatients');

           }
           else if (key == "Reception\\PatientSearch.aspx.cs_12") {
           ValidationWindow(objApp06, objAlert);
               //alert('The selected patient does not have any Due');

           }
        return false;
        }
        function CheckPatientSearch() {
            var objAlert = SListForAppMsg.Get("Reception_PatientSearch_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_PatientSearch_Alert");
            var objApp07 = SListForAppMsg.Get("Reception_PatientSearch_aspx_07") == null ? "Provide any one search category(local)" : SListForAppMsg.Get("Reception_PatientSearch_aspx_07");
            var objApp08 = SListForAppMsg.Get("Reception_PatientSearch_aspx_08") == null ? "Select others" : SListForAppMsg.Get("Reception_PatientSearch_aspx_08");
            var objApp09 = SListForAppMsg.Get("Reception_PatientSearch_aspx_09") == null ? "Select Date" : SListForAppMsg.Get("Reception_PatientSearch_aspx_09");
            var userMsg = SListForApplicationMessages.Get('Reception\\PatientSearch.aspx_4'); 
            if (document.getElementById('uctlPatientSearch_txtPatientNo').value == '' && document.getElementById('uctlPatientSearch_txtPatientName').value == '' &&
    document.getElementById('uctlPatientSearch_txtDOB').value == '' && document.getElementById('uctlPatientSearch_txtRelation').value == '' &&
    document.getElementById('uctlPatientSearch_txtLocation').value == '' && document.getElementById('uctlPatientSearch_txtOthers').value == '' && document.getElementById('uctlPatientSearch_txtURNo').value == '' && document.getElementById('uctlPatientSearch_ddlNationality').value == '0' && document.getElementById('uctlPatientSearch_ddlRegisterDate').value == '-1' && document.getElementById('uctlPatientSearch_txtSmartCardNo').value == '') {

                if (userMsg != null) {
                    ValidationWindow(userMsg, objAlert);
                    //alert(userMsg);
                    return false;
                }
                else {
                    ValidationWindow(objApp07, objAlert);
                    //alert('Provide any one search category(local)');
                    return false;
                }
                document.getElementById('uctlPatientSearch_txtPatientNo').focus();
               
            }

            if (document.getElementById('uctlPatientSearch_txtOthers').value != '') {
                var userMsg1 = SListForApplicationMessages.Get('Reception\\PatientSearch.aspx_3'); 
                if (document.getElementById('uctlPatientSearch_ddOthers').value == -1) {
                    if (userMsg1 != null) {
                        ValidationWindow(userMsg1, objAlert);
                        //alert(userMsg1);
                        return false;
                    }
                    else {
                        ValidationWindow(objApp08, objAlert);
                    //    alert('Select others');
                        return false;
                    }
                    document.getElementById('uctlPatientSearch_ddOthers').focus();
                   
                }
            }
            if (document.getElementById('uctlPatientSearch_ddlRegisterDate').value == '3') {
                var userMsg2 = SListForApplicationMessages.Get('Reception\\PatientSearch.aspx_2'); 
                if (document.getElementById('uctlPatientSearch_txtFromPeriod').value == '' || document.getElementById('uctlPatientSearch_txtToPeriod').value == '') {
                    if (userMsg2 != null) {
                        ValidationWindow(userMsg2, objAlert);
                        //alert(userMsg2);
                         return false;
                    }
                    else {
                        ValidationWindow(objApp09, objAlert);
                       // alert('Select Date');
                        return false;
                    }
                    
                }
            }
            return true;
        }
        function SearchFocus(e) {
            var key = window.event ? e.keyCode : e.which;
            if (key == 13)
                document.getElementById('uctlPatientSearch_btnSearch').focus();
        }

        function ValidatePatientName() {
            var objAlert = SListForAppMsg.Get("Reception_PatientSearch_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_PatientSearch_Alert");
            var objApp10 = SListForAppMsg.Get("Reception_PatientSearch_aspx_10") == null ? "Select patient name" : SListForAppMsg.Get("Reception_PatientSearch_aspx_10");
            var userMsg1 = SListForApplicationMessages.Get('Reception\\PatientSearch.aspx_1'); 
            if (document.getElementById("uctlPatientSearch_hdnPatientID").value == '') {
                if (userMsg1 != null) {
                    ValidationWindow(userMsg1, objAlert);
                    //alert(userMsg1);
                    return false;
                }
                else {
                    ValidationWindow(objApp10, objAlert);
                    //alert('Select patient name');
                    return false;
                }
               
            }
        }
    </script>

</head>
<body onkeypress="SearchFocus(event)" onload="pageLoadFocus('uctlPatientSearch_txtPatientNo');"
    oncontextmenu="return false;">
    <form id="form1" runat="server" defaultbutton="btnSearch1">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                        <asp:UpdatePanel ID="up1" runat="server">
                            <ContentTemplate>
                                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="up1" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <table class="w-100p">
                                  
                                    <tr>
                                        <td>
                                            <uc2:PatientSearch ID="uctlPatientSearch" runat="server" />
                                        </td>
                                    </tr>
                                    <tr id="aRow" runat="server" visible="False">
                                        <td class="defaultfontcolor" runat="server">
                                            <asp:Label ID="Rs_Selectapatient" Text="Select a patient and one of the following"
                                                runat="server" meta:resourcekey="Rs_SelectapatientResource1" />
                                            <asp:DropDownList ID="dList" runat="server" CssClass="ddllarge" 
                                                OnSelectedIndexChanged="dList_SelectedIndexChanged" 
                                                meta:resourcekey="dListResource1">
                                            </asp:DropDownList>
                                            <asp:Button ID="bGo" runat="server" Text="Go" OnClick="bGo_Click" CssClass="btn"
                                                OnClientClick="return ValidatePatientName()" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="bGoResource1" />
                                            <asp:Button ID="btnSearch1" Visible="False" runat="server" CssClass ="btn" 
                                                meta:resourcekey="btnSearch1Resource1" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
              
        <asp:Button ID="btnNoLog" runat="server" Style="display: none" meta:resourcekey="btnNoLogResource1" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />    

    <script type="text/javascript" language="javascript">
        if (document.getElementById('uctlPatientSearch_hdnTempFromPeriod').value == "1" && document.getElementById('uctlPatientSearch_hdnTempToPeriod').value == "1") {
            
            document.getElementById('uctlPatientSearch_divRegDate').style.display = 'none';
            document.getElementById('uctlPatientSearch_divRegDate').style.display = 'none';
            document.getElementById('uctlPatientSearch_divRegCustomDate').style.display = 'block';
            document.getElementById('uctlPatientSearch_divRegCustomDate').style.display = 'block';
            document.getElementById('uctlPatientSearch_divRegCustomDate').style.display = 'inline';
            document.getElementById('uctlPatientSearch_divRegCustomDate').style.display = 'inline';
        }
        if (document.getElementById('uctlPatientSearch_hdnTempFrom').value != "" && document.getElementById('uctlPatientSearch_hdnTempTo').value != "") {
            
            document.getElementById('uctlPatientSearch_divRegDate').style.display = 'block';
            document.getElementById('uctlPatientSearch_divRegDate').style.display = 'block';
            document.getElementById('uctlPatientSearch_divRegCustomDate').style.display = 'none';
            document.getElementById('uctlPatientSearch_divRegCustomDate').style.display = 'none';
            document.getElementById('uctlPatientSearch_divRegDate').style.display = 'inline';
            document.getElementById('uctlPatientSearch_divRegDate').style.display = 'inline';
        }
    </script>
  <asp:HiddenField ID="hdnMessages" runat="server" />
  <asp:HiddenField ID="hdnPStatus" runat="server" />
    </form>
</body>
</html>
