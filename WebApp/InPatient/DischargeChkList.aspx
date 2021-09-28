<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DischargeChkList.aspx.cs" Inherits="InPatient_DischargeChkList" meta:resourcekey="PageResource1" culture="auto" uiculture="auto" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc121" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<%@ Register Src="../CommonControls/PrintIPAdmissionDetails.ascx" TagName="IPAdmDetails"
    TagPrefix="ucAdmDet" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title><link href="../Images/favicon.ico" rel="shortcut icon" />
        <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
           <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="../Scripts/Common.js"></script>
         <script src="../Scripts/MessageHandler.js" type="text/javascript"></script>
        <script type="text/javascript" src="../Scripts/bid.js"></script>
        <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">
            function avoiddoubleentry(btnID)
             {
                if (document.getElementById('txtDTDis').value == '')
                 {
                 
              var userMsg = SListForApplicationMessages.Get('InPatient\\DischargeChkList.aspx_1');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{

                alert('Provide the discharge datetime');
                return false ;
                }
                    document.getElementById('txtDTDis').focus();
                    return false;
                }
                }
            </script>
  
   
    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function avoiddoubleentry(btnID) {
            if (document.getElementById('txtDTDis').value == '') {
             var userMsg = SListForApplicationMessages.Get('InPatient\\DischargeChkList.aspx_2');
               if(userMsg !=null)
               {
               alert(userMsg);
               return false;
               }
               else{

                alert('Enter the Discharge DateTime');
                return false ;
                }
                document.getElementById('txtDTDis').focus();
                return false;
            }

            document.getElementById(btnID).style.display = 'none';
            return true;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scm" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc3:PatientHeader ID="patientHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc121:LeftMenu ID="LeftMenu1" runat="server" />
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
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="1">
                                            <asp:Label ID ="Rs_DateTimeDischarge" Text="Date & Time of Discharge" 
                                                runat="server" meta:resourcekey="Rs_DateTimeDischargeResource1" />
                                        </td>
                                        <td colspan="3">
                                            <asp:TextBox ID="txtDTDis" runat="server"  CssClass="Txtboxsmall" meta:resourcekey="txtDTDisResource1"></asp:TextBox>
                                            <a href="javascript:NewCal('txtDTDis','ddmmyyyy',true,12)">
                                                <img src="../Images/Calendar_scheduleHS.png" width="16" height="16" border="0" alt="Pick a date"></a>
                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Rs_TypeofDischarge" Text="Type of Discharge" runat="server" 
                                                meta:resourcekey="Rs_TypeofDischargeResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlTypeofDis" runat="server" CssClass ="ddlsmall"
                                                meta:resourcekey="ddlTypeofDisResource1">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:Label ID="Rs_Info" Text="Destination Post-Discharge" runat="server" 
                                                meta:resourcekey="Rs_InfoResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlDestPostDis" runat="server"  CssClass ="ddl"
                                                meta:resourcekey="ddlDestPostDisResource1">
                                                <asp:ListItem Selected="True" Text="--Select--" Value="0" 
                                                    meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                <asp:ListItem Text="Residence" Value="R" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                <asp:ListItem Text="Hospital" Value="H" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                <asp:ListItem Text="Out-of-City" Value="OC" 
                                                    meta:resourcekey="ListItemResource4"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Rs_ConditiononDischarge" Text="Condition on Discharge" 
                                                runat="server" meta:resourcekey="Rs_ConditiononDischargeResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCndOnDis" MaxLength="255" runat="server"  CssClass ="Txtboxsmall"
                                                meta:resourcekey="txtCndOnDisResource1"></asp:TextBox>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <asp:Label ID="Rs_DischargeCheckList" Text="Discharge Check List" 
                                                runat="server" meta:resourcekey="Rs_DischargeCheckListResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <asp:GridView ID="grdDisChkList" runat="server" CellPadding="4" AutoGenerateColumns="False"
                                                DataKeyNames="ChkLstID" Width="100%" ForeColor="#333333" CssClass="mytable1"
                                                OnRowDataBound="grdDisChkList_RowDataBound" 
                                                meta:resourcekey="grdDisChkListResource1">
                                                <HeaderStyle CssClass="dataheader1" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Select" 
                                                        meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="ChkSel" runat="server" ToolTip="Select Row" 
                                                                meta:resourcekey="ChkSelResource1" />
                                                        </ItemTemplate>
                                                        <ItemStyle Width="5%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="ChkListID" Visible="False" 
                                                        meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblChkLstID" runat="server" Text='<%# Bind("ChkLstID") %>' 
                                                                meta:resourcekey="lblChkLstIDResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="5%" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="ChkLstDesc" HeaderText="CheckList Description" 
                                                        meta:resourcekey="BoundFieldResource1">
                                                        <ItemStyle HorizontalAlign="Left" Wrap="False" Width="25%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Comments" 
                                                        meta:resourcekey="TemplateFieldResource3">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtReason" runat="server" MaxLength="255" 
                                                                meta:resourcekey="txtReasonResource1" />
                                                        </ItemTemplate>
                                                        <ItemStyle Width="20px" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" 
                                                        meta:resourcekey="imgProgressbarResource1" />
                                             <asp:Label ID="lbplswait" runat="server" Text="Please wait...." 
                                                        meta:resourcekey="lbplswaitResource1"></asp:Label>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnSubmit" Text="Submit" runat="server" Enabled="False" CssClass="btn"
                                                onmouseover="this.className='btn1 btnhov1'" OnClientClick="return avoiddoubleentry(this.id);"
                                                onmouseout="this.className='btn1'" OnClick="btnSubmit_Click" 
                                                meta:resourcekey="btnSubmitResource1" />
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
          <asp:HiddenField ID="hdnMessages" runat="server" />
    </div>
    </form>
</body>
</html>
