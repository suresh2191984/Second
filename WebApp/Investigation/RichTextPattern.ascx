<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RichTextPattern.ascx.cs"
    Inherits="Investigation_RichTextPattern" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="FCKeditorV2" %>
<%--<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>--%>

<script language="javascript" type="text/javascript">
  
    function GetInvMedicalRemarks(source, eventArgs) {

        RemarksDetails = eventArgs.get_value();
        if (document.getElementById('hdnAppRemarksID') != null) {
            var arrValue = RemarksDetails.split("~");
            document.getElementById('hdnAppRemarksID').value = arrValue[1];
            document.getElementById('hdnInvRemGrpIDList').value = document.getElementById('hdnInvRemGrpIDList').value + RemarksDetails + "^";
        }
    }
    function imgEditComputation_onclick() {
    }
</script>

<table class="defaultfontcolor w-100p">
    <tr id="tdFish" runat="server">
        <td id="tdPatientDetails" runat="server" style="color: #000; display: none;" class="w-30p h-20 font12 bold">
            <table class="w-100p h-20">
                <tr>
                    <td class="w-45p a-left">
                        <asp:Label runat="server" ID="lblPatientName" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                    </td>
                    <td class="w-10p" style="display: none;">
                        <asp:Label runat="server" ID="lblPatientNumber" meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                    </td>
                    <td class="w-10p" style="display: none;">
                        <asp:Label runat="server" ID="lblPatientVisitID" meta:resourcekey="lblPatientVisitIDResource1"></asp:Label>
                    </td>
                     <td class="w-10p a-left">
                        <asp:LinkButton ID="lnkPDFReportPreviewer" runat="server" Text="" Font-Underline="true"
                            ForeColor="Blue" TabIndex="-1" meta:resourcekey="lnkPDFReportPreviewerResource1">
                        </asp:LinkButton>
                    </td>
                    <td class="w-40p">
                        <asp:Label runat="server" ID="lblAge" meta:resourcekey="lblAgeResource1"></asp:Label>
                        <span>/</span>
                        <asp:Label runat="server" ID="lblSex" meta:resourcekey="lblSexResource1"></asp:Label>
                    </td>                   
                </tr>
            </table>
        </td>
        <td id="tdInvName" runat="server" style="font-weight: normal; color: #000; display: table-cell;"
            class="w-11p h-20 font11 csspName">
            <asp:Label ID="lblName" runat="server" Text="Name" meta:resourcekey="lblNameResource1"></asp:Label>
            <asp:Label ID="lblTestStatus" runat="server" Text="" BackColor="Yellow" meta:resourcekey="lblTestStatusResource1"></asp:Label>
            &nbsp;
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
        </td>
        <td class="a-left v-middle padding0">
            <asp:Label ID="lblPVisitID" runat="server" Style="display: none;" meta:resourcekey="lblPVisitIDResource1"></asp:Label>
            <asp:Label ID="lblPatternID" runat="server" Style="display: none;" meta:resourcekey="lblPatternIDResource1"></asp:Label>
            <asp:Label ID="lblInvID" runat="server" Style="display: none;" meta:resourcekey="lblInvIDResource1"></asp:Label>
            <asp:Label ID="lblOrgID" runat="server" Style="display: none;" meta:resourcekey="lblOrgIDResource1"></asp:Label>
        </td>
        <td class="w-58p v-middle h-100">
            <%--<FCKeditorV2:FCKeditor ID="fckVal" runat="server" Width="580px" Height="202px">
            </FCKeditorV2:FCKeditor--%>
            <FCKeditorV2:CKEditorControl ID="fckVal" runat="server" Width="580px" Height="202px"
                meta:resourcekey="fckValResource1" TextMode="MultiLine"></FCKeditorV2:CKEditorControl>
            <asp:HiddenField runat="server" ID="hidVal" />
        </td>
        <td style="color: #000;" class="w-2p h-20 font10 bold">
            <img alt="edit" id="imgEditComputation" style="cursor: pointer;" runat="server" visible="false"
                onclick="return imgEditComputation_onclick()" />
            <asp:Label ID="lblUnit" runat="server" meta:resourcekey="lblUnitResource1"></asp:Label><asp:HiddenField
                ID="HiddenField1" runat="server" />
        </td>
        <td style="color: #000;" class="font10 h-20">
            <img alt="Device Value" id="imgDeviceValue" style="cursor: pointer;" visible="false"
                runat="server" />
        </td>
        <td>
         </td>
        <%--    <td id="tdRemarks" runat="server" style="font-weight: normal; font-size: 10px; height: 20px; color: #000; width: 14%;display:block;" valign="top">
     <table>
                <tr><td style="font-weight: normal; font-size: 10px; height: 10px; color: #000; width: 8%;">
                        Comments</td></tr>
                     
                           <tr><td> <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtMedRemarks"
                            TabIndex="1" TextMode="MultiLine" CssClass="Txtboxsmall" Height="40px" Width="180px"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                            TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                            EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
                        </ajc:AutoCompleteExtender>
                        <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
                            </td></tr>
                           </table>
                     </td>--%>
        <td class="v-middle w-13p">
            <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" meta:resourcekey="ddlstatusResource1"
                CssClass="ddl">
                <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
            </asp:DropDownList>
        </td>
        <td class="padding0">
            <table id="tdInvStatusReason2" runat="server" style="display: none;">
                <tr>
                    <td>
                        <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                            Width="100px" normalWidth="100px" onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);"
                            meta:resourcekey="ddlStatusReasonResource1" CssClass="ddl">
                            <asp:ListItem Text="--Select--" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                <tr>
                    <td>
                        <span class="richcombobox w-100">
                            <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                CssClass="ddl" Width="100px" meta:resourcekey="ddlOpinionUserResource1">
                                <asp:ListItem Text="--Select--" meta:resourcekey="OpinionUserListItemResource1"></asp:ListItem>
                            </asp:DropDownList>
                        </span>
                    </td>
                </tr>
            </table>
        </td>
        <td id="tdBetaCheck" runat="server" class="a-left w-8p v-middle" style="display: none;">
            <a id="ABetaTag" runat="server" onclick="CallShowBetaPopUp(this.id);" style="display: inline;
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