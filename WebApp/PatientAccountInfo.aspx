<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PatientAccountInfo.aspx.cs" Inherits="PatientAccountInfo" %>
   


<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/PatientAccessHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="~/CommonControls/PatientOrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="~/CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="~/CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Account Information</title>
    <link href="~/StyleSheets/style.css" rel="stylesheet" type="text/css" />

    <script src="~/Scripts/Common.js" type="text/javascript"></script>

    <style type="text/css">
        .dataone
        {
            background-image: url(Images/data_bg.png);
            color: #FFFFFF;
            float: left;
            font-family: Arial,Helvetica,sans-serif;
            font-size: 11px;
            height: 583px;
            margin-top: 10px;
            position: absolute;
            top: 98px;
            width: 98%;
        }
        .ramone
        {
            width: 98%;
            height: 541px;
            padding-left: 15px;
            padding-right: 6px;
            padding-top: 10px;
            margin-top: 0px;
            background-image: url('Images/tile.png');
            float: none;
            list-style: none;
            font-family: Arial,sans-serif;
            font-size: 12px;
            font-weight: normal;
            color: #000000;
            list-style-image: none;
            overflow: auto;
            position: absolute;
            scrollbar-base-color: #cfd0d1;
            scrollbar-arrow-color: #000000;
            scrollbar-3dlight-color: #e9eef0;
            scrollbar-darkshadow-color: #909699;
            scrollbar-face-color: #cfd0d1;
            scrollbar-highlight-color: #909699;
            scrollbar-shadow-color: #cfd0d1;
            scrollbar-track-color: #cfd0d1; /* background-image: url(../Images/tile.png);
            color: #000000;
            float: none;
            font-family: Arial,sans-serif;
            font-size: 12px;
            font-weight: normal;
            height: 541px;
            list-style-image: none;
            list-style-position: outside;
            list-style-type: none;
            margin-top: 0;
            overflow: auto; */
        }
    </style>

    <script language="javascript" type="text/javascript">
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
                alert('Enter Old password');
                document.getElementById('txtOldpassword').focus();
                return false;
            }
            if (document.getElementById('txtNewpassword').value == '') {
                alert('Enter New password');
                document.getElementById('txtNewpassword').focus();
                return false;
            }

            if (document.getElementById('txtConfirmpassword').value == '') {
                alert('Enter Confirm password');
                document.getElementById('txtConfirmpassword').focus();
                return false;
            }

            if (document.getElementById('txtOldpassword').value == document.getElementById('txtNewpassword').value) {
                alert('New Password and Old Password cannot be same');
                document.getElementById('txtOldpassword').value = '';
                document.getElementById('txtNewpassword').value = '';
                document.getElementById('txtConfirmpassword').value = '';
                document.getElementById('txtOldpassword').focus();
                return false;
            }

            if (document.getElementById('txtNewpassword').value != document.getElementById('txtConfirmpassword').value) {
                alert('Password Mismatch');
                document.getElementById('txtNewpassword').value = '';
                document.getElementById('txtConfirmpassword').value = '';
                document.getElementById('txtNewpassword').focus();
                return false;
            }
            if (document.getElementById('ddlSecretQuestion').value == '0') {
                alert('Select Secret Question');
                document.getElementById('ddlSecretQuestion').focus();
                return false;
            }
            if (document.getElementById('ddlSecretQuestion').value == 'Userquestion') {
                if (document.getElementById('txtSecretQuestion').value == "") {
                alert('Enter Secret Question');
                    document.getElementById('txtSecretQuestion').focus();
                    return false;
                }
            }
            if (document.getElementById('txtSecretAnswer').value == "") {
                alert('Enter Secret Answer');
                document.getElementById('txtSecretAnswer').focus();
                return false;
            }
            return true;

        }
        function getFocus() {
            document.getElementById('txtOldpassword').focus();
        }
    </script>

</head>

<body id="oneColLayout" oncontextmenu="return false;" onload="javascript:getFocus();">
    <form id="prFrm" runat="server" defaultbutton="btnChange">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
          <div id="header">
            <div class="logowrapper">
                <img alt="" src="<%=LogoPath%>" class="logostyle" />
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="Header" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <div id="primaryContent">
            <div id="maincontent">
                <div class="dataone">
                    
                    <div class="ramone">
                    <div align="left">
                        <span align="left" style="font-size:12px;font-weight:bold;">Account Information</span>
                       
                    </div>
                   
                        <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                        <table border="0" cellpadding="0" cellspacing="5" align="center" width="100%">
                            <tr>
                                <td colspan="3">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 17%" height="35" nowrap="nowrap">
                                    Old Password
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:TextBox ID="txtOldpassword" runat="server" TextMode="Password"> &gt;</asp:TextBox>
                                    &nbsp;<img src="Images/starbutton.png" alt="" align="middle" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 17%" height="35" nowrap="nowrap">
                                    New Password
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNewpassword" runat="server" TextMode="Password"></asp:TextBox>
                                    &nbsp;<img src="Images/starbutton.png" alt="" align="middle" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 17%" height="35" nowrap="nowrap">
                                    Confirm password
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:TextBox ID="txtConfirmpassword" runat="server" TextMode="Password"></asp:TextBox>
                                    &nbsp;<img src="Images/starbutton.png" alt="" align="middle" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 17%" height="35" nowrap="nowrap">
                                    Secret Question
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:DropDownList onChange="fnSelectQuestion();" ID="ddlSecretQuestion" runat="server">
                                        <asp:ListItem Value="0" Selected="True">-- Select One --</asp:ListItem>
                                        <asp:ListItem Value='What was the last name of your favorite teacher?'>What was the last name of your favorite teacher?</asp:ListItem>
                                        <asp:ListItem Value='What was the last name of your best childhood friend?'>What was the last name of your best childhood friend?
                                        </asp:ListItem>
                                        <asp:ListItem Value='What is the name of the hospital where you were born?'>What is the name of the hospital where you were born?
                                        </asp:ListItem>
                                        <asp:ListItem Value='Who is your all-time favorite movie character?'>Who is your all-time favorite movie character?
                                        </asp:ListItem>
                                        <asp:ListItem Value='Where did you meet your spouse?'>Where did you meet your spouse?
                                        </asp:ListItem>
                                        <asp:ListItem Value='Userquestion'>-Type your question here-
                                        </asp:ListItem>
                                    </asp:DropDownList>
                                    &nbsp;<img src="Images/starbutton.png" alt="" align="middle" />
                                </td>
                            </tr>
                            <tr id="trUQ" runat="server" style="display: none;">
                                <td align="left" style="width: 17%" height="35" nowrap="nowrap">
                                    Type Your Question
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSecretQuestion" runat="server"></asp:TextBox>
                                    &nbsp;<img src="Images/starbutton.png" alt="" align="middle" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 17%" height="35" nowrap="nowrap">
                                    SecretAnswer
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:TextBox ID="txtSecretAnswer" runat="server"></asp:TextBox>
                                    &nbsp;<img src="Images/starbutton.png" alt="" align="middle" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:Button ID="btnChange" UseSubmitBehavior="true" runat="server" OnClientClick="return chkValidation();"
                                        OnClick="btnChange_Click" Text="Update" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" />
                                    <asp:Button ID="btnCancel" UseSubmitBehavior="true" runat="server" Text="Cancel"
                                        CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                        OnClick="btnCancel_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" height="15px">
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>

    <script language="javascript" type="text/javascript">
       
    
    
    </script>

</body>
</html>



</html>
