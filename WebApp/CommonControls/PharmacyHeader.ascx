<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PharmacyHeader.ascx.cs"
    Inherits="CommonControls_PharmacyHeader" %>
<%@ Register Src="Department.ascx" TagName="Department" TagPrefix="uc2" %>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <div class="details">
            <ul>
                <li class="details_labels">
                    <asp:Label ID="Rs_Name" runat="server" Text="Name:" meta:resourcekey="Rs_NameResource1"></asp:Label></li>
                <li class="details_valueleft">
                    <asp:Literal ID="lblName" runat="server" meta:resourcekey="lblNameResource1"></asp:Literal></li>
                <li class="details_invvalueright">
                    <div style="float: left;">
                        <div style="float: left;">
                            <div style="float: left; padding: 2px 1px 0px 3px; vertical-align: top;">
                                <table class="grdtxt">
                                    <tr>
                                        <td style="width: 65px;">
                                            <asp:Label ID="Rs_Role" runat="server" Text="Role" meta:resourcekey="Rs_RoleResource1"></asp:Label>
                                            :&nbsp;&nbsp;
                                        </td>
                                        <td valign="top">
                                            <asp:Label ID="lblRolename" Font-Bold="True" runat="server" meta:resourcekey="lblRolenameResource1"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 85px;">
                                            <asp:Label ID="Rs_Dept" runat="server" Text="Department :" meta:resourcekey="Rs_DeptResource1"></asp:Label>&nbsp;&nbsp;
                                        </td>
                                        <td valign="top">
                                            <asp:LinkButton CssClass="Department" ID="lblDepartmentName" OnClick="ShowDepartment_Click"
                                                runat="server" meta:resourcekey="lblDepartmentNameResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <input type="hidden" runat="server" id="hdnpage" >
                                <input id="hdnvalue" runat="server" type="hidden"></input>
                                </input>
                            </input>
                        </div>
                    </div>
                    <div style="float: left; padding: 6px 1px 0px 3px; vertical-align: middle;">
                        <asp:LinkButton ID="imgbtnBilling" CssClass="QuickBilling" Width="90px" runat="server" Text="Quick Billing"
                            OnClientClick="javascript:ProductsListPopup1();return false;" meta:resourcekey="imgbtnBillingResource1" />
                        <div style="display: none;">
                            <asp:Button OnClick="btngoClick_Clisk" ID="btnGoClick" Text="d" runat="server" 
                                meta:resourcekey="btnGoClickResource1" /></div>
                    </div>
                </li>
            </ul>

            <script language="javascript" type="text/javascript">
                function ProductsListPopup1() {
                    var pPage = document.getElementById('<%=hdnpage.ClientID %>').value;
                    var pPageName = document.getElementById('<%=hdnPageName.ClientID %>').value;
                    var width = 795;
                    var height = 650;
                    var left = (screen.width - width) / 2;
                    var top = (screen.height - height) / 2;
                    var params = 'width=' + width + ', height=' + height;
                    params += ', top=' + 0 + ', left=' + left;
                    params += ', directories=no';
                    params += ', location=no';
                    params += ', menubar=no';
                    params += ', resizable=no';
                    params += ', scrollbars=yes';
                    params += ', status=no';
                    params += ', toolbar=no';
                    newwin = window.open(pPage + "?IsPopup=Y", 'Billing' + pPageName, params);
                    if (window.focus) { newwin.focus() }
                    document.getElementById('<%=hdnPageName.ClientID %>').value = Number(pPageName) + 1;
                    return false;


                    // window.open( "Billing", "height=650,width=775,scrollbars=yes");
                }
                
                
                
        
       

            </script>

            <script>
                document.onkeydown = checkKeycode;
                function checkKeycode(e) {
                    var keycode;
                    if (window.event) keycode = window.event.keyCode;
                    else if (e) keycode = e.which;
                    if (window.event.ctrlKey == true) {
                        if (keycode == 113) {

                            document.getElementById('<%=hdnvalue.ClientID %>').value = "StockReport";
                            document.getElementById('<%=btnGoClick.ClientID %>').click();
                        }

                        if (keycode == 114) {
                            document.getElementById('<%=hdnvalue.ClientID %>').value = "StockIssue";
                            document.getElementById('<%=btnGoClick.ClientID %>').click();
                        }
                        if (keycode == 83) {
                            document.getElementById('<%=hdnvalue.ClientID %>').value = "QuickStockRec";
                            document.getElementById('<%=btnGoClick.ClientID %>').click();
                        }
                        if (keycode == 122) {
                            document.getElementById('<%=hdnvalue.ClientID %>').value = "Dispensing";
                            document.getElementById('<%=btnGoClick.ClientID %>').click();
                        }
                    }
                }
    
    
            </script>

        </div>
        <input type="hidden" runat="server" id="hdnPageName" value="1">
            <uc2:Department ID="Department1" runat="server" />
        </input>
    </ContentTemplate>
</asp:UpdatePanel>
