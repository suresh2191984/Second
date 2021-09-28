<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="ForgotPassword" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<style>
.text-black
{
    color:#000 !important;
}
.lh30{
    line-height: 30px;
}
.lh40{
    line-height: 40px;
}
.txt-height
{
height:20px !important;
}
.dataheaderPopup {
    border-color: #399ed9 !important;
}
.a-center{text-align: center;}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Forgot Password</title>
<link href="~/Themes/LisIB/style.css" rel="stylesheet" type="text/css" />
<script language="javascript"  src="Scripts/jquery-1.8.2.min.js" type="text/javascript" />



    <script type="text/javascript" src="Scripts/ddaccordion.js" language="javascript"></script>

    <link href="StyleSheets/tooltip.css" rel="stylesheet" type="text/css" media="all" />
<link href="StyleSheets/Common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" >
    function Showpop() {
        document.getElementById('divmodpop').style.display = 'block';
       
    }
    function reloadPage() {
        window.location.href="Home.aspx";
        
    }
    function binddata() {

        var pParentProIDs = document.getElementById('hdnRecords').value.split("^");
        for (j = 0; j < pParentProIDs.length; j++) {
            if (pParentProIDs[j] != "") {
                var test = pParentProIDs[j].split('~');

                if (test[0] != "T") {

                    document.getElementById("hdnnumcharlen").value = test[6];
                    document.getElementById("hdnpasslength").value = test[1];
                    document.getElementById("hdnsplcharlen").value = test[2];
                    document.getElementById("hdnnumcharlen").value = test[3];


                    var passlen = document.getElementById("hdnpasslength").value;
                    var splchar = document.getElementById("hdnsplcharlen").value;
                    var numchar = document.getElementById("hdnnumcharlen").value;

                    document.getElementById('lblLpwdHintLenth').innerHTML = passlen;
                    document.getElementById('lblLpwdHintsplchar').innerHTML = splchar;
                    document.getElementById('lblLpwdHintnumchar').innerHTML = numchar;
                    // + " " + "Minimum Special Character Length- " + splchar + " " + " Minimum Number Character Length- " + numchar;

                }
                else if (test[0] != "L") {


                    document.getElementById("hdntranspasslength").value = test[1];
                    document.getElementById("hdntranssplcharlen").value = test[2];
                    document.getElementById("hdntransnumcharlen").value = test[3];

                    var transpasslen = document.getElementById("hdntranspasslength").value;
                    var transsplchar = document.getElementById("hdntranssplcharlen").value;
                    var transnumchar = document.getElementById("hdntransnumcharlen").value;

                    document.getElementById('lblTpwdHintLenth').innerHTML = transpasslen;
                    document.getElementById('lblTpwdHintsplchar').innerHTML = transsplchar;
                    document.getElementById('lblTpwdHintnumchar').innerHTML = transnumchar;

                    // document.getElementById('lbltransnewpass').innerHTML = "Transaction Password Hint: " + "Maximum Password Length- " + transpasslen + " " + "Minimum Special Character- " + transsplchar + "   " + " Minimum Number Character- " + transnumchar;
                }

            }
        }

    }
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
    function fn_Validation() {
        if (document.getElementById('txtLoginName').value == '') {
            alert('Please Enter Login Name');
            document.getElementById('txtLoginName').focus();
            return false;
        }
    }
    function fn_UpdateValidation() {
        if (document.getElementById('txtOTP').value == '') {
            alert('Provide OTP');
            document.getElementById('txtOTP').focus();
            return false;
        }
        if (document.getElementById('txtNewpassword').value == '') {
            alert('Provide new password');
            document.getElementById('txtNewpassword').focus();
            return false;
        }

        if (document.getElementById('txtConfirmpassword').value == '') {
            alert('Provide confirm password');
            document.getElementById('txtConfirmpassword').focus();
            return false;
        }


        if (document.getElementById('txtNewpassword').value.length < 6) {
            alert('Password length should be minimum of 6 characters.');
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }


       

        if (document.getElementById('txtNewpassword').value != document.getElementById('txtConfirmpassword').value) {
            alert('There is a password mismatch');
            document.getElementById('txtNewpassword').value = '';
            document.getElementById('txtConfirmpassword').value = '';
            document.getElementById('txtNewpassword').focus();
            return false;
        }



        if (document.getElementById('txtNewpassword').value == document.getElementById('txtConfirmpassword').value) {
            var pw = document.getElementById('txtConfirmpassword').value;
            var passed = validatePassword(pw, { alpha: 1, special: 1, numeric: 1 });
            if (!passed) {
                alert('Password should contain atleast one special character,an alphabet and a number');
                document.getElementById('txtNewpassword').value = '';
                document.getElementById('txtConfirmpassword').value = '';
                document.getElementById('txtNewpassword').focus();
                return false;
            }

        }
    }


    function validatePassword(pw, options) {
        // default options (allows any password)
        var o = {
            lower: 0,
            upper: 0,
            alpha: 0, /* lower + upper */
            numeric: 0,
            special: 0,
            length: [0, Infinity],
            custom: [ /* regexes and/or functions */],
            badWords: [],
            badSequenceLength: 0,
            noQwertySequences: false,
            noSequential: false
        };

        for (var property in options)
            o[property] = options[property];

        var re = {
            lower: /[a-z]/g,
            upper: /[A-Z]/g,
            alpha: /[A-Z]/gi,
            numeric: /[0-9]/g,
            special: /[\W_]/g
        },
		rule, i;

        // enforce min/max length
        if (pw.length < o.length[0] || pw.length > o.length[1])
            return false;

        // enforce lower/upper/alpha/numeric/special rules
        for (rule in re) {
            if ((pw.match(re[rule]) || []).length < o[rule])
                return false;
        }

        // enforce word ban (case insensitive)
        for (i = 0; i < o.badWords.length; i++) {
            if (pw.toLowerCase().indexOf(o.badWords[i].toLowerCase()) > -1)
                return false;
        }

        // enforce the no sequential, identical characters rule
        if (o.noSequential && /([\S\s])\1/.test(pw))
            return false;

        // enforce alphanumeric/qwerty sequence ban rules
        if (o.badSequenceLength) {
            var lower = "abcdefghijklmnopqrstuvwxyz",
			upper = lower.toUpperCase(),
			numbers = "0123456789",
			qwerty = "qwertyuiopasdfghjklzxcvbnm",
			start = o.badSequenceLength - 1,
			seq = "_" + pw.slice(0, start);
            for (i = start; i < pw.length; i++) {
                seq = seq.slice(1) + pw.charAt(i);
                if (
				lower.indexOf(seq) > -1 ||
				upper.indexOf(seq) > -1 ||
				numbers.indexOf(seq) > -1 ||
				(o.noQwertySequences && qwerty.indexOf(seq) > -1)
			) {
                    return false;
                }
            }
        }

        // enforce custom regex/function rules
        for (i = 0; i < o.custom.length; i++) {
            rule = o.custom[i];
            if (rule instanceof RegExp) {
                if (!rule.test(pw))
                    return false;
            } else if (rule instanceof Function) {
                if (!rule(pw))
                    return false;
            }
        }

        // great success!
        return true;
    }
</script>
</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
 <asp:ScriptManager ID="ScriptManager1" runat="server">
  </asp:ScriptManager>
  
    <div id="wrapper">
       
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
               
                <td width="85%" valign="top" class="tdspace">
                     
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <%--<Top:TopHeader ID="TopHeader1" runat="server" />--%>
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                           <asp:UpdatePanel ID="UdtPanel" runat="server">
                            <ContentTemplate>
               <div id="divforgetPassword"  runat="server">
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td style="padding-bottom: 80px;">
                                <asp:Image   ImageUrl ="Images/home111.png"  runat="server" ID ="imgHome" />
                                <asp:LinkButton ID="lnkHome"    Text="Home" OnClick="lnkHome_Click"  Font-Size="15px"  CssClass ="text-black"   Font-Underline ="true"  
                                 runat="server"></asp:LinkButton>
                                        </td>
                                             </tr>
                                        </table>
                         <div style="width: 70%">
                             <table cellpadding="5" cellspacing="10"  border="0" style="margin: auto;">
                                          <tr>
                                          <td class="a-center">
                                        <asp:Label ID="lblLoginname" Text="Enter Login Name:" runat="server" ></asp:Label>
                                           <asp:TextBox ID="txtLoginName" runat="server" CssClass="Txtboxmedium txt-height" ></asp:TextBox>
                                        </td>
                                        </tr>
                                        <tr>
                                        <td>
                                    <div style="width:100%;height:40px;margin-bottom: 0;" class="defaultfontcolor dataheader2 a-center">
                                       
                                       
                                           <asp:Label ID="lblSelect" CssClass="lh40" Text="Select Your Option For Receiving OTP" runat="server" ></asp:Label>
                                           </div>
                                          </td>
                                        </tr>
                                        <tr class="lh30">
                                        <td>
                                          <asp:RadioButtonList CssClass="blackfontcolormedium" ID="rdoOTPlst" RepeatDirection="Vertical"
                                                        runat="server" meta:resourcekey="rblAccResource1">
                                                        <asp:ListItem  Selected ="True"  Value="SMS" Text="Send OTP to my 'Registered MobileNumber'"></asp:ListItem>
                                                        <asp:ListItem Text="Send OTP to my 'Registered Email ID'" Value="Email"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                        </td>
                                        </tr>
                                        <tr>
                                        <td class="a-center">
                                        <asp:Button ID="btnGenerateOTP" Text="Generate OTP" OnClientClick="return fn_Validation();" style="width:115px;height:30px;" OnClick="btnGenerateOTP_Click" runat="server" />
                                      
                                        </td>
                                        </tr>
                                         </table>
                         </div>
                                        
               </div>
                                    <div id="divUpdatePassword" style="display:none;" class="defaultfontcolor dataheader2" runat="server">
                                      <table  class="lh30"  cellspacing="1"  border="0" width="50%">
                                        <tr>
                                <td align="center" colspan="2">
                                <a href="#" class="jTip" id="one" name="Password must follow these rules:" onmouseover="showPopup(this.id);"
                                            onmouseout="$('#divLpwdHint').hide();">
                                            <asp:Label ID="lblHint" runat="server" Text="Hint" ForeColor="Red" 
                                        Font-Bold="True"></asp:Label></a>
                                            </td>
                                </tr>
                                
                                <tr >
                                    <td align="center" colspan="2">
                                        <strong>
                                            
                                            <asp:Label ID="lblMsg" Text="Please Update Your Password" runat="server"></asp:Label>
                                        </strong>
                                    </td>
                                </tr>
                                      <tr>
                                      <td>
                                      <asp:Label ID ="lblOTP"  Text="OTP" runat ="server" ></asp:Label>
                                      </td>
                                      <td> 
                                      <asp:TextBox ID="txtOTP" runat="server" MaxLength ="6" CssClass="Txtboxmedium txt-height" ></asp:TextBox>
                                       <asp:LinkButton ID="lnkresendbutton"  Font-Size="9px"  Text="Resend OTP"   ForeColor="Black" 
                                        Font-Underline ="true"  OnClientClick="Showpop();"
                                 runat="server"></asp:LinkButton>
                                 
                                   <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="lnkresendbutton"
                                                                                PopupControlID="Panel1" BackgroundCssClass="modalBackground" CancelControlID="btnClose"
                                                                                DynamicServicePath="" Enabled="True" />
                                      </td>
                                      </tr>
                                      <tr>
                                      <td> 
                                      <asp:Label ID ="lblnewpassword"  Text="New Password" runat ="server" ></asp:Label>
                                      </td>
                                      <td>
                                      <asp:TextBox ID="txtNewpassword" runat="server" TextMode="Password" 
                                            MaxLength="15"  CssClass="Txtboxmedium txt-height" ></asp:TextBox>
                                      </td>
                                      </tr>
                                      <tr>
                                      <td> 
                                      <asp:Label ID ="lblconfirmpwd"  Text="Confirm Password" runat ="server" ></asp:Label>
                                      </td>
                                      <td>
                                      <asp:TextBox ID="txtConfirmpassword" runat="server" TextMode="Password" 
                                            MaxLength="15"  CssClass="Txtboxmedium txt-height" ></asp:TextBox>
                                      </td>
                                      </tr>
                                      <tr>
                                      <td align ="center" colspan="2">
                                      <asp:Button ID="btnUpdate" CssClass ="btn" Text="Update" OnClientClick="return fn_UpdateValidation();" OnClick="btnUpdate_Click" runat="server" />
                                      <asp:Button ID="btncancel" CssClass ="btn" Text="Cancel"  OnClick="btncancel_Click" runat="server" />
                                      </td>
                                      </tr>
                                      </table> 
                                       <asp:HiddenField ID="hdnLoginname" runat="server"  />
   <asp:HiddenField ID="hdnLID" runat="server" />
   <asp:HiddenField ID="hdnOrgID" runat="server"  />
           <asp:HiddenField ID="hdnpwdplcycount" runat="server" />
        <asp:HiddenField ID="hdntranspwdplcycount" runat="server" />
   <asp:HiddenField ID="hdnRecords" runat="server" />
    <asp:HiddenField ID="hdnpasslength" runat="server" />
        <asp:HiddenField ID="hdnsplcharlen" runat="server" />
        <asp:HiddenField ID="hdnnumcharlen" runat="server" />
        <asp:HiddenField ID="hdntranspasslength" runat="server" />
        <asp:HiddenField ID="hdntranssplcharlen" runat="server" />
        <asp:HiddenField ID="hdntransnumcharlen" runat="server" />
   <asp:HiddenField ID="hdnpwdexpdate" runat="server" />
                                    </div>
                                            </ContentTemplate>
                        </asp:UpdatePanel>
                                     </div>
                             
                  
                </td>
            </tr>
        </table>
  
   <div id='divLpwdHint' style='width: 300px; height: 200px; display: none;'>
                                <div id='divLpwdHint_arrow_left'>
                                </div>
                                <div id='divLpwdHint_close_left'>
                                    <asp:Label ID="lblRules" runat="server" 
                                        Text="Password must follow these rules:"></asp:Label>
                                </div>
                                <div id='divLpwdHint_copy'>
                                    <strong>
                                        <asp:Label ID="lblMinimumPasswordLength2" runat="server" 
                                        Text=" 1)  Minimum Password Length - 6"></asp:Label>
                                   
                                    <br />
                                    <br />
                                    <asp:Label ID="lblMaximumPasswordLength2" runat="server" 
                                        Text="2) Maximum Password Length -"></asp:Label>
                                    
                                        <asp:Label ID="lblLpwdHintLenth" runat="server" Text="12"></asp:Label>
                                        <br />
                                        <br />
                                        
                                        <asp:Label ID="lblNumberCharacterLength" runat="server" Text="3) Number Character Length -" ></asp:Label>
                                                                          
                                        <asp:Label ID="lblLpwdHintnumchar" runat="server" Text="1" ></asp:Label>
                                        <br />
                                        <br />
                                        <asp:Label ID="lblSpecialCharacterLength2" runat="server" 
                                        Text="4) Special Character Length -" ></asp:Label>
                                        
                                        <asp:Label ID="lblLpwdHintsplchar" runat="server" Text="1" ></asp:Label>
                                        <asp:Label ID="lbletc" runat="server" Text="(@, %, etc)" ></asp:Label>
                                           </strong>
                                </div>
                                 
                            </div>
                            <div id="divmodpop" style="display :none;" runat="server">
                                    <asp:Panel ID="Panel1" Width="600px" Height="200px" runat="server" CssClass="modalPopup dataheaderPopup"
                                        Style="display: block" meta:resourcekey="Panel1Resource1">
                                        <table width="100%" align="center">
                                            <tr>
                                        <td>
                                    <div style="width:100%;height:40px;margin-bottom: 0;" class="defaultfontcolor dataheader2 a-center">
                                       
                                       
                                           <asp:Label ID="Label1" CssClass="lh40" Text="Select Your Option For Receiving OTP" runat="server" ></asp:Label>
                                           </div>
                                          </td>
                                        </tr>
                                        <tr class="lh30">
                                        <td>
                                          <asp:RadioButtonList CssClass="blackfontcolormedium" ID="rdopoplst" RepeatDirection="Vertical"
                                                        runat="server" meta:resourcekey="rblAccResource1">
                                                        <asp:ListItem  Selected ="True"  Value="SMS" Text="Send OTP to my 'Registered MobileNumber'"></asp:ListItem>
                                                        <asp:ListItem Text="Send OTP to my 'Registered Email ID'" Value="Email"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                        </td>
                                        </tr>
                                            <tr>
                                                <td align="center">
                                                    <asp:Button ID="btnsend" runat="server" Text="Send" CssClass="btn" onmouseover="this.className='btn btnhov'" OnClick ="btnsend_Click"
                                                        onmouseout="this.className='btn'" Width="75px" />
                                                    <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" Width="75px"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>
    </div>
    
    </form>
   
</body>
</html>
