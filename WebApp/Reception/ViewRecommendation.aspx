<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewRecommendation.aspx.cs"
    Inherits="Reception_ViewRecommendation" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ccRec" %>
<%@ Register Src="~/CommonControls/PhySchedule.ascx" TagName="PSchedule" TagPrefix="ps" %>
<%@ Register Src="~/CommonControls/RelatedSchedulesControl.ascx" TagName="RelSchedules"
    TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Theme.ascx" TagName="Theme" TagPrefix="t1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

<script type="text/javascript" src="../Scripts/animatedcollapse.js"></script>

<script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

<script src="../Scripts/Common.js" type="text/javascript"></script>

<script src="../Scripts/bid.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
    function winClose() {

        window.close();
    }

    function valid() {

        var chk = document.getElementById('txt_Remarks').value;
        if (chk == "") {
            var userMsg = SListForApplicationMessages.Get('Reception\\ViewRecommendation.aspx_1');
            if (userMsg != null) {
                alert(userMsg);
            }
            else { alert('Provide the remarks'); }
            return false;
        }

    }
</script>

<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="display: none;">
        <t1:Theme ID="Theme1" runat="server" />
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <%--<Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click"></asp:AsyncPostBackTrigger>
                            <asp:AsyncPostBackTrigger ControlID="bCancel" EventName="Click"></asp:AsyncPostBackTrigger>
                        </Triggers>--%>
        <ContentTemplate>
            <div class="contentdatapopup">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="dataheaderInvCtrl">
                    <tr>
                        <td align="center">
                            <br />
                            <br />
                            <asp:HiddenField ID="hdnValues" runat="server" />
                            <asp:GridView ID="grdResult" Width="100%" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                ForeColor="#333333" CssClass="mytable1" 
                                meta:resourcekey="grdResultResource1">
                                <HeaderStyle CssClass="dataheader1" />
                                <PagerStyle CssClass="dataheader1" />
                                <Columns>
                                    <asp:TemplateField HeaderText="SNO" meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_SequenceNO" runat="server" Text='<%# Eval("SequenceNO") %>' 
                                                Font-Size="Small" meta:resourcekey="lbl_SequenceNOResource1"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle Width="2%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Recommendation" 
                                        meta:resourcekey="TemplateFieldResource2">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_details" runat="server" Text='<%# Eval("ResultValues") %>' 
                                                Font-Size="Small" meta:resourcekey="lbl_detailsResource1"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" valign="middle">
                            <asp:Label ID="lbl_remarks" runat="server" Font-Size="Medium" Text="Remarks:" 
                                ForeColor="#3399FF" meta:resourcekey="lbl_remarksResource1"></asp:Label>
                            <asp:TextBox ID="txt_Remarks" runat="server" TextMode="MultiLine" Height="59px" MaxLength="240"
                                Style="margin-left: 0px" Width="306px" 
                                meta:resourcekey="txt_RemarksResource1"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="trABI" runat="server" CssClass="defaultfontcolor" 
                    meta:resourcekey="trABIResource1">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td align="left" colspan="2" height="23" class="colorforcontent">
                                <div id="ACX2plusOmc" style="display: none; width: 100%;">
                                    &nbsp;<img align="top" alt="Show" height="15" onclick="showResponses('ACX2plusOmc','ACX2minusOmc','ACX2responsesOmc',1);"
                                        src="../Images/showBids.gif" style="cursor: pointer" width="15" />
                                    <span class="dataheader1txt" onclick="showResponses('ACX2plusOmc','ACX2minusOmc','ACX2responsesOmc',1);"
                                        style="cursor: pointer; width: 100%"><asp:Label ID="Rs_Schedules" 
                                        Text="Schedules" runat="server" meta:resourcekey="Rs_SchedulesResource1"></asp:Label></span>
                                </div>
                                <div id="ACX2minusOmc" style="display: block; width: 100%;">
                                    &nbsp;<img align="top" alt="hide" height="15" onclick="showResponses('ACX2plusOmc','ACX2minusOmc','ACX2responsesOmc',0);"
                                        src="../Images/hideBids.gif" style="cursor: pointer" width="15" />
                                    <span class="dataheader1txt" onclick="showResponses('ACX2plusOmc','ACX2minusOmc','ACX2responsesOmc',0);"
                                        style="cursor: pointer"><asp:Label ID="Rs_Schedules1" Text="Schedules" 
                                        runat="server" meta:resourcekey="Rs_Schedules1Resource1"></asp:Label></span>
                                </div>
                            </td>
                        </tr>
                        <tr id="ACX2responsesOmc" class="tablerow" style="display: block">
                            <td colspan="3">
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="dataheaderInvCtrl">
                                    <tr>
                                        <td align="center">
                                            <div id="bookedSlots" runat="server" visible="False">
                                               <asp:Label ID="Rs_BookedSlots" Text="Booked Slots" runat="server" 
                                                    meta:resourcekey="Rs_BookedSlotsResource1"></asp:Label></div>
                                            <asp:GridView ID="gvBookedSlots" runat="server" AutoGenerateColumns="False" ForeColor="#333333"
                                                Width="85%" meta:resourcekey="gvBookedSlotsResource1">
                                                <HeaderStyle CssClass="dataheader1" />
                                                <PagerStyle CssClass="dataheader1" />
                                                <Columns>
                                                    <asp:BoundField HeaderText="Appointment For" DataField="PhysicianName" 
                                                        meta:resourcekey="BoundFieldResource1">
                                                        <HeaderStyle HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Date" DataField="NextOccurance" 
                                                        DataFormatString="{0:dd/MM/yyyy}" meta:resourcekey="BoundFieldResource2">
                                                        <HeaderStyle HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="From Time" DataField="From" 
                                                        DataFormatString="{0:hh:mm tt}" meta:resourcekey="BoundFieldResource3">
                                                        <HeaderStyle HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="To Time" DataField="To" 
                                                        DataFormatString="{0:hh:mm tt}" meta:resourcekey="BoundFieldResource4">
                                                        <HeaderStyle HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Token No." DataField="TotalSlots" 
                                                        meta:resourcekey="BoundFieldResource5">
                                                        <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                                        <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" style="width: 100%">
                                            <div id="DVallSchedules" style="width: 100%" runat="server">
                                                <ps:PSchedule ID="phySch" runat="server" PreviousHiddenField="hdnSelectedSchedules"
                                                    CurrentDIV="DVallSchedules" NextDIV="DVRelated" />
                                            </div>
                                            <div id="DVRelated" runat="server" style="display: none; width: 100%;">
                                                <uc6:RelSchedules ID="rtschedules" runat="server" CurrentDIV="DVRelated" NextDIV="DVallSchedules">
                                                </uc6:RelSchedules>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <div align="center">
                    <asp:Button ID="btnSearch" runat="server" Text="OK" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                        onmouseout="this.className='btn1'" Width="55px" OnClientClick="javascript:return valid()"
                        OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                    &nbsp;&nbsp;
                    <input type="hidden" id="hdnName" runat="server" >
                        <input id="hdnPatientNo" runat="server" type="hidden"></input>
                            <input id="hdnPatientID" runat="server" type="hidden"></input>
                                <input id="hdnStatus" runat="server" type="hidden"></input>
                                    <input id="hdnTitle" runat="server" type="hidden"></input>
                                        <a href="javascript:winClose();" 
                                            style="cursor: pointer; text-decoration: none; font-weight: bold; color: Blue;">
                                        <asp:Label ID="Rs_CloseWindow" runat="server" 
                                            meta:resourcekey="Rs_CloseWindowResource1" Text="Close Window"></asp:Label>
                                        </a></input>
                                </input>
                            </input>
                        </input>
                    </input>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    </form>

    <script type="text/javascript" type="text/javascript">
        closepopup();
        function closepopup() {

            if (document.getElementById('hdnValues').value == 'Y') {
                window.opener.document.forms[0].submit();
                window.close();
                return false;
            }
            if (document.getElementById('hdnValues').value == 'N') {
                var userMsg = SListForApplicationMessages.Get('Reception\\ViewRecommendation.aspx_2');
                if (userMsg != null) {
                    alert(userMsg);
                } else {
                    alert('Updation failed');
                }
                return false;
            }
        }
    </script>

</body>
</html>
