<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SequenceArrangement.ascx.cs"
    Inherits="CommonControls_SequenceArrangement" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<script src="../Scripts/MessageHandler.js" type="text/javascript"></script>


<style type="text/css">
    .style1
    {
        width: 248px;
    }
    #Sequence1_TabContainer1_body { border:none!important;}
</style>

<script type="text/javascript" language="javascript">

  
    
    var UserHeaderText = SListForAppMsg.Get('CommonControls_SequenceArrangement_ascx_0044') == null ? "Alert" : SListForAppMsg.Get('CommonControls_SequenceArrangement_ascx_0044');
    var alertdisplay1 = SListForAppMsg.Get('CommonControls_SequenceArrangement_ascx_0045') == null ? "Select department name !!" : SListForAppMsg.Get('CommonControls_SequenceArrangement_ascx_0045');
    var alertdisplay2 = SListForAppMsg.Get('CommonControls_SequenceArrangement_ascx_0046') == null ? "Provide department name !!" : SListForAppMsg.Get('CommonControls_SequenceArrangement_ascx_0046');
    var alertdisplay3 = SListForAppMsg.Get('CommonControls_SequenceArrangement_ascx_0047') == null ? "Provide department Code !!" : SListForAppMsg.Get('CommonControls_SequenceArrangement_ascx_0047');
    var alertdisplay4 = SListForAppMsg.Get('CommonControls_SequenceArrangement_ascx_0048') == null ? "Please Select The Role" : SListForAppMsg.Get('CommonControls_SequenceArrangement_ascx_0048');
    var alertdisplay5 = SListForAppMsg.Get('CommonControls_SequenceArrangement_ascx_0049') == null ? "Please select the department" : SListForAppMsg.Get('CommonControls_SequenceArrangement_ascx_0049');
    
    function SelectInvSeqRowCommon(rid) {
        var len = document.forms[0].elements.length;
        for (var i = 0; i < len; i++) {
            if (document.forms[0].elements[i].type == "radio") {
                document.forms[0].elements[i].checked = false;
            }
        }
        document.getElementById(rid).checked = true;
    }



 

   
</script>

<table class="w-100p">
    <tr>
        <td>
            <asp:UpdatePanel ID="upd" runat="server">
                <ContentTemplate>
                    <ajc:TabContainer ID="TabContainer1" runat="server"
                  
                        AutoPostBack="True" Width="848px" 
                meta:resourcekey="TabContainer1Resource1">
                        <ajc:TabPanel ID="Sequencetab" runat="server" CssClass="dataheadergroup" 
                            HeaderText="Group Sequence Number" meta:resourcekey="SequencetabResource1">
                            <HeaderTemplate>
                                <%--Group Sequence Number--%>
                                
                                <%=Resources.CommonControls_ClientDisplay.CommonControls_SequenceArrangement_ascx_01%>
                            </HeaderTemplate>
                            <ContentTemplate>
                                <asp:UpdatePanel ID="UpdatePanel" runat="server">
                                    <ContentTemplate>
                                        <table class="w-100p">
                                            <tr>
                                                <td class="a-right style1">
                                                    <asp:Label ID="lbldptname" Text="Select Group Name" runat="server" Font-Bold="True"
                                                        Font-Size="Small" meta:resourcekey="lbldptnameResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddldptname" runat="server" CssClass="ddlsmall" AutoPostBack="True"
                                                        OnSelectedIndexChanged="ddldptname_SelectedIndexChanged" 
                                                        meta:resourcekey="ddldptnameResource1">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                        <div id="gv" runat="server" style="overflow: scroll; display: none">
                                            <asp:GridView ID="gvReckon" EmptyDataText="No matching records found " runat="server"
                                                AutoGenerateColumns="False" GridLines="Both" AllowPaging="false"
                                                ForeColor="#333333" CellPadding="3" OnRowDataBound="Gvbound" OnRowCommand="gvReckon_RowCommand"
                                                OnRowCancelingEdit="gvReckon_RowCancelingEdit" CssClass="w-90p gridView" 
                                                meta:resourcekey="gvReckonResource1">
                                                <Columns>
                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <asp:RadioButton ID="rdbcheck" runat="server" 
                                                                meta:resourcekey="rdbcheckResource1" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField HeaderText="SequenceNo" Visible="False" DataField="SequenceNo" 
                                                        meta:resourcekey="BoundFieldResource1" />
                                                    <asp:BoundField HeaderText="InvestigationID" Visible="False" 
                                                        DataField="InvestigationID" meta:resourcekey="BoundFieldResource2" />
                                                    <asp:BoundField HeaderText="GroupContent" DataField="InvestigationName" 
                                                        meta:resourcekey="BoundFieldResource3" />
                                                    <asp:BoundField HeaderText="Type" DataField="Type" 
                                                        meta:resourcekey="BoundFieldResource4" />
                                                    <asp:TemplateField HeaderText="Print Separately" 
                                                        meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkPrintSeparately" runat="server" AutoPostBack="True" 
                                                                OnCheckedChanged="ChkPrintSeparately_CheckedChanged" 
                                                                meta:resourcekey="chkPrintSeparatelyResource1" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Select" 
                                                        meta:resourcekey="TemplateFieldResource3">
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="btnUp" ImageUrl="~/Images/UpArrow.png" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                CommandName="UP" meta:resourcekey="btnUpResource1" />
                                                            <asp:ImageButton ID="btnDown" ImageUrl="~/Images/DownArrow.png" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                CommandName="DOWN" meta:resourcekey="btnDownResource1" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Move" meta:resourcekey="TemplateFieldResource4">
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnmove" runat="server" CssClass="btn" Text="Move Here" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" CommandName="Move" 
                                                                CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' 
                                                                meta:resourcekey="btnmoveResource1" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <HeaderStyle CssClass="dataheader1" />
                                            </asp:GridView>
                                            <table class="w-100p" id="tprint" runat="server">
                                                <tr id="Tr2" runat="server">
                                                    <td id="Td3" class="a-center" runat="server">
                                                        <asp:Button ID="btnSequenceSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" OnClick="btnSequenceSave_Click" meta:resourcekey="btnSequenceSaveResource4"/>
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:HiddenField ID="HdnDeptvalid" runat="server" />
                                            <asp:HiddenField ID="HdnHeadvalid" runat="server" />
                                            <asp:HiddenField ID="HdnLoad" runat="server" />
                                            <asp:HiddenField ID="HdnUpdateDept" runat="server" />
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </ContentTemplate>
                        </ajc:TabPanel>
                        /////////////////////////////
                        
                                     <ajc:TabPanel ID="TabPanel3" runat="server" 
                            CssClass="dataheadergroup" HeaderText="Group Sequence Number" 
                            meta:resourcekey="TabPanel3Resource1">
                            <HeaderTemplate>
                                <%--Package Sequence--%>
                                <%=Resources.CommonControls_ClientDisplay.CommonControls_SequenceArrangement_ascx_02%>
                            </HeaderTemplate>
                            <ContentTemplate>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <table border="0" cellpadding="0" width="100%">
                                            <tr>
                                                <td align="right" class="style1">
                                                    <asp:Label ID="Label2" Text="Select Package Name" runat="server" Font-Bold="True"
                                                        Font-Size="Small" meta:resourcekey="Label2Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlpkgname" runat="server" CssClass="ddl" AutoPostBack="True"
                                                        OnSelectedIndexChanged="ddlpkgname_SelectedIndexChanged" 
                                                        meta:resourcekey="ddlpkgnameResource1">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                        <div id="gv1" runat="server" style="overflow: scroll; display: none">
                                            <asp:GridView ID="gvReckonPkg" EmptyDataText="No matching records found " runat="server"
                                                AutoGenerateColumns="False" GridLines="Both" Width="90%" AllowPaging="false"
                                                ForeColor="#333333" CellPadding="3" OnRowDataBound="Gvbound" OnRowCommand="gvReckonPkg_RowCommand"
                                                OnRowCancelingEdit="gvReckon_RowCancelingEdit" 
                                                meta:resourcekey="gvReckonPkgResource1">
                                                <Columns>
                                                    <asp:TemplateField meta:resourcekey="TemplateFieldResource5">
                                                        <ItemTemplate>
                                                            <asp:RadioButton ID="rdbcheck" runat="server" 
                                                                meta:resourcekey="rdbcheckResource2" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField HeaderText="SequenceNo" Visible="False" DataField="SequenceNo" 
                                                        meta:resourcekey="BoundFieldResource5" />
                                                    <asp:BoundField HeaderText="InvestigationID" Visible="False" 
                                                        DataField="InvestigationID" meta:resourcekey="BoundFieldResource6" />
                                                    <asp:BoundField HeaderText="GroupContent" DataField="InvestigationName" 
                                                        meta:resourcekey="BoundFieldResource7" />
                                                    <asp:BoundField HeaderText="Type" DataField="Type" 
                                                        meta:resourcekey="BoundFieldResource8" />
                                                    <asp:TemplateField HeaderText="Print Separately" 
                                                        meta:resourcekey="TemplateFieldResource6">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkPrintSeparately" runat="server" AutoPostBack="True" 
                                                                OnCheckedChanged="ChkPrintSeparatelypackage" 
                                                                meta:resourcekey="chkPrintSeparatelyResource2" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Select" 
                                                        meta:resourcekey="TemplateFieldResource7">
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="btnUp" ImageUrl="~/Images/UpArrow.png" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                CommandName="UP" meta:resourcekey="btnUpResource2" />
                                                            <asp:ImageButton ID="btnDown" ImageUrl="~/Images/DownArrow.png" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'
                                                                CommandName="DOWN" meta:resourcekey="btnDownResource2" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Move" meta:resourcekey="TemplateFieldResource8">
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnmove" runat="server" CssClass="btn" Text="Move Here" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" CommandName="Move" 
                                                                CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' 
                                                                meta:resourcekey="btnmoveResource2" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <HeaderStyle CssClass="dataheader1" />
                                            </asp:GridView>
                                            <table width="100%" cellpadding="5" id="Table2" runat="server" cellspacing="0" border="0">
                                                <tr id="Tr3" runat="server">
                                                    <td id="Td4" align="center" runat="server">
                                                        <asp:Button ID="btnsavepkg" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                            onmouseout="this.className='btn'" OnClick="btnpkgSequenceSave_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:HiddenField ID="HiddenField5" runat="server" />
                                            <asp:HiddenField ID="HiddenField6" runat="server" />
                                            <asp:HiddenField ID="HiddenField7" runat="server" />
                                            <asp:HiddenField ID="HiddenField8" runat="server" />
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </ContentTemplate>
                        </ajc:TabPanel>
                        
                        
                        
                        
                        
                        //////////////////////////////////////////////
                      
                        
                    </ajc:TabContainer>
                </ContentTemplate>
            </asp:UpdatePanel>
        </td>
    </tr>
</table>
