<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LabReceptionHome.aspx.cs"
    Inherits="Reception_LabReceptionHome" meta:resourcekey="PageResource2" %>

<%@ Register Src="../CommonControls/PhySchedule.ascx" TagName="PSchedule" TagPrefix="ps" %>
<%@ Register Src="~/CommonControls/ClientSchedule.ascx" TagName="CSchedule" TagPrefix="cs" %>
<%--<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>--%>
<%--<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>--%>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="Task" TagPrefix="uc8" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Department.ascx" TagName="Department" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/TimingSpecimen.ascx" TagName="TSpecimen" TagPrefix="ts" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>LabReceptionHome</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%-- <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>
    <%--    <script src="../Scripts/bid.js" type="text/javascript"></script>--%>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <%--   <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>--%>

    <script type="text/javascript" language="javascript">
        function SelectMaster() {
            if (document.getElementById('rdoTask').checked) {
                document.getElementById('trTask').style.display = 'table-row';
                document.getElementById('trSchedule').style.display = 'none';
                document.getElementById('trTimingSpecimen').style.display = 'none';
            }
            if (document.getElementById('rdoSchedules').checked) {
                document.getElementById('trSchedule').style.display = 'table-row';
                document.getElementById('trTask').style.display = 'none';
                document.getElementById('CSchedule_lblClientType').style.display = 'none';
                document.getElementById('CSchedule_drpClientType').style.display = 'none';
                document.getElementById('trTimingSpecimen').style.display = 'none';
            }
            if (document.getElementById('rdoTimingSpecimen').checked) {
                document.getElementById('trSchedule').style.display = 'none';
                document.getElementById('trTask').style.display = 'none';
                document.getElementById('trTimingSpecimen').style.display = 'table-row';
            }
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="RecHome" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p" style="border-color: Red">
            <tr>
                <td>
                    <table class="w-100p" style="border-color: Red">
                        <tr>
                            <td>
                                <asp:Panel ID="PnlHeader" CssClass="w-100p searchPanel" runat="server" 
                                    GroupingText="Select An Option" meta:resourcekey="PnlHeaderResource2">
                                    <asp:RadioButton runat="server" ID="rdoTask" Text="Task Details" GroupName="rdo"
                                        onclick="javascript:SelectMaster()" meta:resourcekey="rdoTaskResource2" />
                                    &nbsp
                                    <asp:RadioButton runat="server" ID="rdoSchedules" Text="Schedules" GroupName="rdo"
                                        onclick="javascript:SelectMaster()" 
                                        meta:resourcekey="rdoSchedulesResource2" />
                                    &nbsp
                                    <asp:RadioButton runat="server" ID="rdoTimingSpecimen" Text="TimingSpecimen" GroupName="rdo"
                                        onclick="javascript:SelectMaster()" Style="display: none;" 
                                        meta:resourcekey="rdoTimingSpecimenResource1" />
                                </asp:Panel>
                            </td>
                            <td>
                                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                                meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </td>
                        </tr>
                        <tr id="trTask" runat="server" style="display: none;">
                            <td colspan="3">
                                <asp:Panel ID="PnlPatientDetail" CssClass="w-100p" runat="server" 
                                    GroupingText="Task" meta:resourcekey="PnlPatientDetailResource2">
                                    <uc8:Task ID="UcTask" runat="server" />
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                &nbsp
                            </td>
                        </tr>
                        <tr id="trSchedule" runat="server" style="display: none;">
                            <td colspan="4">
                                <cs:CSchedule ID="CSchedule" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                &nbsp
                            </td>
                        </tr>
                        <tr id="trTimingSpecimen" runat="server" style="display: none;">
                            <td colspan="4">
                                <ts:TSpecimen ID="TSpecimen" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    
    </form>
</body>
</html>
