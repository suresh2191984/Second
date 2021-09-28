<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShowPatientRecommendation.aspx.cs"
    Inherits="Reception_ShowPatientRecommendation" meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="~/CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function ViewPatientRecommendationPopup(obj) {
            var pid = obj.split('~')[0];
            var vid = obj.split('~')[1];
            //window.showModalDialog("PatientList.aspx?pName=" + pName + "&pNo=" + pNo + "&pOrg=" + pOrg + "", "Products List", "dialogWidth:550px;dialogHeight:450px");
            window.open("ViewRecommendation.aspx?pid=" + pid + "&vid=" + vid + "&IsPopup=Y" + "", "Recommendation", "height=700,width=750,left=0,top=0,scrollbars=yes");
            return false;
        }
        
    </script>

    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</head>
<body >
    
    <form id="form1" runat="server">
    <script language="javascript" type="text/javascript" >
        function changeUI() {
            var vals = document.getElementById('<%= ddlPurpose.ClientID %>').value;
            
            document.getElementById('<%= hdnSelPurpose.ClientID %>').value = vals;
            if (vals == "Health Package") {
                document.getElementById('<%= dvSchedules.ClientID %>').style.display = 'none';
                document.getElementById('<%= dvSchedules1.ClientID %>').style.display = 'none';
                document.getElementById('<%= dvRecemondation.ClientID %>').style.display = 'block';
            }
            else if (vals == "Appointments") {
                document.getElementById('<%= dvSchedules.ClientID %>').style.display = 'block';
                document.getElementById('<%= dvSchedules1.ClientID %>').style.display = 'block';
                document.getElementById('<%= dvRecemondation.ClientID %>').style.display = 'none';
            }
            else {
                document.getElementById('<%= dvSchedules.ClientID %>').style.display = 'block';
                document.getElementById('<%= dvSchedules1.ClientID %>').style.display = 'block';
                document.getElementById('<%= dvRecemondation.ClientID %>').style.display = 'block';
            }
        }

        function changeFilterBY() {
            var vals = document.getElementById('<%= ddlFilterby.ClientID %>').value;
            document.getElementById('<%= hdnFilterby.ClientID %>').value = vals;
        }
        
        function changevisibility(idhide, idShow, bookID) {
            document.getElementById(idhide).style.display = 'none';
            document.getElementById(idShow).style.display = 'block';
            document.getElementById('<%= hdnBookedID.ClientID %>').value = bookID;
            document.getElementById('<%= UpdateReminder.ClientID %>').click();
        }
    </script>
     <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index:2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>"  class="logostyle" />
                </div>
            </div>
                <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc7:DocHeader ID="docHeader" runat="server" />
            </div>
                    <div style="float: right;"  class="Rightheader"></div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
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
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                   
                    <asp:UpdatePanel ID="upd" runat="server" >
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnFind" EventName="Click" /> 
                        <asp:AsyncPostBackTrigger ControlID="UpdateReminder" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                        <div style="vertical-align: middle;">
                            <table class="style1">
                            <tr>
                            <td class="dataheaderInvCtrl">
                             <div id="Div1" align="center" runat="server">
                             <table >
                                <tr>
                                    <td>
                                        <asp:Label ID="Rs_Purpose" Text="Purpose :" runat="server" 
                                            meta:resourcekey="Rs_PurposeResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlPurpose" runat="server" 
                                            onChange='javascript:changeUI();' meta:resourcekey="ddlPurposeResource1">
                                            <asp:ListItem Text="--All--" Value="All" meta:resourcekey="ListItemResource1" ></asp:ListItem>
                                            <asp:ListItem Text="Health Package" Value="Health Package" 
                                                meta:resourcekey="ListItemResource2" ></asp:ListItem>
                                            <asp:ListItem Text="Appointments" Value="Appointments" 
                                                meta:resourcekey="ListItemResource3"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                 </tr>
                                </table>
                                </div>
                                </td></tr>
                                 
                            </table>
                        </div>
                        <asp:HiddenField ID="hdnSelPurpose" Value="All" runat="server" />
                           <asp:HiddenField ID="hdnFilterby" Value="pending" runat="server" />
                        <table width="100%">
                            <tr>
                                <td align="center" >
                                    <asp:HiddenField ID="Hdnvalue" runat="server" />
                                    <div id="dvRecemondation"  runat="server" class="dataheaderInvCtrl">
                                       <div class="dataheader1" >Health Package</div> 
                                        <asp:GridView ID="gvPatient" runat="server" AllowPaging="True" PageSize="4" AutoGenerateColumns="False"
                                            OnRowDataBound="gvPatient_RowDataBound" ForeColor="#333333" Width="100%" 
                                            OnPageIndexChanging="gvPatient_PageIndexChanging" 
                                            meta:resourcekey="gvPatientResource1">
                                            <HeaderStyle CssClass="dataheader1" />
                                            <PagerStyle CssClass="dataheader1" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1"></asp:TemplateField>
                                                <asp:BoundField HeaderText="Patinet No." DataField="PatientNumber" 
                                                    meta:resourcekey="BoundFieldResource1" />
                                                <asp:TemplateField HeaderText="Patient Name" 
                                                    meta:resourcekey="TemplateFieldResource2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbl_name" runat="server" Text='<%# bind("name") %>' 
                                                            meta:resourcekey="lbl_nameResource1"></asp:Label>
                                                        <asp:Label ID="lbl_visitid" runat="server" Text='<%# bind("PatientVisitId") %>' 
                                                            style="display:none;" meta:resourcekey="lbl_visitidResource1"></asp:Label>
                                                        <asp:Label ID="lbl_pid" runat="server" Text='<%# bind("PatientID") %>' 
                                                            Visible="False" meta:resourcekey="lbl_pidResource1"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Visit Date" 
                                                    meta:resourcekey="TemplateFieldResource3">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbldate" runat="server" 
                                                            Text='<%# DataBinder.Eval(Container.DataItem,"visitdate", "{0:dd/MM/yyyy hh:mm tt}") %>' 
                                                            meta:resourcekey="lbldateResource1" ></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Actions" 
                                                    meta:resourcekey="TemplateFieldResource4">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkshow" runat="server" CommandArgument='<%# bind("PatientVisitId") %>'
                                                            ForeColor="Blue" Text="Show Recommendation Details" CommandName="enter" 
                                                            meta:resourcekey="lnkshowResource1"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                    
                                    <div id="dvSchedules" class="dataheaderInvCtrl" align="center" style="display:none;" runat="server">
                                       <div class="dataheader1" ><asp:Label ID="Rs_IDAppointments" Text="IDAppointments" 
                                               runat="server" meta:resourcekey="Rs_IDAppointmentsResource1"></asp:Label></div> 
                                            <table  >
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_From" Text="From :" runat="server" 
                                                            meta:resourcekey="Rs_FromResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtFromDate" runat="server" 
                                                            meta:resourcekey="txtFromDateResource1" ></asp:TextBox>
                                                        &nbsp;<asp:Image runat="server" ID="ImgBntCalc" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                            Width="16px" Height="16px" border="0" alt="Pick from date" 
                                                            meta:resourcekey="ImgBntCalcResource1" />
                                                        <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                                            TargetControlID="txtFromDate" Enabled="True" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Rs_To" Text="To :" runat="server" 
                                                            meta:resourcekey="Rs_ToResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtToDate" runat="server" 
                                                            meta:resourcekey="txtToDateResource1" ></asp:TextBox>
                                                        &nbsp;<asp:Image runat="server" ID="ImgToDate" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                            Width="16px" Height="16px" AlternateText="Pick to date" 
                                                            meta:resourcekey="ImgToDateResource1" />
                                                        <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgToDate"
                                                            TargetControlID="txtToDate" Enabled="True" />
                                                    </td>
                                                    <td>&nbsp;</td>
                                                    <td>
                                        <asp:Label ID="Rs_FilterBy" Text="Filter By :" runat="server" 
                                                            meta:resourcekey="Rs_FilterByResource1"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlFilterby" runat="server" 
                                            onChange='javascript:changeFilterBY();' meta:resourcekey="ddlFilterbyResource1">
                                            <asp:ListItem Text="All" Value="all" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                            <asp:ListItem Text="Reminded" Value="reminded" 
                                                meta:resourcekey="ListItemResource5"></asp:ListItem>
                                            <asp:ListItem Text="Pending" Selected="True" Value="pending" 
                                                meta:resourcekey="ListItemResource6"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnFind" runat="server" OnClick="btnFind_Click" CssClass="btn" 
                                                            Text="Go" meta:resourcekey="btnFindResource1" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        
                                    <div id="dvSchedules1" style="display:none;" class="dataheaderInvCtrl" runat="server">
                                    <asp:GridView ID="gvSchedules" runat="server" AutoGenerateColumns="False" 
                                            ForeColor="#333333" OnRowDataBound="gvSchedules_RowDataBound" Width="100%" 
                                            meta:resourcekey="gvSchedulesResource1" >
                                            <HeaderStyle CssClass="dataheader1" Height="25px"  />
                                            <PagerStyle CssClass="dataheader1" />
                                            <Columns>
                                            <asp:TemplateField HeaderText ="Patient No." 
                                                    meta:resourcekey="TemplateFieldResource5" >
                                            <ItemTemplate>
                                            <asp:Label ID="lblPatientNo" runat="server" 
                                                    meta:resourcekey="lblPatientNoResource1"></asp:Label>
                                            </ItemTemplate>
                                            </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Patient Name" 
                                                    meta:resourcekey="TemplateFieldResource6">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPatientName" runat="server" 
                                                            meta:resourcekey="lblPatientNameResource1"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Phone No." 
                                                    meta:resourcekey="TemplateFieldResource7">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPhoneNo" runat="server" 
                                                            meta:resourcekey="lblPhoneNoResource1"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Appointment For" 
                                                    meta:resourcekey="TemplateFieldResource8">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblResource" runat="server" 
                                                            meta:resourcekey="lblResourceResource1"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="NextOccurance" DataFormatString="{0:dd/MMM/yyyy}" 
                                                    HeaderText="Date" meta:resourcekey="BoundFieldResource2" />
                                                <asp:BoundField DataField="From" DataFormatString="{0:hh:mm tt}" 
                                                    HeaderText="From" meta:resourcekey="BoundFieldResource3" />
                                                <asp:BoundField DataField="To" DataFormatString="{0:hh:mm tt}" 
                                                    HeaderText="To" meta:resourcekey="BoundFieldResource4" />
                                                <asp:TemplateField HeaderText="Reminder Status" 
                                                    meta:resourcekey="TemplateFieldResource9">
                                                    <ItemTemplate>
                                                     <asp:Label ID="lblRemindCount" Visible="False" runat="server" 
                                                            meta:resourcekey="lblRemindCountResource1"></asp:Label>
                                                        <input ID="btnRemind" runat="server" class="btn" type="button" 
                                                            value="Remind" />
                                                        <asp:Image ID="imgLoad" runat="server" ImageUrl="~/Images/progress.gif" 
                                                            style="display:none;" meta:resourcekey="imgLoadResource1" />
                                                           
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                     <asp:Button ID="UpdateReminder" runat="server" 
                            onclick="UpdateReminder_Click" style="display:none;" 
                                        meta:resourcekey="UpdateReminderResource1"   />
                                </td>
                            </tr>
                        </table>
                        <asp:HiddenField ID="hdnBookedID" runat="server" />
                   
                        </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
               </td>
            </tr>
        </table>
        <uc5:Footer ID="ucFooter" runat="server" />
    </div>
    </form>
</body>
</html>
