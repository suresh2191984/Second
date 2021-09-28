<%@ Control Language="C#" AutoEventWireup="true" CodeFile="VaccinationHistory.ascx.cs"
    Inherits="CommonControls_VaccinationHistory" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<table cellpadding="0" width="100%">
    <tr class="defaultfontcolor" id="trVaccination" runat="server" style="display: block;">
        <td colspan="2">
            <table cellpadding="0">
                <tr>
                    <td style="width: 200px">
                        <asp:Label ID="lblVaccination_1064" runat="server" Text="Vaccination History" Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left" colspan="1">
                        <asp:RadioButton ID="rdoYes_1064" Text="Yes" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoNo_1064" Text="No" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                        <asp:RadioButton ID="rdoUnknown_1064" Text="Unknown" runat="server" GroupName="radioExtend"
                            onclick="javascript:showContentHis(this.id);" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div id="divrdoYes_1064" runat="server" style="display: none">
                <table cellpadding="0" align="right" width="100%">
                    <tr>
                        <td style="width: 12%">
                            <asp:Label ID="lblVacc" runat="server" Text="Vaccination" meta:resourcekey="lblVaccResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="drpVaccination" runat="server" CssClass="ddlTheme" meta:resourcekey="drpVaccinationResource1">
                                <asp:ListItem Value="8" meta:resourcekey="ListItemResource14">OPV</asp:ListItem>
                                <asp:ListItem Value="11" meta:resourcekey="ListItemResource15">MMR</asp:ListItem>
                                <asp:ListItem Value="2" meta:resourcekey="ListItemResource16">Hepatitis B</asp:ListItem>
                                <asp:ListItem Value="3" meta:resourcekey="ListItemResource17">Hepatitis A</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                       <%-- <<%--td style="display: none">
                            <uc8:emr id="EMR20" visible="false" runat="server" />
                        </td>--%>
                        <td>
                            <asp:Label ID="lblYear" runat="server" Text="Year" meta:resourcekey="lblYearResource1"></asp:Label>
                            &nbsp;&nbsp;
                            <asp:TextBox ID="txtYear" runat="server" CssClass="textfield1" MaxLength="4" size="5"
                                   onkeypress="return ValidateOnlyNumeric(this);"   meta:resourcekey="txtYearResource1"></asp:TextBox>
                        </td>
                        <td style="width: 7%">
                            <asp:Label ID="lblMonth" runat="server" Text="Month" meta:resourcekey="lblMonthResource1"></asp:Label>
                        </td>
                        <td style="width: 28%">
                            <asp:DropDownList ID="drpMonth" runat="server" CssClass="ddlTheme" meta:resourcekey="drpMonthResource1">
                                <asp:ListItem Text="Sel" Value="0" meta:resourcekey="ListItemResource18">---Select---</asp:ListItem>
                                <asp:ListItem Text="Jan" Value="1" meta:resourcekey="ListItemResource19">January</asp:ListItem>
                                <asp:ListItem Text="Feb" Value="2" meta:resourcekey="ListItemResource20">Febrauary</asp:ListItem>
                                <asp:ListItem Text="Mar" Value="3" meta:resourcekey="ListItemResource21">March</asp:ListItem>
                                <asp:ListItem Text="Apr" Value="4" meta:resourcekey="ListItemResource22">April</asp:ListItem>
                                <asp:ListItem Text="May" Value="5" meta:resourcekey="ListItemResource23">May</asp:ListItem>
                                <asp:ListItem Text="Jun" Value="6" meta:resourcekey="ListItemResource24">June</asp:ListItem>
                                <asp:ListItem Text="Jul" Value="7" meta:resourcekey="ListItemResource25">July</asp:ListItem>
                                <asp:ListItem Text="Aug" Value="8" meta:resourcekey="ListItemResource26">August</asp:ListItem>
                                <asp:ListItem Text="Sep" Value="9" meta:resourcekey="ListItemResource27">September</asp:ListItem>
                                <asp:ListItem Text="Oct" Value="10" meta:resourcekey="ListItemResource28">October</asp:ListItem>
                                <asp:ListItem Text="Nov" Value="11" meta:resourcekey="ListItemResource29">November</asp:ListItem>
                                <asp:ListItem Text="Dec" Value="12" meta:resourcekey="ListItemResource30">December</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblDoses" runat="server" Text="Doses" meta:resourcekey="lblDosesResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDoses" runat="server" CssClass="textfield1" MaxLength="10" size="5"
                                meta:resourcekey="txtDosesResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblReaction" runat="server" Text="Reaction" meta:resourcekey="lblReactionResource1"></asp:Label>
                            <asp:DropDownList ID="ddlAnaphylacticReaction" runat="server" meta:resourcekey="ddlAnaphylacticReactionResource1">
                            </asp:DropDownList>
                        </td>
                        <%--<td style="display: none">
                            <uc8:emr id="EMR21" visible="true" runat="server" />
                        </td>--%>
                        <td align="left" colspan="2">
                            <asp:Button ID="btnAdd" runat="server" CssClass="btn" OnClientClick="return PriorVaccinationsItems();"
                                onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'" Text="Add"
                                meta:resourcekey="btnAddResource1" />
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="HdnVaccination" runat="server" />
                <br />
                <br />
                <table id="tblPriorVaccinations" runat="server" border="2" cellspacing="0" class="dataheaderInvCtrl"
                    width="75%">
                    <tr class="colorforcontent">
                        <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;">
                        </td>
                        <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 30%;">
                           <%=Resources .ClientSideDisplayTexts.CommonControls_VaccinationHistory_Vaccination %> 
                        </td>
                        <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 10%;">
                            <%=Resources .ClientSideDisplayTexts .CommonControls_VaccinationHistory_Year%>
                        </td>
                        <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 20%;">
                           <%=Resources .ClientSideDisplayTexts .CommonControls_VaccinationHistory_Month %> 
                        </td>
                        <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;">
                           <%=Resources .ClientSideDisplayTexts .CommonControls_VaccinationHistory_Doses %>
                        </td>
                        <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 15%;">
                            <%=Resources .ClientSideDisplayTexts .CommonControls_VaccinationHistory_AnaphylacticReaction %>
                        </td>
                        <td style="font-weight: bold; font-size: 11px; height: 8px; color: White; width: 5%;
                            display: none;">
                            <%=Resources .ClientSideDisplayTexts .CommonControls_VaccinationHistory_VaccinationID %>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
    </tr>
</table>
