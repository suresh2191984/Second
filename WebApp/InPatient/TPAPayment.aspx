<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TPAPayment.aspx.cs" Inherits="InPatient_TPAPayment" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/InPatientSearch.ascx" TagName="PatientSearch"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/InsuranceSearch.ascx" TagName="InsuranceSearch"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <script language="javascript" type="text/javascript">
        function ShowAlertMsg(key) {
            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
            }
            else if (key ==  "InPatient\\TPAPayment.aspx.cs_4") {
            alert('Claim forward Date save Succesfully');
            }
            return false;
        }
    
        function checkForDataSelected() {

            if (document.getElementById('hdnGetValue').value == '') {
                var userMsg = SListForApplicationMessages.Get('InPatient\\TPAPayment.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Select a patient and click Go');
                }
                return false;
            }
            return true;

        }
        function checkForDataSelected1() {

            if (document.getElementById('hdnGetValue').value == '') {
                var userMsg = SListForApplicationMessages.Get('InPatient\\TPAPayment.aspx_2');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    alert('Select a patient and click save');
                }
                return false;
            }
            return true;

        }
    </script>

</head>
<body onload="pageLoadFocus('InsuranceSearch1_txtPatientNo');">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                        <asp:UpdatePanel ID="insurance" runat="server">
                            <ContentTemplate>
                                <table class="w-100p searchPanel">
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <uc8:InsuranceSearch ID="InsuranceSearch1" runat="server" />
                                        </td>
                                    </tr>
                                    <tr id="aRow" runat="server" visible="False">
                                        <td class="defaultfontcolor a-center" runat="server">
                                            <asp:Button ID="bGo" runat="server" Text="Go" OnClick="bGo_Click" CssClass="btn"
                                                onmouseover="this.className='btn btnhov'" OnClientClick="javascript:if(!checkForDataSelected()) return false;"
                                                onmouseout="this.className='btn'" />
                                                &nbsp &nbsp &nbsp
                                                <asp:Button ID="BtnSave" runat="server" Text="Save" OnClick="BtnSave_click" CssClass="btn" ToolTip ="Save Claim Forwarded Date"
                                                onmouseover="this.className='btn btnhov'" OnClientClick="javascript:if(!checkForDataSelected1()) return false;"
                                                onmouseout="this.className='btn'" />
                                        </td>
                                         <td class="defaultfontcolor a-center" runat="server">
                                            
                                        </td>
                                        <td runat="server">
                                            <asp:HiddenField ID="hdnField" runat="server" />
                                            <asp:HiddenField ID="hdnGetValue" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
        <asp:HiddenField ID="hdnMessages" runat ="server" />
  <Attune:Attunefooter ID="Attunefooter" runat="server" />     
    
    </form>
</body>
</html>
