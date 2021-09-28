<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserMaster.aspx.cs" Inherits="Admin_UserMaster"
    Debug="true" meta:resourcekey="PageResource1" EnableEventValidation="false" ValidateRequest="true" %>

<%--<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>--%>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc7" %>
<%--<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>--%>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc10" %>
<%@ Register Src="~/CommonControls/PatientAddress.ascx" TagName="AddressControl"
    TagPrefix="uc12" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="~/CommonControls/Audit_History.ascx" TagName="Audit_History" TagPrefix="adh1" %>
<%@ Register Src="~/CommonControls/LocationUserMap.ascx" TagName="LocationUserMap"
    TagPrefix="ctrl" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>
        <%=Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_01%>
    </title>
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />
    <%--<link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/Common.js" type="text/javascript"></script>

<script type="text/javascript" src="../Scripts/bid.js"></script>--%>

    

    <%--	<script src="../Scripts/MessageHandler.js" type="text/javascript"></script>--%>



<style>
        .style2
        {
            height: 23px;
        }
        #ACX2responses2 td.btn-center { text-align:center!important;}
        .createUser {
            background: #fff;
            text-decoration: none;
            padding: 4px 10px;
            font-weight:bold;
            border-radius: 5px;-moz-border-radius: 5px;-webkit-border-radius: 5px;-khtml-border-radius: 5px;-o-border-radius: 5px;-ms-border-radius: 5px;
            border: 1px solid #aaa;
        }
        .createUser { text-decoration: underline;}
        .RoleLink{cursor :pointer ;}
</style>


</head>
<body>
    <form id="frmPatientVitals" runat="server" enctype="multipart/form-data" onkeydown="SuppressBrowserRefresh();">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server" ScriptMode="Release">    
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="DivErrors" runat="server" style="display: none;">
            <table class="w-100p h-10">
                <tr>
                    <td class="a-center">
                    </td>
                </tr>
            </table>
        </div>
        <asp:UpdatePanel ID="uPnlUserMaster" runat="server">
            <ContentTemplate>
                <table class="tabletxt w-100p">
                    <tr class="w-100p">
                        <td colspan="2">
                            <table id="mytable1" class="w-100p">
                                <tr>
                                    <td class="colorforcontent w-100p h-23 a-left" colspan="2">
                                        <div style="display: none;" runat="server" id="ACX2plusEU">
                                            &nbsp;<img src="../Images/showBids.gif" alt="Show" class="w-15 h-15 v-top" style="cursor: pointer"
                                                onclick="showResponses('ACX2plusEU','ACX2minusEU','ACX2responsesEU',2);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusEU','ACX2minusEU','ACX2responsesEU',2);">
                                                <asp:Label ID="Rs_EditExistingUser" Text="Edit Existing User" runat="server" meta:resourcekey="Rs_EditExistingUserResource1"></asp:Label></span>
                                        </div>
                                        <div class="h-18" style="display: block;" runat="server" id="ACX2minusEU">
                                            &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top" style="cursor: pointer"
                                                onclick="showResponses('ACX2plusEU','ACX2minusEU','ACX2responsesEU',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusEU','ACX2minusEU','ACX2responsesEU',0);">
                                                <asp:Label ID="Rs_EditExistingUser1" Text="Edit Existing User" runat="server" meta:resourcekey="Rs_EditExistingUser1Resource1"></asp:Label></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="tablerow" id="ACX2responsesEU" runat="server" style="display: table-row">
                                    <td id="Td1" colspan="5" runat="server">
                                        <div class="dataheader2 searchPanel">
                                            <div id="divEdit">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td>
                                                            <br />
                                                            <table style="width: 48%">
                                                                <tr>
                                                                    <asp:UpdatePanel ID="updatePanelSearch" runat="server">
                                                                        <ContentTemplate>
                                                                            <td>
                                                                                <asp:Label ID="Label1" runat="server" Text="Name" meta:resourcekey="Label1Resource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtName1" autocomplete="off" runat="server" CssClass="small" meta:resourcekey="txtName1Resource1"></asp:TextBox>
                                                                                <ajc:AutoCompleteExtender ID="AutoGname1" runat="server" TargetControlID="txtName1"
                                                                                    ServiceMethod="getUserNames" ServicePath="~/WebService.asmx" EnableCaching="False"
                                                                                    MinimumPrefixLength="2" BehaviorID="AutoCompleteExLstGrp11" CompletionInterval="30"
                                                                                    DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected" Enabled="True">
                                                                                </ajc:AutoCompleteExtender>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Button ID="btnSearch" Text="Search" runat="server" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                                    onmouseout="this.className='btn'" OnClientClick="return CheckName()" OnClick="btnSearch_Click"
                                                                                    meta:resourcekey="btnSearchResource1" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:CheckBox ID="chkbxDelete" Text="Include Inactive Users" runat="server" meta:resourcekey="chkbxDeleteResource1" />
                                                                                       <%-- </td>
                                                                                        <td>--%>
                                                                                <input type="radio" name="Role" runat="server" id="rbtnUser" onblur="AutoGName1ContextKey();"
                                                                                    value="users" checked="true" />
                                                                                                <%--User--%><%=Resources.Admin_AppMsg.Admin_UserMaster_aspx_38 %>
                                                                                                <input type="radio" name="Role" runat="server" onblur="AutoGName1ContextKey();" id="rbtnPatient"
                                                                                                    value="patient" /><%--Patient--%><%=Resources.Admin_AppMsg.Admin_UserMaster_aspx_39 %>
                                                                                                <input type="radio" name="Role" runat="server" onblur="AutoGName1ContextKey();" id="rbtnOnline"
                                                                                                    value="online" /><%--Portal User--%><%=Resources.Admin_AppMsg.Admin_UserMaster_aspx_40 %>
                                                                            </td>
                                                                            <td>
                                                                                <asp:ImageButton ID="imgBtnXL" runat="server" Text="Export to exel" ImageUrl="../Images/ExcelImage.GIF"
                                                                                    ToolTip="Save As Excel" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                                                            </td>
                                                                        </ContentTemplate>
                                                                        <Triggers>
                                                                            <asp:PostBackTrigger ControlID="imgBtnXL" />
                                                                        </Triggers>
                                                                    </asp:UpdatePanel>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:GridView ID="grdResult" runat="server" AllowPaging="True" CellPadding="2" AutoGenerateColumns="False"
                                                                DataKeyNames="LoginID,SURNAME,RoleID,LoginName,RoleName,Status,EndDTTM,BlockedFrom,BlockedTo,BlockReason"
                                                                OnRowDataBound="grdResult_RowDataBound" ForeColor="#333333" CssClass="mytable1"
                                                                OnPageIndexChanging="grdResult_PageIndexChanging" OnRowCommand="grdResult_RowCommand"
                                                                OnRowDeleting="grdResult_RowDeleting" meta:resourcekey="grdResultResource1">
                                                                <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                                    PageButtonCount="5" PreviousPageText="" />
                                                                <PagerStyle CssClass="pagerTable" HorizontalAlign="Center" BackColor="White" ForeColor="Red" />
                                                                <HeaderStyle CssClass="dataheader1" />
                                                                <Columns>
                                                                    <asp:BoundField Visible="False" DataField="LoginID" HeaderText="LoginID" meta:resourcekey="BoundFieldResource1" />
                                                                    <asp:TemplateField HeaderText="Select" Visible="False" meta:resourcekey="TemplateFieldResource1">
                                                                        <ItemTemplate>
                                                                            <asp:RadioButton ID="rdSel" runat="server" ToolTip="Select Row" GroupName="PatientSelect"
                                                                                meta:resourcekey="rdSelResource1" />
                                                                        </ItemTemplate>
                                                                        <ItemStyle CssClass="w-10p"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="Name" HeaderText="Name" meta:resourcekey="BoundFieldResource2">
                                                                        <ItemStyle CssClass="a-left w-18p RoleLink"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="SURNAME" HeaderText="Role Name" meta:resourcekey="BoundFieldResource3">
                                                                        <ItemStyle CssClass="w-25p RoleLink"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:BoundField Visible="False" DataField="LoginID" HeaderText="Login ID" meta:resourcekey="BoundFieldResource4">
                                                                        <ItemStyle CssClass="w-18p"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:TemplateField SortExpression="LoginName" meta:resourcekey="TemplateFieldResource2">
                                                                        <HeaderTemplate>
                                                                            <asp:LinkButton ID="lnkLoginName" runat="server" CommandName="Sort" CommandArgument="LoginName" Text="LoginName"
                                                                                meta:resourcekey="lnkLoginNameResource1">LoginName </asp:LinkButton>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblLoginName" Text='<%# Bind("LoginName") %>' runat="server"> </asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle CssClass="w-13p RoleLink"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="IsLocked" HeaderText="IsLocked" meta:resourcekey="BoundFieldResource5">
                                                                        <ItemStyle CssClass="w-7p"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="EndDTTM" HeaderText="EndDTTM" Visible="false" ApplyFormatInEditMode="true"
                                                                        DataFormatString="{0:dd/MM/yyyy}" meta:resourcekey="BoundFieldResource6">
                                                                        <ItemStyle CssClass="w-7p"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="IsBlocked" HeaderText="IsBlocked" Visible="false" meta:resourcekey="BoundFieldResource7">
                                                                        <ItemStyle CssClass="w-7p"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="BlockedFrom" HeaderText="BlockedFrom" Visible="false"
                                                                        ApplyFormatInEditMode="true" DataFormatString="{0:dd/MM/yyyy}" meta:resourcekey="BoundFieldResource8">
                                                                        <ItemStyle CssClass="w-7p"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="BlockedTo" HeaderText="BlockedTo" Visible="false" ApplyFormatInEditMode="true"
                                                                        DataFormatString="{0:dd/MM/yyyy}" meta:resourcekey="BoundFieldResource9">
                                                                        <ItemStyle CssClass="w-7p"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="BlockReason" HeaderText="BlockReason" Visible="false"
                                                                        meta:resourcekey="BoundFieldResource10">
                                                                        <ItemStyle CssClass="w-7p"></ItemStyle>
                                                                    </asp:BoundField>
                                                                    <asp:TemplateField HeaderText="Action" meta:resourcekey="TemplateFieldResource3">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblStatus" Text='<%# Bind("Status") %>' runat="server" Visible="False"
                                                                                meta:resourcekey="lblStatusResource1"></asp:Label>
                                                                            <asp:LinkButton ID="lnkDelete" runat="server" CommandName="DELETE" OnClientClick="ConfirmDelete();"
                                                                                meta:resourcekey="lnkDeleteResource1">DELETE</asp:LinkButton>
                                                                            <asp:LinkButton ID="lnkSusp" runat="server" CommandName="SUSPEND" Text="SUSPEND"
                                                                                Visible="False" meta:resourcekey="lnkSuspResource1"></asp:LinkButton>
                                                                            <%--|<asp:LinkButton ID="lnkAct" runat="server" CommandName="ACTIVATE" Visible="false">ACTIVATE</asp:LinkButton>--%>
                                                                            &nbsp;|&nbsp;
																			 <asp:Label ID="Label3" Text=" | " runat="server"></asp:Label>                                                                                 
                                                                            <asp:LinkButton ID="lnkReset" Style="color: Red; text-decoration: underline;" runat="server"
                                                                                CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' CommandName="Reset"
                                                                                OnClientClick="ConfirmResetPswd();" Text="Reset Password" meta:resourcekey="lnkResetResource1"></asp:LinkButton>
																				<asp:Label ID="lblSymbol" Text=" | " runat="server" Visible="false"></asp:Label>     
                                                                            <asp:LinkButton ID="lnkCreatePwd" Style="color: Red; text-decoration: underline;" runat="server"
                                                                                CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' CommandName="GeneratePWD"
                                                                                Text="Generate Password" Visible="false"></asp:LinkButton>    
                                                                        </ItemTemplate>
                                                                        <ItemStyle CssClass="w-20p" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="History" meta:resourcekey="TemplateFieldResource4">
                                                                        <ItemTemplate>
                                                                            <asp:ImageButton ID="btnHistory" CssClass="h-25" ImageUrl="~/Images/Hist2.png" runat="server"
                                                                                CommandArgument='<%# DataBinder.Eval(Container.DataItem, "LoginID") %>' CommandName="History"
                                                                                meta:resourcekey="btnHistoryResource1" />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                            <asp:Label ID="lblMsg" runat="server" meta:resourcekey="lblMsgResource1"></asp:Label>
                                                            <asp:Label ID="lblLoginNam" runat="server" meta:resourcekey="lblLoginNamResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <br />
                                                            &nbsp;<asp:Button ID="btnEdit" Visible="False" runat="server" Text="Edit" CssClass="btn w-75"
                                                                onmouseover="this.className='btn btnhov'" OnClientClick="return pChekUserName('E') "
                                                                onmouseout="this.className='btn'" OnClick="btnEdit_Click" meta:resourcekey="btnEditResource1" />
                                                            <asp:Button ID="btnDelete" Visible="False" runat="server" Text="Delete User" CssClass="btn w-75"
                                                                onmouseover="this.className='btn btnhov'" OnClientClick="return pChekUserName('y')"
                                                                onmouseout="this.className='btn'" OnClick="btnDelete_Click" meta:resourcekey="btnDeleteResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5">
                                        <asp:Label ID="lblLoginName" runat="server" meta:resourcekey="lblLoginNameResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left colorforcontent">
                                        <div style="display: none" runat="server" id="ACX2plus2">
                                            <img src="../Images/showBids.gif" class="w-15 h-15 v-top" alt="Show" style="cursor: pointer"
                                                onclick="showuserResponses('ACX2plus2','ACX2minus2','ACX2responses2','ACX2responsesEU',2);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="return showuserResponses('ACX2plus2','ACX2minus2','ACX2responses2','ACX2responsesEU',2);">
                                                <asp:Label ID="Rs_CreateEditUser" Text="Create \ Edit User" runat="server" meta:resourcekey="Rs_CreateEditUserResource1"></asp:Label></span>
                                        </div>
                                        <div style="display: block" runat="server" id="ACX2minus2">
                                            <img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top" style="cursor: pointer"
                                                onclick="showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);" />
                                            <span class="dataheader1txt" style="cursor: pointer" onclick="return showResponses('ACX2plus2','ACX2minus2','ACX2responses2',0);">
                                                <asp:Label ID="Rs_CreateEditUser1" Text="Create \ Edit User" runat="server" meta:resourcekey="Rs_CreateEditUser1Resource1"></asp:Label></span>
                                        </div>
                                    </td>
                                    <td class="w-20p paddingL10">
                                        <asp:LinkButton ID="lnkCreateNewUser" CssClass="createUser" runat="server" Text="Create New User"
                                            OnClick="lnkCreateNewUser_Click" meta:resourcekey="lnkCreateNewUserResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr id="ACX2responses2" runat="server" style="display: table-row">
                                    <td id="Td2" class="a-left v-top" colspan="5" runat="server">
                                        <div class="dataheader2">
                                            <input type="hidden" id="hdnSpciality" runat="server">
                                            <input id="hdnLocation" runat="server" type="hidden"></input>
                                            <input id="hdnLocationList" runat="server" type="hidden"></input>
                                            <asp:UpdatePanel ID="pnlPurpose" runat="server">
                                                <ContentTemplate>
                                                    <br />
                                                    <asp:Panel ID="Panel3" runat="server" GroupingText="Select UserType" CssClass="w-100p searchPanel"
                                                        meta:resourcekey="Panel3Resource1">
                                                        <asp:CheckBoxList ID="chkUserType" runat="server" onclick="hideSpeciality();" OnDataBound="chkUserType_DataBound"
                                                            RepeatColumns="8" RepeatDirection="Horizontal" meta:resourcekey="chkUserTypeResource1">
                                                        </asp:CheckBoxList>
                                                    </asp:Panel>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                            <table class="w-100p">
                                                <tr>
                                                    <td colspan="5">
                                                        <div id="Speciality" runat="server" style="display: none;">
                                                            <table class="w-100p">
                                                                <tr>
                                                                    <td class="a-right v-top">
                                                                    </td>
                                                                    <td class="a-left w-15p v-top" style="padding-left: 20px;">
                                                                        <span style="color: Red; font-size: small;">
                                                                            <asp:Label ID="Rs_Info" runat="server" Text="* Double click to select the speciality for physician role"
                                                                                meta:resourcekey="Rs_InfoResource1"></asp:Label>
                                                                        </span>
                                                                    </td>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                                <tr class="w-100p">
                                                                    <td class="a-left v-top w-13p">
                                                                        <asp:Label ID="Rs_SelectSpeciality" runat="server" Text="Select Speciality" meta:resourcekey="Rs_SelectSpecialityResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="w-42p">
                                                                        <asp:ListBox ID="lstBoxSpeciality" runat="server" CssClass="font11" Height="150px"
                                                                            ondblclick="javascript:onClickSpcial(this.id);" onkeypress="javascript:setSpItem(event,this);"
                                                                            Width="336px" meta:resourcekey="lstBoxSpecialityResource1"></asp:ListBox>
                                                                    </td>
                                                                    <td class="w-40p v-top">
                                                                        <div style="height: 145px; overflow: auto; width: 300px;">
                                                                            <table id="tblSpeciality" runat="server" class="dataheaderInvCtrl w-93p" style="display: none;">
                                                                                <tr id="Tr1" runat="server" class="colorforcontent">
                                                                                    <td id="Td3" runat="server" class="bold font10 h-8 w-5p" style="color: White;">
                                                                                        <asp:Label ID="Rs_Delete1" runat="server" Text="Delete" meta:resourcekey="Rs_Delete1Resource1"></asp:Label>
                                                                                    </td>
                                                                                    <td id="Td4" runat="server" class="bold font10 h-8 w-25p" style="color: White;">
                                                                                        <asp:Label ID="Rs_Speciality" runat="server" Text="Speciality" meta:resourcekey="Rs_SpecialityResource1"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <asp:Label ID="lblmsgloc" runat="server" meta:resourcekey="lblmsglocResource1"></asp:Label>
                                                        <asp:HiddenField ID="hdnUserID" runat="server" />
                                                        <asp:HiddenField ID="hdn" runat="server" />
                                                        <asp:HiddenField ID="hdnlst" runat="server" />
                                                        <asp:HiddenField ID="hdndelete" runat="server" />
                                                        <asp:HiddenField ID="hdnOrgAddressID" runat="server" Value="0" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td id="tdInventoryLocation" runat="server" class="a-center" style="display: none;">
                                                        <asp:Panel ID="pnlOthers" runat="server" CssClass="modalPopup dataheaderPopup" Style="display: none;
                                                            width: 740px;" meta:resourcekey="pnlOthersResource1">
                                                            <div id="divOthers">
                                                                <table class="dataheader2 defaultfontcolor w-100p">
                                                                    <tr style="display: none;">
                                                                        <td>
                                                                            <asp:Label ID="Label2" runat="server" meta:resourcekey="Label2Resource1"></asp:Label>
                                                                            <asp:HiddenField ID="hdnLocationID" runat="server" Value="0" />
                                                                            <asp:HiddenField ID="hdnStatus" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:Label ID="lblOrganisationAddress" runat="server" Text="Organisation Address"
                                                                                meta:resourcekey="lblOrganisationAddressResource1"></asp:Label>
                                                                            &nbsp;<asp:DropDownList ID="drpOrgAddress" CssClass="ddlsmall" runat="server" >
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="lblLocation" runat="server" Text="Location" meta:resourcekey="lblLocationResource1"></asp:Label>
                                                                            &nbsp;<asp:TextBox ID="txtLocation" runat="server" CssClass="small" onkeypress="return validorgaddress();"
                                                                                meta:resourcekey="txtLocationResource1"></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblLocationType" runat="server" Text="LocationType" meta:resourcekey="lblLocationTypeResource1"></asp:Label>
                                                                            &nbsp;<asp:DropDownList ID="ddlLocationType" CssClass="ddlsmall" runat="server" >
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td style="display: none;">
                                                                            <asp:Label ID="lblActive" runat="server" Text="Active" meta:resourcekey="lblActiveResource1"></asp:Label>
                                                                            &nbsp;<asp:CheckBox ID="chkStatus" runat="server" meta:resourcekey="chkStatusResource1" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <div>
                                                                                <br></br>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <div class="a-center">
                                                                                <table class="a-center w-100p">
                                                                                    <tr>
                                                                                        <td class="a-left">
                                                                                            <asp:CheckBoxList ID="chklistProductType" runat="server" RepeatColumns="3" meta:resourcekey="chklistProductTypeResource1">
                                                                                            </asp:CheckBoxList>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <div>
                                                                                <br />
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="a-right">
                                                                            <asp:Button ID="btnOK" runat="server" CssClass="btn" OnClick="btnOK_click" OnClientClick="return doValidation();"
                                                                                Text="OK" meta:resourcekey="btnOKResource1" />
                                                                        </td>
                                                                        <td class="a-left">
                                                                            <asp:Button ID="btnClose" runat="server" Text="Cancel" CssClass="btn" OnClientClick="javascript:return doClear();"
                                                                                meta:resourcekey="btnCloseResource1" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </asp:Panel>
                                                        <%--<ajc:ModalPopupExtender ID="mpeOthers" runat="server" BackgroundCssClass="modalBackground"
                                                            BehaviorID="mpeOthersBehavior" CancelControlID="btnClose" DynamicServicePath=""
                                                            Enabled="True" PopupControlID="pnlOthers" TargetControlID="btnaddNew">
                                                        </ajc:ModalPopupExtender>--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="5">
                                                        <div id="Location" runat="server" style="display: none;">
                                                            <table class="w-100p">
                                                                <tr>
                                                                    <td>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-left w-10p v-top">
                                                                        <asp:Label ID="Rs_SelectLocation" runat="server" Text="Select Location" meta:resourcekey="Rs_SelectLocationResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="w-40p">
                                                                        <asp:ListBox ID="ListBoxInv" runat="server" CssClass="font11 marginL15" Height="150px"
                                                                            ondblClick="javascript:onClickLoc(this.id);" onkeypress="javascript:setLocItem(event,this);"
                                                                            Width="336px" meta:resourcekey="ListBoxInvResource1"></asp:ListBox>
                                                                        <%--<asp:LinkButton ID="btnaddNew" runat="server" Font-Bold="True" Font-Underline="True"
                                                                            ForeColor="OrangeRed" Text="Add Location" meta:resourcekey="btnaddNewResource1"></asp:LinkButton>--%>
                                                                    </td>
                                                                    <td class="w-40p v-top">
                                                                        <div style="height: 145px; overflow: auto; width: 300px;">
                                                                            <table id="tblInv" runat="server" class="dataheaderInvCtrl w-100p" style="display: none;">
                                                                                <tr id="Tr2" runat="server" class="colorforcontent">
                                                                                    <td id="Td5" runat="server" class="bold font10 h-8 w-5p" style="color: White;">
                                                                                        <asp:Label ID="Rs_Delete" runat="server" Text="Delete" meta:resourcekey="Rs_DeleteResource1"></asp:Label>
                                                                                    </td>
                                                                                    <td id="Td6" runat="server" class="bold font10 h-8 w-25p" style="color: White;">
                                                                                        <asp:Label ID="Rs_Location" runat="server" Text="Location" meta:resourcekey="Rs_LocationResource1"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <asp:HiddenField ID="hdnorgid" runat="server" />
                                                        <asp:HiddenField ID="hdnorgaddrid" runat="server" />
                                                    </td>
                                                </tr>
                                                <%-- <------------------------------------------%>
                                                <tr>
                                                    <td colspan="6">
                                                        <table class="w-100p">
                                                            <tr>
                                                                <td class="a-left w-12p">
                                                                    <asp:Label ID="Rs_Name" runat="server" Text="Name" meta:resourcekey="Rs_NameResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddSalutation" runat="server" TabIndex="1" >
                                                                    </asp:DropDownList>
                                                                    <asp:TextBox ID="txtName" runat="server" autocomplete="off" MaxLength="50" CssClass="small v-top"
                                                                        OnBlur="javascript:chec();" TabIndex="2" meta:resourcekey="txtNameResource1"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoGname" runat="server" BehaviorID="AutoCompleteExLstGrpUN"
                                                                        CompletionInterval="10" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                                        Enabled="False" MinimumPrefixLength="1" ServiceMethod="getUserNames" ServicePath="~/WebService.asmx"
                                                                        TargetControlID="txtName">
                                                                    </ajc:AutoCompleteExtender>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtName"
                                                                        EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="True"
                                                                        CompletionListCssClass="wordWhee2 listMain" CompletionListItemCssClass="wordWhee2 itemsMain"
                                                                        CompletionListHighlightedItemCssClass="wordWhee2 itemsSelected4" ServiceMethod="GetAllEmployeeName"
                                                                        OnClientItemSelected="IAmSelected" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                        DelimiterCharacters=";, :" Enabled="True">
                                                                    </ajc:AutoCompleteExtender>
                                                                    &nbsp;<img class="v-middle" alt="" src="../Images/starbutton.png" />
                                                                    <asp:Button ID="btnSearch1" runat="server" CssClass="btn v-top" OnClick="btnSearch1_Click"
                                                                        onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Search"
                                                                        meta:resourcekey="btnSearch1Resource1" />
                                                                    <asp:HiddenField ID="hdnlogID" runat="server" />
                                                                    &nbsp;&nbsp;<asp:CheckBox ID="Chkactivated" Checked="true" Text="Active" runat="server" meta:resourcekey="ChkactivatedResource1" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-right" colspan="5">
                                                        <span id="errmsg_login" class="duplicateMsg">
                                                            <div id="div_error" style="text-align: left">
                                                            </div>
                                                        </span>
                                                    </td>
                                                </tr>
                                                <tr class="w-100p">
                                                    <td id="tdlEmp" class="a-left w-15p" runat="server" style="display: none">
                                                        <asp:Label ID="lblEmpReg" runat="server" Text="Employee Name" meta:resourcekey="lblEmpRegResource1"></asp:Label>
                                                    </td>
                                                    <td id="tdEmp" runat="server" style="display: none">
                                                        <asp:TextBox ID="TxtEmpRegName" CssClass="small" runat="server" TabIndex="5" meta:resourcekey="TxtEmpRegNameResource1"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="TxtEmpRegName"
                                                            EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="True"
                                                            CompletionListCssClass="wordWheel listMain1 box3" CompletionListItemCssClass="wordWheel listMain1"
                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetAllEmployeeName"
                                                            OnClientItemSelected="IAmSelected" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                            DelimiterCharacters="" Enabled="True">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                                    <td class="a-left w-12p" nowrap="nowrap">
                                                        <asp:Label ID="lblUserName" runat="server" Text="Login User Name" meta:resourcekey="lblUserNameResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-19p">
                                                        <asp:TextBox ID="txtUserName" CssClass="small" runat="server" TabIndex="3" meta:resourcekey="txtUserNameResource1"></asp:TextBox>
                                                        <img id="imgUserName" runat="server" class="v-middle" src="../Images/starbutton.png" />
                                                    </td>
                                                    <td class="a-left w-15p">
                                                        <asp:Label ID="Rs_Email" runat="server" Text="Email" meta:resourcekey="Rs_EmailResource1"></asp:Label>
                                                    </td>
                                                    <td class="w-35p">
                                                        <asp:TextBox ID="txtEmail" CssClass="small" runat="server" TabIndex="4" meta:resourcekey="txtEmailResource1"></asp:TextBox>
                                                        &nbsp;&nbsp;<img class="v-middle" alt="" src="../Images/starbutton.png" />&nbsp;&nbsp;
                                                        <asp:CheckBox ID="chkPreferedUser" runat="server" TabIndex="5" Text="preferred User Name"
                                                            meta:resourcekey="chkPreferedUserResource1" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-left">
                                                        <asp:Label ID="Rs_DOB" runat="server" Text="DOB" meta:resourcekey="Rs_DOBResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" CultureAMPMPlaceholder=""
                                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                            Enabled="True" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date" TargetControlID="tDOB">
                                                        </ajc:MaskedEditExtender>
                                                        <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="True" Format="dd/MM/yyyy"
                                                            PopupButtonID="ImgBntCalc" TargetControlID="tDOB">
                                                        </ajc:CalendarExtender>
                                                        <asp:TextBox ID="tDOB" runat="server" CssClass="small" MaxLength="1" Style="text-align: justify"
                                                            TabIndex="6" ValidationGroup="MKE" meta:resourcekey="tDOBResource1"></asp:TextBox>
                                                        <asp:ImageButton ID="ImgBntCalc" runat="server" CausesValidation="False" CssClass="h-16 w-17"
                                                            ImageUrl="~/images/Calendar_scheduleHS.png" meta:resourcekey="ImgBntCalcResource1" />
                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                            ControlToValidate="tDOB" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                                            ErrorMessage="MaskedEditValidator5" InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid"
                                                            TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE" meta:resourcekey="MaskedEditValidator5Resource1"></ajc:MaskedEditValidator>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:Label ID="Rs_Sex" runat="server" Text="Sex" meta:resourcekey="Rs_SexResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlSex" CssClass="ddlsmall" runat="server" TabIndex="7" >
                                                        </asp:DropDownList>
                                                        &nbsp;&nbsp;<img class="v-middle" alt="" src="../Images/starbutton.png" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-left">
                                                        <asp:Label ID="Rs_Relegion" runat="server" Text="Religion" meta:resourcekey="Rs_RelegionResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtRelegion" CssClass="small" runat="server" MaxLength="30" Style="display: none"
                                                            meta:resourcekey="txtRelegionResource1"></asp:TextBox>
                                                        <asp:DropDownList ID="ddlReligion" CssClass="ddlsmall" runat="server" TabIndex="8">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:Label ID="Rs_WeddingDT" runat="server" Text="Wedding Date" meta:resourcekey="Rs_WeddingDTResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" CultureAMPMPlaceholder=""
                                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                            Enabled="True" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date" TargetControlID="weddingDate">
                                                        </ajc:MaskedEditExtender>
                                                        <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Enabled="True" Format="dd/MM/yyyy"
                                                            PopupButtonID="ImgBntCalc1" TargetControlID="weddingDate">
                                                        </ajc:CalendarExtender>
                                                        <asp:TextBox ID="weddingDate" CssClass="small" runat="server" MaxLength="1" Style="text-align: justify"
                                                            TabIndex="9" ValidationGroup="MKE1" meta:resourcekey="weddingDateResource1"></asp:TextBox>
                                                        <asp:ImageButton ID="ImgBntCalc1" runat="server" CausesValidation="False" CssClass="h-16 w-17"
                                                            ImageUrl="~/images/Calendar_scheduleHS.png" meta:resourcekey="ImgBntCalc1Resource1" />
                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                            ControlToValidate="weddingDate" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                                            ErrorMessage="MaskedEditValidator1" InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid"
                                                            TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE1" meta:resourcekey="MaskedEditValidator1Resource1"></ajc:MaskedEditValidator>
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-left style2">
                                                        <asp:Label ID="Rs_Qualification" runat="server" Text="Qualification" meta:resourcekey="Rs_QualificationResource1"></asp:Label>
                                                    </td>
                                                    <td class="style2">
                                                        <asp:TextBox ID="txtQualification" CssClass="small" runat="server" 
                                                            TabIndex="10" meta:resourcekey="txtQualificationResource1"></asp:TextBox>
                                                    </td>
                                                    <td class="a-left style2">
                                                        <asp:Label ID="Rs_MaritialStatus" runat="server" Text="Marital Status" meta:resourcekey="Rs_MaritialStatusResource1"></asp:Label>
                                                    </td>
                                                    <td class="style2">
                                                        <asp:DropDownList ID="ddlMaritialStatus" CssClass="ddlsmall" runat="server" TabIndex="11">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td class="style2">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr id="trConType" runat="server" style="display: none;">
                                                    <td id="Td7" class="a-left" runat="server">
                                                        <asp:Label ID="lblConsultantType" runat="server" Text="Consultant Type" meta:resourcekey="lblConsultantTypeResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td8" runat="server">
                                                        <asp:DropDownList ID="ddlConsultantType" runat="server" CssClass="ddlsmall" TabIndex="13">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td id="Td9" class="a-left" runat="server">
                                                        <asp:Label ID="lblRegNumber" runat="server" Text="Registration Number" meta:resourcekey="lblRegNumberResource1"></asp:Label>
                                                    </td>
                                                    <td id="Td10" runat="server">
                                                        <asp:TextBox ID="txtRegNumber" CssClass="small" runat="server" MaxLength="30" TabIndex="14"
                                                            meta:resourcekey="txtRegNumberResource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="trValid" runat="server">
                                                    <td class="a-left">
                                                        <asp:Label ID="lblTo" runat="server" Text="Valid To" meta:resourcekey="lblToResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:TextBox ID="txtTo" CssClass="small" runat="server" TabIndex="14" meta:resourcekey="txtToResource1"></asp:TextBox>
                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender7" runat="server" CultureAMPMPlaceholder=""
                                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                            Enabled="True" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date" TargetControlID="txtTo" />
                                                        <ajc:CalendarExtender ID="CalendarExtender7" runat="server" Enabled="True" Format="dd/MM/yyyy"
                                                            PopupButtonID="ImgBntCalcTo" TargetControlID="txtTo" />
                                                        <asp:ImageButton ID="ImgBntCalcTo" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            meta:resourcekey="ImgBntCalcToResource1" />
                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator7" runat="server" ControlExtender="MaskedEditExtender5"
                                                            ControlToValidate="txtTo" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                                            ErrorMessage="MaskedEditValidator1" InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid"
                                                            TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE" meta:resourcekey="MaskedEditValidator7Resource1" />
                                                    </td>
                                                   <td class="a-left">
                                                         <asp:Label ID="LblPrinterName" runat="server" Text="Printer Name" meta:resourcekey="LblPrinterNameResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                         <asp:DropDownList ID="ddlPrinterName" CssClass="ddlsmall" runat="server" TabIndex="11">
                                                        </asp:DropDownList>
                                                        
                                                    </td>
                                                </tr>
                                                <tr id="trBlock" runat="server" style="display: none">
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox ID="ChkBlocked" runat="server" onclick="dateshow()" TabIndex="16" Text="IsBlocked"
                                                            meta:resourcekey="ChkBlockedResource1" />
                                                    </td>
                                                    <td id="tdlreason" runat="server" style="display: none">
                                                        <asp:Label ID="lblReason" runat="server" Text="Reason for Blocking" meta:resourcekey="lblReasonResource1"></asp:Label>
                                                    </td>
                                                    <td id="tdtreason" runat="server" style="display: none">
                                                        <asp:DropDownList ID="drpReason" runat="server" CssClass="ddlsmall">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr id="trBlockDate" runat="server" style="display: none">
                                                    <td>
                                                        <asp:Label ID="lblFrom" Text="Blocked From" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:TextBox ID="txtBlockFrom" CssClass="small" runat="server" TabIndex="18" meta:resourcekey="txtBlockFromResource1"></asp:TextBox>
                                                        <asp:ImageButton ID="ImgBntCalcFrom1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" meta:resourcekey="ImgBntCalcFrom1Resource1" /><br />
                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender8" runat="server" TargetControlID="txtBlockFrom"
                                                            Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                            Enabled="True" />
                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator8" runat="server" ControlExtender="MaskedEditExtender5"
                                                            ControlToValidate="txtBlockFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator8" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                        <ajc:CalendarExtender ID="CalendarExtender8" runat="server" TargetControlID="txtBlockFrom"
                                                            Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom1" Enabled="True" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblblockedto" Text="Blocked To" runat="server" meta:resourcekey="lblblockedtoResource1"></asp:Label>
                                                    </td>
                                                    <td class="a-left">
                                                        <asp:TextBox ID="txtBlockTo" CssClass="small" runat="server" onclick="Todate()" TabIndex="19"
                                                            meta:resourcekey="txtBlockToResource1"></asp:TextBox>
                                                        <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                            CausesValidation="False" OnClientClick="Todate()" meta:resourcekey="ImageButton4Resource1" /><br />
                                                        <ajc:MaskedEditExtender ID="MaskedEditExtender9" runat="server" TargetControlID="txtBlockTo"
                                                            Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                                            CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                            CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                            Enabled="True" />
                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator9" runat="server" ControlExtender="MaskedEditExtender5"
                                                            ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                            Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                            ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator9Resource1" />
                                                        <ajc:CalendarExtender ID="CalendarExtender9" runat="server" TargetControlID="txtBlockTo"
                                                            Format="dd/MM/yyyy" PopupButtonID="ImageButton4" Enabled="True" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="5" id="tdControle">
                                                        <asp:Table ID="tblPatientAddress" runat="server" CssClass="w-60p margin10 bg-row pnlBorder"
                                                            meta:resourcekey="tblPatientAddressResource1">
                                                        </asp:Table>
                                                        <%--<uc10:AddressControl ID="ucPAdd" runat="server" AddressType="PERMANENT" StartIndex="20"
                                                                            Title="Permanent Address" />--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Rs_SelectDigitalSignature" runat="server" Text="Select Digital Signature"
                                                            meta:resourcekey="Rs_SelectDigitalSignatureResource1"></asp:Label>
                                                    </td>
                                                    <td colspan="4">
                                                        <asp:FileUpload ID="flUpload" runat="server" onchange="javascript:ValidateUpload(this.id);"
                                                            meta:resourcekey="flUploadResource1" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4">
                                                        <img id="imgView" runat="server" class="v-middle" alt="Digital Signature"></img>
                                                    </td>
                                                </tr>
                                                <tr class="w-100p">
                                                    <td class="a-center btn-center" colspan="5">
                                                        <asp:Button ID="Save" runat="server" CssClass="btn" OnClick="Save_Click" OnClientClick="return validationCheckBox(valVariable);"
                                                            onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" TabIndex="100"
                                                            Text="Save" meta:resourcekey="SaveResource1" />
                                                        &nbsp;<asp:Button ID="btnUpdate" runat="server" CssClass="btn" OnClick="btnUpdate_Click"
                                                            OnClientClick="return validationchkbx();" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                            Text="Update" Visible="False" TabIndex="101" meta:resourcekey="btnUpdateResource1" />
                                                        <asp:Button ID="btnCancel" runat="server" CssClass="btn" OnClick="btnCancel_Click"
                                                            onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Cancel"
                                                            Visible="False" TabIndex="102" meta:resourcekey="btnCancelResource1" />
                                                        &nbsp;&nbsp;
                                                        <asp:LinkButton ID="lnkLocationMap" ForeColor="Red" Font-Bold="True" Font-Underline="True"
                                                            TabIndex="103" Style="display: none;" runat="server" OnClientClick="return checkUserName();"
                                                            OnClick="lnkLocationMap_Click" Text="Associate Locations and Departments" meta:resourcekey="lnkLocationMapResource1"></asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <input type="hidden" id="hdnID" runat="server" />
                <input id="hdnIsBlock" runat="server" type="hidden" />
                <asp:HiddenField ID="hdnReason" runat="server" />
                <asp:HiddenField ID="hdnDynamicConfig" runat="server" />
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="Save" />
                <asp:PostBackTrigger ControlID="btnUpdate" />
            </Triggers>
        </asp:UpdatePanel>
        <table class="w-100p">
            <tr>
                <td class="a-center">
                    <asp:Panel ID="pnlUserMaster" runat="server" ScrollBars="Both" CssClass="modalPopup dataheaderPopup w-100p"
                        Style="display: none; top: 400px; height: 400px" meta:resourcekey="pnlUserMasterResource1">
                        <adh1:Audit_History ID="audit_History" runat="server" />
                        <asp:Button ID="btnPnlClose" Text="Close" runat="server" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                            onmouseout="this.className='btn1'" meta:resourceKey="btnPnlCloseResource1" />
                    </asp:Panel>
                </td>
                <td>
                    <ajc:ModalPopupExtender ID="ModelPopPatientSearch" runat="server" TargetControlID="btnR"
                        PopupControlID="pnlUserMaster" BackgroundCssClass="modalBackground" OkControlID="btnPnlClose"
                        DynamicServicePath="" Enabled="True" />
                    <input type="button" id="btnR" runat="server" style="display: none;" />
                </td>
            </tr>
            <tr>
                <td class="a-center">
                    <asp:Panel ID="pnlLocationMap" runat="server" ScrollBars="Both" CssClass="modalPopup dataheaderPopup w-100p"
                        Style="display: none; top: 400px; height: 400px" meta:resourcekey="pnlLocationMapResource1">
                        <ctrl:LocationUserMap ID="LocationUserMap" runat="server" />
                        <asp:Button ID="btnLocationMap" Style="display: none;" Text="Close" runat="server"
                            CssClass="btn1" onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                            meta:resourceKey="btnLocationMapResource1" />
                    </asp:Panel>
                </td>
                <td>
                    <ajc:ModalPopupExtender ID="ModelPopLocationMap" runat="server" TargetControlID="btnR1"
                        PopupControlID="pnlLocationMap" BackgroundCssClass="modalBackground" DynamicServicePath=""
                        Enabled="True" />
                    <input type="button" id="btnR1" runat="server" style="display: none;" />
                </td>
            </tr>
        </table>
        <br />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <input type="hidden" id="hdnLID" name="lid" runat="server" />
    <input type="hidden" id="hdnRName" name="rName" runat="server" />
    <input type="hidden" id="hdnRID" name="rId" runat="server" />
    <input type="hidden" id="hdnOrguserID" name="orgUID" runat="server" />
    <input type="hidden" id="hdnUserImage" name="UserImage" runat="server" />
    <input type="hidden" id="hdndeletepswd" runat="server" value="0" />
    <input type="hidden" id="hdnRstPswd" runat="server" value="0" />
    <asp:HiddenField ID="hdnInclude" runat="server" Value="0" />
    <asp:HiddenField ID="hdnchkitems" runat="server" />
    <asp:HiddenField ID="hdnchkitems1" runat="server" />
    <asp:HiddenField ID="hdnLoginStatus" runat="server" />
    <asp:HiddenField ID="hdnpwdexpdate" runat="server" />
    <asp:HiddenField ID="hdntranspwdexpdate" runat="server" />
    <asp:HiddenField ID="hdnLoggedinRole" runat="server" />
    <asp:HiddenField ID="hdnEmpID" runat="server" />
    <asp:HiddenField ID="hdnControleID" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />

<script type="text/javascript" language="javascript">
//        var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
//        var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_18") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_18") : "Provide Email";
    function chec() {
        var chkprefuser = document.getElementById('chkPreferedUser');
        if (chkprefuser.checked == false) {
            var txtname = document.getElementById('txtName').value;
            if (txtname != "") {
                var chk = document.getElementById('txtUserName');
                if (chk != null) {
                    var txt = document.getElementById('txtUserName').value;
                    var txtprefer = txtname.split(" ");
                    document.getElementById('txtUserName').value = txtprefer[0];
                }
              //  ConverttoUpperCase('txtName');
            }
        }
        else {
            if (document.getElementById('txtEmail').value.trim() != '') {
                document.getElementById('txtUserName').value = document.getElementById('txtEmail').value;
            }
            else {
                if (document.getElementById('txtEmail').value.trim() != '') {
                    document.getElementById('txtUserName').value = document.getElementById('txtEmail').value;
                }
                else {
                    //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_34");
                    if (UsrAlrtMsg != null) {
                        // alert(userMsg);
                        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                        //return false;
                    }
                    else {
                        //alert('Provide email');
                        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                        //return false;
                    }
                    document.getElementById('txtEmail').focus();
                    return false;
                }
            }
        }
    }        

    function IAmSelected(source, eventArgs) {

        var varGetVal = eventArgs.get_value();
        //alert(" Key : " + eventArgs.get_text() + "  Value :  " + eventArgs.get_value());
        var varGetText = eventArgs.get_text();
        var varGetIndex = varGetText.indexOf('(');
        if (varGetIndex != '-1') {
            $('#txtName').val(varGetText.substring(0, (varGetIndex)));
        }
        var ID;
        //            eventArgs.get_value()[0].PatientID;
        var list = eventArgs.get_value().split('^');
        if (list.length > 0) {
            for (i = 0; i < list.length; i++) {
                if (list[i] != "") {
                    ID = list[0];
                    document.getElementById('hdnEmpID').value = ID;

                }
            }


        }
    }

    function Todate() {
            var UsrAlrtMsg1 = SListForAppMsg.Get("Admin_UserMaster_aspx_13") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_13") : "Select Blocked From Date";

            if (document.getElementById('ChkBlocked').checked == true) {
                if (document.getElementById('txtBlockFrom').value == "") {
                   // var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_36");
                    if (UsrAlrtMsg1 != null) {
                        //alert(userMsg);
                        ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                        //return false;
                    }
                    else {
                        //alert('Select Blocked From Date');
                        ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                        //return false;
                    }
                    document.getElementById('txtBlockFrom').focus();
                    return false;
                }
                return true;
            }
        }

    function dateshow() {
            document.getElementById('drpReason').disabled = false;
            if (document.getElementById('ChkBlocked').checked == true) {

                var Checked = 'BL';
                var options = document.getElementById('hdnReason').value;
                var ddlReason = document.getElementById('drpReason');
                ddlReason.options.length = 0;
                var optn1 = document.createElement("option");
                ddlReason.options.add(optn1);
                optn1.text = "Select";
                optn1.value = "0";

                var list = options.split('^');
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        var res = list[i].split('~');
                        if (Checked == res[2]) {
                            var optn = document.createElement("option");
                            ddlReason.options.add(optn);
                            optn.text = res[0];
                            optn.value = res[1];
                        }
                    }
                }
                if (document.getElementById("hdnIsBlock").value != "Y") {
                    document.getElementById("trBlockDate").style.display = 'table-row';
                    document.getElementById("tdlreason").style.display = 'table-cell';
                    document.getElementById("tdtreason").style.display = 'table-cell';
                    document.getElementById('drpReason').selectedIndex = 0;
                }
                else {
                    document.getElementById("trBlockDate").style.display = 'table-row';
                    document.getElementById("tdlreason").style.display = 'table-cell';
                    document.getElementById("tdtreason").style.display = 'table-cell';
                    document.getElementById('drpReason').selectedIndex = 0;
                    document.getElementById("lblReason").innerHTML = "Reason for Blocking";
                }
            }
            else {


                if (document.getElementById("hdnIsBlock").value != "Y") {
                    document.getElementById("trBlockDate").style.display = 'none';
                    document.getElementById("lblReason").innerHTML = "Reason for Blocking";
                    document.getElementById("tdlreason").style.display = 'none';
                    document.getElementById("tdtreason").style.display = 'none';
                }
                else {
                    var Checked = 'UB';
                    var options = document.getElementById('hdnReason').value;
                    var ddlReason = document.getElementById('drpReason');
                    ddlReason.options.length = 0;
                    var optn1 = document.createElement("option");
                    ddlReason.options.add(optn1);
                    optn1.text = "Select";
                    optn1.value = "0";

                    var list = options.split('^');
                    for (i = 0; i < list.length; i++) {
                        if (list[i] != "") {
                            var res = list[i].split('~');
                            if (Checked == res[2]) {
                                var optn = document.createElement("option");
                                ddlReason.options.add(optn);
                                optn.text = res[0];
                                optn.value = res[1];
                            }
                        }
                    }
                    document.getElementById("trBlockDate").style.display = 'none';
                    document.getElementById("lblReason").innerHTML = "Reason for UnBlocking";
                    document.getElementById("tdlreason").style.display = 'table-cell';
                    document.getElementById("tdtreason").style.display = 'table-cell';
                    document.getElementById('txtBlockFrom').value = '';
                    document.getElementById('txtBlockTo').value = '';
                    document.getElementById('drpReason').selectedIndex = 0;

                }
            }
        }

     function ValidDate(obj1, StartDt, wedFlag, BAflage) {
            var UsrAlrtMsg2 = SListForAppMsg.Get("Admin_UserMaster_aspx_32") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_32") : "Selected Date Must Be Greater than CurrentDate";

            var obj = document.getElementById(obj1);
            var currentTime;
            if (obj.value != '' && obj.value != '01/01/1901' && obj.value != '__/__/____') {
                dobDt = obj.value.split('/');
                var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
                var mMonth = dobDtTime.getMonth() + 1;
                var mDay = dobDtTime.getDate();
                var mYear = dobDtTime.getFullYear();
                if (wedFlag == 0) {
                    currentTime = new Date();
                }
                else {
                    wedDt = document.getElementById(StartDt).value.split('/');
                    var currentTime = new Date(wedDt[2] + '/' + wedDt[1] + '/' + wedDt[0]);
                }
                var month = currentTime.getMonth() + 1;
                var day = currentTime.getDate();
                var year = currentTime.getFullYear();
                if (BAflage == 0) {
                    if (mYear < year) {
                        //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_42");
                        if (UsrAlrtMsg2 != null) {
                            //alert(userMsg);
                            ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                            //return false;
                        }
                        else {
                            //alert('Selected Date Must Be Greater than CurrentDate');
                            ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                            //return false;
                        }
                        obj.value = '__/__/____';
                        obj.focus();
                        return false;
                    }
                    else if (mYear == year && mMonth < month) {
                        //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_42");
                        if (UsrAlrtMsg2 != null) {
                            ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                            //return false;
                        }
                        else {
                            // alert('Selected Date Must Be Greater than CurrentDate');
                            ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                            //return false;
                        }
                        obj.value = '__/__/____';
                        obj.focus();
                        return false;
                    }
                    else if (mYear == year && mMonth == month && mDay < day) {
                        //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_42");
                        if (UsrAlrtMsg2 != null) {
                            //alert(userMsg);
                            ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                            //return false;
                        }
                        else {
                            //alert('Selected Date Must Be Greater than CurrentDate');
                            ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                            //return false;
                        }
                        obj.value = '__/__/____';
                        obj.focus();
                        return false;
                    }
                }
            }
        }

   function BlockValidate(obj1, obj2, obj3, StartDt, wedFlag, BAflage) {
            var UsrAlrtMsg2 = SListForAppMsg.Get("Admin_UserMaster_aspx_33") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_33") : "BlockedTo Must be Greater than or Equalto BlockedFrom Date";
            var UsrAlrtMsg3 = SListForAppMsg.Get("Admin_UserMaster_aspx_34") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_34") : "BlockedTo Must be Less than ValidTill Date";

            var obj = document.getElementById(obj1);
            var obj1 = document.getElementById(obj2);
            var obj2 = document.getElementById(obj3);
            var currentTime;
            if (obj.value != '' && obj.value != '__/__/____') {
                dobDt = obj.value.split('/');
                var dobDtTime = new Date(dobDt[2] + '/' + dobDt[1] + '/' + dobDt[0]);
                var mMonth = dobDt[1];
                var mDay = dobDt[0];
                var mYear = dobDt[2];
            }
            if (obj1.value != '' && obj1.value != '__/__/____') {
                dobDt1 = obj1.value.split('/');
                var dobDtTime = new Date(dobDt1[2] + '/' + dobDt1[1] + '/' + dobDt1[0]);
                var month = dobDt1[1];
                var day = dobDt1[0];
                var year = dobDt1[2];
            }
            if (mYear > year) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_43");
                if (UsrAlrtMsg2 != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                    //return false;
                }
                else {
                    //alert('BlockedTo Must be Greater than or Equalto BlockedFrom Date');
                    ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                    // return false;
                }


                obj1.value = '__/__/____';
                obj1.focus();
                return false;
            }
            else if (mYear == year && mMonth > month) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_43");
                if (UsrAlrtMsg2 != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                    //return false;
                }
                else {
                    //alert('BlockedTo Must be Greater than or Equalto BlockedFrom Date');
                    ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                    // return false;
                }
                obj1.value = '__/__/____';
                obj1.focus();
                return false;
            }
            else if (mYear == year && mMonth == month && mDay > day) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_43");
                if (UsrAlrtMsg2 != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                    //return false;
                }
                else {
                    // alert('BlockedTo Must be Greater than or Equalto BlockedFrom Date');
                    ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                    // return false;
                }
                obj1.value = '__/__/____';
                obj1.focus();
                return false;
            }

            if (obj2.value != '' && obj2.value != '01/01/1901' && obj2.value != '__/__/____') {
                dobDt2 = obj2.value.split('/');
                var dobDtTime = new Date(dobDt2[2] + '/' + dobDt2[1] + '/' + dobDt2[0]);
                var Vmonth = dobDt2[1];
                var Vday = dobDt2[0];
                var Vyear = dobDt2[2];
            }

            if (year > Vyear) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_44");
                if (UsrAlrtMsg3 != null) {
                    //  alert(userMsg);
                    ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                    //return false;
                }
                else {
                    //alert('BlockedTo Must be Less than ValidTill Date');
                    ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                    //return false;
                }
                obj1.value = '__/__/____';
                obj1.focus();
                return false;
            }
            else if (year == Vyear && month > Vmonth) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_44");
                if (UsrAlrtMsg3 != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                    //return false;
                }
                else {
                    //alert('BlockedTo Must be Less than ValidTill Date');
                    ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                    //return false;
                }
                obj1.value = '__/__/____';
                obj1.focus();
                return false;
            }
            else if (year == Vyear && month == Vmonth && day > Vday) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_44");
                if (UsrAlrtMsg3 != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                    //return false;
                }
                else {
                    //alert('BlockedTo Must be Less than ValidTill Date');
                    ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                    //return false;
                }
                obj1.value = '__/__/____';
                obj1.focus();
                return false;
            }

            return true;

        }
    //}
    </script>

    

</form>
 <script language="javascript" type="text/javascript">
     var ClientSelect = { Select: '<%=Resources.Admin_AppMsg.Admin_UserMaster_aspx_35%>' };
    </script>
    <script src="../Scripts/actbcommon.js" type="text/javascript"></script>
<script src="../Scripts/actb.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">


    var valVariable = new Array("chkUserType_0", "chkUserType_1", "chkUserType_2", "chkUserType_3", "chkUserType_4", "chkUserType_5", "chkUserType_6", "chkUserType_7", "chkUserType_8", "chkUserType_9", "chkUserType_10", "chkUserType_11", "chkUserType_12", "chkUserType_13", "chkUserType_14", "chkUserType_15");
    var CtrlVariable = new Array("ucPAdd_txtAddress2", "ucPAdd_txtCity");
    var arg;
        $(document).ready(function() {

            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
        });

    //        function hideSpeciality() {

    //            var chkbox = document.getElementById("chkUserType");
    //            var inputarray = chkbox.getElementsByTagName('input');
    //            var lblarray = chkbox.getElementsByTagName('label');
    //            document.getElementById('Speciality').style.display = 'none';
    //            document.getElementById('Location').style.display = 'none';
    //            document.getElementById('trConType').style.display = 'none';

    //            for (var i = 0; i < lblarray.length; i++) {
    //                if (inputarray[i].checked == true) {
    //                    var pRole = lblarray[i].innerHTML.trim();

    //                    switch (pRole) {
    //                        case "Physician":
    //                            document.getElementById('Speciality').style.display = 'block';
    //                            document.getElementById('hdnSpciality').style.display = 'block';
    //                            document.getElementById('trConType').style.display = 'block';
    //                            break;
    //                        case "Inventory":
    //                            var obj = document.getElementById('Location').innerText;
    //                            document.getElementById('Location').style.display = 'block';
    //                            document.getElementById('hdnLocation').style.display = 'block';
    //                            if (obj == "Select Location  Delete Location ")
    //                                alert('Locations list is not accesible. The available locations must be entered in the inventory master page');
    //                            break;
    //                        default:
    //                            break;
    //                    }
    //                }
    //            }
    //        }

    //        function ShowEditModal(val, obj) {
    //            var ExpanseID = val;
    //            $find('EditModalPopup').show();

    //        }

    function ShowAlertMsg(key) {

            var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_01") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_01") : "preferred User Name Already Exist";

            // var userMsg = SListForApplicationMessages.Get(key);
            if (UsrAlrtMsg != null) {
                // alert(userMsg);
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
            return false;
        }
        else {
                //alert('Prefered User Name Already Exist');
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
            return false;
        }


        return true;
    }

    function hideSpeciality() {
        ////debugger;

        document.getElementById('Speciality').style.display = 'none';
        document.getElementById('Location').style.display = 'none';
        document.getElementById('trConType').style.display = 'none';


        var chkbox = document.getElementById("chkUserType");
        var inputarray = chkbox.getElementsByTagName('input');
        var lblarray = chkbox.getElementsByTagName('label');

        var chklistitems = document.getElementById('hdnchkitems1').value;
        var list = chklistitems.split('#');
        var NewLocList = '';
        for (var i = 0; i < lblarray.length; i++) {
            if (inputarray[i].checked == true) {
                var pRole = lblarray[i].innerHTML.trim();
                for (var count = 0; count < list.length; count++) {
                    var LocList = list[count].split('$');
                    if (LocList[1] == pRole) {
                        pRole = LocList[0];
                        if (pRole == "Project Stockist" || pRole == "PI" || pRole == "Project Manager") {
                            pRole = "Inventory";
                        }
                        switch (pRole) {
                            case "Physician":
                                document.getElementById('Speciality').style.display = 'block';
                                document.getElementById('hdnSpciality').style.display = 'block';
                                document.getElementById('trConType').style.display = 'table-row';
                                break;
                            case "Inventory":
                                var obj = document.getElementById('Location').innerText;
                                document.getElementById('Location').style.display = 'block';
                                document.getElementById('hdnLocation').style.display = 'block';

                                if (obj == " Select Location  Delete Location ") {
                                    //alert('Locations list is not accesible.Please Add Locations');

                                }

                                break;
                            default:
                                break;
                        }
                        break;
                    }
                }
            }
        }
    }

    function setSpItem(e, ctl) {
        // //debugger;
        var key = window.event ? e.keyCode : e.which;
        if (key == 13) {
            onClickSpcial(ctl.id);
        }
    }

    function onClickSpcial(id) {
        var type;
        var AddStatus = 0;
        var obj = document.getElementById(id);
        var i = obj.getElementsByTagName('OPTION');
        var HidValue = document.getElementById('hdnSpciality').value;
        //                alert(HidValue);
        var list = HidValue.split('^');
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_02") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_02") : "Speciality already added";
        if (document.getElementById('hdnSpciality').value != "") {
            for (var count = 0; count < list.length; count++) {
                var SpecialList = list[count].split('~');
                if (SpecialList[0] != '') {
                    if (obj.selectedIndex >= 0) {
                        if (SpecialList[0] == obj.options[obj.selectedIndex].value) {
                            AddStatus = 1;
                        }
                    }
                }
            }
        }
        else {

                document.getElementById('tblSpeciality').style.display = 'table';
                var row = document.getElementById('tblSpeciality').insertRow(1);
                row.id = obj.options[obj.selectedIndex].value;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSpecial(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                document.getElementById('hdnSpciality').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "^";
                AddStatus = 2;
            }
            if (AddStatus == 0) {
                document.getElementById('tblSpeciality').style.display = 'table';
                var row = document.getElementById('tblSpeciality').insertRow(1);
                row.id = obj.options[obj.selectedIndex].value;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSpecial(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                document.getElementById('hdnSpciality').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "^";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
            }
            else if (AddStatus == 1) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_2");
                if (UsrAlrtMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert('Speciality already added');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
            }
        }

        function testSpe() {
            var HidLoadValue = document.getElementById('hdnSpciality').value;
            var list = HidLoadValue.split('^');
            if (document.getElementById('hdnSpciality').value != "") {
                for (var count = 0; count < list.length; count++) {
                    if (list[count] != "") {
                        var SpList = list[count].split('~');
                        document.getElementById('tblSpeciality').style.display = 'table';
                        var row = document.getElementById('tblSpeciality').insertRow(1);
                        row.id = SpList[0];
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickSpecial(" + SpList[0] + ");' src='../Images/Delete.jpg' />";
                        cell1.width = "5%";
                        cell2.innerHTML = SpList[1];
                    }
                }
            }
            return false;
        }



    function ImgOnclickSpecial(ImgID) {
        document.getElementById(ImgID).style.display = "none";
        var HidValue = document.getElementById('hdnSpciality').value;
        var list = HidValue.split('^');
        var NewSpecialList = '';
        if (document.getElementById('hdnSpciality').value != "") {
            for (var count = 0; count < list.length; count++) {
                var SpecialList = list[count].split('~');
                if (SpecialList[0] != '') {
                    if (SpecialList[0] != ImgID) {

                        NewSpecialList += list[count] + '^';
                    }
                }
            }
            document.getElementById('hdnSpciality').value = NewSpecialList;
        }
    }

    function setLocItem(e, ctl) {

        var key = window.event ? e.keyCode : e.which;
        if (key == 13) {
            onClickLoc(ctl.id);
        }
    }

    function onClickLoc(id) {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
        var type;
        var AddStatus = 0;
        var obj = document.getElementById(id);
        if (obj.selectedIndex == "-1") {
            return;
        }

        var i = obj.getElementsByTagName('OPTION');
        var HidValue = document.getElementById('hdnLocation').value;
        var list = HidValue.split('^');
        if (document.getElementById('hdnLocation').value != "") {
            for (var count = 0; count < list.length; count++) {
                var LocationList = list[count].split('~');
                if (LocationList[0] != '') {
                    if (obj.selectedIndex >= 0) {
                        if (LocationList[0] == obj.options[obj.selectedIndex].value) {
                            AddStatus = 1;
                        }
                    }
                }
            }
        }
        else {

            var x = document.getElementById('hdnLocationList').value.split('^');
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    var val = x[i].split('~');
                    if (x[i].split('~')[1] == obj.options[obj.selectedIndex].value) {
                        document.getElementById('hdnOrgAddressID').value = val[3];
                    }
                }

                }
                document.getElementById('tblInv').style.display = 'table';
                var row = document.getElementById('tblInv').insertRow(1);
                row.id = "loc" + obj.options[obj.selectedIndex].value;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickLoc(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";
                cell2.innerHTML = obj.options[obj.selectedIndex].text;
                document.getElementById('hdnLocation').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "~" + document.getElementById('hdnOrgAddressID').value + "^";
                AddStatus = 2;
            }
            if (AddStatus == 0) {
                var x = document.getElementById('hdnLocationList').value.split('^');
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        var val = x[i].split('~');
                        if (x[i].split('~')[1] == obj.options[obj.selectedIndex].value) {
                            document.getElementById('hdnOrgAddressID').value = val[3];
                        }
                    }

            }

                document.getElementById('tblInv').style.display = 'table';
                var row = document.getElementById('tblInv').insertRow(1);
                row.id = "loc" + obj.options[obj.selectedIndex].value;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickLoc(" + obj.options[obj.selectedIndex].value + ");' src='../Images/Delete.jpg' />";
                cell1.width = "5%";

            document.getElementById('hdnLocation').value += obj.options[obj.selectedIndex].value + "~" + obj.options[obj.selectedIndex].text + "~" + document.getElementById('hdnOrgAddressID').value + "^";
            cell2.innerHTML = obj.options[obj.selectedIndex].text;
        }

        else if (AddStatus == 1) {
                var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_02") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_02") : "Location already added";
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_3");
                if (UsrAlrtMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                return false;
            }
            else {
                    // alert('Location already added');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                return false;
            }
        }
    }

        function testLoc() {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var HidLoadValue = document.getElementById('hdnLocation').value;
            var list = HidLoadValue.split('^');
            if (document.getElementById('hdnLocation').value != "") {
                for (var count = 0; count < list.length; count++) {
                    if (list[count] != "") {
                        var LocList = list[count].split('~');
                        document.getElementById('tblInv').style.display = 'table';
                        var row = document.getElementById('tblInv').insertRow(1);
                        row.id = "loc" + LocList[0];
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickLoc(" + LocList[0] + ");' src='../Images/Delete.jpg' />";
                        cell1.width = "5%";
                        cell2.innerHTML = LocList[1];
                    }
                }
            }
            return false;
        }

    function ImgOnclickLoc(ImgID) {
        document.getElementById("loc" + ImgID).style.display = "none";
        var HidValue = document.getElementById('hdnLocation').value;
        var list = HidValue.split('^');
        var NewLocList = '';
        if (document.getElementById('hdnLocation').value != "") {
            for (var count = 0; count < list.length; count++) {
                var LocList = list[count].split('~');
                if (LocList[0] != '') {
                    if (LocList[0] != ImgID) {

                        NewLocList += list[count] + '^';
                    }
                }
            }
            document.getElementById('hdnLocation').value = NewLocList;

        }
    }

    function validationchkbx() {
        var flag = 0;
        var flag1;
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_04") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_04") : "Select a user type";
            var checkboxCollection = document.getElementById('chkUserType').getElementsByTagName('input');

        for (var i = 0; i < checkboxCollection.length; i++) {
            if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                if (checkboxCollection[i].checked == true) {
                    flag = 1;
                }
            }
        }

        if (flag == 0) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_15");
                if (UsrAlrtMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                return false;
            }
            else {
                    //alert('Select a user type');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                return false;
            }


            //document.getElementById('chkUserType_0').focus();
            //return false;
        }

        var valsplhdn = document.getElementById('hdnSpciality').value
        var vallochdn = document.getElementById('hdnLocation').value

        var chkbox = document.getElementById("chkUserType");
        var inputarray = chkbox.getElementsByTagName('input');
        var lblarray = chkbox.getElementsByTagName('label');

        var chklistitems = document.getElementById('hdnchkitems1').value;
        var list = chklistitems.split('#');
        var NewLocList = '';
        for (var i = 0; i < lblarray.length; i++) {
            if (inputarray[i].checked == true) {
                var pRole = lblarray[i].innerHTML.trim();
                for (var count = 0; count < list.length; count++) {
                    var LocList = list[count].split('$');
                    if (LocList[1] == pRole) {
                        pRole = LocList[0];
                        switch (pRole) {
                            case "Physician":
                                if (valsplhdn == "") {
                                        var UsrAlrtMsg1 = SListForAppMsg.Get("Admin_UserMaster_aspx_05") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_05") : "Select a speciality";
                                        //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_5");
                                        if (UsrAlrtMsg1 != null) {
                                            //alert(userMsg);
                                            ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                                        return false;
                                    }
                                    else {
                                            //alert('Select a speciality');
                                            ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                                            return false;
                                    }
                                    //return false;
                                }
                                break;
                            case "Inventory":
                                if (vallochdn == "") {
                                        //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_17");
                                        var UsrAlrtMsg2 = SListForAppMsg.Get("Admin_UserMaster_aspx_06") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_06") : "Select a location";
                                        if (UsrAlrtMsg2 != null) {
                                            //alert(userMsg);
                                            ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                                        return false;
                                    }
                                    else {
                                            //alert('Select a location');
                                            ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                                            return false;
                                        }
                                        //return false;
                                    }
                                    break;
                                default:
                                    break;
                            }
                            break;
                        }
                    }
                }
            }
            if (document.getElementById('txtName').value == '') {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_8");
                var UsrAlrtMsg3 = SListForAppMsg.Get("Admin_UserMaster_aspx_07") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_07") : "Provide the name";
                if (UsrAlrtMsg3 != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                //return false;
            }
            else {
                    //alert('Provide the name');
                    ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                    //return false;
                }
                document.getElementById('txtName').focus();
                return false;
            }

        if (document.getElementById('ucPAdd_txtAddress2').value == '') {
            var UsrAlrtMsg4 = SListForAppMsg.Get("Admin_UserMaster_aspx_08") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_08") : "Provide street/road name";

            if (UsrAlrtMsg4 != null) {
                //alert(userMsg);
                ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
                //return false;
            }
            else {
                //alert('Provide street/road name');
                ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
                //return false;
            }
            document.getElementById('ucPAdd_txtAddress2').focus();
            return false;
        }
        if ($('#ucPAdd_txtCity').length > 0) {
            if (document.getElementById('ucPAdd_txtCity').value == '') {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_21");
                var UsrAlrtMsg5 = SListForAppMsg.Get("Admin_UserMaster_aspx_09") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_09") : "Provide the city";

                if (UsrAlrtMsg5 != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
                    // return false;
                }
                else {
                    ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
                    //alert('Provide the city');
                    //return false;
                }
                document.getElementById('ucPAdd_txtCity').focus();
                return false;
            }
        }
        if (document.getElementById('txtEmail').value != "") {
            flag1 = checkMailId();
            if (flag1 == false) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_22");
                var UsrAlrtMsg5 = SListForAppMsg.Get("Admin_UserMaster_aspx_10") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_10") : "Provide a valid e-mail ID";

                if (UsrAlrtMsg5 != null) {
                    // alert(userMsg);
                  ////  ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
                    // return false;
                }
                else {
                    //alert('Provide a valid e-mail ID');
                  ////  ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
                    // return false;
                }
                document.getElementById('txtEmail').focus();
                return false;

            }
        }
       // if (document.getElementById('ucPAdd_txtMobile').value == '' && document.getElementById('ucPAdd_txtLandLine').value == '') {
        if (document.getElementById('ucPAdd_txtMobile').value == '') {
            //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_14");
            var UsrAlrtMsg6 = SListForAppMsg.Get("UserMaster_Scripts_UserList_js_32") != null ? SListForAppMsg.Get("UserMaster_Scripts_UserList_js_32") : "Provide Mobile Number";

            if (UsrAlrtMsg6 != null) {
                // alert(userMsg);
                ValidationWindow(UsrAlrtMsg6, AlrtWinHdr);
                //return false;
            }
            else {
                //alert('Provide at least one contact number');
                ValidationWindow(UsrAlrtMsg6, AlrtWinHdr);
                //return false;
            }
            document.getElementById('ucPAdd_txtMobile').focus();
            return false;
        }
        if (document.getElementById('ucPAdd_txtMobile').value != '' && document.getElementById('ucPAdd_txtMobile').value.length < 10) {
            // alert('Enter 10 digit Mobile No.');

            var userMsg = SListForAppMsg.Get("UserMaster_Scripts_UserList_js_15") != null ? SListForAppMsg.Get("UserMaster_Scripts_UserList_js_15") : "Provide Valid Mobile Number";
            ValidationWindow(userMsg, AlrtWinHdr);
            return false;
        }
        if (document.getElementById('ChkBlocked').checked == true) {
            var r;
            //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_45");
            var userMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_12") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_12") : "Are You Sure To Block This User?";

            if (userMsg != null) {
                r = confirm(userMsg);
                //return false;
            }
            else {
                r = confirm(userMsg);
                // return false;
            }
            //  var  r = confirm("Are You Sure To Block This User?");
            if (r == true) {

            }
            else {
                document.getElementById('ChkBlocked').checked = false;
                document.getElementById('txtBlockFrom').value = '';
                document.getElementById('txtBlockTo').value = '';
                document.getElementById('drpReason').selectedIndex = 0;
                return false;
            }
            if (document.getElementById('txtBlockFrom').value == "") {
                // var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_36");
                var userMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_13") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_13") : "Select Blocked From Date";

                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    //return false;
                }
                else {
                    //alert('Select Blocked From Date');
                    ValidationWindow(userMsg, AlrtWinHdr);
                    // return false;
                }
                document.getElementById('txtBlockFrom').focus();
                return false;
            }


            if (document.getElementById('drpReason').options[document.getElementById('drpReason').selectedIndex].innerHTML == 'Select') {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_37");
                var userMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_14") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_14") : "Select Reason for Block";

                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    //return false;
                }
                else {
                    //alert('Select Reason for Block');
                    ValidationWindow(userMsg, AlrtWinHdr);
                    // return false;
                }
                document.getElementById('drpReason').focus();
                return false;
            }
        }
        else {
            if (document.getElementById('hdnIsBlock').value == "Y") {
                if (document.getElementById('drpReason').options[document.getElementById('drpReason').selectedIndex].innerHTML == 'Select') {
                    //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_38");
                    var userMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_15") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_15") : "Select Reason for UnBlock";
                    if (userMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg, AlrtWinHdr);
                        // return false;
                    }
                    else {
                        // alert('Select Reason for UnBlock');
                        ValidationWindow(userMsg, AlrtWinHdr);
                        //return false;
                    }
                    document.getElementById('drpReason').focus();
                    return false;
                }
            }


        }

        if (document.getElementById('txtEmail').value.trim() == '') {
            //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_18");
            var userMsg = SListForAppMsg.Get("UserMaster_Scripts_UserList_js_31") != null ? SListForAppMsg.Get("UserMaster_Scripts_UserList_js_31") : "Please enter the email address";
            ValidationWindow(userMsg, AlrtWinHdr);
            return false;
        }

        return true;
    }
    


    function validationCheckBox(valVariable) {
        var flag = 0;
        var flag1;
        var checkboxCollection = document.getElementById('chkUserType').getElementsByTagName('input');
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
        for (var i = 0; i < checkboxCollection.length; i++) {
            if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                if (checkboxCollection[i].checked == true) {
                    flag = 1;
                }
            }
        }

        if (flag == 0) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_4");
                var userMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_16") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_16") : "Select a user type";
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    // return false;
                }
                else {
                    //alert('Select a user type');
                    ValidationWindow(userMsg, AlrtWinHdr);
                    //return false;
                }
                document.getElementById('chkUserType_0').focus();
                return false;
            }

        var valsplhdn = document.getElementById('hdnSpciality').value
        var vallochdn = document.getElementById('hdnLocation').value

        var chkbox = document.getElementById("chkUserType");
        var inputarray = chkbox.getElementsByTagName('input');
        var lblarray = chkbox.getElementsByTagName('label');

        var chklistitems = document.getElementById('hdnchkitems1').value;
        var list = chklistitems.split('#');
        var NewLocList = '';
        for (var i = 0; i < lblarray.length; i++) {
            if (inputarray[i].checked == true) {
                var pRole = lblarray[i].innerHTML.trim();
                for (var count = 0; count < list.length; count++) {
                    var LocList = list[count].split('$');
                    if (LocList[1] == pRole) {
                        pRole = LocList[0];
                        switch (pRole) {
                            case "Physician":
                                if (valsplhdn == "") {
                                        var userMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_05") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_05") : "Select a speciality";

                                        //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_5");
                                        if (userMsg != null) {
                                            // alert(userMsg);
                                            ValidationWindow(userMsg, AlrtWinHdr);
                                            return false;
                                        }
                                        else {
                                            //alert('Select a speciality');
                                            ValidationWindow(userMsg, AlrtWinHdr);
                                            return false;
                                    }
                                }
                                break;
                            case "Inventory":
                                if (vallochdn == "") {
                                        var userMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_06") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_06") : "Select a location";

                                        //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_6");
                                        if (userMsg != null) {
                                            // alert(userMsg);
                                            ValidationWindow(userMsg, AlrtWinHdr);
                                            return false;
                                        }
                                        else {
                                            // alert('Select a location');
                                            ValidationWindow(userMsg, AlrtWinHdr);
                                            return false;
                                        }
                                        //return false;
                                    }
                                    break;
                                default:
                                    break;
                            }
                            break;
                        }
                    }
                }
            }

            if (document.getElementById('txtUserName').value.trim() == '') {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_18");
                var userMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_17") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_17") : "Provide preferred user name";

                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    //return false;
                }
                else {
                    //alert('Provide preferred user name');
                    ValidationWindow(userMsg, AlrtWinHdr);
                    //return false;
                }
                document.getElementById('txtUserName').focus();
                return false;
            }
            var e = document.getElementById("ddlSex");
            var strUser = e.options[e.selectedIndex].text;
            if (strUser == "Select") {
               // alert('Select Sex');
                var userMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_45") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_45") : "Please select Sex";
                ValidationWindow(userMsg, AlrtWinHdr);
                return false;
            }

            if (document.getElementById('chkPreferedUser').checked == true) {
                if (document.getElementById('txtEmail').value.trim() == '') {
                    var userMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_18") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_18") : "Provide Email";

                    //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_34");
                    if (userMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg, AlrtWinHdr);
                        // return false;
                    }
                    else {
                        //alert('Provide Email');
                        ValidationWindow(userMsg, AlrtWinHdr);
                        //return false;
                    }


                    document.getElementById('txtEmail').focus();
                    return false;
                }
            }



            if (document.getElementById('txtName').value == '') {

                var userMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_07") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_07") : "Provide the name";
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_8");
                if (userMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(userMsg, AlrtWinHdr);
                    // return false;
                }
                else {
                    //alert('Provide the name');
                    ValidationWindow(userMsg, AlrtWinHdr);
                    //return false;
                }
                document.getElementById('txtName').focus();
                return false;
            }
            var AddressConfig = document.getElementById('hdnDynamicConfig').value;
            if (AddressConfig != 'Y') {
                if (document.getElementById('ucPAdd_txtAddress2').value == '') {
                    //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_11");
                    var userMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_20") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_20") : "Provide street/road name";
                    if (userMsg != null) {
                        // alert(userMsg);
                        ValidationWindow(userMsg, AlrtWinHdr);
                        //return false;
                    }
                    else {
                        // alert('Provide street/road name');
                        ValidationWindow(userMsg, AlrtWinHdr);
                        // return false;
                    }
                    document.getElementById('ucPAdd_txtAddress2').focus();
                    return false;
                }
                if (document.getElementById('ucPAdd_txtCity').value == '') {
                    //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_12");
                    var userMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_09") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_09") : "Provide the City";
                    if (userMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg, AlrtWinHdr);
                        //return false;
                    }
                    else {
                        //alert('Provide the city');
                        ValidationWindow(userMsg, AlrtWinHdr);
                        //return false;
                    }


                    document.getElementById('ucPAdd_txtCity').focus();
                    return false;
                }

//                if (document.getElementById('ucPAdd_txtMobile').value == '' && document.getElementById('ucPAdd_txtLandLine').value == '') {
                if (document.getElementById('ucPAdd_txtMobile').value == '') {
                    //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_23");
                    //  var userMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_21") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_21") : "Provide any one contact number";
                    var userMsg = SListForAppMsg.Get("UserMaster_Scripts_UserList_js_32") != null ? SListForAppMsg.Get("UserMaster_Scripts_UserList_js_32") : "Provide Mobile Number.";
                    if (userMsg != null) {
                        // alert(userMsg);
                        ValidationWindow(userMsg, AlrtWinHdr);
                        //return false;
                    }
                    else {
                        //alert('Provide any one contact number');
                        ValidationWindow(userMsg, AlrtWinHdr);
                        //return false;
                    }
                    document.getElementById('ucPAdd_txtMobile').focus();
                    return false;
                }
                if (document.getElementById('ucPAdd_txtMobile').value != '' && document.getElementById('ucPAdd_txtMobile').value.length < 10) {
                    // alert('Enter 10 digit Mobile No.');

                    var userMsg = SListForAppMsg.Get("UserMaster_Scripts_UserList_js_15") != null ? SListForAppMsg.Get("UserMaster_Scripts_UserList_js_15") : "Provide Valid Mobile Number";
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }
            }
            if (document.getElementById('txtEmail').value != "") {
                flag1 = checkMailId();
                if (flag1 == false) {
                    var userMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_10") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_10") : "Provide a valid e-mail ID";

                    // var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_22");
                    if (userMsg != null) {
                        //alert(userMsg);
                     ////   ValidationWindow(userMsg, AlrtWinHdr);
                        //return false;
                    }
                    else {
                        // alert('Provide a valid e-mail ID');
                      ////  ValidationWindow(userMsg, AlrtWinHdr);
                        //return false;
                    }
                    document.getElementById('txtEmail').focus();
                    return false;
                }
            }
            //Dynamic Controle

            if (AddressConfig == 'Y') {
                var Address = $('[id$="txtAddress2"]').val();
                if (Address == '') {
                    //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_39");
                    var userMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_22") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_22") : "Provide address";

                    if (userMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg, AlrtWinHdr);
                        // return false;
                    }
                    else {
                        //alert('Provide address ');
                        ValidationWindow(userMsg, AlrtWinHdr);
                        // return false;
                    }


                    $('[id$="txtAddress2"]').focus();
                    return false;
                }
                var MobileNo = $('[id$="txtMobile"]').val();
                var LandNo = $('[id$="txtLandLine"]').val();
                if (MobileNo == '' && LandNo == '') {
                    //var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
                    var UserDate = SListForAppMsg.Get("Admin_UserMaster_aspx_19") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_19") : "Provide Mobile Number or Landline Number";

                    //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_40");
                    if (UserDate != null) {
                        //alert(userMsg);
                        ValidationWindow(UserDate, AlrtWinHdr);
                        // return false;
                    }
                    else {
                        //alert('Provide Mobile Number or Landline Number');
                        ValidationWindow(UserDate, AlrtWinHdr);
                        // return false;
                    }
                    $('[id$="txtMobile"]').focus();
                    return false;
                }

            }
             if (document.getElementById('txtEmail').value.trim() == '') {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_18");
                 var userMsg = SListForAppMsg.Get("UserMaster_Scripts_UserList_js_31") != null ? SListForAppMsg.Get("UserMaster_Scripts_UserList_js_31") : "Please enter the email address";
                    ValidationWindow(userMsg, AlrtWinHdr);
                    return false;
                }

            return true;
        }

        function showModalPopupViaClient(control, id) {
            var modalPopupBehavior = $find('ModalPopupExtender');
            modalPopupBehavior.show();
        }
        function close(control, id) {
            var close = $find('ModalPopupExtender');
            close.hide();
        }

        function CheckName() {
            var hdn = document.getElementById('hdnID');
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            if (document.getElementById('txtName1').value == '') {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_24");
                var UserDate = SListForAppMsg.Get("Admin_UserMaster_aspx_23") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_23") : "Provide name to search";

                if (UserDate != null) {
                    //alert(userMsg);
                    ValidationWindow(UserDate, AlrtWinHdr);
                    //return false;
                }
                else {
                    //alert('Provide name to search');
                    ValidationWindow(UserDate, AlrtWinHdr);
                    //return false;
                }
                document.getElementById('txtName1').focus();
                return false;
            }
            hdn.value = "";
            return true;
        }


    function AddEmailAsLogIn() {
        var chkprefuser = document.getElementById('chkPreferedUser');
        if (chkprefuser.checked == true) {
            if (document.getElementById('txtEmail').value.trim() != '') {
                document.getElementById('txtUserName').value = document.getElementById('txtEmail').value;
            }
        }
        else {
            //                var txtname = document.getElementById('txtName').value;
            //                if (txtname != "") {
            //                    var chk = document.getElementById('txtUserName');
            //                    if (chk != null) {
            //                        var txt = document.getElementById('txtUserName').value;
            //                        var txtprefer = txtname.split(" ");
            //                        document.getElementById('txtUserName').value = txtprefer[0];
            //                    }
            //                }
        }
    }

    var xmlhttp;
    function ReloadData(url) {
        xmlhttp = null;
        if (window.XMLHttpRequest) {
            xmlhttp = new XMLHttpRequest();
        }
        else if (window.ActiveXObject) {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        if (xmlhttp != null) {
            xmlhttp.onreadystatechange = state_Change;
            xmlhttp.open("GET", url, true);
            document.getElementById('div_error').innerHTML = "<img src='../Images/working.gif' width='10' height='10' align='absmiddle' vspace='3' border=0>&nbsp; Checking Physician Already in use..";
            xmlhttp.send(null);
        }
        else {
            document.getElementById('div_error').innerHTML = "Your browser does not support XMLHTTP.";
        }
    }

    function state_Change() {
        if (xmlhttp.readyState == 4) {
            if (xmlhttp.status == 200) {
                if (arg == 1) {
                    //alert(xmlhttp.reponseText);
                    if (xmlhttp.responseText == "true")
                        document.getElementById('div_error').innerHTML = "Selected Dr Name already in use. Please Verify...";
                    else
                        document.getElementById('div_error').innerHTML = "";
                }
            }
            else {
                document.getElementById('div_error').innerHTML = "Problem retrieving User Availability";
            }
        }
    }

    function SelectUserName(id, lid, rName) {

        chosen = "";
        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        document.getElementById(id).checked = true;
        document.getElementById("hdnLID").value = lid;
        document.getElementById("hdnRName").value = rName;
        //document.getElementById("hdnRID").value = rId;
        //document.getElementById("hdnOrguserID").value = orgUID;
        //            alert('Login ID : ' + document.getElementById("hdnLID").value);
        //            alert('R Id : ' + document.getElementById("hdnRID").value);
        //            alert('R Name : ' + document.getElementById("hdnRName").value);
        //            alert('U Id : ' + document.getElementById("hdnOrguserID").value);
    }


    //        function pChekUserName() {
    //            var i;


    //            i = confirm('Are you sure You wanna delete this user?');
    //            alert(i);
    //            if (i == true) {                
    //                    return ;
    //                }
    //                else {
    //                    return false;
    //                }
    //            
    //                       
    //            //return true;
    //        }
    function checkMailId() {
        var emailID = document.getElementById('txtEmail')
        if ((emailID.value == null) || (emailID.value.trim() != "")) {
            if (echeck(emailID.value) == false) {
                emailID.value = "";
                emailID.focus();
                return false;
            }
        }
        return true
    }
        function echeck(str) {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var at = "@"
            var dot = "."
            var lat = str.indexOf(at)
            var lstr = str.length
            var ldot = str.indexOf(dot)
            if (str.indexOf(at) == -1) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_25");
                var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_24") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_24") : "Invalid e-mail id";
                if (UsrAlrtMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);

                    return false;
                }
                else {
                    //alert('Invalid e-mail id');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                //return false;
            }

            if (str.indexOf(at) == -1 || str.indexOf(at) == 0 || str.indexOf(at) == lstr) {
                var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_24") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_24") : "Invalid e-mail id";

                if (UsrAlrtMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert('Invalid e-mail id');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
            }

            if (str.indexOf(dot) == -1 || str.indexOf(dot) == 0 || str.indexOf(dot) == lstr) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_25");
                var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_24") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_24") : "Invalid e-mail id";

                if (UsrAlrtMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert('Invalid e-mail id');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
            }

           /* if (str.indexOf(at, (lat + 1)) != -1) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_25");
                var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_24") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_24") : "Invalid e-mail id";

                if (UsrAlrtMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert('Invalid e-mail id');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
            }*/


            if (str.substring(lat - 1, lat) == dot || str.substring(lat + 1, lat + 2) == dot) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_25");
                var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_24") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_24") : "Invalid e-mail id";

                if (UsrAlrtMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    // alert('Invalid e-mail id');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
            }

            if (str.indexOf(dot, (lat + 2)) == -1) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_25");
                var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_24") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_24") : "Invalid e-mail id";

                if (UsrAlrtMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    // alert('Invalid e-mail id');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
            }

            if (str.indexOf(" ") != -1) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_25");
                var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_24") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_24") : "Invalid e-mail id";

                if (UsrAlrtMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    // alert('Invalid e-mail id');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
            }

            return true;
        }

        ////   **************** End Function *******************************

        function ValidateUpload(id) {
            // alert(id);
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var Upload_Image = document.getElementById(id);
            var myfile = Upload_Image.value;
            //alert(Upload_Image.value);
            if (myfile.indexOf("jpg") > 0 || myfile.indexOf("jpeg") > 0) {

            }
            else {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_32");
                var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_25") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_25") : "The file given for upload is not valid";

                if (UsrAlrtMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert('The file given for upload is not valid');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
            }
        }
    //        function showothercouuntry() {
    //            var e = document.getElementById("ucPAdd_ddCountry");
    //            var strCountry = e.options[e.selectedIndex].text;
    //            if (strCountry.toUpperCase() == 'OTHERS') {
    //                document.getElementById('ucPAdd__tbCountry').style.display = 'block';
    //                document.getElementById('ucPAdd_tbState').style.display = 'block';
    //                
    //            }
    //            else {
    //                document.getElementById('ucPAdd__tbCountry').style.display = 'none';
    //                document.getElementById('ucPAdd_tbState').style.display = 'none';

    //            }
    //        }
        function ConfirmDelete() {
            var cnfm;
            //var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_26") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_26") : "Are you sure you want to delete this?";
    //below var commented by sudha
           // var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_33");
            if (UsrAlrtMsg != null) {
                cnfm = confirm(UsrAlrtMsg);
                // return false;
            }
            else {
                cnfm = confirm(UsrAlrtMsg);
                // return false;
            }
            //var cnfm = confirm("Are you sure you want to delete this?");
            if (cnfm == true) {
                document.getElementById('hdndeletepswd').value = "1";
            }
            else {
                document.getElementById('hdndeletepswd').value = "0";
            }
        }

        function ConfirmResetPswd() {
            var cnfm;
            var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_27") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_27") : "Are you sure you want to Reset Password?";

            //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_31");
            if (UsrAlrtMsg != null) {
                cnfm = confirm(UsrAlrtMsg);
                //return false;
            }
            else {
                cnfm = confirm(UsrAlrtMsg);
                //return false;
            }
            //cnfm = confirm("Are you sure you want to Reset Password?");var cnfm = confirm("Are you sure you want to Reset Password?");
            if (cnfm == true) {
                document.getElementById('hdnRstPswd').value = "1";
            }
            else {
                document.getElementById('hdnRstPswd').value = "0";
            }
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
                           if (key == 8 || isCtrl) {
                                return true;
                           }
                            reg = /\d/;
                            var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
                            var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;
                            return isFirstN || isFirstD || reg.test(keychar);
                       }  
    function showModalPopup(evt) {

        document.getElementById('pnlOthers').style.display = "none";
        var modalPopupBehavior = $find('mpeOthersBehavior');
        modalPopupBehavior.show();
    }
    function doClear() {
        document.getElementById("txtLocation").value = "";
        document.getElementById("ddlLocationType").setAttribute("SelectedIndex", "0", "true");
        document.getElementById("chkStatus").checked = true;
        return false;
    }
        function doValidation() {

            var flag = 0;
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_28") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_28") : "Provide the location name";

            if ((document.getElementById('txtLocation').value).trim() == '') {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_26");
                if (UsrAlrtMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    //return false;
                }
                else {
                    // alert('Provide the location name');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    //return false;
                }
                document.getElementById('txtLocation').value = '';
                document.getElementById('txtLocation').focus();
                flag = 1;
                return false;
            }
            if (document.getElementById('ddlLocationType').value == 0) {
                var UsrAlrtMsg1 = SListForAppMsg.Get("Admin_UserMaster_aspx_29") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_29") : "Select location type";

                if (UsrAlrtMsg1 != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                    //return false;
                }
                else {
                    // alert('Select location type');
                    ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                    // return false;
                }
                document.getElementById('ddlLocationType').focus();
                if (flag == 1) {
                    document.getElementById('txtLocation').focus();
                }
                return false;
            }
            return true;
            document.getElementById('divOthers').style.display = "block";
        }
        function validorgaddress() {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_30") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_30") : "Select the Org address";

            if (document.getElementById('drpOrgAddress').value == 0) {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_28");
                if (UsrAlrtMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert('Select the Org address');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
            }
        }
        function checkUserName() {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var UsrAlrtMsg = SListForAppMsg.Get("Admin_UserMaster_aspx_31") != null ? SListForAppMsg.Get("Admin_UserMaster_aspx_31") : "Please provide user name";

            if (document.getElementById('txtName').value == "") {
                //var userMsg = SListForApplicationMessages.Get("Admin\\UserMaster.aspx_41");
                if (UsrAlrtMsg != null) {
                    //  alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert('Please provide user name');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }


            }
        }
    function AutoGName1ContextKey() {
        var OrgID = document.getElementById('hdnorgid').value;
        var pstatus = "A";
        var sval = OrgID + "~" + "Users" + "~" + pstatus;

        if (document.getElementById('chkbxDelete').checked) {

            pstatus = "D";
        }


        if (document.getElementById('rbtnPatient').checked)
        { sval = OrgID + "~" + "Patient" + "~" + pstatus };
        if (document.getElementById('rbtnOnline').checked)
        { sval = OrgID + "~" + "Online" + "~" + pstatus };
        if (document.getElementById('rbtnUser').checked)
        { sval = OrgID + "~" + "Users" + "~" + pstatus };

        $find('AutoCompleteExLstGrp11').set_contextKey(sval);
    }
</script>

</body>
</html>
