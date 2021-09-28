<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="SelectRole.aspx.cs"
    Inherits="SelectRole" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Select Roles</title>
    <link id="linkCommonCSS" href="StyleSheets/style.css" rel="stylesheet" type="text/css" />
<%--    <link href="StyleSheets/Common.css" rel="stylesheet" type="text/css" />--%>
    <link href="Images/favicon.ico" rel="shortcut icon" />

    <script src='<%= "Scripts/resource/ResourceJson_"+ LanguageCode +".js"%>'    type="text/javascript"></script>
         
    <script src="Scripts/Common.js" type="text/javascript"></script>

    <script src="Scripts/jquery.min.js" type="text/javascript"></script>

    <script src="Scripts/MessageHandler.js" type="text/javascript"></script>

    <script src="Scripts/jquery.backgroundresize.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function() {
        $("#ddlOrg, #ddlLocation, #ddlRole").css("width", "220px");
            $("#ddlOrg, #ddlLocation, #ddlRole").mousedown(function() {
                if ($.browser.msie) {
                    if ($(this).css("width") != "auto") {
                        var width = $(this).width();
                        $(this).css("width", "auto");
                        if ($(this).width() < width) {
                            $(this).unbind('mousedown');
                            $(this).css("width", "220px");
                        }
                    }
                }
            });
            $("#ddlOrg, #ddlLocation, #ddlRole").change(function() {
                if ($.browser.msie) {
                    $(this).css("width", "220px");
                }
            });
            $("#ddlOrg, #ddlLocation, #ddlRole").blur(function() {
                if ($.browser.msie) {
                    $(this).css("width", "220px");
                }
            });
            $("#imgGo").click(function() {
                if ($("#ddlOrg").get(0).selectedIndex == 0) {
                    var userMsg = SListForApplicationMessages.Get('SelectRole.aspx_1');
                    if (userMsg == null)
                        alert('Select Organization');
                    else
                        alert(userMsg);
                    $("#ddlOrg").focus();
                    return false;
                }
                if ($("#ddlRole").get(0).selectedIndex == 0) {
                    // alert('Select Role');
                    var userMsg = SListForApplicationMessages.Get('SelectRole.aspx_3');
                    if (userMsg == null)
                        alert('Select Role');
                    else
                        alert(userMsg);
                    $("#ddlRole").focus();
                    return false;
                }
                if ($("#ddlLocation").get(0).selectedIndex == 0) {
                    // alert('Select Location');
                    var userMsg = SListForApplicationMessages.Get('SelectRole.aspx_2');
                    if (userMsg == null)
                        alert('Select Location');
                    else
                        alert(userMsg);
                    $("#ddlLocation").focus();
                    return false;
                }
            });
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
    <link rel="stylesheet" type="text/css" href="StyleSheets/loginMultiClient.css" />
</head>
<body oncontextmenu="return false;" style="background-color: #a5a5a3">
    <form id="form1" runat="server" style="background-image: url(../Images/Login.jpg);"
    defaultbutton="imgGo">
    <div class="login-img"></div>
    <div class="loginimg card-login-white" id="divLoginImg" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="lh40 login-label">
	                 <asp:Label ID="lbl" runat="server" Text="Login as..." meta:resourcekey="Rs_LoginAsResource1"></asp:Label>
                </div>
                <div class="w-100p displaytb">
	                <div class="w-50p displaytd">
                	    <table id="tblInputBox" runat="server" border="0" class="marginT20 marginB20 inputbox" cellpadding="3">
                            <tr>
                                <td class="logintxt hide">
                                    <asp:Label ID="lblll" runat="server" Text="Login as..." meta:resourcekey="Rs_LoginAsResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="logintxt">
                                    <asp:Label ID="lblOrg" runat="server" Text="Organization" meta:resourcekey="Rs_SelectOrganisationResource1"
                                        Width="80px"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <asp:DropDownList ID="ddlOrg" runat="server" Width="220px" CssClass="ddlstyle bdr-radius-2" meta:resourcekey="ddlOrgResource1">
                                    </asp:DropDownList>
                                </td>
                            </tr> 
                            <tr>
                                <td class="logintxt">
                                    <asp:Label ID="lblRole" runat="server" Text="Role" meta:resourcekey="Rs_SelectRoleResource1"
                                        Width="80px"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <asp:DropDownList ID="ddlRole" CssClass="ddlstyle bdr-radius-2" Width="220px" runat="server" meta:resourcekey="ddlRoleResource1">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="logintxt">
                                    <asp:Label ID="lblLocation" runat="server" Text="Location" meta:resourcekey="Rs_SelectLocationResource1"
                                        Width="80px"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <asp:DropDownList ID="ddlLocation" CssClass="ddlstyle bdr-radius-2" Width="220px" runat="server" meta:resourcekey="ddlLocationResource1">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" >
                                    <asp:UpdateProgress ID="Progressbar" runat="server">
                                        <ProgressTemplate>
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:LinkButton ID="imgGo" Text="Go" OnClick="imgGo_Click" CssClass="loginbtn marginR10"
                                        runat="server" meta:resourcekey="imgGoResource1" />
                                    <asp:LinkButton ID="imgLogout" Text="Logout" OnClick="imgLogout_Click" CssClass="loginbtn closebtn"
                                        runat="server" meta:resourcekey="imgLogoutResource1" />
                                </td>
                            </tr>
                        </table>
	                </div>
	                <div class="w-50p displaytd v-middle a-center">
	                <asp:Image runat="server" id="LoginPageLogo" class="compLogoImg" />
	                </div>
                </div>
                
                <ajc:CascadingDropDown ID="CascadeddlOrg" runat="server" TargetControlID="ddlOrg"
                    Category="Org" PromptText="------Select------" ServicePath="WebService.asmx"
                    ServiceMethod="GetOrganizations" meta:resourcekey="cascadeddlOrgResource1" />
                <ajc:CascadingDropDown ID="CascadeddlRole" runat="server" TargetControlID="ddlRole"
                    ParentControlID="ddlOrg" PromptText="------Select------" ServiceMethod="GetRolesForOrg"
                    ServicePath="WebService.asmx" Category="Role" LoadingText="[Loading Roles...]"
                    meta:resourcekey="cascadeddlRoleResource1" />
                <ajc:CascadingDropDown ID="CascadeddlLoc" runat="server" TargetControlID="ddlLocation"
                    ParentControlID="ddlRole" PromptText="------Select------" ServiceMethod="GetLocationsForOrg"
                    ServicePath="WebService.asmx" Category="Location" LoadingText="[Loading Locations...]"
                    meta:resourcekey="cascadeddlLocResource1" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
    <p>
    </p>
</body>
</html>
