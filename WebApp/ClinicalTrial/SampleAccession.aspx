<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SampleAccession.aspx.cs"
    Inherits="ClinicalTrial_SampleAccession" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/ControlListDetails.ascx" TagName="ControlListDetails"
    TagPrefix="uc8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="../Scripts/datetimepicker_css.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <%--<script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>--%>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/SampleAccession.js" type="text/javascript"></script>

    <script runat="server">
        string _date;
        string GetDate(string Date)
        {
            if (Date != "01/01/1900")
            {
                _date = Date;
            }
            else
            {
                _date = "--";
            }
            return _date;
        }
    </script>

    <script type="text/javascript" language="javascript">
        function SampleStatusChange(objStatusID, objReasonID) {
            if (document.getElementById(objStatusID).value == "4") {
                document.getElementById(objReasonID).disabled = false;
            }
            else {
                document.getElementById(objReasonID).disabled = true;
            }
        }
        function isSpclChar(e) {
            var key;
            var isCtrl = false;

            if (window.event) // IE8 and earlier
            {
                key = e.keyCode;
            }
            else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
            {
                key = e.which;
            }

            if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32) || (key == 44) || (key == 46)) {
                isCtrl = true;
            }

            return isCtrl;
        }
        function blockNonNumbers(obj, e, allowDecimal, allowNegative) {
            var key;
            var isCtrl = false;
            var keychar;
            var reg;

            if (window.event) {
                key = e.keyCode;
                isCtrl = window.event.ctrlKey
            }
            else if (e.which) {
                key = e.which;
                isCtrl = e.ctrlKey;
            }

            if (isNaN(key)) return true;

            keychar = String.fromCharCode(key);

            // check for backspace or delete, or if Ctrl was pressed
            if (isCtrl || (key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 188) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46)) {
                //            if (key == 8 || isCtrl) {
                return true;
            }

            reg = /\d/;
            var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
            var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;

            return isFirstN || isFirstD || reg.test(keychar);
        }

        
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc6:UserHeader ID="UserHeader1" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: none;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
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
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <div>
                            <asp:UpdatePanel ID="UpdatePanel" runat="server">
                                <ContentTemplate>
                                    <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel" runat="server" >
                                        <ProgressTemplate>
                                            <div id="progressBackgroundFilter">
                                            </div>
                                            <div align="center" id="processMessage">
                                                <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" />
                                                <br />
                                                <br />
                                                <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" />
                                            </div>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td colspan="2">
                                                <div>
                                                    <asp:Panel ID="pnlas" runat="server">
                                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td>
                                                                    <asp:Panel ID="Panel5" runat="server" GroupingText="Study/Protocol Consignment Details">
                                                                        <table border="0" cellpadding="2" width="100%" class="dataheader3">
                                                                            <tr class="tablerow" id="ACX2responsesOPPmt" runat="server" style="display: block;">
                                                                                <td id="Td1" colspan="2" runat="server">
                                                                                    <table width="80%" border="0" cellpadding="2" cellspacing="0" align="center">
                                                                                        <tr id="Tr1" runat="server" width="100%">
                                                                                            <td style="width: 10%;" align="left" runat="server">
                                                                                                <asp:Label ID="Rs_ClientName" runat="server" Text="Site Name"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width: 15%;" runat="server">
                                                                                                <asp:TextBox ID="txtClient" Width="125px" runat="server" CssClass="Txtboxsmall" ToolTip="Enter Site Name"></asp:TextBox>
                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" TargetControlID="txtClient"
                                                                                                    EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetClientListforSchedule"
                                                                                                    ServicePath="~/WebService.asmx" OnClientItemSelected="ClientSelected" DelimiterCharacters=""
                                                                                                    Enabled="True">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                            </td>
                                                                                            <td id="Td2" style="width: 10%;" align="left" runat="server">
                                                                                                <asp:Label ID="lblEpisode" Text="Study/Protocol Name" runat="server"></asp:Label>
                                                                                            </td>
                                                                                            <td id="Td3" runat="server" width="15%">
                                                                                                <asp:TextBox ID="txtEpisodeName" onfocus="getSittingEpisoe();" CssClass="Txtboxsmall"
                                                                                                    runat="server" ToolTip="Enter Study/Protocol Name"></asp:TextBox>
                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteSittingEpisode" runat="server" TargetControlID="txtEpisodeName"
                                                                                                    EnableCaching="False" FirstRowSelected="True" CompletionInterval="1" MinimumPrefixLength="1"
                                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetClientEpisode"
                                                                                                    ServicePath="~/OPIPBilling.asmx" OnClientItemSelected="SittingEpisodeSelected"
                                                                                                    DelimiterCharacters="" Enabled="True">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                            </td>
                                                                                            <td id="Td10" style="width: 12%;" align="left" runat="server">
                                                                                                <asp:Label ID="lblConsign" runat="server" Text="Registeration Track Id." ToolTip="Register with Existing Consignment No."></asp:Label>
                                                                                                &nbsp;
                                                                                            </td>
                                                                                            <td id="Td16" style="width: 15%;" align="left" runat="server">
                                                                                                <asp:TextBox ID="txtConsignment" Width="125px" onfocus="SetConsignContextKey();"
                                                                                                    onblur="javascript:CheckConsignmentNo();" runat="server" CssClass="Txtboxsmall"
                                                                                                    ToolTip="Register with Existing Consignment No."></asp:TextBox>
                                                                                                <ajc:AutoCompleteExtender ID="AutoConsignment" runat="server" TargetControlID="txtConsignment"
                                                                                                    EnableCaching="false" FirstRowSelected="true" CompletionInterval="1" CompletionSetCount="10"
                                                                                                    MinimumPrefixLength="1" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetConsignmentNo"
                                                                                                    ServicePath="~/OPIPBilling.asmx" OnClientItemSelected="ConsignmentSelected">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                            </td>
                                                                                            <td id="TdSearch" style="width: 15%;" align="left" runat="server">
                                                                                                <asp:Button runat="server" Text="Search" ID="btnSearch" OnClick="Search_Click" CssClass="btn"
                                                                                                    OnClientClick="javascript:return checkisempty();" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <%--<asp:Panel ID="Panel1" runat="server" GroupingText="Subject Details">--%>
                                                                <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                    CellPadding="0" DataKeyNames="PatientVisitID" ForeColor="#333333" GridLines="None"
                                                                    Width="100%" PageSize="10" OnRowDataBound="grdResult_RowDataBound" OnPageIndexChanging="grdResult_PageIndexChanging"
                                                                    HeaderStyle-BorderWidth="0px" CssClass="parentrow" EmptyDataText="No Matcing Record Found!">
                                                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                    <Columns>
                                                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource3">
                                                                            <ItemTemplate>
                                                                                <table cellpadding="0" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                                                                                    cellspacing="0" border="1" width="100%">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <table cellpadding="0" cellspacing="0" border="1" width="100%">
                                                                                                <tr>
                                                                                                    <td>
                                                                                                        <table cellpadding="5" cellspacing="0" border="1" width="100%">
                                                                                                            <tr class="Duecolor">
                                                                                                                <td align="left" style="font-weight: bold;" width="15%"> 
                                                                                                                    <asp:Label ID="lblSubjectNo" Text='<%# "Subject No: " + DataBinder.Eval(Container.DataItem,"PatientVisitID") %>'
                                                                                                                        runat="server"></asp:Label>
                                                                                                                </td>
                                                                                                                <td align="left" style="font-weight: bold;" width="25%"> 
                                                                                                                    <asp:Label ID="lblPhy" Text='<%# "Subject Initials/Name: " + DataBinder.Eval(Container.DataItem,"Name") %>' runat="server"></asp:Label>
                                                                                                                </td>
                                                                                                                <td align="left" style="font-weight: bold;" width="25%"> 
                                                                                                                    <asp:Label ID="lblAge" Text='<%# "Age/Gender: " + DataBinder.Eval(Container.DataItem,"Age") %>' runat="server"></asp:Label>
                                                                                                                </td>
                                                                                                                <td align="left" style="font-weight: bold;" width="25%"> 
                                                                                                                    <asp:Label ID="Label2" Text='<%# "Test Name: " + DataBinder.Eval(Container.DataItem,"InvSampleStatusDesc") %>'
                                                                                                                        runat="server"></asp:Label>
                                                                                                                </td> 
                                                                                                                 <td align="left" style="font-weight: bold;" width="15%"> 
                                                                                                                     <asp:CheckBox ID="chkMismatchData" runat="server" Text="Mismatch Data" />
                                                                                                                     <asp:HiddenField ID="hdnParPatientVisitID" Value='<%# DataBinder.Eval(Container.DataItem,"PatientVisitID") %>'
                                                                                                                            runat="server" />
                                                                                                                </td> 
                                                                                                        </table>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td align="center">
                                                                                                        <asp:GridView ID="grdChildResult" runat="server" AutoGenerateColumns="False" CellPadding="0"
                                                                                                            PageSize="100" ForeColor="Black" GridLines="Both" OnRowDataBound="grdChildResult_RowDataBound"
                                                                                                            Width="100%" CssClass="childrow">
                                                                                                            <HeaderStyle Font-Underline="True" />
                                                                                                            <RowStyle Font-Bold="False" />
                                                                                                            <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                                                                            <Columns>
                                                                                                                <asp:BoundField DataField="SampleDesc" HeaderText="SampleDesc">
                                                                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                                                    <ItemStyle HorizontalAlign="left" Width="10%"></ItemStyle>
                                                                                                                </asp:BoundField>
                                                                                                                <asp:BoundField DataField="ConditionDesc" HeaderText="Sample Condition">
                                                                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                                                    <ItemStyle HorizontalAlign="left" Width="12%"></ItemStyle>
                                                                                                                </asp:BoundField>
                                                                                                                <asp:BoundField DataField="CollectedDateTime" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                                                                                    HeaderText="Collected Date & Time">
                                                                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                                                    <ItemStyle HorizontalAlign="left" Width="8%"></ItemStyle>
                                                                                                                </asp:BoundField>
                                                                                                                <asp:TemplateField HeaderText="Sample Received Date & time">
                                                                                                                    <ItemTemplate>
                                                                                                                        <asp:TextBox ID="txtReceivedDatetime" runat="server" Class="Txtboxsmall" Width="130px"
                                                                                                                            ToolTip="dd-MM-yyyy hh:mm:ssAM/PM"></asp:TextBox>
                                                                                                                    </ItemTemplate>
                                                                                                                    <ItemStyle HorizontalAlign="center" Width="8%" />
                                                                                                                </asp:TemplateField>
                                                                                                                <asp:TemplateField HeaderText="Remarks">
                                                                                                                    <ItemTemplate>
                                                                                                                        <asp:TextBox ID="txtRemarks" runat="server" Class="Txtboxsmall" Width="130px" Text='<%# DataBinder.Eval(Container.DataItem,"Remarks") %>'
                                                                                                                            ToolTip="Remarks about Sample Received"></asp:TextBox>
                                                                                                                    </ItemTemplate>
                                                                                                                    <ItemStyle HorizontalAlign="center" Width="8%" />
                                                                                                                </asp:TemplateField>
                                                                                                                <asp:BoundField DataField="InvestigtionName" HeaderText="Current Status">
                                                                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                                                    <ItemStyle HorizontalAlign="left" Width="10%"></ItemStyle>
                                                                                                                </asp:BoundField>
                                                                                                                <asp:TemplateField HeaderText="Action">
                                                                                                                    <ItemTemplate>
                                                                                                                        <asp:DropDownList ID="ddlSampleStatus" runat="server" CssClass="ddl">
                                                                                                                        </asp:DropDownList>
                                                                                                                        <%--<asp:CheckBox ID="chkIsRecieved" runat="server" Text="Is Received" Width="130px"
                                                                                                                            Checked="true" />--%>
                                                                                                                        <asp:HiddenField ID="hdnPatientVisitID" Value='<%# DataBinder.Eval(Container.DataItem,"PatientVisitID") %>'
                                                                                                                            runat="server" />
                                                                                                                        <asp:HiddenField ID="hdnSampleID" Value='<%# DataBinder.Eval(Container.DataItem,"SampleID") %>'
                                                                                                                            runat="server" />
                                                                                                                        <asp:HiddenField ID="hdnInvSampleStatusID" Value='<%# DataBinder.Eval(Container.DataItem,"InvSampleStatusID") %>'
                                                                                                                            runat="server" /> 
                                                                                                                    </ItemTemplate>
                                                                                                                    <ItemStyle HorizontalAlign="left" Width="8%" />
                                                                                                                </asp:TemplateField>
                                                                                                                <asp:TemplateField HeaderText="Reason">
                                                                                                                    <ItemTemplate>
                                                                                                                        <asp:DropDownList CssClass="ddl" ID="ddlAddReason" runat="server" Width="120px" ToolTip="Select reason">
                                                                                                                        </asp:DropDownList>
                                                                                                                    </ItemTemplate>
                                                                                                                    <ItemStyle HorizontalAlign="left" Width="8%" />
                                                                                                                </asp:TemplateField>
                                                                                                                <asp:TemplateField HeaderText="Volume">
                                                                                                                    <ItemTemplate>
                                                                                                                        <asp:TextBox CssClass="Txtboxsmall" runat="server" Width="40px"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                                                                                            ID="txtVolume" ToolTip="Enter Sample volume" MaxLength="25" size="10"></asp:TextBox>
                                                                                                                    </ItemTemplate>
                                                                                                                    <ItemStyle HorizontalAlign="left" Width="5%"></ItemStyle>
                                                                                                                </asp:TemplateField>
                                                                                                                <asp:TemplateField HeaderText="Units">
                                                                                                                    <ItemTemplate>
                                                                                                                        <asp:DropDownList CssClass="ddl" ID="ddlvolumeUnits" runat="server" Width="55px"
                                                                                                                            ToolTip="Select unit">
                                                                                                                        </asp:DropDownList>
                                                                                                                    </ItemTemplate>
                                                                                                                    <ItemStyle HorizontalAlign="left" Width="5%"></ItemStyle>
                                                                                                                </asp:TemplateField>
                                                                                                            </Columns>
                                                                                                        </asp:GridView>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <HeaderStyle BorderWidth="0px"></HeaderStyle>
                                                                </asp:GridView>
                                                                <%--</asp:Panel>--%>
                                                            </tr>
                                                            <tr>
                                                                <td id="TdReceiveSample" align="center" style="width: 15%; display: none;" runat="server">
                                                                    <asp:Button runat="server" Text="Receive Sample" ID="btnReceiveSample" CssClass="btn"
                                                                        OnClientClick="javascript:return IsValid();" OnClick="Save_Click" />
                                                                    <%-- <input type="button" id="btnSave" class="btn" style="width: 220px; height: 20px;"
                                                                        value="test" onclick="TableToJson();" />--%>
                                                                    <%--OnClick="Save_Click"--%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input id="hdnClientID" runat="server" type="hidden" />
                                                <input id="hdnEpisodeID" runat="server" type="hidden" />
                                                <input id="hdnOrgID" runat="server" type="hidden" />
                                                <input id="hdnShippingCondition" runat="server" type="hidden" />
                                                <input id="hdnCollectedDate" runat="server" type="hidden" />
                                                <input id="hdnRateID" runat="server" type="hidden" />
                                                <input id="hdnRateClientID" runat="server" type="hidden" />
                                                <input id="hdnMappingClientID" runat="server" type="hidden" />
                                                <input id="hdnLstobjPatient" runat="server" type="hidden" />
                                                <input id="hdnLslstPatientDueChart" runat="server" type="hidden" />
                                                <input id="hdnLslstInv" runat="server" type="hidden" />
                                                <input id="hdnLslstFinalBill" runat="server" type="hidden" />
                                                <input id="hdnLslstPatientInvSample" runat="server" type="hidden" />
                                                <input id="hdnBaseClientID" runat="server" type="hidden" />
                                                <input id="hdnBaseRateID" runat="server" type="hidden" />
                                                <input id="hdnDeptID" runat="server" type="hidden" />
                                                <input id="hdnConsignmentNo" runat="server" type="hidden" />
                                                <input id="hdnPatientID" runat="server" type="hidden" />
                                                <input id="hdnSelectedPatientTempDetails" runat="server" type="hidden" />
                                                <input type="hidden" runat="server" value="N" id="hdnIsEditMode" />
                                                <input type="hidden" runat="server" id="hdnCollectedIn" />
                                                <input type="hidden" runat="server" id="hdnCreatedBy" />
                                                <input type="hidden" runat="server" id="hdnLstSampleTracker" />
                                                <input type="hidden" runat="server" id="hdnLstPatientVisit" />
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>

    <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

    </form>
</body>
</html>

<script type="text/javascript" language="javascript">
   
</script>

<script type="text/javascript" language="javascript">


    function getSittingEpisoe() {
        var OrgID = "<%=OrgID%>";
        var ClinetID = document.getElementById('hdnClientID').value;
        document.getElementById('hdnOrgID').value = OrgID
        var sval = OrgID + '~' + ClinetID + '~' + 'COM';
        $find('AutoCompleteSittingEpisode').set_contextKey(sval);

    }

    function countQuickAge(id) {
        //alert(document.getElementById(id).value);
        if (document.getElementById(id).value != '') {
            bD = document.getElementById(id).value.split('/');
            var agetemp = 0;
            dd = bD[0];
            mm = bD[1];
            yy = bD[2];
            main = "valid";
            if ((dd == "__") || (mm == "__") || (yy == "____")) {
                //document.getElementById('txtAge').value = '';
                return false;
            }
            if ((mm < 1) || (mm > 12) || (dd < 1) || (dd > 31) || (yy < 1) || (mm == "") || (dd == "") || (yy == ""))
                main = "Invalid";
            else
                if (((mm == 4) || (mm == 6) || (mm == 9) || (mm == 11)) && (dd > 30))
                main = "Invalid";
            else
                if (mm == 2) {
                if (dd > 29)
                    main = "Invalid";
                else if ((dd > 28) && (!lyear(yy)))
                    main = "Invalid";
            }
            else
                if ((yy > 9999) || (yy < 0))
                main = "Invalid";
            else
                main = main;
            if (main == "valid") {
                function leapyear(a) {
                    if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0))
                        return true;
                    else
                        return false;
                }
                var days = new Date();

                var gdate = days.getDate();
                var gmonth = days.getMonth();
                var gyear = days.getFullYear();
                age = gyear - yy;
                if ((mm == (gmonth + 1)) && (dd <= parseInt(gdate))) {
                    age = age;
                }
                else {
                    if (mm <= (gmonth)) {
                        age = age;
                    }
                    else {
                        age = age - 1;
                    }
                }
                if (age == 0)
                    age = age;
                agetemp = age;
                if (mm <= (gmonth + 1))
                    age = age - 1;
                if ((mm == (gmonth + 1)) && (dd > parseInt(gdate)))
                    age = age + 1;
                var m;
                var n;
                if (mm == 12) { n = 31 - dd; }
                if (mm == 11) { n = 61 - dd; }
                if (mm == 10) { n = 92 - dd; }
                if (mm == 9) { n = 122 - dd; }
                if (mm == 8) { n = 153 - dd; }
                if (mm == 7) { n = 184 - dd; }
                if (mm == 6) { n = 214 - dd; }
                if (mm == 5) { n = 245 - dd; }
                if (mm == 4) { n = 275 - dd; }
                if (mm == 3) { n = 306 - dd; }
                if (mm == 2) { n = 334 - dd; if (leapyear(yy)) n = n + 1; }
                if (mm == 1) { n = 365 - dd; if (leapyear(yy)) n = n + 1; }
                if (gmonth == 1) m = 31;
                if (gmonth == 2) { m = 59; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 3) { m = 90; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 4) { m = 120; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 5) { m = 151; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 6) { m = 181; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 7) { m = 212; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 8) { m = 243; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 9) { m = 273; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 10) { m = 304; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 11) { m = 334; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 12) { m = 365; if (leapyear(gyear)) m = m + 1; }
                totdays = (parseInt(age) * 365);
                totdays += age / 4;
                totdays = parseInt(totdays) + gdate + m + n;
                months = age * 12;
                var t = parseInt(mm);
                months += 12 - mm;
                months += gmonth + 1;
                if (gmonth == 1) p = 31 + gdate;
                if (gmonth == 2) { p = 59 + gdate; if (leapyear(gyear)) m = m + 1; }
                if (gmonth == 3) { p = 90 + gdate; if (leapyear(gyear)) p = p + 1; }
                if (gmonth == 4) { p = 120 + gdate; if (leapyear(gyear)) p = p + 1; }
                if (gmonth == 5) { p = 151 + gdate; if (leapyear(gyear)) p = p + 1; }
                if (gmonth == 6) { p = 181 + gdate; if (leapyear(gyear)) p = p + 1; }
                if (gmonth == 7) { p = 212 + gdate; if (leapyear(gyear)) p = p + 1; }
                if (gmonth == 8) { p = 243 + gdate; if (leapyear(gyear)) p = p + 1; }
                if (gmonth == 9) { p = 273 + gdate; if (leapyear(gyear)) p = p + 1; }
                if (gmonth == 10) { p = 304 + gdate; if (leapyear(gyear)) p = p + 1; }
                if (gmonth == 11) { p = 334 + gdate; if (leapyear(gyear)) p = p + 1; }
                if (gmonth == 12) { p = 365 + gdate; if (leapyear(gyear)) p = p + 1; }
                weeks = totdays / 7;
                weeks += " weeks";
                weeks = parseInt(weeks);
                if (agetemp <= 0) {
                    if (months <= 0) {
                        if (weeks <= 0) {
                            if (totdays >= 0) {
                                if (totdays == 1) {
                                    document.getElementById('txtDOBNos').value = totdays;
                                    document.getElementById('ddlDOBDWMY').value = 'Day(s)';
                                }
                                else {
                                    document.getElementById('txtDOBNos').value = totdays;
                                    document.getElementById('ddlDOBDWMY').value = 'Day(s)';
                                }
                            }
                        }
                        else {
                            if (weeks == 1) {
                                document.getElementById('txtDOBNos').value = weeks;
                                document.getElementById('ddlDOBDWMY').value = 'Week(s)';
                            }
                            else {
                                document.getElementById('txtDOBNos').value = weeks;
                                document.getElementById('ddlDOBDWMY').value = 'Week(s)';
                            }
                        }
                    }
                    else {
                        if (months == 1) {
                            document.getElementById('txtDOBNos').value = months;
                            document.getElementById('ddlDOBDWMY').value = 'Month(s)';
                        }
                        else {
                            document.getElementById('txtDOBNos').value = months;
                            document.getElementById('ddlDOBDWMY').value = 'Month(s)';
                        }
                    }
                }
                else {
                    if (agetemp == 1) {
                        document.getElementById('txtDOBNos').value = agetemp;
                        document.getElementById('ddlDOBDWMY').value = 'Year(s)';
                    }
                    else {
                        document.getElementById('txtDOBNos').value = agetemp;
                        document.getElementById('ddlDOBDWMY').value = 'Year(s)';
                    }
                }

                function lyear(a) {
                    if (((a % 4 == 0) && (a % 100 != 0)) || (a % 400 == 0)) return true;
                    else return false;
                }
                //document.getElementById('ddlSex').focus();
            }
            else {
                alert(main + ' Date');
                document.getElementById('txtDOBNos').value = '';
                document.getElementById('tDOB').value = '';
                document.getElementById('tDOB').value = '__/__/____';
                document.getElementById('tDOB').focus();
            }
        }
    }

    function getDOB() {
        if (document.getElementById('txtDOBNos').value == '') {
            alert('Provide Age in (Days or Weeks or Months or Year) & choose appropriate from the list');
            document.getElementById('txtDOBNos').focus();
            return false;
        }
        return true;
    }
    function ClearDOB() {

        if (document.getElementById('txtDOBNos').value <= 0) {
            document.getElementById('txtDOBNos').value = '';
        }
        if (document.getElementById('txtDOBNos').value >= 150) {
            alert('Provide a valid year');
            document.getElementById('tDOB').value = '__/__/____';
            document.getElementById('txtDOBNos').value = '';
            document.getElementById('txtDOBNos').focus();
            return false;
        }
    }
</script>

