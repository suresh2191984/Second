<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MappingInvtoGrp.aspx.cs" Inherits="Admin_MappingInvtoGrp" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mapping Inv to Group</title>
    <%--<link href="../StyleSheets/Style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" type="text/javascript"></script>    
    <script language="javascript" type="text/javascript">
        function winClose() {

            window.close();
        }
        function chkonchange() {

            var tableBody = document.getElementById('chklstGrp').childNodes[0];
            var j = 0;
            for (var i = 0; i < tableBody.childNodes.length; i++) {
                var currentTd = tableBody.childNodes[i].childNodes[0];
                var listControl = currentTd.childNodes[0];
                if (listControl.checked == true) {
                    j = j + 1;
                }
            }
            if (j == 0) {
                alert('Select the items in investigation master');
                return false;
            }
        }
        function chklstonchange() {

            var tableBody = document.getElementById('chkGrpMap').childNodes[0];
            var j = 0;
            for (var i = 0; i < tableBody.childNodes.length; i++) {
                var currentTd = tableBody.childNodes[i].childNodes[0];
                var listControl = currentTd.childNodes[0];
                if (listControl.checked == true) {
                    j = j + 1;
                }
            }
            if (j == 0) {
                alert('Select the items in investigation mapping');
                return false;
            }
        }

        function validation() {
            var tableBody = document.getElementById('chkGrpMap').childNodes[0];
            var j = 0;
            for (var i = 0; i < tableBody.childNodes.length; i++) {
                var currentTd = tableBody.childNodes[i].childNodes[0];
                //alert(currentTd);                         ;
            }        
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>           
               
    <asp:Panel ID="pnlGRP" CssClass="dataheader2" BorderWidth="1px" runat="server">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                            <div id="divInvGp" runat="server">
                                <table border="1" cellpadding="0" width="80%">
                                 <tr>
                                                    <td>
                                                        UnMapped Investigation
                                                   
                                                        <asp:TextBox ID="txtInvestigationName" runat="server"  CssClass="Txtboxsmall" ></asp:TextBox>
                                                   
                                                        <asp:Button ID="btnSearch" Text="Search" runat="server" class="btn" onmouseout="this.className='btn'"
                                                            onmouseover="this.className='btn btnhov'" OnClick="btnSearch_Click" />
                                                    </td>
                                                    <td>
                                                    </td>
                                                    
                                                    <td>
                                                      Mapped Investigation
                                                        <asp:TextBox ID="txtInvname" runat="server" CssClass ="Txtboxsmall" ></asp:TextBox>
                                                    
                                                        <asp:Button ID="btnfind" Text="Search" runat="server" class="btn" onmouseout="this.className='btn'"
                                                            onmouseover="this.className='btn btnhov'" onclick="btnfind_Click"   />
                                                    </td>
                                                </tr>
                                <tr>
                                <td >
                                    Master Investigation</td>
                                <td>
                                </td>
                                <td >
                                    Investigation Mapped to <asp:label id="lbl_id"  runat="server">
                                    </asp:label>
                                    </td>
                                </tr>
                                    <tr>
                                        <td style="height:51px;">
                                         <div style="overflow:auto; border:2px; border-color:#fff;  height:180px;" class="ancCSviolet">
                                            <asp:CheckBoxList ID="chklstGrp" runat="server" Height="51px" Width="270px" 
                                                 Font-Size="Small" >
                                            </asp:CheckBoxList>
                                            </div>
                                        </td>
                                        <td >
                                        <table>
                                        <tr>
                                        <td>
                                            <asp:HiddenField ID="hdnInv" runat="server" />
                                             <asp:HiddenField ID="hdnRemoveInv" runat="server" />
                                            <asp:Button ID="btnGrpAdd" runat="server" class="btn" 
                                                 Text="&gt;&gt;" OnClientClick="javascript:return chkonchange();" onclick="btnGrpAdd_Click" 
                                                 />
                                        </td>
                                        </tr>
                                        <tr>
                                        <td align="center" style="height: 15px">
                                            
                                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                                <ProgressTemplate>
                                                    <asp:Image ID="Img1" ImageUrl="~/Images/ajax-loader.gif" runat="server" 
                                                        Height="33px" Width="50px" />Please Wait...
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                        </td>
                                    </tr>
                                        <tr>
                                        <td>
                                            <asp:Button ID="btnGrpRemove" runat="server" class="btn" 
                                                Text="&lt;&lt;"  OnClientClick="javascript:return chklstonchange();"  onclick="btnGrpRemove_Click" 
                                                 />
                                        </td>
                                        </tr>
                                        </table>
                                        </td>
                                        <td>
                                         <div style="overflow: scroll; border:1px 1px 1px 1px; border-color:Red;height:180px;">
                                      <asp:CheckBoxList ID="chkGrpMap" runat="server" Height="51px" 
                                                Width="270px" Font-Size="Small"> 
                                                 
                                            </asp:CheckBoxList>
                                            </div>
                                        </td>
                                    </tr>
                                    </table>  
                                    
                                    <table border="1" cellpadding="0" width="100%">
                                    <tr>                                    
                                    <td width="10%">                                    
                                    </td>
                                <td width="20%">
                                <asp:Button ID="btnSave" runat="server" Text="Save & Continue" class="btn" onmouseout="this.className='btn'"
                                        onmouseover="this.className='btn btnhov'" OnClientClick="javascript:validation();" onclick="btnSave_Click"  />                                                                    
                                    <a style="cursor: pointer; text-decoration: none; font-weight: bold; color: Blue;"
            href="javascript:winClose();">Close Window </a>
                                    <asp:HiddenField ID="Hdngid" runat="server" />
                                    <asp:HiddenField ID="HdnMap" runat="server" />
                                    <asp:HiddenField ID="HdnAdd" runat="server" />
                                    <asp:HiddenField ID="HdnRemove" runat="server" />
                            </table>
                                       </td>
                                   
                                    </tr>                                    
                                                              
                            </div>
                            </ContentTemplate>
                             </asp:UpdatePanel>
                        </asp:Panel>
    </form>
    <input type="hidden" id="hdnStatus" runat="server" value="before" />
    </body>
   <%-- <script language="javascript" type="text/javascript">
    popupclose();

    function popupclose() {
      
        if (document.getElementById("hdnStatus").value == "after") {
            window.close();
            return true;
        }
    }
    </script>--%>

</html>
