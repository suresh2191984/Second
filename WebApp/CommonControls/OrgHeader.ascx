<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OrgHeader.ascx.cs" Inherits="UserControl_OrgHeader" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    .style1
    {
        width: 18%;
    }
</style>
<%--<link href="../Themes/IB/style.css" rel="stylesheet" type="text/css" />--%>
<%--<%@ Register Src="Department.ascx" TagName="Department" TagPrefix="uc2" %>
--%><link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

<script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script> 
<script src="../Scripts/KeySuppress.js" type="text/javascript"></script>

<script type="text/javascript">
    var sessionTime = <%= Session.Timeout %>;
    var timeLeft=sessionTime;
    var denom="M";
    var t;
    
    function resetSession()
    {
        timeLeft=<%= Session.Timeout %>;
        displaySessionTimeLeft();
    }
    
    function displaySessionTimeLeft() 
    {var objvar19=SListForAppDisplay.Get("CommonControls_OrgHeader_ascx_02")== null ?"Your session will expire in":SListForAppDisplay.Get("CommonControls_OrgHeader_ascx_02");
var objvar20=SListForAppDisplay.Get("CommonControls_OrgHeader_ascx_03")== null ?" minutes":SListForAppDisplay.Get("CommonControls_OrgHeader_ascx_03");
var objvar21=SListForAppDisplay.Get("CommonControls_OrgHeader_ascx_04")== null ?"Your Session Has EXPIRED":SListForAppDisplay.Get("CommonControls_OrgHeader_ascx_04");
var objvar22=SListForAppDisplay.Get("CommonControls_OrgHeader_ascx_05")== null ?" seconds":SListForAppDisplay.Get("CommonControls_OrgHeader_ascx_05");

      //alert("test");
        if(denom=="M")
        {
            document.getElementById('lblOrgHeader_DispText').innerHTML = objvar19;
            document.getElementById('lblOrgHeader_SessionTime').innerHTML = timeLeft;
            document.getElementById('lblOrgHeader_denom').innerHTML = " "+objvar20;
            timeLeft=timeLeft-1;
            if(timeLeft==0)
            {
                denom="S";
                timeLeft=59;
                t=setTimeout("displaySessionTimeLeft()",1000);
            }   
            else
            {
                t=setTimeout("displaySessionTimeLeft()",60000);
            }
            
        }
        else
        {
            document.getElementById('lblOrgHeader_DispText').innerHTML = objvar19;
            document.getElementById('lblOrgHeader_SessionTime').innerHTML = timeLeft;
            document.getElementById('lblOrgHeader_denom').innerHTML = " "+objvar22;
            timeLeft=timeLeft-1;
            if(timeLeft>=0)
            {
                t=setTimeout("displaySessionTimeLeft()",1000);
            }
            else
            {
                document.getElementById('lblOrgHeader_DispText').innerHTML = "";
                document.getElementById('lblOrgHeader_SessionTime').innerHTML = objvar21;
                document.getElementById('lblOrgHeader_denom').innerHTML = "";
                document.getElementById('divEXPIRED').style.display = "block";
                document.getElementById('divLogout').style.display = "none";
                document.getElementById('<%= btnCancel.ClientID %>').style.display = "none";

                document.getElementById('<%= lnkLogOut.ClientID %>').click();
                clearTimeout(t);
            }
        }
    }

</script>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
<div>
    <table style="width: 100%;" class="title" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td class="main_title" align=center style="width: 35%">
                <asp:Label ID="lblOrgName" runat="server" meta:resourcekey="lblOrgNameResource1"></asp:Label>
            </td>
            <td class="main_Location" align=left style="width: 25%">
                <asp:Label ID="lblLocationName" runat="server" meta:resourcekey="lblLocationNameResource1"></asp:Label>
            </td>
            <td style="width: 25%" align="left">
                <div id="divBanner" runat="server">
                    <marquee scrolldelay="250" scrollamount="5" direction="left">
                        <asp:Label ID="lblBannerText" CssClass="bannerText" runat="server"></asp:Label></marquee>
                </div>
            </td>
            <td align="right">
                <asp:Literal ID="link" runat="server" meta:resourcekey="linkResource1"></asp:Literal>
                <input type="hidden" id="hdnTheme" runat="server" />
            </td>
            <td style="width: 25%" nowrap="nowrap" align="right">
                <asp:Label ID="lblOrgHeader_DispText" runat="server" CssClass="displaytext" meta:resourcekey="lblOrgHeader_DispTextResource1" />
                <%--Your session will expire in--%>
                <asp:Label ID="lblOrgHeader_SessionTime" runat="server" CssClass="displaytext" Style="font-weight: bold"
                    meta:resourcekey="lblOrgHeader_SessionTimeResource1" />
                <asp:Label ID="lblOrgHeader_denom" runat="server" CssClass="displaytext" meta:resourcekey="lblOrgHeader_denomResource1" />
            </td> 
            <td style="width: 25%" align="center">
                        <asp:LinkButton ID="lnkRolechangeClientSide" Text="Change Role" Style="color: Red;
                            text-decoration: underline" OnClientClick="javascript:onRoleChanges(0,0,0); return false;"
                            Width="80px" runat="server" meta:resourcekey="lnkRoleChangeResource1" TabIndex="-1" />
                    </td>
            <td style="width: 25%" align="right">
                <asp:LinkButton ID="lnkLogOut" runat="server" Text="Logout" OnClientClick="javascript:if(!DisabledEffect()) return false;"
                    CssClass="logout_position" Width="90px" OnClick="lnkLogOut_Click" TabIndex="-1"
                    meta:resourcekey="lnkLogOutResource1" />
            </td>
        </tr>
    </table>
     
    
    <div id="divLogOut" style="display: none">
        <asp:Panel ID="pnlLogout" DefaultButton="btnCancel" runat="server" CssClass="modalPopup dataheaderPopup"
            meta:resourcekey="pnlLogoutResource1">
            <table width="100%">
                <tr>
                    <td style="height: 10px;">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="txtboxps">
                        <div id="divLogout">
                            <asp:Label ID="Rs_RUlogout" runat="server" Text="Are you sure you want to logout?"
                                meta:resourcekey="Rs_RUlogoutResource1"></asp:Label></div>
                        <div id="divEXPIRED" style="display: none;">
                            <asp:Label ID="Rs_EXPIRED" runat="server" Text="Your Session Has EXPIRED" meta:resourcekey="Rs_EXPIREDResource1"></asp:Label></div>
                    </td>
                </tr>
                <tr>
                    <td style="height: 25px;">
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Button ID="btnOk" runat="server" Text="OK" CssClass="btn" OnClick="btnLogOut_Click"
                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" Width="70px"
                            meta:resourcekey="btnOkResource1" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnCancel" runat="server" Width="70px" Text="Cancel" CssClass="btn"
                            onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" meta:resourcekey="btnCancelResource1" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
        </div>
        <asp:Panel ID="pnlRole" Width="500px" Height="100px" runat="server" CssClass="modalPopup dataheaderPopup"
            Style="display: none" meta:resourcekey="pnlRoleResource1">
            <br />
            <table align="center">
                <tr>
                    <td>
                        <asp:Label ID="Rs_SelectOrganisation" runat="server" Text="Select Organization "
                            meta:resourcekey="Rs_SelectOrganisationResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlOrg" runat="server" CssClass="ddlmedium" onchange="javascript:return onRoleChanges(1,1,0);"
                            AutoPostBack="true">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Rs_SelectRole" runat="server" Text="Select Role " meta:resourcekey="Rs_SelectRoleResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="ddlmedium" onchange="javascript:return onRoleChanges(1,1,1);"
                            AutoPostBack="true">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Rs_Location" runat="server" Text="Select Location " meta:resourcekey="Rs_LocationResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlLocation1" CssClass="ddlmedium" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="height: 20px;">
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                        <%--<asp:Button ID="btnRoleOK" runat="server" Text="OK" CssClass="btn" onmouseover="this.className='btn btnhov'"
                            OnClientClick="javascript:return LoginData();" onmouseout="this.className='btn'"
                            Width="70px" OnClick="btnRoleOK_Click" meta:resourcekey="btnRoleOKResource1" />--%>
                            <asp:LinkButton ID="btnRoleOK" runat="server" Text="OK" CssClass="btn" onmouseover="this.className='btn btnhov'"
                            OnClientClick="javascript:return LoginData();" onmouseout="this.className='btn'"
                            Width="70px" OnClick="btnRoleOK_Click" meta:resourcekey="btnRoleOKResource1" />
                        &nbsp;&nbsp;
                        <asp:Button ID="btnRoleCancel" runat="server" Text="Cancel" CssClass="btn" onmouseover="this.className='btn btnhov'"
                            onmouseout="this.className='btn'" Width="70px" />
                    </td>
                </tr>
            </table>
            <br />
        </asp:Panel>
        <ajc:ModalPopupExtender ID="mpeLocationAndRole" runat="server" TargetControlID="btnRoleDummy"
            PopupControlID="pnlRole" CancelControlID="btnRoleCancel" DropShadow="false" Drag="false"
            BackgroundCssClass="modalBackground" />
        <input type="button" id="btnRoleDummy" runat="server" style="display: none;" />
        <input type="hidden" runat="server" id="hdnOrg" value="" />
        <input type="hidden" runat="server" id="hdnRole" value="" />
        <input type="hidden" runat="server" id="hdnDisplayName" value="" />
        <input type="hidden" runat="server" id="hdnLocationID" value="" />
        <input type="hidden" runat="server" id="hdnLocationName" value="" />
        <input type="hidden" runat="server" id="hdnRoleName" value="" />

        <script type="text/javascript">
            function LoginData() {
                
                $('#' + '<%=hdnOrg.ClientID %>').val(document.getElementById("<%=ddlOrg.ClientID %>").value);
                $('#' + '<%=hdnRole.ClientID %>').val(document.getElementById("<%=ddlRole.ClientID %>").value);
                $('#' + '<%=hdnDisplayName.ClientID %>').val($("#<%=ddlOrg.ClientID %> :selected").text());
                $('#' + '<%=hdnLocationID.ClientID %>').val(document.getElementById("<%=ddlLocation1.ClientID %>").value);
                $('#' + '<%=hdnLocationName.ClientID %>').val($("#<%=ddlLocation1.ClientID %> :selected").text());
                $('#' + '<%=hdnRoleName.ClientID %>').val($("#<%=ddlRole.ClientID %> :selected").text());
                
            } 
        </script>

        <%--    <uc2:Department ID="Department2" runat="server" style="z-index: 1000000" />--%>
    </ContentTemplate>
</asp:UpdatePanel>

<script language="javascript">
    function DisabledEffect() {
        var objConfirm = SListForAppDisplay.Get("CommonControls_OrgHeader_aspx_01") == null ? "Are you sure you want to logout?" : SListForAppDisplay.Get("CommonControls_OrgHeader_aspx_01");
        if (confirm(objConfirm)) {
            return true;
        }
        return;
    }
    if (document.getElementById('hdnTheme') != null) {
        document.getElementById('hdnTheme').value = '';
    }

    function onRoleChanges(defaultOrgID, defaultRoleID, defaultlocationID) {
         
        var OrgID = '<%=OrgID%>';
        var RoleID = '<%=RoleID%>';
        var RoleName = '<%=RoleName%>';
        var ILocationID = '<%=ILocationID%>';
        if (defaultOrgID != 0) {
            OrgID = document.getElementById("<%=ddlOrg.ClientID %>").value;
        }
        if (defaultlocationID == 0) {
            try {
                $.ajax({
                    type: "POST",
                    url: "../OPIPBilling.asmx/GetOrgDetails",
                    data: "",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function(data) {
                        var Items = data.d;
                        var orgList = [];
                        var roleList = [];
                        var k = 0;
                        if (defaultOrgID == 0) {
                            $.each(Items, function(index, Item) {
                                var orgExist = $.grep(orgList, function(obj) {
                                    return obj.OrgID === Item.OrgID;
                                });
                                if (orgExist.length == 0) {
                                    orgList.push({
                                        OrgID: Item.OrgID,
                                        OrgDisplayName: Item.OrgDisplayName
                                    });
                                }
                            });
                            //For Sorting based on OrgDisplayName
                            orgList.sort(function(a, b) {
                                var a1 = a.OrgDisplayName, b1 = b.OrgDisplayName;
                                if (a1 == b1) return 0;
                                return a1 > b1 ? 1 : -1;
                            });
                            document.getElementById("<%=ddlOrg.ClientID %>").innerHTML = "";
                            $.each(orgList, function(index, Item) {
                                $('#<%=ddlOrg.ClientID %>').append('<option value="' + Item.OrgID + '">' + Item.OrgDisplayName + '</option>');
                            });
                        }
                        document.getElementById("<%=ddlOrg.ClientID %>").value = OrgID.toString();
                        var roleExist = $.grep(Items, function(obj) {
                            return obj.OrgID.toString() === OrgID.toString();
                        });

                        //For Sorting based on description
                        roleExist.sort(function(a, b) {
                            var a1 = a.Description, b1 = b.Description;
                            if (a1 == b1) return 0;
                            return a1 > b1 ? 1 : -1;
                        });
                        document.getElementById("<%=ddlRole.ClientID %>").innerHTML = "";
                        $.each(roleExist, function(index, Item) {
                            $('#<%=ddlRole.ClientID %>').append('<option value="' + Item.RoleID + "~" + Item.RoleName + '">' + Item.Description + '</option>');
                        });
                        if (defaultOrgID == 0)
                            document.getElementById("<%=ddlRole.ClientID %>").value = RoleID.toString() + "~" + RoleName.toString();
                        else
                            document.getElementById("<%=ddlRole.ClientID %>").selectedIndex = 0;
                        if (defaultRoleID != 0) {
                            RoleID = document.getElementById("<%=ddlRole.ClientID %>").value.split('~')[0];
                            RoleName = document.getElementById("<%=ddlRole.ClientID %>").value.split('~')[1];
                        }
                        onChangeLocation(RoleID, RoleName);
                        $find('<%=mpeLocationAndRole.ClientID %>').show();
                    },
                    failure: function(msg) {
                        ShowErrorMessage(msg);
                    }
                   
                });
            }
            catch (e) {
            }
        }
        else {

            RoleID = document.getElementById("<%=ddlRole.ClientID %>").value.split('~')[0];
            RoleName = document.getElementById("<%=ddlRole.ClientID %>").value.split('~')[1];
            onChangeLocation(RoleID, RoleName)
        }
        
        return false;
    }

    function onChangeLocation(RoleID, RoleName) {
        try {
            $.ajax({
                type: "POST",
                url: "../OPIPBilling.asmx/GetLocationDetails",
                data: "{'iOrgID': " + $('#<%=ddlOrg.ClientID %>').val() + ",'RoleID': " + RoleID + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function(data) {
                    var Itemlocation = data.d;
                    //For Sorting based on Location
                    Itemlocation.sort(function(a, b) {
                        var a1 = a.Location, b1 = b.Location;
                        if (a1 == b1) return 0;
                        return a1 > b1 ? 1 : -1;
                    });
                    document.getElementById("<%=ddlLocation1.ClientID %>").innerHTML = "";
                    $.each(Itemlocation, function(index, Item) {
                        $('#<%=ddlLocation1.ClientID %>').append('<option value="' + Item.AddressID + '">' + Item.Location + '</option>');
                    });
                    document.getElementById("<%=ddlLocation1.ClientID %>").selectedIndex = 0;
                },
                failure: function(msg) {
                    ShowErrorMessage(msg);
                }
            });
        }
        catch (e) {

        }
       

    }

        
</script>

