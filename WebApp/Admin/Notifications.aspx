<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Notifications.aspx.cs" EnableEventValidation="false"
    Inherits="Admin_Notifications" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
    
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Src="../Investigation/NotesPattern.ascx" TagName="NotesPattern" TagPrefix="uc41" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
<style type="text/css">
    .hideGridColumn
    {
        display:none;
    }
 </style>
    <script src="../Scripts/AdobeReaderDetection.js" type="text/javascript" language="javascript" />

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    
    <script type="text/javascript">
        function Validate() {           
            var CheckCount = 0;
            var gridView = document.getElementById("<%=grdResult.ClientID %>");
            var checkBoxes = gridView.getElementsByTagName("input");
            for (var i = 0; i < checkBoxes.length; i++) {
                if (checkBoxes[i].type == "checkbox" && checkBoxes[i].checked) {
                    CheckCount = CheckCount + 1;
                   // return;
                }
            }

            if (CheckCount == 0) {
                    alert('Select atleast one Notification Details')              
                return false;

            }
            if (document.getElementById('ddlVisitActionName').selectedIndex == 0) {
                alert('Please Select ActionType')               
                return false;
            }
        }
        
        
        function FunActionChange() {
            //debugger;
            document.getElementById('ddlVisitActionName').selectedIndex = 2;
            document.getElementById('btnGo').disabled = false; 
            
        }
        
        function setAceWidth(source, eventArgs) {        
            document.getElementById('aceClient').style.width = 'auto';            
            document.getElementById('Divzone').style.width = 'auto';
        }
        
        function ClearFields() {
            if (document.getElementById('txtClientName').value.trim() == "") {
                document.getElementById('hdnClientID').value = "";
            }
            
            if (document.getElementById('txtzone').value.trim() == "") {
                document.getElementById('hdntxtzoneID').value = "";
            }

            if (document.getElementById('txtReportCollectioncenter').value.trim() == "") {
                document.getElementById('hdnReportClientID').value = "";
            }           
            
        }

        function SelectedClient(source, eventArgs) {
           // debugger;
            var Name = eventArgs.get_text();
            var ID = eventArgs.get_value();
            document.getElementById('hdnClientID').value = eventArgs.get_value().split('|')[0];
        }
        
        function Onzoneselected(source, eventArgs) {
            document.getElementById('txtzone').value = eventArgs.get_text();
            document.getElementById('hdntxtzoneID').value = eventArgs.get_value();
        }

        function SelectedReportClient(source, eventArgs) {
            // debugger;
            var Name = eventArgs.get_text();
            var ID = eventArgs.get_value();
            document.getElementById('hdnReportClientID').value = eventArgs.get_value().split('|')[0];
        }
        
        function SelectAllNotification(sender) {
            //debugger;
            var chkArrayMain = new Array();
            chkArrayMain = document.getElementById('HdnNotoficationCheckBoxId').value.split('~');
            
            if (document.getElementById(sender).checked) {
                for (var i = 0; i < chkArrayMain.length; i++) {
                if(document.getElementById(chkArrayMain[i])!=null)
                    document.getElementById(chkArrayMain[i]).checked = true;
            }           
            }
            else {
                for (var i = 0; i < chkArrayMain.length; i++) {
                    if (document.getElementById(chkArrayMain[i]) != null)
                    document.getElementById(chkArrayMain[i]).checked = false;                 
                }
            }

            var chkDropDownMain = new Array();
            chkDropDownMain = document.getElementById('HdnNotificationDropDownId').value.split('~');
            
            if (document.getElementById(sender).checked) {
                for (var i = 0; i < chkDropDownMain.length; i++) {
                    if (document.getElementById(chkDropDownMain[i]) != null) {
                        document.getElementById(chkDropDownMain[i]).style.display = "block";
                        document.getElementById('ddlVisitActionName').selectedIndex = 2;
                    }
                }

            }
            else {
                for (var i = 0; i < chkDropDownMain.length; i++) {
                    if (document.getElementById(chkDropDownMain[i]) != null) {
                        document.getElementById(chkDropDownMain[i]).style.display = "none";
                        document.getElementById('ddlVisitActionName').selectedIndex = 0;
                    }
                }
            }

            var chkStatusLableMain = new Array();
            chkStatusLableMain = document.getElementById('HdnNotificationLableId').value.split('~');
            if (document.getElementById(sender).checked) {
                for (var i = 0; i < chkStatusLableMain.length; i++) {
                    if (document.getElementById(chkStatusLableMain[i]) != null)
                        document.getElementById(chkStatusLableMain[i]).style.display = "none";
                }
            }
            else {
                for (var i = 0; i < chkStatusLableMain.length; i++) {
                    if (document.getElementById(chkStatusLableMain[i]) != null)
                        document.getElementById(chkStatusLableMain[i]).style.display = "block";
                }                
            }            
        }

        //Enable/Disable DropDownList Inside Gridview
        function EnableDisableDropDownList(chk, ddlStatus, lblStatusinGrid) {
           // debugger;
            var ddlStatusinGrid = document.getElementById(ddlStatus);
            if ( chk.checked == true) {
                document.getElementById(ddlStatus).style.display = "block";
                document.getElementById(lblStatusinGrid).style.display = "none";
                document.getElementById('ddlVisitActionName').selectedIndex = 1;
            }
            else if ( chk.checked == false) {
            document.getElementById(ddlStatus).style.display = "none";
            document.getElementById(lblStatusinGrid).style.display = "block";
            }
        }
    </script>
</head>
<body id="oneColLayout">
  <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>          
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <%--Default Search options--%>
    <table id="tblPatient" runat="server" class="w-100p" cellpadding="2" cellspacing="2">
        <tr>
            <td>
                <asp:Panel ID="Panel3" CssClass="w-100p" DefaultButton="btnSearch" BorderWidth="0px"
                    runat="server" meta:resourcekey="Panel3Resource1">
                    <div style="display: block;" class="w-100p">
                        <table class="w-75p">
                            <tr id="trhide1" runat="server">
                                <td id="tdlblLabNo" runat="server">
                                    <asp:Label ID="lblLabNo" Text="Lab No" runat="server"></asp:Label>
                                </td>
                                <td id="tdtxtLabNo" runat="server">
                                    <asp:TextBox ID="txtLabNo" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                </td>
                                <td id="tdlblddActiontype" runat="server">
                                    <asp:Label ID="lblddActiontype" Text="Action Type" runat="server" style="width: 100px;"></asp:Label>
                                </td>
                                <td id="tdrichcombobox" runat="server">
                                    <span class="richcombobox" style="width: 155px;">
                                        <asp:DropDownList ID="ddActionType" CssClass="ddl" Width="155px" runat="server">
                                        </asp:DropDownList>
                                    </span>
                                </td>
                                <td>
                                    <asp:Label ID="lblclient" style="width: 100px;" Text="Client" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox  ID="txtClientName" runat="server" onBlur="return ClearFields();"
                                        meta:resourcekey="txtClientNameResource1" CssClass="AutoCompletesearchBox Txtboxsmall"></asp:TextBox>
                                   <asp:HiddenField ID="hdnClientID" runat="server" />
                                    <input type="hidden" runat="server" value="N" id="hdnIsCashClient" />
                                
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtenderClientCorp" runat="server" CompletionInterval="1"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2" 
                                                        OnClientItemSelected="SelectedClient" ServiceMethod="GetClientList" ServicePath="~/WebService.asmx"
                                                        TargetControlID="txtClientName">
                                                    </cc1:AutoCompleteExtender>
                                </td>
                            </tr>
                            <tr id="trClient" runat="server">
                                
                                <td>
                                    <asp:Label ID="lblZone" Text="Zone" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtzone" runat="server" CssClass="AutoCompletesearchBox Txtboxsmall" AutoComplete="off"
                                        OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"
                                       ></asp:TextBox>
                                    <div id="Divzone">
                                    </div>
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtenderzone" runat="server" TargetControlID="txtzone"
                                        CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                        MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetGroupMasterDetails"
                                        OnClientItemSelected="Onzoneselected" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                        Enabled="True" CompletionListElementID="Divzone" OnClientShown="setAceWidth">
                                    </cc1:AutoCompleteExtender>
                                    <input type="hidden" id="hdntxtzoneID" runat="server" value="0" />
                                </td>
                                 <td>
                                    <asp:Label ID="lblStatus" Text="Status" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <span class="richcombobox" style="width: 155px;">
                                        <asp:DropDownList ID="ddstatus" runat="server" CssClass="ddl" Width="155px">
                                        </asp:DropDownList>
                                    </span>
                                </td>
                                <td>
                                    <asp:Label ID="lblddlocation" Text="Reg.Location" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <span class="richcombobox" style="width: 155px;">
                                        <asp:DropDownList ID="ddlocation" CssClass="ddl" Width="155px" runat="server">
                                        </asp:DropDownList>
                                    </span>
                                </td>
                            </tr>
                            <tr id="trDepartment" runat="server">
                             <td id="Td4" runat="server" class="v-top a-left w-18p">
                                    <asp:Label ID="lblReportCollectioncenter" runat="server" Text="Report Collection Center"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox  ID="txtReportCollectioncenter" runat="server" onBlur="return ClearFields();"
                                        meta:resourcekey="txtClientNameResource1" CssClass="AutoCompletesearchBox Txtboxsmall"></asp:TextBox>
                                    
                                <asp:HiddenField ID="hdnReportClientID" runat="server" />
                                    <cc1:AutoCompleteExtender ID="AutoCompleteExtenderRptCollectCenter" runat="server" CompletionInterval="1"
                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                        Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2" 
                                                        OnClientItemSelected="SelectedReportClient" ServiceMethod="GetClientList" ServicePath="~/WebService.asmx"
                                                        TargetControlID="txtReportCollectioncenter">
                                                    </cc1:AutoCompleteExtender>
                                </td>
                           
                                <td id="Td41" runat="server" class="v-top a-left w-18p">
                                    <asp:Label ID="Label11" runat="server" Text="From : " meta:resourcekey="Label11Resource1"></asp:Label>
                                </td>
                                <td id="Td42" runat="server" class="v-top a-left w-18p">
                                    <asp:TextBox ID="TextBox2" runat="server"  CssClass="Txtboxsmall" 
                                        size="25" Width="126px"></asp:TextBox>
                                    <%--<a href="javascript:NewCssCall('<%=TextBox2.ClientID %>','ddMMMyyyy','arrow',true,12,'Y','Y','Y')">--%>
                                    <a href="javascript:NewCssCall('<%=TextBox2.ClientID %>','ddMMMyyyy','arrow',true,12,false)">
                                        <img src="../Images/Calendar_scheduleHS.png" alt="Pick a date"></a>
                                     
                                </td>
                                <td id="Td43" runat="server" class="v-top a-left">
                                    <asp:Label ID="Label12" runat="server" Text="To : " meta:resourcekey="Label12Resource1"></asp:Label>
                                </td>
                                <td id="Td44" runat="server" class="v-top a-left">
                                    <asp:TextBox ID="TextBox3" runat="server" CssClass="Txtboxsmall"
                                        size="25" Width="126px"></asp:TextBox>
                                    <%--<a href="javascript:NewCssCall('<%=TextBox3.ClientID %>','ddMMMyyyy','arrow',true,12,'Y','Y','Y')">--%>
                                    <a href="javascript:NewCssCall('<%=TextBox3.ClientID %>','ddMMMyyyy','arrow',true,12,false)">
                                        <img src="../Images/Calendar_scheduleHS.png" alt="Pick a date"></a>
                                </td>                                
                            </tr>
                          
                            <tr>
                                <td colspan="3" class="a-right v-middle">
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnSearch_Click" TabIndex="13" meta:resourcekey="btnSearchResource1" />
                                </td>
                                <td colspan="3" class="a-left v-middle">
                                  <%--  <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" TabIndex="14" OnClientClick="return ClearSearchFields();" />--%>
                                          <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                                            CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                            meta:resourcekey="btnCancelResource1" />
                                </td>
                                <td colspan="3" class="a-left">
                                    <asp:UpdateProgress ID="UpdateProgress4" runat="server">
                                        <ProgressTemplate>
                                            <div id="progressBackgroundFilter" class="a-center">
                                            </div>
                                            <div id="processMessage" class="a-center w-20p">
                                                <asp:Image ID="img22" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                                    meta:resourcekey="img1Resource1" />
                                            </div>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:Panel>
            </td>
        </tr>
     
                              
    </table>
    
    <%--Grid Functionality--%>
    <table id="tblgrdview" class="w-100p" runat="server" style="display: none;">
        <tr>
            <td>
                <asp:CheckBox ID="chkExportPdf" runat="server" Text="Click here to Export PDF" Style="display: none;" />
            </td>
        </tr>

        <tr id="ACX2responses3" style="display: table-row;">
            <td>                
           
                <table id="Table1" runat="server" class="w-100p">
                <%--Added by Radha -START--%>
              <tr>
                        <td class="colorforcontent w-30p h-23 a-left">
                            <div id="ACX2plus2" style="display: none;">
                                &nbsp;<img src="../Images/showBids.gif" alt="Show" width="15" height="15" align="top"
                                    style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','tblindv',2);" />
                                <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',2);">
                                    &nbsp;<asp:Label ID="lblinvfilter" runat="server" Text="Show Notification Details" meta:resourcekey="lblinvfilterResource1"></asp:Label></span>
                            </div>
                            <div id="ACX2minus2" style="display: block;">
                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                    style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','tblindv',0);" />
                                <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);">
                                    &nbsp;<asp:Label ID="lblinvfilters" runat="server" Text="Hide Notification Details" meta:resourcekey="lblinvfiltersResource1"></asp:Label></span>
                            </div>
                        </td>
                    </tr>
                    <%--Added by Radha -END--%>
                    <tr id="tblindv" style="display: none;">
                        <td>
                            <div id="divNotifyResult">
                                <asp:GridView ID="grdResult" EmptyDataText="No Record Found" runat="server" CellPadding="1"
                                    AutoGenerateColumns="false" ItemStyle-VerticalAlign="Top" DataKeyNames="LabNumber,NotificationID,ReportType"
                                    ForeColor="Black"  CssClass="w-100p gridView" OnRowDataBound="grdResult_OnRowDataBound" OnRowCommand="grdResult_RowCommand"
                                    RepeatDirection="Horizontal">                                  

                                   <Columns>  
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID = "chkAll" runat="server" ToolTip="Select Row" onclick="SelectAllNotification(this.id);" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSel" runat="server"/>
                                        <asp:HiddenField ID="hdID" runat="server" Value='<%# Eval("NotificationID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>  
                                 <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblreport" runat="server" text="Print Report"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="Image1" ImageUrl="../Images/WithStationary.ico" runat="server" Enabled="false"   
                                                                meta:resourcekey="Image1Resource1" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                CommandName="ShowWithStationary" Style="cursor: pointer; margin-left: 10px" />
                                       <asp:ImageButton ID="ImageButton1" ImageUrl="../Images/printer.gif" runat="server"
                                                                meta:resourcekey="ImageButton1Resource1" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                CommandName="ShowWithoutStationary" Style="cursor: pointer; margin-left: 10px;display: none"/>
                                    <asp:Label ID="lblPatientVisitId" runat="server"  style="display: none;" Text='<%# Eval("PatientVisitId") %>' ></asp:Label>
                                   <asp:Label ID="lblActionType" runat="server"  style="display: none;" Text='<%# Eval("ActionType") %>' ></asp:Label>
                                    </ItemTemplate>
                                 </asp:TemplateField>                    
                                <asp:BoundField  DataField="Name" ReadOnly="true"  HeaderText="User" />         
                                <asp:BoundField  DataField="NotificationID" HeaderText="NotificationID" HeaderStyle-CssClass = "hideGridColumn" ItemStyle-CssClass="hideGridColumn"/> 
                                <asp:BoundField  DataField="LabNumber" ReadOnly="true"  HeaderText="LabNumber" /> 
                                <asp:BoundField  DataField="ActionType" HeaderText="ActionType" ReadOnly="true" /> 
                                  
                                    <asp:TemplateField HeaderText="Status" ItemStyle-Width = "150">
                                    <ItemTemplate>
                                        <asp:Label ID = "lblStatusinGrid" runat="server" style="display: block;" Text='<%# Eval("Status") %>'></asp:Label>
                                        <asp:DropDownList ID="ddlStatusinGrid" runat="server" style="display: none;" CssClass="ddl drpNotification" onchange="FunActionChange();">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>                                
                                <asp:BoundField  DataField="Zone" HeaderText="Zone" ReadOnly="true"/> 
                                <asp:BoundField  DataField="ReportType" HeaderText="ReportType" ReadOnly="true"/> 
                                <asp:BoundField  DataField="Location" HeaderText="Reg.Location" ReadOnly="true" /> 
                                <asp:BoundField  DataField="ClientNames" HeaderText="Client" ReadOnly="true"/> 
                                <asp:BoundField  DataField="Destination" HeaderText="Destination" ReadOnly="true" /> 
                                <asp:BoundField  DataField="Reason" HeaderText="Reason" ReadOnly="true"/> 
                                <asp:BoundField  DataField="CreatedDate" HeaderText="CreatedDate" ReadOnly="true"/> 
                                <asp:BoundField  DataField="ReportingCenter" HeaderText="Report Collection Center" ReadOnly="true"/>                                 
                        </Columns>
                               <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                        <HeaderStyle CssClass="colorforcontent" ForeColor="White" />
                                                                        <EmptyDataRowStyle BackColor="LightBlue" ForeColor="Black" />
                                                                    
                                </asp:GridView>
                                <ajc:ModalPopupExtender ID="modalPopUp" runat="server" DropShadow="false" PopupControlID="pnlOthers"
                                    BackgroundCssClass="modalBackground" Enabled="True" TargetControlID="btnDummy">
                                </ajc:ModalPopupExtender>
                               <asp:Panel ID="pnlOthers" runat="server" Style="display: none; height: 600px; width: 1050px;
                                vertical-align: bottom; top: 80px;" meta:resourcekey="pnlOthersResource1">
                                <table class="w-100p a-center">
                                    <tr>
                                        <td class="a-right">
                                            <img class="w-29 h-30 pointer" src="../Images/Close_Red_Online_small.png" alt="Close"
                                                id="img2" onclick="ClosePopUp()" style="position: absolute; top: -8px; right: 10px;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <iframe id="ifPDF" runat="server" width="1000" height="550"></iframe>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="button" id="btnDummy" runat="server" style="display: none;" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            </div>
                        </td>
                          <td  class="w-50p" align="Center" id="tdExportReport" runat="server" style="display:none;">                     

               
                    </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table class="w-100p">
        <div id="tblpage" runat="server" class="w-100p">
            <tr id="trFooter" runat="server" class="dataheaderInvCtrl">
                <td colspan="2" class="defaultfontcolor a-center">
                    <div id="divFooterNav" runat="server">
                        <asp:Label ID="Label1" runat="server" Text="Page"></asp:Label>
                        <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                        <asp:Label ID="Label13" runat="server" Text="Of"></asp:Label>
                        <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                        <asp:Button ID="Btn_Previous" runat="server" Text="Previous" OnClick="Btn_Previous_Click"
                            CssClass="btn" Style="width: 71px" />
                        <asp:Button ID="Btn_Next" runat="server" Text="Next" OnClick="Btn_Next_Click" CssClass="btn" />
                        <asp:HiddenField ID="hdnCurrent" runat="server" />
                        <asp:HiddenField ID="hdnPostBack" runat="server" />
                        <asp:HiddenField ID="hdnOrgID" runat="server" />
                        <asp:Label ID="Label14" runat="server" Text="Enter The Page To Go:"></asp:Label>
                        <asp:TextBox ID="txtpageNo" runat="server" Width="30px" onkeypress="return ValidateOnlyNumeric(this);"></asp:TextBox>
                        <asp:Button ID="Button1" runat="server" Text="Go" 
                            OnClick="btnGo_Click1" CssClass="btn" />
                    </div>
                </td>
            </tr>
             <tr id="trSelectVisit" runat="server" visible="false">
                            <td class="defaultfontcolor">
                                <asp:Label ID="Rs_Info" Text="Select a Notification and Choose one of the following" runat="server"
                                    ></asp:Label>
                                <asp:DropDownList onchange="return storevalue();" ID="ddlVisitActionName" CssClass="ddlmedium"
                                    runat="server" >
                                </asp:DropDownList>
                                <asp:Button ID="btnGo" runat="server" Enabled="false"  Text="Go" CssClass="btn" OnClick="btnGo_Click" OnClientClick="return Validate();"/>
                                <input type="hidden" id="hdnActionGo" runat="server" value="0";/>
                            </td>
           </tr>
            <tr>
                    <td>
                        <asp:Label ID="lblMessage1" runat="server" meta:resourcekey="lblMessage1Resource1"></asp:Label>
                        <asp:Label ID="lblResult" runat="server" CssClass="casesheettext" meta:resourcekey="lblResultResource1"></asp:Label>
                    </td>
                </tr>
        </div>
    </table>
    <br />
      <table class="w-100p">
            <tr>
                <td>
                    <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessageResource1"></asp:Label>
                </td>
            </tr>
        </table>
     
 
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
     <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hndBillprintHide" runat="server" />
    <asp:HiddenField ID="HiddenField4" runat="server" />
    <asp:HiddenField ID="hdnPrintReport" runat="server" />
    <asp:HiddenField ID="hdnConfirmprint" runat="server" Value="No" />
<asp:HiddenField ID="hdnisduebill" runat="server" Value="0" />
  <asp:HiddenField ID="HdnID" runat="server" />
  <input type="hidden" id="hdndrpdowndetail" runat="server" />
   <input type="hidden" id="hdnPDFType" name="PType" runat="server" />
    <input type="hidden" id="hdnPNAME" name="PName" runat="server" />
    <input type="hidden" id="hdnPID" name="pid" runat="server" />
    <input type="hidden" id="hdnVID" name="vid" runat="server" />
    <input type="hidden" id="hdnVisitDetail" runat="server" />
    <input type="hidden" id="patOrgID" runat="server" name="patOrgID" />
    <input type="hidden" id="ChkID" runat="server" />
    <input type="hidden" id="hdndeptid" runat="server" />
    <input type="hidden" id="hdndeptvalues" runat="server" />
    <asp:HiddenField ID="HdnCheckBoxId" runat="server" />
    <asp:HiddenField ID="Hdndisablebox" runat="server" />
    <asp:HiddenField ID="hdnHideDetails" Value="0" runat="server" />
    <asp:HiddenField ID="hdnReferralType" runat="server" />
    <asp:HiddenField ID="hdnEMail" runat="server" />
    
    <asp:HiddenField ID="HiddenField2" runat="server" />
    <asp:HiddenField ID="hdncreditlimit" runat="server" Value="0.00" />
    <asp:HiddenField ID="hdnclientBlock" runat="server" />
    <asp:HiddenField ID="hdnrolename" runat="server" />
    <asp:HiddenField ID="hdndespatchvisit" runat="server" />
    <asp:HiddenField ID="hdndespatchClientId" runat="server" />
    <asp:HiddenField ID="hdnpreviousdue" runat="server" />
    <asp:HiddenField ID="hdnonoroff" runat="server" Value="N" />
    <asp:HiddenField ID="hdnclientdue" runat="server" Value="0.00" />
    <asp:HiddenField ID="hdnDispatchType" runat="server" Value="" />
    <asp:HiddenField ID="hdnDispatchMode" runat="server" Value="" />
    <input type="hidden" id="hdnHealthcheckup" runat="server" value="N" />
    <asp:HiddenField ID="hdnDispatch" runat="server" Value="" />
    <asp:HiddenField ID="hdnHomeList" runat="server" Value="" />
    <asp:HiddenField ID="hdnDoctorList" runat="server" Value="" />
    <asp:HiddenField ID="hdnPartial" runat="server" Value="" />
    <asp:HiddenField ID="hdnPending" runat="server" Value="" />
    <input type="hidden" id="hdnIsGeneralClient" runat="server" value="" />
    <input type="hidden" id="hdnPriority" name="Priority" runat="server" />
   <asp:HiddenField ID="HdnNotoficationCheckBoxId" runat="server" />
   <asp:HiddenField ID="HdnNotificationDropDownId" runat="server" />
   <asp:HiddenField ID="HdnNotificationLableId" runat="server" />
    </form>
  
    <script type="text/javascript">       

        function storevalue() {
            //debugger;            
            var e = document.getElementById("ddlVisitActionName"); // select element
            var ddloption1 = "Edit Notification";
            var ddloption2 = "Update Notification";
            var strUser = e.options[e.selectedIndex].text;            
            document.getElementById('hdndrpdowndetail').value = strUser;

            if ($(strUser).val() === ddloption1) {
                $("option[value='Edit Notification']").hide();            
            }
            
        }

        function pageLoad() {
            $("#grouptab_InvestigationStatusReportTab_txtFrom").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '2008:2050'
            }); // Will run at every postback/AsyncPostback
            $("#grouptab_InvestigationStatusReportTab_txtTo").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '2008:2050'
            });

            $("#grouptab_testStatisticReportTab_txtFromDate").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '2008:2050'
            }); // Will run at every postback/AsyncPostback
            $("#grouptab_testStatisticReportTab_txtToDate").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '2008:2050'
            });

        }

//        function ClearSearchFields() {
//            //debugger;
//            document.getElementById('ddActionType').selectedIndex = 0;
//            // $("select#selected").prop('selectedIndex', -1);
//            document.getElementById('ddlocation').selectedIndex = 0;
//            //document.getElementById('ddlReportCollectionCenter').selectedIndex = 0;
//            document.getElementById('ddlVisitActionName').selectedIndex = 0;
//            document.getElementById('ddstatus').selectedIndex = 0;
//            document.getElementById('TextBox2').value = "";
//            document.getElementById('TextBox3').value = "";
//            document.getElementById('txtzone').value = "";
//            document.getElementById('txtLabNo').value = "";
//            document.getElementById('txtClientName').value = "";
//            document.getElementById('txtReportCollectioncenter').value = "";
//            document.getElementById('hdnReportClientID').value = "";
//            document.getElementById('hdnClientID').value = "";
//            return false;
//        }


        function ClosePopUp() {
            $find('modalPopUp').hide();
        }

        

       
    </script>

</body>
</html>
