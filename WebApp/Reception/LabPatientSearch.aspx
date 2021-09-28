<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LabPatientSearch.aspx.cs"
    Inherits="LabPatientSearch" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/PatientSearch.ascx" TagName="PatientSearch" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Patient Search</title>
<%--    <script src="../Scripts/ToolTip.js" type="text/javascript"></script>--%>

    <script type="text/javascript">


        function CheckPatientSearch() {
                    var objvarAlert = SListForAppMsg.Get("Reception_PatientSearch_Alert") == null ? "Alert" : SListForAppMsg.Get("Reception_PatientSearch_Alert");

                    var a1 = SListForAppMsg.Get("Reception_LabPatientSearch_aspx_01") == null ? "Provide any one search category" : SListForAppMsg.Get("Reception_LabPatientSearch_aspx_01");
                    var a2 = SListForAppMsg.Get("Reception_LabPatientSearch_aspx_02") == null ? "Select value for others" : SListForAppMsg.Get("Reception_LabPatientSearch_aspx_02");


            if (document.getElementById('uctlPatientSearch_txtPatientNo').value == '' && document.getElementById('uctlPatientSearch_txtPatientName').value == '' &&
    document.getElementById('uctlPatientSearch_txtDOB').value == '' && document.getElementById('uctlPatientSearch_txtRelation').value == '' &&
    document.getElementById('uctlPatientSearch_txtLocation').value == '' && document.getElementById('uctlPatientSearch_txtOthers').value == '' && document.getElementById('uctlPatientSearch_txtURNo').value == '' && document.getElementById('uctlPatientSearch_ddlNationality').value == '0' && document.getElementById('uctlPatientSearch_ddlRegisterDate').value == '-1' && document.getElementById('uctlPatientSearch_txtSmartCardNo').value == '') {
                var userMsg = SListForApplicationMessages.Get('Reception\\LabPatientSearch.aspx_1');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                   // alert('Provide any one search category');
                    ValidationWindow(a1, objvarAlert);
                
                }
                document.getElementById('uctlPatientSearch_txtPatientNo').focus();
                return false;
            }

            if (document.getElementById('uctlPatientSearch_txtOthers').value != '') {
                if (document.getElementById('uctlPatientSearch_ddOthers').value == -1) {
                    var userMsg = SListForApplicationMessages.Get('Reception\\LabPatientSearch.aspx_2');
                    if (userMsg != null) {
                        alert(userMsg);
                    }
                    else {
                       // alert('Select value for others');
                        ValidationWindow(a2, objvarAlert);
                     
                     }
                    document.getElementById('uctlPatientSearch_ddOthers').focus();
                    return false;
                }
            }
            return true;
        }
        function SearchFocus(e) {
            var key = window.event ? e.keyCode : e.which;
            if (key == 13)
                document.getElementById('uctlPatientSearch_btnSearch').focus();
        }

    </script>

</head>
<body onkeypress="SearchFocus(event)" oncontextmenu="return true;">
    <form id="form1" runat="server" defaultbutton="btnSearch1">
    <asp:ScriptManager ID="scp" ScriptMode="Release" runat="server">
    </asp:ScriptManager>
            <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="up1" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter">
                                        </div>
                                        <div align="center" id="processMessage">
                                            Loading...<br />
                                            <br />
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" 
                                                meta:resourcekey="imgProgressbarResource1" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <%--<uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />--%>
                                <asp:UpdatePanel ID="up1" runat="server">
                                    <ContentTemplate>
                                        <table class="w-100p">
                                            <tr>
                                                <td>
                                                    <table id="mytable1" class="w-100p">
                                                        <tr>
                                                            <td id="us">
                                                                <asp:Label ID="Rs_Lookupforregisteredpatients" 
                                                                    Text="Look up for registered patients." runat="server" 
                                                                    meta:resourcekey="Rs_LookupforregisteredpatientsResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-bottom: 10px;">
                                                    <uc9:PatientSearch ID="uctlPatientSearch" runat="server" />
                                                </td>
                                            </tr>
                                            <tr id="Row" runat="server" visible="False">
                                                <td class="defaultfontcolor" runat="server">
                                                    <asp:Label ID="Rs_Info" Text="Select a Patient's Record and perform one of the following" runat="server"></asp:Label>
                                                    <asp:DropDownList ID="dList" runat="server" ToolTip="Select the Action to be Performed"
                                                        OnSelectedIndexChanged="dList_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                    <asp:Button ID="bGo" runat="server" Text="Go" OnClick="bGo_Click" ToolTip="Click here to Proceed"
                                                        CssClass="btn" OnClientClick="javascript:return pValidation();" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" />
                                                    <asp:Button ID="btnSearch1" Visible="False" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                  <input type="hidden" id="hdnPatientRegistrationStatus" name="hdnPatientRegistrationStatus" />
                                </div> </div> </div> </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
           <Attune:Attunefooter ID="Attunefooter" runat="server" />       

         <asp:HiddenField ID="hdnPStatus" runat="server" />
         <asp:HiddenField ID ="hdnMessages" runat ="server" />
    </form>
</body>
</html>
