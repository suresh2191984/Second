<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationConsumptionDetails.aspx.cs"
    Inherits="LabConsumptionInventory_InvestigationConsumptionDetails" meta:resourcekey="PageResource1"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <script src="Scripts/Js_InvestigationConsumptionDetails.js" type="text/javascript"></script>

</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata ">
        <table class="w-100p">
            <tr class="w-100p">
                <td class="w-100p">
                    <table class="searchPanel">
                        <tr class="panelHeader">
                            <td>
                                <table class="w-40p">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblAnalyzerName" Text="Analyzer Name" runat="server" 
                                                meta:resourcekey="lblAnalyzerNameResource1" ></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlAnalyzerName" CssClass="medium" runat="server" 
                                                meta:resourcekey="ddlAnalyzerNameResource1" >
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnLoad" value="Load" Text="Load" CssClass="btn" 
                                                runat="server" OnClick="btnLoad_Click" 
                                                meta:resourcekey="btnLoadResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="w-100p">
                <td id="tdConsumptionTab" runat="server" class="w-100p hide">
                    <table class="w-100p">
                        <tr>
                            <td>
                                <asp:Label ID="lblDate" Text="Date" runat="server" 
                                    meta:resourcekey="lblDateResource1" ></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDate" runat="server" MaxLength="20" 
                                    CssClass="small dateTimePicker" meta:resourcekey="txtDateResource1"
                                    ></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label ID="lblConsumptionType" Text="Consumption Type" runat="server" 
                                    meta:resourcekey="lblConsumptionTypeResource1" ></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlConsumptionType" CssClass="medium" runat="server" 
                                    meta:resourcekey="ddlConsumptionTypeResource1" >
                                </asp:DropDownList>
                                 <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                            </td>
                            <td>
                                <asp:Label ID="lblNoOfTimes" Text="No of Times" runat="server" 
                                    meta:resourcekey="lblNoOfTimesResource1" ></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtNoOfTimes" runat="server" MaxLength="5" 
                                    onkeydown="return validatenumber(event);" meta:resourcekey="txtNoOfTimesResource1"
                                    ></asp:TextBox>
                            </td>
                            <td>
                                <asp:Button ID="btnApplyToAll" Text="Apply To All" CssClass="btn" OnClientClick="return ApplyNoOfTimes();"
                                     runat="server" meta:resourcekey="btnApplyToAllResource1" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td id="tdConsumption" runat="server" class="w-100p hide">
                    <table class="w-100p">
                        <tr>
                            <td>
                                <div class="a-right">
                                </div>
                                <asp:GridView ID="gvInvestigationDevices" runat="server" AutoGenerateColumns="False"
                                    CssClass="gridView w-100p" 
                                    meta:resourcekey="gvInvestigationDevicesResource1" >
                                    <Columns>
                                        <asp:TemplateField HeaderText="Test Name" 
                                            meta:resourcekey="TemplateFieldResource1">
                                            <HeaderTemplate>
                                                <div class="w-100p">
                                                    <div style="width: 40%; float: left">
                                                        <div style="width: 50%; float: left; padding-left: 0%;">
                                                            <asp:TextBox ID="txSearchGv" runat="server" MaxLength="20" CssClass="large" 
                                                                onkeyup="return fun_searchTable('#gvInvestigationDevices' ,'#gvInvestigationDevices_ctl01_txSearchGv');" 
                                                                meta:resourcekey="txSearchGvResource1"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div style="width: 60%; float: left">
                                                        <div style="width: 50%; float: left; padding-left: 5%">
                                                            <asp:Label ID="lblTestName" Text="Test Name" runat="server" 
                                                                meta:resourcekey="lblTestNameResource1" ></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblTestName" Text='<%# Eval("DisplayText") %>' runat="server" 
                                                    meta:resourcekey="lblTestNameResource2" ></asp:Label>
                                                <asp:HiddenField ID="hdnInvetigationID" runat="server" Value='<%# Eval("InvestigationID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="No of Times" ItemStyle-HorizontalAlign="Justify" 
                                            meta:resourcekey="TemplateFieldResource2" >
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtNoOfTimes" CssClass="xsmaller" MaxLength="5" runat="server" 
                                                    onkeydown="return validatenumber(event)" meta:resourcekey="txtNoOfTimesResource2"
                                                    ></asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Justify"></ItemStyle>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-center">
                                <asp:Button ID="btnSave" Text="Save" CssClass="btn" runat="server" OnClientClick="return ReadGvInvDevicesRowData();"
                                     OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnCancel" Text="Cancel" CssClass="btn" 
                                    runat="server" meta:resourcekey="btnCancelResource1" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnInvDevicesData" runat="server" />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
