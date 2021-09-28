<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewInstanceCreation.aspx.cs"
    Inherits="NewInstanceCreation_NewInstanceCreation" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <link href="../StyleSheets/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link rel="Stylesheet" type="text/css" href="../StyleSheets/jquery.datatable.css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <script type="text/javascript" src="../Scripts/jquery.min.js" language="javascript"></script>
    <script src="../Scripts/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Scripts/moment.js"></script>
   

</head>
<body >
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table class="searchPanel">
                                <tr>
                                <td>
                                <div id="divCreateNewInstance" runat="server" style="display:block;">
                                    <table class="tabledata w-100p">
                                        <tr class="a-left">
                                            <td style="width: 171px;">
                                                <asp:Label runat="server" ID="lblloc" Text="Default Organization" 
                                                    meta:resourcekey="lbllocResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlOrgName" runat="server" CssClass="ddlsmall" 
                                                    OnSelectedIndexChanged="ddlOrgName_SelectedIndexChanged" onchange="mobilenovalidation('')"
                                                    AutoPostBack="True" TabIndex="13" meta:resourcekey="ddlOrgNameResource1">
                                                </asp:DropDownList>
                                            </td>
                                            <tr class="a-left">
                                                <td style="width: 173px;">
                                                   <asp:Label runat="server" ID="lblorg" Text="Org Name" 
                                                        meta:resourcekey="lblorgResource1"></asp:Label>
                                                </td>
                                                <td style="width: 300px;">
                                                    <asp:TextBox ID="txtOrgName" runat="server" CssClass="Txtboxsmall" TabIndex="1" 
                                                          OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" meta:resourcekey="txtOrgNameResource1"></asp:TextBox>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                     <asp:Label ID="lbldefaultorg" runat="server" Text="Is Base Org?" 
                                                        meta:resourcekey="lbldefaultorgResource1"></asp:Label>
                                                <asp:CheckBox ID="chkbaseorgselect" runat="server" 
                                                        meta:resourcekey="chkbaseorgselectResource1"/>
                                                </td>
                                                <td style="width: 211px;">
                                               <asp:Label runat="server" ID="lbldisplay" Text="Display Name" 
                                                        meta:resourcekey="lbldisplayResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtdisplayname" runat="server" CssClass="Txtboxsmall" MaxLength="250"
                                                    TabIndex="13"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" 
                                                    meta:resourcekey="txtdisplaynameResource1"></asp:TextBox>
                                                 <img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                            </tr>
                                    </table>
                                    <asp:Panel ID="addpanel" runat="server" meta:resourcekey="addpanelResource1">
                                        <table class="tabledata w-100p">
                                            <tr>
                                                <td colspan="4">
                                                    <uc2:AddressControl ID="ucPAdd" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <table class="tabledata w-100p">
                                        <tr class="a-left">
                                         <td style="width: 171px;">
                                                    <asp:Label runat="server" ID="lbllocn" Text="Location" 
                                                        meta:resourcekey="lbllocnResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtLocation" runat="server" CssClass="Txtboxsmall" MaxLength="250"
                                                        TabIndex="2" meta:resourcekey="txtLocationResource1"></asp:TextBox>
                                                    <img src="../Images/starbutton.png" alt="" align="middle" />
                                                </td>
                                        </tr>
                                        <tr class="a-left">
                                            <td style="width: 171px;">
                                                <asp:Label runat="server" ID="Label1" Text="Base Currency" 
                                                    meta:resourcekey="Label1Resource1"></asp:Label>
                                            </td>
                                            <td style="width: 300px;">
                                                <asp:DropDownList ID="ddlBaseCurrency" runat="server" CssClass="ddlsmall" 
                                                    AutoPostBack="True" meta:resourcekey="ddlBaseCurrencyResource1">
                                                </asp:DropDownList>
                                                <img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                            <td style="width: 171px;">
                                                <asp:Label ID="fileupload" runat="server" Text="Logo" 
                                                    meta:resourcekey="fileuploadResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:FileUpload ID="FileUpload1" runat="server" 
                                                    accept="gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG" 
                                                    meta:resourcekey="FileUpload1Resource1" />
                                            </td>
                                            <td>
                                                <%--<img alt="" src="<%=LogoPath%>" class="logostyle" />--%>
                                            <img id="imglogo" runat="server" alt="Logo" src="<%=LogoPath%>" style="display: none"
                                                class="logostyle" />
                                            </td>
                                        </tr>
                                        <tr>
                                        <td id="tdreplang" runat="server">
                                        <asp:Label ID="lblreplang" runat="server" Text="Report Language"  meta:resourcekey="lblreplangResource1" ></asp:Label>
                                        </td>
                                        <td  id="tdddreplang" runat="server" style="width: 300px;">
                                        <asp:DropDownList CssClass="ddlsmall"  ID="ddlreplang" runat="server"></asp:DropDownList>
                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                        </td>
                                        <td colspan="3"></td>
                                        </tr>
                                    </table>
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" ID="s1role" Text="ROLES" Visible="False" 
                                                    style="font-weight:bold;" meta:resourcekey="s1roleResource1"></asp:Label>
                                                <asp:CheckBox ID="chkRolesAll" runat="server" onclick="CheckAll();"
                                                    Visible="False" ToolTip="select row" 
                                                    meta:resourcekey="chkRolesAllResource1" />&nbsp;
                                                <asp:Label ID="lblroleall" runat="server" Text="All" Visible="False" 
                                                    meta:resourcekey="lblroleallResource1"></asp:Label>    
                                            </td>
                                        </tr>
                                        <tr  style="display:table-row;">
                                            <td>
                                                <asp:CheckBoxList ID="chkRoles" RepeatColumns="5" runat="server" 
                                                    meta:resourcekey="chkRolesResource1">
                                                </asp:CheckBoxList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" ID="s2Purpose" Text="VISIT PURPOSE" Visible="False" 
                                                    style="font-weight:bold;" meta:resourcekey="s2PurposeResource1"></asp:Label>
                                                <asp:CheckBox ID="chkVisitAll" runat="server" Visible="False"
                                                    onclick="CheckAllVisit();" ToolTip="select row" 
                                                    meta:resourcekey="chkVisitAllResource1" />&nbsp;
                                                    <asp:label ID="lblvisitall" runat="server" Text="All"  Visible="False" 
                                                    meta:resourcekey="lblvisitallResource1"></asp:label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBoxList ID="chkVisitPurpose" RepeatColumns="5" runat="server" 
                                                    meta:resourcekey="chkVisitPurposeResource1">
                                                </asp:CheckBoxList>
                                            </td>
                                        </tr>
                                        <%--Department--%>
                                    <tr>
                                            <td>
                                                <asp:Label runat="server" ID="lbldept" Text="DEPARTMENT" Visible="False" 
                                                    style="font-weight:bold;" meta:resourcekey="lbldeptResource1"></asp:Label>
                                                <asp:CheckBox ID="chkDeptAll" runat="server" onclick="CheckDeptAll();"
                                                    Visible="False" ToolTip="Select Row" 
                                                    meta:resourcekey="chkDeptAllResource1" />&nbsp;
                                                    <asp:Label ID="lbldeptall" runat="server" Text="All"  Visible="False" 
                                                    meta:resourcekey="lbldeptallResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    <tr>
                                            <td>
                                                <asp:CheckBoxList ID="chkDeptlist" RepeatColumns="5" runat="server" 
                                                    meta:resourcekey="chkDeptlistResource1">
                                                </asp:CheckBoxList>
                                            </td>
                                        </tr>  
                                        <%--end dept    --%>                                  
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnFinish" runat="server" OnClientClick="return ValidateNewInstance();"
                                                    OnClick="btnFinish_Click" TabIndex="41" Text="Finish" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" meta:resourcekey="btnFinishResource1" />
                                                    
                                                     <asp:Button ID="btnupdate" runat="server" OnClientClick="return ValidateNewInstance();"
                                                     TabIndex="41" Text="Update" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" OnClick="btnupdate_Click" 
                                                    Style="display: none" meta:resourcekey="btnupdateResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                        <asp:UpdateProgress ID="Progressbar" runat="server">
                                            
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
                        </div>
                                </td>
                                </tr>
                                </table>
                                
                        </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnFinish" />
                <asp:PostBackTrigger ControlID="btnupdate" />
            </Triggers>
                        </asp:UpdatePanel>
                        <%--<asp:Timer ID="Timer1" runat="server" Interval="15000" >
                        </asp:Timer>--%>
                        <%--OnTick="Timer1_Tick"--%>
                        <asp:UpdatePanel ID="UpdatePanel2" UpdateMode="Conditional" runat="server">
                           <%-- <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
                            </Triggers>--%>
                            <ContentTemplate>
                            
                                <div id="divCreatedOrg" runat="server" style="display: none;">
                                <span class="bold"><%=Resources.NewInstanceCreation_ClientDisplay.NewInstanceCreation_NewInstanceCreation_aspx_02%></span> 
                                 <asp:TextBox ID="txtSearch" runat="server" Font-Size="14px" CssClass="AutoCompletesearchBox" onkeyup="Search_Gridview(this, 'grdCreatedOrgs')"></asp:TextBox><br />
                                    <br />
                                    <table class="w-100p">
                                        <tr>
                                            <td>
                                                    <asp:GridView ID="grdCreatedOrgs" CssClass="gridView w-100p" runat="server" 
                                                        CellPadding="4" AutoGenerateColumns="False"
                                                        
                                                        DataKeyNames="Name,Location,Isdefaultorg,DefaultOrgID,InstanceID,LogoPath,DisplayName,CurrencyID" 
                                                        ForeColor="#333333" OnRowDataBound="grdCreatedOrgs_RowDataBound" OnRowCommand="grdCreatedOrgs_RowCommand"
                                                        OnRowEditing="grdCreatedOrgs_RowEditing" AllowPaging="True" 
                                                        OnPageIndexChanging="grdCreatedOrgs_PageIndexChanging" 
                                                        meta:resourcekey="grdCreatedOrgsResource1" >
                                                        <PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <HeaderStyle CssClass="dataheader1" />
                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                        PageButtonCount="1" PreviousPageText="" Visible="false"/>

                                                        <Columns>
                                                            <asp:BoundField DataField="Name" HeaderText="Org Name" 
                                                                meta:resourcekey="BoundFieldResource1" />
                                                            <asp:BoundField DataField="Location" HeaderText="Location" 
                                                                meta:resourcekey="BoundFieldResource2" />
                                                            <asp:BoundField DataField="Isdefaultorg" HeaderText="Isdefaultorg" 
                                                                Visible="false" meta:resourcekey="BoundFieldResource3"/>
                                                            <asp:BoundField DataField="DefaultOrgID" HeaderText="DefaultOrgID" 
                                                                Visible="false" meta:resourcekey="BoundFieldResource4"/>
                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Currency ID" 
                                                                Visible="false" meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblcurrency" Text='<%# Eval("CurrencyID") %>' runat="server" 
                                                                        Visible="False" meta:resourcekey="lblcurrencyResource1" />
                                                                </ItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="DisplayName" HeaderText="Display Name" 
                                                                Visible="false" meta:resourcekey="BoundFieldResource5" />
                                                            <asp:BoundField DataField="DefaultLoginName" HeaderText="User Name" 
                                                                meta:resourcekey="BoundFieldResource6" />
                                                            <%--<asp:BoundField DataField="DefaultPassword" HeaderText="Password" />--%>
                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Password" 
                                                                meta:resourcekey="TemplateFieldResource2">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblPassword" Text='<%# Bind("DefaultPassword") %>' 
                                                                        runat="server" meta:resourcekey="lblPasswordResource1" />
                                                                </ItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Status" 
                                                                meta:resourcekey="TemplateFieldResource3">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblStatus" Text='<%# Bind("IsApproved") %>' runat="server" 
                                                                        meta:resourcekey="lblStatusResource1" />
                                                                </ItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="CreatedAt" HeaderText="Created At" 
                                                                meta:resourcekey="BoundFieldResource7" />
                                                            <asp:BoundField DataField="CompletedAt" HeaderText="Completed At" 
                                                                meta:resourcekey="BoundFieldResource8" />
                                                            <asp:BoundField DataField="InstanceID" HeaderText="InstanceID" Visible="false" 
                                                                meta:resourcekey="BoundFieldResource9" />
                                                            <asp:TemplateField HeaderText="Logo" Visible="false" 
                                                                meta:resourcekey="TemplateFieldResource4">
                                                                <ItemTemplate>
                                                                    <asp:Image ID="Image1" runat="server" class="logostyle" ImageUrl='<%# Bind("LogoPath") %>'
                                                                        Visible="False" meta:resourcekey="Image1Resource1" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Action" 
                                                                meta:resourcekey="TemplateFieldResource5">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="btEdit" runat="server" CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                                                                        CommandName="Edit" Font-Bold="False" Font-Size="12px" 
                                                                        Font-Underline="True" ForeColor="Blue"
                                                                        Text="Edit" meta:resourcekey="btEditResource1" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                            </td>
                                        </tr>
                                        
                                    <tr>
                                    <td class="a-left">
                                        <table class="w-100p">
                                    <tr id="GrdFooter" runat="server" style="display: none;" class="dataheaderInvCtrl">
                                        <td class="divFooterNav a-center">
                                        <asp:Label ID="lblPageStart" runat="server" Font-Bold="True" ></asp:Label>
                                            <asp:Label ID="lblGrdvwtotpage" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                            <asp:Label ID="lblendPage" runat="server" Font-Bold="True" ></asp:Label>
                                            <asp:Label ID="lblGrdToOF" runat="server" Font-Bold="True" ForeColor="Blue"></asp:Label>
                                            <asp:Button ID="Btn_Previous" runat="server" Text="Previous" CssClass="btn w-71" meta:resourcekey="Btn_PreviousResource1"  OnClick="Btn_Previous_Click"/>
                                            <asp:Button ID="Btn_Next" runat="server" Text="Next"  CssClass="btn"  meta:resourcekey="Btn_NextResource1"  OnClick="Btn_Next_Click"/>
                                            <asp:Label ID="Labelpagetogo" runat="server" Text="Enter The Page To Go:" meta:resourcekey="LabelpagetogoResource1"></asp:Label>
                                            <asp:TextBox ID="txtpageNo" runat="server" CssClass="w-30" AutoComplete="off" MaxLength="7"
                                                meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                                            <asp:Button ID="btnGoes" runat="server" Text="Go" OnClientClick="return validatePageNumber();"
                                                CssClass="btn" OnClick="btnGoes_Click" meta:resourcekey="btnGoesResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                        
                                        <%--<tr>
                                    <td>
                                        Org Name : 
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtNewOrg" runat="server" Width="250px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        User Name : 
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtUserName" runat="server" Width="250px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Password : 
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPassword" runat="server" Width="250px"></asp:TextBox>
                                    </td>
                                </tr>--%>
                                    </table>
                                </div>
                                
                                </ContentTemplate>
                        </asp:UpdatePanel>
        <div class="scrollcss" style="width: 1300px; height: auto" id="DivInstanceGrd" runat="server">
            <table id="tblInstanceCreation" style="display: none;">
                <thead>
                    <tr>
                        <th>
                            <b>Org Name </b>
                        </th>
                        <th>
                            <b>Location </b>
                        </th>
                        <th>
                            <b>UserName </b>
                        </th>
                        <th>
                            <b>Password </b>
                        </th>
                        <th>
                            <b>Status </b>
                        </th>
                        <th>
                            <b>CreatedAt </b>
                        </th>
                        <th>
                            <b>CompletedAt </b>
                        </th>
                        <th>
                            <b>Action </b>
                        </th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />       
        <asp:HiddenField ID="hdnadd" runat="server" />
        <asp:HiddenField ID="hdnLogoPath" runat="server" />
        <asp:HiddenField ID="hdnOrgName" runat="server" />
        <asp:HiddenField ID="hdnInstanceID" runat="server" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
        <asp:HiddenField ID="hdnlogname" runat="server" /> 
        <asp:HiddenField ID="hdnlogpwd" runat="server" />  
    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>
     <script language="javascript" type="text/javascript">
         function hdnInstanceID(hdnID, Logo) {


             document.getElementById('hdnInstanceID').value = hdnID;
             document.getElementById('hdnLogoPath').value = Logo;
         }

         function Search_Gridview(strKey, strGV) {
             debugger;
             var strData = strKey.value.toLowerCase().split(" ");
             var tblData = document.getElementById(strGV);
             var rowData;
             for (var i = 1; i < tblData.rows.length; i++) {
                 rowData = tblData.rows[i].innerHTML;
                 var styleDisplay = 'none';
                 for (var j = 0; j < strData.length; j++) {
                     if (rowData.toLowerCase().indexOf(strData[j]) >= 0)
                         styleDisplay = '';
                     else {
                         styleDisplay = 'none';
                         break;
                     }
                 }
                 tblData.rows[i].style.display = styleDisplay;
             }
         }    

         function ShowAlertMsg() {
             var objAlert = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_Alert");
             var objApp01 = SListForAppMsg.Get("Newinstancecreation_Newinstancecreation_aspx_01") == null ? " details saved successfully.Org Creation has been initiated." : SListForAppMsg.Get("Newinstancecreation_Newinstancecreation_aspx_01");
             var objApp02 = SListForAppMsg.Get("Newinstancecreation_Newinstancecreation_aspx_02") == null ? "  creation completed successfully. You can login with given credentials." : SListForAppMsg.Get("Newinstancecreation_Newinstancecreation_aspx_02");
             var objApp03 = SListForAppMsg.Get("Newinstancecreation_Newinstancecreation_aspx_03") == null ? "Login Credentials \n Login Name :" : SListForAppMsg.Get("Newinstancecreation_Newinstancecreation_aspx_03");
             var objApp04 = SListForAppMsg.Get("Newinstancecreation_Newinstancecreation_aspx_04") == null ? "Password : " : SListForAppMsg.Get("Newinstancecreation_Newinstancecreation_aspx_04");
	      var objApp05 = SListForAppMsg.Get("Newinstancecreation_Newinstancecreation_aspx_16") == null ? "New Org Created Successfully. UserName :  " : SListForAppMsg.Get("Newinstancecreation_Newinstancecreation_aspx_16");
             var successtxt = document.getElementById('txtOrgName').value;
             //            alert(successtxt + " details saved successfully.Org Creation has been initiated.");
             //            alert(successtxt + "  creation completed successfully.\n You can login with given credentials.");
             //ValidationWindow(successtxt + objApp01, objAlert);

             //ValidationWindow(successtxt + objApp02, objAlert);
             var logname = document.getElementById('hdnlogname').value;
             var logpwd = document.getElementById('hdnlogpwd').value;
             if (logname != "") {
                 // ValidationWindow(objApp03 + logname + objApp04 + logpwd, objAlert);
                // ValidationWindow('<span class="bold">' + successtxt + '</span>' + objApp01 + '<span class="bold">' + successtxt + '</span>' + objApp02 + objApp03 + '<span class="bold">' + logname + '</span>' + objApp04 + '<span class="bold">' + logpwd + '</span>', objAlert);
		ValidationWindow( objApp05 +'</span>'+logname+'</span>'+  objApp04 +'</span>'+ logpwd,objAlert );
                 // alert("Login Credentials \n Login Name : " + logname + "\nPassword : " + logpwd);
             }
             document.getElementById('txtOrgName').value = "";
             document.getElementById('hdnlogname').value = "";
             document.getElementById("hdnlogpwd").value = "";
             // window.location.href('NewInstanceCreation.aspx');
             //return false;
         }
         function ShowAlertMsgUpdate() {
             var objAlert = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_Alert") == null ? "Alert" : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_Alert");             
             var objApp05 = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_05") == null ? "Details updated successfully " : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_05");
             var successtxt = document.getElementById('txtOrgName').value;
             ValidationWindow(successtxt + objApp05, objAlert);

             //alert(successtxt + " details updated successfully");
             document.getElementById('txtOrgName').value = "";
         }
         function CheckAll() {
             var intIndex = 0;
             var rowCount = document.getElementById('chkRoles').getElementsByTagName("input").length;
             for (i = 0; i < rowCount; i++) {
                 if (document.getElementById('chkRolesAll').checked == true) {
                     if (document.getElementById("chkRoles" + "_" + i)) {
                         if (document.getElementById("chkRoles" + "_" + i).disabled != true)
                             document.getElementById("chkRoles" + "_" + i).checked = true;
                     }
                 }
                 else {
                     if (document.getElementById("chkRoles" + "_" + i)) {
                         if (document.getElementById("chkRoles" + "_" + i).disabled != true)
                             document.getElementById("chkRoles" + "_" + i).checked = false;
                     }
                 }
             }
         }
         function chkrole() {
             //debugger;
             var objAlert = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_Alert") == null ? "Alert" : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_Alert");
             var objApp17 = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_17") == null ? "Select Role and Proceed" : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_17");
             var rowCount = document.getElementById('chkRoles').getElementsByTagName("input").length;
             var count = 0;
             for (i = 0; i < rowCount; i++) {
                 if (document.getElementById("chkRoles" + "_" + i).checked == true) {
                     count++;
                     }
                 }
                 if (count == 0) {
                     ValidationWindow(objApp17, objAlert);
                     return false;
                 }
                 return true; 
         }

         function CheckDeptAll() {
             var intIndex = 0;
             var rowCount = document.getElementById('chkDeptlist').getElementsByTagName("input").length;
             for (i = 0; i < rowCount; i++) {
                 if (document.getElementById('chkDeptAll').checked == true) {
                     if (document.getElementById("chkDeptlist" + "_" + i)) {
                         if (document.getElementById("chkDeptlist" + "_" + i).disabled != true)
                             document.getElementById("chkDeptlist" + "_" + i).checked = true;
                     }
                 }
                 else {
                     if (document.getElementById("chkDeptlist" + "_" + i)) {
                         if (document.getElementById("chkDeptlist" + "_" + i).disabled != true)
                             document.getElementById("chkDeptlist" + "_" + i).checked = false;
                     }
                 }
             }
         }

        function CheckAllVisit() {
            var rowcount = document.getElementById('chkVisitPurpose').getElementsByTagName("input").length;
            for (i = 0; i < rowcount; i++) {
                if (document.getElementById('chkVisitAll').checked == true) {
                    document.getElementById("chkVisitPurpose" + "_" + i).checked = true;

                 }
                 else {
                     if (document.getElementById('chkVisitAll').checked == false) {
                         document.getElementById("chkVisitPurpose" + "_" + i).checked = false;
                     }
                 }
             }
         }

         function alpha(e) {
             var k;
             document.all ? k = e.keyCode : k = e.which;
             return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || (k >= 48 && k <= 57));
         }
         function ValidateNewInstance() {
            // debugger;
             var objAlert = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_Alert") == null ? "Alert" : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_Alert");
             var objApp06 = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_06") == null ? " Provide the organization name " : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_06");
             var objApp07 = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_07") == null ? " Provide the Display Name" : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_07");
             var objApp08 = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_08") == null ? " Provide the location" : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_08");
             var objApp09 = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_09") == null ? " Provide the address" : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_09");
             var objApp10 = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_21") == null ? " Provide the city" : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_21");
             var objApp11 = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_11") == null ? "Provide at least one contact number" : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_11");
             var objApp12 = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_18") == null ? "Select the Base Currency" : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_18");
             var objApp16 = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_16") == null ? "Select the Default Organization" : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_16");
             var objApp17 = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_22") == null ? "Select the Report Language" : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_22");

             $("#ddlOrgName").prop("disabled", false);
             $("#ddlBaseCurrency").prop('disabled', false);
             $("chkbaseorgselect").prop('disabled', false);
             if (document.getElementById('ddlOrgName').value == 0) {
                 ValidationWindow(objApp16, objAlert);
                 // alert('Select the Base Currency');
                 document.getElementById('ddlOrgName').focus();
                 return false;
             }
             if (document.getElementById('txtOrgName').value == '') {
                 ValidationWindow(objApp06, objAlert);
                 //alert('Provide the organization name');
                 document.getElementById('txtOrgName').focus();
                 return false;
             }
             if (document.getElementById('txtdisplayname').value == 0) {
                 ValidationWindow(objApp07, objAlert);
                 //alert('Provide the Display Name');
                 document.getElementById('txtdisplayname').focus();
                 return false;
             }
	    if (document.getElementById('ucPAdd_txtAddress2').value == '') {
                 ValidationWindow(objApp09, objAlert);
                 // alert('Provide the address');
                 document.getElementById('ucPAdd_txtAddress2').focus();
                 return false;
             }
             if (document.getElementById('ucPAdd_txtCity').value == '') {
                 ValidationWindow(objApp10, objAlert);
                 //alert('Provide the city in permanent address');
                 document.getElementById('ucPAdd_txtCity').focus();
                 return false;
             }
             if ((document.getElementById('ucPAdd_txtMobile').value == '') && (document.getElementById('ucPAdd_txtLandLine').value == '')) {
                 ValidationWindow(objApp11, objAlert);
                 // alert('Provide at least one contact number');
                 document.getElementById('ucPAdd_txtMobile').focus();
                 return false;
             }
             if (document.getElementById('txtLocation').value == '') {
                 ValidationWindow(objApp08, objAlert);
                 //alert('Provide the location');
                 document.getElementById('txtLocation').focus();
                 return false;
             }

           
             if (document.getElementById('ddlBaseCurrency').value == 0) {
                 ValidationWindow(objApp12, objAlert);
                 // alert('Select the Base Currency');
                 document.getElementById('ddlBaseCurrency').focus();
                 return false;
             }
             if (document.getElementById('ddlreplang').value == 0) {
                 ValidationWindow(objApp17, objAlert); 
                 document.getElementById('ddlreplang').focus();
                 return false;
             }
             var a = chkrole();
             if (a == false) {
                 return false;
             }
             else {
                 return true;
             }
             
         }
         function showvalidatemsg() {
             var objAlert = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_Alert") == null ? "Alert" : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_Alert");
             var objApp06 = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_12") == null ? " Enter Valid Page Number" : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_12");
             ValidationWindow(objApp06, objAlert);
             //alert("Enter Valid Page Number");
         }
         function validatePageNumber() {
             var objAlert = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_Alert") == null ? "Alert" : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_Alert");
             var objApp06 = SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_13") == null ? " Enter page number" : SListForAppMsg.Get("NewInstanceCreation_NewInstanceCreation_aspx_13");

             if (document.getElementById('txtpageNo').value == "") {
                 ValidationWindow(objApp06, objAlert);
                 //alert("Enter page number");
                 return false;
             }
         }
         function CreateatedOrgInstanceDetail(OrgID) {
             //   debugger;
             var ReturnStatus = -1;
             $.ajax({
                 type: "POST",
                 url: "../WebService.asmx/CreateatedOrgInstanceDetail",
                 contentType: "application/json; charset=utf-8",
                 data: "{'ReturnStatus' : '" + ReturnStatus + "','OrgID': '" + OrgID + "'}",
                 dataType: "json",
                 success: fnCreateatedOrgInstanceDetail,
                 error: function(xhr, ajaxOptions, thrownError) {
                     alert("Error");
                     $('#tblInstanceCreation').hide();
                     return false;
                 }
             });
         }
         function fnCreateatedOrgInstanceDetail(result) {
             // debugger;

            try {
                var oTable;

                if (result != "[]") {

                    // $('#tblInstanceCreation tbody> tr>').empty();
                    oTable = $('#tblInstanceCreation').dataTable({

                        "bDestroy": true,
                        "bAutoWidth": false,
                        "aaData": result.d,
                        "sDom": '<"H"Tfr>t<ip>',
                        //"sDom": '<"H"lr>t<"F"ip>',
                        "bFilter": true,
                        "bInfo": false,
                        "bProcessing": true,
                        //"bServerSide": true,                  
                        "aoColumns": [
            { "mDataProp": "Name" },
            { "mDataProp": "Location" },
            { "mDataProp": "DefaultLoginName" },
            { "mDataProp": "DefaultPassword" },
            { "mDataProp": "IsApproved" },
            { "mDataProp": "CreatedAt",
                "mRender": function(data, type, full) {
                    // debugger;
                    var dtStart = new Date(parseInt(data.substr(6)));
                    var dtStartWrapper = moment(dtStart);
                    return dtStartWrapper.format('DD/MM/YYYY HH:mm');
                }
            },
            { "mDataProp": "CompletedAt",
                "mRender": function(data, type, full) {
                    //debugger;
                    var dtStart = new Date(parseInt(data.substr(6)));
                    var dtStartWrapper = moment(dtStart);
                    return dtStartWrapper.format('DD/MM/YYYY HH:mm');
                }
            },
             { "mDataProp": "Isdefaultorg",
                 "mRender": function(data, type, full) {
                     //debugger;
                     return '<input type="button" value="Edit" onclick="edit();">';

                 }
             }
           ],
                        "bPaginate": true,
                        "sPaginationType": "full_numbers",

                        "bSort": false,
                        "bJQueryUI": true,
                        "iDisplayLength": 10

                    });
                    //   $('#tblInstanceCreation').show();
                    $('#tblInstanceCreation').attr("style", "display:table");

                }
            }
            catch (e) {
                alert(e);
            }
        }
        function edit() {
            //debugger;
            var table = $('#tblInstanceCreation').DataTable();
            $('#tblInstanceCreation tbody').on('click', 'tr', function() {
                var pos = table.fnGetPosition(this);
                var rowData = table.fnGetData(pos);
                $("#ddlOrgName").val(rowData.DefaultOrgID);
                $('#ddlOrgName').find('option:selected').text();
                $("#ddlBaseCurrency").val(rowData.CurrencyID);
                $('#ddlBaseCurrency').find('option:selected').text();
                document.getElementById('txtOrgName').value = rowData.Name;
                document.getElementById('txtLocation').value = rowData.Location;
                document.getElementById('txtdisplayname').value = rowData.DisplayName;
                document.getElementById('hdnInstanceID').value = rowData.InstanceID;
                if (rowData.Isdefaultorg == 'Y') {
                    document.getElementById('chkbaseorgselect').checked = true;
                }
                else {
                    document.getElementById('chkbaseorgselect').checked = false;
                }
                //                document.getElementById('btnupdate').style.display = 'block';
                //                document.getElementById('btnFinish').style.display = 'none';
                $('#btnupdate').attr("style", "display:block");
                $('#btnFinish').attr("style", "display:none");
                // document.getElementById('<%= btnupdate.ClientID %>').style.display = 'block';
                // document.getElementById('<%= btnFinish.ClientID %>').style.display = 'none';
                //$('#ddlOrgName').attr('onkeydown', 'return false');
                // $('#ddlOrgName').prop('readOnly', true);
                // $('#ddlOrgName').prop({ readOnly: true });
                $("#ddlOrgName").prop("disabled", true);
                $('#txtOrgName').attr('onkeydown', 'return false');
                $('#txtdisplayname').attr('onkeydown', 'return false');
                // $('#<%=txtdisplayname.ClientID %>').prop('disabled', true);
                $('#ddlBaseCurrency').prop('disabled', true);
                $('#chkbaseorgselect').prop('disabled', true);
                if (rowData.LogoPath != '') {
                    var imgsrc = $("#imglogo").attr("src");
                    imgsrc = rowData.LogoPath;
                    $("#imglogo").attr("src", imgsrc);
                    //document.getElementById('<%= imglogo.ClientID %>').style.display = 'block';
                    //  $('#imglogo').show();
                    $('#imglogo').attr("style", "display:block");
                }
                else {
                    // document.getElementById('<%= imglogo.ClientID %>').style.display = 'none';
                    //   $('#imglogo').hide();
                    $('#imglogo').attr("style", "display:none");
                }
                var InstacneID = rowData.InstanceID;
                AddresstoLocEdit(InstacneID);
            });
            return false;
        }
        function AddresstoLocEdit(InstacneID) {
            // //debugger;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/Getmyloc",
                contentType: "application/json; charset=utf-8",
                data: "{'InstacneID' : '" + InstacneID + "'}",
                dataType: "json",
                success: function fnpgetmylocDetails(data) {
                    var lstloc = data.d;
                    $('#ucPAdd_ddCountry').val(data.d[0].CountryID);
                    $('#ucPAdd_ddCountry').find('option:selected').text();
                    var CountryId = data.d[0].CountryID;
                    var StateID = data.d[0].StateID;
                    LoadState(CountryId, StateID);
                    document.getElementById('ucPAdd_txtAddress2').value = data.d[0].Add2;
                    document.getElementById('ucPAdd_txtAddress1').value = data.d[0].Add1;
                    document.getElementById('ucPAdd_txtAddress3').value = data.d[0].Add3;
                    document.getElementById('ucPAdd_txtAddress1').value = data.d[0].Add1;
                    document.getElementById('ucPAdd_txtCity').value = data.d[0].City;
                    document.getElementById('ucPAdd_txtPostalCode').value = data.d[0].PostalCode;
                    document.getElementById('ucPAdd_txtMobile').value = data.d[0].MobileNo;
                    document.getElementById('ucPAdd_txtLandLine').value = data.d[0].LandLineNumber;
                    //  $('#ucPAdd_ddState').value = data.d[0].StateID;
//                    $("#ucPAdd_ddState").val(data.d[0].StateID);
//                    $('#ucPAdd_ddState').find('optiosn:selected').text();
                    if ($('#ucPAdd_ddCountry').find('option:selected').text() == 'OTHERS' & $('#ucPAdd_ddState').find('option:selected').text() == 'OTHERS') {
                        $('#ucPAdd_tbState').attr("style", "display:block");
                        $('#ucPAdd_tbCountry').attr("style", "display:block");
                        //                        $('#ucPAdd_tbState').show();
                        //                        $('#ucPAdd_tbCountry').show();
                    }
                    else if ($('#ucPAdd_ddState').find('option:selected').text() == 'OTHERS') {
                        $('#ucPAdd_tbState').attr("style", "display:block");
                    }
                    else {
                        $('#ucPAdd_tbState').attr("style", "display:none");
                        $('#ucPAdd_tbCountry').attr("style", "display:none");
                    }
                }
            });
            return false;
        }
        function LoadState(CountryId,StateID) {
            //debugger;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/LoadState",
                contentType: "application/json; charset=utf-8",
                data: "{'CountryId' : '" + CountryId + "'}",
                dataType: "json",
                success: function fnpgetmylocDetails(data) {
                    var lstloc = data.d;
                    var option = '';
                    for (var i = 0; i < data.d.length; i++) {
                        option += '<option value="' + data.d[i].StateID + '">' + data.d[i].StateName + '</option>';
                    }
                    $('#ucPAdd_ddState').append(option);
                    $("#ucPAdd_ddState").val(StateID);
                    $('#ucPAdd_ddState').find('option:selected').text();
                }
            });
        }
        
    </script>
    </form>
</body>
</html>
