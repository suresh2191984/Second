<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientAccountInfo.aspx.cs"
    Inherits="PatientAccess_PatientAccountInfo" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/PatientAccessHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/PatientOrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Account Information</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
         <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
         <script src ="../scripts/MessageHandler.js" language ="javascript" type ="text/javascript" ></script>
              
    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
    var userMsg ;
        function fnSelectQuestion() {
            if (document.getElementById('ddlSecretQuestion').value == 'Userquestion') {
                document.getElementById('trUQ').style.display = "block";
            }
            else {
                document.getElementById('trUQ').style.display = "none";
            }


        }
        function chkValidation() {
            if (document.getElementById('txtOldpassword').value == '') {
              userMsg = SListForApplicationMessages.Get('PatientAccess\\PatientAccountInfo.aspx_1');
                      if(userMsg !=null)
                          {
                            alert (userMsg );
                             return false;
                             
                          }  
            else {              
                alert('Provide old password');
                 return false;
                }
                document.getElementById('txtOldpassword').focus();
                return false;
            }
            if (document.getElementById('txtNewpassword').value == '') {
             userMsg = SListForApplicationMessages.Get('PatientAccess\\PatientAccountInfo.aspx_2');
                      if(userMsg !=null)
                          {
                            alert (userMsg );
                             return false;
                          }  
            else {              
                alert('Provide new password');
                 return false;
                }
                document.getElementById('txtNewpassword').focus();
                return false;
            }

            if (document.getElementById('txtConfirmpassword').value == '') {
             userMsg = SListForApplicationMessages.Get('PatientAccess\\PatientAccountInfo.aspx_3');
                      if(userMsg !=null)
                          {
                            alert (userMsg );
                             return false;
                          }  
            else {              
                alert('Provide confirm password');
                 return false;
                }
                document.getElementById('txtConfirmpassword').focus();
                return false;
            }

            if (document.getElementById('txtOldpassword').value == document.getElementById('txtNewpassword').value) {
             userMsg = SListForApplicationMessages.Get('PatientAccess\\PatientAccountInfo.aspx_4');
                      if(userMsg !=null)
                          {
                            alert (userMsg );
                             return false;
                          }  
            else {              
                alert('New password and old password cannot be same');
                 return false;
                }
                document.getElementById('txtOldpassword').value = '';
                document.getElementById('txtNewpassword').value = '';
                document.getElementById('txtConfirmpassword').value = '';
                document.getElementById('txtOldpassword').focus();
                return false;
            }

            if (document.getElementById('txtNewpassword').value != document.getElementById('txtConfirmpassword').value) {
             userMsg = SListForApplicationMessages.Get('PatientAccess\\PatientAccountInfo.aspx_5');
                      if(userMsg !=null)
                          {
                            alert (userMsg );
                             return false;
                          }  
            else {              
                alert('There is a password mismatch');
                 return false;
                }
                document.getElementById('txtNewpassword').value = '';
                document.getElementById('txtConfirmpassword').value = '';
                document.getElementById('txtNewpassword').focus();
                return false;
            }
            if (document.getElementById('ddlSecretQuestion').value == '0') {
             userMsg = SListForApplicationMessages.Get('PatientAccess\\PatientAccountInfo.aspx_6');
                      if(userMsg !=null)
                          {
                            alert (userMsg );
                             return false;
                          }  
            else {              
                alert('Select a secret question');
                 return false;
                }
                document.getElementById('ddlSecretQuestion').focus();
                return false;
            }
            if (document.getElementById('ddlSecretQuestion').value == 'Userquestion') {
                if (document.getElementById('txtSecretQuestion').value == "") {
                 userMsg = SListForApplicationMessages.Get('PatientAccess\\PatientAccountInfo.aspx_7');
                      if(userMsg !=null)
                          {
                            alert (userMsg );
                             return false;
                          }  
            else {              
                alert('Provide a secret question');
                 return false;
                }
                    document.getElementById('txtSecretQuestion').focus();
                    return false;
                }
            }
            if (document.getElementById('txtSecretAnswer').value == "") {
             userMsg = SListForApplicationMessages.Get('PatientAccess\\PatientAccountInfo.aspx_8');
                      if(userMsg !=null)
                          {
                            alert (userMsg );
                             return false;
                          }  
            else {              
                alert('Provide a secret answer');
                 return false;
                }
                document.getElementById('txtSecretAnswer').focus();
                return false;
            }
            return true;

        }
    </script>

</head>
<body oncontextmenu="return false;">
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
                <uc3:Header ID="Header" runat="server" />
            </div>
            <div style="float: right; width: 1%;">
                <div class="Rightheader" />
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
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <top:topheader id="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table border="0" cellpadding="0" cellspacing="5" align="center" width="100%">
                            <tr>
                                <td colspan="3">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 17%" height="35" nowrap="nowrap">
                       <asp:Label ID="lboldpwd" runat="server" Text="Old Password" 
                                        meta:resourcekey="lboldpwdResource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:TextBox ID="txtOldpassword" runat="server"  CssClass ="Txtboxsmall" 
                                        TextMode="Password" meta:resourcekey="txtOldpasswordResource1"> &gt;</asp:TextBox>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 17%" height="35" nowrap="nowrap">
                           <asp:Label ID="lbnewpwd" runat="server" Text="New Password" 
                                        meta:resourcekey="lbnewpwdResource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNewpassword" runat="server" CssClass ="Txtboxsmall" 
                                        TextMode="Password" meta:resourcekey="txtNewpasswordResource1"></asp:TextBox>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 17%" height="35" nowrap="nowrap">
                           <asp:Label ID="lbcnfrmpwd" runat="server" Text="Confirm password" 
                                        meta:resourcekey="lbcnfrmpwdResource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:TextBox ID="txtConfirmpassword" runat="server" CssClass ="Txtboxsmall" 
                                        TextMode="Password" meta:resourcekey="txtConfirmpasswordResource1"></asp:TextBox>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 17%" height="35" nowrap="nowrap">
                               <asp:Label ID="lbsecretques" runat="server" Text="Secret Question" 
                                        meta:resourcekey="lbsecretquesResource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:DropDownList onChange="fnSelectQuestion();" ID="ddlSecretQuestion"  
                                        CssClass="ddllarge" runat="server" 
                                        meta:resourcekey="ddlSecretQuestionResource1">
                                        <asp:ListItem Value="0" Selected="True" meta:resourcekey="ListItemResource1">-- 
                                        Select One --</asp:ListItem>
                                        <asp:ListItem Value='What was the last name of your favorite teacher?' 
                                            meta:resourcekey="ListItemResource2">What was the last name of your favorite 
                                        teacher?</asp:ListItem>
                                        <asp:ListItem Value='What was the last name of your best childhood friend?' 
                                            meta:resourcekey="ListItemResource3">What was the last name of your best 
                                        childhood friend?
                                        </asp:ListItem>
                                        <asp:ListItem Value='What is the name of the hospital where you were born?' 
                                            meta:resourcekey="ListItemResource4">What is the name of the hospital where 
                                        you were born?
                                        </asp:ListItem>
                                        <asp:ListItem Value='Who is your all-time favorite movie character?' 
                                            meta:resourcekey="ListItemResource5">Who is your all-time favorite movie 
                                        character?
                                        </asp:ListItem>
                                        <asp:ListItem Value='Where did you meet your spouse?' 
                                            meta:resourcekey="ListItemResource6">Where did you meet your spouse?
                                        </asp:ListItem>
                                        <asp:ListItem Value='Userquestion' meta:resourcekey="ListItemResource7">-Type 
                                        your question here-
                                        </asp:ListItem>
                                    </asp:DropDownList>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                            </tr>
                            <tr id="trUQ" runat="server" style="display: none;">
                                <td align="left" style="width: 17%" height="35" nowrap="nowrap">
                                    <asp:Label ID="lbtypeques" runat="server" Text="Type Your Question" 
                                        meta:resourcekey="lbtypequesResource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSecretQuestion"  CssClass ="Txtboxlarge" runat="server" 
                                        meta:resourcekey="txtSecretQuestionResource1"></asp:TextBox>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 17%" height="35" nowrap="nowrap">
                                  <asp:Label ID="lbsecretans" runat="server" Text="Secret Answer" 
                                        meta:resourcekey="lbsecretansResource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSecretAnswer"  CssClass ="Txtboxlarge" runat="server" 
                                        meta:resourcekey="txtSecretAnswerResource1"></asp:TextBox>
                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:Button ID="btnChange" runat="server" OnClientClick="return chkValidation();"
                                        OnClick="btnChange_Click" Text="Update" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" meta:resourcekey="btnChangeResource1" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel"
                                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                        OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" height="15px">
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
            <asp:HiddenField ID ="hdnMessages" runat ="server" />
    </div>
    </form>
</body>
</html>
