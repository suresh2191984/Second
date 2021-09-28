<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EditEMR.ascx.cs" Inherits="EMR_EditEMR" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asd" %>

<script type="text/javascript" language="javascript">
    var gvvalue;
    function pUpdateItem(obj, val) {
        var i = 0;
        var value = 'tcEMR';
        var str = val.split('_');
        for (var i = 1; i < str.length - 2; i++) {
            value = value + '_' + str[i];
        }        
        var attribute = value;   
       
        var basegrid = document.getElementById(attribute);
        if (basegrid != null) {
            i = document.getElementById(attribute).rows.length;
            if (i < 10) {
                i = "0" + i;
            }

            document.getElementById(attribute + '_ctl' + i + '_txtattribute').value = obj.cname;
            document.getElementById(attribute + '_ctl' + i + '_hdnattribute').value = obj.cid;
            document.getElementById(attribute + '_ctl' + i + '_btnsave').value = 'Update';
            }
        }

        function pInsertItem(obj, val) {
           var i = 0;
           var value = 'tcEMR';
        var str = val.split('_');
        for (var i = 1; i < str.length - 2; i++) {
            value = value + '_' + str[i];
        }        
        var attribute = value;
        var basegrid = document.getElementById(attribute);
        if (basegrid != null) {
            i = document.getElementById(attribute).rows.length;
            if (i < 10) {
                i = "0" + i;
            }
            
            if (document.getElementById(attribute + '_ctl' + i + '_txtattribute').value == "") {
                alert('Enter the Type');
                return false;
            }                      
            }              
        }
    function fClear(val) {
        var i = 0;
        var value = 'tcEMR';
        var str = val.split('_');
        for (var i = 1; i < str.length - 2; i++) {
            value = value + '_' + str[i];
        }
        var attribute = value;
        i = document.getElementById(attribute).rows.length;
        if (i < 10) {
            i = "0" + i;
        }
        document.getElementById(attribute + '_ctl' + i + '_btnsave').value = 'Save';
        document.getElementById(attribute + '_ctl' + i + '_txtattribute').value = '';
        document.getElementById(attribute + '_ctl' + i + '_hdnattribute').value = '';
        //document.getElementById(attribute + '_ctl' + i + '_hdnattributeID').value = '';            
    }    
</script>
<div>
    <table width="100%">
        <tr>
            <td>
                <%--<input id='lnktype' value = 'Show' runat="serer" type='button' onclick="showModalPopupViaClient();" style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>--%>
                <asp:LinkButton ID="lbtnShow" runat="server" ForeColor="Blue" 
                    meta:resourcekey="lbtnShowResource1">Edit</asp:LinkButton>
                <asp:HiddenField ID="hdnAttributeID" runat="server" />
                <asp:HiddenField ID="HiddenField1" runat="server" />                 
            </td>
        </tr>
    </table>
</div>
<asd:ModalPopupExtender ID="ModalPopupExtender1"  runat="server" TargetControlID="lbtnShow"
    PopupControlID="Panel1" BackgroundCssClass="modalBackground"
    CancelControlID="btnClose" DynamicServicePath="" Enabled="True" />
    <asp:UpdatePanel ID="updpnl" runat="server">
    <ContentTemplate>
    <div id="divid">
        
<asp:Panel ID="Panel1" runat="server" cssClass="modalPopup dataheaderPopupdup" Width="50%"
    Style="display: none" meta:resourcekey="Panel1Resource1">
    <div>
        <table width="100%">
            <tr>
                <td>
                    <asp:Label ID="lblexamination" Visible="false" runat="server" 
                        meta:resourcekey="lblexaminationResource1"></asp:Label>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:Label ID="lblskin" runat="server" meta:resourcekey="lblskinResource1"></asp:Label>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td>
                    <asp:Label ID="lbltype" runat="server" meta:resourcekey="lbltypeResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                
                <td>
                </td>
                <td>
                </td>
                <td align="center">
                    <div style="overflow: auto;">                    
                        <asp:GridView ID="gvAttributes" CellSpacing="2" CellPadding="2" runat="server" 
                            AutoGenerateColumns="False" ShowFooter="True" 
                            OnRowCommand="gvAttributes_RowCommand" CssClass="mytable1"
                            Width="75%" meta:resourcekey="gvAttributesResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="Attribute" 
                                    meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAttributesID" runat="server" Visible="False" 
                                            Text='<%# Eval("AttributevalueID") %>' 
                                            meta:resourcekey="lblAttributesIDResource1"></asp:Label>
                                        <asp:Label ID="lblID" runat="server" Visible="False" 
                                            Text='<%# Eval("AttributeID") %>' meta:resourcekey="lblIDResource1"></asp:Label>
                                        <asp:Label ID="lblAttributes" runat="server" 
                                            Text='<%# Eval("AttributeValueName") %>' 
                                            meta:resourcekey="lblAttributesResource1"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtattribute" runat="server" 
                                            meta:resourcekey="txtattributeResource1"></asp:TextBox>
                                        <asp:HiddenField ID="hdnattribute" runat="server" />
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Action" 
                                    meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <input id="lnkedit" type="button" cname='<%#Eval("AttributeValueName") %>' cid='<%#Eval("AttributevalueID") %>' runat='server' value='Edit' onclick="pUpdateItem(this,this.id)"
                                            style='background-color: Transparent; color: Red; border-style: none; text-decoration: underline;
                                            cursor: pointer' />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Button ID="btnsave" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                            onmouseover="this.className='btn btnhov'" 
                                            OnClientClick="javascript:return pInsertItem(this,this.id)" 
                                            CommandName="ADD" 
                                            TabIndex="4" Text="Save" meta:resourcekey="btnsaveResource1" />
                                        <input type="button" id="btn" runat="server" value="Cancel" class="btn" onclick="fClear(this.id)" />
                                    </FooterTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="dataheader1" />
                        </asp:GridView>
                    </div>
                    </td>
            </tr>            
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td align="center">
                <%--<asp:UpdateProgress ID="UpdateProgress2" runat="server">
                  <ProgressTemplate>
                  <asp:Image ID="Img1" ImageUrl="~/Images/ajax-loader.gif" runat="server" Height="33px"
                                                             Width="50px" 
                          meta:resourcekey="Img1Resource1" />Please Wait...
                  </ProgressTemplate>
                     </asp:UpdateProgress>--%>
                </td>
                </tr>
                <tr>  
                <td>
                
                </td>
                <td>
                </td>              
                <td align="center">                  
                    <asp:Button ID="btnClose" runat="server" Width="50px" Text="Close" CssClass="btn"
                        onmouseover="this.className='btn btnhov'" OnClick="btnClose_Click" 
                        onmouseout="this.className='btn'" meta:resourcekey="btnCloseResource1" />
                </td>
            </tr>
            <tr id="show" runat="server" style="display:none">  
                <td runat="server">
                
                </td>
                <td runat="server">
                </td>              
                <td align="center" runat="server">                  
                    <asp:Label ID="lbltext" runat="server" Text="Already Exists" Font-Bold="True" 
                        Font-Size="Medium" ForeColor="Red"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
</asp:Panel>
</div>
</ContentTemplate>
</asp:UpdatePanel>
