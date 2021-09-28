<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InPatientSearch.aspx.cs"
    Inherits="Reception_InPatientSearch" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/InPatientSearch.ascx" TagName="PatientSearch"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Patient Search</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <script type="text/javascript">
     function ShowAlertMsg(key) {
       var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false ;
            }
            else if(key =="Reception\\InPatientSearch.aspx.cs_3")
            {
            alert('This action cannot be performed for male patient');
            return false ;
            }
          else if(key =="Reception\\InPatientSearch.aspx.cs_4")
            {
            alert('This action can be performed for New born baby');
            return false ;
            }
             else if(key =="Reception\\InPatientSearch.aspx.cs_5")
            {
            alert('No Physiotherapy ordered/Pending for this patient');
            return false ;
            }
             else if(key =="Reception\\InPatientSearch.aspx.cs_6")
            {
            alert('Discharge summary already completed for this patient. Please contact Administrator');
            return false ;
            }
            else if(key =="Reception\\InPatientSearch.aspx.cs_20")
            {
            alert('URL not found');
            return false ;
            }
           return true;
        }
        function CheckINPatientSearch() {

            if (document.getElementById('ucINPatientSearch_txtPatientNo').value == '' && document.getElementById('ucINPatientSearch_txtPatientName').value == '' &&
    document.getElementById('ucINPatientSearch_txtDOB').value == '' && document.getElementById('ucINPatientSearch_txtRoomNo').value == '' &&
    document.getElementById('ucINPatientSearch_txtCellNo').value == '' && document.getElementById('ucINPatientSearch_purposeOfAdmission').value == '0' &&
    document.getElementById('ucINPatientSearch_txtIPNo').value == '' && document.getElementById('ucINPatientSearch_txtSmartCardNo').value == '' &&
    (document.getElementById('ucINPatientSearch_chkDischarge').checked == false)) {

                var userMsg = SListForApplicationMessages.Get('CommonControls\\InpatientSearch.ascx_1');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Please Enter any one search category');
                }
                document.getElementById('ucINPatientSearch_txtPatientNo').focus();
                return false;
            }

            return true;
        }
        function PrintOpCard() {
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0,Addressbar=no');
            WinPrint.document.write($('#divGenerateVisit').html());
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
       

    </script>

</head>
<body onload="pageLoadFocus('ucINPatientSearch_txtPatientNo');" oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        
                        <table class="w-100p">
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <uc2:PatientSearch ID="ucINPatientSearch" runat="server" />
                                </td>
                            </tr>
                            <tr id="aRow" runat="server" visible="false">
                                <td class="defaultfontcolor">
                                    <asp:Label ID="Rs_Info" Text="Select a patient and one of the following" runat="server"
                                        meta:resourcekey="Rs_InfoResource1"></asp:Label>
                                    <asp:DropDownList ID="dList" runat="server" CssClass="ddlmedium" OnSelectedIndexChanged="dList_SelectedIndexChanged"
                                        meta:resourcekey="dListResource1">
                                    </asp:DropDownList>
                                    <asp:Button ID="bGo" runat="server" Text="Go" OnClick="bGo_Click" CssClass="btn"
                                        OnClientClick="return pValidation()" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" meta:resourcekey="bGoResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />      
        <div style="display: none" id="divGenerateVisit">
            <asp:Xml ID="XmlOP" runat="server"></asp:Xml>
        </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
