<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PrintExam.ascx.cs" Inherits="EMR_PrintExam" %>
<%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>

<script type="text/javascript" src="../Scripts/Common.js"></script>

<table id="tblVital" runat ="server" style="display:none;" width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="lblHVitals" runat="server" Text="VITALS" Font-Bold="True"></asp:Label>
        </td>
    </tr>
</table>
<table id="tblVital1" runat ="server" style="display:none;" width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td nowrap="nowrap" style="width: 200px">
            <asp:Label ID="lblVitals" runat="server" Text="Vitals" Font-Bold="True" 
                meta:resourcekey="lblVitalsResource1"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblVitalsNil" runat="server" Text=" - " 
                meta:resourcekey="lblVitalsNilResource1"></asp:Label>
        </td>
    </tr>
    <tr id="trAdmissionVitals" runat="server" style="display: none">
        <td>
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td>
                        <asp:Table ID="tblAdmissionVitals" runat="server" CellSpacing="0" BorderWidth="1px"
                            CellPadding="8" GridLines="Both" 
                            meta:resourcekey="tblAdmissionVitalsResource1">
                        </asp:Table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table  id="tblSign" runat ="server" style="display:none;"  width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="lblHSign" runat="server" Text="General Sign Examination" Font-Bold="True"></asp:Label>
        </td>
    </tr>
</table>
<table id="tblSign1" runat ="server" style="display:none;" width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td nowrap="nowrap" style="width: 200px">
            <asp:Label ID="lblSign" runat="server" Text="General Sign" Font-Bold="True"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblSignNil" runat="server" Text=" - "></asp:Label>
            <asp:Label ID="lblSignValue" runat="server" Visible="False"></asp:Label>
        </td>
    </tr>
</table>
<table  id="tblSkin" runat ="server" style="display:none;"  width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="lblHSkin" runat="server" Text="SKIN EXAMINATION" Font-Bold="True"></asp:Label>
        </td>
    </tr>
</table>
<table id="tblSkin1" runat ="server" style="display:none;"  width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblSkin_928" runat="server" Text="Skin" Font-Bold="True" 
                            meta:resourcekey="lblSkin_928Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblSKNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblSKNilResource1"></asp:Label>
                                    <%-- <asp:Label ID="lblSkinTypeSKAI_1" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblSkinTypeSKAVI_1" runat="server" Visible="False" 
                                        meta:resourcekey="lblSkinTypeSKAVI_1Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblSkinLesionsSKAI_2" runat="server" Text="Skin Lesions :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblSkinLesionsSKAVI_2" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<table  id="tblHair" runat ="server" style="display:none;" width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="lblHHair_915" runat="server" Text="HAIR EXAMINATION"></asp:Label>
        </td>
    </tr>
</table>
<table id="tblHair1" runat ="server" style="display:none;"  width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblHair_915" runat="server" Text="Hair" Font-Bold="True" 
                            meta:resourcekey="lblHair_915Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblHRNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblHRNilResource1"></asp:Label>
                                    <%-- <asp:Label ID="lblHairTypeHRAI_3" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblHairTypeHRAVI_3" runat="server" Visible="False" 
                                        meta:resourcekey="lblHairTypeHRAVI_3Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table id="tblNail" runat ="server" style="display:none;"  width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="lblHNails_916" runat="server" Text="NAIL EXAMINATION" 
                meta:resourcekey="lblHNai_916Resource1"></asp:Label>
        </td>
    </tr>
</table>
<table id="tblNail1" runat ="server" style="display:none;"  width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblNails_916" runat="server" Text="Nails" Font-Bold="True" 
                            meta:resourcekey="lblNails_916Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblNNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblNNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblNailsTypeNAI_4" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblNailsTypeNAVI_4" runat="server" Visible="False" 
                                        meta:resourcekey="lblNailsTypeNAVI_4Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblNailsDescriptionNAI_5" runat="server" Text="Description :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblNailsDescriptionNAVI_5" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<%--<div id="divVitalsSHN" runat="server">
    <p class='pagestart'>
    </p>
</div>
<br />--%>
<table id="tblScar" runat ="server" style="display:none;"   width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="lblHScar_917" runat="server" Text="SCAR EXAMINATION" Font-Bold="True"></asp:Label>
        </td>
    </tr>
</table>
<table  id="tblScar1" runat ="server" style="display:none;"  width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblScar_917" runat="server" Text="Scar" Font-Bold="True" 
                            meta:resourcekey="lblScar_917Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblSRNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblSRNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblScarTypeSRAI_6" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblScarTypeSRAVI_6" runat="server" Visible="False" 
                                        meta:resourcekey="lblScarTypeSRAVI_6Resource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp; &nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblScaretiologySRAI_7" runat="server" Text="Scar Lesions :-" 
                                        Visible="False" meta:resourcekey="lblScaretiologySRAI_7Resource1"></asp:Label>
                                    <asp:Label ID="lblScaretiologySRAVI_7" runat="server" Visible="False" 
                                        meta:resourcekey="lblScaretiologySRAVI_7Resource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp; &nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblScarLocationSRAI_8" runat="server" Text="Scar Location :-" 
                                        Visible="False" meta:resourcekey="lblScarLocationSRAI_8Resource1"></asp:Label>
                                    <asp:Label ID="lblScarLocationSRAVI_8" runat="server" Visible="False" 
                                        meta:resourcekey="lblScarLocationSRAVI_8Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table  id="tblEye" runat ="server" style="display:none;"   width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="lblEye_918" runat="server" Text="EYE EXAMINATION"></asp:Label>
        </td>
    </tr>
</table>
<table id="tblEye1" runat ="server" style="display:none;"    width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr id="trDistantSpace" style="display:none" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trDistant" style="display:none" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblDistantVision_919" runat="server" Text="Distant Vision" 
                            Font-Bold="True" meta:resourcekey="lblDistantVision_919Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblDVNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblDVNilResource1"></asp:Label>
                                    <%--<asp:Label ID="ddlTypeDVAI_9" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="ddlTypeDVAVI_9" runat="server" Visible="False" 
                                        meta:resourcekey="ddlTypeDVAVI_9Resource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp; &nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblRightEyeDVAI_10" runat="server" Text="Right Eye :-" 
                                        Visible="False" meta:resourcekey="lblRightEyeDVAI_10Resource1"></asp:Label>
                                    <asp:Label ID="lblRightEyeDVAVI_10" runat="server" Visible="False" 
                                        meta:resourcekey="lblRightEyeDVAVI_10Resource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp; &nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblLeftEyeDVAI_97" runat="server" Text="left Eye :-" 
                                        Visible="False" meta:resourcekey="lblLeftEyeDVAI_97Resource1"></asp:Label>
                                    <asp:Label ID="lblLeftEyeDVAVI_97" runat="server" Visible="False" 
                                        meta:resourcekey="lblLeftEyeDVAVI_97Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trNearSpace" runat="server" style="display:none;">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trNear" style="display:none" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblNearVision_920" runat="server" Text="Near Vision" 
                            Font-Bold="True" meta:resourcekey="lblNearVision_920Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblNVNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblNVNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblTypeNVAI_11" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeNVAVI_11" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeNVAVI_11Resource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp; &nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblRightEyeNVAI_12" runat="server" Text="Right Eye :-" 
                                        Visible="False" meta:resourcekey="lblRightEyeNVAI_12Resource1"></asp:Label>
                                    <asp:Label ID="lblRightEyeNVAVI_12" runat="server" Visible="False" 
                                        meta:resourcekey="lblRightEyeNVAVI_12Resource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp; &nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblLeftEyeNVAI_99" runat="server" Text="left Eye :-" 
                                        Visible="False" meta:resourcekey="lblLeftEyeNVAI_99Resource1"></asp:Label>
                                    <asp:Label ID="lblLeftEyeNVAVI_99" runat="server" Visible="False" 
                                        meta:resourcekey="lblLeftEyeNVAVI_99Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trColorSpace" style="display:none" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trColor" style="display:none" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblColorVision_921" Visible ="false" runat="server" Text="Color Vision" 
                            Font-Bold="True" meta:resourcekey="lblColorVision_921Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblCVNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblCVNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblTypeCVAI_13" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeCVAVI_13" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeCVAVI_13Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDescriptionCVAI_14" runat="server" Text="Description :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblDescriptionCVAVI_14" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trIOLSpace" style="display:none" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trIOL" style="display:none" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblIOLPresent_922" runat="server" Text="IOL" Font-Bold="True" 
                            meta:resourcekey="lblIOLPresent_922Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblIOLNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblIOLNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblEyesIOLAI_15" runat="server" Text="Eyes :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblEyesIOLAVI_15" runat="server" Visible="False" 
                                        meta:resourcekey="lblEyesIOLAVI_15Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trPterySpace" style="display:none" runat="server"> 
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trPtery" style="display:none" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblPterygium_923" runat="server" Text="Pterygium" 
                            Font-Bold="True" meta:resourcekey="lblPterygium_923Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblPGNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblPGNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblTypePGAI_16" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypePGAVI_16" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypePGAVI_16Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDescriptionPGAI_17" runat="server" Text="Description :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblDescriptionPGAVI_17" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trXantheSpace" style="display:none" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trXanthe" style="display:none" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblXanthelasma_924" runat="server" Text="Xanthelasma" 
                            Font-Bold="True" meta:resourcekey="lblXanthelasma_924Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblXNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblXNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblTypeXAI_18" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeXAVI_18" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeXAVI_18Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAssociatedConditionsXAI_19" runat="server" Text="Associated Conditions :-"
                                                                    Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAssociatedConditionsXAVI_19" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trEyemoveSpace" style="display:none" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trEyemove" style="display:none" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblEyeMovements_925" runat="server" Text="Eye Movements" 
                            Font-Bold="True" meta:resourcekey="lblEyeMovements_925Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblEMNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblEMNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblTypeEMAI_20" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeEMAVI_20" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeEMAVI_20Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalityEMAI_21" runat="server" Text="Abnormality :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAbnormalityEMAVI_21" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trPupilsSpace" style="display:none" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trPupils" style="display:none" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="chkPupils_926" runat="server" Text="Pupils" Font-Bold="True" 
                            meta:resourcekey="chkPupils_926Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblSizePAI_22" runat="server" Text="Size " Visible="False" 
                                        meta:resourcekey="lblSizePAI_22Resource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp; &nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblRightEyePAI_23" runat="server" Text="Right Eye :-" 
                                        Visible="False" meta:resourcekey="lblRightEyePAI_23Resource1"></asp:Label>
                                    <asp:Label ID="lblRightEyePAVI_23" runat="server" Visible="False" 
                                        meta:resourcekey="lblRightEyePAVI_23Resource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp; &nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblLeftEyePAI_24" runat="server" Text="Left Eye  :-" 
                                        Visible="False" meta:resourcekey="lblLeftEyePAI_24Resource1"></asp:Label>
                                    <asp:Label ID="lblLeftEyePAVI_24" runat="server" Visible="False" 
                                        meta:resourcekey="lblLeftEyePAVI_24Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblPPNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblPPNilResource1"></asp:Label>
                                    <asp:Label ID="lblShapePAI_25" runat="server" Text="Shape" Visible="False" 
                                        meta:resourcekey="lblShapePAI_25Resource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp; &nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblRightEyePAI_26" runat="server" Text="Right Eye :-" 
                                        Visible="False" meta:resourcekey="lblRightEyePAI_26Resource1"></asp:Label>
                                    <asp:Label ID="lblRightEyePAVI_26" runat="server" Visible="False" 
                                        meta:resourcekey="lblRightEyePAVI_26Resource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp; &nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblLeftEyePAI_27" runat="server" Text="Left Eye :-" 
                                        Visible="False" meta:resourcekey="lblLeftEyePAI_27Resource1"></asp:Label>
                                    <asp:Label ID="lblLeftEyePAVI_27" runat="server" Visible="False" 
                                        meta:resourcekey="lblLeftEyePAVI_27Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblReactiontoLight_28" runat="server" Text="Reaction to Light" 
                                        Visible="False" meta:resourcekey="lblReactiontoLight_28Resource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp; &nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblRightEyePAI_29" runat="server" Text="Right Eye :-" 
                                        Visible="False" meta:resourcekey="lblRightEyePAI_29Resource1"></asp:Label>
                                    <asp:Label ID="lblRightEyePAVI_29" runat="server" Visible="False" 
                                        meta:resourcekey="lblRightEyePAVI_29Resource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp; &nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblLeftEyePAI_30" runat="server" Text="Left Eye :-" 
                                        Visible="False" meta:resourcekey="lblLeftEyePAI_30Resource1"></asp:Label>
                                    <asp:Label ID="lblLeftEyePAVI_30" runat="server" Visible="False" 
                                        meta:resourcekey="lblLeftEyePAVI_30Resource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblAbnormalitiesPAI_31" runat="server" Text="Abnormalities :-" 
                                        Visible="False" meta:resourcekey="lblAbnormalitiesPAI_31Resource1"></asp:Label>
                                    <asp:Label ID="lblAbnormalitiesPAVI_31" runat="server" Visible="False" 
                                        meta:resourcekey="lblAbnormalitiesPAVI_31Resource1"></asp:Label>
                                </td>
                                <td>
                                    &nbsp; &nbsp;
                                </td>
                                <td>
                                    <asp:Label ID="lblDescriptionPAI_32" runat="server" Text="Description :-" 
                                        Visible="False" meta:resourcekey="lblDescriptionPAI_32Resource1"></asp:Label>
                                    <asp:Label ID="lblDescriptionPAVI_32" runat="server" Visible="False" 
                                        meta:resourcekey="lblDescriptionPAVI_32Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trTonometrySpace" style="display:none" runat="server">
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr id="trTonometry" style="display:none" runat="server">
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblTonometry_927" runat="server" Text="Tonometry" 
                            Font-Bold="True" meta:resourcekey="lblTonometry_927Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblIOPNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblIOPNilResource1"></asp:Label>
                                    <asp:Label ID="lblIOPTAI_33" runat="server" Text="IOP" Visible="False" 
                                        meta:resourcekey="lblIOPTAI_33Resource1"></asp:Label>
                                </td>
                                <%--<td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                              <asp:Label ID="lblRightIOPTAI_33" runat="server" Text="Right IOP :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblRightIOPTAVI_33" runat="server" Visible="false"></asp:Label>
                                                            </td>
                                                           <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblLeftIOPTAI_34" runat="server" Text="Left IOP :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblLeftIOPTAVI_34" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<%--<div id="div1" runat="server">
    <p class='pagestart'>
    </p>
</div>
<br />--%>
<table id="tblEar" runat ="server" style="display:none;"   width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="lblEye_871" runat="server" Text="EAR EXAMINATION"></asp:Label>
        </td>
    </tr>
</table>
<table id="tblEar1" runat ="server" style="display:none;"   width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblAuditoryCanal_872" runat="server" Text="Auditory Canal" 
                            Font-Bold="True" meta:resourcekey="lblAuditoryCanal_872Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblACNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblACNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblRightEarACAI_35" runat="server" Text="Right Ear :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblRightEarACAVI_35" runat="server" Visible="False" 
                                        meta:resourcekey="lblRightEarACAVI_35Resource1"></asp:Label>
                                </td>
                                <%--  <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblLeftEarACAI_36" runat="server" Text="Left Ear :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblLeftEarACAVI_36" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblEarDrum_873" Visible="false" runat="server" Text="Ear Drum" Font-Bold="True" 
                            meta:resourcekey="lblEarDrum_873Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblEDNil" Visible="false" runat="server" Text=" - " 
                                        meta:resourcekey="lblEDNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblRightEarEDAI_37" runat="server" Text="Right Ear :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblRightEarEDAVI_37" runat="server" Visible="False" 
                                        meta:resourcekey="lblRightEarEDAVI_37Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblLeftEarEDAI_38" runat="server" Text="Left Ear :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblLeftEarEDAVI_38" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table  id="tblOral" runat ="server" style="display:none;"  width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="lblOralCavity_894" runat="server" Text="ORAL CAVITY EXAMINATION" 
                meta:resourcekey="lblOralCavity_894Resource1"></asp:Label>
        </td>
    </tr>
</table>
<table id="tblOral1" runat ="server" style="display:none;"   width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblGeneralAppearance_895" runat="server" Text="General Appearance"
                            Font-Bold="True" meta:resourcekey="lblGeneralAppearance_895Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblGENill" runat="server" Text=" - " 
                                        meta:resourcekey="lblGENillResource1"></asp:Label>
                                    <%--<asp:Label ID="lblTypeGEAI_66" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeGEAVI_66" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeGEAVI_66Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTeeth_896" runat="server" Text="Teeth " Font-Bold="True" 
                            meta:resourcekey="lblTeeth_896Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblTHNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblTHNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblTypeTHAI_67" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeTHAVI_67" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeTHAVI_67Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesTHAI_68" runat="server" Text="Abnormalities :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesTHAVI_68" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTongue_897" runat="server" Text="Tongue " Font-Bold="True" 
                            meta:resourcekey="lblTongue_897Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblTGNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblTGNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblTypeTGAI_69" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeTGAVI_69" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeTGAVI_69Resource1"></asp:Label>
                                </td>
                                <%--<td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesTGAI_70" runat="server" Text="Abnormalities :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesTGAVI_70" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTonsils_898" runat="server" Text="Tonsils " Font-Bold="True" 
                            meta:resourcekey="lblTonsils_898Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblTSNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblTSNilResource1"></asp:Label>
                                    <%--    <asp:Label ID="lblTypeTSAI_71" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeTSAVI_71" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeTSAVI_71Resource1"></asp:Label>
                                </td>
                                <%--<td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesTSAI_72" runat="server" Text="Abnormalities :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesTSAVI_72" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Pharynx_899" runat="server" Text="Pharynx " Font-Bold="True" 
                            meta:resourcekey="Pharynx_899Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblPNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblPNilResource1"></asp:Label>
                                    <%--      <asp:Label ID="lblTypePAI_73" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypePAVI_73" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypePAVI_73Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesPAI_74" runat="server" Text="Abnormalities :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesPAVI_74" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table id="tblNeck" runat ="server" style="display:none;"   width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="lblNeck_874" runat="server" Text="NECK EXAMINATION"></asp:Label>
        </td>
    </tr>
</table>
<table id="tblNeck1" runat ="server" style="display:none;"   width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblThyroidGland_875" runat="server" Text="Thyroid Gland" 
                            Font-Bold="True" meta:resourcekey="lblThyroidGland_875Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblTHYNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblTHYNilResource1"></asp:Label>
                                    <%-- <asp:Label ID="lblTypeTHYAI_39" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeTTHYAVI_39" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeTTHYAVI_39Resource1"></asp:Label>
                                </td>
                                <%--<td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesTHYAI_40" runat="server" Text="Abnormalities :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesTHYAVI_40" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblLymphNodes_876" runat="server" Text="Lymph Nodes" 
                            Font-Bold="True" meta:resourcekey="lblLymphNodes_876Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblLNNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblLNNilResource1"></asp:Label>
                                    <%--     <asp:Label ID="ddlTypeLNAI_41" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="ddlTypeLNAVI_41" runat="server" Visible="False" 
                                        meta:resourcekey="ddlTypeLNAVI_41Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblLocationLNAI_42" runat="server" Text="Location :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblLocationLNAVI_42" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<%--<div id="div4" runat="server">
    <p class='pagestart'>
    </p>
</div>
<br />--%>
<table id="tblCardio" runat ="server" style="display:none;"   width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="lblCardiovascularExamination_880" runat="server" 
                Text="CARDIOVASCULAR EXAMINATION" 
                meta:resourcekey="lblCardiovascularExamination_880Resource1"></asp:Label>
        </td>
    </tr>
</table>
<table id="tblCardio1" runat ="server" style="display:none;"   width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblPulseRhythm_881" runat="server" Text="Pulse Rhythm" 
                            Font-Bold="True" meta:resourcekey="lblPulseRhythm_881Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblPRTMNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblPRTMNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblFindingsPRTMAI_47" runat="server" Text="Findings   :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblFindingsPRTMAVI_47" runat="server" Visible="False" 
                                        meta:resourcekey="lblFindingsPRTMAVI_47Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblPulseVolume_882" runat="server" Text="Pulse Volume" 
                            Font-Bold="True" meta:resourcekey="lblPulseVolume_882Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblPVNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblPVNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblFindingsPVAI_48" runat="server" Text="Findings :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblFindingsPVAVI_48" runat="server" Visible="False" 
                                        meta:resourcekey="lblFindingsPVAVI_48Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblPulseCharacter_883" runat="server" Text="Pulse Character" 
                            Font-Bold="True" meta:resourcekey="lblPulseCharacter_883Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblPCNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblPCNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblFindingsPCAI_49" runat="server" Text="Findings :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblFindingsPCAVI_49" runat="server" Visible="False" 
                                        meta:resourcekey="lblFindingsPCAVI_49Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPeripheralPulses_884" runat="server" Text="Peripheral Pulses" 
                            Font-Bold="True" meta:resourcekey="lblPeripheralPulses_884Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblPEPNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblPEPNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblFindingsSignsPEPAI_50" runat="server" Text="Findings/Signs  :-"
                                                                    Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblFindingsSignsPEPAVI_50" runat="server" Visible="False" 
                                        meta:resourcekey="lblFindingsSignsPEPAVI_50Resource1"></asp:Label>
                                </td>
                                <%--  <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblLocationPEPAI_51" runat="server" Text="Location  :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblLocationPEPAVI_51" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblApexBeat_885" runat="server" Text="Apex Beat " 
                            Font-Bold="True" meta:resourcekey="lblApexBeat_885Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblABNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblABNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblFindingsABAI_52" runat="server" Text="Findings  :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblFindingsABAVI_52" runat="server" Visible="False" 
                                        meta:resourcekey="lblFindingsABAVI_52Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblTypesofabnormalitiessABAI_53" runat="server" Text="Types of abnormalities  :-"
                                                                    Visible="false"></asp:Label>
                                                                <asp:Label ID="lblTypesofabnormalitiessABAVI_53" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblHeartSounds_886" runat="server" Text="Heart Sounds" 
                            Font-Bold="True" meta:resourcekey="lblHeartSounds_886Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblHSNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblHSNilResource1"></asp:Label>
                                    <%--  <asp:Label ID="lblFindingsHSAI_54" runat="server" Text="Findings :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblFindingsHSAVI_54" runat="server" Visible="False" 
                                        meta:resourcekey="lblFindingsHSAVI_54Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblTypesofabnormalitiessHSAI_55" runat="server" Text="Types of abnormalities  :-"
                                                                    Visible="false"></asp:Label>
                                                                <asp:Label ID="lblTypesofabnormalitiessHSAVI_55" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblHeartMummurs_887" runat="server" Text="Heart Mummurs" 
                            Font-Bold="True" meta:resourcekey="lblHeartMummurs_887Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblHMNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblHMNilResource1"></asp:Label>
                                    <%--    <asp:Label ID="lblFindingsHMAI_56" runat="server" Text="Findings :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblFindingsHMAVI_56" runat="server" Visible="False" 
                                        meta:resourcekey="lblFindingsHMAVI_56Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblTypesofabnormalitiessHMAI_57" runat="server" Text="Types of abnormalities  :-"
                                                                    Visible="false"></asp:Label>
                                                                <asp:Label ID="lblTypesofabnormalitiessHMAVI_57" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table id="tblRespiratory" runat ="server" style="display:none;"   width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="lblRespiratorySystem_877" runat="server" 
                Text="RESPIRATORY SYSTEM"></asp:Label>
        </td>
    </tr>
</table>
<table id="tblRespiratory1" runat ="server" style="display:none;"    width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblTrachea" runat="server" Text="Trachea" Font-Bold="True" 
                            meta:resourcekey="lblTracheaResource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblTRANil" runat="server" Text=" - " 
                                        meta:resourcekey="lblTRANilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblTypeTRAAI_43" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeTRAAVI_43" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeTRAAVI_43Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblPostTracheostomy_156" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblBreathSounds_879" runat="server" Text="Breath Sounds" 
                            Font-Bold="True" meta:resourcekey="lblBreathSounds_879Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblBSNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblBSNilResource1"></asp:Label>
                                    <%-- <asp:Label ID="ddlTypeBSAI_45" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="ddlTypeBSAVI_45" runat="server" Visible="False" 
                                        meta:resourcekey="ddlTypeBSAVI_45Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesBSAI_46" runat="server" Text="Abnormalities :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesBSAVI_46" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table id="tblAbdominal" runat ="server" style="display:none;"    width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="lblAbdominalExamination_888" runat="server" 
                Text="ABDOMINAL EXAMINATION" 
                meta:resourcekey="lblAbdominalExamination_888Resource1"></asp:Label>
        </td>
    </tr>
</table>
<table id="tblAbdominal1" runat ="server" style="display:none;"    width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblAbdominalInspection_889" runat="server" Text="Abdominal Inspection"
                            Font-Bold="True" meta:resourcekey="lblAbdominalInspection_889Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblAINil" runat="server" Text=" - " 
                                        meta:resourcekey="lblAINilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblInspectionAIAI_58" runat="server" Text="Inspection   :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblInspectionAIAVI_58" runat="server" Visible="False" 
                                        meta:resourcekey="lblInspectionAIAVI_58Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblAbdominalPalpation_890" runat="server" Text="Abdominal Palpation"
                            Font-Bold="True" meta:resourcekey="lblAbdominalPalpation_890Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblAPNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblAPNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblPalpationAPAI_59" runat="server" Text="Palpation :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblPalpationAPAVI_59" runat="server" Visible="False" 
                                        meta:resourcekey="lblPalpationAPAVI_59Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblLiver_891" runat="server" Text="Liver" Font-Bold="True" 
                            meta:resourcekey="lblLiver_891Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblLINil" runat="server" Text=" - " 
                                        meta:resourcekey="lblLINilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblTypeLIAI_60" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeLIAVI_60" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeLIAVI_60Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDescriptionLIAI_61" runat="server" Text="Description  :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblDescriptionLIAVI_61" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblSpleen_892" runat="server" Text="Spleen " Font-Bold="True" 
                            meta:resourcekey="lblSpleen_892Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblSPLNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblSPLNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblTypeSPLAI_62" runat="server" Text="Type  :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeSPLAVI_62" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeSPLAVI_62Resource1"></asp:Label>
                                </td>
                                <%--  <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDescriptionSPLAI_63" runat="server" Text="Description  :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblDescriptionSPLAVI_63" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblKidneys_893" runat="server" Text="Kidneys" Font-Bold="True" 
                            meta:resourcekey="lblKidneys_893Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblKDNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblKDNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblTypeKDAI_64" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeKDAVI_64" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeKDAVI_64Resource1"></asp:Label>
                                </td>
                                <%--  <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDescriptionKDAI_65" runat="server" Text="Description   :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblDescriptionKDAVI_65" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblOtherFindings_914" runat="server" Text="Other Findings " 
                            Font-Bold="True" meta:resourcekey="lblOtherFindings_914Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblOFNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblOFNilResource1"></asp:Label>
                                    <asp:Label ID="lblOtherFindings_98" runat="server" Visible="False" 
                                        meta:resourcekey="lblOtherFindings_98Resource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<%--<div id="div2" runat="server">
    <p class='pagestart'>
    </p>
</div>
<br />--%>
<table id="tblGynae" runat ="server" style="display:none;"   width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:HiddenField runat="server" ID="hdnSex" />
            <asp:Label ID="lblGynaecologicalExamination_907" runat="server" 
                Text="GYNAECOLOGICAL EXAMINATION" 
                meta:resourcekey="lblGynaecologicalExamination_907Resource1"></asp:Label>
        </td>
    </tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl"
     id="tblGynae1" runat ="server" style="display:none;">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblBreasts_908" runat="server" Text="Breasts" Font-Bold="True" 
                            meta:resourcekey="lblBreasts_908Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblBNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblBNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblTypeBAI_87" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeBAVI_87" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeBAVI_87Resource1"></asp:Label>
                                </td>
                                <%--<td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesBAI_88" runat="server" Text="Abnormalities :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesBAVI_88" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblUterus_909" runat="server" Text="Uterus" Font-Bold="True" 
                            meta:resourcekey="lblUterus_909Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblUNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblUNilResource1"></asp:Label>
                                    <%-- <asp:Label ID="lblTypeUAI_89" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeUAVI_89" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeUAVI_89Resource1"></asp:Label>
                                </td>
                                <%--<td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesUAI_90" runat="server" Text="Abnormalities :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesUAVI_90" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblExternalGenetaila_910" runat="server" Text="External Genetaila "
                            Font-Bold="True" meta:resourcekey="lblExternalGenetaila_910Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblEGNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblEGNilResource1"></asp:Label>
                                    <%-- <asp:Label ID="lblTypeEGAI_91" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeEGAVI_91" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeEGAVI_91Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesEGAI_92" runat="server" Text="Abnormalities :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesEGAVI_92" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table id="tblRect" runat ="server" style="display:none;"    width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="lblRectalExamination_911" runat="server" 
                Text="RECTAL EXAMINATION" meta:resourcekey="lblRectalExamination_911Resource1"></asp:Label>
        </td>
    </tr>
</table>
<table  id="tblRect1" runat ="server" style="display:none;"   width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblRectum_912" runat="server" Text="Rectum" Font-Bold="True" 
                            meta:resourcekey="lblRectum_912Resource1"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblRTMNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblRTMNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblTypeRTMAI_93" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeRTMAVI_93" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeRTMAVI_93Resource1"></asp:Label>
                                </td>
                                <%--<td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesRTMAI_94" runat="server" Text="Abnormalities :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesRTMAVI_94" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblProstate_913" runat="server" Text="Prostate " 
                            Font-Bold="True" meta:resourcekey="lblProstate_913Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblPRTNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblPRTNilResource1"></asp:Label>
                                    <%--  <asp:Label ID="lblTypePRTAI_95" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypePRTAVI_95" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypePRTAVI_95Resource1"></asp:Label>
                                </td>
                                <%--   <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesPRTAI_96" runat="server" Text="Abnormalities :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesPRTAVI_96" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<%--Foot Examination--%>
<table  id="tblFoot" runat ="server" style="display:none;"    width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="Label1" runat="server" 
                Text="FOOT EXAMINATION"></asp:Label>
        </td>
    </tr>
</table>
<table  id="tblFoot1" runat ="server" style="display:none;"   width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="Label2" runat="server" Text="Peripheral Neuropathy" Font-Bold="True"></asp:Label>
                    </td>
                    <td nowrap="nowrap">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblPeripheralNil" runat="server" Text=" - "></asp:Label>
                                    <asp:Label ID="lblPeripheral" runat="server" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text="Pedal Oedema" 
                            Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblPedalNil" runat="server" Text=" - "></asp:Label>
                                    <asp:Label ID="lblPedal" runat="server" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label8" runat="server" Text="Foot or Toe Deformity" 
                            Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblFootorToeNil" runat="server" Text=" - "></asp:Label>
                                    <asp:Label ID="lblFootorToe" runat="server" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label11" runat="server" Text="Foot Ulcer" 
                            Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblFootUlcerNil" runat="server" Text=" - "></asp:Label>
                                    <asp:Label ID="lblFootUlcer" runat="server" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label14" runat="server" Text="Infection" 
                            Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblInfectionNil" runat="server" Text=" - "></asp:Label>
                                    <asp:Label ID="lblInfection" runat="server" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label17" runat="server" Text="Peripheral Pulses" 
                            Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblPeripheralPulsesNil" runat="server" Text=" - "></asp:Label>
                                    <asp:Label ID="lblPeripheralPulses" runat="server" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label20" runat="server" Text="Foot Risk Assessment" 
                            Font-Bold="True"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblFootRiskAssessmentNil" runat="server" Text=" - "></asp:Label>
                                    <asp:Label ID="lblFootRiskAssessment" runat="server" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<%--End Foot Examination--%>

<table  id="tblNeuro" runat ="server" style="display:none;"   width="100%">
    <tr>
        <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 14px"
            align="center">
            <asp:Label ID="lblNeurologicalExamination_900" runat="server" 
                Text="NEUROLOGICAL EXAMINATION" 
                meta:resourcekey="lblNeurologicalExamination_900Resource1"></asp:Label>
        </td>
    </tr>
</table>
<table id="tblNeuro1" runat ="server" style="display:none;"    width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0" visible="">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" style="width: 200px">
                        <asp:Label ID="lblCranialNerves_901" runat="server" Text="Cranial Nerves " 
                            Font-Bold="True" meta:resourcekey="lblCranialNerves_901Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td nowrap="nowrap">
                                    <asp:Label ID="lblCNNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblCNNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblTypeCNAI_75" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeCNAVI_75" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeCNAVI_75Resource1"></asp:Label>
                                </td>
                                <%--<td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesCNAI_76" runat="server" Text="Abnormalities :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesCNAVI_76" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblSensorySystem_902" runat="server" Text="Sensory System " 
                            Font-Bold="True" meta:resourcekey="lblSensorySystem_902Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblSSNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblSSNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblTypeSSAI_77" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeSSAVI_77" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeSSAVI_77Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesSSAI_78" runat="server" Text="Abnormalities :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesSSAVI_78" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblReflexes_903" runat="server" Text="Reflexes " 
                            Font-Bold="True" meta:resourcekey="lblReflexes_903Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblRFNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblRFNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblTypeRFAI_79" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeRFAVI_79" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeRFAVI_79Resource1"></asp:Label>
                                </td>
                                <%--<td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesRFAI_80" runat="server" Text="Abnormalities :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesRFAVI_80" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblMotorSystem_904" runat="server" Text="Motor System " 
                            Font-Bold="True" meta:resourcekey="lblMotorSystem_904Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblMSNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblMSNilResource1"></asp:Label>
                                    <%--  <asp:Label ID="lblTypeMSAI_81" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeMSAVI_81" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeMSAVI_81Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesMSAI_82" runat="server" Text="Abnormalities :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesMSAVI_82" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblMusculoSkeletalsystem_905" runat="server" Text="Musculo Skeletal System "
                            Font-Bold="True" meta:resourcekey="lblMusculoSkeletalsystem_905Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblMSSNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblMSSNilResource1"></asp:Label>
                                    <%--  <asp:Label ID="lblTypeMSSAI_83" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeMSSAVI_83" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeMSSAVI_83Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesMSSAI_84" runat="server" Text="Abnormalities :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesMSSAVI_84" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblGait_906" runat="server" Text="Gait " Font-Bold="True" 
                            meta:resourcekey="lblGait_906Resource1"></asp:Label>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblGTNil" runat="server" Text=" - " 
                                        meta:resourcekey="lblGTNilResource1"></asp:Label>
                                    <%--<asp:Label ID="lblTypeGTAI_85" runat="server" Text="Type :-" Visible="false"></asp:Label>--%>
                                    <asp:Label ID="lblTypeGTAVI_85" runat="server" Visible="False" 
                                        meta:resourcekey="lblTypeGTAVI_85Resource1"></asp:Label>
                                </td>
                                <%-- <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesGTAI_86" runat="server" Text="Abnormalities :-" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesGTAVI_86" runat="server" Visible="false"></asp:Label>
                                                            </td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<%--<div id="div3" runat="server">
    <p class='pagestart'>
    </p>
</div>--%>
<br />
