<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CorporatePatientSearch.aspx.cs"
    Inherits="Corporate_CorporatePatientSearch" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/CorporatePatientSearch.ascx" TagName="PatientSearch"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Patient Search</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
 <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script type="text/javascript">
        function ShowAll() {
            if (document.getElementById("uctlPatientSearch_hdnPatientID").value == '') {
                alert('Select patient name');
                return false;
            }
            else {
                document.getElementById("hdnPatientID").value = document.getElementById("uctlPatientSearch_hdnPatientID").value;
                var pid = document.getElementById("hdnPatientID").value;
                var vid = document.getElementById("hdnVisitID").value;
                vType = 'IP';
                var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
                strFeatures = strFeatures + ",scrollbars=No,resizable=yes,height=600,width=800,left=0,top=0";
                window.open("../Physician/ViewConsolidateCaseSheet.aspx?vid=" + vid + "&pid=" + pid + "&vType=" + vType + "&IsPopup=Y" + "", "", strFeatures);
                return false;
            }
        }
        function ValidatePatientName() {
            var AgeLimit = document.getElementById("hdnPatientAgeLimit").value;
            var PatientAge = document.getElementById("uctlPatientSearch_hdnpDOB").value.split(' ');
            var PatientMStatus = document.getElementById("uctlPatientSearch_hdnpMstatus").value
            var Dependents = document.getElementById("uctlPatientSearch_hdnpType").value
            var Status = document.getElementById("uctlPatientSearch_hdnStatus").value
            var sets = document.getElementById("dList").selectedIndex;
            if (document.getElementById("uctlPatientSearch_hdnPatientID").value == '') {
                alert('Select patient name');
                return false;
            }

            var sServiceBasedOnAgeMessage = 'Service cannot be placed as the dependent is above the configured limit of ' + AgeLimit + ' years.';
            if (sets == "1") {
                if (Status.trim() == 'D') {
                    alert('Service or Visit cannot be done as the patient is in Inactive status');
                    return false;
                }
                if (Dependents.trim() == 'D') {
                    if (AgeLimit.trim() < PatientAge[0].trim() && PatientMStatus == 'M') {
                        alert(sServiceBasedOnAgeMessage);
                        return false;
                    }
                    if (AgeLimit.trim() > PatientAge[0].trim() && PatientMStatus == 'M') {
                        alert(sServiceBasedOnAgeMessage);
                        return false;
                    }
                }
                if (Dependents.trim() == 'S') {
                    if (AgeLimit.trim() < PatientAge[0].trim()) {
                        alert(sServiceBasedOnAgeMessage);
                        return false;
                    }
                }
            }
        }        
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server" defaultbutton="btnSearch1">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="UsrHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
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
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="up1" runat="server">
                            <ContentTemplate>
                                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="up1" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter">
                                        </div>
                                        <div align="center" id="processMessage">
                                            <asp:Label ID="Rs_Loading" Text="Loading..." runat="server" meta:resourcekey="Rs_LoadingResource1" />
                                            <br />
                                            <br />
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <uc2:PatientSearch ID="uctlPatientSearch" runat="server" />
                                        </td>
                                    </tr>
                                    <tr style="display: none;">
                                        <td>
                                            <asp:Label ID="lblloctaion" Text="Location" runat="server" meta:resourcekey="lblloctaionResource1"></asp:Label>
                                            <asp:DropDownList ID="ddlLocatiopn" runat="server" CssClass="ddlsmall" meta:resourcekey="ddlLocatiopnResource1">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr id="aRow" runat="server" style="display: none">
                                        <td id="Td1" class="defaultfontcolor" runat="server">
                                            <asp:Label ID="Rs_Selectapatient" Text="Select a Patient and Choose one of the following"
                                                runat="server" />
                                            <asp:DropDownList ID="dList" runat="server" CssClass="ddlsmall">
                                            </asp:DropDownList>
                                            <asp:Button ID="bGo" runat="server" Text="Go" CssClass="btn" OnClientClick="return ValidatePatientName()"
                                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="bGo_Click" />
                                            <asp:Button ID="btnSearch1" Visible="False" runat="server" />
                                        </td>
                                    </tr>
                                    <tr id="tdSelect" style="display:none" runat="server">
                                    <td align="center" >
                                    <asp:Button ID="btnShowAll" runat="server" Text="Show Previous Visit" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                     OnClientClick="return ShowAll()" onmouseout="this.className='btn'"/>
                                    </td>
                                    </tr>
                                </table>
                                <asp:HiddenField ID="hdnPatientAgeLimit" runat="server" />
                                <asp:Button ID="btnNoLog" runat="server" Style="display: none" meta:resourcekey="btnNoLogResource1" />
                                <div id="divPanel">
                                    <asp:Panel ID="pnlPatient1" runat="server" ScrollBars="Both" CssClass="modalPopup dataheaderPopup"
                                        Width="80%" Style="display: none; top: 400px; height: 400px">
                                        <table cellpadding="2" cellspacing="0"
                                            border="0" width="100%" runat="server" class="dataheaderInvCtrl">
                                            <tr class="defaultfontcolor">
                                                <td>
                                                    <asp:GridView ID="gvPrevVisitDetail" EmptyDataText="No Record Found" runat="server"
                                                        Width="100%" CellPadding="4" CssClass="mytable1" AutoGenerateColumns="False"
                                                        ForeColor="#333333" HorizontalAlign="Left" OnRowDataBound="gvPrevVisitDetail_RowDataBound">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Date" meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblNextReview" Text='<%# Eval("NextReview") %>' runat="server" Width="74px"
                                                                        meta:resourcekey="lblNextReviewResource1"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Procedure Name" meta:resourcekey="TemplateFieldResource2">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblProcedureNames" Text='<%# Eval("ProcedureName") %>' runat="server"
                                                                        Width="74px" meta:resourcekey="lblProcedureNamesResource1"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Sitting" meta:resourcekey="TemplateFieldResource3">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblAdvisedNoOfSitting" Text='<%# Eval("HasPending") %>' runat="server"
                                                                        Width="74px" meta:resourcekey="lblAdvisedNoOfSittingResource1"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Duration" meta:resourcekey="TemplateFieldResource4">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblDuration" Text='<%# Eval("Duration") %>' runat="server" Width="74px"
                                                                        meta:resourcekey="lblDurationResource1"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Physiotherapy Notes" meta:resourcekey="TemplateFieldResource5">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblPhysioNote" Text='<%# Eval("Remarks") %>' runat="server" Width="74px"
                                                                        meta:resourcekey="lblPhysioNoteResource1"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Location" meta:resourcekey="TemplateFieldResource6">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblRemarks" Text='<%# Eval("Status") %>' runat="server" Width="74px"
                                                                        meta:resourcekey="lblRemarksResource1"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Symptoms / History" meta:resourcekey="TemplateFieldResource7">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblSymptoms" Text='<%# Eval("Symptoms") %>' runat="server" Width="74px"
                                                                        meta:resourcekey="lblSymptomsResource1"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Referring Physician Comments" meta:resourcekey="TemplateFieldResource8">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblPhysicianComments" Text='<%# Eval("PhysicianComments") %>' runat="server"
                                                                        Width="74px" meta:resourcekey="lblPhysicianCommentsResource1"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                                        <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="gvPrevDiagnose" EmptyDataText="No Record Found" runat="server"
                                                        Width="100%" CellPadding="4" CssClass="mytable1" AutoGenerateColumns="False"
                                                        ForeColor="#333333" HorizontalAlign="Left">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Clinical Diagnosis " meta:resourcekey="TemplateFieldResource9">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblComplaintNamePrev" Text='<%# Eval("ComplaintName") %>' runat="server"
                                                                        meta:resourcekey="lblComplaintNamePrevResource1"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="ICDCode" Visible="False" meta:resourcekey="TemplateFieldResource10">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblICDCodePrev" Text='<%# Eval("ICDCode") %>' runat="server" meta:resourcekey="lblICDCodePrevResource1"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="ICD 10 Description" Visible="False" meta:resourcekey="TemplateFieldResource11">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblICDDescription" Text='<%# Eval("ICDDescription") %>' runat="server"
                                                                        meta:resourcekey="lblICDDescriptionResource1"></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                                        <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center">
                                                    <input type="button" id="btnCancel" class="btn"
                                                        runat="server" value="Close" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>
                                <ajc:ModalPopupExtender ID="ModelPopPatient" runat="server" TargetControlID="hiddenTargetControlFormpeOthers"
                                    PopupControlID="pnlPatient1" BackgroundCssClass="modalBackground" CancelControlID="btnCancel"
                                    DynamicServicePath="" Enabled="True" />
                                <input type="button" id="btnR" runat="server" style="display: none;" />
                                <asp:HiddenField ID="hiddenTargetControlFormpeOthers" runat="server" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <input type="hidden" id="hdnPatientID" name="pid" runat="server" />
        <input type="hidden" id="hdnVisitID" name="pvid" runat="server" />
        <uc5:Footer ID="Footer1" runat="server" />
    </form>
</body>
</html>
