<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationQuickApprovelCovid.aspx.cs"
    Inherits="Investigation_InvestigationQuickApprovelCovid" EnableEventValidation="false"
    meta:resourcekey="PageResource1" %>

<%--<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head2" runat="server">
    <title>Investigation Quick Approvel</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

 <%--   <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>
    <script src="../Scripts/bid.js" type="text/javascript"></script>--%>
    <script type="text/javascript" language="javascript">
        function ShowReportPreview(vid, roleId, invStatus) {
            try {
                $("#ACX3responses2").hide();
                $find("mpReportPreview").show();
                $("#iframefullreportplaceholder").html("<iframe id='myiframe' name='myname' src='PrintVisitDetails.aspx?vid=" + vid + "&roleid=" + roleId + "&type=showreport&invstatus=" + invStatus + "' style='width: 100%;height: 450px; border: 0px; overfow: none;'></iframe>");
                return false;
            }
            catch (e) {
                return false;
            }
        }
        function HidePopup() {
            try {
                $find("mpReportPreview").hide();
                $("#ACX3responses2").show();
                return false;
            }
            catch (e) {
                return false;
            }
        }
        function ShowHeader() {
            try {
                if (document.getElementById('header').style.display == 'block')
                    document.getElementById('header').style.display = 'none';
                else
                    document.getElementById('header').style.display = 'block';
            }
            catch (e) {
            }
            return false;
        }
        function ShowHideHeader() {
            try {
                if (document.getElementById('imgShowHeader').src.split('Images')[1] == '/expand.jpg')
                    document.getElementById('imgShowHeader').src = '../Images/collapse.jpg';
                else if (document.getElementById('imgShowHeader').src.split('Images')[1] == '/collapse.jpg')
                    document.getElementById('imgShowHeader').src = '../Images/expand.jpg';
            }
            catch (e) {
            }
            return false;
        }
        window.onbeforeunload = LeavePage;
        function LeavePage(e) {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/UpdateCurrentTask",
                data: "{taskID: '" + $("#hdnTaskID").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function Success(data) {
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    return false;
                }
            });
            //ValidateUserExit("User");
            //ValidateUserExit(document.getElementById('hdnClickCheck').value + '$' + document.getElementById('hdnClickCheck').id);

        }
        function GetGUID() {
            //debugger;
            var RedirectURL = document.getElementById('hdnRedirectURL').value;
            var Temp = RedirectURL.split("&gUID=");
            var Guid = Temp[1].split("&tid=");
            document.getElementById('hdnGuid').value = Guid[0];
            //            var Temp = RedirectURL.split("~\Investigation\I");
            //            document.getElementById('hdnRedirectURL').value=Temp[1];

        }
        function checkForValues() {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vPageNo = SListForAppMsg.Get('Investigation_InvestigationQuickApprovel_aspx_01') == null ? "Provide page number" : SListForAppMsg.Get('Investigation_InvestigationQuickApprovel_aspx_01');
            var vCorrectPageNo = SListForAppMsg.Get('Investigation_InvestigationQuickApprovel_aspx_02') == null ? "Provide correct page number" : SListForAppMsg.Get('Investigation_InvestigationQuickApprovel_aspx_02');
            if (document.getElementById('txtpageNo').value == "") {
                //alert('Provide page number');
                ValidationWindow(vPageNo, AlertType);
                return false;
            }

            if (Number(document.getElementById('txtpageNo').value) < Number(1)) {
                //alert('Provide correct page number');
                ValidationWindow(vCorrectPageNo, AlertType);
                return false;
            }

            if (Number(document.getElementById('txtpageNo').value) > Number(document.getElementById('lblTotal').innerText)) {
                //alert('Provide correct page number');
                ValidationWindow(vCorrectPageNo, AlertType);
                return false;
            }


        }
        function MoveNext() {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vLastApproval = SListForAppMsg.Get('Investigation_InvestigationQuickApprovel_aspx_03') == null ? "This is Last Approval Page" : SListForAppMsg.Get('Investigation_InvestigationQuickApprovel_aspx_03');
            if (document.getElementById('hdnCurrentPage').value == document.getElementById('hdnTotalPage').value) {
                //alert('This is Last Approval Page');
                ValidationWindow(vLastApproval, AlertType);
                return false;
            }
            else {
                document.getElementById("CheakInv").style.display = "none";
            }
        }
        function MovePrevious() {
            /* Added By Venkatesh S */
            var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
            var vFirstApproval = SListForAppMsg.Get('Investigation_InvestigationQuickApprovel_aspx_04') == null ? "This is First Approval Page" : SListForAppMsg.Get('Investigation_InvestigationQuickApprovel_aspx_04');
            if (document.getElementById('hdnCurrentPage').value == "1") {
                //alert('This is First Approval Page');
                ValidationWindow(vFirstApproval, AlertType);
                return false;
            }
            else {
            document.getElementById("CheakInv").style.display = "none"; 
            }
        }
    </script>

    <script type="text/javascript" language="javascript">
        function changeScreenSize(w, h) {
            window.resizeTo(w, h)
        }
    </script>

    <script type="text/javascript" language="javascript">

        function autoResize(id) {
            var newheight;
            var newwidth;

            if (document.getElementById) {
                newheight = document.getElementById(id).contentWindow.document.body.scrollHeight;
                newwidth = document.getElementById(id).contentWindow.document.body.scrollWidth;
            }

            document.getElementById(id).height = (newheight) + "px";
            document.getElementById(id).width = (newwidth) + "px";
        }
    
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form2" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
       <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <%--<ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>--%>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table class="w-100p searchPanel" runat="server" id="CheakInv">
                                    <tr>
                                        <td class="h-23 a-left">
                                            <asp:HiddenField ID="HdnInvID" runat="server" />
                                            <div id="ACX2plus21" style="display: none;">
                                                <img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top pointer" 
                                                    onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',2);" />
                                                <span class="dataheader1txt pointer "  style="color: #000;" onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',2);">
                                    <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationQuickApprovel_aspx_01 %></span>
                                            </div>
                                            <div id="ACX2minus21" style="display: block;">
                                                <img src="../Images/hideBids.gif" alt="hide"class="w-15 h-15 v-top pointer" onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',0);" />
                                                <span class="dataheader1txt pointer" style="color: #000;" onclick="showResponses('ACX2plus21','ACX2minus21','ACX2responses211',0);">
                                    &nbsp;<%=Resources.Investigation_ClientDisplay.Investigation_InvestigationQuickApprovel_aspx_01 %></span>
                                            </div>
                                        </td>
                        <td>
                            <asp:Label ID="lblAttachmentMandatory" Style="display: none;" runat="server" Text="Graph or image is not yet uploaded for this visit"
                                Font-Bold="True" Font-Size="Large" ForeColor="Red" meta:resourcekey="lblAttachmentMandatoryResource1" />
                        </td>
                                    </tr>
                                    <tr runat="server" id="ACX2responses211" style="display: table-row;">
                                        <td class="v-top w-100p" colspan="2">
                                            <div class="dataheader2">
                                                <asp:UpdatePanel ID="UpdPnl1" runat="server">
                                                    <ContentTemplate>
                                        <asp:DataList ID="GrdInv" CssClass="w-30p gridView" runat="server" HeaderStyle-CssClass="gridHeader"
                                            GridLines="Horizontal" RepeatColumns="1" OnItemDataBound="GrdInv_ItemDataBound"
                                            meta:resourcekey="GrdInvResource1">
                                                            <HeaderTemplate>
                                                                <%--<table class="w-100p">
                                                                    <tr>--%>
                                                                         <%--<td class="bold">--%>
                                                                          <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationQuickApprovel_aspx_06 %>
                                                                        </td>
                                                                        <td class="bold">
                                                    <%=Resources.Investigation_ClientDisplay.Investigation_InvestigationQuickApprovel_aspx_02 %>
                                                                        </td>
                                                                     
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                          
                                                                <%--<td width="70%">--%>
                                                                    <%# DataBinder.Eval(Container.DataItem, "InvestigationName")%>
                                                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("ReferredType")%>'></asp:Label>
                                                                </td>
                                                                <td headers="Status">
                                                                    <%# DataBinder.Eval(Container.DataItem, "DisplayStatus")%>
                                                                </td>
                                                            
                                                            </ItemTemplate>
                                                         <%--   <FooterTemplate>
                                                                </tr> </table>
                                                            </FooterTemplate>--%>
                                                        </asp:DataList>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="v-top w-100p" colspan="2">
                                            <div id="divReportControls" runat="server">
                                                <table class="w-100p">
                                                    <tr style="display: none;">
                                                        <td>
                                                            <asp:GridView ID="grdTasks" runat="server" AllowPaging="True" CssClass="w-100p gridView" CellPadding="4"
                                                                AutoGenerateColumns="False" DataKeyNames="PatientID,
                                                                PatientVisitID,
                                                                TaskID,
                                                                RedirectURL,
                                                                Name,
                                                                RoleName,
                                                                Category,
                                                                HighlightColor,
                                                                CreatedName,
                                                                OrgID,
                                                                RefernceID" ForeColor="#333333" PageSize="1" OnRowDataBound="grdTasks_RowDataBound"
                                                                OnPageIndexChanging="grdTasks_PageIndexChanging" meta:resourcekey="grdTasksResource1"
                                                                OnRowCommand="grdTasks_RowCommand">
                                                                <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                <HeaderStyle CssClass="dataheader1" />
                                                                <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                                    PageButtonCount="5" PreviousPageText="" />
                                                                <Columns>
                                                    <asp:BoundField DataField="Name" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource1">
                                                                        <ControlStyle Width="660px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="Age" HeaderText="Age">
                                                                        <ControlStyle Width="30px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="VisitNumber" HeaderText="Visit Number">
                                                                        <ControlStyle Width="30px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="TaskDate" HeaderText="Task Date" DataFormatString="{0:dd MMM yyyy hh:mm}"
                                                                        meta:resourcekey="BoundFieldResource7">
                                                                        <ControlStyle Width="50px" />
                                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Location" HeaderText="Location" meta:resourceskey="BoundFieldResource9"
                                                        meta:resourcekey="BoundFieldResource4">
                                                        <ControlStyle Width="50px" />
                                                    </asp:BoundField>
                                                                    <asp:BoundField Visible="False" DataField="RoleName" HeaderText="RoleName" meta:resourcekey="BoundFieldResource1" />
                                                                    <asp:BoundField Visible="False" DataField="PatientID" HeaderText="PatientID" meta:resourcekey="BoundFieldResource2" />
                                                                    <asp:BoundField Visible="False" DataField="TaskID" HeaderText="TaskID" meta:resourcekey="BoundFieldResource3" />
                                                                    <asp:BoundField Visible="False" DataField="RedirectURL" HeaderText="URL" meta:resourcekey="BoundFieldResource4" />
                                                                    <asp:BoundField Visible="False" DataField="PatientVisitID" HeaderText="VisitID" meta:resourcekey="BoundFieldResource5" />
                                                                    <asp:BoundField DataField="TaskDescription" HeaderText="Task Details" meta:resourcekey="BoundFieldResource6"
                                                                        Visible="False">
                                                                        <ControlStyle Width="660px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="Category" HeaderText="Category" meta:resourcekey="BoundFieldResource8"
                                                                        Visible="False">
                                                                        <ControlStyle Width="50px" />
                                                                    </asp:BoundField>
                                                                    <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource2"
                                                                        Visible="True">
                                                                        <ItemTemplate>
                                                                            <asp:ImageButton ID="imgQuickDiagnosis" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                CommandName="Approve" ImageUrl="~/Images/RightIcon.png" meta:resourcekey="imgQuickDiagnosisResource1" />
                                                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                                                            <asp:ImageButton ID="ImageButton3" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                CommandName="Edit" ImageUrl="~/Images/notes.gif" meta:resourcekey="ImageButton3Resource1" />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="CreatedName" HeaderText="Created By" meta:resourcekey="BoundFieldResource17"
                                                                        Visible="False" />
                                                                    <asp:BoundField DataField="HighlightColor" HeaderText="Picked By" meta:resourcekey="BoundFieldResource10"
                                                                        Visible="False">
                                                                        <ControlStyle Width="50px" />
                                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="RefernceID" HeaderText="Lab No" Visible="false" meta:resourcekey="BoundFieldResource19" />
                                                    <asp:BoundField DataField="OrgName" HeaderText="Org Name" Visible="false" meta:resourcekey="BoundFieldResource9" />
                                                                    <asp:BoundField DataField="OrgID" HeaderText="Org Id" Visible="false" meta:resourcekey="BoundFieldResource18" />
                                                                </Columns>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                    <tr class="dataheaderInvCtrl">
                                                        <td class="defaultfontcolor a-right">
                                                            <div>
                                                                <table class="w-100p bg-row b-grey">
                                                                    <tr>
                                                                        <td class="w-25p">
                                                                            <asp:Label ID="Rs_Department" runat="server" Text="Department" meta:resourcekey="Rs_DepartmentResource3"></asp:Label>
                                                                            <asp:DropDownList runat="server" ID="ddlDept" Width="200" CssClass="ddlsmall" meta:resourcekey="ddlDeptResource3"
                                                                                OnSelectedIndexChanged="ddlDept_SelectedIndexChanged" AutoPostBack="true">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <table class="w-100p" runat="server" id="trResult"
                                                                                style="display: none;">
                                                                                <tr>
                                                                                    <td class="a-center">
                                                                                        <asp:Label runat="server" Text="You don't have any pending task!!!" ID="lblResult" Font-Size="Medium" meta:resourcekey="lblResultResource1"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                            <table class="w-100p" id="divFooterNav" runat="server">
                                                                                <tr>
                                                                                    <td class="a-center w-15p">
                                                                                        <asp:Label ID="Label1" runat="server" meta:resourcekey="Label1Resource1" Text="Patient"></asp:Label>
                                                                                        <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                                                                                        <asp:Label ID="Label2" runat="server" meta:resourcekey="Label2Resource1" Text="Of"></asp:Label>
                                                                                        <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                                                                                        <asp:Button ID="Btn_Previous" runat="server" CssClass="btn" meta:resourcekey="Btn_PreviousResource1"
                                                                                            OnClick="Btn_Previous_Click" Style="width: 71px" Text="Previous" Visible="false" />
                                                                                    </td>
                                                                                    <td class="a-center w-10p">
                                                                                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/previousimage.png"
                                                                                            OnClick="Btn_Previous_Click" OnClientClick="javascript:return MovePrevious();" meta:resourcekey="ImageButton1Resource1" />
                                                                                        &nbsp;&nbsp;
                                                                                        <asp:ImageButton ID="imgQuickDiagnosis" runat="server" ImageUrl="~/Images/nextimage.png"
                                                                                            OnClick="Btn_Next_Click" OnClientClick="javascript:return MoveNext();" meta:resourcekey="imgQuickDiagnosisResource2" />
                                                                                    </td>
                                                                                    <td class="w-23p">
                                                                                        <asp:Button ID="Btn_Next" runat="server" CssClass="btn" meta:resourcekey="Btn_NextResource1"
                                                                                            OnClick="Btn_Next_Click" Text="Next" Visible="false" />
                                                                                        <asp:HiddenField ID="hdnCurrent" runat="server" />
                                                                                        <asp:HiddenField ID="hdnTotalPage" runat="server" />
                                                                                        <asp:HiddenField ID="hdnCurrentPage" runat="server" />
                                                                                        <asp:HiddenField ID="hdnPostBack" runat="server" />
                                                                                        <asp:HiddenField ID="hdnOrgID" runat="server" />
                                                                                        <asp:Label ID="Label3" runat="server" meta:resourcekey="Label3Resource1" Text="Enter the Number to Go:"></asp:Label>
                                                                                        <asp:TextBox ID="txtpageNo" runat="server" meta:resourcekey="txtpageNoResource1"
                                                                                              onkeypress="return ValidateOnlyNumeric(this);"   Width="30px"></asp:TextBox>
                                                                                    </td>
                                                                    <td class="a-center w-5p">
                                                                                       <%-- <asp:ImageButton ID="ImageButton" runat="server" ImageUrl="~/Images/go-btn.png"
                                                                                            OnClick="btnGo_Click" OnClientClick="javascript:return checkForValues();" Visible="false"/>--%>
                                                                        <asp:LinkButton ID="ImageButton2" OnClick="btnGo_Click" Text="GO" runat="server"
                                                                            CssClass="btngoimg" OnClientClick="javascript:return checkForValues();" meta:resourcekey="btnGoResource1"></asp:LinkButton>
                                                                        <asp:Button ID="btnGo" runat="server" CssClass="btn" meta:resourcekey="btnGoResource1"
                                                                            OnClick="btnGo_Click" OnClientClick="javascript:return checkForValues();" Text="Go"
                                                                            Visible="false" />
                                                                    </td>
                                                                    <td class="a-center" id="tdCaptureRemarks" runat="server">
                                                                        <%--<asp:LinkButton ID="lnkbtnCaptureRemarks" Text="Capture Remarks" runat="server" class="btn"
                                                                            Width="120px"></asp:LinkButton>--%>
                                                                            <asp:Button ID="btnCaptureRemarks" Text="Counselling Remarks" runat="server" class="btn"
                                                                            Width="120px" />
                                                                    </td>
                                                                    <td>
                                                                        <table class="w-100p">
                                                                            <tr>
                                                                                <td class="w-35p">
                                                                                    <asp:Button ID="btnApprove" runat="server" CssClass="btn" OnClick="btnGo_ClickApprove"
                                                                                        Text="Approve" meta:resourcekey="btnApproveResource1" />
                                                                                                </td>
                                                                                                <td class="a-center w-35p">
                                                                                                    <asp:Button ID="vtnEdit" runat="server" CssClass="btn" OnClick="btnGo_ClickEdit"
                                                                                        Text="Edit" meta:resourcekey="vtnEditResource1" />
                                                                                                </td>
                                                                                                <td class="w-30p">
                                                                                                    <asp:LinkButton ID="LinkButton2" Text="Home" Font-Underline="True" runat="server"
                                                                                                        CssClass="details_label_age" OnClick="LinkButton2_Click" meta:resourcekey="LinkButton2Resource1"></asp:LinkButton>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:LinkButton ID="lnkFullReport" runat="server" Text="Full Report" Font-Underline="true"
                                                                                            ForeColor="Blue" Font-Bold="true" meta:resourcekey="lnkFullReportResource1" />
                                                                                    </td>
                                                                    <td class="w-12p">
                                                                                        <asp:UpdateProgress ID="upProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                                                                                            <ProgressTemplate>
                                                                                                <div id="progressBackgroundFilter" class="a-center">
                                                                                                </div>
                                                                                                <div id="processMessage" class="a-center w-20p">
                                                                                                    <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                                                                                </div>
                                                                                            </ProgressTemplate>
                                                                                        </asp:UpdateProgress>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="w-100p" colspan="2">
                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                <ContentTemplate>
                                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
                                                         <ProgressTemplate>
                                                                                                <div id="progressBackgroundFilter" class="a-center">
                                                                                                </div>
                                                                                                <div id="processMessage" class="a-center w-20p">
                                                                                                    <asp:Image ID="img2" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                                                                                </div>
                                                                                            </ProgressTemplate>
                                                    </asp:UpdateProgress>
                                                    <table id="ACX3responses2" style="display: table;" class="w-100p" runat="server">
                                                        <tr>
                                                            <td>
                                                                <div id="iframeplaceholder" class="w-100p" style="height: auto;">
                                                                    <iframe runat="server" class="w-100p" id="frameReportPreview" name="myname" style="height: 650px; border: 0px; overfow: none;"></iframe>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="w-100p">
                                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                <ContentTemplate>
                                                    <asp:UpdateProgress ID="UpdateProgress3" runat="server" AssociatedUpdatePanelID="UpdatePanel3">
                                                        <ProgressTemplate>
                                                            <asp:Image ID="imgProgressbar3" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                            <asp:Label ID="Rs_Pleasewait3" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                                        </ProgressTemplate>
                                                    </asp:UpdateProgress>
                                                    <table id="ACX3responses3" style="display: none;" class="w-100p" runat="server">
                                                        <tr>
                                                            <td>
                                                                <div id="Div2" class="w-100p" style="height: auto;">
                                                                    <iframe runat="server" class="w-100p" id="iframeplaceholderEdit" name="myname1" style="height: 650px; border: 0px; overfow: none;"></iframe>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="popup2" class="popup_block" style="background-color: #d9dbdb; display: none;">
                                <h2 style="text-align: center">
                                    Capture Remarks</h2>
                                <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr bgcolor="#d9dbdb">
                                        <td>
                                            <asp:Label ID="lblpatienthistory" runat="server" Text="Patient History"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtpatienthistory" runat="server" CssClass="w-100p" Height="50px"
                                                TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr bgcolor="#d9dbdb">
                                        <td>
                                            <asp:Label ID="lblremarks" runat="server" Text="Remarks"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtremarks" runat="server" CssClass="w-100p" Height="50px" TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr bgcolor="#d9dbdb">
                                        <td>
                                        </td>
                                        <td align="center">
                                            <%--<asp:LinkButton ID="lnkbtnAdd" Text="Add" runat="server" CssClass="btn" OnClientClick="GetRemarks();"></asp:LinkButton>--%>
                                            <asp:Button ID="lnkbtnAdd" Text="Add" runat="server" CssClass="btn" OnClientClick="GetRemarks();" />
                                            <%--&nbsp;
                                                <asp:LinkButton ID="lnkbrncancel" Text="Cancel" runat="server" CssClass="btn"></asp:LinkButton>--%>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <input type="hidden" id="hdnVID" name="vid" runat="server" />
                                <input type="hidden" id="hdnVisitDetail" runat="server" />
                                <input type="hidden" id="hdnRedirectURL" runat="server" />
                                <input type="hidden" id="hdnGuid" runat="server" />
                                <input type="hidden" id="hdnTaskID" runat="server" />
                                <input type="hidden" id="hdniPatientID" runat="server" />
                                <input type="hidden" id="hdniVisitID" runat="server" />
                                <input type="hidden" id="hdniTaskID" runat="server" />
                                <input type="hidden" id="hdniPageUrl" runat="server" />
                                <input type="hidden" id="hdniName" runat="server" />
                                <input type="hidden" id="hdniOrgid" runat="server" />
                                <input type="hidden" id="hdnRNo" runat="server" />
                                <input type="hidden" id="hdnlabNo" runat="server" />
                                
                                <input type="hidden" id="hdnTaskDate" runat="server" value="-1"/>
                                <input type="hidden" id="hdncategory" runat="server" value="-1" />
                                <input type="hidden" id="hdnspecId" runat="server" value="-1"/>
                                <input type="hidden" id="hdnInvLocationID" runat="server" value="0" />
                                <input type="hidden" id="hdnHosOrRefID" runat="server" />
                                <input id="hdnSelectedClientTempDetails" type="hidden" value="0" runat="server" />
                                 <input id="hdnSelectedClientID" type="hidden" value="-1" runat="server" />
                                 <input id="hdnCheckClientid" type="hidden" value="-1" runat="server" />
                                <asp:HiddenField ID="hdnTargetCtlReportPreview" runat="server" />
                                <cc1:ModalPopupExtender ID="mpReportPreview" runat="server" PopupControlID="pnlReportPreview"
                                    TargetControlID="hdnTargetCtlReportPreview" BackgroundCssClass="modalBackground"
                                    CancelControlID="" DynamicServicePath="" Enabled="True">
                                </cc1:ModalPopupExtender>
                                <asp:Panel ID="pnlReportPreview" BorderWidth="1px" Height="95%" CssClass="modalPopup dataheaderPopup w-90p"
                                    runat="server" meta:resourcekey="pnlShowReportPreviewResource1" Style="display: none">
                                    <asp:Panel ID="pnlReportPreviewHeader" runat="server" CssClass="dialogHeader" meta:resourcekey="pnlReportPreviewHeaderResource1">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="a-left">
                                                    <asp:Label ID="lblReportPreviewHeader" runat="server" Text="Report Preview" meta:resourcekey="lblReportPreviewHeaderResource2"></asp:Label>
                                                </td>
                                                <td class="a-right">
                                                    <img id="imgPDFReportPreview" src="../Images/dialog_close_button.png" runat="server" onclick="return HidePopup();"
                                                        alt="Close" style="cursor: pointer;" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <div id="iframefullreportplaceholder" class="w-100p" style="height: auto;">
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />        
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnpatienthistory" runat="server" />
    <asp:HiddenField ID="hdnremarks" runat="server" />
    </form>
</body>
</html>

<script type="text/javascript" language="javascript">
    window.onbeforeunload = LeavePage;
    function LeavePage(e) {
        $.ajax({
            type: "POST",
            url: "InvestigationQuickApprovel.aspx/WebTaskOpen",
            data: "{visitID: " + $("#hdniVisitID").val() + ",taskID:" + $("#hdniTaskID").val() + "}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function Success(data) {
                
            },
            error: function(xhr, ajaxOptions, thrownError) {
                return false;
            }
        });

    }

    $("#btnCaptureRemarks").on("click", function(e) {
        e.preventDefault();
        $("#popup2").dialog({
            height: 300,
            width: 550
        });
    });
    function GetRemarks() {
        var pathistory = $("#txtpatienthistory").val();
        var remarks = $("#txtremarks").val();
        if (pathistory == '') {
            alert('Please Enter Patient Remarks');
            return;
        }
        //            if (remarks == '') {
        //                alert('Please Enter Remarks');
        //            }
        if (pathistory != '') {
            hdnpatienthistory.value = pathistory;
        }
        if (remarks != '') {
            hdnremarks.value = remarks;
        }
        $('#popup2').dialog('close');

    }
   
    
</script> 
