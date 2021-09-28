<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="ChangePassword"
    meta:resourcekey="PageResource2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Change Password</title>

    <script type="text/javascript" language="javascript">
        window.history.forward(1);
    </script>
    <link media="all" href="../PlatForm/StyleSheets/tooltip.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">

        function getElementWidth(objectId) {
            x = document.getElementById(objectId);
            return x.offsetWidth;
        }
        function getAbsoluteLeft(objectId) {
            // Get an object left position from the upper left viewport corner
            o = document.getElementById(objectId)
            oLeft = o.offsetLeft            // Get left position from the parent object
            while (o.offsetParent != null) {   // Parse the parent hierarchy up to the document element
                oParent = o.offsetParent    // Get parent object reference
                oLeft += oParent.offsetLeft // Add parent left position
                o = oParent
            }
            return oLeft
        }

        function getAbsoluteTop(objectId) {
            // Get an object top position from the upper left viewport corner
            o = document.getElementById(objectId)
            oTop = o.offsetTop            // Get top position from the parent object
            while (o.offsetParent != null) { // Parse the parent hierarchy up to the document element
                oParent = o.offsetParent  // Get parent object reference
                oTop += oParent.offsetTop // Add parent top position
                o = oParent
            }
            return oTop
        }
        function showPopup(linkId) {
            var arrowOffset = getElementWidth(linkId) + 11;
            var clickElementx = getAbsoluteLeft(linkId) + arrowOffset; //set x position
            var clickElementy = getAbsoluteTop(linkId) - 3; //set y position
            $('#divLpwdHint').css({ left: clickElementx + "px", top: clickElementy + "px" });
            var pParentProIDs = document.getElementById('hdnRecords').value.split("^");
            for (j = 0; j < pParentProIDs.length; j++) {
                if (pParentProIDs[j] != "") {
                    var test = pParentProIDs[j].split('~');

                    if (test[0] == "L" && test[0] != "") {
                        $('#divLpwdHint').show();
                    }

                }
                else {
                    $('#divLpwdHint').show();
                }
            }

        }

        function showTPopup(linkId) {
            var arrowOffset = getElementWidth(linkId) + 11;
            var clickElementx = getAbsoluteLeft(linkId) + arrowOffset; //set x position
            var clickElementy = getAbsoluteTop(linkId) - 3; //set y position
            $('#divTpwdHint').css({ left: clickElementx + "px", top: clickElementy + "px" });

            var pParentProIDs = document.getElementById('hdnRecords').value.split("^");
            for (j = 0; j < pParentProIDs.length; j++) {
                if (pParentProIDs[j] != "") {
                    var test = pParentProIDs[j].split('~');

                    if (test[0] == "T" && test[0] != "") {
                        $('#divTpwdHint').show();
                    }

                }

                else {
                    $('#divTpwdHint').show();
                }
            }



        }
        
    </script>

    <style type="text/css">
        #passwordStrength
        {
            height: 10px;
            /*display: block;
            float: left;*/
        }
        .strength
        {
            width: 250px;
        }
        .strength0
        {
            width: 250px;
            background: #000000;
        }
        .strength1
        {
            width: 50px;
            background: #ff0000;
        }
        .strength2
        {
            width: 100px;
            background: #ff5f5f;
        }
        .strength3
        {
            width: 150px;
            background: #56e500;
        }
        .strength4
        {
            background: #4dcd00;
            width: 200px;
        }
        .strength5
        {
            background: #399800;
            width: 250px;
        }
        .style2
        {
            width: 15%;
        }
    </style>

    <script type="text/javascript" language="javascript">
        function passwordStrength(password) {
            var VeryWeak = SListForAppDisplay.Get('UserSettings_ChangePassword_aspx_01');
            if (VeryWeak == null) {
                VeryWeak = "Very Weak";
            }
            var Weak = SListForAppDisplay.Get('UserSettings_ChangePassword_aspx_02');
            if (Weak == null) {
                Weak = "Weak";
            }
            var Better = SListForAppDisplay.Get('UserSettings_ChangePassword_aspx_03');
            if (Better == null) {
                Better = "Better";
            }
            var Medium = SListForAppDisplay.Get('UserSettings_ChangePassword_aspx_04');
            if (Medium == null) {
                Medium = "Medium";
            }
            var Strong = SListForAppDisplay.Get('UserSettings_ChangePassword_aspx_05');
            if (Strong == null) {
                Strong = "Strong";
            }
            var Strongest = SListForAppDisplay.Get('UserSettings_ChangePassword_aspx_06');
            if (Strongest == null) {
                Strongest = "Strongest";
            }
            
            var desc = new Array();
            desc[0] = VeryWeak;
            desc[1] = Weak;
            desc[2] = Better;
            desc[3] = Medium;
            desc[4] = Strong;
            desc[5] = Strongest;

            var score = 0;

            //if password bigger than 6 give 1 point
            if (password.length > 3) score++;

            //if password has both lower and uppercase characters give 1 point
            if ((password.match(/[a-z]/)) && (password.match(/[A-Z]/))) score++;

            //if password has at least one number give 1 point
            if (password.match(/\d+/)) score++;

            //if password has at least one special caracther give 1 point
            if (password.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/)) score++;

            //if password bigger than 12 give another 1 point
            if (password.length > 6) score++;
            
            var strength = SListForAppDisplay.Get('UserSettings_ChangePassword_aspx_07');
            strength = strength.replace('{0}', score);
            if (strength == null) {
                strength = "strength" + score;
            }
            document.getElementById("passwordDescription").innerHTML = desc[score];
            document.getElementById("passwordStrength").className = strength;
        }
    </script>

    <script type="text/javascript" language="javascript">
        var userMsg;
        function save(Path) {
            //debugger;
            userMsg = SListForAppMsg.Get('UserSettings_ChangePassword_aspx_02');
            var Information = SListForAppMsg.Get('UserSettings_ChangePassword_aspx_04');
            if (Information == null) {
                Information = "Information";
            }
            if (userMsg != null) {
                ValidationWindow(userMsg, Information);
                return false;
            }
            else {
                ValidationWindow('Updated Successfully', 'Information');
                return false ;

            }
            location.href = Path;
            return true;
        }


        function binddata() {

            var pParentProIDs = document.getElementById('hdnRecords').value.split("^");
            for (j = 0; j < pParentProIDs.length; j++) {
                if (pParentProIDs[j] != "") {
                    var test = pParentProIDs[j].split('~');

                    if (test[0] != "T") {

                        document.getElementById("hdnnumcharlen").value = test[6];
                        document.getElementById("hdnpasslength").value = test[1];
                        document.getElementById("hdnMinpasslength").value = test[8];
                        document.getElementById("hdnsplcharlen").value = test[2];
                        document.getElementById("hdnnumcharlen").value = test[3];


                        var passlen = document.getElementById("hdnpasslength").value;
                        var splchar = document.getElementById("hdnsplcharlen").value;
                        var numchar = document.getElementById("hdnnumcharlen").value;
                        var minpasslen = document.getElementById("hdnMinpasslength").value;
                        document.getElementById('lblLpwdMinHintLenth').innerHTML = minpasslen;
                        document.getElementById('lblLpwdHintLenth').innerHTML = passlen;
                        document.getElementById('lblLpwdHintsplchar').innerHTML = splchar;
                        document.getElementById('lblLpwdHintnumchar').innerHTML = numchar;
                        // + " " + "Minimum Special Character Length- " + splchar + " " + " Minimum Number Character Length- " + numchar;

                    }
                    else if (test[0] != "L") {


                        document.getElementById("hdntranspasslength").value = test[1];
                        document.getElementById("hdntranssplcharlen").value = test[2];
                        document.getElementById("hdntransnumcharlen").value = test[3];
                        document.getElementById("hdnMinpasslength").value = test[8];

                        var transpasslen = document.getElementById("hdntranspasslength").value;
                        var transsplchar = document.getElementById("hdntranssplcharlen").value;
                        var transnumchar = document.getElementById("hdntransnumcharlen").value;
                        var transminpasslen = document.getElementById("hdnMinpasslength").value;

                        document.getElementById('lblLpwdMinHintLenth').innerHTML = transminpasslen;
                        document.getElementById('lblTpwdHintLenth').innerHTML = transpasslen;
                        document.getElementById('lblTpwdHintsplchar').innerHTML = transsplchar;
                        document.getElementById('lblTpwdHintnumchar').innerHTML = transnumchar;

                        // document.getElementById('lbltransnewpass').innerHTML = "Transaction Password Hint: " + "Maximum Password Length- " + transpasslen + " " + "Minimum Special Character- " + transsplchar + "   " + " Minimum Number Character- " + transnumchar;
                    }

                }
            }

        }

        function pwdcheck() {
            if (document.getElementById('txtAccesspwd').value == '') {
                userMsg = SListForApplicationMessages.Get('UserSettings_ChangePassword_aspx_03');
                var ErrorMsg = SListForAppMsg.Get('UserSettings_ChangePassword_aspx_01');
                if (ErrorMsg == null) {
                    ErrorMsg = "Error";
                }
                if (userMsg != null) {
                    ValidationWindow(userMsg, ErrorMsg);
                    return false;
                }
                else {

                    ValidationWindow('Provide Transaction password','Error');
                    return false;
                }
                document.getElementById('txtAccesspwd').focus();
                return false;
            }
            else {
                return true;
            }
        }
        function checkSubmit(e) {
            if (e && e.keyCode == 13) {
                if (document.getElementById('txtAccesspwd').value == '') {
                    userMsg = SListForApplicationMessages.Get('UserSettings_ChangePassword_aspx_03');
                    var ErrorMsg = SListForAppMsg.Get('UserSettings_ChangePassword_aspx_01');
                    if (ErrorMsg == null) {
                        ErrorMsg = "Alert";
                    }
                    if (userMsg != null) {
                        ValidationWindow(userMsg, ErrorMsg);
                        return false;
                    }
                    else {

                        ValidationWindow('Provide Transaction password','Error');
                        return false;
                    }
                    document.getElementById('txtAccesspwd').focus();
                }
                return false;
            }
        }
    </script>

</head>
<body oncontextmenu="return false;">
    <form id="form1" runat="server" >
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div class="marginT20">
            <div class="hide w-30p marginauto card-Bg-Grey " id="DivLpwd" runat="server">           
                <table class="w-100p">
                    <tr id="trplcy" runat="server" class="hide">
                        <td colspan="3" class="a-left">
                        </td>
                    </tr>
                    <tr class=" a-center lh15">
                        <td colspan="3">
                            <asp:Label ID="lblMsg" class="thmColorHdrtxt font20" Text="Login Password" runat="server" meta:resourcekey="lblMsgResource2"></asp:Label>
                            <div class="bg-thmColorHdrtxt marginB40"></div>
                        </td>
                    </tr>
                    <tr class="panelContent lh40">
                        <td class="a-right w-40p paddingR30" nowrap="nowrap">
                            <asp:Label ID="lblop" CssClass="marginT20" runat="server" Text="Old Password" meta:resourcekey="lblopResource2"></asp:Label>
                        </td>
                        <td class="a-left">
                            <asp:TextBox ID="txtOldpassword" runat="server" autocomplete="off" TextMode="Password" TabIndex="1" CssClass="medium h-30 marginT20"
                                meta:resourcekey="txtOldpasswordResource2"> &gt;</asp:TextBox>
                        </td>
                        <td class="a-left">
                        </td>
                    </tr>
                    <tr class="panelContent lh40">
                        <td class="a-right w-40p paddingR26" nowrap="nowrap">
                            <asp:Label ID="lblnp"  runat="server" Text="New Password" meta:resourcekey="lblnpResource2"></asp:Label>
                        </td>
                        <td class="a-left">
                            <asp:TextBox ID="txtNewpassword" runat="server" autocomplete="off" CssClass="medium h-30" TextMode="Password" MaxLength="12"
                                TabIndex="2" onkeyup="passwordStrength(this.value)" meta:resourcekey="txtNewpasswordResource2"></asp:TextBox>
                            <a href="#" class="jTip" id="one" name="Password must follow these rules:" onmouseover="showPopup(this.id);"
                                onmouseout="$('#divLpwdHint').hide();">
                                <asp:Label ID="lblHint" runat="server" CssClass="bold" Text="Hint" meta:resourcekey="lblHintResource2"></asp:Label></a>
                        </td>
                        <td class="a-left">
                        </td>
                    </tr>
                    <tr class="panelContent lh40">
                        <td class="a-right w-40p paddingR26" nowrap="nowrap">
                            <asp:Label ID="lblcpd" runat="server" Text="Confirm Password" meta:resourcekey="lblcpdResource2"></asp:Label>
                        </td>
                        <td class="a-left">
                            <asp:TextBox ID="txtConfirmpassword" CssClass="medium h-30" runat="server" autocomplete="off" TextMode="Password" MaxLength="12"
                                TabIndex="3" meta:resourcekey="txtConfirmpasswordResource2"></asp:TextBox>
                        </td>
                        <td class="a-left">
                        </td>
                    </tr>
                    <tr class="panelContent">
                        <td>
                        </td>
                        <td colspan="2">
                            <div id="passwordDescription">
                            </div>
                            <div id="passwordStrength" class="strength">
                            </div>
                        </td>
                    </tr>
                    <tr class="panelContent">
                        <td colspan="3">
                            <br />
                        </td>
                    </tr>
                    <tr >
                        <td class="a-center" colspan="3">
                            <asp:Button ID="btnCancel" runat="server" TabIndex="5" Text="Cancel" CssClass="cancel-btn btn-flat marginR20"
                                OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource2" />
                            <asp:Button ID="btnChange" runat="server" OnClientClick="return TextboxValidation();"
                                OnClick="btnChange_Click" TabIndex="4" Text="Update" CssClass="btn btn-flat marginL30" meta:resourcekey="btnChangeResource2" />
                        </td>
                    </tr>
                    <tr>
                        <td class="a-left" colspan="3">
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div>
            <div id='divLpwdHint' class="hide" style="position:absolute;">
                <div id='divLpwdHint_arrow_left'>
                </div>
                <div id='divLpwdHint_close_left'>
                    <asp:Label ID="lblRules" runat="server" CssClass="thmColorHdrtxt margin0" Text="Password must follow these rules:"
                        meta:resourcekey="lblRulesResource2"></asp:Label>
                </div>
                <div id='divLpwdHint_copy'>
                    <strong>
                        <asp:Label ID="lblMinimumPasswordLength2" runat="server" Text=" 1)  Minimum Password Length -"
                            meta:resourcekey="lblMinimumPasswordLength2Resource1"></asp:Label>
                        <asp:Label ID="lblLpwdMinHintLenth" runat="server" Text="8" meta:resourcekey="lblLpwdMinHintLenthResource2"></asp:Label>
                        <br />
                        <br />
                        <asp:Label ID="lblMaximumPasswordLength2" runat="server" Text="2) Maximum Password Length -"
                            meta:resourcekey="lblMaximumPasswordLength2Resource1"></asp:Label>
                        <asp:Label ID="lblLpwdHintLenth" runat="server" Text="15" meta:resourcekey="lblLpwdHintLenthResource2"></asp:Label>
                        <br />
                        <br />
                        <asp:Label ID="lblNumberCharacterLength" runat="server" Text="3) Number Character Length -"
                            meta:resourcekey="lblNumberCharacterLengthResource1"></asp:Label>
                        <asp:Label ID="lblLpwdHintnumchar" runat="server" Text="1" meta:resourcekey="lblLpwdHintnumcharResource2"></asp:Label>
                        <br />
                        <br />
                        <asp:Label ID="lblSpecialCharacterLength2" runat="server" Text="4) Special Character Length -"
                            meta:resourcekey="lblSpecialCharacterLength2Resource1"></asp:Label>
                        <asp:Label ID="lblLpwdHintsplchar" runat="server" Text="1" meta:resourcekey="lblLpwdHintsplcharResource2"></asp:Label>
                        <asp:Label ID="lbletc" runat="server" Text="(@, %, etc)" meta:resourcekey="lbletcResource1"></asp:Label>
                    </strong>
                </div>
            </div>
        </div>
        <div>
        </div>
        <div class="scheduledataheader2 hide" id="divTpwd" runat="server">
            <table class="w-100p a-center">
                <tr id="transplcy" runat="server" class="hide">
                    <td colspan="3" class="a-left">
                        <%--  <asp:Label ID="lbltransnewpass" runat="server" CssClass="errorbox"></asp:Label>--%>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" class="a-right">
                        <a href="#" class="jTip" id="two" name="Transaction Password must follow these rules:"
                            onmouseover="showTPopup(this.id);" onmouseout="$('#divTpwdHint').hide();">
                            <asp:Label ID="lblTpp" runat="server" Text="Hint" ForeColor="Red" Font-Bold="True"
                                meta:resourcekey="lblTppResource2"></asp:Label></a>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" class="a-right">
                        <strong>
                            <br />
                            <asp:Label Text="Transaction Password" ID="lblmsg1" runat="server" meta:resourcekey="lblmsg1Resource2"></asp:Label>
                        </strong>
                    </td>
                </tr>
                <tr>
                    <td class="a-right" nowrap="nowrap">
                        <asp:Label ID="lbltopl" runat="server" Text="Old Transaction Password" meta:resourcekey="lbltoplResource2"></asp:Label>
                    </td>
                    <td class="a-right">
                        <asp:TextBox ID="Txtoldtranspwd" runat="server" TextMode="Password" TabIndex="6"
                            meta:resourcekey="TxtoldtranspwdResource2"> &gt;</asp:TextBox>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trNTP" runat="server">
                    <td class="a-right" nowrap="nowrap">
                        <asp:Label ID="lblntp" runat="server" Text="New Transaction Password" meta:resourcekey="lblntpResource2"></asp:Label>
                    </td>
                    <td class="a-right">
                        <asp:TextBox ID="TxtNewtranspwd" TextMode="Password" runat="server" TabIndex="7"
                            meta:resourcekey="TxtNewtranspwdResource2"></asp:TextBox>
                    </td>
                    <td class="a-left">
                    </td>
                </tr>
                <tr id="trCTP" runat="server">
                    <td class="a-left" nowrap="nowrap">
                        <asp:Label ID="lblctp" runat="server" Text="Confirm Transaction Password" meta:resourcekey="lblctpResource2"></asp:Label>
                    </td>
                    <td class="a-left">
                        <asp:TextBox ID="TxtconTranspwd" TextMode="Password" runat="server" TabIndex="8"
                            meta:resourcekey="TxtconTranspwdResource2"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="a-left">
                        <asp:Button ID="btnupdate" runat="server" OnClientClick="return Passwordvalidation();"
                            TabIndex="9" Text="Update" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                            onmouseout="this.className='btn1'" OnClick="btnupdate_Click" meta:resourcekey="btnupdateResource2" />
                    </td>
                    <td colspan="2" class="a-left">
                        <asp:Button ID="btnclose" runat="server" TabIndex="10" Text="Cancel" CssClass="btn"
                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClick="btnclose_Click"
                            meta:resourcekey="btncloseResource2" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" class="a-left">
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <div id='divTpwdHint' class="hide">
                <div id='divTpwdHint_arrow_left'>
                </div>
                <div id='divTpwdHint_close_left'>
                    <asp:Label ID="lblTRules" runat="server" Text="Transaction Password must follow these rules:"
                        meta:resourcekey="lblTRulesResource2"></asp:Label>
                </div>
                <div id='divTpwdHint_copy'>
                    <strong>
                        <asp:Label ID="lblMinimumPasswordLength1" runat="server" Text="1)  Minimum Password Length - 6"
                            meta:resourcekey="lblMinimumPasswordLength1Resource1"></asp:Label>
                        <br />
                        <br />
                        <asp:Label ID="lblMaximumPasswordLength1" runat="server" Text=" 2) Maximum Password Length -"
                            meta:resourcekey="lblMaximumPasswordLength1Resource1"></asp:Label>
                        <asp:Label ID="lblTpwdHintLenth" runat="server" Text="12" meta:resourcekey="lblTpwdHintLenthResource2"></asp:Label>
                        <br />
                        <br />
                        <asp:Label ID="lblSpecialCharacter1" runat="server" Text="3) Special Character Length -"
                            meta:resourcekey="lblSpecialCharacter1Resource1"></asp:Label>
                        <asp:Label ID="lblTpwdHintsplchar" runat="server" Text="1" meta:resourcekey="lblTpwdHintsplcharResource2"></asp:Label>
                        <asp:Label ID="lbletc1" runat="server" Text="(@, %, etc)" meta:resourcekey="lbletc1Resource1"></asp:Label>
                        <br />
                        <br />
                        <asp:Label ID="lblNumberCharacter1" runat="server" Text=" 4) Number Character Length - "
                            meta:resourcekey="lblNumberCharacter1Resource1"></asp:Label>
                        <asp:Label ID="lblTpwdHintnumchar" runat="server" Text="1" meta:resourcekey="lblTpwdHintnumcharResource2"></asp:Label>
                    </strong>
                </div>
            </div>
        </div>
        <asp:UpdatePanel ID="UP" runat="server">
            <ContentTemplate>
                <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" class="hide" meta:resourcekey="hiddenTargetControlForModalPopupResource2" />
                <ajc:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="hiddenTargetControlForModalPopup"
                    PopupControlID="pnlTpwd" BackgroundCssClass="modalBackground" DynamicServicePath=""
                    Enabled="True" />
                <asp:Panel ID="pnlTpwd" runat="server" CssClass="modalPopup dataheaderPopup hide"
                    meta:resourcekey="pnlTpwdResource2">
                    <div id="divAccess" runat="server">
                        <div class="a-right">
                            <asp:ImageButton ID="btncancelclose" runat="server" ImageUrl="~/PlatForm/Images/CloseIcon.png"
                                AlternateText="Close" ImageAlign="Top" ToolTip="Close" OnClick="btncancelclose_Click"
                                meta:resourcekey="btncancelcloseResource2" />
                        </div>
                        <table class="a-100p">
                            <tr>
                                <td colspan="3" class="a-center">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="a-center">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="right">
                                </td>
                            </tr>
                            <tr>
                                <td class="a-left" nowrap="nowrap">
                                    <asp:Label ID="lblEnterTransactionPassword" runat="server" Text="Enter Transaction Password"
                                        meta:resourcekey="lblEnterTransactionPasswordResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtAccesspwd" TextMode="Password" runat="server" TabIndex="11" onKeyPress="return checkSubmit(event)"
                                        meta:resourcekey="txtAccesspwdResource2"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Button ID="btngo" runat="server" TabIndex="12" Text=" GO " CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btngo_Click" OnClientClick="javascript:return pwdcheck();"
                                        meta:resourcekey="btngoResource2" />
                                </td>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </tr>
                            <tr>
                                <td colspan="3" height="15px" class="a-left">
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:Panel>
                <asp:Button ID="btnmsgpopup" runat="server" class="hide" meta:resourcekey="btnmsgpopupResource1" />
                <ajc:ModalPopupExtender ID="ModalPopupExtender2" runat="server" TargetControlID="btnmsgpopup"
                    PopupControlID="pnlOthers" BackgroundCssClass="modalBackground" DynamicServicePath=""
                    Enabled="True" />
                <asp:Panel ID="pnlOthers" runat="server" class="hide" CssClass="modalPopup dataheaderPopup"
                    meta:resourcekey="pnlOthersResource1">
                    <center>
                        <div id="divOthers">
                            <table class="a-center w-100p">
                                <tr class="a-left">
                                    <td>
                                        <table id="tblDiagnosisItems" runat="server" class="w-100p">
                                            <tr id="Tr1" runat="server">
                                                <td id="Td1" class="a-center" rowspan="2" runat="server">
                                                    <asp:Label ID="lblmsgs" runat="server" Text="Updated Successfully" Font-Bold="True"
                                                        Font-Size="Medium" meta:resourcekey="lblmsgsResource1"></asp:Label>
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr id="Tr2" runat="server">
                                                <td id="Td2" runat="server">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-center">
                                        <asp:Button ID="btnpopClose" OnClick="btnpopClose_Click" runat="server" class="btn"
                                            Text="Ok" meta:resourcekey="btnpopCloseResource1" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </center>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnRecords" runat="server" />
    <asp:HiddenField ID="hdnprepass" runat="server" />
    <asp:HiddenField ID="hdnType" runat="server" />
    <asp:HiddenField ID="hdnpasslength" runat="server" />
    <asp:HiddenField ID="hdnMinpasslength" runat="server" />
    <asp:HiddenField ID="hdnsplcharlen" runat="server" />
    <asp:HiddenField ID="hdnnumcharlen" runat="server" />
    <asp:HiddenField ID="hdntranspasslength" runat="server" />
    <asp:HiddenField ID="hdntranssplcharlen" runat="server" />
    <asp:HiddenField ID="hdntransnumcharlen" runat="server" />
    <asp:HiddenField ID="hdnpwdplcycount" runat="server" />
    <asp:HiddenField ID="hdntranspwdplcycount" runat="server" />
        <asp:HiddenField ID="hdnprevpwdcount" runat="server" />
    <asp:HiddenField ID="hdnpwdexpdate" runat="server" />
    <asp:HiddenField ID="hdntranspwdexpdate" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>

    <script type="text/javascript" language="javascript">
        function show() {
            document.getElementById('pnlOthers').style.display = "block";

        }
        
        $(window).on('load', function() {
            $('#pnlOthers').css('top', '30%');
            $('#pnlOthers').css('left', '35%');
        });
        

    </script>
        <script type="text/javascript" language="javascript">
            $("#txtConfirmpassword").keyup(function (event) {
                if (event.keyCode == 13) {
                    $("#btnChange").click()
                }

            });
        </script>
</body>
</html>
