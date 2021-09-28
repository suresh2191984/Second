<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FishPattern1.ascx.cs"
    Inherits="Investigation_FishPattern1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<style>
    .resultCapgrid span  
    { 
        width:145px;
    }
    .csspName span{
        width:211px;
    } 
     .cssvName span, .cssvName a
     {
        display: table-cell;
        width:95px;
    }
    .cssUnitName span{
        width:75px;
    }
    .csstxtName1 textarea{ height:30px!important;}
    
</style>
<table class="defaultfontcolor w-100p">
    <tr id="tdFish" runat="server">
        <td id="tdPatientDetails" class="bold font12 h-20 w-30p" runat="server" style="color: #000;
            display: none;">
            <table class="w-100p h-20">
                <tr>
                    <td class="w-45p a-left csspName">
                        <asp:Label runat="server" ID="lblPatientName" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                    </td>
                    <td class="w-10p">
                        <asp:Label runat="server" ID="lblPatientNumber" 
                            meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                    </td>
                    <td class="w-10p" style="display: none;">
                        <asp:Label runat="server" ID="lblPatientVisitID" 
                            meta:resourcekey="lblPatientVisitIDResource1"></asp:Label>
                    </td>
                    <td class="w-10p a-left cssvName">
                        <asp:LinkButton ID="lnkPDFReportPreviewer" runat="server" Font-Underline="True"
                            ForeColor="Blue" TabIndex="-1" 
                            meta:resourcekey="lnkPDFReportPreviewerResource1"></asp:LinkButton>
                    </td>
                    <td class="w-40p">
                        <asp:Label runat="server" ID="lblAge" meta:resourcekey="lblAgeResource1"></asp:Label>
                        <span>/</span>
                        <asp:Label runat="server" ID="lblSex" meta:resourcekey="lblSexResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
        <td id="tdInvName" runat="server" class="font11 h-20 w-10p csspName" style="font-weight: normal;
            color: #000; display: table-cell;">
            <asp:Label ID="lblName" runat="server" Text="Name" 
                meta:resourcekey="lblNameResource1"></asp:Label>
				</br>
				<asp:Label ID="lblbarcodeno" runat="server" ForeColor="Blue" ></asp:Label> 
            <asp:Label ID="lblTestStatus" runat="server" BackColor="Yellow" 
                meta:resourcekey="lblTestStatusResource1"></asp:Label>
            &nbsp;
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
        </td>
        <td class="v-middle a-left">
            <asp:Label ID="lblPVisitID" runat="server" Style="display: none;" 
                meta:resourcekey="lblPVisitIDResource1"></asp:Label>
            <asp:Label ID="lblPatternID" runat="server" Style="display: none;" 
                meta:resourcekey="lblPatternIDResource1"></asp:Label>
            <asp:Label ID="lblInvID" runat="server" Style="display: none;" 
                meta:resourcekey="lblInvIDResource1"></asp:Label>
            <asp:Label ID="lblOrgID" runat="server" Style="display: none;" 
                meta:resourcekey="lblOrgIDResource1"></asp:Label>
        </td>
        <td class="w-21p v-middle csstxtName1">
            <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtValue" TextMode="MultiLine"
                runat="server" CssClass="small" Width="311px" 
                meta:resourcekey="txtValueResource1"></asp:TextBox>
            <asp:HiddenField runat="server" ID="hidVal" />
        </td>
        <td class="bold font10 h-20 w-5p" style="color: #000;">
            <img alt="edit" id="imgEditComputation" style="cursor: pointer;" runat="server" visible="false" />
            <asp:Label ID="lblUnit" runat="server" meta:resourcekey="lblUnitResource1"></asp:Label><asp:HiddenField
                ID="HiddenField1" runat="server" />
        </td>
        <td class="bold font10 h-20 w-5p" style="color: #000;">
            <img alt="Device Value" id="imgDeviceValue" style="cursor: pointer;" visible="false"
                runat="server" />
        </td>
        <td class="w-29p">
            &nbsp;
        </td>
        <td id="tdRemarks" class="font10 h-20 w-12p v-top paddingL10" runat="server" style="font-weight: normal;
            color: #000; display: table-cell;">
            <table>
                <tr>
                    <td class="font10 h-10 w-8p" style="font-weight: normal; color: #000;">
                        <%=Resources.Investigation_ClientDisplay.Investigation_FishPattern1_ascx_01 %>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtMedRemarks"
                            TabIndex="1" TextMode="MultiLine" CssClass="small"
                            meta:resourcekey="txtMedRemarksResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                            TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                            EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
                        </ajc:AutoCompleteExtender>
                        <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
        <td class="w-5p v-middle">
            <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" meta:resourcekey="ddlstatusResource1"
                CssClass="ddlsmall">
                <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
            </asp:DropDownList>
        </td>
        <td class="w-2p">
            <table id="tdInvStatusReason2" runat="server" style="display: none;">
                <tr>
                    <td>
                        <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                            onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);"
                            meta:resourcekey="ddlStatusReasonResource1" CssClass="ddlsmall">
                            <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                <tr>
                    <td>
                        <span class="richcombobox" class="w-100">
                            <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                CssClass="ddlsmall" meta:resourcekey="ddlOpinionUserResource1">
                                <asp:ListItem Text="--Select--" meta:resourcekey="OpinionUserListItemResource1"></asp:ListItem>
                            </asp:DropDownList>
                        </span>
                    </td>
                </tr>
            </table>
        </td>
        <td id="tdBetaCheck" class="a-left w-25p v-middle" runat="server" style="display: none;">
            <a id="ABetaTag" runat="server" onclick="CallShowBetaPopUp(this.id);" style="display: block;
                font-size: large; color: Red"><u>Δ</u></a>
            <asp:Label ID="Label1" runat="server" Style="display: none;" meta:resourcekey="lblPVisitIDResource1"></asp:Label>
            <asp:Label ID="Label2" runat="server" Style="display: none;" meta:resourcekey="lblPatternIDResource1"></asp:Label>
            <asp:Label ID="Label3" runat="server" Style="display: none;" meta:resourcekey="lblInvIDResource1"></asp:Label>
            <asp:Label ID="Label4" runat="server" Style="display: none;" meta:resourcekey="lblOrgIDResource1"></asp:Label>
            <asp:Label ID="lblPatternClassName" runat="server" Style="display: none;" meta:resourcekey="lblPatternClassNameResource1"></asp:Label>
        </td>
    </tr>
</table>
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnResultValue" runat="server" Value="" />
<asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
<asp:HiddenField ID="hdnUID" runat="server" Value="0" />
<asp:HiddenField ID="hdnLabNo" runat="server" Value="0" />
<asp:HiddenField ID="hdnGroupID" runat="server" Value="0" />
<asp:HiddenField ID="hdnGroupName" runat="server" Value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
<asp:HiddenField ID="hdnIsAutoValidate" runat="server" Value="" />
