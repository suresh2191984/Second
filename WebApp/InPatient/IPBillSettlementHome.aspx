<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IPBillSettlementHome.aspx.cs"
    Inherits="InPatient_IPBillSettlementHome" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/InPatientSearch.ascx" TagName="PatientSearch"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <script type="text/javascript">
    
 function ShowAlertMsg(key) {
       var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false ;
            }
            else if(key =="InPatient\\IPBillSettlementHome.aspx.cs_2")
            {
            alert('This cannot be performed as the Room is not occupied by this patient');
            return false ;
            }
         else if(key =="InPatient\\IPBillSettlementHome.aspx.cs_3")
            {
            alert('URL Not Found');
            return false ;
            }
           return true;
        }

        function CheckINPatientSearch() {

            if (document.getElementById('ucINPatientSearch_txtPatientNo').value == '' && document.getElementById('ucINPatientSearch_txtPatientName').value == '' &&
    document.getElementById('ucINPatientSearch_txtDOB').value == '' && document.getElementById('ucINPatientSearch_txtRoomNo').value == '' &&
    document.getElementById('ucINPatientSearch_txtCellNo').value == '' && document.getElementById('ucINPatientSearch_purposeOfAdmission').value == '0' &&
    document.getElementById('ucINPatientSearch_txtIPNo').value == '' &&
    (document.getElementById('ucINPatientSearch_chkDischarge').checked == false)) {
    
           var userMsg = SListForApplicationMessages.Get('InPatient\\IPBillSettlementHome.aspx_1');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{
                alert('Provide one search category');
                return false ;
                }
                document.getElementById('ucINPatientSearch_txtPatientNo').focus();
                return false;
            }

            return true;
        }

    </script>

</head>
<body onload="pageLoadFocus('ucINPatientSearch_txtPatientNo');">
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
                                    <asp:Label ID="Rs_SelectaPatientandoneofthefollowing" Text="Select a patient and one of the following"
                                        runat="server" meta:resourcekey="Rs_SelectaPatientandoneofthefollowingResource1"></asp:Label>
                                    <asp:DropDownList ID="dList" runat="server"  CssClass="ddlsmall" OnSelectedIndexChanged="dList_SelectedIndexChanged"
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
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
