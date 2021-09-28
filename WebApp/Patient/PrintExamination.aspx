<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintExamination.aspx.cs"
    Inherits="Patient_PrintExamination" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AutoCom" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
   <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <script language="javascript" type="text/javascript">
        function popupprint() {
            var prtContent = document.getElementById('PrintPackage');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>

</head>
<body >
    <form id="form1" runat="server"><asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
         <div id="header">
            <div class="logoleft" style="z-index:2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>"  class="logostyle" />
                </div>
            </div>
                <div class="middleheader">
                <uc1:MainHeader ID="MainHeader" runat="server" />
                <uc3:PatientHeader ID="patientHeader" runat="server" />
            </div>
                    <div style="float: right;"  class="Rightheader"></div>
        </div>
            <table border="0" id="tblExam" runat="server" style="display:none;" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc4:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">  
       
                        <ul>
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                   
                    <table border="0" cellpadding="0" width="100%">
                        <tr>
                            <td align="right" valign="middle">
                                <asp:Button ID="btnEditExam" runat="server" Text="Edit" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" onclick="btnEditExam_Click" 
                                    meta:resourcekey="btnEditExamResource1" />&nbsp;&nbsp;<asp:Button 
                                    ID="btnEMRHistory" runat="server" Text="Capture History" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" onclick="btnEMRHistory_Click" 
                                    meta:resourcekey="btnEMRHistoryResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                            &nbsp;
                            </td>
                        </tr>
                    </table>
                        <div id="PrintPackage">
                            <table width="100%">
                                <tr>
                                    <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                                        align="center">
                                        <asp:Label ID="lblHVitals" runat="server" Text="Vitals" Font-Bold="True" 
                                            meta:resourcekey="lblHVitalsResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
                                <tr>
                                    <td nowrap="nowrap" style="width: 200px">
                                        <asp:Label ID="lblVitals" runat="server" Text="Vitals" Font-Bold="True" 
                                            meta:resourcekey="lblVitalsResource1"></asp:Label>
                                    </td>
                                    <td nowrap="nowrap">
                                        <asp:Label ID="lblVitalsNil" runat="server" Text="Nil" 
                                            meta:resourcekey="lblVitalsNilResource1" ></asp:Label>
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
                            <table width="100%">
                                <tr>
                                    <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                                        align="center">
                                        <asp:Label ID="lblHSkin" runat="server" Text="Skin" Font-Bold="True" 
                                            meta:resourcekey="lblHSkinResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
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
                                                                <asp:Label ID="lblSKNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblSKNilResource1"></asp:Label>
                                                                <asp:Label ID="lblSkinTypeSKAI_1" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblSkinTypeSKAI_1Resource1"></asp:Label>
                                                                <asp:Label ID="lblSkinTypeSKAVI_1" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblSkinTypeSKAVI_1Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblSkinLesionsSKAI_2" runat="server" Text="Skin Lesions :-" 
                                                                    Visible="False" meta:resourcekey="lblSkinLesionsSKAI_2Resource1"></asp:Label>
                                                                <asp:Label ID="lblSkinLesionsSKAVI_2" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblSkinLesionsSKAVI_2Resource1"></asp:Label>
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
                            <table width="100%">
                                <tr>
                                    <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                                        align="center">
                                        <asp:Label ID="lblHHair_915" runat="server" Text="Hair" 
                                            meta:resourcekey="lblHHair_915Resource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
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
                                                                <asp:Label ID="lblHRNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblHRNilResource1"></asp:Label>
                                                                <asp:Label ID="lblHairTypeHRAI_3" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblHairTypeHRAI_3Resource1"></asp:Label>
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
                            <table width="100%">
                                <tr>
                                    <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                                        align="center">
                                        <asp:Label ID="lblHNails_916" runat="server" Text="Nails" 
                                            meta:resourcekey="lblHNails_916Resource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
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
                                                                <asp:Label ID="lblNNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblNNilResource1"></asp:Label>
                                                                <asp:Label ID="lblNailsTypeNAI_4" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblNailsTypeNAI_4Resource1"></asp:Label>
                                                                <asp:Label ID="lblNailsTypeNAVI_4" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblNailsTypeNAVI_4Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblNailsDescriptionNAI_5" runat="server" Text="Description :-" 
                                                                    Visible="False" meta:resourcekey="lblNailsDescriptionNAI_5Resource1"></asp:Label>
                                                                <asp:Label ID="lblNailsDescriptionNAVI_5" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblNailsDescriptionNAVI_5Resource1"></asp:Label>
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
                            <table width="100%">
                                <tr>
                                    <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                                        align="center">
                                        <asp:Label ID="lblHScar_917" runat="server" Text="Scar" Font-Bold="True" 
                                            meta:resourcekey="lblHScar_917Resource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
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
                                                                <asp:Label ID="lblSRNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblSRNilResource1"></asp:Label>
                                                                <asp:Label ID="lblScarTypeSRAI_6" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblScarTypeSRAI_6Resource1"></asp:Label>
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
                            <table width="100%">
                                <tr>
                                    <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                                        align="center">
                                        <asp:Label ID="lblEye_871" runat="server" Text="Ear" 
                                            meta:resourcekey="lblEye_871Resource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
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
                                                                <asp:Label ID="lblACNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblACNilResource1"></asp:Label>
                                                                <asp:Label ID="lblRightEarACAI_35" runat="server" Text="Right Ear :-" 
                                                                    Visible="False" meta:resourcekey="lblRightEarACAI_35Resource1"></asp:Label>
                                                                <asp:Label ID="lblRightEarACAVI_35" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblRightEarACAVI_35Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblLeftEarACAI_36" runat="server" Text="Left Ear :-" 
                                                                    Visible="False" meta:resourcekey="lblLeftEarACAI_36Resource1"></asp:Label>
                                                                <asp:Label ID="lblLeftEarACAVI_36" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblLeftEarACAVI_36Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblEarDrum_873" runat="server" Text="Ear Drum" Font-Bold="True" 
                                                        meta:resourcekey="lblEarDrum_873Resource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblEDNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblEDNilResource1"></asp:Label>
                                                                <asp:Label ID="lblRightEarEDAI_37" runat="server" Text="Right Ear :-" 
                                                                    Visible="False" meta:resourcekey="lblRightEarEDAI_37Resource1"></asp:Label>
                                                                <asp:Label ID="lblRightEarEDAVI_37" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblRightEarEDAVI_37Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblLeftEarEDAI_38" runat="server" Text="Left Ear :-" 
                                                                    Visible="False" meta:resourcekey="lblLeftEarEDAI_38Resource1"></asp:Label>
                                                                <asp:Label ID="lblLeftEarEDAVI_38" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblLeftEarEDAVI_38Resource1"></asp:Label>
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
                            <table width="100%">
                                <tr>
                                    <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                                        align="center">
                                        <asp:Label ID="lblNeck_874" runat="server" Text="Neck" 
                                            meta:resourcekey="lblNeck_874Resource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
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
                                                                <asp:Label ID="lblTHYNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblTHYNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeTHYAI_39" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeTHYAI_39Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeTTHYAVI_39" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeTTHYAVI_39Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesTHYAI_40" runat="server" Text="Abnormalities :-" 
                                                                    Visible="False" meta:resourcekey="lblAbnormalitiesTHYAI_40Resource1"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesTHYAVI_40" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAbnormalitiesTHYAVI_40Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblLymphNodes_876" runat="server" Text="Lymph Nodes" 
                                                        Font-Bold="True" meta:resourcekey="lblLymphNodes_876Resource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblLNNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblLNNilResource1"></asp:Label>
                                                                <asp:Label ID="ddlTypeLNAI_41" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="ddlTypeLNAI_41Resource1"></asp:Label>
                                                                <asp:Label ID="ddlTypeLNAVI_41" runat="server" Visible="False" 
                                                                    meta:resourcekey="ddlTypeLNAVI_41Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblLocationLNAI_42" runat="server" Text="Location :-" 
                                                                    Visible="False" meta:resourcekey="lblLocationLNAI_42Resource1"></asp:Label>
                                                                <asp:Label ID="lblLocationLNAVI_42" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblLocationLNAVI_42Resource1"></asp:Label>
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
                            <table width="100%">
                                <tr>
                                    <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                                        align="center">
                                        <asp:Label ID="lblRespiratorySystem_877" runat="server" 
                                            Text="Respiratory System" meta:resourcekey="lblRespiratorySystem_877Resource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
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
                                                                <asp:Label ID="lblTRANil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblTRANilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeTRAAI_43" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeTRAAI_43Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeTRAAVI_43" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeTRAAVI_43Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblPostTracheostomy_156" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblPostTracheostomy_156Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblBreathSounds_879" runat="server" Text="Breath Sounds" 
                                                        Font-Bold="True" meta:resourcekey="lblBreathSounds_879Resource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblBSNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblBSNilResource1"></asp:Label>
                                                                <asp:Label ID="ddlTypeBSAI_45" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="ddlTypeBSAI_45Resource1"></asp:Label>
                                                                <asp:Label ID="ddlTypeBSAVI_45" runat="server" Visible="False" 
                                                                    meta:resourcekey="ddlTypeBSAVI_45Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesBSAI_46" runat="server" Text="Abnormalities :-" 
                                                                    Visible="False" meta:resourcekey="lblAbnormalitiesBSAI_46Resource1"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesBSAVI_46" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAbnormalitiesBSAVI_46Resource1"></asp:Label>
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
                            <table width="100%">
                                <tr>
                                    <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                                        align="center">
                                        <asp:Label ID="lblEye_918" runat="server" Text="Eye" 
                                            meta:resourcekey="lblEye_918Resource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
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
                                                    <asp:Label ID="lblDistantVision_919" runat="server" Text="Distant Vision" 
                                                        Font-Bold="True" meta:resourcekey="lblDistantVision_919Resource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblDVNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblDVNilResource1"></asp:Label>
                                                                <asp:Label ID="ddlTypeDVAI_9" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="ddlTypeDVAI_9Resource1"></asp:Label>
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
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td nowrap="nowrap" style="width: 200px">
                                                    <asp:Label ID="lblNearVision_920" runat="server" Text="Near Vision" 
                                                        Font-Bold="True" meta:resourcekey="lblNearVision_920Resource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblNVNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblNVNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeNVAI_11" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeNVAI_11Resource1"></asp:Label>
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
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td nowrap="nowrap" style="width: 200px">
                                                    <asp:Label ID="lblColorVision_921" runat="server" Text="Color Vision" 
                                                        Font-Bold="True" meta:resourcekey="lblColorVision_921Resource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblCVNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblCVNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeCVAI_13" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeCVAI_13Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeCVAVI_13" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeCVAVI_13Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDescriptionCVAI_14" runat="server" Text="Description :-" 
                                                                    Visible="False" meta:resourcekey="lblDescriptionCVAI_14Resource1"></asp:Label>
                                                                <asp:Label ID="lblDescriptionCVAVI_14" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblDescriptionCVAVI_14Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblIOLPresent_922" runat="server" Text="IOL Present" 
                                                        Font-Bold="True" meta:resourcekey="lblIOLPresent_922Resource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblIOLNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblIOLNilResource1"></asp:Label>
                                                                <asp:Label ID="lblEyesIOLAI_15" runat="server" Text="Eyes :-" Visible="False" 
                                                                    meta:resourcekey="lblEyesIOLAI_15Resource1"></asp:Label>
                                                                <asp:Label ID="lblEyesIOLAVI_15" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblEyesIOLAVI_15Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblPterygium_923" runat="server" Text="Pterygium" 
                                                        Font-Bold="True" meta:resourcekey="lblPterygium_923Resource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblPGNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblPGNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypePGAI_16" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypePGAI_16Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypePGAVI_16" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypePGAVI_16Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDescriptionPGAI_17" runat="server" Text="Description :-" 
                                                                    Visible="False" meta:resourcekey="lblDescriptionPGAI_17Resource1"></asp:Label>
                                                                <asp:Label ID="lblDescriptionPGAVI_17" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblDescriptionPGAVI_17Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblXanthelasma_924" runat="server" Text="Xanthelasma" 
                                                        Font-Bold="True" meta:resourcekey="lblXanthelasma_924Resource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblXNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblXNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeXAI_18" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeXAI_18Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeXAVI_18" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeXAVI_18Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAssociatedConditionsXAI_19" runat="server" Text="Associated Conditions :-"
                                                                    Visible="False" meta:resourcekey="lblAssociatedConditionsXAI_19Resource1"></asp:Label>
                                                                <asp:Label ID="lblAssociatedConditionsXAVI_19" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAssociatedConditionsXAVI_19Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblEyeMovements_925" runat="server" Text="Eye Movements" 
                                                        Font-Bold="True" meta:resourcekey="lblEyeMovements_925Resource1"></asp:Label>
                                                </td>
                                                <td nowrap="nowrap">
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblEMNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblEMNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeEMAI_20" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeEMAI_20Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeEMAVI_20" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeEMAVI_20Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalityEMAI_21" runat="server" Text="Abnormality :-" 
                                                                    Visible="False" meta:resourcekey="lblAbnormalityEMAI_21Resource1"></asp:Label>
                                                                <asp:Label ID="lblAbnormalityEMAVI_21" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAbnormalityEMAVI_21Resource1"></asp:Label>
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
                                                             <asp:Label ID="lblPPNil" runat="server" Text=" Nil" 
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
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
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
                                                             <asp:Label ID="lblIOPNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblIOPNilResource1"></asp:Label>
                                                                <asp:Label ID="lblIOPTAI_33" runat="server" Text="IOP" Visible="False" 
                                                                    meta:resourcekey="lblIOPTAI_33Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblRightIOPTAI_33" runat="server" Text="Right IOP :-" 
                                                                    Visible="False" meta:resourcekey="lblRightIOPTAI_33Resource1"></asp:Label>
                                                                <asp:Label ID="lblRightIOPTAVI_33" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblRightIOPTAVI_33Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblLeftIOPTAI_34" runat="server" Text="Left IOP :-" 
                                                                    Visible="False" meta:resourcekey="lblLeftIOPTAI_34Resource1"></asp:Label>
                                                                <asp:Label ID="lblLeftIOPTAVI_34" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblLeftIOPTAVI_34Resource1"></asp:Label>
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
                                    </td>
                                </tr>
                            </table>
                            <table width="100%">
                                <tr>
                                    <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                                        align="center">
                                        <asp:Label ID="lblOralCavity_894" runat="server" Text="ORAL CAVITY" 
                                            meta:resourcekey="lblOralCavity_894Resource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
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
                                                                <asp:Label ID="lblGENill" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblGENillResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeGEAI_66" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeGEAI_66Resource1"></asp:Label>
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
                                                                <asp:Label ID="lblTHNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblTHNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeTHAI_67" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeTHAI_67Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeTHAVI_67" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeTHAVI_67Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesTHAI_68" runat="server" Text="Abnormalities :-" 
                                                                    Visible="False" meta:resourcekey="lblAbnormalitiesTHAI_68Resource1"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesTHAVI_68" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAbnormalitiesTHAVI_68Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblTongue_897" runat="server" Text="Tongue " Font-Bold="True" 
                                                        meta:resourcekey="lblTongue_897Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblTGNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblTGNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeTGAI_69" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeTGAI_69Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeTGAVI_69" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeTGAVI_69Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesTGAI_70" runat="server" Text="Abnormalities :-" 
                                                                    Visible="False" meta:resourcekey="lblAbnormalitiesTGAI_70Resource1"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesTGAVI_70" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAbnormalitiesTGAVI_70Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblTonsils_898" runat="server" Text="Tonsils " Font-Bold="True" 
                                                        meta:resourcekey="lblTonsils_898Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblTSNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblTSNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeTSAI_71" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeTSAI_71Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeTSAVI_71" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeTSAVI_71Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesTSAI_72" runat="server" Text="Abnormalities :-" 
                                                                    Visible="False" meta:resourcekey="lblAbnormalitiesTSAI_72Resource1"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesTSAVI_72" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAbnormalitiesTSAVI_72Resource1"></asp:Label>
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
                                                    <asp:Label ID="Pharynx_899" runat="server" Text="Pharynx " Font-Bold="True" 
                                                        meta:resourcekey="Pharynx_899Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblPNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblPNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypePAI_73" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypePAI_73Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypePAVI_73" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypePAVI_73Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesPAI_74" runat="server" Text="Abnormalities :-" 
                                                                    Visible="False" meta:resourcekey="lblAbnormalitiesPAI_74Resource1"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesPAVI_74" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAbnormalitiesPAVI_74Resource1"></asp:Label>
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
                            <table width="100%">
                                <tr>
                                    <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                                        align="center">
                                        <asp:Label ID="lblNeurologicalExamination_900" runat="server" 
                                            Text="NEUROLOGICAL EXAMINATION" 
                                            meta:resourcekey="lblNeurologicalExamination_900Resource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
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
                                                                <asp:Label ID="lblCNNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblCNNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeCNAI_75" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeCNAI_75Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeCNAVI_75" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeCNAVI_75Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesCNAI_76" runat="server" Text="Abnormalities :-" 
                                                                    Visible="False" meta:resourcekey="lblAbnormalitiesCNAI_76Resource1"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesCNAVI_76" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAbnormalitiesCNAVI_76Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblSensorySystem_902" runat="server" Text="Sensory System " 
                                                        Font-Bold="True" meta:resourcekey="lblSensorySystem_902Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblSSNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblSSNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeSSAI_77" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeSSAI_77Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeSSAVI_77" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeSSAVI_77Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesSSAI_78" runat="server" Text="Abnormalities :-" 
                                                                    Visible="False" meta:resourcekey="lblAbnormalitiesSSAI_78Resource1"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesSSAVI_78" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAbnormalitiesSSAVI_78Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblReflexes_903" runat="server" Text="Reflexes " 
                                                        Font-Bold="True" meta:resourcekey="lblReflexes_903Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblRFNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblRFNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeRFAI_79" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeRFAI_79Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeRFAVI_79" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeRFAVI_79Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesRFAI_80" runat="server" Text="Abnormalities :-" 
                                                                    Visible="False" meta:resourcekey="lblAbnormalitiesRFAI_80Resource1"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesRFAVI_80" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAbnormalitiesRFAVI_80Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblMotorSystem_904" runat="server" Text="Motor System " 
                                                        Font-Bold="True" meta:resourcekey="lblMotorSystem_904Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblMSNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblMSNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeMSAI_81" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeMSAI_81Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeMSAVI_81" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeMSAVI_81Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesMSAI_82" runat="server" Text="Abnormalities :-" 
                                                                    Visible="False" meta:resourcekey="lblAbnormalitiesMSAI_82Resource1"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesMSAVI_82" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAbnormalitiesMSAVI_82Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblMusculoSkeletalsystem_905" runat="server" Text="Musculo Skeletal System "
                                                        Font-Bold="True" meta:resourcekey="lblMusculoSkeletalsystem_905Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblMSSNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblMSSNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeMSSAI_83" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeMSSAI_83Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeMSSAVI_83" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeMSSAVI_83Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesMSSAI_84" runat="server" Text="Abnormalities :-" 
                                                                    Visible="False" meta:resourcekey="lblAbnormalitiesMSSAI_84Resource1"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesMSSAVI_84" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAbnormalitiesMSSAVI_84Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblGait_906" runat="server" Text="Gait " Font-Bold="True" 
                                                        meta:resourcekey="lblGait_906Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblGTNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblGTNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeGTAI_85" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeGTAI_85Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeGTAVI_85" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeGTAVI_85Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesGTAI_86" runat="server" Text="Abnormalities :-" 
                                                                    Visible="False" meta:resourcekey="lblAbnormalitiesGTAI_86Resource1"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesGTAVI_86" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAbnormalitiesGTAVI_86Resource1"></asp:Label>
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
                            <table width="100%">
                                <tr>
                                    <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                                        align="center">
                                        <asp:Label ID="lblGynaecologicalExamination_907" runat="server" 
                                            Text="GYNAECOLOGICAL EXAMINATION" 
                                            meta:resourcekey="lblGynaecologicalExamination_907Resource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
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
                                                                <asp:Label ID="lblBNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblBNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeBAI_87" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeBAI_87Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeBAVI_87" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeBAVI_87Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesBAI_88" runat="server" Text="Abnormalities :-" 
                                                                    Visible="False" meta:resourcekey="lblAbnormalitiesBAI_88Resource1"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesBAVI_88" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAbnormalitiesBAVI_88Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblUterus_909" runat="server" Text="Uterus" Font-Bold="True" 
                                                        meta:resourcekey="lblUterus_909Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblUNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblUNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeUAI_89" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeUAI_89Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeUAVI_89" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeUAVI_89Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesUAI_90" runat="server" Text="Abnormalities :-" 
                                                                    Visible="False" meta:resourcekey="lblAbnormalitiesUAI_90Resource1"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesUAVI_90" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAbnormalitiesUAVI_90Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblExternalGenetaila_910" runat="server" Text="External Genetaila "
                                                        Font-Bold="True" meta:resourcekey="lblExternalGenetaila_910Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblEGNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblEGNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeEGAI_91" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeEGAI_91Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeEGAVI_91" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeEGAVI_91Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesEGAI_92" runat="server" Text="Abnormalities :-" 
                                                                    Visible="False" meta:resourcekey="lblAbnormalitiesEGAI_92Resource1"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesEGAVI_92" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAbnormalitiesEGAVI_92Resource1"></asp:Label>
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
                            <table width="100%">
                                <tr>
                                    <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                                        align="center">
                                        <asp:Label ID="lblRectalExamination_911" runat="server" 
                                            Text="RECTAL EXAMINATION" meta:resourcekey="lblRectalExamination_911Resource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
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
                                                                <asp:Label ID="lblRTMNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblRTMNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeRTMAI_93" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeRTMAI_93Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeRTMAVI_93" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeRTMAVI_93Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesRTMAI_94" runat="server" Text="Abnormalities :-" 
                                                                    Visible="False" meta:resourcekey="lblAbnormalitiesRTMAI_94Resource1"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesRTMAVI_94" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAbnormalitiesRTMAVI_94Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblProstate_913" runat="server" Text="Prostate " 
                                                        Font-Bold="True" meta:resourcekey="lblProstate_913Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblPRTNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblPRTNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypePRTAI_95" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypePRTAI_95Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypePRTAVI_95" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypePRTAVI_95Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblAbnormalitiesPRTAI_96" runat="server" Text="Abnormalities :-" 
                                                                    Visible="False" meta:resourcekey="lblAbnormalitiesPRTAI_96Resource1"></asp:Label>
                                                                <asp:Label ID="lblAbnormalitiesPRTAVI_96" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblAbnormalitiesPRTAVI_96Resource1"></asp:Label>
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
                            <table width="100%">
                                <tr>
                                    <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                                        align="center">
                                        <asp:Label ID="lblCardiovascularExamination_880" runat="server" 
                                            Text="CARDIOVASCULAR EXAMINATION" 
                                            meta:resourcekey="lblCardiovascularExamination_880Resource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
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
                                                                <asp:Label ID="lblPRTMNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblPRTMNilResource1"></asp:Label>
                                                                <asp:Label ID="lblFindingsPRTMAI_47" runat="server" Text="Findings   :-" 
                                                                    Visible="False" meta:resourcekey="lblFindingsPRTMAI_47Resource1"></asp:Label>
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
                                                                <asp:Label ID="lblPVNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblPVNilResource1"></asp:Label>
                                                                <asp:Label ID="lblFindingsPVAI_48" runat="server" Text="Findings :-" 
                                                                    Visible="False" meta:resourcekey="lblFindingsPVAI_48Resource1"></asp:Label>
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
                                                                <asp:Label ID="lblPCNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblPCNilResource1"></asp:Label>
                                                                <asp:Label ID="lblFindingsPCAI_49" runat="server" Text="Findings :-" 
                                                                    Visible="False" meta:resourcekey="lblFindingsPCAI_49Resource1"></asp:Label>
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
                                                                <asp:Label ID="lblPEPNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblPEPNilResource1"></asp:Label>
                                                                <asp:Label ID="lblFindingsSignsPEPAI_50" runat="server" Text="Findings/Signs  :-"
                                                                    Visible="False" meta:resourcekey="lblFindingsSignsPEPAI_50Resource1"></asp:Label>
                                                                <asp:Label ID="lblFindingsSignsPEPAVI_50" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblFindingsSignsPEPAVI_50Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblLocationPEPAI_51" runat="server" Text="Location  :-" 
                                                                    Visible="False" meta:resourcekey="lblLocationPEPAI_51Resource1"></asp:Label>
                                                                <asp:Label ID="lblLocationPEPAVI_51" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblLocationPEPAVI_51Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblApexBeat_885" runat="server" Text="Apex Beat " 
                                                        Font-Bold="True" meta:resourcekey="lblApexBeat_885Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblABNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblABNilResource1"></asp:Label>
                                                                <asp:Label ID="lblFindingsABAI_52" runat="server" Text="Findings  :-" 
                                                                    Visible="False" meta:resourcekey="lblFindingsABAI_52Resource1"></asp:Label>
                                                                <asp:Label ID="lblFindingsABAVI_52" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblFindingsABAVI_52Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblTypesofabnormalitiessABAI_53" runat="server" Text="Types of abnormalities  :-"
                                                                    Visible="False" 
                                                                    meta:resourcekey="lblTypesofabnormalitiessABAI_53Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypesofabnormalitiessABAVI_53" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypesofabnormalitiessABAVI_53Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblHeartSounds_886" runat="server" Text="Heart Sounds" 
                                                        Font-Bold="True" meta:resourcekey="lblHeartSounds_886Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblHSNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblHSNilResource1"></asp:Label>
                                                                <asp:Label ID="lblFindingsHSAI_54" runat="server" Text="Findings :-" 
                                                                    Visible="False" meta:resourcekey="lblFindingsHSAI_54Resource1"></asp:Label>
                                                                <asp:Label ID="lblFindingsHSAVI_54" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblFindingsHSAVI_54Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblTypesofabnormalitiessHSAI_55" runat="server" Text="Types of abnormalities  :-"
                                                                    Visible="False" 
                                                                    meta:resourcekey="lblTypesofabnormalitiessHSAI_55Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypesofabnormalitiessHSAVI_55" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypesofabnormalitiessHSAVI_55Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblHeartMummurs_887" runat="server" Text="Heart Mummurs" 
                                                        Font-Bold="True" meta:resourcekey="lblHeartMummurs_887Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblHMNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblHMNilResource1"></asp:Label>
                                                                <asp:Label ID="lblFindingsHMAI_56" runat="server" Text="Findings :-" 
                                                                    Visible="False" meta:resourcekey="lblFindingsHMAI_56Resource1"></asp:Label>
                                                                <asp:Label ID="lblFindingsHMAVI_56" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblFindingsHMAVI_56Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblTypesofabnormalitiessHMAI_57" runat="server" Text="Types of abnormalities  :-"
                                                                    Visible="False" 
                                                                    meta:resourcekey="lblTypesofabnormalitiessHMAI_57Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypesofabnormalitiessHMAVI_57" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypesofabnormalitiessHMAVI_57Resource1"></asp:Label>
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
                            <table width="100%">
                                <tr>
                                    <td nowrap="nowrap" style="font-weight: bold; height: 6px; color: #000; font-size: 12px"
                                        align="center">
                                        <asp:Label ID="lblAbdominalExamination_888" runat="server" 
                                            Text="ABDOMINAL EXAMINATION" 
                                            meta:resourcekey="lblAbdominalExamination_888Resource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="dataheaderInvCtrl">
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
                                                                <asp:Label ID="lblAINil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblAINilResource1"></asp:Label>
                                                                <asp:Label ID="lblInspectionAIAI_58" runat="server" Text="Inspection   :-" 
                                                                    Visible="False" meta:resourcekey="lblInspectionAIAI_58Resource1"></asp:Label>
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
                                                                <asp:Label ID="lblAPNil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblAPNilResource1"></asp:Label>
                                                                <asp:Label ID="lblPalpationAPAI_59" runat="server" Text="Palpation :-" 
                                                                    Visible="False" meta:resourcekey="lblPalpationAPAI_59Resource1"></asp:Label>
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
                                                                <asp:Label ID="lblLINil" runat="server" Text=" Nil" 
                                                                    meta:resourcekey="lblLINilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeLIAI_60" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeLIAI_60Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeLIAVI_60" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeLIAVI_60Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDescriptionLIAI_61" runat="server" Text="Description  :-" 
                                                                    Visible="False" meta:resourcekey="lblDescriptionLIAI_61Resource1"></asp:Label>
                                                                <asp:Label ID="lblDescriptionLIAVI_61" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblDescriptionLIAVI_61Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblSpleen_892" runat="server" Text="Spleen " Font-Bold="True" 
                                                        meta:resourcekey="lblSpleen_892Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblSPLNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblSPLNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeSPLAI_62" runat="server" Text="Type  :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeSPLAI_62Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeSPLAVI_62" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeSPLAVI_62Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDescriptionSPLAI_63" runat="server" Text="Description  :-" 
                                                                    Visible="False" meta:resourcekey="lblDescriptionSPLAI_63Resource1"></asp:Label>
                                                                <asp:Label ID="lblDescriptionSPLAVI_63" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblDescriptionSPLAVI_63Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblKidneys_893" runat="server" Text="Kidneys" Font-Bold="True" 
                                                        meta:resourcekey="lblKidneys_893Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblKDNil" runat="server" Text="Nil" 
                                                                    meta:resourcekey="lblKDNilResource1"></asp:Label>
                                                                <asp:Label ID="lblTypeKDAI_64" runat="server" Text="Type :-" Visible="False" 
                                                                    meta:resourcekey="lblTypeKDAI_64Resource1"></asp:Label>
                                                                <asp:Label ID="lblTypeKDAVI_64" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblTypeKDAVI_64Resource1"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp; &nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDescriptionKDAI_65" runat="server" Text="Description   :-" 
                                                                    Visible="False" meta:resourcekey="lblDescriptionKDAI_65Resource1"></asp:Label>
                                                                <asp:Label ID="lblDescriptionKDAVI_65" runat="server" Visible="False" 
                                                                    meta:resourcekey="lblDescriptionKDAVI_65Resource1"></asp:Label>
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
                                                    <asp:Label ID="lblOtherFindings_914" runat="server" Text="Other Findings " 
                                                        Font-Bold="True" meta:resourcekey="lblOtherFindings_914Resource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <table cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblOFNil" runat="server" Text="Nil" 
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
                        </div>
                        <table style="width: 75%;">
                            <tr>
                                <td>
                                    <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="return popupprint();" 
                                        meta:resourcekey="btnPrintResource1" />
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClick="btnEdit_Click" 
                                        meta:resourcekey="btnEditResource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
               </td>
            </tr>
        </table>
        <uc2:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
