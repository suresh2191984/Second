<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Masters_Home"
    meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link id="linkCommonCSS" href="StyleSheets/style.css" rel="stylesheet" type="text/css" />
    <link href="Images/favicon.ico" rel="shortcut icon" />
<%--    <link href="StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>
    <title>Health Care</title>
    <script type="text/javascript" src="PlatForm/Scripts/jquery.min.js"></script>
	
	 <script src="Scripts/jquery.min.js" type="text/javascript"></script>
	 <script src='<%= "Scripts/resource/ResourceJson_"+ LanguageCode +".js"%>'    type="text/javascript"></script>
    <script src="Scripts/jquery-1.11.3.min.js" type="text/javascript" language="javascript"></script>

    <script src="Scripts/jquery-ui-1.10.4.custom.min.js" type="text/javascript" language="javascript"></script>
 <link id="iconslink" rel="stylesheet" type="text/css" href="Themes/LisIB/start/jquery-ui-1.10.4.custom.min.css" />
    <script src="Scripts/Common.js" type="text/javascript"></script>

   

    <script src="Scripts/jquery.watermark.min.js" type="text/javascript"></script>
    
    <script src="Scripts/jquery.backgroundresize.js" type="text/javascript"></script>      
    <script src="Scripts/MessageHandler.js" type="text/javascript"></script>

    <script type="text/vbscript">
         Function RegKeyExists()
            On Error Resume Next
            Dim oShell, entry
            Const HKEY_CLASSES_ROOT = &H80000000
            strComputer = "."
            hDefKey = HKEY_CLASSES_ROOT
            strKeyPath = "attunebarcode"
            Set oReg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\default:StdRegProv")
            Set entry = oShell.RegRead("HKCR")
            call ShowRegKeyExists(oReg.EnumKey(hDefKey, strKeyPath, arrSubKeys))
        End Function
    </script>
    <script type="text/vbscript">
        Function GetProductUUID()
            On Error Resume Next
            strComputer = "."
            Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
            Set colItems = objWMIService.ExecQuery("Select * from Win32_ComputerSystemProduct",,48)
            For Each objItem in colItems
                call showProductUUID(objItem.UUID)
            Next
        End Function
    </script>
    <script type="text/javascript">
        function ShowRegKeyExists(entry) {
            try {
                if (entry == 0) {
                    $("#hdnRegKeyExists").val('true');
                }
                else {
                    $("#hdnRegKeyExists").val('false');
                }
            }
            catch (e) {
            }
        }
        function showProductUUID(uuid) {
            try {
                $("#hdnMacAddress").val(uuid);
            }
            catch (e) {
            }
        }
        /*function showMacAddress() {
            try {
                var obj = new ActiveXObject("WbemScripting.SWbemLocator");
                var s = obj.ConnectServer(".");
                var properties = s.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration");
                var e = new Enumerator(properties);

                while (!e.atEnd()) {
                    e.moveNext();
                    var p = e.item();
                    if (!p) continue;
                    if (p.MACAddress != null && $.trim(p.MACAddress) != "") {
                        var ipAddress = null;
                        if (p.IPAddress != null) {
                            ipAddress = p.IPAddress(0);
                        }
                        if (ipAddress != null && $.trim(ipAddress).length > 0) {
                            $("#hdnMacAddress").val(p.MACAddress);
                            return;
                        }
                    }
                }
            }
            catch (e) {
            }
        }*/
        $(function() {
        $("#ddLang").focus();
            
            var txtUserTitle = $("#txtUserName").attr('title');
            var txtPwdTitle = $("#txtPassword").attr('title');
            $("#txtUserName").watermark(txtUserTitle);
            $("#txtPassword").watermark(txtPwdTitle);

            $("#imgGo").click(function() {
                if (($("#txtUserName").val().length == 0) || ($("#txtUserName").val() == txtUserTitle)) {
                    $("#txtUserName").focus();
                    return false;
                }
                if (($("#txtPassword").val().length == 0) || ($("#txtPassword").val() == txtPwdTitle)) {
                    $("#txtPassword").focus();
                    return false;
                }
            });
            RegKeyExists();
            GetProductUUID();
        });

        function SetBodyBackground(imgSrc) {
            $("body").ezBgResize({
            img: imgSrc,
                bodyWidth: $(window).width(),
                bodyHeight: $(window).height(),
                opacity: 1,
                center: true
            });
        }
    </script>

</head>
<body id="body" runat="server" oncontextmenu="return false;">
<%--<body id="body" runat="server" oncontextmenu="return false;" style="background-color: #a5a5a3">--%>
    <form id="form1" runat="server" defaultbutton="imgGo">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
        <div class="login-img"></div>
        <div id="divLoginImg" class="loginimg-Multi h-280 card-login-white" runat="server">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <div class="lh40 login-label">

                   
                    <asp:Label ID="Label1" runat="server" Text="Login" meta:resourcekey="imgGoResource1"></asp:Label>
                </div>
                <div class="w-100p displaytb">
                    <div class="w-50p o-auto displaytd">
                        <table id="tblInputBox" runat="server" border="0" class="marginT20 marginB20  inputbox" cellpadding="5">
                            <tr id="Tr1" runat="server">
                                <td id="Td1" colspan="3" align="center" runat="server">
                                    <asp:Label ID="lblStatus" runat="server" ForeColor="Yellow" meta:resourcekey="lblStatusResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td width="10" align="left" class="logintxt">
                                    <asp:Label ID="Language" Text="Language" CssClass="logintxt" size="34" runat="server"
                                        meta:resourcekey="lblLangResource1" />
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddLang" runat="server" CssClass="ddlstyle bdr-radius-2" AutoPostBack="true"
                                    OnSelectedIndexChanged="SetLanguage">
                                        <asp:ListItem Value="en-GB" Text="English"></asp:ListItem>
                                        <asp:ListItem Value="id-ID" Text="Bahasa"></asp:ListItem>
                                        <asp:ListItem Value="ta-IN" Text="தமிழ்"></asp:ListItem>
                                        <asp:ListItem Value="zh-CN" Text="Chinese"></asp:ListItem>
                                    <asp:ListItem Value="es-ES" Text="Español"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td class="logintxt" align="right">
                                    <%--<asp:ImageButton ID="btnSetLang" runat="server" ImageUrl="~/Images/Refresh.png" OnClick="SetLanguage"
                                        Width="20" Height="20" />--%>
                                </td>
                            </tr>
                            <tr id="Tr2" style="display: none;" runat="server">
                                <td id="Td2" colspan="3" width="77" align="left" class="logintxt" runat="server">
                                    <asp:Label ID="Rs_Username" Text="Username" runat="server" meta:resourcekey="Rs_UsernameResource1" />
                                </td>
                            </tr>
                            <tr id="Tr3" runat="server">
                                <td id="Td3" colspan="3" width="153" runat="server">
                                    <asp:TextBox ID="txtUserName" runat="server" CssClass="Txtboxstyle t-ic1 bdr-radius-2" size="34" meta:resourcekey="txtUserNameResource1"></asp:TextBox>
                                </td>
                            </tr>
                            <tr id="Tr4" style="display: none;" runat="server">
                                <td id="Td4" colspan="3" class="logintxt" align="left" runat="server">
                                    <asp:Label ID="Rs_Password" Text="Password" runat="server" meta:resourcekey="Rs_PasswordResource1" />
                                </td>
                            </tr>
                            <tr id="Tr5" runat="server">
                                <td id="Td5" colspan="3" runat="server">
                                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="Txtboxstyle t-ic2 bdr-radius-2"
                                        meta:resourcekey="txtPasswordResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                        <td colspan="3" align="right" >
                                 <asp:LinkButton ID="lnkforgetPassword" ForeColor="Black"   Font-Size="12px"  Text="Forgot Password" OnClick="lnkforgetPassword_Click"   Font-Underline ="true" 
                                 runat="server"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr id="Tr6" runat="server">
                                <td id="Td6" colspan="3" align="left" valign="middle" runat="server">
                                    <asp:UpdateProgress ID="Progressbar" runat="server">
                                        <ProgressTemplate>
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                            </tr>
                            <tr id="Tr7" runat="server">
                                <td id="Td7" colspan="2" runat="server" align="left">
                                    
                                    <asp:LinkButton ID="imgGo" CssClass="loginbtn marginR10" Text="Login"  OnClientClick="return validateUsers();"
                                        OnClick="imgGo_Click" runat="server" meta:resourcekey="imgGoResource1" />
                                     <asp:LinkButton ID="imgClose" Text="Close" OnClientClick="window.close();" CssClass="loginbtn closebtn"
                                         runat="server" meta:resourcekey="imgCloseResource1" />
                                   
                                </td>
                                <td></td>
                            </tr>
                        </table>
                    </div>
                    <div class="w-50p displaytd v-middle a-center">
                    <asp:Image runat="server" ID="LoginPageLogo"   class="compLogoImg" />
                    </div>
                </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="fixedImgFooter">
            <asp:Image runat="server" ID="imgCustomerLogo" width="350px" ImageUrl="" /> </td> 
        </div>
        
        
        <asp:HiddenField ID="hdnRegKeyExists" runat="server" Value="false" />
        <asp:HiddenField ID="hdnMacAddress" runat="server" Value="" />
    </form>
    <p>
    </p>
    <link rel="stylesheet" type="text/css" href="StyleSheets/loginMultiClient.css" />
</body>
</html>
