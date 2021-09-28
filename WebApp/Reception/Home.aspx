<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Reception_Home"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/PhySchedule.ascx" TagName="PSchedule" TagPrefix="ps" %>
<%--<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>--%>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%--<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="Task" TagPrefix="uc8" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/Department.ascx" TagName="Department" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/TimingSpecimen.ascx" TagName="TSpecimen" TagPrefix="ts" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Reception</title>
    <%-- <link href="../Images/favicon.ico" rel="shortcut icon" />--%>
    <%-- <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>
    <%--<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/bid.js" type="text/javascript"></script>--%>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <%--    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>--%>

    <script type="text/javascript" language="javascript">
   
    </script>

    <style type="text/css">
        .pager span
        {
            color: #000000;
            font-weight: bold;
            font-size: 10pt;
        }
    </style>
      <script type="text/javascript" language="javascript">
          function SelectMaster() {
              if (document.getElementById('rdoTask').checked) {
                document.getElementById('trTask').style.display = 'table-row';
                  document.getElementById('trTimingSpecimen').style.display = 'none';
              } 
              if (document.getElementById('rdoTimingSpecimen').checked) { 
                  document.getElementById('trTask').style.display = 'none';
                document.getElementById('trTimingSpecimen').style.display = 'table-row';
              }
          }
    </script>
</head>
<body oncontextmenu="return false;">
    <form id="RecHome" runat="server" defaultbutton="btnSearch">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table class="w-100p searchPanel" style="border-color: Red">
            <tr style="display: none">
                <td class="a-right" colspan="4">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Label runat="server" ID="lblPatientNo" Text="Patient Number" CssClass="label_title"
                                meta:resourcekey="lblPatientNoResource1"></asp:Label>
                            <asp:TextBox runat="server" ID="txtPatientNo" CssClass="small" MaxLength="16" meta:resourcekey="txtPatientNoResource1"></asp:TextBox>
                            <asp:Button runat="server" ID="btnSearch" Text="Go" CssClass="btn" OnClick="btnSearch_Click"
                                onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                                meta:resourcekey="btnSearchResource1" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td class="blackfontcolorbig h-32">
                    <asp:Label ID="Rs_TasksLists" Text="Task List" runat="server" meta:resourcekey="Rs_TasksListsResource1"></asp:Label>
                    <%-- <asp:LinkButton ID="itd" runat="server" PostBackUrl="~/Billing/GenerateBill.aspx">QuickBilling
                                    </asp:LinkButton>--%>
                    <uc2:Department ID="Department1" runat="server" />
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <%--<uc6:TaskControl ID="TaskControl1" runat="server" />--%>
                    <%-- <uc8:Task ID="TaskControl1" runat="server" />--%>
                    <table class="w-100p" style="border-color: Red">
                        <tr>
                            <td>
                                <asp:Panel ID="PnlHeader" runat="server" CssClass="w-100p" GroupingText="Select An Option" meta:resourcekey="PnlHeaderResource1">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:RadioButton runat="server" ID="rdoTask" Text="Task Details" GroupName="rdo"
                                                    onclick="javascript:SelectMaster()" Style="display: block;" Checked="true" meta:resourcekey="RdoTaskResource1"/>
                                            </td>
                                            <td>
                                                <asp:RadioButton runat="server" ID="rdoTimingSpecimen" Text="Timing Specimen" GroupName="rdo"
                                                    onclick="javascript:SelectMaster()" Style="display: none;" meta:resourcekey="RdoTimeResource1"/>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr id="trTask" runat="server" style="display: table-row;">
                            <td colspan="3">
                                <asp:Panel ID="PnlPatientDetail" runat="server" GroupingText="Task" meta:resourcekey="PnlpatientResource1">
                                    <uc6:TaskControl ID="UcTask" runat="server" />
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr id="trTimingSpecimen" runat="server" style="display: none;">
                            <td colspan="4">
                                <asp:Panel ID="Panel1" runat="server" GroupingText="Timing Specimen">
                                    <ts:TSpecimen ID="TSpecimen" runat="server" />
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                    <%-- <a href="../Billing/GenerateBill.aspx?PID=6046&VID=10100&PNAME=&vType=IP&BP=N"  >Select Here</a>--%>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td class="a-left v-top style1 w-50p">
                    <div class="colorforcontent w-23p" style="display: block" id="ACX2plusFup">
                        <span>&nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top"
                            style="cursor: pointer" onclick="showResponses('ACX2plusFup','ACX2minusFup','ACX2responsesFup',1);" />
                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusFup','ACX2minusFup','ACX2responsesFup',1);">
                                &nbsp;<asp:Label ID="Rs_Followup1" runat="server" Text="Patient Follow up" meta:resourcekey="Rs_Followup1Resource1"></asp:Label></span></span>
                    </div>
                    <div class="colorforcontent w-23p" style="display: none" id="ACX2minusFup">
                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top" style="cursor: pointer"
                            onclick="showResponses('ACX2plusFup','ACX2minusFup','ACX2responsesFup',0);" />
                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusFup','ACX2minusFup','ACX2responsesFup',0);">
                            &nbsp;<asp:Label ID="Rs_Followup2" runat="server" Text="Patient Follow up" meta:resourcekey="Rs_Followup2Resource1"></asp:Label></span>
                    </div>
                    <div class="w-100p" style="display: none;" id="ACX2responsesFup" title="Patient Follow up"
                        runat="server">
                        <asp:UpdatePanel ID="updatePanel2" runat="server">
                            <ContentTemplate>
                                <asp:Label ID="lblFollowUpPeriod" runat="server" Text="Follow up" meta:resourcekey="lblFollowUpPeriodResource1"></asp:Label>
                                <asp:DropDownList ID="ddlFollowUpPeriod" CssClass="ddlTheme" runat="server" meta:resourcekey="ddlFollowUpPeriodResource1">
                                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource1">Next 1 Day</asp:ListItem>
                                    <asp:ListItem Value="2" meta:resourcekey="ListItemResource2">Next 1 Week</asp:ListItem>
                                </asp:DropDownList>
                                <asp:Button ID="btnSubmit" runat="server" Text="Go" CssClass="btn1" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                <br />
                                <br />
                                <asp:GridView ID="gvIPCreditMain" runat="server" CssClass="gridView w-50p m-auto"
                                    AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanging="gvIPCreditMain_PageIndexChanging"
                                    OnRowCancelingEdit="gvIPCreditMain_RowCancelingEdit" PageSize="10" OnRowDataBound="gvIPCreditMain_RowDataBound"
                                     ForeColor="#333333">
                                    <%--<PagerStyle HorizontalAlign="Center" BackColor="AliceBlue" />--%>
                                    <HeaderStyle CssClass="dataheader1 v-top" />
                                    <PagerSettings Mode="NumericFirstLast" />
                                    <Columns>
                                        <asp:BoundField DataField="PatientNumber" HeaderText="S.No." />
                                        <asp:BoundField DataField="PatientName" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                            <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Age" HeaderText="Age" meta:resourcekey="BoundFieldResource3">
                                            <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="IPNumber" HeaderText="IP No" meta:resourcekey="BoundFieldResource4" />
                                        <asp:BoundField DataField="Address" HeaderText="Address" meta:resourcekey="BoundFieldResource5" />
                                        <asp:BoundField DataField="ContactNumber" HeaderText="Contact Number">
                                            <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ConsultantName" HeaderText="Consultant Name" meta:resourcekey="BoundFieldResource7" />
                                        <asp:BoundField DataField="SpecialityName" HeaderText="Speciality" meta:resourcekey="BoundFieldResource8" />
                                        <asp:BoundField DataField="ADMDiagnosis" HeaderText="Diagnosis" Visible="False" meta:resourcekey="BoundFieldResource9" />
                                        <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Review Date"
                                            meta:resourcekey="BoundFieldResource11" />
                                        <asp:BoundField DataField="VisitType" HeaderText="Type" meta:resourcekey="BoundFieldResource12" />
                                    </Columns>
                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                    <PagerStyle BackColor="White" CssClass="pager" ForeColor="#000066" HorizontalAlign="Left" />
                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" Font-Underline="false" ForeColor="#ff0000"
                                        HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
                <td>
                    &nbsp;
                </td>
                <td class="a-left v-top">
                    <div class="colorforcontent w-35p" style="display: block" id="divFollow1">
                        <span>&nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top"
                            style="cursor: pointer" onclick="showResponses('divFollow1','divFollow2','divFollow3',1);" />
                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('divFollow1','divFollow2','divFollow3',1);">
                                &nbsp;<asp:Label ID="Label1" runat="server" Text="Physiotherapist Follow up" meta:resourcekey="lblPhyFollowUpPeriodResource1"></asp:Label></span></span>
                    </div>
                    <div class="colorforcontent w-35p" style="display: none" id="divFollow2">
                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top"
                            style="cursor: pointer" onclick="showResponses('divFollow1','divFollow2','divFollow3',0);" />
                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('divFollow1','divFollow2','divFollow3',0);">
                            &nbsp;<asp:Label ID="Label2" runat="server" Text="Physiotherapist Follow up" meta:resourcekey="lblPhyFollowUpPeriodResource1"></asp:Label></span>
                    </div>
                    <div class="w-100p" style="display: none;" id="divFollow3" title="Physiotherapist Follow up"
                        runat="server">
                        <asp:UpdatePanel ID="updatePanel3" runat="server">
                            <ContentTemplate>
                                <asp:Label ID="Label3" runat="server" Text="Follow up" meta:resourcekey="lblFollowUpPeriodResource1"></asp:Label>
                                <asp:DropDownList ID="ddlFollowPhy" CssClass="ddlTheme ddlsmall" runat="server" meta:resourcekey="ddlFollowUpPeriodResource1">
                                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource1">Next 1 Day</asp:ListItem>
                                    <asp:ListItem Value="2" meta:resourcekey="ListItemResource2">Next 1 Week</asp:ListItem>
                                </asp:DropDownList>
                                <asp:Button ID="btnPhyGO" runat="server" Text="Go" CssClass="btn1" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClick="btnPhyGO_Click" meta:resourcekey="btnSubmitResource1"/>
                                <br />
                                <br />
                                <asp:GridView ID="gvIPPhyMain" runat="server" AutoGenerateColumns="False" OnPageIndexChanging="gvIPPhyMain_PageIndexChanging"
                                    OnRowCancelingEdit="gvIPPhyMain_RowCancelingEdit" PageSize="10" OnRowDataBound="gvIPPhyMain_RowDataBound"
                                    class="gridView w-20p m-auto" EmptyDataText="No Record Found" AllowPaging="True" CellPadding="1">
                                    <HeaderStyle CssClass="dataheader1 v-top" />
                                    <PagerSettings Mode="NumericFirstLast" />
                                    <Columns>
                                        <asp:BoundField DataField="PatientNumber" HeaderText="S.No." />
                                        <asp:BoundField DataField="PatientName" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                            <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Age" HeaderText="Age" meta:resourcekey="BoundFieldResource3">
                                            <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="IPNumber" HeaderText="IP No" meta:resourcekey="BoundFieldResource4" />
                                        <asp:BoundField DataField="Address" HeaderText="Address" meta:resourcekey="BoundFieldResource5" />
                                        <asp:BoundField DataField="ContactNumber" HeaderText="ContactNumber" meta:resourcekey="BoundFieldResource6">
                                            <ItemStyle HorizontalAlign="Left" Wrap="False"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ConsultantName" HeaderText="Consultant Name" meta:resourcekey="BoundFieldResource7" />
                                        <asp:BoundField DataField="SpecialityName" HeaderText="Speciality" meta:resourcekey="BoundFieldResource8" />
                                        <asp:BoundField DataField="ADMDiagnosis" HeaderText="Diagnosis" Visible="False" meta:resourcekey="BoundFieldResource9" />
                                        <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Review Date"
                                            meta:resourcekey="BoundFieldResource11" />
                                        <asp:BoundField DataField="VisitType" HeaderText="Type" meta:resourcekey="BoundFieldResource12" />
                                    </Columns>
                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                    <PagerStyle BackColor="White" CssClass="pager" ForeColor="#000066" HorizontalAlign="Left" />
                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <ps:PSchedule ID="phySch" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
