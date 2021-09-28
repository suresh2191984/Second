<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeFile="RefPhyRateMapping.aspx.cs"
    Inherits="RefPhyRateMapping" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Add Corporate And Client </title>
    <%-- <link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/bid.js" type="text/javascript"></script>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc7:DocHeader ID="docHeader" runat="server" />
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
                    <div class="contentdata1">
                        <ul>
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="pnl_Client" runat="server">
                            <ContentTemplate>
                                <asp:Panel ID="pnlAdd" CssClass="dataheader2" Style="width: 100%" BorderWidth="1px"
                                    runat="server" meta:resourcekey="pnlAddResource1">
                                    <div id="divInv" runat="server">
                                        <table width="100%" border="0">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Rs_SelectType" Text="Select Type :" runat="server" meta:resourcekey="Rs_SelectTypeResource1"></asp:Label>
                                                    <asp:RadioButton ID="rdoClient" runat="server" onclick="javascript:ChkSelectType()"
                                                        GroupName="rdo" Text="Client/Corporate" meta:resourcekey="rdoClientResource1" />
                                                    <asp:RadioButton ID="rdoTPA" runat="server" GroupName="rdo" onclick="javascript:ChkSelectType()"
                                                        Text="TPA/Insurance" meta:resourcekey="rdoTPAResource1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top">
                                                    <table border="0" width="75%">
                                                        <tr>
                                                            <td style="width: 20%">
                                                                <asp:Label ID="lbl_Type" runat="server" meta:resourcekey="lbl_TypeResource1" />
                                                            </td>
                                                            <td>
                                                                <asp:TextBox onblur="return Chkgeneral()" ID="txtName" runat="server" CssClass ="Txtboxsmall" meta:resourcekey="txtNameResource1"></asp:TextBox>
                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                            </td>
                                                            <td style="width: 30%">
                                                                &nbsp;
                                                            </td>
                                                            <td rowspan="4" style="display: none; width: 20%">
                                                                <asp:Label ID="Rs_Note" Text="Note :" runat="server" meta:resourcekey="Rs_NoteResource1"></asp:Label>
                                                                <asp:Label ID="lblwarning" runat="server" Text="Warning Message" CssClass="label_error"
                                                                    meta:resourcekey="lblwarningResource1"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <div id="divClientType" runat="server" style="display: none;">
                                                                    <table>
                                                                        <tr style="display: none;">
                                                                            <td>
                                                                                <asp:Label ID="Rs_SelectRateType" Text="Select Rate Type" runat="server" meta:resourcekey="Rs_SelectRateTypeResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddlRate" runat="server" Width="145px" meta:resourcekey="ddlRateResource1">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                        <tr id="ratetype" runat="server" style="display: block;">
                                                                            <td runat="server">
                                                                                <asp:Label ID="Rs_SelectRate" Text="Select Rate" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td runat="server">
                                                                                <asp:DropDownList ID="ddlRateType" runat="server" onChange="javascript:loaddata(this.value);"
                                                                                    Width="155px">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="Rs_SelectAttributes" Text="Select Attributes" runat="server" meta:resourcekey="Rs_SelectAttributesResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtClientAttributes" runat="server" meta:resourcekey="txtClientAttributesResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="Rs_EnterAttributeValue" Text="Enter Attribute Value" runat="server"
                                                                                    meta:resourcekey="Rs_EnterAttributeValueResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox onblur="return Chkgeneral()" ID="txtValue" runat="server" meta:resourcekey="txtValueResource1"></asp:TextBox>
                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="Rs_SelectAttributeType" Text="Select Attribute Type" runat="server"
                                                                                    meta:resourcekey="Rs_SelectAttributeTypeResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddlClientTypes" runat="server" meta:resourcekey="ddlClientTypesResource1">
                                                                                    <asp:ListItem Text="AlphaNumeric" Value="1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                                    <asp:ListItem Text="Numeric" Value="2" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                                    <asp:ListItem Text="DateTime" Value="3" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                                <input type="button" id="btnClientAttributes" value="Add" class="btn" onclick="javascript:createClienttab();" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td valign="top" colspan="2">
                                                                                <input type="hidden" id="hdnClientAttributes" runat="server">
                                                                                    <input id="hdntvtvalue" runat="server" type="hidden"></input>
                                                                                    <table id="tblClientAttributes" border="0" cellpadding="4" cellspacing="0" class="dataheaderInvCtrl"
                                                                                        style="display: none;" width="100%">
                                                                                        <tr class="dataheader1">
                                                                                            <td style="width: 10%">
                                                                                            </td>
                                                                                            <td style="width: 45%">
                                                                                                <asp:Label ID="Rs_Attributes1" runat="server" meta:resourcekey="Rs_Attributes1Resource1"
                                                                                                    Text="Attributes"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width: 45%">
                                                                                                <asp:Label ID="Rs_Type1" runat="server" meta:resourcekey="Rs_Type1Resource1" Text="Type"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width: 45%">
                                                                                                <asp:Label ID="Rs_Value1" runat="server" meta:resourcekey="Rs_Value1Resource1" Text="Value"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </input>
                                                                                </input>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                                <div id="divTPAType" runat="server" style="display: none;">
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="Rs_SelecttheRate" Text="Select the Rate" runat="server" meta:resourcekey="Rs_SelecttheRateResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddlTPARate" runat="server" Width="155px" onChange="javascript:loaddata(this.value);"
                                                                                    meta:resourcekey="ddlTPARateResource1">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="Rs_EnterAttribute" Text="Enter Attribute" runat="server" meta:resourcekey="Rs_EnterAttributeResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtAttributes" runat="server" meta:resourcekey="txtAttributesResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="Rs_EnterAttributeValues" Text="Enter Attribute Values" runat="server"
                                                                                    meta:resourcekey="Rs_EnterAttributeValuesResource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtTpaValue" runat="server" meta:resourcekey="txtTpaValueResource1"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="Rs_SelectAttributeType1" Text="Select Attribute Type" runat="server"
                                                                                    meta:resourcekey="Rs_SelectAttributeType1Resource1"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddlTypes" runat="server" meta:resourcekey="ddlTypesResource1">
                                                                                    <asp:ListItem Text="AlphaNumeric" Value="1" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                                                    <asp:ListItem Text="Numeric" Value="2" meta:resourcekey="ListItemResource5"></asp:ListItem>
                                                                                    <asp:ListItem Text="DateTime" Value="3" meta:resourcekey="ListItemResource6"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                                <input type="button" id="btnAttributes" value="Add" class="btn" onclick="javascript:createtab();" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 50%;" valign="top">
                                                                                <input type="hidden" id="hdnAttributes" runat="server">
                                                                                    <table id="tblAttributes" border="0" cellpadding="4" cellspacing="0" class="dataheaderInvCtrl"
                                                                                        style="display: none;" width="100%">
                                                                                        <tr class="dataheader1">
                                                                                            <td style="width: 10%">
                                                                                            </td>
                                                                                            <td style="width: 45%">
                                                                                                <asp:Label ID="Rs_Attributes" runat="server" meta:resourcekey="Rs_AttributesResource1"
                                                                                                    Text="Attributes"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width: 45%">
                                                                                                <asp:Label ID="Rs_Type" runat="server" meta:resourcekey="Rs_TypeResource1" Text="Type"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width: 45%">
                                                                                                <asp:Label ID="Rs_Value" runat="server" meta:resourcekey="Rs_ValueResource1" Text="Value"></asp:Label>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </input>
                                                                            </td>
                                                                        </tr>
                                                                        <tr id="tdload" style="display: none;">
                                                                            <td>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <table>
                                                                    <tr align="center">
                                                                        <td>
                                                                            <asp:Button ID="bsave" runat="server" CssClass="btn" OnClientClick="return InPageValidation();"
                                                                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" TabIndex="4"
                                                                                Text="Save" OnClick="bsave_Click" meta:resourcekey="bsaveResource1" />
                                                                        </td>
                                                                        <td>
                                                                            <asp:Button ID="btnDelete" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                                                onmouseover="this.className='btn btnhov'" TabIndex="5" Text="Delete" OnClick="btnDelete_Click"
                                                                                meta:resourcekey="btnDeleteResource1" />
                                                                        </td>
                                                                        <td>
                                                                            <input type="reset" id="btn" value="Clear" class="btn" onclick="javascript:check();" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                    </div>
                                </asp:Panel>
                                <asp:Panel ID="PnlEditGp" CssClass="dataheader2" Style="width: 100%;" BorderWidth="1px"
                                    runat="server" meta:resourcekey="PnlEditGpResource1">
                                    <div id="divEditGp" runat="server">
                                        <table width="100%" border="0" style="vertical-align: top;">
                                            <tr>
                                                <td colspan="2" style="width: 100%; vertical-align: top;">
                                                    <table width="100%" id="ExistingClientTab" border="0" cellpadding="0" cellspacing="0"
                                                        style="display: block;">
                                                        <tr>
                                                            <td class="colorforcontent" height="23" width="50%" align="left">
                                                                <div id="ACX2OPPmt" style="display: none;">
                                                                    &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                                        style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);">
                                                                        <asp:Label ID="Rs_ExistingClient" Text="Existing Client" runat="server" meta:resourcekey="Rs_ExistingClientResource1"></asp:Label></span>
                                                                </div>
                                                                <div id="ACX2minusOPPmt" style="display: block;">
                                                                    &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                        style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);" />
                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);">
                                                                        <asp:Label ID="Rs_ExistingClient1" Text="Existing Client" runat="server" meta:resourcekey="Rs_ExistingClient1Resource1"></asp:Label>
                                                                </div>
                                                            </td>
                                                            <td>
                                                            </td>
                                                        </tr>
                                                        <tr class="tablerow" id="ACX2responsesOPPmt" style="display: block;">
                                                            <td colspan="2">
                                                                <asp:GridView ID="gvClient" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                    BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                                    CellPadding="3" Font-Bold="False" Font-Names="Verdana" Font-Overline="False"
                                                                    Font-Size="9pt" Font-Strikeout="False" Font-Underline="False" OnRowDataBound="gvClient_RowDataBound"
                                                                    meta:resourcekey="gvClientResource1">
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <Columns>
                                                                        <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                                            <ItemTemplate>
                                                                                <asp:HiddenField ID="hdnLoadAttrib" runat="server" />
                                                                                <asp:RadioButton ID="rdoSel" runat="server" GroupName="PatientSelect1" meta:resourcekey="rdoSelResource1" />
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="10%" />
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="ClientName" HeaderText="Client Name" meta:resourcekey="BoundFieldResource1" />
                                                                        <asp:BoundField DataField="RateTypeName" HeaderText="RateTypeName" Visible="False"
                                                                            meta:resourcekey="BoundFieldResource2" />
                                                                        <asp:BoundField DataField="RateName" HeaderText="Rate Name" meta:resourcekey="BoundFieldResource3" />
                                                                    </Columns>
                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="width: 100%; vertical-align: top;">
                                                    <asp:Panel ID="pnlTPA" runat="server" meta:resourcekey="pnlTPAResource1">
                                                        <table id="ExistingTPA" border="0" style="display: none; width: 100%">
                                                            <tr>
                                                                <td class="colorforcontent" width="50%" height="23" align="left">
                                                                    <div id="Div1" style="display: none;">
                                                                        &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                                            style="cursor: pointer" onclick="showResponses('Div1','Div2','Tr1',1);" />
                                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div1','Div2','Tr1',1);">
                                                                            <asp:Label ID="Rs_ExistingTPA" Text="Existing TPA" runat="server" meta:resourcekey="Rs_ExistingTPAResource1"></asp:Label></span>
                                                                    </div>
                                                                    <div id="Div2" style="display: block;">
                                                                        &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                            style="cursor: pointer" onclick="showResponses('Div1','Div2','Tr1',0);" />
                                                                        <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div1','Div2','Tr1',0);">
                                                                            <asp:Label ID="Rs_ExistingTPA1" Text="Existing TPA" runat="server" meta:resourcekey="Rs_ExistingTPA1Resource1"></asp:Label>
                                                                        </span>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr class="tablerow" id="Tr1" style="display: block;">
                                                                <td colspan="2">
                                                                    <asp:GridView ID="gvTRA" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                                        BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Font-Bold="False"
                                                                        Font-Names="Verdana" Font-Overline="False" Font-Size="9pt" Font-Strikeout="False"
                                                                        Font-Underline="False" OnRowDataBound="gvTRA_RowDataBound" Width="100%" meta:resourcekey="gvTRAResource1">
                                                                        <RowStyle ForeColor="#000066" />
                                                                        <Columns>
                                                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource2">
                                                                                <ItemTemplate>
                                                                                    <asp:HiddenField ID="hdnLoadAttrib" runat="server" />
                                                                                    <asp:RadioButton ID="rdSel" runat="server" GroupName="PatientSelect" meta:resourcekey="rdSelResource1" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle Width="10%" />
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="TPAName" HeaderText="TPA Name" meta:resourcekey="BoundFieldResource4" />
                                                                            <asp:TemplateField HeaderText="Rate Name" meta:resourcekey="TemplateFieldResource3">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="RateId" runat="server" Visible="False" Text='<%# bind("RateId") %>'
                                                                                        meta:resourcekey="RateIdResource1"></asp:Label><asp:Label ID="RateName" runat="server"
                                                                                            Text='<%# bind("RateName") %>' meta:resourcekey="RateNameResource1"></asp:Label></ItemTemplate>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                        <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                    </asp:GridView>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <br />
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    <asp:HiddenField ID="hdID" runat="server" />
    <asp:HiddenField ID="hdnTPA" runat="server" />
    <asp:HiddenField ID="hdnClient" runat="server" />
    <asp:HiddenField ID="hdnRate" runat="server" /> 
    <asp:HiddenField ID="hdnddlTPARateID" runat="server" Value="0" />
     

    <script language="javascript" type="text/javascript">

        //        function loaddropdown(id) {
        //            document.getElementById('ratetype').style.display = 'block'   
        //            var ctl = document.getElementById('<%=ddlRate.ClientID %>').value;
        //            var ddlobj = document.getElementById('<%=ddlRateType.ClientID %>');
        //            ddlobj.options.length = 0;
        //         if (ddlobj.options.length == 0) {             
        //             var hdn = document.getElementById('hdnClient').value;
        //             var list = hdn.split('^');             
        //             if (hdn != "") {
        //                 for (var i = 0; i < list.length - 1; i++) {
        //                     var value = list[i].split('~');
        //                                 
        //                     var opt = document.createElement("option");
        //                     document.getElementById('<%=ddlRateType.ClientID %>').options.add(opt);
        ////                     alert(ctl);
        ////                     alert(value[2]);
        //                     if(value[2]==ctl) {
        //                         alert(value[0]);
        //                     opt.text = value[1];
        //                     opt.value = value[0];
        //                     }
        //                 }
        //             }
        //         }
        //         
        //
        //        }
        function loaddropdown(id) {
            if (id > 0) {
                document.getElementById('ratetype').style.display = 'block'
                var ddlobj = document.getElementById('<%=ddlRateType.ClientID %>');
                var HidValue = document.getElementById('hdnClient').value;
                var MasterID = id;
                var list = HidValue.split('^');
                ddlobj.options.length = 0;
                var opt = document.createElement("option");
                document.getElementById("ddlRateType").options.add(opt);
                opt.text = '--Select-->';
                opt.value = 0;
                if (document.getElementById('hdnClient').value != "") {
                    for (var count = 0; count < list.length; count++) {
                        var Rate = list[count].split('~');
                        if (MasterID == Rate[2]) {
                            var opt = document.createElement("option");
                            document.getElementById("ddlRateType").options.add(opt);
                            opt.text = Rate[1];
                            opt.value = Rate[0];
                        }
                    }
                }
            }
            else {
                alert('Select the item');
                document.getElementById('ratetype').style.display = 'none';
                return false;
            }
        }

        function Chkgeneral() {
            var ctl = document.getElementById('<%=txtName.ClientID %>');
            if (ctl.value.toUpperCase().trim() == 'GENERAL') {
                alert('Name "GENERAL" cannot be used for Clients/Corporates. Use any other name');
                ctl.value = "";
                ctl.focus();
                return false;
            }
            else {
                return true;
            }
        }

        function createtab() {

            var j = 1;
            var obj = document.getElementById('<%=ddlTypes.ClientID%>');
            var i = obj.getElementsByTagName('OPTION');
            var AddStatus = 0;
            var Attributes = document.getElementById('txtAttributes').value;
            var Value = document.getElementById('txtTpaValue').value;
            var rwNumber = obj.options[obj.selectedIndex].value;
            var Type = obj.options[obj.selectedIndex].text;
            //document.getElementById('tblAttributes').style.display = 'block';
            var HidValue = document.getElementById('hdnAttributes').value;
            var list = HidValue.split('^');
            if (document.getElementById('hdnAttributes').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var SpecialityList = list[count].split('~');
                    if (SpecialityList[1] != '') {
                        if (SpecialityList[0] != '') {
                            rwNumber = parseInt(parseInt(SpecialityList[0]) + parseInt(1));
                        }
                        if (Attributes != '') {
                            if (SpecialityList[1] == Attributes) {
                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                if (Attributes != '') {
                    var row = document.getElementById('tblAttributes').insertRow(1);
                    //rwNumber = Attributes + rwNumber;
                    row.id = rwNumber;
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    //alert("rwNumber:" + rwNumber);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + rwNumber + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "10%";
                    cell2.innerHTML = "<b>" + Attributes + "</b> ";
                    cell2.width = "45%";
                    cell3.innerHTML = "<b>" + Type + "</b> ";
                    cell3.width = "45%";
                    cell4.innerHTML = "<b>" + Value + "</b> ";
                    cell4.width = "45%";
                    document.getElementById('hdnAttributes').value += rwNumber + "~" + Attributes + "~" + Type + "~" + Value + "^";
                    //alert(document.getElementById('hdnAttributes').value);
                    AddStatus = 2;
                    document.getElementById('tblAttributes').style.display = 'block'
                    j++;
                }
                else {
                    alert('Provide attribute to add');
                }
            }
            if (AddStatus == 0) {
                if (Attributes != '') {
                    var row = document.getElementById('tblAttributes').insertRow(1);
                    //alert("rwNumber1:" + rwNumber);
                    //rwNumber = Attributes + rwNumber;
                    row.id = rwNumber;
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    //alert("rwNumber1:" + rwNumber);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + rwNumber + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = "<b>" + Attributes + "</b> ";
                    cell3.innerHTML = "<b>" + Type + "</b>";
                    cell4.innerHTML = "<b>" + Value + "</b>";
                    j++;
                    document.getElementById('hdnAttributes').value += rwNumber + "~" + Attributes + "~" + Type + "~" + Value + "^";
                    document.getElementById('tblAttributes').style.display = 'block';
                }
                else {
                    alert('Provide attribute to add');
                }
            }
            else if (AddStatus == 1) {
                alert('Attribute already added');
            }
            //        alert(document.getElementById('PackageProfileControl_hdnSpecialityItems').value);
            return;
        }
        function ImgOnclick(ImgID) {
            //alert(ImgID);
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnAttributes').value;
            var list = HidValue.split('^');
            var NewHealthCheckupList = '';
            if (document.getElementById('hdnAttributes').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HealthCheckupList = list[count].split('~');
                    if (HealthCheckupList[0] != '') {
                        if (HealthCheckupList[0] != ImgID) {
                            NewHealthCheckupList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnAttributes').value = NewHealthCheckupList;
            }
            if (document.getElementById('hdnAttributes').value == '') {
                document.getElementById('tblAttributes').style.display = 'none';
                document.getElementById('tdload').style.display = 'none';
            }
        }

        function check() {
            document.getElementById('<%= txtName.ClientID %>').value = "";
            document.getElementById('<%= hdID.ClientID %>').value = 0;
            document.getElementById('<%= divClientType.ClientID %>').style.display = 'block';
            document.getElementById('<%= divTPAType.ClientID %>').style.display = 'none';
            document.getElementById('ExistingClientTab').style.display = 'none';
            document.getElementById('ExistingTPA').style.display = 'none';
            //document.getElementById('ExistingCorporateTab').style.display = 'block';
            document.getElementById('<%= rdoClient.ClientID %>').disabled = false;
            document.getElementById('<%= rdoTPA.ClientID %>').disabled = false;
            document.getElementById('ExistingClientTab').style.display = 'block';
            document.getElementById('<%= bsave.ClientID %>').value = 'Save';
            document.getElementById('<%= ratetype.ClientID %>').style.display = 'block';
            document.getElementById('tblAttributes').style.display = 'none';
            document.getElementById('tblClientAttributes').style.display = 'none';
        }


        function SetClientId(obj) {
            document.getElementById('<%= hdID.ClientID %>').value = obj.title;

            document.getElementById('<%= txtName.ClientID %>').value = obj.cname;            //           
            document.getElementById('<%= rdoClient.ClientID %>').checked = true;
            document.getElementById('<%= ddlRate.ClientID %>').value = obj.dtype;
            loaddropdown(obj.dtype);
            var ddlRateType = document.getElementById('<%= ddlRateType.ClientID %>');
            ddlRateType.value = obj.dratetype;
            //ddlRateType.options[ddlRateType.selectedIndex].text = obj.dratetype;
            document.getElementById('<%= bsave.ClientID %>').value = 'Update';
            document.getElementById('<%= rdoClient.ClientID %>').disabled = true;
            document.getElementById('<%= rdoTPA.ClientID %>').disabled = true;
            document.getElementById('ratetype').style.display = 'block';
            ChkSelectTypeAll();
        }
        function SetTPAId(Id, TpaName, TPAID, AttribValue, Rate) {
            //            alert(AttribValue);
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(Id).checked = true;
            var ctrl;
            ctrl = document.getElementById('obj')

            document.getElementById('<%= hdnTPA.ClientID %>').value = TPAID;
            //document.getElementById('<%= lbl_Type.ClientID %>').value = 'Enter the Insurance Name';
            document.getElementById('<%= txtName.ClientID %>').value = TpaName;
            document.getElementById('<%= rdoClient.ClientID %>').checked = false;
            document.getElementById('<%= rdoTPA.ClientID %>').checked = true;
            document.getElementById('<%= ddlTPARate.ClientID %>').value = Rate;
            document.getElementById('<%= bsave.ClientID %>').value = 'Update';
            document.getElementById('<%= rdoClient.ClientID %>').disabled = false;
            document.getElementById('<%= rdoTPA.ClientID %>').disabled = false;

            LoadOrdItemsCorp(AttribValue);
            ChkSelectTypeAll();
        }

        function ChkSelectTypeAll() {
            if (document.getElementById('<%= rdoClient.ClientID %>').checked) {
                document.getElementById('<%= lbl_Type.ClientID %>').innerHTML = 'Enter the Client Name';
                document.getElementById('<%= divClientType.ClientID %>').style.display = 'block';
                document.getElementById('<%= divTPAType.ClientID %>').style.display = 'none';
                //document.getElementById('ExistingCorporateTab').style.display = 'none';
                document.getElementById('ExistingTPA').style.display = 'none';
                document.getElementById('ExistingClientTab').style.display = 'block';
            }
            if (document.getElementById('<%= rdoTPA.ClientID %>').checked) {
                document.getElementById('<%= lbl_Type.ClientID %>').innerHTML = 'Enter the Insurance Name';
                document.getElementById('<%= divClientType.ClientID %>').style.display = 'none';
                document.getElementById('<%= divTPAType.ClientID %>').style.display = 'block';
                document.getElementById('ExistingClientTab').style.display = 'none';
                // document.getElementById('ExistingCorporateTab').style.display = 'none';
                document.getElementById('ExistingTPA').style.display = 'block';
            }
        }


        function ChkSelectType() {
             
            var response = true;
            if (document.getElementById('<%= txtName.ClientID %>').value != "" || document.getElementById('<%= txtClientAttributes.ClientID %>').value != "" || document.getElementById('<%= txtValue.ClientID %>').value != "" ||
        document.getElementById('<%= txtName.ClientID %>').value != "" || document.getElementById('<%= txtAttributes.ClientID %>').value != "" || document.getElementById('<%= txtTpaValue.ClientID %>').value != "") {
                response = confirm('Unsaved data would be lost!');
            }
            if (response) {
                if (document.getElementById('<%= rdoClient.ClientID %>').checked) {
                    document.getElementById('<%= lbl_Type.ClientID %>').innerHTML = 'Enter the Client Name';
                    document.getElementById('<%= divClientType.ClientID %>').style.display = 'block';
                    document.getElementById('<%= divTPAType.ClientID %>').style.display = 'none';
                    //document.getElementById('ExistingCorporateTab').style.display = 'none';
                    document.getElementById('ExistingTPA').style.display = 'none';
                    document.getElementById('ExistingClientTab').style.display = 'block';

                    document.getElementById('<%= txtName.ClientID %>').value = "";
                    document.getElementById('<%= txtAttributes.ClientID %>').value = "";
                    document.getElementById('<%= txtTpaValue.ClientID %>').value = "";
                    document.getElementById('<%= ddlTPARate.ClientID %>').value = document.getElementById('<%= hdnddlTPARateID.ClientID %>').value;
                    document.getElementById('<%= ddlTypes.ClientID %>').value = "1";
                    document.getElementById('<%= bsave.ClientID %>').value = 'Save';

                    document.getElementById('hdnAttributes').value = '';
                    document.getElementById('tblAttributes').value = '';
                    //document.getElementById('tblAttributes').innerHTML = '';
                    document.getElementById('tblAttributes').style.display = 'none';
                    document.getElementById('tdload').style.display = 'none';

                document.getElementById('hdnClientAttributes').value = '';
               // document.getElementById('tblClientAttributes').innerHTML = '';
                document.getElementById('tblClientAttributes').style.display = 'none';
                }
                if (document.getElementById('<%= rdoTPA.ClientID %>').checked) {
                    document.getElementById('<%= lbl_Type.ClientID %>').innerHTML = 'Enter the Insurance Name';
                    document.getElementById('<%= divClientType.ClientID %>').style.display = 'none';
                    document.getElementById('<%= divTPAType.ClientID %>').style.display = 'block';
                    document.getElementById('ExistingClientTab').style.display = 'none';
                    // document.getElementById('ExistingCorporateTab').style.display = 'none';
                    document.getElementById('ExistingTPA').style.display = 'block';

                    document.getElementById('<%= txtName.ClientID %>').value = "";
                    document.getElementById('<%= txtClientAttributes.ClientID %>').value = "";
                    document.getElementById('<%= txtValue.ClientID %>').value = "";                     
                    document.getElementById('<%= ddlRateType.ClientID %>').value = document.getElementById('<%= hdnddlTPARateID.ClientID %>').value;
                    document.getElementById('<%= ddlRate.ClientID %>').value = "1";
                    document.getElementById('<%= ddlClientTypes.ClientID %>').value = "1";
                    document.getElementById('<%= bsave.ClientID %>').value = 'Save';
                    
                    document.getElementById('tblClientAttributes').value = '';
                    //document.getElementById('tblClientAttributes').innerHTML = '';
                    document.getElementById('hdnClientAttributes').value = '';
                    document.getElementById('tblClientAttributes').style.display = 'none';
                    document.getElementById('tdload').style.display = 'none';
                    
                    document.getElementById('tblAttributes').value = '';
                    //document.getElementById('tblAttributes').innerHTML = '';
                    document.getElementById('tblAttributes').style.display = 'none';
                }
            }
            else {
                if (document.getElementById('<%= rdoTPA.ClientID %>').checked) {
                    document.getElementById('<%= rdoClient.ClientID %>').checked = true;
                }
                else {
                    document.getElementById('<%= rdoTPA.ClientID %>').checked = true;
                }
                return false;
            }
        }
        
        function InPageValidation() {
            if (document.getElementById('<%=txtName.ClientID %>').value == '') {
                alert('Provide the name');
                document.getElementById('<%=txtName.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%=bsave.ClientID %>').value != 'Update') {
                document.getElementById('<%= hdID.ClientID %>').value = '0';
                document.getElementById('<%= hdnTPA.ClientID %>').value = "";
                document.getElementById('<%= hdnClient.ClientID %>').value = "";
            }

            if (document.getElementById('<%= rdoClient.ClientID %>').checked) {
                // commented with respect to vijay request by mohan
                //                if (document.getElementById('<%=ddlRate.ClientID %>').value == "--Select-->") {
                //                    alert('Select the Rate Type');
                //                    return false;
                //                }

                if (document.getElementById('<%=ddlRateType.ClientID %>').value == "0") {
                    alert('Select the Rate');
                    return false;
                }

            }
        }

        //       


        function LoadOrdItemsCorp(AttribValue) {
            //alert('begin :'+AttribValue);
            var HidValue = "";
            if (AttribValue == '') {
                //var HidValue = document.getElementById('<%= hdnAttributes.ClientID %>').value;
                var otable = document.getElementById('tblAttributes');
                while (otable.rows.length > 1)
                    otable.deleteRow(otable.rows.length - 1);
                document.getElementById('tblAttributes').style.display = 'none';
                document.getElementById('<%= hdnAttributes.ClientID %>').value = "";
            }
            else {
                //alert('else '+AttribValue);
                document.getElementById('<%= hdnAttributes.ClientID %>').value = AttribValue;
                HidValue = AttribValue;
                var otable = document.getElementById('tblAttributes');
                while (otable.rows.length > 1)
                    otable.deleteRow(otable.rows.length - 1);
            }
            var list = HidValue.split('^');
            var total = 0, rate;
            // alert(HidValue);
            if (HidValue != '') {
                // alert('else 2 ' + AttribValue);
                for (var count = 0; count < list.length - 1; count++) {
                    var InvesList = list[count].split('~');
                    //total = document.getElementById('InvestigationControl1_lblTotal').innerHTML;
                    var row = document.getElementById('tblAttributes').insertRow(1);
                    row.id = InvesList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    // var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclick(" + InvesList[0] + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = InvesList[1];
                    cell3.innerHTML = InvesList[2];
                    cell4.innerHTML = InvesList[3];
                    // alert(InvesList[2]);
                }
                document.getElementById('tblAttributes').style.display = 'block';

            }
            //alert(document.getElementById('<%= hdnAttributes.ClientID %>').value);
            if (document.getElementById('<%= hdnAttributes.ClientID %>').value == '') {

                document.getElementById('tblAttributes').style.display = 'none';
                document.getElementById('tdload').style.display = 'none';
            }
        }
        function loaddata(obj) {
            if (obj != "") {
                var hdn = document.getElementById('hdnRate');
                hdn.value = 0;
                hdn.value = obj;
            }
        }

        function createClienttab() {
            //debugger;
            var ddllist = window.document.getElementById('<%=ddlClientTypes.ClientID%>');
            var itemName= ddllist.options[ddllist.selectedIndex].value;
            var j = 1;
            var obj = document.getElementById('<%=ddlClientTypes.ClientID%>');
            var i = obj.getElementsByTagName('OPTION');
            var AddStatus = 0;
            var Attributes = document.getElementById('txtClientAttributes').value;
            var Value = document.getElementById('txtValue').value;
            var rwNumber = obj.options[obj.selectedIndex].value;
            var Type = obj.options[obj.selectedIndex].text;
            //document.getElementById('tblAttributes').style.display = 'block';
            var HidValue = document.getElementById('hdnClientAttributes').value;
            // var txtvalue = document.getElementById('hdntxtvalue').value;
            var list = HidValue.split('^');
            //var clientvalue = txtvalue.split('^');
            if (document.getElementById('hdnClientAttributes').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var SpecialityList = list[count].split('~');
                    if (SpecialityList[1] != '') {
                        if (SpecialityList[0] != '') {
                            rwNumber = parseInt(parseInt(SpecialityList[0]) + parseInt(1));
                        }
                        if (Attributes != '') {
                            if (SpecialityList[1] == Attributes) {
                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                if (Attributes != '') {
                    var row = document.getElementById('tblClientAttributes').insertRow(1);
                    //rwNumber = Attributes + rwNumber;
                    row.id = rwNumber;
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    //alert("rwNumber:" + rwNumber);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickClient(" + rwNumber + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "10%";
                    cell2.innerHTML = "<b>" + Attributes + "</b> ";
                    cell2.width = "45%";
                    cell3.innerHTML = "<b>" + Type + "</b> ";
                    cell3.width = "45%";
                    cell4.innerHTML = "<b>" + Value + "</b> ";
                    cell4.width = "45%";

                    document.getElementById('hdnClientAttributes').value += rwNumber + "~" + Attributes + "~" + Type + "~" + Value + "^";
                    //alert(document.getElementById('hdnAttributes').value);
                    AddStatus = 2;
                    document.getElementById('tblClientAttributes').style.display = 'block'
                    j++;
                }
                else {
                    alert('Provide attribute to add');
                }
            }
            if (AddStatus == 0) {
                if (Attributes != '') {
                    var row = document.getElementById('tblClientAttributes').insertRow(1);
                    //alert("rwNumber1:" + rwNumber);
                    //rwNumber = Attributes + rwNumber;
                    row.id = rwNumber;
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    //alert("rwNumber1:" + rwNumber);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickClient(" + rwNumber + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = "<b>" + Attributes + "</b> ";
                    cell3.innerHTML = "<b>" + Type + "</b>";
                    cell4.innerHTML = "<b>" + Value + "</b>";
                    j++;
                    document.getElementById('hdnClientAttributes').value += rwNumber + "~" + Attributes + "~" + Type + "~" + Value + "^";
                    document.getElementById('tblClientAttributes').style.display = 'block';
                }
                else {
                    alert('Provide attribute to add');
                }
            }
            else if (AddStatus == 1) {
                alert('Attribute already added');
            }
            //        alert(document.getElementById('PackageProfileControl_hdnSpecialityItems').value);
            return;
        }

        function ImgOnclickClient(ImgID) {
            //alert(ImgID);
             
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnClientAttributes').value;
            var list = HidValue.split('^');
            var NewHealthCheckupList = '';
            if (document.getElementById('hdnClientAttributes').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HealthCheckupList = list[count].split('~');
                    if (HealthCheckupList[0] != '') {
                        if (HealthCheckupList[0] != ImgID) {
                            NewHealthCheckupList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnClientAttributes').value = NewHealthCheckupList;
            }
            if (document.getElementById('hdnClientAttributes').value == '') {
                document.getElementById('hdnClientAttributes').style.display = 'none';
                document.getElementById('tdload').style.display = 'none';
            }
        }

        function SetClientId(Id, ClientName, ClientID, AttribValue, Rate, RateType) {
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(Id).checked = true;
            var ctrl;
            ctrl = document.getElementById('obj')

            document.getElementById('<%= hdnClient.ClientID %>').value = ClientID;
            //alert(document.getElementById('<%= hdnClient.ClientID %>'));
            document.getElementById('<%= txtName.ClientID %>').value = ClientName;

            // document.getElementById('<%= lbl_Type.ClientID %>').value = 'Enter the Client Name';
            document.getElementById('<%= rdoClient.ClientID %>').checked = true;
            document.getElementById('<%= rdoTPA.ClientID %>').checked = false;
            document.getElementById('<%= ddlRateType.ClientID %>').value = Rate;
            document.getElementById('<%= bsave.ClientID %>').value = 'Update';
            document.getElementById('<%= rdoClient.ClientID %>').disabled = false;
            document.getElementById('<%= rdoTPA.ClientID %>').disabled = false;

            var objddlratetype = document.getElementById('<%=ddlRate.ClientID %>');
            for (var i = 0; i < objddlratetype.options.length; i++) {
                if (objddlratetype.options[i].text == RateType) {
                    objddlratetype.options[i].selected = true;

                }

            }

            LoadOrdItemsClient(AttribValue);
            ChkSelectTypeAll();
        }
        function LoadOrdItemsClient(AttribValue) {
            // alert(AttribValue);
            var HidValue;
            if (AttribValue == "") {
                //var HidValue = document.getElementById('<%= hdnClientAttributes.ClientID %>').value;
                HidValue = "";
                var otable = document.getElementById('tblClientAttributes');
                while (otable.rows.length > 1)
                    otable.deleteRow(otable.rows.length - 1);
                document.getElementById('tblClientAttributes').style.display = 'none';
                document.getElementById('<%= hdnClientAttributes.ClientID %>').value = "";

            }
            else {
                document.getElementById('<%= hdnClientAttributes.ClientID %>').value = AttribValue;
                HidValue = AttribValue;
                var otable = document.getElementById('tblClientAttributes');
                while (otable.rows.length > 1)
                    otable.deleteRow(otable.rows.length - 1);
            }
            var list = HidValue.split('^');
            var total = 0, rate;
            // alert(HidValue);
            if (HidValue != "") {

                for (var count = 0; count < list.length - 1; count++) {
                    var InvesList = list[count].split('~');
                    //total = document.getElementById('InvestigationControl1_lblTotal').innerHTML;
                    var row = document.getElementById('tblClientAttributes').insertRow(1);

                    row.id = InvesList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    // var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickClient(" + InvesList[0] + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = InvesList[1];
                    cell3.innerHTML = InvesList[2];
                    cell4.innerHTML = InvesList[3];
                    // alert(InvesList[2]);
                }
                document.getElementById('tblClientAttributes').style.display = 'block';
            }

        }
    </script>

    <%--<script language="javascript" type="text/javascript">
         LoadOrdItemsCorp();
    </script>--%>
    </form>
</body>
</html>
