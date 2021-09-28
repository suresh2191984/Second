<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BioPattern1.ascx.cs" Inherits="Investigation_checkInvest" %>
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
    .csstxtName textarea{ height:20px!important;}
   
</style>

<table class="w-100p defaultfontcolor">
    <tr>
<td id="tdCheckbox" runat="server" class="w-5p h-5 bold font10"  style="color: #000; display: none">
   
    <input type="checkbox" id="ChkAppr" bulk="checkbox"  />
    </td>
        <td id="tdPatientDetails" runat="server" class="w-30p h-20 bold font12" style="color: #000; display: none">
            <table class="w-100p h-20" cellpadding="2" cellspacing="2">
                <tr>
                    <td class="w-45p a-left csspName">
                        <asp:Label runat="server" ID="lblPatientName" meta:resourcekey="lblPatientNameResource1"></asp:Label>
                    </td>
                    <td class="w-10p" style="display: none;">
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
        <td id="tdInvName" runat="server" style="font-weight: normal;
            color: #000; display: table-cell;" class="h-20 font11 w-11p csspName">
            <asp:Label ID="lblName" runat="server" Text="Name"
                meta:resourcekey="lblNameResource1"></asp:Label>
</br>
<asp:Label ID="lblbarcodeno" runat="server" ForeColor="Blue" ></asp:Label> 
            <asp:Label ID="lblTestStatus" runat="server" Width="15px" BackColor="Yellow" 
                meta:resourcekey="lblTestStatusResource1"></asp:Label>
            &nbsp;
            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" Visible="False" OnClick="lnkEdit_Click"
                ForeColor="Red" meta:resourcekey="lnkEditResource1" ></asp:LinkButton>
            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_BioPattern1_ascx_01 %></u></a>
        </td>
        <td class="w-14p v-middle csstxtName">
            <asp:TextBox ForeColor="Black" Font-Bold="True" ID="txtValue" TextMode="MultiLine"
               runat="server" CssClass="small" meta:resourcekey="txtValueResource1"></asp:TextBox>
        </td>
        <td class="w-7p h-20 font10 bold cssUnitName">
            <img alt="edit" id="imgEditComputation" style="cursor: pointer;" runat="server" visible="false" />
            <asp:Label ID="lblUnit" runat="server" meta:resourcekey="lblUnitResource1"></asp:Label><asp:HiddenField
                ID="hidVal" runat="server" />
        </td>
        <td style="color: #000;" class="w-5p h-20 font10 bold">
            <img alt="Device Value" id="imgDeviceValue" style="cursor: pointer;" visible="false"
                runat="server" />
        </td>
        <td style="font-weight: normal;color: #000;" class="w-8p font10">
            <table>
                <tr>
                    <td style="font-weight: normal;color: #000;" class="w-8p font10 h-10">
                        <asp:Label ID="Rs_ReferenceRange" Text="Reference Range" runat="server" meta:resourcekey="Rs_ReferenceRangeResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: normal;color: #000;" class="w-8p font10">
                        <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server"
                            TabIndex="-1" ID="txtRefRange" TextMode="MultiLine" CssClass="small"
                           meta:resourcekey="txtRefRangeResource1"></asp:TextBox>
                        <asp:HiddenField ID="hdnXmlContent" runat="server" />
                        <asp:HiddenField ID="hdnPanicXmlContent" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
        <td class="w-9p" align="center">
            <table class="tblAbnormal">
                <tr>
                    <td style="font-weight: normal;color: #000;" class="font10 h-10 a-center">
                        <asp:Label ID="lblIsAbnormal" Text="Abnormal" runat="server" 
                            meta:resourcekey="lblIsAbnormalResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: normal;color: #000;" class="font10 a-center">
                        <span id="spanIsAbnormal" style="cursor:pointer;" runat="server">
                            <asp:TextBox CssClass="w-10 h-10" ID="txtIsAbnormal" Enabled="false" 
							runat="server" Style="background:white;" TabIndex="-1"
                            meta:resourcekey="txtIsAbnormalResource1"></asp:TextBox>
                        </span>
                    </td>
                </tr>
                
            </table>
        </td>
         <td class="w-9p" align="center">
            <table class="tbldelta">
                <tr>
                    <td style="font-weight: normal;color: #000;" class="font10 h-10 a-center">
                        <asp:Label ID="Label1" Text="DeltaStatus" runat="server" 
                            meta:resourcekey="lblDeltaStatusResource1"></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td style="font-weight: normal;color: #000;" class="font10 h-10 a-center">
                        <asp:Label ID="lbldeltarange" Text="" runat="server" 
                            meta:resourcekey="lblIsdeltaResource1"></asp:Label>
                            <asp:HiddenField ID="lbldeltadetails" runat="server"/>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: normal;color: #000;" class="font10 a-center">
                        <span id="span1" style="cursor:pointer;" runat="server">
                            <%--<asp:TextBox CssClass="w-10 h-10" ID="txtdeltastatus" Enabled="false" 
							runat="server" Style="background:red;" TabIndex="-1"
                            meta:resourcekey="txtIsdeltaResource1"></asp:TextBox>--%>
                             <a id="adeltastatus"  runat="server" Font-Bold="True" style="font-size: large; background:red;" meta:resourcekey="txtIsdeltaResource1" onclick="CallShowDeltaPopUp(this.id);"><u>Δ</u></a>
                        </span>
                    </td>
                </tr>   
                
            </table>
        </td>
       <td id="QCDataId" class="w-9p" align="center" runat="server">
            <table class="tbldelta">
                <tr>
                    <td style="font-weight: normal;color: #000;" class="font10 h-10 a-center">
                        <asp:Label ID="Label2" Text="QCStatus" runat="server" 
                            meta:resourcekey="lblQCStatusResource1"></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td style="font-weight: normal;color: #000;" class="font10 h-10 a-center">
                        <asp:Label ID="Label3" Text="" runat="server" 
                            meta:resourcekey="lblIsdeltaResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: normal;color: #000;" class="font10 a-center">
                        <span id="span2" style="cursor:pointer;" runat="server">
                            <%--<asp:TextBox CssClass="w-10 h-10" ID="txtdeltastatus" Enabled="false" 
							runat="server" Style="background:red;" TabIndex="-1"
                            meta:resourcekey="txtIsdeltaResource1"></asp:TextBox>--%>
                             <%--<a id="aQcstatus"  runat="server" Font-Bold="True" style="font-size: large; background:red;" meta:resourcekey="txtqccheckResource1"><u>QC</u></a>--%>
                             <a id="aQcstatus"  runat="server">
                             <asp:Image ID="aQcstatusImg" Width="15px" Height="15px" runat="server" ImageUrl="../Images/fail.png"
                                                        meta:resourcekey="img1Resource1" />
                             </a>
                        </span>
                    </td>
                </tr>   
                
            </table>
        </td>
       
        <td id="tdQcCheck" class="w-9p" align="center" runat="server" visible="false" >
        <table class="tblQcCheck">
        <tr>
                
                <td  style="font-weight: normal;color: #000;" class="font10 h-10 a-center">
                        <asp:Label ID="lblQCValue" Text="QCValue" runat="server" 
                            meta:resourcekey="lblQCValueResource1"></asp:Label>
						<asp:Label ID="lblQcCheck" Text="QcCheck" runat="server" 
                            meta:resourcekey="lblQcCheckResource1"></asp:Label>
              <%--  </td>--%>
                <%--<td  style="font-weight: normal;color: #000;" class="font9 a-center">--%>
                <asp:CheckBox ID="ChkQcValue" runat="server" Enabled="false" />
               <%-- <asp:ImageButton ImageUrl="~/Images/Checkin.png" ID="imgQccheck" runat="server" Visible="false" />
                <asp:ImageButton ImageUrl="~/Images/Delete.jpg" ID="imgQcCheck1" runat="server" Visible="false" />--%>
                </td>
               </tr>
        </table>
        </td>
      <%--   <td id="tdPastReport" class="w-9p" align="center" runat="server" >
       <%-- <table class="tblQcCheck">
        <tr>
                <tr>
                    <td style="font-weight: normal;color: #000;" class="font10 h-10 a-center">
                        <asp:Label ID="Label4" Text="Past Report" runat="server"></asp:Label>
                    </td>
                </tr>
                <td  style="font-weight: normal;color: #000;" class="font10 h-10 a-center">
                     <span id="span3" style="cursor:pointer;" runat="server">
                            <%--<asp:TextBox CssClass="w-10 h-10" ID="txtdeltastatus" Enabled="false" 
							runat="server" Style="background:red;" TabIndex="-1"
                            meta:resourcekey="txtIsdeltaResource1"></asp:TextBox>--%>
                             <%--<a id="aQcstatus"  runat="server" Font-Bold="True" style="font-size: large; background:red;" meta:resourcekey="txtqccheckResource1"><u>QC</u></a>
                             <a id="aPastReport"  runat="server">
                             <asp:Image ID="aBioPattern1PastReport" Width="15px" Height="15px" runat="server"  onclick="CallPastReportPopUp(this.id);" ImageUrl="../Images/search_icon.gif"/>
                             </a>
                        </span>
                        <asp:Label ID="lblPastPatientID" runat="server" Style="display: none;"></asp:Label>
                </td>
               </tr>
        </table>
        </td>--%>
        <td class="w-14p">
            <table>
                <tr>
                    <td style="font-weight: normal;color: #000;" class="w-8p font10 h-10">
                        <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server" 
                            meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                    </td>
                    <td style="font-weight: normal;color: #000;" class="w-8p font10 h-10">
                        <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server" 
                            meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: normal;color: #000;" class="w-8p font10">
                        <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtReason"
                            TabIndex="-1" TextMode="MultiLine" CssClass="small"
                            meta:resourcekey="txtReasonResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                            TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                            EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                        </ajc:AutoCompleteExtender>
                        <asp:HiddenField ID="hdnRemarksID" runat="server" />
                    </td>
                    <td style="font-weight: normal;color: #000;" class="w-8p font10">
                        <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtMedRemarks"
                            TabIndex="-1" TextMode="MultiLine"
                            CssClass="small" 
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
        <td style="display:none;" class="w-14p">
            <table>
                <tr>
                    <td style="font-weight: normal;color: #000;" class="w-8p font10 h-10">
                        <asp:Label ID="lblDilution" Text="Dilution" runat="server" 
                            meta:resourcekey="lblDilutionResource1"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: normal;color: #000;" class="w-8p font10">
                        <asp:TextBox ForeColor="Black" Font-Bold="True" runat="server" ID="txtDilution" TabIndex="-1"
                             CssClass="textbox_pattern small"
                            meta:resourcekey="txtReasonResource1" Style="margin-bottom: 0px"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
        <td class="w-50p">
            <table>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td style="font-weight: normal;color: #000;" class="h-10 font10">
                        <table id="tdInvStatusReason1" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblReason" Text="Reason" runat="server" 
                                        meta:resourcekey="lblReasonResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <table id="tdInvStatusOpinion1" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblOpinionUser" runat="server" Text="User" 
                                        meta:resourcekey="lblOpinionUserResource1" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" bulkapp="ddl"
                            meta:resourcekey="ddlstatusResource1" CssClass="ddlsmall">
                            <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <table id="tdInvStatusReason2" runat="server" style="display: none;">
                            <tr>
                                <td>
                                    <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                                       onmousedown="expandDropDownList(this);" 
                                        onblur="collapseDropDownList(this);" 
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
                                            CssClass="ddlsmall"
                                        meta:resourcekey="ddlOpinionUserResource1">
                                            <asp:ListItem Text="--Select--" meta:resourcekey="OpinionUserListItemResource1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td id="tdBetaCheck" runat="server" class="a-center w-25p v-middle  ABetaTag" style="display: none;">
                        <a id="ABetaTag" runat="server" onclick="CallShowBetaPopUp(this.id);" style="display: block;
                            font-size: large; color: Red"><u>Δ</u></a>
                        <asp:Label ID="lblPVisitID" runat="server" Style="display: none;" 
                            meta:resourcekey="lblPVisitIDResource1"></asp:Label>
                        <asp:Label ID="lblPatternID" runat="server" Style="display: none;" 
                            meta:resourcekey="lblPatternIDResource1"></asp:Label>
                        <asp:Label ID="lblInvID" runat="server" Style="display: none;" 
                            meta:resourcekey="lblInvIDResource1"></asp:Label>
                        <asp:Label ID="lblOrgID" runat="server" Style="display: none;" 
                            meta:resourcekey="lblOrgIDResource1"></asp:Label>
                        <asp:Label ID="lblPatternClassName" runat="server" Style="display: none;" 
                            meta:resourcekey="lblPatternClassNameResource1"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<input id="hdnstatusreason" runat="server" type="hidden" value="" />
<input id="hdnOpinionUser" runat="server" type="hidden" value="" />
<asp:HiddenField ID="hdnResultValue" runat="server" Value="" />
<asp:HiddenField ID="hdnIsNonEditable" runat="server" Value="false" />
<asp:HiddenField ID="hdnPrintableRange" runat="server" Value="" />
<asp:HiddenField ID="hdnClientID" runat="server" Value="0" />
<asp:HiddenField ID="hdnUID" runat="server" Value="0" />
<asp:HiddenField ID="hdnLabNo" runat="server" Value="0" />
<asp:HiddenField ID="hdnGroupID" runat="server" Value="0" />
<asp:HiddenField ID="hdnGroupName" runat="server" Value="" />
<asp:HiddenField ID="hdnPackageID" runat="server" Value="0" />
<asp:HiddenField ID="hdnPackageName" runat="server" Value="0" />
<asp:HiddenField ID="hdnAutoApproveLoginID" runat="server" Value="" />
<asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
<asp:HiddenField ID="hdnIsAbnormal" runat="server" Value="" />
<asp:HiddenField ID="hdnRefAppendString" runat="server" Value="" />
<asp:HiddenField ID="hdnIsAutoValidate" runat="server" Value="" />
<asp:HiddenField ID="hdnConvFactor" runat="server" Value="" />
<asp:HiddenField ID="hdnConvDecimalPoint" runat="server" Value="" />
<asp:HiddenField ID="hdnConvUOM" runat="server" Value="" />
<asp:HiddenField ID="hdnConvReferenceRange" runat="server" Value="" />
<asp:HiddenField ID="hdnIsWaters" runat="server" Value="" />

<%--Added by jegan-start--%>
<asp:HiddenField ID="hdnAutoAuthCount" runat="server" />
<asp:HiddenField ID="hdnAutoAuthStatus" runat="server" />
<%--End--%>
<style type="text/css">
    .listMain
    {
        width: 350px !important;
    }
</style>
  <script type="text/javascript">
      $(document).ready(function() {
          var txtValueid = '<%=txtValue.ClientID %>';
          var lbldeltarangeid = '<%=lbldeltarange.ClientID %>';
          var adeltastatusid = '<%=adeltastatus.ClientID %>';
          CheckDeltaValidate(txtValueid, lbldeltarangeid, adeltastatusid);
      });
      </script>