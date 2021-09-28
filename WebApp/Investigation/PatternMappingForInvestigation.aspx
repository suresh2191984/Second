<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatternMappingForInvestigation.aspx.cs"
    Inherits="Investigation_PatternMappingForInvestigation" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
    <%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/SampleBillPrint.ascx" TagName="BillPrintControl"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/InvestigationSearchControl.ascx" TagName="InvestigationSearchControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>PatternMapping</title>
    
  
    <style type="text/css">
        #grdpat tr.rowHover:hover
        {
         background-color:ActiveBorder;
         font-family: Verdana;
         }
    </style>
    <style type="text/css">
        #grdptn tr.rowHover:hover
        {
         background-color:ActiveBorder;
         font-family: Verdana;
         }
    </style>

</head>
<body oncontextmenu="return true;">
    <form runat="server">
    <asp:ScriptManager ID="ScriptManager1" ScriptMode="Release" runat="server">
    </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <table class="w-100p" >
                            <tr>
                                <td class="a-left w-100p" style="background-color: White">
                                    <asp:RadioButton ID="rdoPattern" runat="server" GroupName="pattern"  
                                        onclick="javascript:checks('patwise');" meta:resourcekey="rdoPatternResource1"/>                                    
                                    <asp:Label ID="lblPattern" runat="server" Font-Names="Verdana" Text="PatternWise" meta:resourcekey="lblPatternResource1"></asp:Label>                               
                                    <asp:RadioButton ID="rdoInvestigation" runat="server" GroupName="pattern" 
                                        onclick="javascript:checks('invwise');" 
                                        meta:resourcekey="rdoInvestigationResource1"/>
                                    <asp:Label ID="lblInvwise" runat="server" Font-Names="Verdana" Text="InvestigationWise" meta:resourcekey="lblInvwiseResource1"></asp:Label>
                                </td>
                                <td>
                              </td>
                            </tr>                            
                        </table>
                        <div id="div1" runat="server" style="display: none;">
                        <asp:Updatepanel ID="PanelPattern" runat="server">
                        <ContentTemplate >
                        <table class="w-100p searchPanel">
                        <tr>
                        <td>
                        <asp:Label ID="lblInvSearch" Text="InvestigationName" Font-Names="Verdana" 
                                Font-Bold="True"  runat="server" meta:resourcekey="lblInvSearchResource1" ></asp:Label>
                        <asp:TextBox ID="txtSearch" runat="server" Font-Names="Verdana" 
                                meta:resourcekey="txtSearchResource1" ></asp:TextBox>
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" onmouseout="this.className='btn'" 
                        onmouseover="this.className='btn btnhov'" onclick="btnSearch_Click" 
                                meta:resourcekey="btnSearchResource1"/>
                        </td>
                        </tr>
                        <tr> 
                        <td>
                        <%--<asp:Label ID="lblStatus" Visible="false" runat="server" ForeColor="#333" Text="No Matching Records Found!"></asp:Label>--%>
                            <asp:GridView ID="grdpat" runat="server" CssClass="w-96p gridView m-auto" AllowPaging="true"  OnRowDataBound="grdpat_RowDataBound" 
                            BackColor="White" BorderColor="#CCCCCC" BorderStyle="Double"  BorderWidth="1px" OnRowCommand="grdpat_RowCommand"
                                CellPadding="2" Font-Names="Verdana" Font-Size="9pt" GridLines="Both" AutoGenerateColumns="false"
                                 pagesize="20" OnPageIndexChanging="grdpat_PageIndexChanging" EmptyDataText="No Matching Records Found!"  
                                 PagerStyle-ForeColor="black" RowStyle-CssClass="rowHover" ClientIDMode="Static" meta:resourcekey="grdpatResource1">
                                <RowStyle VerticalAlign="Top" ForeColor="#000066" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Select" HeaderStyle-BackColor="WhiteSmoke" 
                                        meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkSelect" runat="server"  AutoPostBack="false"   meta:resourcekey="chkSelectResource1"/>
                                            <br />
                                            <asp:HiddenField ID="hdnvalue" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="InvestigationID" 
                                        HeaderStyle-BackColor="WhiteSmoke" Visible="false" 
                                        meta:resourcekey="TemplateFieldResource2" >
                                        <ItemTemplate>
                                            <asp:Label ID="lblInvestigationNo" runat="server" 
                                                Text='<%# bind("InvestigationID") %>' 
                                                meta:resourcekey="lblInvestigationNoResource1" ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="InvestigationName" 
                                        HeaderStyle-BackColor="WhiteSmoke" meta:resourcekey="TemplateFieldResource3">
                                        <ItemTemplate>
                                            <asp:Label ID="lblInvestigationName" runat="server" 
                                                Text='<%# bind("InvestigationName") %>' 
                                                meta:resourcekey="lblInvestigationNameResource1" ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>                                                          
                                    <asp:TemplateField HeaderText="PatternName" HeaderStyle-BackColor="WhiteSmoke" 
                                        meta:resourcekey="TemplateFieldResource4">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlPattern" runat="server" AutoPostBack="True" 
                                                onchange="javascript:DropCheck(ddlLocID, chkSelID);" 
                                                meta:resourcekey="ddlPatternResource1">
                                           </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Report Template" 
                                        HeaderStyle-BackColor="WhiteSmoke" meta:resourcekey="TemplateFieldResource5">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlReportTemplate" runat="server" AutoPostBack="True" 
                                                meta:resourcekey="ddlReportTemplateResource1" >
                                           </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                   <asp:TemplateField HeaderText="Preview" HeaderStyle-BackColor="WhiteSmoke" 
                                        Visible="true" meta:resourcekey="TemplateFieldResource6">
                                    <ItemTemplate>                                    
                                    <asp:LinkButton ID="LinkPreview" runat="server" Text="Preview" ForeColor="Black" Font-Underline ="true" AutoPostBack="True";
                                     CommandName="Preview" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>' meta:resourcekey="LinkPreviewResource1">
                                     </asp:LinkButton>
                                    </ItemTemplate> 
                                    </asp:TemplateField>                               
                                </Columns>
                            </asp:GridView>
                            <div id="Div3" runat="server" style="display:block;">
                            
                         <ajc:ModalPopupExtender ID="ModalPopupExtender2" runat="server" TargetControlID="bttn"
                         PopupControlID="Panel2" BackgroundCssClass="modalBackground" DynamicServicePath=""
                         Enabled="True" CancelControlID="Button2"  ></ajc:ModalPopupExtender>
                         <input type="button"   id="bttn" runat="server" style="display:none;" />                         
                         <asp:Panel runat="server" ID="panel2" CssClass="modalPopup dataheaderPopup w-100p" 
                          Height="70%" ScrollBars="Vertical" style="position:fixed;top:100px; margin:auto;left:0;right:0;">                       
                         <asp:Button ID="Button2" runat="server" Text="OK" CssClass="btn" onmouseover="this.className='btn btnhov'"
                         onmouseout="this.className='btn'" meta:resourcekey="Button2Resource1" />
                         <input type="hidden" id="Hidden1" runat="server" />
                         </asp:Panel>                                                            
                         </div>
                            </td></tr>                                                                                                          
                            <tr>
                            <td class="a-center" >
                            <asp:Button runat="server" Text="Save" ID ="btnSave"  CssClass="btn" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" onclick="btnSave_Click" 
                                    meta:resourcekey="btnSaveResource1" />
                            <asp:Button ID="btnCancel" UseSubmitBehavior="true" runat="server" Text="Cancel"
                            ToolTip="Click here to Cancel, View the Home Page" Style="cursor: pointer;" CssClass="btn"
                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" 
                                    OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                            </td>
                            </tr>                                                                             
                           </table>                                                        
                           </ContentTemplate>
                        </asp:Updatepanel>                         
                        </div>
                        <div id="div2" runat="server" style="display:none;">
                        <asp:Updatepanel ID="paneldrop" runat="server">
                        <ContentTemplate>
                        <table class="w-100p searchPanel">
                        <tr>
                        <td>
                        <asp:Label ID="lblpatern" runat="server" Text="Select The PatternName"  Font-Bold="true"   Font-Names="Verdana" Font-Size="9pt" meta:resourcekey="lblpaternResource1"></asp:Label>
                        <asp:DropDownList ID="ddlpatternName" CssClass="ddlsmall" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlpatternName_SelectedIndexChanged"  meta:resourcekey="ddlpatternNameResource1"  >
                        </asp:DropDownList>
                        <asp:Button ID="PatternLoad" OnClick="PatternLoad_Click" Text="preview"  CssClass="btn"
                         runat="server" meta:resourcekey="PatternLoadResource1" />
                        </td>
                        
                        </tr>          
                        </table>                        
                        <asp:GridView ID="grdptn" runat="server" AutoGenerateColumns="false" AllowPaging="true" 
                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="Double" CssClass="w-75p gridView m-auto"   BorderWidth="1px"
                        CellPadding="2" Font-Names="Verdana" Font-Size="9pt" GridLines="Both" RowStyle-CssClass="rowHover"
                        ClientIDMode="Static" pagesize="20" OnPageIndexChanging="grdptn_PageIndexChanging" EmptyDataText="No Matching Records Found!"  
                        PagerStyle-ForeColor="black" meta:resourcekey="grdptnResource1">
                        <RowStyle VerticalAlign="Top" ForeColor="#000066" />
                        <Columns >
                        <asp:TemplateField HeaderText="InvestigationName" 
                                HeaderStyle-BackColor="WhiteSmoke" meta:resourcekey="TemplateFieldResource7">
                        <ItemTemplate >
                        <asp:Label ID="lblInvName" runat="server" Text='<%# Bind("InvestigationName") %>' 
                                meta:resourcekey="lblInvNameResource1"></asp:Label>
                        </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="InvestigationID" HeaderStyle-BackColor="WhiteSmoke" 
                                meta:resourcekey="TemplateFieldResource8">
                        <ItemTemplate >
                        <asp:Label ID="lblInvID" runat="server" Text='<%# Bind("InvestigationID") %>' 
                                meta:resourcekey="lblInvIDResource1"></asp:Label>
                        </ItemTemplate>
                        </asp:TemplateField>                                       
                        </Columns>
                        </asp:GridView>                        
                        <div id="Div4" runat="server" style="display:block;" >
                        <ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btn"
                         PopupControlID="Panel1" BackgroundCssClass="modalBackground"  DynamicServicePath=""
                         Enabled="True" CancelControlID="btnAttributeOk" />                         
                         <input type="button"  id="btn" runat="server" style="display:none;" />                         
                        <asp:Panel runat="server" ID="panel1" CssClass="modalPopup dataheaderPopup w-70p" 
                        Height="50%" ScrollBars="Vertical" style="position:fixed;top:200px; margin:auto;left:0;right:0;" >                       
                        <asp:Button ID="btnAttributeOk" runat="server"
                         Text="OK" CssClass="btn" onmouseover="this.className='btn btnhov'"
                        onmouseout="this.className='btn'" meta:resourcekey="btnAttributeOkResource1" />
                        <input type="hidden" id="hndControlID" runat="server" />
                        </asp:Panel>                        
                        </div>
                        <div id="paractice" runat="server" >                       
                        <ajc:Accordion  runat="server"  ID="MyAccordion"                        
                       SelectedIndex="0"
                        HeaderCssClass="accordionHeader"
                         HeaderSelectedCssClass="accordionHeaderSelected"
                         ContentCssClass="accordionContent"
                         AutoSize="None"
                        FadeTransitions="true"
                        TransitionDuration="250"
                        FramesPerSecond="40"
                        RequireOpenedPane="false"
                        SuppressHeaderPostbacks="true">
                        </ajc:Accordion>
                        </div>
                        </ContentTemplate>
                        </asp:Updatepanel>
                        </div>
                    </div>
         <Attune:Attunefooter ID="Attunefooter" runat="server" />      
    </form>
    <script language="javascript" type="text/javascript">
        //        function SelectInvSeqRowCommon(rid) {
        //            var len = document.forms[0].elements.length;
        //            for (var i = 0; i < len; i++) {
        //                if (document.forms[0].elements[i].type == "radio") {
        //                    document.forms[0].elements[i].checked = false;
        //                }
        //            }
        //            document.getElementById(rid).checked = true;
        //        }

        function DropCheck(ddlLocID, chkSelID) {
            document.getElementById(chkSelID).checked = true;

        }


        function checks(obj) {

            if (obj == "patwise") {

                document.getElementById('<%= div1.ClientID %>').style.display = 'none';
                document.getElementById('<%= div2.ClientID %>').style.display = 'block';

            }

            if (obj == "invwise") {
                document.getElementById('<%= div1.ClientID %>').style.display = 'block';
                document.getElementById('<%= div2.ClientID %>').style.display = 'none';

            }

        }

        
    </script>
</body>
</html>


