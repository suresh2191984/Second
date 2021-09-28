<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationQueue.aspx.cs"
    Inherits="Lab_InvestigationQueue" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Investigation Queue</title>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        //var objAlert = SListForAppMsg.Get("Admin_RateTypeMaster_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_RateTypeMaster_aspx_Alert");
       
        function selectvisitid(rid, patvid, pid) {
            chosen = "";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
            document.getElementById('rdoRetest').checked = true;
            document.getElementById('hdnSelectedVisitID').value = patvid;
            document.getElementById('hdnvid').value = patvid;
            document.getElementById('hdnPatientID').value = pid;
        }
        function GetPatientDetails(PID) {

            var pID = PID.split('~');
            if (pID.length > 1) {
                document.getElementById('hdnSearchPatientID').value = '';
                document.getElementById('hdnSearchPatientID').value = pID[1];
            }
            else {
                pID = document.getElementById('hdnSearchPatientID').value = '';
            }
        }
        function ValidateFields() {
            var InformationMsg = SListForAppMsg.Get("Lab_InvestigationQueue_aspx_Information") == null ? "Information" : SListForAppMsg.Get("Lab_InvestigationQueue_aspx_Information");
            if (document.getElementById('hdnSelectedVisitID').value == '') {
                
                var userMsg = SListForAppMsg.Get("Lab_InvestigationQueue_aspx_01") == null ? "Select the patient" : SListForAppMsg.Get("Lab_InvestigationQueue_aspx_01");
                ValidationWindow(userMsg , InformationMsg);
             
                //alert('Select the patient');
                return false;
            }
        }
        function ClearPatientDetails() {
            document.getElementById('hdnSearchPatientID').value = '';
            document.getElementById('txtPatientName').value = '';
        }
        function SelectedPatienttemp(source, eventArgs) {
            PatientDetails = eventArgs.get_text().split('~');
            if (PatientDetails.length > 1) {
                document.getElementById('hdnSearchPatientID').value = '';
                document.getElementById('txtPatientName').value = PatientDetails[0];
                document.getElementById('hdnSearchPatientID').value = PatientDetails[1];
            }
            else {
                document.getElementById('hdnSearchPatientID').value = '';
                document.getElementById('txtPatientName').value = '';
            }
        }
    </script>

    <style type="text/css">
        .style1
        {
            height: 32px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/InventoryWebService.asmx" />
        </Services>
    </asp:ScriptManager>
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <table class="defaultfontcolor w-100p">
                            <tr>
                                <td colspan="3">
                                    <asp:Panel ID="pnlFilter" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlFilterResource1">
                                        <table class="defaultfontcolor w-100p searchPanel">
                                            <tr>
                                                <td class="colorforcontent w-30p h-23 a-left">
                                                    <div id="ACX2plus1" style="display: none;">
                                                        &nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);" />
                                                        <span class="dataheader1txt pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);">
                                                            &nbsp;<%--Filter Result--%><%=Resources.Lab_ClientDisplay.Lab_InvestigationQueue_aspx_002%></span>
                                                    </div>
                                                    <div id="ACX2minus1" style="display: block;">
                                                        &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);" />
                                                        <span class="dataheader1txt pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);">
                                                        &nbsp;<%--Filter Result--%><%=Resources.Lab_ClientDisplay.Lab_InvestigationQueue_aspx_002%>
                                                    </div>
                                                </td>
                                                
                                            </tr>
                                            <tr class="tablerow" id="ACX2responses1" style="display: table-row;">
                                                <td colspan="2">
                                                    <div class="filterdataheader2 font14" style="font-family: Verdana;">
                                                        <table class="defaultfontcolor w-100p margin6">
                                                            <tr>
                                                                <td colspan="9" style="display: none">
                                                                    <asp:RadioButton ID="rdoRetest" Text="Retest" runat="server" GroupName="TestType"
                                                                        meta:resourcekey="rdoRetestResource1" />
                                                                    <asp:RadioButton ID="rdoRefelectTest" Text="Reflex Test" runat="server" GroupName="TestType"
                                                                        meta:resourcekey="rdoRefelectTestResource1" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblPatientName" Text="Patient Name:" runat="server" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtPatientName" CssClass="Txtboxsmall" runat="server" onfocus="javascript:ClearPatientDetails();"
                                                                        onblur="ConverttoUpperCase(this.id); GetPatientDetails(this.value);" TabIndex="1"
                                                                        meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtPatientName"
                                                                        EnableCaching="False" FirstRowSelected="True" CompletionInterval="100" MinimumPrefixLength="2"
                                                                        CompletionListCssClass="listtwo" CompletionListItemCssClass="listitemtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                                                        OnClientItemOver="SelectedPatienttemp" ServiceMethod="GetPatientListWithDetails"
                                                                        ServicePath="~/InventoryWebService.asmx" DelimiterCharacters="" Enabled="True">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblBillNumber" Text="Visit Number:" runat="server" 
                                                                        meta:resourcekey="lblBillNumberResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtBillNumber" CssClass="Txtboxsmall" runat="server" TabIndex="2"
                                                                        meta:resourcekey="txtBillNumberResource1"></asp:TextBox>
                                                                </td>
                                                                <td style="display: none">
                                                                    <asp:Label ID="lblSampleName" Text="Sample Name :" runat="server" meta:resourcekey="lblSampleNameResource1"></asp:Label>
                                                                </td>
                                                                <td style="display: none">
                                                                    <asp:DropDownList ID="ddlSampleName" CssClass="ddlsmall" runat="server" ToolTip="Select Sample"
                                                                        TabIndex="3" meta:resourcekey="ddlSampleNameResource1">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblSourceName" Text="Client Name:" runat="server" meta:resourcekey="lblSourceNameResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddClientName" CssClass="ddlsmall" runat="server" meta:resourcekey="ddClientNameResource1">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Rs_From" Text="From Date :" runat="server" meta:resourcekey="Rs_FromResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <table border="0" cellpadding="2" cellspacing="1" width="100%">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:TextBox runat="server" CssClass="Txtboxsmall" ID="txtFrom" MaxLength="25" size="20"
                                                                                    meta:resourcekey="txtFromResource1"></asp:TextBox>
                                                                                <a href="javascript:NewCssCal('<%=txtFrom.ClientID %>','ddmmyyyy','arrow',true,12,'Y','Y')">
                                                                                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Rs_To" Text="To Date :" runat="server" meta:resourcekey="Rs_ToResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <table class="w-100p">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:TextBox runat="server" CssClass="Txtboxsmall" ID="txtTo" MaxLength="25" size="20"
                                                                                    meta:resourcekey="txtToResource1"></asp:TextBox>
                                                                                <a href="javascript:NewCssCal('<%=txtTo.ClientID %>','ddmmyyyy','arrow',true,12,'Y','N')">
                                                                                    <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblddlocation" Text="Location" runat="server" meta:resourcekey="lblddlocationResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlocation" CssClass="ddlsmall" runat="server" meta:resourcekey="ddlocationResource2">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblPreference" Text="Preference :" runat="server" 
                                                        meta:resourcekey="lblPreferenceResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <span class="richcombobox w-80">
                                                        <asp:DropDownList ID="ddlPriority" CssClass="ddl w-80" runat="server" 
                                                        meta:resourcekey="ddlPriorityResource1">
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblTestType" Text="TestType" runat="server" 
                                                        meta:resourcekey="lblTestTypeResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlTestType" CssClass="ddlsmall" runat="server" 
                                                        meta:resourcekey="ddlTestTypeResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="a-center">
                                                    <asp:Button ID="btnSearch" CssClass="btn" runat="server" Text="Search" OnClick="btnSearch_Click"
                                                        TabIndex="4" meta:resourcekey="btnSearchResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                         </table>
                          <table class="w-100p">
                    <tr>
                        <td>
                            <asp:GridView ID="grdMain" EmptyDataText="No Results Found." EmptyDataRowStyle-CssClass="dataheader1"
                                runat="server" CssClass="mytable1 w-100p gridView" AutoGenerateColumns="False" OnRowDataBound="grdMain_RowDataBound"
                                meta:resourcekey="grdMainResource1">
                                <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                <HeaderStyle CssClass="dataheader1" />
                                <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                    PageButtonCount="5" PreviousPageText="" />
                                <EmptyDataRowStyle CssClass="dataheader1"></EmptyDataRowStyle>
                                <Columns>
                                    <asp:BoundField Visible="false" DataField="PatientID" HeaderText="Patient ID" 
                                        meta:resourcekey="BoundFieldResource1" />
                                    <asp:TemplateField HeaderText="VisitID" Visible="false" ItemStyle-HorizontalAlign="Left"
                                        HeaderStyle-Width="20px" meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <asp:Label ID="lblVisitID" runat="server" Text='<%# Eval("VisitID") %>' 
                                                meta:resourcekey="lblVisitIDResource1" />
                                        </ItemTemplate>
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Left" 
                                        HeaderStyle-Width="20px" meta:resourcekey="TemplateFieldResource2">
                                        <ItemTemplate>
                                            <asp:RadioButton ID="rdoSel" runat="server" ToolTip="Select Patient" 
                                                GroupName="PatientVisitSelect" meta:resourcekey="rdoSelResource1" />
                                        </ItemTemplate>
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" ItemStyle-HorizontalAlign="Left"
                                        HeaderStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource2">
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BillNumber" HeaderText="Bill No" ItemStyle-HorizontalAlign="Left"
                                        HeaderStyle-HorizontalAlign="Left" Visible="false" 
                                        meta:resourcekey="BoundFieldResource3">
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ReferingPhysicianName" HeaderText="VisitNumber" ItemStyle-HorizontalAlign="Left"
                                        HeaderStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource4">
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PatientName" HeaderText="Patient Name" ItemStyle-HorizontalAlign="Left"
                                        HeaderStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource5">
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PhoneNo" HeaderText="PhoneNo" ItemStyle-HorizontalAlign="Left"
                                        HeaderStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource6">
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Investigation Name" ItemStyle-HorizontalAlign="Left"
                                        HeaderStyle-HorizontalAlign="Left" 
                                        meta:resourcekey="TemplateFieldResource3">
                                        <ItemTemplate>
                                            <asp:Label ID="lblInvestigationName" Text='<%# Eval("InvestigationName") %>' 
                                                runat="server" meta:resourcekey="lblInvestigationNameResource1"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status" 
                                        meta:resourcekey="TemplateFieldResource4">
                                            <ItemTemplate>
                                            <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>' 
                                                    style="display:none;" meta:resourcekey="lblStatusResource1"></asp:Label>
                                            <asp:Label ID="lblDisplayStatus" runat="server" Text='<%# Eval("DisplayStatus") %>' 
                                                    meta:resourcekey="lblDisplayStatusResource1"></asp:Label>
                                                <asp:HiddenField ID="hdnStatus" runat="server" Value='<%# Eval("Status") %>'></asp:HiddenField>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:TemplateField>
                                    <asp:TemplateField HeaderText="InvestigationID" Visible="false" 
                                        meta:resourcekey="TemplateFieldResource5">
                                        <ItemTemplate>
                                            <asp:Label ID="lblInvestigationID" Text='<%# Eval("InvestigationIDs") %>' 
                                                runat="server" meta:resourcekey="lblInvestigationIDResource1"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="AccessionNumber" Visible="false" 
                                        meta:resourcekey="TemplateFieldResource6">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAccessionNumber" Text='<%# Eval("AccessionNumbers") %>' 
                                                runat="server" meta:resourcekey="lblAccessionNumberResource1"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="OrderedUID" Visible="false" 
                                        meta:resourcekey="TemplateFieldResource7">
                                        <ItemTemplate>
                                            <asp:Label ID="lblOrderedUID" Text='<%# Eval("OrderedUID") %>' runat="server" 
                                                meta:resourcekey="lblOrderedUIDResource1"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="RootUID" Visible="false" 
                                        meta:resourcekey="TemplateFieldResource8">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRootUID" Text='<%# Eval("UID") %>' runat="server" 
                                                meta:resourcekey="lblRootUIDResource1"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Location" HeaderText="Location" ItemStyle-HorizontalAlign="Left"
                                        HeaderStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource7">
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd/MMM/yy hh:mm tt}" HeaderText="Visit Date"
                                        ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" 
                                        meta:resourcekey="BoundFieldResource8">
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Type" Visible="false" 
                                        meta:resourcekey="TemplateFieldResource9">
                                        <ItemTemplate>
                                            <asp:Label ID="lbltype" Text='<%# Eval("Type") %>' runat="server" 
                                                meta:resourcekey="lbltypeResource1"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Reason" 
                                        meta:resourcekey="TemplateFieldResource99">
                                        <ItemTemplate>
                                            <asp:Label ID="lblReason" Text='<%# Eval("Reason") %>' runat="server" 
                                                meta:resourcekey="lblReasonResource1"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr id="aRow" style="display: none;" runat="server">
                        <td id="Td1" class="defaultfontcolor" runat="server" align="center">
                            <asp:Label ID="Rs_Selectapatient" runat="server" Text="Perform one of the following"
                                meta:resourcekey="Rs_SelectapatientResource1" />
                            <asp:DropDownList ID="dList" runat="server" meta:resourcekey="dListResource1" CssClass="ddlsmall">
                            </asp:DropDownList>
                            <asp:DropDownList ID="dList1" Visible="False" runat="server" CssClass="ddlsmall">
                          <%--      <asp:ListItem Text="Order Investigation" Value="1" 
                                    meta:resourcekey="ListItemResource1"></asp:ListItem>
                                <asp:ListItem Text="Collect sample" Value="2" 
                                    meta:resourcekey="ListItemResource2"></asp:ListItem>--%>
                            </asp:DropDownList>
                            <asp:Button ID="bGo" runat="server" Text="Go" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                onmouseout="this.className='btn'" OnClientClick="return ValidateFields();" OnClick="bGo_Click"
                                meta:resourcekey="bGoResource1" />
                        </td>
                    </tr>
                </table>
                <ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modalBackground"
                    TargetControlID="btnDummy1" CancelControlID="btnClose" DynamicServicePath=""
                    Enabled="True" PopupControlID="InvPanel">
                </ajc:ModalPopupExtender>
                <asp:Panel ID="InvPanel" runat="server" Width="500px" Height="400px" CssClass="modalPopup dataheaderPopup"
                    ScrollBars="Vertical" Style="display: none" meta:resourcekey="InvPanelResource1">
                    <table class="w-100p">
                        <tr>
                            <td class="a-right">
                                <input type="image" id="btnClose" class="pointer h-25 w-25" style="background-color: Red;" src="~/Images/Delete.jpg" />
                            </td>
                        </tr>
                        <tr>
                            <td class="a-center" id="InvGrd" runat="server" style="display: none">
                                <asp:GridView ID="grdResult" EmptyDataText="No Results Found." runat="server" OnRowDataBound="grdResult_RowDataBound"
                                    CssClass="filterdataheader2 gridView" AutoGenerateColumns="False" meta:resourcekey="grdResultResource1">
                                    <Columns>
                                        <asp:BoundField DataField="TestID" HeaderText="Test ID" 
                                            meta:resourceKey="BoundFieldResource9" Visible="False" />
                                        <asp:BoundField DataField="PatientID" HeaderText="Patient ID" 
                                            meta:resourceKey="BoundFieldResource10" Visible="False" />
                                        <asp:TemplateField HeaderText="VisitID" 
                                            meta:resourceKey="TemplateFieldResource7" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVisitID" runat="server" 
                                                    meta:resourceKey="lblVisitIDResource2" Text='<%# Eval("VisitID") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle Width="20px" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="UID" HeaderText="UID" meta:resourceKey="BoundFieldResource11"
                                            Visible="False" />
                                        <asp:BoundField DataField="ClientID" HeaderText="ClientID" meta:resourceKey="BoundFieldResource12"
                                            Visible="False" />
                                        <asp:BoundField DataField="AccessionNumber" HeaderText="AccessionNumber" meta:resourceKey="BoundFieldResource13"
                                            Visible="False" />
                                        <asp:TemplateField HeaderText="Investigation ID" meta:resourceKey="TemplateFieldResource8"
                                            Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblInvestigationID" runat="server" meta:resourceKey="lblInvestigationIDResource2"
                                                    Text='<%# Eval("InvestigationID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Type" meta:resourceKey="TemplateFieldResource9" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblType" runat="server" meta:resourcekey="lblTypeResource2" 
                                                    Text='<%# Eval("Type") %>' Visible="False"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="OrderedUID" meta:resourceKey="TemplateFieldResource10"
                                            Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblOrderedUID" runat="server" meta:resourceKey="lblOrderedUIDResource2"
                                                    Text='<%# Eval("OrderedUID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="RootUID" 
                                            meta:resourcekey="TemplateFieldResource11" Visible="False">
                                        <ItemTemplate>
                                                <asp:Label ID="lblRootUID" runat="server" 
                                                    meta:resourcekey="lblRootUIDResource2" Text='<%# Eval("UID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Select" 
                                            meta:resourceKey="TemplateFieldResource1">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="ChkSel" runat="server" GroupName="InvestigationSelect" meta:resourceKey="rdSelResource1"
                                                    ToolTip="Select Investigation" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="20px" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Investigation Name" meta:resourceKey="TemplateFieldResource11">
                                            <ItemTemplate>
                                                <asp:Label ID="lblInvestigationName" runat="server" meta:resourceKey="lblInvestigationNameResource2"
                                                    Text='<%# Eval("InvestigationName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="SampleDesc" HeaderText="Sample Name" meta:resourceKey="BoundFieldResource14">
                                            <HeaderStyle HorizontalAlign="Left" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ReferingPhysicianName" HeaderText="Referring Physician"
                                            meta:resourceKey="BoundFieldResource15">
                                            <HeaderStyle HorizontalAlign="Left" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Status" 
                                            meta:resourcekey="TemplateFieldResource12">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>' style="display:none;" meta:resourcekey="lblStatusResource2" ></asp:Label>
                                                <asp:Label ID="lblDisplayStatus" runat="server" Text='<%# Eval("DisplayStatus") %>' meta:resourcekey="lblDisplayStatusResource2"></asp:Label>
                                                <asp:HiddenField ID="hdnStatus" runat="server" Value='<%# Eval("Status") %>'></asp:HiddenField>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="AccessionNumber" meta:resourceKey="TemplateFieldResource12"
                                            Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAccessionNumber" runat="server" meta:resourceKey="lblAccessionNumberResource2"
                                                    Text='<%# Eval("AccessionNumber") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataRowStyle CssClass="dataheader1" />
                                    <HeaderStyle CssClass="dataheader1" />
                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                        PageButtonCount="5" PreviousPageText="" />
                                    <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-center">
                                <asp:Button ID="btnOk" runat="server" Text="OK" OnClientClick="return ValidateInvestigation();"
                                    CssClass="btn" OnClick="btnOk_Click" meta:resourceKey="btnOkResource1" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                    </div>
                
        <input id="btnDummy1" runat="server" style="display: none;" type="button"></input>
        <asp:HiddenField ID="hdnTestID" runat="server" />
        <asp:HiddenField ID="hdnPatientID" runat="server" />
        <asp:HiddenField ID="hdnSelectedPatientID" runat="server" />
        <asp:HiddenField ID="hdnSelectedVisitID" runat="server" />
        <asp:HiddenField ID="hdnstatus" runat="server" />
        <asp:HiddenField ID="hdnrdosave" runat="server" />
        <asp:HiddenField ID="hdnrdosearch" runat="server" />
        <asp:HiddenField ID="hdnRoleUser" runat="server" />
        <asp:HiddenField ID="hdnUserID" runat="server" />
        <asp:HiddenField ID="hdnvid" runat="server" />
        <asp:HiddenField ID="hdnUID" runat="server" />
        <asp:HiddenField ID="hdnClientID" runat="server" />
        <asp:HiddenField ID="hdnAccessionNumber" runat="server" />
        <asp:HiddenField ID="hdnLabNumber" runat="server" />
        <asp:HiddenField ID="hdnSearchPatientID" runat="server" />
        <asp:HiddenField ID="hdnchkids" runat="server" />
         <asp:HiddenField ID="hdnMessages" runat="server" />
        <asp:Button ID="btnNoLog" runat="server" Style="display: none" meta:resourcekey="btnNoLogResource1" />
   
    <script language="javascript" type="text/javascript">

        function SelectRow(rid, TestID, PID, status, vid, UID, ClientID, AccessionNumber) {
            chosen = "";
            document.getElementById('<%= hdnTestID.ClientID %>').value = '';

            document.getElementById('<%= hdnTestID.ClientID %>').value = TestID;
            document.getElementById('<%= hdnPatientID.ClientID %>').value = PID;
            document.getElementById('<%= hdnstatus.ClientID %>').value = status;
            document.getElementById('<%= hdnvid.ClientID %>').value = vid;
            document.getElementById('<%= hdnUID.ClientID %>').value = UID;
            document.getElementById('<%= hdnClientID.ClientID %>').value = ClientID;
            document.getElementById('<%= hdnAccessionNumber.ClientID %>').value = AccessionNumber;

        }
        function ValidateInvestigation() {
            var InformationMsg = SListForAppMsg.Get("Lab_InvestigationQueue_aspx_Information") != null ? SListForAppMsg.Get("Lab_InvestigationQueue_aspx_Information") : "Information";
            var chkids = document.getElementById('hdnchkids').value.split('~');
            for (var i = 0; i < chkids.length - 1; i++) {
                var chkInv = chkids[i];
                if (document.getElementById(chkInv).checked) {
                    return true;
                }
            }
            var userMsg = SListForAppMsg.Get("Lab_InvestigationQueue_aspx_02") == null ? "Select atleast one investigation and then press OK" : SListForAppMsg.Get("Lab_InvestigationQueue_aspx_02");
            ValidationWindow(userMsg, InformationMsg);
             
            //alert('Select atleast one investigation and then press OK');
            return false;
        }
    </script>

    <Attune:Attunefooter ID="Attunefooter" runat="server" />  
    </form>
</body>
</html>
