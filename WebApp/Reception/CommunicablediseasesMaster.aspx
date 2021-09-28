<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CommunicablediseasesMaster.aspx.cs"
    Inherits="Reception_CommunicableDiseaseMaster" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<%@ Register Src="../CommonControls/ComplaintICDCode.ascx" TagName="ComplaintICDCode"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Communicable Diseases</title>
    <script type="text/javascript" src="../Scripts/AutoComplete.js"></script>

     <script src="../Scripts/actb.js" type="text/javascript"></script>

    <script src="../Scripts/actbcommon.js" type="text/javascript"></script>

    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript">
               var  userMsg;
        function InPageValidation() {
            if (document.getElementById('ComplaintICDCode1_hdnDiagnosisItems').value == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\CommunicablediseasesMaster.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                    
                }

                else {
                    alert('Add communicable diseases before saving');
                }
                return false;
            }

        }
    
    </script>

</head>
<body onload="" oncontextmenu="return false;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                       
                        <table class="w-100p">
                            <tr>
                                <td class="fontGPLA">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource1"></asp:Label>
                                                <asp:Label ID="lblResult" runat="server" CssClass="casesheettext" meta:resourcekey="lblResultResource1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Panel ID="Panel1" runat="server" GroupingText="Add Communicable diseases" Style="color: #000000;"
                                                    meta:resourcekey="Panel1Resource1">
                                                    <table class="searchPanel" cellpadding="3" cellspacing="3" border="0" width="100%"
                                                        id="Table1" runat="server" style="padding-left: 5px;">
                                                        <tr runat="server">
                                                            <td runat="server">
                                                                <uc7:ComplaintICDCode ID="ComplaintICDCode1" runat="server" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-center">
                                                <asp:Button CssClass="btn" OnClientClick="InPageValidation()" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click"
                                                    meta:resourcekey="btnSaveResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
     <Attune:Attunefooter ID="Attunefooter" runat="server" />          
    <asp:HiddenField ID="hdnvalue" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
